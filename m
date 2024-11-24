Return-Path: <stable+bounces-94899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B071B9D7465
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D460B3C597
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F08C18CBFB;
	Sun, 24 Nov 2024 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0XAzB0f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B60A18C910;
	Sun, 24 Nov 2024 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455189; cv=none; b=WX+GperEMVYV+SUU166iCCCNwWaNtOxzE3rgyMjWJs4GT0aA/P+aMdOaDA4giC7mWYpT4MgMKo4AEXsc+DqChoCLEBSUwzS4GLQM3riprXvfYQITyGkouHpv704W+0lvgg9I9B0cN3g7/vE9TD+g8et3B4FJ/Vi3PzTJ8DJ8BNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455189; c=relaxed/simple;
	bh=lmZodKinwBc/P9EgLvUQI1zXAQcCzq1nRGeZkpjEFGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzuyURJ+pL6HBuZ/QvPy4cUzHlNXxLYSEQeEZDHM+YJT1RkUoWvllqn81NubXquzXMN16SOPY88sYxomjgDJcn/ypEI+KyO9DwfZgLcCrMQeulnVBI1k6UWhUUOx+b3EZbkFGyz3GJe3An2wLoIB3jg6is9e1k2fSKTPilbX9Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0XAzB0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBFCC4CECC;
	Sun, 24 Nov 2024 13:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455188;
	bh=lmZodKinwBc/P9EgLvUQI1zXAQcCzq1nRGeZkpjEFGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0XAzB0f2GAv6Duun5hfOpbpcU+B8UKOb8a/b1HeZDEUqNPvICHHxr1mGLYlcM2lu
	 GXwueBBoYZwLyJgY6qZVxQsoeMrGx0sPD6kb9i4elqBiuxgmdWWUBcwdmfRBLqUrOL
	 2Nb8I+aGjnc3zOwS2dK0wPO38ZeqnKAlPb+H26mVDLSkK4FEBRJ+U9l68eg/47XOSP
	 yQGhr0OLYNTZy4hLeTXoWu7OmMgn9uR9chAl3hDFyeoZcsEZd1JlO9RNG7kcZP18u1
	 4tlygnPQ6PjT7wmNJmTAOlDDA+8PZ0/V+t4/KRU2oHyG8j0DTuL68ESdN8wOfLeLe9
	 BMgCgL8iKCtdw==
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
Subject: [PATCH AUTOSEL 6.12 003/107] drm/vc4: hdmi: Avoid log spam for audio start failure
Date: Sun, 24 Nov 2024 08:28:23 -0500
Message-ID: <20241124133301.3341829-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 6611ab7c26a63..43f4e150d7267 100644
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


