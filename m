Return-Path: <stable+bounces-59428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC124932887
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29BA01C20B28
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741B619DF6B;
	Tue, 16 Jul 2024 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Du9dcPuq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F9919CD01;
	Tue, 16 Jul 2024 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139957; cv=none; b=Ke8opdXDjA+h+zsdPBQWwX1c63jwvy5wZyX1cdl9dCMIyRhmEk1k+oTxa2yyviQqxqlZRdCtMvY59wPeCoIO7cClOPIy4dr15m/faFt7RONuLzelRxoM2DWbGwIRLty+pt2jwX9JAkOZhCF5iS145ZqjZOcIlT7BoZd7WFPHf20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139957; c=relaxed/simple;
	bh=L9vw0SOo7zsmSC9f3Fyo4092LaNKWbBAXxFqQ2talOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoPYZFgtGnlBB4vaT1igBbVqri5tgiN4PLT2K8Plh7UT2xsdegMPF/nrCzfWktflNLzFz/d1Lh++nINIk7cowblGteMn3uYAm+gjpNwG7kewD+OYya4O0e2yYWRvjPW1TBZvyrA5rSne9rxeS7M27G9D7zYe/0DmBgAlFzHE0wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Du9dcPuq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236E1C116B1;
	Tue, 16 Jul 2024 14:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721139957;
	bh=L9vw0SOo7zsmSC9f3Fyo4092LaNKWbBAXxFqQ2talOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Du9dcPuqBnXxf+wpWZuhcBsKdFkLhJb905h5Dqs4qXH2FSNOAWwIZRR2d6itWA2bE
	 5B67JVKGp3IaGltTYsHQIXuS3H0cJ5ZV9pkCQ6Ksd5oxDDndLzIL+nKsg6TPV++MrW
	 upOhQV0Ptcw2JJNLBcW+SzUtwueJkOHh3a7ipoFD5v3homhWiO11zsHwXS45OyoSsi
	 aIHgLJPsndAvCb3m/EVpR5BCHQIptHYP2p/PPMjMapuMHYkth4q8HVhn2uZ5zF1Oz9
	 0gaE9a9nNgdP2INHZWCfB5qch39ufckUiNA8FOx95JLut5KjJS7PCxVuzFxPqMJvT/
	 DXi2EsWcMDu/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tom Chung <chiahsuan.chung@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alex.hung@amd.com,
	hamza.mahfooz@amd.com,
	roman.li@amd.com,
	joshua@froggi.es,
	wayne.lin@amd.com,
	srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.9 12/22] drm/amd/display: Add refresh rate range check
Date: Tue, 16 Jul 2024 10:24:19 -0400
Message-ID: <20240716142519.2712487-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142519.2712487-1-sashal@kernel.org>
References: <20240716142519.2712487-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.9
Content-Transfer-Encoding: 8bit

From: Tom Chung <chiahsuan.chung@amd.com>

[ Upstream commit 74ad26b36d303ac233eccadc5c3a8d7ee4709f31 ]

[Why]
We only enable the VRR while monitor usable refresh rate range
is greater than 10 Hz.
But we did not check the range in DRM_EDID_FEATURE_CONTINUOUS_FREQ
case.

[How]
Add a refresh rate range check before set the freesync_capable flag
in DRM_EDID_FEATURE_CONTINUOUS_FREQ case.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 53a55270998cc..6f43797e1c060 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11290,9 +11290,11 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		if (is_dp_capable_without_timing_msa(adev->dm.dc,
 						     amdgpu_dm_connector)) {
 			if (edid->features & DRM_EDID_FEATURE_CONTINUOUS_FREQ) {
-				freesync_capable = true;
 				amdgpu_dm_connector->min_vfreq = connector->display_info.monitor_range.min_vfreq;
 				amdgpu_dm_connector->max_vfreq = connector->display_info.monitor_range.max_vfreq;
+				if (amdgpu_dm_connector->max_vfreq -
+				    amdgpu_dm_connector->min_vfreq > 10)
+					freesync_capable = true;
 			} else {
 				edid_check_required = edid->version > 1 ||
 						      (edid->version == 1 &&
-- 
2.43.0


