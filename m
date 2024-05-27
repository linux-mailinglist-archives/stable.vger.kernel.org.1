Return-Path: <stable+bounces-47263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D71E28D0D48
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA6D1F218FF
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B8F15FCFC;
	Mon, 27 May 2024 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nS3Qe8kW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529FF262BE;
	Mon, 27 May 2024 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838089; cv=none; b=Tkfw7w5cCL+mv+ZQUOwb91Yxv8G0C5VHqKOnycnsba9Sulvz7NXbHi4vAAYaCC5uLL0dzwNhMJxMxzkl9oMCpjgsBhaKbKDREtQB3JTrkAhA+VkQvF8w3rPIWBOC2xwjCdmxK3TNyts+xswObbBap64xpsT4TkseoQ1z/mKGE0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838089; c=relaxed/simple;
	bh=9Q2Olua1KxoLu6RkZtxuM/L7GjSNJLKtT1a6HF1Y7bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQzfLjKap5yS32+148EpkTXU8sTQluS0XOtIkCD3pxNDxdMCs5EGzpnwE5z5XqDIQzGAZQG6rRQ/qS5CNoPOxOOWcJlI2CkkSp1VDvrJF2m3ELgD1VVYiTyoUZAQFLouWwW1TzAM7sQA59FLZ7jMidpG/i3+/m4g2rS8jHYTUe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nS3Qe8kW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76A9C2BBFC;
	Mon, 27 May 2024 19:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716838089;
	bh=9Q2Olua1KxoLu6RkZtxuM/L7GjSNJLKtT1a6HF1Y7bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nS3Qe8kW031Xaiu3xiw31lFMzqQkpvbA6j+sy1eR4DVWnU/pg/OzWlAQOIx3c0otV
	 VibYlPwRcBf4OET3FjJWQoO5Q/whCHueNe58pjo9UsiDRHtPKK4SbIlJ5LFP7XferM
	 Vyf8rkM8ROeJdG8XjyAvG3ftWWukWzekOBP46Y+Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 260/493] pwm: Reorder symbols in core.c
Date: Mon, 27 May 2024 20:54:22 +0200
Message-ID: <20240527185638.793941914@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 62928315adfe32442b119cff42788891db89a575 ]

This moves the functions called by pwm consumers above the functions
called by pwm providers. When character device support is added later
this is hooked into the chip registration functions. As the needed
callbacks are a kind of consumer and make use of the consumer functions,
having this order is more natural and prevents having to add
declarations for static functions.

Also move the global variables for pwm tables to the respective
functions to have them properly grouped.

Link: https://lore.kernel.org/r/eed83de07bdfb69b5ceba0b9aed757ee612dea8f.1706182805.git.u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Stable-dep-of: 3e551115aee0 ("pwm: meson: Add check for error from clk_round_rate()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/core.c | 825 +++++++++++++++++++++++----------------------
 1 file changed, 413 insertions(+), 412 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index b025d90e201c9..1b4c3d0caa824 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -24,256 +24,358 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/pwm.h>
 
-static DEFINE_MUTEX(pwm_lookup_lock);
-static LIST_HEAD(pwm_lookup_list);
-
 /* protects access to pwm_chips */
 static DEFINE_MUTEX(pwm_lock);
 
 static DEFINE_IDR(pwm_chips);
 
-static struct pwm_chip *pwmchip_find_by_name(const char *name)
+static void pwm_apply_debug(struct pwm_device *pwm,
+			    const struct pwm_state *state)
 {
-	struct pwm_chip *chip;
-	unsigned long id, tmp;
-
-	if (!name)
-		return NULL;
-
-	mutex_lock(&pwm_lock);
+	struct pwm_state *last = &pwm->last;
+	struct pwm_chip *chip = pwm->chip;
+	struct pwm_state s1 = { 0 }, s2 = { 0 };
+	int err;
 
-	idr_for_each_entry_ul(&pwm_chips, chip, tmp, id) {
-		const char *chip_name = dev_name(chip->dev);
+	if (!IS_ENABLED(CONFIG_PWM_DEBUG))
+		return;
 
-		if (chip_name && strcmp(chip_name, name) == 0) {
-			mutex_unlock(&pwm_lock);
-			return chip;
-		}
-	}
+	/* No reasonable diagnosis possible without .get_state() */
+	if (!chip->ops->get_state)
+		return;
 
-	mutex_unlock(&pwm_lock);
+	/*
+	 * *state was just applied. Read out the hardware state and do some
+	 * checks.
+	 */
 
-	return NULL;
-}
+	err = chip->ops->get_state(chip, pwm, &s1);
+	trace_pwm_get(pwm, &s1, err);
+	if (err)
+		/* If that failed there isn't much to debug */
+		return;
 
