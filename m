Return-Path: <stable+bounces-172496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C428EB3228D
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 21:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3341B17171A
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 19:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186372C1585;
	Fri, 22 Aug 2025 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zfk5Q+Bz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC018F7D
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889296; cv=none; b=NW6SLlknuUAqMbKdxGo+aA39F3vSiQlAKaDfBzXDmUK583f/+t7g63qxtAlWcB88CQAkwGB8FnXyl9szdIl3jafPBtVMmCglTM4Wyf/hYKY65bycstJJIJNdEn4dHjOT9265dhZpUETdMK2hzugfFSo/zfwW5DEXy1bONWQ+exA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889296; c=relaxed/simple;
	bh=l2MUxVoMNnmWmmkoKeCSyKNXMk77y8OOg5jr6nXWkYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHvhfBOghC95RFTYpNfrmuG7wCNqH8hvD5sIH2W6Ln0zAPIImfk5UlCRvHnjzUjoLgjhYLuhcd12EBK3QsfNHMtOd/2KDMj7Fv/A1X9Bj9lWA9rwjapCf6i6euV0JRlvO5GuM95ArWlzXMmuJdLaqn+A/9Bb4vc89HuZrJpexk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zfk5Q+Bz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C20C4CEED;
	Fri, 22 Aug 2025 19:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755889295;
	bh=l2MUxVoMNnmWmmkoKeCSyKNXMk77y8OOg5jr6nXWkYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zfk5Q+BzmhqoVSL254M7qvQ5zXtWiRntg4k+tn6zZo08PiejP+0xo/irw2fiEk9MN
	 fDSel38usL3jvYdCttnkdXXCQDygko7cGBY9r+trL2b3Vj4R2G4WcDxq/f3YeTaKhs
	 Vmc53kbHPQOv3+5iRVdNfoOOKqs5TnyY/ZVGlU601oRT/k0pxJMwyLG/hQVrdgLT76
	 k74GT3O6ytruHEieYDFj5KC3cUZZdl9KVpw8aJqcQi4gVb1zXExyW9J07wBESn1y5A
	 0F1Biz41sJ40uqO8ot5r4THQn/vl5IRFNxKvZmQkgZkRSm6EbtKW3hHq639gTNS95+
	 zRpoIIto2B6sA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] pwm: mediatek: Implement .apply() callback
Date: Fri, 22 Aug 2025 15:01:31 -0400
Message-ID: <20250822190133.1406293-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082143-written-shale-5249@gregkh>
References: <2025082143-written-shale-5249@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 758de66f4bd2cac2b1d71db917c65c3d611d4e74 ]

To eventually get rid of all legacy drivers convert this driver to the
modern world implementing .apply().
This just pushed a variant of pwm_apply_legacy() into the driver that was
slightly simplified because the driver doesn't provide a .set_polarity()
callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Stable-dep-of: f21d136caf81 ("pwm: mediatek: Fix duty and period setting")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-mediatek.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 239eb052f40b..ea9161b96795 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -211,10 +211,33 @@ static void pwm_mediatek_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	pwm_mediatek_clk_disable(chip, pwm);
 }
 
+static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			      const struct pwm_state *state)
+{
+	int err;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			pwm_mediatek_disable(chip, pwm);
+
+		return 0;
+	}
+
+	err = pwm_mediatek_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
+
+	if (!pwm->state.enabled)
+		err = pwm_mediatek_enable(chip, pwm);
+
+	return err;
+}
+
 static const struct pwm_ops pwm_mediatek_ops = {
-	.config = pwm_mediatek_config,
-	.enable = pwm_mediatek_enable,
-	.disable = pwm_mediatek_disable,
+	.apply = pwm_mediatek_apply,
 	.owner = THIS_MODULE,
 };
 
-- 
2.50.1


