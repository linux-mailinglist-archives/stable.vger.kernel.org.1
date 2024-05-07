Return-Path: <stable+bounces-43273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1818BF120
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6541F2263D
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B70112A17B;
	Tue,  7 May 2024 23:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHN4fSZq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB2E13C9A0;
	Tue,  7 May 2024 23:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122904; cv=none; b=Xcj4VpPMXWBibY8v2P4GdInwlzOSwbsnrDtDFvim/6CMJmTei4DAHO2ErLExZKemC8kdnjgyJjbW2DGPH6MZhhL5zN+YhNFgiDUJpkrtGBX4//k4Gz1YZ9IykKpAiskv3oOZk4Adz1Z0e4e2xacX9kFB85y0WNgUou2xdbEK5ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122904; c=relaxed/simple;
	bh=tovHdZnNetq9FRVFwkN2dsgjcO8FTfI8ShnWTzMfq1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIngCHOjFc1VYMIFZEIGt2hPO5yc6dX+h4su0LqDHSi8zcdk77N3B1AVvphhMPFUiOmlYNTHZfktDerFeJ9dbGctfUFMxt6ViBQZhZywHPlMe5gKX2tUmMNRDW9OiCGhdFEc8F9iQo85Uk6/AhcSJhZGkpfCxyTqTAHHINb+Ug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHN4fSZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78091C3277B;
	Tue,  7 May 2024 23:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122903;
	bh=tovHdZnNetq9FRVFwkN2dsgjcO8FTfI8ShnWTzMfq1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UHN4fSZqiXa0nF9WR4fFtDMk4LntFiuOfZCzNBEQA3zoGv9ixmr+2lYjJVTBO6dub
	 lHZNtMoismbRytI6UvD5j0zdggo4GRBLO0iRQE/Nw6soaKbfy2Rje0R3I/ewOmR76f
	 ApbaHUZD2uCM0y6/ACIiUty5hc9+5HMW+W6P4j4b9o8vmQGAJIT3WVS3jaeOIyrRk4
	 n4cNRYRhYTdVxvqQv1UwNsHMhR/5V+GJX67+HKJYGGqL7X+1mgJFE1paC6quUYndyu
	 TyijLK+0PYuESVNGj4Pfi23VH2gmTrkd3c2YY4nqvQ+qEbNjjF8tErATYQsuGrHR1e
	 +l6umPE2eBfAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joshua Ashton <joshua@froggi.es>,
	Harry Wentland <harry.wentland@amd.com>,
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
	wayne.lin@amd.com,
	srinivasan.shanmugam@amd.com,
	mario.limonciello@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 3/3] drm/amd/display: Set color_mgmt_changed to true on unsuspend
Date: Tue,  7 May 2024 19:01:30 -0400
Message-ID: <20240507230134.391850-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230134.391850-1-sashal@kernel.org>
References: <20240507230134.391850-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.216
Content-Transfer-Encoding: 8bit

From: Joshua Ashton <joshua@froggi.es>

[ Upstream commit 2eb9dd497a698dc384c0dd3e0311d541eb2e13dd ]

Otherwise we can end up with a frame on unsuspend where color management
is not applied when userspace has not committed themselves.

Fixes re-applying color management on Steam Deck/Gamescope on S3 resume.

Signed-off-by: Joshua Ashton <joshua@froggi.es>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3578e3b3536e3..29ef0ed44d5f4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2099,6 +2099,7 @@ static int dm_resume(void *handle)
 			dc_stream_release(dm_new_crtc_state->stream);
 			dm_new_crtc_state->stream = NULL;
 		}
+		dm_new_crtc_state->base.color_mgmt_changed = true;
 	}
 
 	for_each_new_plane_in_state(dm->cached_state, plane, new_plane_state, i) {
-- 
2.43.0