-static int pwm_device_request(struct pwm_device *pwm, const char *label)
-{
-	int err;
-	struct pwm_chip *chip = pwm->chip;
-	const struct pwm_ops *ops = chip->ops;
+	/*
+	 * The lowlevel driver either ignored .polarity (which is a bug) or as
+	 * best effort inverted .polarity and fixed .duty_cycle respectively.
+	 * Undo this inversion and fixup for further tests.
+	 */
+	if (s1.enabled && s1.polarity != state->polarity) {
+		s2.polarity = state->polarity;
+		s2.duty_cycle = s1.period - s1.duty_cycle;
+		s2.period = s1.period;
+		s2.enabled = s1.enabled;
+	} else {
+		s2 = s1;
+	}
 
-	if (test_bit(PWMF_REQUESTED, &pwm->flags))
-		return -EBUSY;
+	if (s2.polarity != state->polarity &&
+	    state->duty_cycle < state->period)
+		dev_warn(chip->dev, ".apply ignored .polarity\n");
 
-	if (!try_module_get(chip->owner))
-		return -ENODEV;
+	if (state->enabled &&
+	    last->polarity == state->polarity &&
+	    last->period > s2.period &&
+	    last->period <= state->period)
+		dev_warn(chip->dev,
+			 ".apply didn't pick the best available period (requested: %llu, applied: %llu, possible: %llu)\n",
+			 state->period, s2.period, last->period);
 
-	if (ops->request) {
-		err = ops->request(chip, pwm);
-		if (err) {
-			module_put(chip->owner);
-			return err;
-		}
-	}
+	if (state->enabled && state->period < s2.period)
+		dev_warn(chip->dev,
+			 ".apply is supposed to round down period (requested: %llu, applied: %llu)\n",
+			 state->period, s2.period);
 
-	if (ops->get_state) {
-		/*
-		 * Zero-initialize state because most drivers are unaware of
-		 * .usage_power. The other members of state are supposed to be
-		 * set by lowlevel drivers. We still initialize the whole
-		 * structure for simplicity even though this might paper over
-		 * faulty implementations of .get_state().
-		 */
-		struct pwm_state state = { 0, };
+	if (state->enabled &&
+	    last->polarity == state->polarity &&
+	    last->period == s2.period &&
+	    last->duty_cycle > s2.duty_cycle &&
+	    last->duty_cycle <= state->duty_cycle)
+		dev_warn(chip->dev,
+			 ".apply didn't pick the best available duty cycle (requested: %llu/%llu, applied: %llu/%llu, possible: %llu/%llu)\n",
+			 state->duty_cycle, state->period,
+			 s2.duty_cycle, s2.period,
+			 last->duty_cycle, last->period);
 
-		err = ops->get_state(chip, pwm, &state);
-		trace_pwm_get(pwm, &state, err);
+	if (state->enabled && state->duty_cycle < s2.duty_cycle)
+		dev_warn(chip->dev,
+			 ".apply is supposed to round down duty_cycle (requested: %llu/%llu, applied: %llu/%llu)\n",
+			 state->duty_cycle, state->period,
+			 s2.duty_cycle, s2.period);
 
-		if (!err)
-			pwm->state = state;
+	if (!state->enabled && s2.enabled && s2.duty_cycle > 0)
+		dev_warn(chip->dev,
+			 "requested disabled, but yielded enabled with duty > 0\n");
 
-		if (IS_ENABLED(CONFIG_PWM_DEBUG))
-			pwm->last = pwm->state;
+	/* reapply the state that the driver reported being configured. */
+	err = chip->ops->apply(chip, pwm, &s1);
+	trace_pwm_apply(pwm, &s1, err);
+	if (err) {
+		*last = s1;
+		dev_err(chip->dev, "failed to reapply current setting\n");
+		return;
 	}
 
-	set_bit(PWMF_REQUESTED, &pwm->flags);
-	pwm->label = label;
+	*last = (struct pwm_state){ 0 };
+	err = chip->ops->get_state(chip, pwm, last);
+	trace_pwm_get(pwm, last, err);
+	if (err)
+		return;
 
-	return 0;
+	/* reapplication of the current state should give an exact match */
+	if (s1.enabled != last->enabled ||
+	    s1.polarity != last->polarity ||
+	    (s1.enabled && s1.period != last->period) ||
+	    (s1.enabled && s1.duty_cycle != last->duty_cycle)) {
+		dev_err(chip->dev,
+			".apply is not idempotent (ena=%d pol=%d %llu/%llu) -> (ena=%d pol=%d %llu/%llu)\n",
+			s1.enabled, s1.polarity, s1.duty_cycle, s1.period,
+			last->enabled, last->polarity, last->duty_cycle,
+			last->period);
+	}
 }
 
-struct pwm_device *
-of_pwm_xlate_with_flags(struct pwm_chip *chip, const struct of_phandle_args *args)
+/**
+ * __pwm_apply() - atomically apply a new state to a PWM device
+ * @pwm: PWM device
+ * @state: new state to apply
+ */
+static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
 {
-	struct pwm_device *pwm;
+	struct pwm_chip *chip;
+	int err;
 
-	/* period in the second cell and flags in the third cell are optional */
-	if (args->args_count < 1)
-		return ERR_PTR(-EINVAL);
+	if (!pwm || !state || !state->period ||
+	    state->duty_cycle > state->period)
+		return -EINVAL;
 
-	pwm = pwm_request_from_chip(chip, args->args[0], NULL);
-	if (IS_ERR(pwm))
-		return pwm;
+	chip = pwm->chip;
 
-	if (args->args_count > 1)
-		pwm->args.period = args->args[1];
+	if (state->period == pwm->state.period &&
+	    state->duty_cycle == pwm->state.duty_cycle &&
+	    state->polarity == pwm->state.polarity &&
+	    state->enabled == pwm->state.enabled &&
+	    state->usage_power == pwm->state.usage_power)
+		return 0;
 
-	pwm->args.polarity = PWM_POLARITY_NORMAL;
-	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
-		pwm->args.polarity = PWM_POLARITY_INVERSED;
+	err = chip->ops->apply(chip, pwm, state);
+	trace_pwm_apply(pwm, state, err);
+	if (err)
+		return err;
 
-	return pwm;
+	pwm->state = *state;
+
+	/*
+	 * only do this after pwm->state was applied as some
+	 * implementations of .get_state depend on this
+	 */
+	pwm_apply_debug(pwm, state);
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
 
-struct pwm_device *
-of_pwm_single_xlate(struct pwm_chip *chip, const struct of_phandle_args *args)
+/**
+ * pwm_apply_might_sleep() - atomically apply a new state to a PWM device
+ * Cannot be used in atomic context.
+ * @pwm: PWM device
+ * @state: new state to apply
+ */
+int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
 {
-	struct pwm_device *pwm;
-
-	pwm = pwm_request_from_chip(chip, 0, NULL);
-	if (IS_ERR(pwm))
-		return pwm;
+	int err;
 
-	if (args->args_count > 1)
-		pwm->args.period = args->args[0];
+	/*
+	 * Some lowlevel driver's implementations of .apply() make use of
+	 * mutexes, also with some drivers only returning when the new
+	 * configuration is active calling pwm_apply_might_sleep() from atomic context
+	 * is a bad idea. So make it explicit that calling this function might
+	 * sleep.
+	 */
+	might_sleep();
 
-	pwm->args.polarity = PWM_POLARITY_NORMAL;
-	if (args->args_count > 1 && args->args[1] & PWM_POLARITY_INVERTED)
-		pwm->args.polarity = PWM_POLARITY_INVERSED;
+	if (IS_ENABLED(CONFIG_PWM_DEBUG) && pwm->chip->atomic) {
+		/*
+		 * Catch any drivers that have been marked as atomic but
+		 * that will sleep anyway.
+		 */
+		non_block_start();
+		err = __pwm_apply(pwm, state);
+		non_block_end();
+	} else {
+		err = __pwm_apply(pwm, state);
+	}
 
-	return pwm;
+	return err;
 }
-EXPORT_SYMBOL_GPL(of_pwm_single_xlate);
+EXPORT_SYMBOL_GPL(pwm_apply_might_sleep);
 
-static void of_pwmchip_add(struct pwm_chip *chip)
+/**
+ * pwm_apply_atomic() - apply a new state to a PWM device from atomic context
+ * Not all PWM devices support this function, check with pwm_might_sleep().
+ * @pwm: PWM device
+ * @state: new state to apply
+ */
+int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state)
 {
-	if (!chip->dev || !chip->dev->of_node)
-		return;
-
-	if (!chip->of_xlate)
-		chip->of_xlate = of_pwm_xlate_with_flags;
+	WARN_ONCE(!pwm->chip->atomic,
+		  "sleeping PWM driver used in atomic context\n");
 
-	of_node_get(chip->dev->of_node);
+	return __pwm_apply(pwm, state);
 }
+EXPORT_SYMBOL_GPL(pwm_apply_atomic);
 
-static void of_pwmchip_remove(struct pwm_chip *chip)
+/**
+ * pwm_adjust_config() - adjust the current PWM config to the PWM arguments
+ * @pwm: PWM device
+ *
+ * This function will adjust the PWM config to the PWM arguments provided
+ * by the DT or PWM lookup table. This is particularly useful to adapt
+ * the bootloader config to the Linux one.
+ */
+int pwm_adjust_config(struct pwm_device *pwm)
 {
-	if (chip->dev)
-		of_node_put(chip->dev->of_node);
-}
+	struct pwm_state state;
+	struct pwm_args pargs;
 
-static bool pwm_ops_check(const struct pwm_chip *chip)
-{
-	const struct pwm_ops *ops = chip->ops;
+	pwm_get_args(pwm, &pargs);
+	pwm_get_state(pwm, &state);
 
-	if (!ops->apply)
-		return false;
+	/*
+	 * If the current period is zero it means that either the PWM driver
+	 * does not support initial state retrieval or the PWM has not yet
+	 * been configured.
+	 *
+	 * In either case, we setup the new period and polarity, and assign a
+	 * duty cycle of 0.
+	 */
+	if (!state.period) {
+		state.duty_cycle = 0;
+		state.period = pargs.period;
+		state.polarity = pargs.polarity;
 
-	if (IS_ENABLED(CONFIG_PWM_DEBUG) && !ops->get_state)
-		dev_warn(chip->dev,
-			 "Please implement the .get_state() callback\n");
+		return pwm_apply_might_sleep(pwm, &state);
+	}
 
-	return true;
+	/*
+	 * Adjust the PWM duty cycle/period based on the period value provided
+	 * in PWM args.
+	 */
+	if (pargs.period != state.period) {
+		u64 dutycycle = (u64)state.duty_cycle * pargs.period;
+
+		do_div(dutycycle, state.period);
+		state.duty_cycle = dutycycle;
+		state.period = pargs.period;
+	}
+
+	/*
+	 * If the polarity changed, we should also change the duty cycle.
+	 */
+	if (pargs.polarity != state.polarity) {
+		state.polarity = pargs.polarity;
+		state.duty_cycle = state.period - state.duty_cycle;
+	}
+
+	return pwm_apply_might_sleep(pwm, &state);
 }
+EXPORT_SYMBOL_GPL(pwm_adjust_config);
 
 /**
- * __pwmchip_add() - register a new PWM chip
- * @chip: the PWM chip to add
- * @owner: reference to the module providing the chip.
- *
- * Register a new PWM chip. @owner is supposed to be THIS_MODULE, use the
- * pwmchip_add wrapper to do this right.
+ * pwm_capture() - capture and report a PWM signal
+ * @pwm: PWM device
+ * @result: structure to fill with capture result
+ * @timeout: time to wait, in milliseconds, before giving up on capture
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
+int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
+		unsigned long timeout)
 {
-	unsigned int i;
-	int ret;
+	int err;
 
-	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
+	if (!pwm || !pwm->chip->ops)
 		return -EINVAL;
 
-	if (!pwm_ops_check(chip))
-		return -EINVAL;
+	if (!pwm->chip->ops->capture)
+		return -ENOSYS;
 
-	chip->owner = owner;
+	mutex_lock(&pwm_lock);
+	err = pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
+	mutex_unlock(&pwm_lock);
 
-	chip->pwms = kcalloc(chip->npwm, sizeof(*chip->pwms), GFP_KERNEL);
-	if (!chip->pwms)
-		return -ENOMEM;
+	return err;
+}
+EXPORT_SYMBOL_GPL(pwm_capture);
 
-	mutex_lock(&pwm_lock);
+static struct pwm_chip *pwmchip_find_by_name(const char *name)
+{
+	struct pwm_chip *chip;
+	unsigned long id, tmp;
 
-	ret = idr_alloc(&pwm_chips, chip, 0, 0, GFP_KERNEL);
-	if (ret < 0) {
-		mutex_unlock(&pwm_lock);
-		kfree(chip->pwms);
-		return ret;
-	}
+	if (!name)
+		return NULL;
 
-	chip->id = ret;
+	mutex_lock(&pwm_lock);
 
-	for (i = 0; i < chip->npwm; i++) {
-		struct pwm_device *pwm = &chip->pwms[i];
+	idr_for_each_entry_ul(&pwm_chips, chip, tmp, id) {
+		const char *chip_name = dev_name(chip->dev);
 
-		pwm->chip = chip;
-		pwm->hwpwm = i;
+		if (chip_name && strcmp(chip_name, name) == 0) {
+			mutex_unlock(&pwm_lock);
+			return chip;
+		}
 	}
 
 	mutex_unlock(&pwm_lock);
 
-	if (IS_ENABLED(CONFIG_OF))
-		of_pwmchip_add(chip);
-
-	pwmchip_sysfs_export(chip);
-
-	return 0;
+	return NULL;
 }
-EXPORT_SYMBOL_GPL(__pwmchip_add);
 
-/**
- * pwmchip_remove() - remove a PWM chip
- * @chip: the PWM chip to remove
- *
- * Removes a PWM chip.
- */
-void pwmchip_remove(struct pwm_chip *chip)
+static int pwm_device_request(struct pwm_device *pwm, const char *label)
 {
-	pwmchip_sysfs_unexport(chip);
-
-	if (IS_ENABLED(CONFIG_OF))
-		of_pwmchip_remove(chip);
+	int err;
+	struct pwm_chip *chip = pwm->chip;
+	const struct pwm_ops *ops = chip->ops;
 
-	mutex_lock(&pwm_lock);
+	if (test_bit(PWMF_REQUESTED, &pwm->flags))
+		return -EBUSY;
 
-	idr_remove(&pwm_chips, chip->id);
+	if (!try_module_get(chip->owner))
+		return -ENODEV;
 
-	mutex_unlock(&pwm_lock);
+	if (ops->request) {
+		err = ops->request(chip, pwm);
+		if (err) {
+			module_put(chip->owner);
+			return err;
+		}
+	}
 
-	kfree(chip->pwms);
-}
-EXPORT_SYMBOL_GPL(pwmchip_remove);
+	if (ops->get_state) {
+		/*
+		 * Zero-initialize state because most drivers are unaware of
+		 * .usage_power. The other members of state are supposed to be
+		 * set by lowlevel drivers. We still initialize the whole
+		 * structure for simplicity even though this might paper over
+		 * faulty implementations of .get_state().
+		 */
+		struct pwm_state state = { 0, };
 
-static void devm_pwmchip_remove(void *data)
-{
-	struct pwm_chip *chip = data;
+		err = ops->get_state(chip, pwm, &state);
+		trace_pwm_get(pwm, &state, err);
 
-	pwmchip_remove(chip);
-}
+		if (!err)
+			pwm->state = state;
 
-int __devm_pwmchip_add(struct device *dev, struct pwm_chip *chip, struct module *owner)
-{
-	int ret;
+		if (IS_ENABLED(CONFIG_PWM_DEBUG))
+			pwm->last = pwm->state;
+	}
 
-	ret = __pwmchip_add(chip, owner);
-	if (ret)
-		return ret;
+	set_bit(PWMF_REQUESTED, &pwm->flags);
+	pwm->label = label;
 
-	return devm_add_action_or_reset(dev, devm_pwmchip_remove, chip);
+	return 0;
 }
-EXPORT_SYMBOL_GPL(__devm_pwmchip_add);
 
 /**
  * pwm_request_from_chip() - request a PWM device relative to a PWM chip
@@ -307,301 +409,179 @@ struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 }
 EXPORT_SYMBOL_GPL(pwm_request_from_chip);
 
-static void pwm_apply_debug(struct pwm_device *pwm,
-			    const struct pwm_state *state)
-{
-	struct pwm_state *last = &pwm->last;
-	struct pwm_chip *chip = pwm->chip;
-	struct pwm_state s1 = { 0 }, s2 = { 0 };
-	int err;
-
-	if (!IS_ENABLED(CONFIG_PWM_DEBUG))
-		return;
-
-	/* No reasonable diagnosis possible without .get_state() */
-	if (!chip->ops->get_state)
-		return;
-
-	/*
-	 * *state was just applied. Read out the hardware state and do some
-	 * checks.
-	 */
-
-	err = chip->ops->get_state(chip, pwm, &s1);
-	trace_pwm_get(pwm, &s1, err);
-	if (err)
-		/* If that failed there isn't much to debug */
-		return;
-
-	/*
-	 * The lowlevel driver either ignored .polarity (which is a bug) or as
-	 * best effort inverted .polarity and fixed .duty_cycle respectively.
-	 * Undo this inversion and fixup for further tests.
-	 */
-	if (s1.enabled && s1.polarity != state->polarity) {
-		s2.polarity = state->polarity;
-		s2.duty_cycle = s1.period - s1.duty_cycle;
-		s2.period = s1.period;
-		s2.enabled = s1.enabled;
-	} else {
-		s2 = s1;
-	}
-
-	if (s2.polarity != state->polarity &&
-	    state->duty_cycle < state->period)
-		dev_warn(chip->dev, ".apply ignored .polarity\n");
-
-	if (state->enabled &&
-	    last->polarity == state->polarity &&
-	    last->period > s2.period &&
-	    last->period <= state->period)
-		dev_warn(chip->dev,
-			 ".apply didn't pick the best available period (requested: %llu, applied: %llu, possible: %llu)\n",
-			 state->period, s2.period, last->period);
-
-	if (state->enabled && state->period < s2.period)
-		dev_warn(chip->dev,
-			 ".apply is supposed to round down period (requested: %llu, applied: %llu)\n",
-			 state->period, s2.period);
-
-	if (state->enabled &&
-	    last->polarity == state->polarity &&
-	    last->period == s2.period &&
-	    last->duty_cycle > s2.duty_cycle &&
-	    last->duty_cycle <= state->duty_cycle)
-		dev_warn(chip->dev,
-			 ".apply didn't pick the best available duty cycle (requested: %llu/%llu, applied: %llu/%llu, possible: %llu/%llu)\n",
-			 state->duty_cycle, state->period,
-			 s2.duty_cycle, s2.period,
-			 last->duty_cycle, last->period);
-
-	if (state->enabled && state->duty_cycle < s2.duty_cycle)
-		dev_warn(chip->dev,
-			 ".apply is supposed to round down duty_cycle (requested: %llu/%llu, applied: %llu/%llu)\n",
-			 state->duty_cycle, state->period,
-			 s2.duty_cycle, s2.period);
-
-	if (!state->enabled && s2.enabled && s2.duty_cycle > 0)
-		dev_warn(chip->dev,
-			 "requested disabled, but yielded enabled with duty > 0\n");
-
-	/* reapply the state that the driver reported being configured. */
-	err = chip->ops->apply(chip, pwm, &s1);
-	trace_pwm_apply(pwm, &s1, err);
-	if (err) {
-		*last = s1;
-		dev_err(chip->dev, "failed to reapply current setting\n");
-		return;
-	}
 
-	*last = (struct pwm_state){ 0 };
-	err = chip->ops->get_state(chip, pwm, last);
-	trace_pwm_get(pwm, last, err);
-	if (err)
-		return;
+struct pwm_device *
+of_pwm_xlate_with_flags(struct pwm_chip *chip, const struct of_phandle_args *args)
+{
+	struct pwm_device *pwm;
 
-	/* reapplication of the current state should give an exact match */
-	if (s1.enabled != last->enabled ||
-	    s1.polarity != last->polarity ||
-	    (s1.enabled && s1.period != last->period) ||
-	    (s1.enabled && s1.duty_cycle != last->duty_cycle)) {
-		dev_err(chip->dev,
-			".apply is not idempotent (ena=%d pol=%d %llu/%llu) -> (ena=%d pol=%d %llu/%llu)\n",
-			s1.enabled, s1.polarity, s1.duty_cycle, s1.period,
-			last->enabled, last->polarity, last->duty_cycle,
-			last->period);
-	}
-}
+	/* period in the second cell and flags in the third cell are optional */
+	if (args->args_count < 1)
+		return ERR_PTR(-EINVAL);
 
-/**
- * __pwm_apply() - atomically apply a new state to a PWM device
- * @pwm: PWM device
- * @state: new state to apply
- */
-static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
-{
-	struct pwm_chip *chip;
-	int err;
+	pwm = pwm_request_from_chip(chip, args->args[0], NULL);
+	if (IS_ERR(pwm))
+		return pwm;
 
-	if (!pwm || !state || !state->period ||
-	    state->duty_cycle > state->period)
-		return -EINVAL;
+	if (args->args_count > 1)
+		pwm->args.period = args->args[1];
 
-	chip = pwm->chip;
+	pwm->args.polarity = PWM_POLARITY_NORMAL;
+	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
+		pwm->args.polarity = PWM_POLARITY_INVERSED;
 
-	if (state->period == pwm->state.period &&
-	    state->duty_cycle == pwm->state.duty_cycle &&
-	    state->polarity == pwm->state.polarity &&
-	    state->enabled == pwm->state.enabled &&
-	    state->usage_power == pwm->state.usage_power)
-		return 0;
+	return pwm;
+}
+EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
 
-	err = chip->ops->apply(chip, pwm, state);
-	trace_pwm_apply(pwm, state, err);
-	if (err)
-		return err;
+struct pwm_device *
+of_pwm_single_xlate(struct pwm_chip *chip, const struct of_phandle_args *args)
+{
+	struct pwm_device *pwm;
 
-	pwm->state = *state;
+	pwm = pwm_request_from_chip(chip, 0, NULL);
+	if (IS_ERR(pwm))
+		return pwm;
 
-	/*
-	 * only do this after pwm->state was applied as some
-	 * implementations of .get_state depend on this
-	 */
-	pwm_apply_debug(pwm, state);
+	if (args->args_count > 1)
+		pwm->args.period = args->args[0];
 
-	return 0;
+	pwm->args.polarity = PWM_POLARITY_NORMAL;
+	if (args->args_count > 1 && args->args[1] & PWM_POLARITY_INVERTED)
+		pwm->args.polarity = PWM_POLARITY_INVERSED;
+
+	return pwm;
 }
+EXPORT_SYMBOL_GPL(of_pwm_single_xlate);
 
-/**
- * pwm_apply_might_sleep() - atomically apply a new state to a PWM device
- * Cannot be used in atomic context.
- * @pwm: PWM device
- * @state: new state to apply
- */
-int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
+static void of_pwmchip_add(struct pwm_chip *chip)
 {
-	int err;
+	if (!chip->dev || !chip->dev->of_node)
+		return;
 
-	/*
-	 * Some lowlevel driver's implementations of .apply() make use of
-	 * mutexes, also with some drivers only returning when the new
-	 * configuration is active calling pwm_apply_might_sleep() from atomic context
-	 * is a bad idea. So make it explicit that calling this function might
-	 * sleep.
-	 */
-	might_sleep();
+	if (!chip->of_xlate)
+		chip->of_xlate = of_pwm_xlate_with_flags;
 
-	if (IS_ENABLED(CONFIG_PWM_DEBUG) && pwm->chip->atomic) {
-		/*
-		 * Catch any drivers that have been marked as atomic but
-		 * that will sleep anyway.
-		 */
-		non_block_start();
-		err = __pwm_apply(pwm, state);
-		non_block_end();
-	} else {
-		err = __pwm_apply(pwm, state);
-	}
+	of_node_get(chip->dev->of_node);
+}
 
-	return err;
+static void of_pwmchip_remove(struct pwm_chip *chip)
+{
+	if (chip->dev)
+		of_node_put(chip->dev->of_node);
 }
-EXPORT_SYMBOL_GPL(pwm_apply_might_sleep);
 
-/**
- * pwm_apply_atomic() - apply a new state to a PWM device from atomic context
- * Not all PWM devices support this function, check with pwm_might_sleep().
- * @pwm: PWM device
- * @state: new state to apply
- */
-int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state)
+static bool pwm_ops_check(const struct pwm_chip *chip)
 {
-	WARN_ONCE(!pwm->chip->atomic,
-		  "sleeping PWM driver used in atomic context\n");
+	const struct pwm_ops *ops = chip->ops;
 
-	return __pwm_apply(pwm, state);
+	if (!ops->apply)
+		return false;
+
+	if (IS_ENABLED(CONFIG_PWM_DEBUG) && !ops->get_state)
+		dev_warn(chip->dev,
+			 "Please implement the .get_state() callback\n");
+
+	return true;
 }
