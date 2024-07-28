Return-Path: <stable+bounces-62190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDF893E6C1
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AB911F24A7C
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E0613E3E7;
	Sun, 28 Jul 2024 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvEnnHzH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B2978C7A;
	Sun, 28 Jul 2024 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181630; cv=none; b=VrFR/zn7ZR5k0lgkE2TloiDz7jc+8CdO/czqUmbAm6anUwCXNW4vCV1wm26UJxmOKspozucv6O20FqeVwSi6lkmTIHgdwjkKoTRdgXhcbk+hWGQtL+iMk8rhZ5d/yRqMYo7y9C7IahukRgscPBb9s28RfXWXcOdabE6ALmsoTSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181630; c=relaxed/simple;
	bh=8w5R5fcdDjRyKHGWoORciPpmcOKJ9u6P7eE6Ez03pdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FiaHglXeck9ulR4s/X20n1AB1FKFwVdpm+eLshgn7+176HX4n4oz6uv33r2v7nHVz3/0IMa9z/ea6cD7XljA80BJjFBp2muCiI9R7yOQMCFqDQXklu+Ao/4tlfgQMbneigxsdbH9L1t6T7FprgWFl2c3TC5X9wmLwMrtf/9C0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvEnnHzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6F4C32782;
	Sun, 28 Jul 2024 15:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181630;
	bh=8w5R5fcdDjRyKHGWoORciPpmcOKJ9u6P7eE6Ez03pdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TvEnnHzHDEQFwY24jPMXAJhFYNxijlW4oIMLR3nyRqtA0QEO0YfEEf1E6Kai4Vn4I
	 Vd+mnXR9dZr1rr+lAuP1o6hKcn3X2jVqB3gGlm4lkHdFIDZ/Cvkbfi1T3vvGI6YF9i
	 mUvjergexTBH2VBK+VGmTI+guNhFeUhK8+Z4X7zD7T6QM2dojg6XcuqPP6zow5Kzqm
	 jAUmVZgU7ILKfIJIw4SOSsShvAa7zT7OIwvQDsdOrfeRGKK6wBFHFOIUvk2zoD8caF
	 XStQmMeJIjTuuoR8wdnTQHqcAlM5hGyYTecFWxWPwdDaDS8g1tm0WyF3k62aZobV2P
	 EYaDZ07EpdeXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	roman.li@amd.com,
	mario.limonciello@amd.com,
	joshua@froggi.es,
	wayne.lin@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 12/20] drm/amd/display: Add null checker before passing variables
Date: Sun, 28 Jul 2024 11:45:10 -0400
Message-ID: <20240728154605.2048490-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154605.2048490-1-sashal@kernel.org>
References: <20240728154605.2048490-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 8092aa3ab8f7b737a34b71f91492c676a843043a ]

Checks null pointer before passing variables to functions.

This fixes 3 NULL_RETURNS issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c1a0fd47802a0..f66e2e89892f8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2628,7 +2628,8 @@ static int dm_suspend(void *handle)
 
 		dm->cached_dc_state = dc_copy_state(dm->dc->current_state);
 
-		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
+		if (dm->cached_dc_state)
+			dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
 
 		amdgpu_dm_commit_zero_streams(dm->dc);
 
@@ -6483,7 +6484,8 @@ static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 		aconnector->dc_sink = aconnector->dc_link->local_sink ?
 		aconnector->dc_link->local_sink :
 		aconnector->dc_em_sink;
-		dc_sink_retain(aconnector->dc_sink);
+		if (aconnector->dc_sink)
+			dc_sink_retain(aconnector->dc_sink);
 	}
 }
 
@@ -7296,7 +7298,8 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 				drm_add_modes_noedid(connector, 1920, 1080);
 	} else {
 		amdgpu_dm_connector_ddc_get_modes(connector, edid);
-		amdgpu_dm_connector_add_common_modes(encoder, connector);
+		if (encoder)
+			amdgpu_dm_connector_add_common_modes(encoder, connector);
 		amdgpu_dm_connector_add_freesync_modes(connector, edid);
 	}
 	amdgpu_dm_fbc_init(connector);
-- 
2.43.0


