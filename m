Return-Path: <stable+bounces-141737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12249AAB7CE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31BF4C6440
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22A934EC58;
	Tue,  6 May 2025 00:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcbL4Xbu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734562FC0EC;
	Mon,  5 May 2025 23:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487451; cv=none; b=rt/bGVFNLv8dvd+U5vk4VGzgMT51TdbxbYDX0Z28iUvcmhH06QGOR+BUYu7OJp2EjdEUYcnz8ydVDhzASPpdezo3fRUvBxFFvMuVXZg9NgieEBljlOlh1HHbN/uxLpf6/gO3f/H4ClrsmddJr2gWC7xttNmFvfBK826NSp1/1Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487451; c=relaxed/simple;
	bh=i22rMXdaaCX2nMsxb00wU60TfhaQ8tXx58+iF125btM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HgY+JZGBtI5xKeLY45om7PSC74NQy7Hu3LcTy4Mww7o5LvhVZWNvnKTAT6h3VAM2bBbQw1q9l0bYkyYFwSsgkidoCofBRgydf5Skq6FOzDzuSb7WH+1lm/Tr4F/5wLhITsDDE2WeyFoKCGZ+J6X/UUqfYCaUyELnSoOvPpK5NbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcbL4Xbu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75AAC4CEED;
	Mon,  5 May 2025 23:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487449;
	bh=i22rMXdaaCX2nMsxb00wU60TfhaQ8tXx58+iF125btM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lcbL4Xbu8lplE07+huzT2WmvCwbcY3pQZUxLur9IhDyeZxHeR7E4wJToUPm7jkk+s
	 YwKeyd9BExFgV0xiX1sKKiRT59zgPNrwssgeqspUxpMoV+J01t3/4cFYkA2T2x4V2I
	 t6phRrXDy1bZtWAJnY25Ju/nLcZpOWxEyA0KbQdb5QWUWui0+AaD/v5ybQGqPqlths
	 uBmGCduXiK0CcXgGVUgjfJOkpRzirWrGVNdatwjx0s0CYwV9/daxIF9p0EO9xVtDCa
	 WJ0Lf/47US8/m0hoXHlwTtBAzvDBXXF1gZ74ebKxG/um2b+vp3RlYA2BD1kHYqpwvq
	 Hq23glDoxz6+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maxime Ripard <mripard@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 79/79] drm: Add valid clones check
Date: Mon,  5 May 2025 19:21:51 -0400
Message-Id: <20250505232151.2698893-79-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit

From: Jessica Zhang <quic_jesszhan@quicinc.com>

[ Upstream commit 41b4b11da02157c7474caf41d56baae0e941d01a ]

Check that all encoders attached to a given CRTC are valid
possible_clones of each other.

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241216-concurrent-wb-v4-3-fe220297a7f0@quicinc.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 70d97a7fc6864..678dba387d838 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -561,6 +561,30 @@ mode_valid(struct drm_atomic_state *state)
 	return 0;
 }
 
+static int drm_atomic_check_valid_clones(struct drm_atomic_state *state,
+					 struct drm_crtc *crtc)
+{
+	struct drm_encoder *drm_enc;
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
+									  crtc);
+
+	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask) {
+		if (!drm_enc->possible_clones) {
+			DRM_DEBUG("enc%d possible_clones is 0\n", drm_enc->base.id);
+			continue;
+		}
+
+		if ((crtc_state->encoder_mask & drm_enc->possible_clones) !=
+		    crtc_state->encoder_mask) {
+			DRM_DEBUG("crtc%d failed valid clone check for mask 0x%x\n",
+				  crtc->base.id, crtc_state->encoder_mask);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * drm_atomic_helper_check_modeset - validate state object for modeset changes
  * @dev: DRM device
@@ -724,6 +748,10 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
 		ret = drm_atomic_add_affected_planes(state, crtc);
 		if (ret != 0)
 			return ret;
+
+		ret = drm_atomic_check_valid_clones(state, crtc);
+		if (ret != 0)
+			return ret;
 	}
 
 	/*
-- 
2.39.5


