// AdvancedListModel.qml
// Created by troyane@github
// According to http://qt-project.org/forums/viewthread/11108

import QtQuick 2.3

/* Usage:
   For sorting you need do:
       AdvancedListModel.sortColumnName="productName";
       AdvancedListModel.quick_sort();
   For reversing you need do:
       AdvancedListModel.reverse()
*/

ListModel {
    property string sortColumnName: ""

    function swap(a, b) {
        if (a < b) {
            move(a, b, 1)
            move (b-1, a, 1)
        } else if (a > b) {
            move(b, a, 1)
            move (a-1, b, 1)
        }
    }

    function reverse() {
        for (var i = 0; i < Math.floor(count/2); ++i) {
            swap(i, count-i-1)
        }
    }

    function partition(begin, end, pivot) {
        var piv = get(pivot)[sortColumnName]
        swap(pivot, end-1)
        var store = begin
        var ix
        for (ix = begin; ix < end-1; ++ix) {
            if (get(ix)[sortColumnName] < piv) {
                swap(store, ix)
                ++store
            }
        }
        swap(end-1, store)
        return store
    }

    function qsort(begin, end) {
        if (end-1 > begin) {
            var pivot = begin + Math.floor(Math.random()*(end-begin))
            pivot = partition(begin, end, pivot)
            qsort(begin, pivot)
            qsort(pivot+1, end)
        }
    }

    function quick_sort() {
        qsort(0, count)
    }
}