-EXPORT_SYMBOL_GPL(pwm_apply_atomic);
 
 /**
- * pwm_capture() - capture and report a PWM signal
- * @pwm: PWM device
- * @result: structure to fill with capture result
- * @timeout: time to wait, in milliseconds, before giving up on capture
+ * __pwmchip_add() - register a new PWM chip
+ * @chip: the PWM chip to add
+ * @owner: reference to the module providing the chip.
+ *
+ * Register a new PWM chip. @owner is supposed to be THIS_MODULE, use the
+ * pwmchip_add wrapper to do this right.
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
-		unsigned long timeout)
+int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 {
-	int err;
+	unsigned int i;
+	int ret;
 
-	if (!pwm || !pwm->chip->ops)
+	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
 		return -EINVAL;
 
-	if (!pwm->chip->ops->capture)
-		return -ENOSYS;
+	if (!pwm_ops_check(chip))
+		return -EINVAL;
+
+	chip->owner = owner;
+
+	chip->pwms = kcalloc(chip->npwm, sizeof(*chip->pwms), GFP_KERNEL);
+	if (!chip->pwms)
+		return -ENOMEM;
 
 	mutex_lock(&pwm_lock);
-	err = pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
+
+	ret = idr_alloc(&pwm_chips, chip, 0, 0, GFP_KERNEL);
+	if (ret < 0) {
+		mutex_unlock(&pwm_lock);
+		kfree(chip->pwms);
+		return ret;
+	}
+
+	chip->id = ret;
+
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
+
+		pwm->chip = chip;
+		pwm->hwpwm = i;
+	}
+
 	mutex_unlock(&pwm_lock);
 
-	return err;
+	if (IS_ENABLED(CONFIG_OF))
+		of_pwmchip_add(chip);
+
+	pwmchip_sysfs_export(chip);
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(pwm_capture);
+EXPORT_SYMBOL_GPL(__pwmchip_add);
 
 /**
- * pwm_adjust_config() - adjust the current PWM config to the PWM arguments
- * @pwm: PWM device
+ * pwmchip_remove() - remove a PWM chip
+ * @chip: the PWM chip to remove
  *
- * This function will adjust the PWM config to the PWM arguments provided
- * by the DT or PWM lookup table. This is particularly useful to adapt
- * the bootloader config to the Linux one.
+ * Removes a PWM chip.
  */
