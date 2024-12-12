Return-Path: <stable+bounces-103219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 830A19EF6F5
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39CC188E96B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6F11487CD;
	Thu, 12 Dec 2024 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aph+os2o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AD84F218;
	Thu, 12 Dec 2024 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023903; cv=none; b=jL2pCLwt5aYMBk00gUQPfaA+tbE2UKbY6JloisVspZm22xWhkEFUrSXsef88C22nE2RU/Br8uqEiRsJHuRiPoXleN8WGO1D9m1+ryX2XqbHhtZzhnewzT7H22N88EFwb9aMJWaMKftVqbumMmGzl6SIb33VNxCoIoPjYwiEfnsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023903; c=relaxed/simple;
	bh=E04VSSRxvVxefkivdnSvustphwL8B/UBJU9yI7cZuyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USgD9juxuIuupZpN8v+efSCer/bDxQjMD+0sLqdwLljRAUueK2+I1lQ7PHELRMEOeMU/XCFhTkx7vH7QF53fZY2UoSnZGuPyEpuVE4nsk22T3jL+wvnKs8cib4ZM3XtcnOArSTj8U7+M2FsLVq4Sz6VGZw7C0Y0gwPC+2JHVOcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aph+os2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825FAC4CECE;
	Thu, 12 Dec 2024 17:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023902;
	bh=E04VSSRxvVxefkivdnSvustphwL8B/UBJU9yI7cZuyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aph+os2o77UalMmnaqR5Y7qOizd+FcRJzjHXDazvS64fFTjnZjNZJSNA3DTLz2pOM
	 qj7tjLhRO+iw1cpcx/8zL0kxj+G8xlhfdFcKD7JpXSzao3d2+JlcRA2WmrN6UeS1ir
	 gNv6Rwwft1jPJMU2jsD2Mk4do81a/+5eCTfZ7Jb8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jun Li <jun.li@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 090/459] pwm: imx27: Workaround of the pwm output bug when decrease the duty cycle
Date: Thu, 12 Dec 2024 15:57:08 +0100
Message-ID: <20241212144257.068415474@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Clark Wang <xiaoning.wang@nxp.com>

[ Upstream commit a25351e4c7740eb22561a3ee4ef17611c6f410b0 ]

Implement workaround for ERR051198
(https://www.nxp.com/docs/en/errata/IMX8MN_0N14Y.pdf)

PWM output may not function correctly if the FIFO is empty when a new SAR
value is programmed.

Description:
  When the PWM FIFO is empty, a new value programmed to the PWM Sample
  register (PWM_PWMSAR) will be directly applied even if the current timer
  period has not expired. If the new SAMPLE value programmed in the
  PWM_PWMSAR register is less than the previous value, and the PWM counter
  register (PWM_PWMCNR) that contains the current COUNT value is greater
  than the new programmed SAMPLE value, the current period will not flip
  the level. This may result in an output pulse with a duty cycle of 100%.

Workaround:
  Program the current SAMPLE value in the PWM_PWMSAR register before
  updating the new duty cycle to the SAMPLE value in the PWM_PWMSAR
  register. This will ensure that the new SAMPLE value is modified during
  a non-empty FIFO, and can be successfully updated after the period
  expires.

Write the old SAR value before updating the new duty cycle to SAR. This
avoids writing the new value into an empty FIFO.

This only resolves the issue when the PWM period is longer than 2us
(or <500kHz) because write register is not quick enough when PWM period is
very short.

Reproduce steps:
  cd /sys/class/pwm/pwmchip1/pwm0
  echo 2000000000 > period     # It is easy to observe by using long period
  echo 1000000000 > duty_cycle
  echo 1 > enable
  echo       8000 > duty_cycle # One full high pulse will be seen by scope

Fixes: 166091b1894d ("[ARM] MXC: add pwm driver for i.MX SoCs")
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20241008194123.1943141-1-Frank.Li@nxp.com
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-imx27.c | 98 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 86bcafd23e4f6..3c7929ca3b921 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -26,6 +26,7 @@
 #define MX3_PWMSR			0x04    /* PWM Status Register */
 #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
 #define MX3_PWMPR			0x10    /* PWM Period Register */
+#define MX3_PWMCNR			0x14    /* PWM Counter Register */
 
 #define MX3_PWMCR_FWM			GENMASK(27, 26)
 #define MX3_PWMCR_STOPEN		BIT(25)
@@ -215,11 +216,13 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
 static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			   const struct pwm_state *state)
 {
-	unsigned long period_cycles, duty_cycles, prescale;
+	unsigned long period_cycles, duty_cycles, prescale, period_us, tmp;
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
 	struct pwm_state cstate;
 	unsigned long long c;
 	unsigned long long clkrate;
+	unsigned long flags;
+	int val;
 	int ret;
 	u32 cr;
 
@@ -262,7 +265,98 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		pwm_imx27_sw_reset(chip);
 	}
 
