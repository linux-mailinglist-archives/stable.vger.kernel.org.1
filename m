Return-Path: <stable+bounces-128072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A577FA7AEE8
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1030A189D4BB
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC39227EAF;
	Thu,  3 Apr 2025 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6k4O5gJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E00227EA0;
	Thu,  3 Apr 2025 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707901; cv=none; b=Z7oOgHEOxKeyYssRojPZ5AxeJKv4RI9eWHWK21lXr0WLs2xLZyyJmUTclKIb2MRTElCbaBUvz4ctHASIidmdNSSz5Lg7Wl6/1BX07it6VMwXTNjRbB8AE3Pa7j6T4N1LM7UJ177fR19UFr5j7aFt3OKP9NGAcO4QnzxteN1zGRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707901; c=relaxed/simple;
	bh=6G55NMBSzBPke3/x+W4yLOHysx1XiBrKV3Gi+nsYFTA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S7HGrhg13TDKBcTn9xpBw4HHP9JV/8eq+Bf45p8FmbByTvJsgZR3/eJ2cRhzrC1qrRIWPvUd/VP3dlSrh5y0K8uLe4TLkp9zjDuS0Nj+4pBuSiy8GN2XjvO8d/WhB663QdgeNhNut5XSE0zRJbAHP9eNd/AH74pNvMOzijIaz+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6k4O5gJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C00C4CEE9;
	Thu,  3 Apr 2025 19:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707901;
	bh=6G55NMBSzBPke3/x+W4yLOHysx1XiBrKV3Gi+nsYFTA=;
	h=From:To:Cc:Subject:Date:From;
	b=g6k4O5gJ3XnPJZTfR0g/KKQAeg6ozKMtEjgNu9wFZBhcuw8BNf/AqqRjZJiz/qGiY
	 C6gYy3TOLiKzKVkVTmgRMPEwuba1KXRdUaxRY54dbZclsO2dVZjt7hGEo9qfg4Y+OF
	 x7ct3xXLnZ+Ji+1n9L9DF6zn/VmKSE+2icHrXAEe2hVVyNXIp0kGOCX5tCcRe+8ePE
	 VusCikSJ6/XtAmQpLyd5ykc1kzXITfs0TZ8uX1RzjxDIc5RnPEtvCy5IrJT0TU4LQF
	 po/5boGtfWyTdoPCpnSoxMduJF6ofE5QcCTZCVmSMl7mc4ToIforFgTHKu+RSU6wGa
	 d3QJuk7cpcnBw==
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
Subject: [PATCH AUTOSEL 6.6 01/23] drm: allow encoder mode_set even when connectors change for crtc
Date: Thu,  3 Apr 2025 15:17:54 -0400
Message-Id: <20250403191816.2681439-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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
index 554d4468aa7c0..f3681970887cc 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1373,7 +1373,7 @@ crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *old_state)
 		mode = &new_crtc_state->mode;
 		adjusted_mode = &new_crtc_state->adjusted_mode;
 
-		if (!new_crtc_state->mode_changed)
+		if (!new_crtc_state->mode_changed && !new_crtc_state->connectors_changed)
 			continue;
 
 		drm_dbg_atomic(dev, "modeset on [ENCODER:%d:%s]\n",
-- 
2.39.5


