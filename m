Return-Path: <stable+bounces-172499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02853B32295
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 21:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B06AA806C
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 19:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65A42C08AB;
	Fri, 22 Aug 2025 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAffK0ou"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EF7278E7B
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889529; cv=none; b=M4Va6jo8VhotS4Fr4mkaM4njVZHPcW68ukt2M5ioddF62R9skuwLw+NoGv7nc5ZCO5DVxRndDCaZkJIV1AKZMu4FPzVmXjd7eie0Y2ybAom4x9ZkWCHg9IwZS92CVIh4kfhNxBIOqMJ+0eLnEJCJ9xCeamyeHBd2qgB8S+3yT0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889529; c=relaxed/simple;
	bh=lF+WYwnzNPYbFy5bu5PPIVJFCGyZvfpPJjqNGzbFahg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ao51GsJpPqXN/+xSMqqmNnjB7mXYuqaEegRt3z2Uxu1U1Tj/YhPv2iK2MWDIlO3v6p4Khz3hRBtrvCz1ueLx8KA7AZ3AzdJ7UaGbFns8Ut5kLG9GcZ56JNKIZeumf/6gDFhuG7UTUZYyFzfUrmAu4vUb/OZAlz0UD8ROP+DPNu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAffK0ou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A7EC4CEED;
	Fri, 22 Aug 2025 19:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755889529;
	bh=lF+WYwnzNPYbFy5bu5PPIVJFCGyZvfpPJjqNGzbFahg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cAffK0ouzdejmjPcZMMFbg7NdYxPy92li3eaGI3LlWHVjtv7hpOvytRrWkPVd4qDP
	 UmYIjSL5KSTfG8jPbNV92R2UmmCvknth+yHzJJ1P9+j1TSqBpqXZo8xNnNVuJxUei2
	 mCF1v2ORujvhbwNMK1cJd1awmc/9lANf7lRxPPNghH3D4aEwjUw2oOeuFjPX6A0oh7
	 St1l8OwByLowHefbJuFSv1oEMY/+mceL+k1yAZZAWuTVxJNZODo+QpjxZ6/ARuR17r
	 AWopheb94PHzxdqX38G4ulyAgnUEJCIC+KY4rzKdHihOJnTVnkJmuDOzrT0YpWCJs2
	 HFxFb9WmSLWJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 1/3] pwm: mediatek: Implement .apply() callback
Date: Fri, 22 Aug 2025 15:05:25 -0400
Message-ID: <20250822190527.1408882-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082143-creature-relay-7247@gregkh>
References: <2025082143-creature-relay-7247@gregkh>
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
index 3cf766d892db..69616224a5fa 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -210,10 +210,33 @@ static void pwm_mediatek_disable(struct pwm_chip *chip, struct pwm_device *pwm)
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