-	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+	val = readl(imx->mmio_base + MX3_PWMPR);
+	val = val >= MX3_PWMPR_MAX ? MX3_PWMPR_MAX : val;
+	cr = readl(imx->mmio_base + MX3_PWMCR);
+	tmp = NSEC_PER_SEC * (u64)(val + 2) * MX3_PWMCR_PRESCALER_GET(cr);
+	tmp = DIV_ROUND_UP_ULL(tmp, clkrate);
+	period_us = DIV_ROUND_UP_ULL(tmp, 1000);
+
+	/*
+	 * ERR051198:
+	 * PWM: PWM output may not function correctly if the FIFO is empty when
+	 * a new SAR value is programmed
+	 *
+	 * Description:
+	 * When the PWM FIFO is empty, a new value programmed to the PWM Sample
+	 * register (PWM_PWMSAR) will be directly applied even if the current
+	 * timer period has not expired.
+	 *
+	 * If the new SAMPLE value programmed in the PWM_PWMSAR register is
+	 * less than the previous value, and the PWM counter register
+	 * (PWM_PWMCNR) that contains the current COUNT value is greater than
+	 * the new programmed SAMPLE value, the current period will not flip
+	 * the level. This may result in an output pulse with a duty cycle of
+	 * 100%.
+	 *
+	 * Consider a change from
+	 *     ________
+	 *    /        \______/
+	 *    ^      *        ^
+	 * to
+	 *     ____
+	 *    /    \__________/
+	 *    ^               ^
+	 * At the time marked by *, the new write value will be directly applied
+	 * to SAR even the current period is not over if FIFO is empty.
+	 *
+	 *     ________        ____________________
+	 *    /        \______/                    \__________/
+	 *    ^               ^      *        ^               ^
+	 *    |<-- old SAR -->|               |<-- new SAR -->|
+	 *
+	 * That is the output is active for a whole period.
+	 *
+	 * Workaround:
+	 * Check new SAR less than old SAR and current counter is in errata
+	 * windows, write extra old SAR into FIFO and new SAR will effect at
+	 * next period.
+	 *
+	 * Sometime period is quite long, such as over 1 second. If add old SAR
+	 * into FIFO unconditional, new SAR have to wait for next period. It
+	 * may be too long.
+	 *
+	 * Turn off the interrupt to ensure that not IRQ and schedule happen
+	 * during above operations. If any irq and schedule happen, counter
+	 * in PWM will be out of data and take wrong action.
+	 *
+	 * Add a safety margin 1.5us because it needs some time to complete
+	 * IO write.
+	 *
+	 * Use writel_relaxed() to minimize the interval between two writes to
+	 * the SAR register to increase the fastest PWM frequency supported.
+	 *
+	 * When the PWM period is longer than 2us(or <500kHz), this workaround
+	 * can solve this problem. No software workaround is available if PWM
+	 * period is shorter than IO write. Just try best to fill old data
+	 * into FIFO.
+	 */
+	c = clkrate * 1500;
+	do_div(c, NSEC_PER_SEC);
+
+	local_irq_save(flags);
+	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
+
+	if (duty_cycles < imx->duty_cycle && (cr & MX3_PWMCR_EN)) {
+		if (period_us < 2) { /* 2us = 500 kHz */
+			/* Best effort attempt to fix up >500 kHz case */
+			udelay(3 * period_us);
+			writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
+			writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
+		} else if (val < MX3_PWMSR_FIFOAV_2WORDS) {
+			val = readl_relaxed(imx->mmio_base + MX3_PWMCNR);
+			/*
+			 * If counter is close to period, controller may roll over when
+			 * next IO write.
+			 */
+			if ((val + c >= duty_cycles && val < imx->duty_cycle) ||
+			    val + c >= period_cycles)
+				writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
+		}
+	}
+	writel_relaxed(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+	local_irq_restore(flags);
+
 	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
 
 	/*
-- 
2.43.0




