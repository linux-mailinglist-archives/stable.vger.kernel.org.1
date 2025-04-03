Return-Path: <stable+bounces-128127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E40A7AF42
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06A847A57E8
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3E42627F9;
	Thu,  3 Apr 2025 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHZ842bE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0E62627E9;
	Thu,  3 Apr 2025 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708036; cv=none; b=c8UcTw5TJbcMIaX2Td68asgNLlmPhVWWN0S05r8NVtKUu6/0p3gHwwAw6+DUlcnqmlCtwT2ocbXurulI+rvQlqzmlG4Re1MpAnLDVU0wEPJqAdbuYkkzrjHXcDGnp26S+t0/GOcYWSwvgYy2Rx3edoT1CKmy/a1ms1kZgvVVFb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708036; c=relaxed/simple;
	bh=jY23Tk4fK5CVWwp1mUlGhoY+lfh54DAhBrcJb+UgZuw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z74TqvdWxOeE0EVh4aYG2GkevIY8IfUM5QlcX8Q5yAKkUb8nwhSglsapLVSYcxa5uVjsaNz5E22WNCqCl5NltroeQfC1WfljYyvVed56CkpsD46L9/JUkeCEGarcePbGnevMr5U4Ov8MFgAv1GIrTOZ0MBfY39oRZUwzX8cS7Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHZ842bE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D739AC4CEE3;
	Thu,  3 Apr 2025 19:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743708036;
	bh=jY23Tk4fK5CVWwp1mUlGhoY+lfh54DAhBrcJb+UgZuw=;
	h=From:To:Cc:Subject:Date:From;
	b=RHZ842bE8dacIma4cPMzb11qvI1+8iCP6cd2kKkA6F2dN5nAnx8eZM010d7X9uQ9Y
	 DTY5eazsOIfV0EmdMl5nW9beTgNNUywfPS4Lx75g0pDy76gORgPOe4i+nBklnB5LL4
	 twhcWIvuWIkvHpmOy81CMoqdSzhMH310Hrp/3vPUZeegC9E1AlKBMxrhgybL8n9DSv
	 fFQDgl2iOXWiP5Ng7KPNnh6Hq7cKTVZEpmMVEpvHb9POCmW3RcXmbIE/ZZWMg63U9E
	 73eEdYyhi41aPvEQh+Iy42mfNnHRXM4PraP7Lj1geCuO3c8j4UQ7+32y4my5ekm6PE
	 6Qv9EEHFISehg==
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
Subject: [PATCH AUTOSEL 5.10 1/8] drm: allow encoder mode_set even when connectors change for crtc
Date: Thu,  3 Apr 2025 15:20:23 -0400
Message-Id: <20250403192031.2682315-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
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
index 0fde260b7edd8..dee3b81dec587 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1268,7 +1268,7 @@ crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *old_state)
 		mode = &new_crtc_state->mode;
 		adjusted_mode = &new_crtc_state->adjusted_mode;
 
-		if (!new_crtc_state->mode_changed)
+		if (!new_crtc_state->mode_changed && !new_crtc_state->connectors_changed)
 			continue;
 
 		DRM_DEBUG_ATOMIC("modeset on [ENCODER:%d:%s]\n",
-- 
2.39.5


