Return-Path: <stable+bounces-14905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818BB83831B
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E1128BC1C
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC4A605D2;
	Tue, 23 Jan 2024 01:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eBHvASor"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40DD6025E;
	Tue, 23 Jan 2024 01:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974705; cv=none; b=UFYieE81EDhCHmPXzg8b/l/OnOY10uYWEfIx12TWMcDMeLeKmCjPd1FhF/ThbA9CvFrJtvttcoDv3Jcqw+JEvWMk78txixjQE/He7gPZzgu7bRidFE4hJ/Hu7HRxhAylm3C2upE6QGQDfjR9MYJ3xMZAYsbj2V8pj7d1bIbVZ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974705; c=relaxed/simple;
	bh=TkYLh82MNOueqlgFYD/i1MnfPmAQFLuGFdtRwd8ZNJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBwjL+beK+vvmKQG1dKE9kvr2cIOLMroHGTXyWCCeSTNhlctHf0tdVlYVD9E0db6nBQUScUQJ0Ef03tNuyhFiE4Qz8K7HUE3dc1KsbnDGI/GBHQo0vlF5NREkK1TFiuYbUaL1iPGxmGTnjGcM4O6Xb5rdYkTURDiPuKiFLm5W+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eBHvASor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C019C43394;
	Tue, 23 Jan 2024 01:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974705;
	bh=TkYLh82MNOueqlgFYD/i1MnfPmAQFLuGFdtRwd8ZNJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eBHvASorMW16Tecobu58z3Wp4xLUpdHOMMIroOeNo9uiEI3L0XImQaSoQrXFwz9S1
	 xX+jCBKBmc+wwYYsXF+alpXe7Aet3aDnF1Gp+I6ur3GPy4jtzXOhg4GbIUrRAleGvW
	 x6F7e+WzKpdH4cJiJP8vaTn3rowcy5b+Jkq1z5UE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 227/374] pwm: stm32: Use regmap_clear_bits and regmap_set_bits where applicable
Date: Mon, 22 Jan 2024 15:58:03 -0800
Message-ID: <20240122235752.591838278@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 632ae5d7eb348b3ef88552ec0999260b6f9d6ab1 ]

Found using coccinelle and the following semantic patch:

@@
expression map, reg, bits;
@@

- regmap_update_bits(map, reg, bits, bits)
+ regmap_set_bits(map, reg, bits)

@@
expression map, reg, bits;
@@

- regmap_update_bits(map, reg, bits, 0)
+ regmap_clear_bits(map, reg, bits)

Tested-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Link: https://lore.kernel.org/r/20221115111347.3705732-6-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Stable-dep-of: 19f1016ea960 ("pwm: stm32: Fix enable count for clk in .probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-stm32.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 794ca5b02968..21e4a34dfff3 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -115,14 +115,14 @@ static int stm32_pwm_raw_capture(struct stm32_pwm *priv, struct pwm_device *pwm,
 	int ret;
 
 	/* Ensure registers have been updated, enable counter and capture */
-	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
-	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, TIM_CR1_CEN);
+	regmap_set_bits(priv->regmap, TIM_EGR, TIM_EGR_UG);
+	regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 
 	/* Use cc1 or cc3 DMA resp for PWM input channels 1 & 2 or 3 & 4 */
 	dma_id = pwm->hwpwm < 2 ? STM32_TIMERS_DMA_CH1 : STM32_TIMERS_DMA_CH3;
 	ccen = pwm->hwpwm < 2 ? TIM_CCER_CC12E : TIM_CCER_CC34E;
 	ccr = pwm->hwpwm < 2 ? TIM_CCR1 : TIM_CCR3;
