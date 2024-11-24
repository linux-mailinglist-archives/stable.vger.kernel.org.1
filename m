Return-Path: <stable+bounces-94901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D0D9D755C
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99460B28716
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB33318FDC6;
	Sun, 24 Nov 2024 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhFKWiT4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A630218FDAA;
	Sun, 24 Nov 2024 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455192; cv=none; b=Wr5nhcCW8UbWEXnGG/6Xf+zLEM17atoJuZz3SG9Vprs1dqOdmKKIU0pyQr6uRaRgxGFty2VK5w7NT3o/ky9ZtyF35h5HvMVOySIrDFu1qtanaOLHlezs7+Nys2ZGp0mt1J+6vkrob+wSfGLGD5+aO/5JFaXmWX5h2A6amCTEeW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455192; c=relaxed/simple;
	bh=+SEVPFnWbGasTS3CaQzAyjGOG6Uv4j7pH8wGVB6evMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdPRoXWRUjsXCS7kSusjehhGMLKd3Q37enPBSmBHwhqvKFwkWmkq9O1VQOZjrDPobW552KJX0QUAEKrQzs/UOfK3REe5MJe6xVywKJqC4zOp0u95XMD/yCMFdAix/FjRSbmhOpelEbfceRCHpEytAhMsfijynOKyvOfeUY2o7ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhFKWiT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9607C4AF0B;
	Sun, 24 Nov 2024 13:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455192;
	bh=+SEVPFnWbGasTS3CaQzAyjGOG6Uv4j7pH8wGVB6evMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EhFKWiT4T+l8lFxMMLK1Njo0an9gRANy1XnIp62TVQqNgRrr2NtkTn7zxuDst1KPB
	 so3VMYCoHDmsT4vF22cmqcHnrQdfsVx6yizrGIKP+kBRkze+es5fNGz+WQk5u+QzMD
	 eGPaAqz93ep4+NZ21mWTaOCWoPWoINyDSkMNdauaxOgw/P3UQG7+kM1bByq79meeTg
	 bg13cmCxst3Cx4ChMqdgxAidKHHCy1QEgK0bUbvP+qM3ipX64riVc9JSXgjvSxLl6Y
	 Pb94gBb4d4DmDH2YMbj+xYEoz5aMgBe107I0aThns3Pb13pIqOB+zfA0rMCaqC+xjk
	 9ZPe7QefeRYUA==
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
Subject: [PATCH AUTOSEL 6.12 005/107] drm/vc4: hdmi: Increase audio MAI fifo dreq threshold
Date: Sun, 24 Nov 2024 08:28:25 -0500
Message-ID: <20241124133301.3341829-5-sashal@kernel.org>
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

[ Upstream commit 59f8b2b7fb8e460881d21c7d5b32604993973879 ]

Now we wait for write responses and have a burst
size of 4, we can set the fifo threshold much higher.

Set it to 28 (of the 32 entry size) to keep fifo
fuller and reduce chance of underflow.

Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240621152055.4180873-8-dave.stevenson@raspberrypi.com
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 43f4e150d7267..60cbf1d4c7dd1 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2047,6 +2047,7 @@ static int vc4_hdmi_audio_prepare(struct device *dev, void *data,
 	struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
 	struct drm_device *drm = vc4_hdmi->connector.dev;
 	struct drm_connector *connector = &vc4_hdmi->connector;
+	struct vc4_dev *vc4 = to_vc4_dev(drm);
 	unsigned int sample_rate = params->sample_rate;
 	unsigned int channels = params->channels;
 	unsigned long flags;
@@ -2104,11 +2105,18 @@ static int vc4_hdmi_audio_prepare(struct device *dev, void *data,
 					     VC4_HDMI_AUDIO_PACKET_CEA_MASK);
 
 	/* Set the MAI threshold */
-	HDMI_WRITE(HDMI_MAI_THR,
-		   VC4_SET_FIELD(0x08, VC4_HD_MAI_THR_PANICHIGH) |
-		   VC4_SET_FIELD(0x08, VC4_HD_MAI_THR_PANICLOW) |
-		   VC4_SET_FIELD(0x06, VC4_HD_MAI_THR_DREQHIGH) |
-		   VC4_SET_FIELD(0x08, VC4_HD_MAI_THR_DREQLOW));
+	if (vc4->is_vc5)
+		HDMI_WRITE(HDMI_MAI_THR,
+			   VC4_SET_FIELD(0x10, VC4_HD_MAI_THR_PANICHIGH) |
+			   VC4_SET_FIELD(0x10, VC4_HD_MAI_THR_PANICLOW) |
+			   VC4_SET_FIELD(0x1c, VC4_HD_MAI_THR_DREQHIGH) |
+			   VC4_SET_FIELD(0x1c, VC4_HD_MAI_THR_DREQLOW));
+	else
+		HDMI_WRITE(HDMI_MAI_THR,
+			   VC4_SET_FIELD(0x8, VC4_HD_MAI_THR_PANICHIGH) |
+			   VC4_SET_FIELD(0x8, VC4_HD_MAI_THR_PANICLOW) |
+			   VC4_SET_FIELD(0x6, VC4_HD_MAI_THR_DREQHIGH) |
+			   VC4_SET_FIELD(0x8, VC4_HD_MAI_THR_DREQLOW));
 
 	HDMI_WRITE(HDMI_MAI_CONFIG,
 		   VC4_HDMI_MAI_CONFIG_BIT_REVERSE |
-- 
2.43.0


