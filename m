Return-Path: <stable+bounces-172493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D97CB32264
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 20:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1105E755B
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 18:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E5929B777;
	Fri, 22 Aug 2025 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdbCk5pU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F1F19D07A
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755888605; cv=none; b=sadPqFmINDkHohd6IkcKmNW/pOd8+s3n8OBTgPDxo5aPya7iqrYO7XteljC2KShnpjVxrvSwDEiJn9IHxXtgyQ/taSnKEHzpZMXg77gAX2xUHbHn4q17VqrPkx8p7/3tdkFc76a7Om9BVxZyLKMistz3rwrVjh40B2t2S9lsK1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755888605; c=relaxed/simple;
	bh=4EtBb7IgWpU2+9GjxPPbdML037mFVXIohM27Bk+UyZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beo+0LkXafbdKee3fLwZ+jrjtJ9DSfqNikqbwZ3ytqr1EFRg0R6u7u2EnNcYsx21sOcQyu63HY/pcEopatGZQaIpR+5Og27aqdVQwQg52Y/r6wvjAJfQrm2PQYu6kk78wOWtwC5XBhM+YMklNI92aen2sFXaPL6BOr3rik/ZEvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdbCk5pU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75587C4CEED;
	Fri, 22 Aug 2025 18:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755888605;
	bh=4EtBb7IgWpU2+9GjxPPbdML037mFVXIohM27Bk+UyZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LdbCk5pUntiX3EeOn6Wiw/w62dnhv/qvFBy0fdxRUvbyV3b6NGcrd8qx8swuiN70m
	 o4jCPVJmX/UzhvbDqQGNeIy4hdubyNigO7x7wWhRHDSVmfx3VLV1NGF14Gp5CMQABo
	 bLchXA2V0TnDIXngXD6FNQvy7hTP8AAwdvCqwPJ0aeQi0SBs+tCnjuU2grMm5P22F9
	 QFU2Hf2AB6cUDVcvJ6KnthVYRO59y62GYI1xLXWu5pOqqV/6kkvcBUpe9TYHaIIWAE
	 2TlCL7HdJjtCobaGWRbPkLggSrkU2eygg47wCc6kWs0oCcEDwoLmI432zWOytN4rkP
	 hztkZYduFTq0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] pwm: mediatek: Implement .apply() callback
Date: Fri, 22 Aug 2025 14:50:00 -0400
Message-ID: <20250822185002.1400911-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082142-splotchy-hypocrite-964a@gregkh>
References: <2025082142-splotchy-hypocrite-964a@gregkh>
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
index d8a80b06a6f2..7b89ee0e3270 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -205,10 +205,33 @@ static void pwm_mediatek_disable(struct pwm_chip *chip, struct pwm_device *pwm)
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


