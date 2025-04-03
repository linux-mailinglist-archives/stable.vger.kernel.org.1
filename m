Return-Path: <stable+bounces-128115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F393A7AF53
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12F711892EF1
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA8825EF9F;
	Thu,  3 Apr 2025 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pq49ayD4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EC625EF93;
	Thu,  3 Apr 2025 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708007; cv=none; b=kWoUKwdk7/+bwJIGVUkp5YPD+DQpJT2LBnqDHKBLBJvCLzslrqkNJ4cGS3EnbcEjOUhHkvCwT+QPheA84eWT+LqBh1RwpYSxaeKA05202VHcdBea//2SCz1c9yHGLiStymAt5/6fA6EptE9qUZ8APzLSKJoz0w2xbQQ4yaHrMWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708007; c=relaxed/simple;
	bh=DbdOCu8C2UPRFYr3yj+hI9OuY166nAcFAiyTOGAScDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bZDVgcp4qhJ//shlBhEsDQ3VsY6KdoKYsx+iBtHe4MjqlpevAsRLB6zUTY15UGWTMMtRdWUxZkqJCY9La/sVFGeP3DYf2nEsCaGRrYK29OnMMRcO8ObEKZFx01F5Yb2Xayb1Vpu0TavEHflDDxQ9PS1ansBwj8VhA/cGZIZUhe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pq49ayD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89827C4CEE3;
	Thu,  3 Apr 2025 19:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743708006;
	bh=DbdOCu8C2UPRFYr3yj+hI9OuY166nAcFAiyTOGAScDA=;
	h=From:To:Cc:Subject:Date:From;
	b=Pq49ayD4g/Sc/0VrhN6h95cakMKl2p9hNglL6KK+uPbanzZ0Xin7VjwuEMqzn8NuO
	 iMcGofF8+u4hQzPWSXP9DJIQI5eGnQp+vzIwSdXpAW+XFBytpR0FK1aorno6EnQvO7
	 qroIbkEw/hhKUZfvkmVSB6W4ak2Pw3ZTAUtX/tAkU8F6X+PVIAS5PIw2v5Roxlk4PR
	 EuzT+bPSRqzi+0eos1iN/ThpH4hnpftWBs0Lnng1iYH0Sisb7/dBG5EeMHqYy5AtWp
	 Q2TGAWu46uyOzUHy4qe+bBkL2bagbE1bvFwFWFdTfZ9P/d1lrfMc8MGyZSNckNJBmv
	 M6B6BwXMqXshg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maxime Ripard <mripard@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 01/12] drm: allow encoder mode_set even when connectors change for crtc
Date: Thu,  3 Apr 2025 15:19:50 -0400
Message-Id: <20250403192001.2682149-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
Content-Transfer-Encoding: 8bit

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

[ Upstream commit 7e182cb4f5567f53417b762ec0d679f0b6f0039d ]

In certain use-cases, a CRTC could switch between two encoders
and because the mode being programmed on the CRTC remains
the same during this switch, the CRTC's mode_changed remains false.
In such cases, the encoder's mode_set also gets skipped.

Skipping mode_set on the encoder for such cases could cause an issue
because even though the same CRTC mode was being used, the encoder
type could have changed like the CRTC could have switched from a
real time encoder to a writeback encoder OR vice-versa.

Allow encoder's mode_set to happen even when connectors changed on a
CRTC and not just when the mode changed.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241211-abhinavk-modeset-fix-v3-1-0de4bf3e7c32@quicinc.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 2c3883d79f531..bd01d925769db 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1279,7 +1279,7 @@ crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *old_state)
 		mode = &new_crtc_state->mode;
 		adjusted_mode = &new_crtc_state->adjusted_mode;
 
-		if (!new_crtc_state->mode_changed)
+		if (!new_crtc_state->mode_changed && !new_crtc_state->connectors_changed)
 			continue;
 
 		DRM_DEBUG_ATOMIC("modeset on [ENCODER:%d:%s]\n",
-- 
2.39.5


