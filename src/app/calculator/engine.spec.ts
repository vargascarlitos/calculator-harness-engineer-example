import { add, subtract, multiply, divide } from './engine';

describe('engine', () => {
  describe('add', () => {
    it('suma dos números positivos', () => {
      expect(add(2, 3)).toBe(5);
    });

    it('suma con números negativos', () => {
      expect(add(-2, -3)).toBe(-5);
      expect(add(-5, 3)).toBe(-2);
    });

    it('suma con decimales', () => {
      expect(add(0.1, 0.2)).toBeCloseTo(0.3);
    });
  });

  describe('subtract', () => {
    it('resta dos números positivos', () => {
      expect(subtract(5, 3)).toBe(2);
    });

    it('resta con números negativos', () => {
      expect(subtract(-5, -3)).toBe(-2);
      expect(subtract(-5, 3)).toBe(-8);
    });

    it('resta con decimales', () => {
      expect(subtract(0.3, 0.1)).toBeCloseTo(0.2);
    });
  });

  describe('multiply', () => {
    it('multiplica dos números positivos', () => {
      expect(multiply(4, 3)).toBe(12);
    });

    it('multiplica con números negativos', () => {
      expect(multiply(-4, 3)).toBe(-12);
      expect(multiply(-4, -3)).toBe(12);
    });

    it('multiplica con decimales', () => {
      expect(multiply(1.5, 2)).toBeCloseTo(3);
    });
  });

  describe('divide', () => {
    it('divide dos números positivos', () => {
      expect(divide(6, 3)).toBe(2);
    });

    it('divide con números negativos', () => {
      expect(divide(-6, 3)).toBe(-2);
      expect(divide(-6, -3)).toBe(2);
    });

    it('divide con decimales', () => {
      expect(divide(1, 4)).toBeCloseTo(0.25);
    });

    it('lanza Error("Division by zero") al dividir por cero', () => {
      expect(() => divide(1, 0)).toThrowError('Division by zero');
    });
  });
});