-int pwm_adjust_config(struct pwm_device *pwm)
+void pwmchip_remove(struct pwm_chip *chip)
 {
-	struct pwm_state state;
-	struct pwm_args pargs;
-
-	pwm_get_args(pwm, &pargs);
-	pwm_get_state(pwm, &state);
-
-	/*
-	 * If the current period is zero it means that either the PWM driver
-	 * does not support initial state retrieval or the PWM has not yet
-	 * been configured.
-	 *
-	 * In either case, we setup the new period and polarity, and assign a
-	 * duty cycle of 0.
-	 */
-	if (!state.period) {
-		state.duty_cycle = 0;
-		state.period = pargs.period;
-		state.polarity = pargs.polarity;
+	pwmchip_sysfs_unexport(chip);
 
-		return pwm_apply_might_sleep(pwm, &state);
-	}
+	if (IS_ENABLED(CONFIG_OF))
+		of_pwmchip_remove(chip);
 
-	/*
-	 * Adjust the PWM duty cycle/period based on the period value provided
-	 * in PWM args.
-	 */
-	if (pargs.period != state.period) {
-		u64 dutycycle = (u64)state.duty_cycle * pargs.period;
+	mutex_lock(&pwm_lock);
 
-		do_div(dutycycle, state.period);
-		state.duty_cycle = dutycycle;
-		state.period = pargs.period;
-	}
+	idr_remove(&pwm_chips, chip->id);
 
-	/*
-	 * If the polarity changed, we should also change the duty cycle.
-	 */
-	if (pargs.polarity != state.polarity) {
-		state.polarity = pargs.polarity;
-		state.duty_cycle = state.period - state.duty_cycle;
-	}
+	mutex_unlock(&pwm_lock);
 
-	return pwm_apply_might_sleep(pwm, &state);
+	kfree(chip->pwms);
 }
