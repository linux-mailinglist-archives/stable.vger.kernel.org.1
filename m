Return-Path: <stable+bounces-184737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DF7BD42CF
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C75C188DB35
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CBC30C62D;
	Mon, 13 Oct 2025 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kV7qTe7H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF05330C627;
	Mon, 13 Oct 2025 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368291; cv=none; b=qnH3ZOzd6KVabBHKUJxcx9hujnLfv1xxyUMtoXUak2qayCnpXgN2LF7AkqE1xufeav1AzTvYZXux6FDH8+zDfnhhETMofDzQEICsg4huZl+prhILnqNm4isZgPMYRkAhY0dBycNfySGDSH6Z+d0qj3NhxIUPMgt3Z8u/77m7CLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368291; c=relaxed/simple;
	bh=IpCzIcav0XWpyHpQbHPTnWv9VtxlCemp5QrJ/Bse9+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mn7cnSpygcITh2+06dmHjMRUu+Xw3hC3yZMBgjfIx2PA1YDr1WE4fJ0Q4/eYLOwZ2+yH2GxZSiBIyVXlLSBwi6I6GZnzjwbM231iVySR2U82PawKwWckVpc2x7vtP8BI9334ZQ7ghjpNBTDmxGKd2QVEFgEOZc2Ho9GD88s+5f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kV7qTe7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33413C4CEE7;
	Mon, 13 Oct 2025 15:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760368291;
	bh=IpCzIcav0XWpyHpQbHPTnWv9VtxlCemp5QrJ/Bse9+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kV7qTe7Hu92ODMAc8sVcY81ZajNNomvyJ5LlUpDuas/SE29Tbyik1GcNXouwaNE8I
	 mEawGpLegz5kq/v/MExWzP2bQefrt1gGgi09L3ElP8v35o107Q3GLJnBH34ghGrLgA
	 z4V+qbeABvI79+5qmK/IAyABMy4Q+zNlImtKAJ2Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 067/262] pwm: tiehrpwm: Fix various off-by-one errors in duty-cycle calculation
Date: Mon, 13 Oct 2025 16:43:29 +0200
Message-ID: <20251013144328.541418937@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
References: <20251013144326.116493600@linuxfoundation.org>
User-Agent: quilt/0.69
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

[ Upstream commit bc7ce5bfc504eea9eac0eb0215017b9fcfc62c59 ]

In Up-Count Mode the timer is reset to zero one tick after it reaches
TBPRD, so the period length is (TBPRD + 1) * T_TBCLK. This matches both
the documentation and measurements. So the value written to the TBPRD has
to be one less than the calculated period_cycles value.

A complication here is that for a 100% relative duty-cycle the value
written to the CMPx register has to be TBPRD + 1 which might overflow if
TBPRD is 0xffff. To handle that the calculation of the AQCTLx register
has to be moved to ehrpwm_pwm_config() and the edge at CTR = CMPx has to
be skipped.

Additionally the AQCTL_PRD register field has to be 0 because that defines
the hardware's action when the maximal counter value is reached, which is
(as above) one clock tick before the period's end. The period start edge
has to happen when the counter is reset and so is defined in the AQCTL_ZRO
field.

Fixes: 19891b20e7c2 ("pwm: pwm-tiehrpwm: PWM driver support for EHRPWM")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Link: https://lore.kernel.org/r/dc818c69b7cf05109ecda9ee6b0043a22de757c1.1754927682.git.u.kleine-koenig@baylibre.com
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-tiehrpwm.c | 143 +++++++++++++++----------------------
 1 file changed, 58 insertions(+), 85 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index a94b1e387b924..a23e48b8523db 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -36,7 +36,7 @@
 
 #define CLKDIV_MAX		7
 #define HSPCLKDIV_MAX		7
-#define PERIOD_MAX		0xFFFF
+#define PERIOD_MAX		0x10000
 
 /* compare module registers */
 #define CMPA			0x12
@@ -65,14 +65,10 @@
 #define AQCTL_ZRO_FRCHIGH	BIT(1)
 #define AQCTL_ZRO_FRCTOGGLE	(BIT(1) | BIT(0))
 
