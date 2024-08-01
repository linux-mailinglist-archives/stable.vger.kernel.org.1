Return-Path: <stable+bounces-65143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18A4943F1D
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9620A282CAC
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D781BD4F4;
	Thu,  1 Aug 2024 00:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXC516uC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59651BD03D;
	Thu,  1 Aug 2024 00:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472631; cv=none; b=IgPLj2Sn/26Xf7XiL1uwu3B0LvhijPLiVHYEkkVUwoIUbENpGEV9wxZB45NMtW7DbrxMIfIItENpUcQ5NxOWGExG76C/vJCU0xKVVqfFtKKsDi0eVcHnUIoxJ8m0VmrgDFX4cFKJlw0QUXabtrPNko42LHdEM76OZnormBcXPVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472631; c=relaxed/simple;
	bh=eIHymcHKcLWeyqcn1rbwyuynACfOYNjx6gDZeGCBu+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lj6mlXzCZuJrRybVva/Fr8nCOFovpTmZch/nM0C17JibMtmOD+jWK8Uk1116zJMZ5hlG6AyfZM+GPJA4wps+EzT58jgVCSLsYHfkoBBT6zYVfZqATvCge/xUTcwswvFgeBSBK54sAd902ZWD3GzJmJE+CTCbD39nofE5fMdjSwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXC516uC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4572C116B1;
	Thu,  1 Aug 2024 00:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472631;
	bh=eIHymcHKcLWeyqcn1rbwyuynACfOYNjx6gDZeGCBu+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OXC516uC1a5fad2+dnOrmWoJJJv2FNisKTqXB8pUjQz/UakmqRYwUxWEjQsQ/9mcw
	 objMvFlA3zUj1Pyb1uKuaHwwFS5fjV3Uoowu7iTvM3zfyfAOC/tgP8CqFKiLlT/DMb
	 Th+Oqte0TvRY3aVo/SUZvQo2PKWSeUHrIy4N2ig6cesEK79PTn1rSdqJW0mtc4J5zi
	 KAl1nH5g2IOSpmmP13f8q5zPjcNLxrBsWTiE/h/Qtrl7DeepmtUdFEF/g3tz8qAqGB
	 8rRXgFkxlavwMbfSV8dVnDgFb7jUxYFL6Fzi487pupC3oW5Yo5i6NYJa8zg9mqlutH
	 CiFIndBmzZW1Q==
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
Subject: [PATCH AUTOSEL 5.10 06/38] drm/amd/display: Stop amdgpu_dm initialize when stream nums greater than 6
Date: Wed, 31 Jul 2024 20:35:12 -0400
Message-ID: <20240801003643.3938534-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index 29ef0ed44d5f4..50921b340b886 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3341,7 +3341,10 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
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


