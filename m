Return-Path: <stable+bounces-172494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883E4B32265
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 20:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A4C6885A6
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 18:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809822BF002;
	Fri, 22 Aug 2025 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuGpTlUP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B5C19D07A
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755888606; cv=none; b=deAGdOojWDj7yGjX55spFzu28VlAKAmieK5epvE+XkJ5FzIoaub+iRdxctpffhGojMcMUGdWmFGpKocPJImjuUXF6ZHZzUAbLAcVL0o0p0an+BMZ4Z4L2p6zsTj0xeTcFtyEisaCmgw680e4dq4DXLIj6A7W9yyPhKvkUtt/sXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755888606; c=relaxed/simple;
	bh=Sa8/mfpV8HrdHUz1aCbawWuSWDli26sTvakb3pG/TfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vf6PRgByuyL98G3/V7jDAONxXr4xoFwMwd55wIv90hEHAtkqixa0Dc3kuAE01LPXAUPDO4z0/vKib7YrCsGld/pJGoLOY4C/GBDbnzKKXqPJ3DhmCdoMT17K09fH0AUKBzknpCyvc1mERfbiJjqqzL4oI/f5MIOzp80yFvJrrL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuGpTlUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411C6C4CEF1;
	Fri, 22 Aug 2025 18:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755888605;
	bh=Sa8/mfpV8HrdHUz1aCbawWuSWDli26sTvakb3pG/TfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iuGpTlUPsAfzBuKr2Ddjmx6s8VHSqlI9aO1w+TC3+niX17xoTb1DJJMkNFpnynRKC
	 goVjX1s+r71BbAkMlgd4y6G1WA4V76LI7edI/4DX5BTca3hp5VoMSPzabfzMeEAWHZ
	 dQR04OS+I2ntN+v7ZpwGDPidl7BzLYUd1l8/T39ZszwlPkFoaV712NZZ3Qc1eeLZTc
	 zKEYW7qMRTQVrPjYayZl/RJhl12fbE2aZ8AC6tTDv7TFBA8m1nLqVM8PJiSp7a69Y7
	 tWbG6NfBLF11rBzcLU4HtvCDCeE67tCxg20zaU/J1lsUUQZfXLyUzpdHooiCD1IW9f
	 PpXSKd46KNMYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] pwm: mediatek: Handle hardware enable and clock enable separately
Date: Fri, 22 Aug 2025 14:50:01 -0400
Message-ID: <20250822185002.1400911-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822185002.1400911-1-sashal@kernel.org>
References: <2025082142-splotchy-hypocrite-964a@gregkh>
 <20250822185002.1400911-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

[ Upstream commit 704d918341c378c5f9505dfdf32d315e256d3846 ]

Stop handling the clocks in pwm_mediatek_enable() and
pwm_mediatek_disable(). This is a preparing change for the next commit
that requires that clocks and the enable bit are handled separately.

Also move these two functions a bit further up in the source file to
make them usable in pwm_mediatek_config(), which is needed in the next
commit, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/55c94fe2917ece152ee1e998f4675642a7716f13.1753717973.git.u.kleine-koenig@baylibre.com
Cc: stable@vger.kernel.org
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
Stable-dep-of: f21d136caf81 ("pwm: mediatek: Fix duty and period setting")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-mediatek.c | 60 ++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 7b89ee0e3270..a11e4f750d02 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -114,6 +114,26 @@ static inline void pwm_mediatek_writel(struct pwm_mediatek_chip *chip,
 	writel(value, chip->regs + pwm_mediatek_reg_offset[num] + offset);
 }
 
+static void pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
+	u32 value;
+
+	value = readl(pc->regs);
+	value |= BIT(pwm->hwpwm);
+	writel(value, pc->regs);
+}
+
+static void pwm_mediatek_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
+	u32 value;
+
+	value = readl(pc->regs);
+	value &= ~BIT(pwm->hwpwm);
+	writel(value, pc->regs);
+}
+
 static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			       int duty_ns, int period_ns)
 {
@@ -176,35 +196,6 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	return ret;
 }
 
-static int pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
-	u32 value;
-	int ret;
-
-	ret = pwm_mediatek_clk_enable(chip, pwm);
-	if (ret < 0)
-		return ret;
-
-	value = readl(pc->regs);
-	value |= BIT(pwm->hwpwm);
-	writel(value, pc->regs);
-
-	return 0;
-}
-
-static void pwm_mediatek_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
-	u32 value;
-
-	value = readl(pc->regs);
-	value &= ~BIT(pwm->hwpwm);
-	writel(value, pc->regs);
-
-	pwm_mediatek_clk_disable(chip, pwm);
-}
-
 static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			      const struct pwm_state *state)
 {
@@ -214,8 +205,10 @@ static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -EINVAL;
 
 	if (!state->enabled) {
-		if (pwm->state.enabled)
+		if (pwm->state.enabled) {
 			pwm_mediatek_disable(chip, pwm);
+			pwm_mediatek_clk_disable(chip, pwm);
+		}
 
 		return 0;
 	}
@@ -224,8 +217,11 @@ static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (err)
 		return err;
 
-	if (!pwm->state.enabled)
-		err = pwm_mediatek_enable(chip, pwm);
+	if (!pwm->state.enabled) {
+		err = pwm_mediatek_clk_enable(chip, pwm);
+		if (!err)
+			pwm_mediatek_enable(chip, pwm);
+	}
 
 	return err;
 }
-- 
2.50.1


