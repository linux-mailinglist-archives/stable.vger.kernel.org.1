Return-Path: <stable+bounces-172497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7075EB3228B
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 21:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C820E1CC5C44
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 19:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1887A2C158E;
	Fri, 22 Aug 2025 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLwP92bE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCC822D7A5
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 19:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889296; cv=none; b=ixccWVy5HG/nf9uXemYCw8LD0XWixBP35+ttoyTFK8ThaHtmrQHD9fG7ZjR6OX3X1OETesUhGVB/usZnEbUNn+8g/rKoRSUDuVADAf4VByg6CbzxJyH8ccUKnDh5O0hlodjwmoyT3svEvCWoMOmbf6FBwCRq7IKDU+3QUOywbpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889296; c=relaxed/simple;
	bh=IvIQ3neXu8mU7zR8AYdDqiSddy6aSdF0ysgu8T2WhRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwV3PaCoGiUgDKhVeXGU7yx3oKPMoWwJuLH8Ub6bDE9IAOtG0oSxbfQVNt9Zvlh5XuT3iU+51N7AzVqHaf8bbC0GID+WYhPworsrHyYweUejOXi6eFcw9yVn9JtMus2xrfg8cp5vuhBj1avrzxrs+q4R9UBu1N5tu95ASjXF9Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLwP92bE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0947C4CEF1;
	Fri, 22 Aug 2025 19:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755889296;
	bh=IvIQ3neXu8mU7zR8AYdDqiSddy6aSdF0ysgu8T2WhRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GLwP92bErzDEZ2DtNUWqzAFN5gE1iHRQG0fmZNYdEWEkI9XBLbXMgXNDge40b8iwZ
	 1qrVEANEy9cTJvT1mt9Al5Q4jz2I4nzQV0NwB8ZNYWwk91Q1G3T/Ya5UWcbXUXOFuL
	 XlZyj9uHKbSXql0DJppN8uoUfRSqY8+eyi3hW1vQUGCWt8E+qjc1hjb7ZWX10lfBS6
	 yvRgJ94+T96nNZRGPU3MaUoTmVFbvH81j4a2ZcXbUvAIheLMic/fPl7bT9Z/yX/+7f
	 GyytdYDhuQVjd7Y3VERrWkxFuNDu7lKVBd/3s/0/vZFsF0mVT/SmzAiriSGQLCJnq5
	 Uv/5/fBZE/xnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] pwm: mediatek: Handle hardware enable and clock enable separately
Date: Fri, 22 Aug 2025 15:01:32 -0400
Message-ID: <20250822190133.1406293-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822190133.1406293-1-sashal@kernel.org>
References: <2025082143-written-shale-5249@gregkh>
 <20250822190133.1406293-1-sashal@kernel.org>
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
index ea9161b96795..a86e5637c742 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -120,6 +120,26 @@ static inline void pwm_mediatek_writel(struct pwm_mediatek_chip *chip,
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
@@ -182,35 +202,6 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
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
@@ -220,8 +211,10 @@ static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -EINVAL;
 
 	if (!state->enabled) {
-		if (pwm->state.enabled)
+		if (pwm->state.enabled) {
 			pwm_mediatek_disable(chip, pwm);
+			pwm_mediatek_clk_disable(chip, pwm);
+		}
 
 		return 0;
 	}
@@ -230,8 +223,11 @@ static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
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


