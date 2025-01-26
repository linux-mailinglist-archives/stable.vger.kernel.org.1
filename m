Return-Path: <stable+bounces-110525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56629A1C99B
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C8A7A3104
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B421A9B29;
	Sun, 26 Jan 2025 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcKoIYkR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE11A9B27;
	Sun, 26 Jan 2025 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903263; cv=none; b=OKim54GFAvr0OASY1Cr8+qUHwTDyI+5oYRp6zUaey/1lhKhNq7Lsu7LKTXPmxg4AAtU3Y0qH/JO8IKFK5RqrANWhpOShdZrtlDcyjry0csRHQaHKQ4Bb5KTqJsTFeaZEQIo+//B44uJd9A2NeOHPt/Uqa2rVp9m7O9F0xq5nWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903263; c=relaxed/simple;
	bh=tFMmcJ4WiZ4T+GcQR2jZ8ZBr1K9RTB8HKxC6Cg085BA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jyLd5Cg2elamG/BcAI5HGnx3YcP5PK/IY1jmdJnKDMshrwqdHYvTFk90GnSoi7ZxGF5L74q4SuYr8d3/NIL2Eo5VWla+XqF+nxBZyblmbyHxSAPKqXV7J3P3pNLM33LLjdiEHxBaQ0etzwKnYYBU0NU1/5/bBSCPTa2CWJsIDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcKoIYkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85764C4CEE6;
	Sun, 26 Jan 2025 14:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903262;
	bh=tFMmcJ4WiZ4T+GcQR2jZ8ZBr1K9RTB8HKxC6Cg085BA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IcKoIYkRoybSvkNYBc2HiRARHfjvh7Ka3w2CaEZy8Zs9ul7rh0D5t47v/qXar9iwL
	 j8LymBGSgLETVPfJv6qpZGfhGYTPZb3ZG79toZeSOkfAfNHRwoQ1XOR9SV4eU0+Rlv
	 MSouZ1dPQoNsdUOB1Jf+8MKPv8lwTkNWUgvSXFNeTl4W6urPTorRlD/s0UBspwBQue
	 2gkUrEFazoDGkDwgLygLvBclTpvJTwsbUt54lT/n9Wquk/7o7tV7GnSE1sAn5iHjJ3
	 ck3/jRHwg7PCtg3/1zZ7WEIxEWe8U0LhgjKmG6dAkXxmTLXrxj4c6X3IR2snm84yCQ
	 aLVeRWiMb/oKw==
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
	hersenxs.wu@amd.com,
	mario.limonciello@amd.com,
	mwen@igalia.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 23/34] drm/amd/display: Fix Mode Cutoff in DSC Passthrough to DP2.1 Monitor
Date: Sun, 26 Jan 2025 09:52:59 -0500
Message-Id: <20250126145310.926311-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145310.926311-1-sashal@kernel.org>
References: <20250126145310.926311-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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
index 1080075ccb17c..e096fb5621229 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1695,16 +1695,16 @@ int pre_validate_dsc(struct drm_atomic_state *state,
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


