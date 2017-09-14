import pool from './pool.js';

export default function max(a) {
  return Math.max(...pool, a);
}