-#define AQCTL_CHANA_POLNORMAL	(AQCTL_CAU_FRCLOW | AQCTL_PRD_FRCHIGH | \
-				AQCTL_ZRO_FRCHIGH)
-#define AQCTL_CHANA_POLINVERSED	(AQCTL_CAU_FRCHIGH | AQCTL_PRD_FRCLOW | \
-				AQCTL_ZRO_FRCLOW)
-#define AQCTL_CHANB_POLNORMAL	(AQCTL_CBU_FRCLOW | AQCTL_PRD_FRCHIGH | \
-				AQCTL_ZRO_FRCHIGH)
-#define AQCTL_CHANB_POLINVERSED	(AQCTL_CBU_FRCHIGH | AQCTL_PRD_FRCLOW | \
-				AQCTL_ZRO_FRCLOW)
+#define AQCTL_CHANA_POLNORMAL	(AQCTL_CAU_FRCLOW | AQCTL_ZRO_FRCHIGH)
+#define AQCTL_CHANA_POLINVERSED	(AQCTL_CAU_FRCHIGH | AQCTL_ZRO_FRCLOW)
+#define AQCTL_CHANB_POLNORMAL	(AQCTL_CBU_FRCLOW | AQCTL_ZRO_FRCHIGH)
+#define AQCTL_CHANB_POLINVERSED	(AQCTL_CBU_FRCHIGH | AQCTL_ZRO_FRCLOW)
 
 #define AQSFRC_RLDCSF_MASK	(BIT(7) | BIT(6))
 #define AQSFRC_RLDCSF_ZRO	0
@@ -108,7 +104,6 @@ struct ehrpwm_pwm_chip {
 	unsigned long clk_rate;
 	void __iomem *mmio_base;
 	unsigned long period_cycles[NUM_PWM_CHANNEL];
-	enum pwm_polarity polarity[NUM_PWM_CHANNEL];
 	struct clk *tbclk;
 	struct ehrpwm_context ctx;
 };
@@ -177,51 +172,20 @@ static int set_prescale_div(unsigned long rqst_prescaler, u16 *prescale_div,
 	return 1;
 }
 
-static void configure_polarity(struct ehrpwm_pwm_chip *pc, int chan)
-{
-	u16 aqctl_val, aqctl_mask;
-	unsigned int aqctl_reg;
-
-	/*
-	 * Configure PWM output to HIGH/LOW level on counter
-	 * reaches compare register value and LOW/HIGH level
-	 * on counter value reaches period register value and
-	 * zero value on counter
-	 */
-	if (chan == 1) {
-		aqctl_reg = AQCTLB;
-		aqctl_mask = AQCTL_CBU_MASK;
-
-		if (pc->polarity[chan] == PWM_POLARITY_INVERSED)
-			aqctl_val = AQCTL_CHANB_POLINVERSED;
-		else
-			aqctl_val = AQCTL_CHANB_POLNORMAL;
-	} else {
-		aqctl_reg = AQCTLA;
-		aqctl_mask = AQCTL_CAU_MASK;
-
-		if (pc->polarity[chan] == PWM_POLARITY_INVERSED)
-			aqctl_val = AQCTL_CHANA_POLINVERSED;
-		else
-			aqctl_val = AQCTL_CHANA_POLNORMAL;
-	}
-
-	aqctl_mask |= AQCTL_PRD_MASK | AQCTL_ZRO_MASK;
-	ehrpwm_modify(pc->mmio_base, aqctl_reg, aqctl_mask, aqctl_val);
-}
-
 /*
  * period_ns = 10^9 * (ps_divval * period_cycles) / PWM_CLK_RATE
  * duty_ns   = 10^9 * (ps_divval * duty_cycles) / PWM_CLK_RATE
  */
 static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			     u64 duty_ns, u64 period_ns)
+			     u64 duty_ns, u64 period_ns, enum pwm_polarity polarity)
 {
 	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
 	u32 period_cycles, duty_cycles;
 	u16 ps_divval, tb_divval;
 	unsigned int i, cmp_reg;
 	unsigned long long c;
+	u16 aqctl_val, aqctl_mask;
+	unsigned int aqctl_reg;
 
 	if (period_ns > NSEC_PER_SEC)
 		return -ERANGE;
@@ -231,15 +195,10 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(c, NSEC_PER_SEC);
 	period_cycles = (unsigned long)c;
 
-	if (period_cycles < 1) {
-		period_cycles = 1;
-		duty_cycles = 1;
-	} else {
-		c = pc->clk_rate;
-		c = c * duty_ns;
-		do_div(c, NSEC_PER_SEC);
-		duty_cycles = (unsigned long)c;
-	}
+	c = pc->clk_rate;
+	c = c * duty_ns;
+	do_div(c, NSEC_PER_SEC);
+	duty_cycles = (unsigned long)c;
 
 	/*
 	 * Period values should be same for multiple PWM channels as IP uses
@@ -271,46 +230,67 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -EINVAL;
 	}
 
-	pm_runtime_get_sync(pwmchip_parent(chip));
-
-	/* Update clock prescaler values */
-	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CLKDIV_MASK, tb_divval);
-
 	/* Update period & duty cycle with presacler division */
 	period_cycles = period_cycles / ps_divval;
 	duty_cycles = duty_cycles / ps_divval;
 
