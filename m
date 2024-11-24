Return-Path: <stable+bounces-95006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3A19D733A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D97B4B26EF9
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE03318FDA6;
	Sun, 24 Nov 2024 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8qAGank"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789AD18FC75;
	Sun, 24 Nov 2024 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455671; cv=none; b=A5lguJjgsVVuYs5O5S+yNlJ/cZncm8rTtg9JxTQfoHK6sJD7pOjgBcLDX1++8oI7Hw4mjuUypk3O2Xpgv7RPwy7N67q4kCGhFG3XhnKsMe1jHI6lgU06PEdujx4X0zmu651jGDtZuP5gnhCdZtv5glyFA+7Lvpl6g1CZ+4dLRho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455671; c=relaxed/simple;
	bh=tNEtgZZlaWDdjHOifOd0efr1ZRGD7UE8MF/fMJhw1AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aocWU00RlepsIZEZeMKo/tLketq1wiIQQUc6ZwobglICoTqvps7bK5dZEoH3cSbZjdId6S0gP1rTprH8G265oL9kOPeqEzxzRIrBX27PJj+MHS29lJknDUL0s1DdskVzenQFwOaHx3KxrG0drU0HYqeC0rn41/mnqygm64xhlJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8qAGank; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7CAC4CED3;
	Sun, 24 Nov 2024 13:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455670;
	bh=tNEtgZZlaWDdjHOifOd0efr1ZRGD7UE8MF/fMJhw1AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p8qAGank6tAKYWI4eClmMcZaU9zkEJKVCxi+Gs0YU+noJw/t57g4eZ0HaoyqECo2M
	 EBG6oLt8qB5WM5ZxrlbAj+qDAZi6NN0FsByVBxNL3ww/3VJ7E6ulaMsMDmMTJkOaRE
	 WsE6qdUq3UzsJHbluqBZnXBW4exAS1VNmCexGzuwk6sAX9mtkGvL0bgq/etTwEd9/K
	 iW1QylrV7pZjRKRia7VETIzLo+AQUa8rtmRRiEjbh9jyA1J7mg575CSrTwBz0dvJtC
	 NDbXyNuCWwX1zOjcfR2vPzzYADcCxaBzLihpj0DKO9N84DGHcGwbNkMEzM6ryEtfZB
	 dUeuXaj8VcZWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dom Cobley <popcornmix@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 03/87] drm/vc4: hdmi: Avoid log spam for audio start failure
Date: Sun, 24 Nov 2024 08:37:41 -0500
Message-ID: <20241124134102.3344326-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Dom Cobley <popcornmix@gmail.com>

[ Upstream commit b4e5646178e86665f5caef2894578600f597098a ]

We regularly get dmesg error reports of:
[   18.184066] hdmi-audio-codec hdmi-audio-codec.3.auto: ASoC: error at snd_soc_dai_startup on i2s-hifi: -19
[   18.184098]  MAI: soc_pcm_open() failed (-19)

These are generated for any disconnected hdmi interface when pulseaudio
attempts to open the associated ALSA device (numerous times). Each open
generates a kernel error message, generating general log spam.

The error messages all come from _soc_pcm_ret in sound/soc/soc-pcm.c#L39
which suggests returning ENOTSUPP, rather that ENODEV will be quiet.
And indeed it is.

Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240621152055.4180873-5-dave.stevenson@raspberrypi.com
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index cb424604484f1..5cb7ddec99a1f 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1920,7 +1920,7 @@ static int vc4_hdmi_audio_startup(struct device *dev, void *data)
 	}
 
 	if (!vc4_hdmi_audio_can_stream(vc4_hdmi)) {
-		ret = -ENODEV;
+		ret = -ENOTSUPP;
 		goto out_dev_exit;
 	}
 
-- 
2.43.0


