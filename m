Return-Path: <stable+bounces-110556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAB5A1CA16
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8153C3A8D5C
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EA01B07AE;
	Sun, 26 Jan 2025 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTuSmWzP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9B919049B;
	Sun, 26 Jan 2025 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903347; cv=none; b=NcVWFKKdrZU5uZYrXKdByYaRLZZC7tDuPPY4NIhDkPksWK2A0MjJeUDMFnXLUNA2IHN9aD0MnUc4Jo6/gRHY/ylq+NgkQNvNDNxYfh231aKpxXuIFSarYDDHRzPWqhiF1MTdyrCpeBqx3Nr4vCQBhuUPY5HiDUQ6DSXqeAAqKiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903347; c=relaxed/simple;
	bh=r/cMiaq5Oeg0Vio/i16UwG1HIl2dfnKz1i/Pkqa/iSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N3xY8dko3vIKup2sMN8VSeMVZyOCVVnxr9mOOs5KqJCyEPus0SQ3JawhSbm+9jYhWn7bOFxSUBLTcofnWaCikq/UT/m49/SnwXrdk4TOWwMwuMOxeIkcS2mK4+zDUmeLxbBl4a263kYIt4pinVgoTiJYWKAdGPgax4XNLR90snM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTuSmWzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0C7C4CEE3;
	Sun, 26 Jan 2025 14:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903346;
	bh=r/cMiaq5Oeg0Vio/i16UwG1HIl2dfnKz1i/Pkqa/iSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kTuSmWzPreYLv8CQyIo9TTei0+LOo6ezH++ec7TVC6FlMNvh4+rcWbekbNvA7zB2F
	 t4siMRCf/7CWMMC4kpsPPmQjuzP6WVr3Ygae64RSJqtjWHNNP285v2JyIxa54Asvcn
	 xgtnX63sms04/RXjlXTOV2UxYZon/KSKN3dWi37LzGE5RTq/D2Pzuc9VoQrGR86X6j
	 /GaGr7DqOp0dk3vcc5K7Ux9l77qYUExORUzdz3TYpbk6n7k3Fvq5a7JfLRULunm2eQ
	 x35iYRLSoeX24v2XXh/RISgGjMNJFXZnLfv7r3mCf1DjoxYQ1H95LSmxLK2sl7kybq
	 6i/ncLqB68szQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Wayne.Lin@amd.com,
	chiahsuan.chung@amd.com,
	agustin.gutierrez@amd.com,
	mario.limonciello@amd.com,
	hersenxs.wu@amd.com,
	mwen@igalia.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 20/31] drm/amd/display: Fix Mode Cutoff in DSC Passthrough to DP2.1 Monitor
Date: Sun, 26 Jan 2025 09:54:36 -0500
Message-Id: <20250126145448.930220-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145448.930220-1-sashal@kernel.org>
References: <20250126145448.930220-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

[ Upstream commit e56ad45e991128bf4db160b75a1d9f647a341d8f ]

Source --> DP2.1 MST hub --> DP1.4/2.1 monitor

When change from DP1.4 to DP2.1 from monitor manual, modes higher than
4k120 are all cutoff by mode validation. Switch back to DP1.4 gets all
the modes up to 4k240 available to be enabled by dsc passthrough.

[why]
Compared to DP1.4 link from hub to monitor, DP2.1 link has larger
full_pbn value that causes overflow in the process of doing conversion
from pbn to kbps.

[how]
Change the data type accordingly to fit into the data limit during
conversion calculation.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 32b025c92c63c..6c6a908615052 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1684,16 +1684,16 @@ int pre_validate_dsc(struct drm_atomic_state *state,
 	return ret;
 }
 
-static unsigned int kbps_from_pbn(unsigned int pbn)
+static uint32_t kbps_from_pbn(unsigned int pbn)
 {
-	unsigned int kbps = pbn;
+	uint64_t kbps = (uint64_t)pbn;
 
 	kbps *= (1000000 / PEAK_FACTOR_X1000);
 	kbps *= 8;
 	kbps *= 54;
 	kbps /= 64;
 
-	return kbps;
+	return (uint32_t)kbps;
 }
 
 static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
-- 
2.39.5


