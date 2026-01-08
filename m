Return-Path: <stable+bounces-206343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B4860D02FF7
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 14:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32BB8302C7B1
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 13:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2224D2AE3;
	Thu,  8 Jan 2026 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="lyOmVC6e"
X-Original-To: stable@vger.kernel.org
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851A14D2469;
	Thu,  8 Jan 2026 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876353; cv=none; b=Fm/coEmCxLXJ+OibYCm6pFhlHn/vs5JaixCeOvjEjiCklM4xKvSj/6+l3buxDSHUstYwjFTJDwhdFpjMWUO4uVFiI9BcRGXHvctMcjdrqyRmJuudM6jfDVI48l1eYhHx89SvTOQIvDDaRx8JRTZsUaLotbF9LBNXtkhwMW7VebI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876353; c=relaxed/simple;
	bh=D6fKN4f7C5FKbpG7szxX8++uDksOX+1oMjGH0iRMq48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=i5zk9lTlub6QeUHQXQZnM0DvxL4xaJw3uO/eTcqkeRC/50c8tErLARmSDo1SFzY6Adx10mBHL5DPfDjoZDnWKPdZu0+gwetvyNdgLRv8nKOuM9Z7GSjJ7hvqMDNuicr6NAc7l+x9GPdzQFympB2OiVVGryDotk/v+Br9kf+hc44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=lyOmVC6e; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1767876332; x=1768135532;
	bh=aLc1ABNGDOubKMqJjdyEE2rUDJu3+cw3hXTWYt1I64k=;
	h=From:Date:Subject:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=lyOmVC6eOUwGhcHBO5Eb3462sjFxqRvWZvq2Tnb1kiC0M83ZmLC0cGE15QPCn0EMK
	 kF1laGjM9ulpW5X22nlxzMJ85BP/dhI7K6CWlDtnKld6FfPTWSR6zdv03ndr4j9NU0
	 Ss/4Guj/HI1LBft19+e9PmHrG+KRRO93IF1DGv3PUieuC+syUKAKulF+7GR/KaNubo
	 rSujErEg5+imTtlN4P9JxaF+q7AsQKKt35FTBBrIMYq2GRHE5SgO12fWaPNKBy+jWn
	 pWPn+Ojc2VX2jb9s/f57BlvSiBYPBr5QSGNKGcWchPAUuBNNwDVezVFpSCX5lzuqNc
	 asTVPIsgl8NHw==
X-Pm-Submission-Id: 4dn4Pk0Vvcz1DLbC
From: Sean Nyekjaer <sean@geanix.com>
Date: Thu, 08 Jan 2026 13:45:23 +0100
Subject: [PATCH v2] pwm: stm32: Always program polarity
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260108-stm32-pwm-v2-1-ced582974f8b@geanix.com>
X-B4-Tracking: v=1; b=H4sIAOKmX2kC/03MSwrCMBSF4a2UOzaSRw2NI/chHcR4095B05KUW
 CnZu7EgOPwPh2+HhJEwwbXZIWKmRHOoIU8NuNGGARk9a4PkUnPBLyytk5JseU3MCPfoWqU77lu
 o/yWip+2w7n3tkdI6x/dBZ/Fdf4r+U7JggimFBjtrvFPqNqANtJ3dPEFfSvkAjw/CIKMAAAA=
X-Change-ID: 20260105-stm32-pwm-91cb843680f4
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

Commit 7346e7a058a2 ("pwm: stm32: Always do lazy disabling") triggered a
regression where PWM polarity changes could be ignored.

stm32_pwm_set_polarity() was skipped due to a mismatch between the
cached pwm->state.polarity and the actual hardware state, leaving the
hardware polarity unchanged.

Fixes: 7edf7369205b ("pwm: Add driver for STM32 plaftorm")
Cc: stable@vger.kernel.org # <= 6.12
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Co-developed-by: Uwe Kleine-König <ukleinek@kernel.org>
---
This patch is only applicable for stable tree's <= 6.12
---
Changes in v2:
- Taken patch improvements for Uwe
- Link to v1: https://lore.kernel.org/r/20260106-stm32-pwm-v1-1-33e9e8a9fc33@geanix.com
---
 drivers/pwm/pwm-stm32.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index eb24054f9729734da21eb96f2e37af03339e3440..86e6eb7396f67990249509dd347cb5a60c9ccf16 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -458,8 +458,7 @@ static int stm32_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	if (state->polarity != pwm->state.polarity)
-		stm32_pwm_set_polarity(priv, pwm->hwpwm, state->polarity);
+	stm32_pwm_set_polarity(priv, pwm->hwpwm, state->polarity);
 
 	ret = stm32_pwm_config(priv, pwm->hwpwm,
 			       state->duty_cycle, state->period);

---
base-commit: eb18504ca5cf1e6a76a752b73daf0ef51de3551b
change-id: 20260105-stm32-pwm-91cb843680f4

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


