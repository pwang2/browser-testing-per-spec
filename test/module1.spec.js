import test from 'tape';
import max from '../src/module1.js';

test('max', t => {
  t.ok(max(56) === 56, '56 should be the biggest one');
  t.end();
});
