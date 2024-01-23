Return-Path: <stable+bounces-14172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ED0837FCE
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34CD1C2944F
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D615612BEA8;
	Tue, 23 Jan 2024 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mIGU05nB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9670312BEA3;
	Tue, 23 Jan 2024 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971362; cv=none; b=B3FSNLABdmlkc26kR1Pbq1XFiEwM0vWubdmTQa3YWyJryPJ1Rbjs+8kAirybbjaI3HWkKE5mnpaANbq2RpQ9i3FstIzhyXqJLKWvECzmpOX1SINn1WjZoW8eXe7meaHOyAIf/sNL2ZeiWCo+cXX8hrSKeEnqwljKg5fo+2Ho+M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971362; c=relaxed/simple;
	bh=mCcNVpwdQKQlorsUPMZJ8tD9SYrQ885hiUP104P793Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okenpAwqPhVqc+rKa+CDUJ1J/D5XsSj8+1y7iomvOyZtRF2WnyJZD6VRFutMHGzbKg89czQN1O3sYucERSaPbibVRTroEqJokT7OzgaMoz5vzclxTMXdfs7tGNShc3/AsjbURrnD/E6s2a+T9oGrmhb7Tade7yqDQ9LdWdl0XCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mIGU05nB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A97EC433C7;
	Tue, 23 Jan 2024 00:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971362;
	bh=mCcNVpwdQKQlorsUPMZJ8tD9SYrQ885hiUP104P793Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mIGU05nBHb7c9SHWwrvfaO7t4+XVEOs3UilcmRLTCSpYGyHd6UUKKKIiQ81JHCcB/
	 bzFzTibgP/DWeqStNoIXorkq9xJ8nYMgQ5ImCHPbAbFxVJww5MO7hauuGkN6VNIlSU
	 YR5l7pXLztuth3S/tOgW9pcK6+l9m5P86iF9OGGA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philipp Zabel <p.zabel@pengutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 229/417] pwm: stm32: Use hweight32 in stm32_pwm_detect_channels
Date: Mon, 22 Jan 2024 15:56:37 -0800
Message-ID: <20240122235759.837320124@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philipp Zabel <p.zabel@pengutronix.de>

[ Upstream commit 41fa8f57c0d269243fe3bde2bce71e82c884b9ad ]

Use hweight32() to count the CCxE bits in stm32_pwm_detect_channels().
Since the return value is assigned to chip.npwm, change it to unsigned
int as well.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Stable-dep-of: 19f1016ea960 ("pwm: stm32: Fix enable count for clk in .probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-stm32.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 21e4a34dfff3..9c260aac442d 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -575,10 +575,9 @@ static void stm32_pwm_detect_complementary(struct stm32_pwm *priv)
 	priv->have_complementary_output = (ccer != 0);
 }
 
-static int stm32_pwm_detect_channels(struct stm32_pwm *priv)
+static unsigned int stm32_pwm_detect_channels(struct stm32_pwm *priv)
 {
 	u32 ccer;
-	int npwm = 0;
 
 	/*
 	 * If channels enable bits don't exist writing 1 will have no
@@ -588,19 +587,7 @@ static int stm32_pwm_detect_channels(struct stm32_pwm *priv)
 	regmap_read(priv->regmap, TIM_CCER, &ccer);
 	regmap_clear_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
 
-	if (ccer & TIM_CCER_CC1E)
-		npwm++;
-
-	if (ccer & TIM_CCER_CC2E)
-		npwm++;
-
-	if (ccer & TIM_CCER_CC3E)
-		npwm++;
-
-	if (ccer & TIM_CCER_CC4E)
-		npwm++;
-
-	return npwm;
+	return hweight32(ccer & TIM_CCER_CCXE);
 }
 
 static int stm32_pwm_probe(struct platform_device *pdev)
-- 
2.43.0