-EXPORT_SYMBOL_GPL(pwm_adjust_config);
+EXPORT_SYMBOL_GPL(pwmchip_remove);
 
-static struct pwm_chip *fwnode_to_pwmchip(struct fwnode_handle *fwnode)
+static void devm_pwmchip_remove(void *data)
 {
-	struct pwm_chip *chip;
-	unsigned long id, tmp;
+	struct pwm_chip *chip = data;
 
-	mutex_lock(&pwm_lock);
+	pwmchip_remove(chip);
+}
 
-	idr_for_each_entry_ul(&pwm_chips, chip, tmp, id)
-		if (chip->dev && device_match_fwnode(chip->dev, fwnode)) {
-			mutex_unlock(&pwm_lock);
-			return chip;
-		}
+int __devm_pwmchip_add(struct device *dev, struct pwm_chip *chip, struct module *owner)
+{
+	int ret;
 
-	mutex_unlock(&pwm_lock);
+	ret = __pwmchip_add(chip, owner);
+	if (ret)
+		return ret;
 
-	return ERR_PTR(-EPROBE_DEFER);
+	return devm_add_action_or_reset(dev, devm_pwmchip_remove, chip);
 }
+EXPORT_SYMBOL_GPL(__devm_pwmchip_add);
 
 static struct device_link *pwm_device_link_add(struct device *dev,
 					       struct pwm_device *pwm)
@@ -629,6 +609,24 @@ static struct device_link *pwm_device_link_add(struct device *dev,
 	return dl;
 }
 
+static struct pwm_chip *fwnode_to_pwmchip(struct fwnode_handle *fwnode)
+{
+	struct pwm_chip *chip;
+	unsigned long id, tmp;
+
+	mutex_lock(&pwm_lock);
+
+	idr_for_each_entry_ul(&pwm_chips, chip, tmp, id)
+		if (chip->dev && device_match_fwnode(chip->dev, fwnode)) {
+			mutex_unlock(&pwm_lock);
+			return chip;
+		}
+
+	mutex_unlock(&pwm_lock);
+
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
 /**
  * of_pwm_get() - request a PWM via the PWM framework
  * @dev: device for PWM consumer
@@ -763,6 +761,9 @@ static struct pwm_device *acpi_pwm_get(const struct fwnode_handle *fwnode)
 	return pwm;
 }
 
+static DEFINE_MUTEX(pwm_lookup_lock);
+static LIST_HEAD(pwm_lookup_list);
+
 /**
  * pwm_add_table() - register PWM device consumers
  * @table: array of consumers to register
-- 
2.43.0




