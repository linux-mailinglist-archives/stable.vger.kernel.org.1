Return-Path: <stable+bounces-59449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA5E9328D6
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894A61C2186C
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8621A0700;
	Tue, 16 Jul 2024 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMpbDqEa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA119D8A9;
	Tue, 16 Jul 2024 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140067; cv=none; b=RiZJrgz3n7i7An467v8nkIR1bpJ2w+JRJ1zVcvRxeBDQifXttPAMGjnmcjIExd+3+L7TNWbUQLxoW6vkwpCKVNxAhVMQio408crFJMkf0n8i2mO+9DTJvZJsGO7CUwdOLM+UqzfCV+fLMRhOERDiNapJ8Ly8pk2w/OBYm6s37kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140067; c=relaxed/simple;
	bh=ZgkkHsHE/75SC2ff7WEeeFJjsv482GEMLDFH/s5vuMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAQ6GMrjfWr6Bk0Q71wM09uzGtVDN/yRX9453Doduk2FeX0n09oJoQiTXXU/skiyjXvz+fhM3VHjNbvwBJnKehgb4kSBddfPxnczwMJEXelKJQYgv3Z9JCalt8mgcgxOlXgNueyDpVMJcmOYmEzl36fkL/sg2MnaNVyiNF3pXM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMpbDqEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311ACC4AF09;
	Tue, 16 Jul 2024 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140066;
	bh=ZgkkHsHE/75SC2ff7WEeeFJjsv482GEMLDFH/s5vuMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YMpbDqEaCBj0ALbXalFzpAsnwBXnCIoQMCudyfmwn4mEGae1Vysg0gtZiwqvaoJbA
	 Nll6TdsnOtlgieZXyBQG8+YXACnTSRT08+mO1dgB5XVCsk9UK6bBkxhdMXc5Nhau0v
	 54P8+lQDLlSHaSCxY4e9yK2MPc8uX131urcZE+w3EWCbAbt3oaoxgtuNgrGuhA9+vt
	 dmVEpKMc0kIE720gf9VKcIMrmVyGy0SWX8nQTkuSipwOxTqDJmTfANhFjLhJ4iB8xx
	 ktoIjRTJTH450A8ELRd/e5Q2Bg8GV0iApKeulxVJ/GtqnRgeUKdJXCOi3DEfHe/Sd9
	 8skqqDVLHLLJg==
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
Subject: [PATCH AUTOSEL 6.6 11/18] drm/amd/display: Add refresh rate range check
Date: Tue, 16 Jul 2024 10:26:46 -0400
Message-ID: <20240716142713.2712998-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142713.2712998-1-sashal@kernel.org>
References: <20240716142713.2712998-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.40
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
index a1acc8108586f..023fd3945e47a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10760,9 +10760,11 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
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


