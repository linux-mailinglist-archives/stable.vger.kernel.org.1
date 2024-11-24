Return-Path: <stable+bounces-95152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBDB9D7749
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 19:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92747B34A3F
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67099230F52;
	Sun, 24 Nov 2024 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LG1YHT1v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231CC230F4C;
	Sun, 24 Nov 2024 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456193; cv=none; b=e2SWQOjjfM95pZ64dta8NG7xdK1/K/v4ahnnSNEhmwtVsXymGDNZdcW+fBzouCvaQRkzF+lmzj1fCcoEfEc3suiDy7+wPMHSvhz4lCFX9ei1WVFaHDMTbpyhEFeDU2rOHws7pv51YLry79JpazvcFEs0z1LeDVdywTYwxbE6tHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456193; c=relaxed/simple;
	bh=6YhAJVbTfvrNGGBHSBgjgxW8/vqPCFlO/eFJJowc6uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=imuF1ma/NckpAONkdR/VI0MMQdDNN4XxkMJulGP/5QL225yKDYIVA72Tud2XHoqVdESrFj97u1nPO5BJWPL5i6Kt17PM4usnRekw961ouKKoOBAnUO1DeABZLmFLvgx8HAT3GyNP56pMzSDSiaeU+KOxFv0bUHwvR+9+lCsPUfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LG1YHT1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA152C4CECC;
	Sun, 24 Nov 2024 13:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456193;
	bh=6YhAJVbTfvrNGGBHSBgjgxW8/vqPCFlO/eFJJowc6uc=;
	h=From:To:Cc:Subject:Date:From;
	b=LG1YHT1v8gUVVE4l2QuzfWdlClzXY8pYfnFutKabCiIdlOS7bIy1vpoDbTqiqAAc+
	 pJqacWipHRDY4TLqT0R5vNINciulKYuBZ+J3hFnOFZvG+zLO3MbCIlany9gHGjBGZm
	 hx7U+ddA/VlzzfGitTGw3UN5HAmHjglNm0Np/+jgBYmcFYd2OiXBIB7obUxrGyndJJ
	 tpOqogOfS6sl7esMPkNyanS+Zms1zTHqIRqngVYQFsY4C74ScsBKQBZUijJ1WvER6N
	 mDGRZadMMrghFJLhx0jeRIUd3gZEYZzqNWZYlSfKn02VsUQ80s7dIT7fpXwiiTImR3
	 nZMq8tT07ji/Q==
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
Subject: [PATCH AUTOSEL 6.1 01/48] drm/vc4: hdmi: Avoid log spam for audio start failure
Date: Sun, 24 Nov 2024 08:48:24 -0500
Message-ID: <20241124134950.3348099-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index 971801acbde60..51971035d8cbb 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2156,7 +2156,7 @@ static int vc4_hdmi_audio_startup(struct device *dev, void *data)
 	}
 
 	if (!vc4_hdmi_audio_can_stream(vc4_hdmi)) {
-		ret = -ENODEV;
+		ret = -ENOTSUPP;
 		goto out_dev_exit;
 	}
 
-- 
2.43.0


