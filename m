Return-Path: <stable+bounces-64837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD02943A9D
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8521C214CB
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9B9131BDD;
	Thu,  1 Aug 2024 00:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NP0sj2TU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC2F26AE6;
	Thu,  1 Aug 2024 00:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470976; cv=none; b=hGxaxcTMjTxFs17iMMgHUekn6aQIXHB99V+XYEQll3jJMKAQWShWAqPwlRjPqnKDSLFckIeC7lSZsrNMeGCp5jURGjZugmgwkmqw18thYYUDYdYnH9MvIei4o71IFZFl1nJUYS3Xf3243OaOTFF05cHMXZ0vNp/DRsBFfcd62Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470976; c=relaxed/simple;
	bh=w7QQNe2svEeQIEK0b9v3+6bRgR/Nld29VT8pup+EO48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1OZxQCaXkMu39KPqwkxWAPqJ9E2YKhtCJXTcaxLMNdYBbN9dAT3LvCW4QAyXuCH/863s3wF18HnH+aeLZ+vOTg55a9Xsm0aqCqvEmMJ1zxQT064OvNO2ErSMb9fpNMayPDvTCq32Nu/xQgAVbRc/GSoQcc3TjBxhcQ0wLeRt7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NP0sj2TU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEC8C4AF0E;
	Thu,  1 Aug 2024 00:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470976;
	bh=w7QQNe2svEeQIEK0b9v3+6bRgR/Nld29VT8pup+EO48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NP0sj2TU/UqicBnb7j0s4dgSAfMi8ZDOiPZTO+uxXdofPQTgD365JKPTG+LmXgOGQ
	 rJU48R7Dynd8oWpe5zOEyBQztbXOC/4RhQps/TRoanLZkS4nI0SDDlYWJYT21xbS1v
	 vSZb2CJHBgkma5LL+xW4MV/giwdE70Zjj4IEtD5oY5KWdiH3Bng2irQ0HawH2/Nnwo
	 JCaARf+YeOQ4uMtm+wIV22PDYJt3qA8D/lBn2WdsiQlkIca9+NQUVYElNQ2U/ZsImh
	 foxhk+cfSk6MWS1o0woXWYiTbJesz8vM0os3t0q/FZsl2NX5TiAMOscAkRZ3uxCONT
	 lx/7o0Ox8pv6A==
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
Subject: [PATCH AUTOSEL 6.10 012/121] drm/amd/display: Stop amdgpu_dm initialize when stream nums greater than 6
Date: Wed, 31 Jul 2024 19:59:10 -0400
Message-ID: <20240801000834.3930818-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index e9aac7f7cfdce..9b440b26c6505 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4543,7 +4543,10 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
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


