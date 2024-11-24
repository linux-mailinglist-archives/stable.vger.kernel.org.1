Return-Path: <stable+bounces-95091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A07649D7330
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B22D165A4F
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E43192D61;
	Sun, 24 Nov 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bu3GSnAK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9C41974EA;
	Sun, 24 Nov 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456000; cv=none; b=MsZ38whxCyDlhBf8NrvtlupfLQKIsGcuJNsMzMgP5mjTQybzJGZ6i+15S/+b/ZC3D1dc+G7cl7yCn1igy3yusU6tVSn76yUE+sLYc71tFSb9iusBaM4xwF0OMhRcPtZ8Y09kWUH7Cw6Ax6QZo/i0dY9kNh9RuV27nZGyczz6ZkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456000; c=relaxed/simple;
	bh=qdiB0thozglpFuFyTlIZMBwLPGTZmLhXJH68DX3ouZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TLAQivow/lMYVl5t/E4MBiqBXou7f2W/UDq5RCw6yTnWSFfNcuGJGqjOKKcN1JOLTs6nUCZixSHsGaUKw6p9zKuBNu5N9YTJqVxDkQiTilxChHZPV9TZu2PobU0+jO5YiI7nXgaJAcG5kWhbhcmXnO9u75pEJnMPAWxmlwZeDjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bu3GSnAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB178C4CED1;
	Sun, 24 Nov 2024 13:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455999;
	bh=qdiB0thozglpFuFyTlIZMBwLPGTZmLhXJH68DX3ouZU=;
	h=From:To:Cc:Subject:Date:From;
	b=bu3GSnAKhYTk1rnzyvSx1LlcXKhcSht4Vnk0JWVS4hT2f0PsXqNcdRXDU21QESWop
	 Miq4DtlBIr5WK6wGUlMLqfH6QmAUhJU4tjQMAWaNrJw2obaMpU+WepO4sQYQwdmU+D
	 mQuZtN6ut3qkEr40lGkK7ie20TBjoVaQbj1sJy3I2Lm8OrqOBGEgPQyPi31+AARzyq
	 Hh3CO75/PfbhLKc7OBO52JXbF0qvorXmAgn8u465kqmGlMuCsRF5ep1XfcLHx+8pij
	 M78dPiiZrU4PiK5BE+ZDMppmNXqFWA/LVSICNbRzsCKue3FmVbMAz9RjlQ0POg4jPA
	 3TuxvJgz2FBrw==
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
Subject: [PATCH AUTOSEL 6.6 01/61] drm/vc4: hdmi: Avoid log spam for audio start failure
Date: Sun, 24 Nov 2024 08:44:36 -0500
Message-ID: <20241124134637.3346391-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index c6e986f71a26f..7cabfa1b883d2 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2392,7 +2392,7 @@ static int vc4_hdmi_audio_startup(struct device *dev, void *data)
 	}
 
 	if (!vc4_hdmi_audio_can_stream(vc4_hdmi)) {
-		ret = -ENODEV;
+		ret = -ENOTSUPP;
 		goto out_dev_exit;
 	}
 
-- 
2.43.0


