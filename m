Return-Path: <stable+bounces-43240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D0D8BF07D
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DE96B2280B
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C683C84E17;
	Tue,  7 May 2024 22:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9TWAEkI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A5584E0E;
	Tue,  7 May 2024 22:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122767; cv=none; b=WZq0qZt6Ez+pMCBoC49uBFL2F4nNfqInqgmiGyTiUdjf6amrCFI4TPlXcaAMHUrfv1hBvMqNYlkxZY23R48vyW4F/mzj13XqeUeNw9o/vybGdxbe0vUKr6l0CP+N3xC8JeoE25KpPMZ9Yl+amOmLAPbtI/F537fmsUuzDF1DPC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122767; c=relaxed/simple;
	bh=871IcTP+FnfETikR2gKy/pM1dVybfZZishDY0mTvOls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgSjry8bomC3wUsJE93JhA/omAtQ8o7xlsTyCXTspV+U2gA2uFuOHGXiGRVes8z7GhSW1yfhpw6TSaz2+l5PtIC/4nIwz5IBfxdHiAOHV5rIjm9gQSA6d3/kXpIja/rUTHfTjxrs7R8PRZah0REYsz4d6XUzKel7QvgLrOFYgCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9TWAEkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C8BC3277B;
	Tue,  7 May 2024 22:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122767;
	bh=871IcTP+FnfETikR2gKy/pM1dVybfZZishDY0mTvOls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a9TWAEkIfF4xLGcnvsiaZqJNa8OzZLKF1YdTwBsXx4ndR2G55a/iz0C5ZakBSadd3
	 cQOKEjcrX1y0AwpuisDqRoV3T7iXy3nRNtsGGwIZlHejFQIHJ2UF6BCBkceLnDdomH
	 TzT19aBI+wMNznFG4K3T/ivJPSl8UccnW3UtMlAz5yy3fswftpIQOiMc4cVgd69Kg/
	 bfd41NZUYRZ0LL7XHhEYsKUmWizl3C9VMVxe5JX/4gAfM3+eIdYNe2eGO5JOmuj0jL
	 vS8T9KxRUkp42MmpQmre5qw4OdiQ52qv49VFz1GKcGKLnRNC3t0bNNifBloAaPNnAX
	 I5UBQsOtYcrrw==
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
Subject: [PATCH AUTOSEL 6.6 07/19] drm/amd/display: Set color_mgmt_changed to true on unsuspend
Date: Tue,  7 May 2024 18:58:29 -0400
Message-ID: <20240507225910.390914-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225910.390914-1-sashal@kernel.org>
References: <20240507225910.390914-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
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
index 3442e08f47876..dce9a4599174c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2956,6 +2956,7 @@ static int dm_resume(void *handle)
 			dc_stream_release(dm_new_crtc_state->stream);
 			dm_new_crtc_state->stream = NULL;
 		}
+		dm_new_crtc_state->base.color_mgmt_changed = true;
 	}
 
 	for_each_new_plane_in_state(dm->cached_state, plane, new_plane_state, i) {
-- 
2.43.0


