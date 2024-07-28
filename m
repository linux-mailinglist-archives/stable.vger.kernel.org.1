Return-Path: <stable+bounces-62160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396E793E641
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3CE1C2124D
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CAF7F487;
	Sun, 28 Jul 2024 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwYVQqD3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4998F768EE;
	Sun, 28 Jul 2024 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181440; cv=none; b=Xk6CHA4YTfQ9SvMZWgLGYGMEYoUWtpR2vE/oh8SscDihYyVkfdEuTeujfTJVhtqTSq6suQDToR+R8f12BPnbGjpUPhOz41coSKeirIOPcC/NNws6OIThwJ/NMAyW1nubJq7YKRWkqq3+6r6P9jqHpe6Mt4vIPZ02zVABm1gQ4v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181440; c=relaxed/simple;
	bh=Tst4WHHCamd3ae+R1a1DtMZHKP0OgRso3Ogrs1SLQNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuX8rOVkGHtU9+V6TO0K/la5BTp8iDiVHsEQttYG8v4/0kcSi2RjBBFvKyquQUxbDqLevkFoHQQq9KDBh0Pq5pnXn69WNAmShLJWJeiRp7UTaBdtrjDfpxFX+j5qsqexmmpd0KblW7Ioy+ypqm4DPepHvWmT6Av2xpzJWnePT6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwYVQqD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D142DC116B1;
	Sun, 28 Jul 2024 15:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181440;
	bh=Tst4WHHCamd3ae+R1a1DtMZHKP0OgRso3Ogrs1SLQNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pwYVQqD3Kt80OXCBQHGoC+CbIIYEeAToweuTfOBljhRN398NLIrmsRMMpPPOhtBkN
	 HttNMHSU1KKC6nb3zNJwfYo9Ukh1R9HhJR9DI3w6q5yf2qFLu2Htqnbw+B1JgRszV9
	 LjsnezKtmUPU2GiITDIUBAgOKe5ymlTkacXuA83DEUefopqqKhodLSq3aYoSCpeygq
	 smgN7ZNa7i6LQjX0KpVAfaTdPPuEp3GBWmmD8k4XpsHegmLU1lnQ74xQKA/HGgCCy7
	 jlPBZ3yq7rGRa4BIigzB257DjkmRNc7DgvWFHR799AYg9PMdKdUVloVyGsS91BAuyG
	 MvzXo3zcCVeuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Roman Li <roman.li@amd.com>,
	Hersen Wu <hersenxs.wu@amd.com>,
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
	hamza.mahfooz@amd.com,
	Qingqing.Zhuo@amd.com,
	Nicholas.Choi@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 16/34] drm/amd/display: Add NULL check for 'afb' before dereferencing in amdgpu_dm_plane_handle_cursor_update
Date: Sun, 28 Jul 2024 11:40:40 -0400
Message-ID: <20240728154230.2046786-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154230.2046786-1-sashal@kernel.org>
References: <20240728154230.2046786-1-sashal@kernel.org>
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 38e6f715b02b572f74677eb2f29d3b4bc6f1ddff ]

This commit adds a null check for the 'afb' variable in the
amdgpu_dm_plane_handle_cursor_update function. Previously, 'afb' was
assumed to be null, but was used later in the code without a null check.
This could potentially lead to a null pointer dereference.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:1298 amdgpu_dm_plane_handle_cursor_update() error: we previously assumed 'afb' could be null (see line 1252)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c  | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 8a4c40b4c27e4..918c880739a2a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1231,14 +1231,22 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 {
 	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(plane->state->fb);
-	struct drm_crtc *crtc = afb ? plane->state->crtc : old_plane_state->crtc;
-	struct dm_crtc_state *crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
-	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-	uint64_t address = afb ? afb->address : 0;
+	struct drm_crtc *crtc;
+	struct dm_crtc_state *crtc_state;
+	struct amdgpu_crtc *amdgpu_crtc;
+	u64 address;
 	struct dc_cursor_position position = {0};
 	struct dc_cursor_attributes attributes;
 	int ret;
 
+	if (!afb)
+		return;
+
+	crtc = plane->state->crtc ? plane->state->crtc : old_plane_state->crtc;
+	crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
+	amdgpu_crtc = to_amdgpu_crtc(crtc);
+	address = afb->address;
+
 	if (!plane->state->fb && !old_plane_state->fb)
 		return;
 
-- 
2.43.0


