Return-Path: <stable+bounces-77640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D146985F69
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49677285D0E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FCC1D2B2C;
	Wed, 25 Sep 2024 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ft2P9apU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982D31D2B0B;
	Wed, 25 Sep 2024 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266552; cv=none; b=l4+opMZ8J1sYq1VUCmlmDsaBXXKVBGDh5UVl5lDxaG4Ow7uBRcH6jx73WGWCa88rQZ4fHrJin6qoDTPTVOw02+6B24x62UhjZiZQ/LnA5Zs5C/24TuCnvpMCLFHxFU4nSB9mGDPWDVdSARX0lk5OW37xKPnoYPzKIY5Xd42DVCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266552; c=relaxed/simple;
	bh=DkShh8XJWfajgEmVNTX/trnqo8P75F1KlP9+NpBv6CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QW5Kl8uNCaWx4KCR8ak/6vOQkXg+ejTBqbftd7DWkutpJu4H0MyAORDLRnied9Z5i1ai+7eXTYN9Yhk8qiulqddraYcUsKr19Ql2p2yfqb4Uvb2ZPnutDxemypfJCXufxk3n8HbgSzAyduWHoRr38mikszZxT2CH34GsULAdjZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ft2P9apU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF37C4CEC3;
	Wed, 25 Sep 2024 12:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266552;
	bh=DkShh8XJWfajgEmVNTX/trnqo8P75F1KlP9+NpBv6CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ft2P9apU5vDzdo6v0/3vCTc1Esldgqlj0gihCxs8hNhEGq/ExwNVc/AkkcSknsaam
	 hTP/ZO4fVBCkB2L+YKMIcMF4+kP7bmDRhDqjVueG44c1Lb8jIc7EbmmoBYbX7ETK65
	 PQrGhy8/Fkht1m44xupSumAWGx7DrNnkSoEE00nzUkLpxXWRj1Mx4oM8j8g+hEC2Y4
	 OLijUw9mge6JWtZPVn+rMMr8wqtz+Uaowo3Os4Wbe2KHzxrCmd9U7nr+6YxRoC2xZK
	 qJ9vleeAIV/s8pDH36cYuYGOyNrnsWJjjvC434RgfhnG7sUPipoKM1AfnliBHo7XrY
	 C9V78fqmJT4VQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mwen@igalia.com,
	joshua@froggi.es,
	marek.olsak@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 093/139] drm/amd/display: Add null check for 'afb' in amdgpu_dm_plane_handle_cursor_update (v2)
Date: Wed, 25 Sep 2024 08:08:33 -0400
Message-ID: <20240925121137.1307574-93-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit cd9e9e0852d501f169aa3bb34e4b413d2eb48c37 ]

This commit adds a null check for the 'afb' variable in the
amdgpu_dm_plane_handle_cursor_update function. Previously, 'afb' was
assumed to be null, but was used later in the code without a null check.
This could potentially lead to a null pointer dereference.

Changes since v1:
- Moved the null check for 'afb' to the line where 'afb' is used. (Alex)

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:1298 amdgpu_dm_plane_handle_cursor_update() error: we previously assumed 'afb' could be null (see line 1252)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Co-developed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index fa9f53b310793..d1329f20b7bd4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1281,7 +1281,8 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 	    adev->dm.dc->caps.color.dpp.gamma_corr)
 		attributes.attribute_flags.bits.ENABLE_CURSOR_DEGAMMA = 1;
 
-	attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
+	if (afb)
+		attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
 
 	if (crtc_state->stream) {
 		mutex_lock(&adev->dm.dc_lock);
-- 
2.43.0