-	/* Configure shadow loading on Period register */
-	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_PRDLD_MASK, TBCTL_PRDLD_SHDW);
+	if (period_cycles < 1)
+		period_cycles = 1;
 
-	ehrpwm_write(pc->mmio_base, TBPRD, period_cycles);
+	pm_runtime_get_sync(pwmchip_parent(chip));
 
-	/* Configure ehrpwm counter for up-count mode */
-	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CTRMODE_MASK,
-		      TBCTL_CTRMODE_UP);
+	/* Update clock prescaler values */
+	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CLKDIV_MASK, tb_divval);
 
-	if (pwm->hwpwm == 1)
+	if (pwm->hwpwm == 1) {
 		/* Channel 1 configured with compare B register */
 		cmp_reg = CMPB;
-	else
+
+		aqctl_reg = AQCTLB;
+		aqctl_mask = AQCTL_CBU_MASK;
+
+		if (polarity == PWM_POLARITY_INVERSED)
+			aqctl_val = AQCTL_CHANB_POLINVERSED;
+		else
+			aqctl_val = AQCTL_CHANB_POLNORMAL;
+
+		/* if duty_cycle is big, don't toggle on CBU */
+		if (duty_cycles > period_cycles)
+			aqctl_val &= ~AQCTL_CBU_MASK;
+
+	} else {
 		/* Channel 0 configured with compare A register */
 		cmp_reg = CMPA;
 
-	ehrpwm_write(pc->mmio_base, cmp_reg, duty_cycles);
+		aqctl_reg = AQCTLA;
+		aqctl_mask = AQCTL_CAU_MASK;
 
-	pm_runtime_put_sync(pwmchip_parent(chip));
+		if (polarity == PWM_POLARITY_INVERSED)
+			aqctl_val = AQCTL_CHANA_POLINVERSED;
+		else
+			aqctl_val = AQCTL_CHANA_POLNORMAL;
 
-	return 0;
-}
+		/* if duty_cycle is big, don't toggle on CAU */
+		if (duty_cycles > period_cycles)
+			aqctl_val &= ~AQCTL_CAU_MASK;
+	}
 
-static int ehrpwm_pwm_set_polarity(struct pwm_chip *chip,
-				   struct pwm_device *pwm,
-				   enum pwm_polarity polarity)
-{
-	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+	aqctl_mask |= AQCTL_PRD_MASK | AQCTL_ZRO_MASK;
+	ehrpwm_modify(pc->mmio_base, aqctl_reg, aqctl_mask, aqctl_val);
+
+	/* Configure shadow loading on Period register */
+	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_PRDLD_MASK, TBCTL_PRDLD_SHDW);
+
+	ehrpwm_write(pc->mmio_base, TBPRD, period_cycles - 1);
+
+	/* Configure ehrpwm counter for up-count mode */
+	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CTRMODE_MASK,
+		      TBCTL_CTRMODE_UP);
+
+	if (!(duty_cycles > period_cycles))
+		ehrpwm_write(pc->mmio_base, cmp_reg, duty_cycles);
 
-	/* Configuration of polarity in hardware delayed, do at enable */
-	pc->polarity[pwm->hwpwm] = polarity;
+	pm_runtime_put_sync(pwmchip_parent(chip));
 
 	return 0;
 }
@@ -339,9 +319,6 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ehrpwm_modify(pc->mmio_base, AQCSFRC, aqcsfrc_mask, aqcsfrc_val);
 
-	/* Channels polarity can be configured from action qualifier module */
-	configure_polarity(pc, pwm->hwpwm);
-
 	/* Enable TBCLK */
 	ret = clk_enable(pc->tbclk);
 	if (ret) {
@@ -406,10 +383,6 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			ehrpwm_pwm_disable(chip, pwm);
 			enabled = false;
 		}
-
-		err = ehrpwm_pwm_set_polarity(chip, pwm, state->polarity);
-		if (err)
-			return err;
 	}
 
 	if (!state->enabled) {
@@ -418,7 +391,7 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	err = ehrpwm_pwm_config(chip, pwm, state->duty_cycle, state->period);
+	err = ehrpwm_pwm_config(chip, pwm, state->duty_cycle, state->period, state->polarity);
 	if (err)
 		return err;
 
-- 
2.51.0




