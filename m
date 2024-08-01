Return-Path: <stable+bounces-65098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B68943E63
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C491F215FF
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8128114A60E;
	Thu,  1 Aug 2024 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoY+Y6sa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D05214A605;
	Thu,  1 Aug 2024 00:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472413; cv=none; b=MISXELMYkojZCrZqgjEKS4dQuLggxUQqtMlMhBAwgiFsx7HI//6BsvLyt3PCvoq7pNIPL/wMEZP3EWd5ZGlo7cE7XbqgCc6/pC0LWvJVcW37Oo0POVhgBwQn8TMK90p8sYm2bRf89oKV6ztkqT+lLXqYKrqKWHZxaJJPtuf6RV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472413; c=relaxed/simple;
	bh=U/M6qwBDdOL1CB5UND0iBIgoeGnYnNqGW0sMvybSHp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeTRlpz9Ywl+SxEAE+CDUga3I1h1miAdX54LTMQzpJM4tfTck8MAKB/DWHpSHhCxiv++HVwMLv8Pum0gpzayeq7ktlbbyIHWM9lGPy+oi5s9YxU1idvniRyz5YV3EILlqPBMEA2YLUB9TlzDL8qn7xEs9m18lgwEfJbcoJ4MuQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoY+Y6sa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800AAC32786;
	Thu,  1 Aug 2024 00:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472412;
	bh=U/M6qwBDdOL1CB5UND0iBIgoeGnYnNqGW0sMvybSHp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZoY+Y6sapbukTGLbZ2LMU6PGyxTK1rmvqwZI/sYBUhkabY/GBUmviQ4kCSTGJBJnL
	 26qdYaA3e9bE58Y7hEin4EpNgFbrX1cU2LwSE9p6CpsZaan+ghvLX+fiF6YZzM7Ma5
	 fIjWA1Zj/Dyxy7Pv/fZ4MlsCKCEpoddxhQ9n466J9MmwfaOdlJtV6kad5D0dA4zKCE
	 HYohYoIj0JSg2/U9QeM2XCwImx+sdjFs55mMFWb/7M4WpOYcBrCzSHkY984bwp2wOL
	 5zd65podHgTKqedw9KxWDDM9xv83UXvYPIrd43ul1aDEkNitN7Nq1uLzcbvNojTkwg
	 ZRCAnGfTYU3hA==
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
Subject: [PATCH AUTOSEL 5.15 08/47] drm/amd/display: Stop amdgpu_dm initialize when stream nums greater than 6
Date: Wed, 31 Jul 2024 20:30:58 -0400
Message-ID: <20240801003256.3937416-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index b821abb56ac3b..4b85885e4ddbb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4210,7 +4210,10 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
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


