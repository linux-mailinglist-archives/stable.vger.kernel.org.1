Return-Path: <stable+bounces-65178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC097943F75
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B841F229C3
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21B41C2326;
	Thu,  1 Aug 2024 00:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNNG2ej8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9CD25760;
	Thu,  1 Aug 2024 00:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472771; cv=none; b=F0sEuSCJiPC398llc52SKQOoyAnqeHIPs3XGRUG6xYUeYrJRB/KxuxoP6VNH8bn6LuCT1+q+wk/0t+nEYz6IecTzNqMTELEq345WHry+gD4n8yTJNxsl7VWq9loAfnDALmK6Yb3RUPyzwyTU2z7kkgj3ksaeZ2Fid1DbaKCTj5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472771; c=relaxed/simple;
	bh=YUOKHtCGRMiJcZsp1siXNPvJs6Y1pBOnUG+ESB4yCrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRhgnSV4DZPjS+Oe5ZUrBykmTrsQx1PMOfIhUvzWBRFIB1TfRlL96bPY4xgj+N0HZvF2heSqV8mR3D1HciqYQXIh/My3Qs1DOfUiFuBsqdop7rZjTrd5QwJxoMyJ1qtmbcpRkP/YET3DximHN6ChEksCenkQdBMmOWk8UHQ0CTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNNG2ej8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2727AC116B1;
	Thu,  1 Aug 2024 00:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472771;
	bh=YUOKHtCGRMiJcZsp1siXNPvJs6Y1pBOnUG+ESB4yCrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MNNG2ej8g/hVolVWaH9up1VTC4SVQjP9DUgX6NQwITvuqb+dNxG1aZJ9nJk+OtIKM
	 x/pYSjN6AM2pvclIFv0lQA7U+0Hn9LFrZE5FIHSUOEN/BKGs2O90MJrXbUCXNGzwUu
	 8wFsIzL5iSvsSKs2VtC9hQTT0CPmEvbSw0t3KJ/1/jaI4rmGp/DGmbem2Mor3WwpOi
	 C+dFT/PF7xc4S7hctv5HwrcWp6RpXf6CQFG4aVD5D+37suNYoth1/YXEjmGH3qyUgt
	 itXLSLOqD2IOHNg2fE9xMFzhlyEcRIxeP8f1xSkrjr8b/zSmn6XvkWbedVq8GPLQqN
	 U/ogCEE6lVh4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hersen Wu <hersenxs.wu@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alex.hung@amd.com,
	hamza.mahfooz@amd.com,
	roman.li@amd.com,
	mario.limonciello@amd.com,
	Wayne.Lin@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 03/22] drm/amd/display: Stop amdgpu_dm initialize when stream nums greater than 6
Date: Wed, 31 Jul 2024 20:38:32 -0400
Message-ID: <20240801003918.3939431-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003918.3939431-1-sashal@kernel.org>
References: <20240801003918.3939431-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
Content-Transfer-Encoding: 8bit

From: Hersen Wu <hersenxs.wu@amd.com>

[ Upstream commit 84723eb6068c50610c5c0893980d230d7afa2105 ]

[Why]
Coverity reports OVERRUN warning. Should abort amdgpu_dm
initialize.

[How]
Return failure to amdgpu_dm_init.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3bfc4aa328c6f..869b38908b28d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2263,7 +2263,10 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 	/* There is one primary plane per CRTC */
 	primary_planes = dm->dc->caps.max_streams;
-	ASSERT(primary_planes <= AMDGPU_MAX_PLANES);
+	if (primary_planes > AMDGPU_MAX_PLANES) {
+		DRM_ERROR("DM: Plane nums out of 6 planes\n");
+		return -EINVAL;
+	}
 
 	/*
 	 * Initialize primary planes, implicit planes for legacy IOCTLS.
-- 
2.43.0