-	regmap_update_bits(priv->regmap, TIM_CCER, ccen, ccen);
+	regmap_set_bits(priv->regmap, TIM_CCER, ccen);
 
 	/*
 	 * Timer DMA burst mode. Request 2 registers, 2 bursts, to get both
@@ -160,8 +160,8 @@ static int stm32_pwm_raw_capture(struct stm32_pwm *priv, struct pwm_device *pwm,
 	}
 
 stop:
-	regmap_update_bits(priv->regmap, TIM_CCER, ccen, 0);
-	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
+	regmap_clear_bits(priv->regmap, TIM_CCER, ccen);
+	regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 
 	return ret;
 }
@@ -359,7 +359,7 @@ static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
 
 	regmap_write(priv->regmap, TIM_PSC, prescaler);
 	regmap_write(priv->regmap, TIM_ARR, prd - 1);
-	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, TIM_CR1_ARPE);
+	regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE);
 
 	/* Calculate the duty cycles */
 	dty = prd * duty_ns;
@@ -377,7 +377,7 @@ static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
 	else
 		regmap_update_bits(priv->regmap, TIM_CCMR2, mask, ccmr);
 
-	regmap_update_bits(priv->regmap, TIM_BDTR, TIM_BDTR_MOE, TIM_BDTR_MOE);
+	regmap_set_bits(priv->regmap, TIM_BDTR, TIM_BDTR_MOE);
 
 	return 0;
 }
@@ -411,13 +411,13 @@ static int stm32_pwm_enable(struct stm32_pwm *priv, int ch)
 	if (priv->have_complementary_output)
 		mask |= TIM_CCER_CC1NE << (ch * 4);
 
-	regmap_update_bits(priv->regmap, TIM_CCER, mask, mask);
+	regmap_set_bits(priv->regmap, TIM_CCER, mask);
 
 	/* Make sure that registers are updated */
-	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
+	regmap_set_bits(priv->regmap, TIM_EGR, TIM_EGR_UG);
 
 	/* Enable controller */
-	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, TIM_CR1_CEN);
+	regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 
 	return 0;
 }
@@ -431,11 +431,11 @@ static void stm32_pwm_disable(struct stm32_pwm *priv, int ch)
 	if (priv->have_complementary_output)
 		mask |= TIM_CCER_CC1NE << (ch * 4);
 
-	regmap_update_bits(priv->regmap, TIM_CCER, mask, 0);
+	regmap_clear_bits(priv->regmap, TIM_CCER, mask);
 
 	/* When all channels are disabled, we can disable the controller */
 	if (!active_channels(priv))
-		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
+		regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 
 	clk_disable(priv->clk);
 }
@@ -568,10 +568,9 @@ static void stm32_pwm_detect_complementary(struct stm32_pwm *priv)
 	 * If complementary bit doesn't exist writing 1 will have no
 	 * effect so we can detect it.
 	 */
-	regmap_update_bits(priv->regmap,
-			   TIM_CCER, TIM_CCER_CC1NE, TIM_CCER_CC1NE);
+	regmap_set_bits(priv->regmap, TIM_CCER, TIM_CCER_CC1NE);
 	regmap_read(priv->regmap, TIM_CCER, &ccer);
-	regmap_update_bits(priv->regmap, TIM_CCER, TIM_CCER_CC1NE, 0);
+	regmap_clear_bits(priv->regmap, TIM_CCER, TIM_CCER_CC1NE);
 
 	priv->have_complementary_output = (ccer != 0);
 }
@@ -585,10 +584,9 @@ static int stm32_pwm_detect_channels(struct stm32_pwm *priv)
 	 * If channels enable bits don't exist writing 1 will have no
 	 * effect so we can detect and count them.
 	 */
-	regmap_update_bits(priv->regmap,
-			   TIM_CCER, TIM_CCER_CCXE, TIM_CCER_CCXE);
+	regmap_set_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
 	regmap_read(priv->regmap, TIM_CCER, &ccer);
-	regmap_update_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE, 0);
+	regmap_clear_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
 
 	if (ccer & TIM_CCER_CC1E)
 		npwm++;
-- 
2.43.0




