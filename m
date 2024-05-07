Return-Path: <stable+bounces-43276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BED98BF12C
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069CA282C19
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568D380C16;
	Tue,  7 May 2024 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGHSAOdZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C4280C14;
	Tue,  7 May 2024 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122916; cv=none; b=a4bXtJpdpxZXzJT75fYwVPaAlA5jI4jToHLnhAR2safAPw55k9K9mWu9K+9cmEi9njKyXafRojWuFxvLTJ3N4D+qs+xD8d1k4m8dcwbyxuv3A+tEVvvgbXY5ABrnoazA2Y/HOXUweYkYIAFDZ+MuBevXo+IS6r6nFCtfFNeIH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122916; c=relaxed/simple;
	bh=Ojbrq8calDDK6zre4KUhu3qnC0Lb+IpNjLh39EtbaRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFmsKoIlPdkJFOebnXZVAcUgdgY7yv+G+qNvisSP+iCfeDRfjNpRXFlnCTH6pTNg7/ySGTlKcRO3pFiIYI9SIwlm6nAwIFSNZUOR0PR3adPQ4NJrfDfxzdf2dSjATl5xchWkzQYSpkoyEtQZzz0BVwcRaWHZ6vULNavvTculZIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGHSAOdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2012C3277B;
	Tue,  7 May 2024 23:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122916;
	bh=Ojbrq8calDDK6zre4KUhu3qnC0Lb+IpNjLh39EtbaRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YGHSAOdZ/X7nnaak5mDMKu67mOv7JJU0cVhp9iqEnhji1sy6pe62EFiBaTAr34JB3
	 p1G4kODBoBubCAy1DWNNaoKpRULctkwiqDPmQBU0b2yBZIB4WN7fIEuE42bcB/pcmx
	 ytSBusVpeUe0lFK+Lg5EhGqi0wUPghZxJapWFMMoAiWvU1freD7uKaDBBGDDVRAqnM
	 jlYUcWUBM3uUFQfSErioLtVjyW6TQ2Kdf2kJgLJV1adzzaxyh4Cz1zWzLR9nDR12nZ
	 +FG2HUZI8F7ETCkzlnemsGEHTtoZVMDfCDwC/Q2gmY+l1HTlc5fcDquwWQ7K//N2D5
	 8mG/6QCS3DN4A==
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
Subject: [PATCH AUTOSEL 5.4 3/3] drm/amd/display: Set color_mgmt_changed to true on unsuspend
Date: Tue,  7 May 2024 19:01:43 -0400
Message-ID: <20240507230146.391926-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230146.391926-1-sashal@kernel.org>
References: <20240507230146.391926-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.275
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
index 3f3242783e1c3..3bfc4aa328c6f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1251,6 +1251,7 @@ static int dm_resume(void *handle)
 			dc_stream_release(dm_new_crtc_state->stream);
 			dm_new_crtc_state->stream = NULL;
 		}
+		dm_new_crtc_state->base.color_mgmt_changed = true;
 	}
 
 	for_each_new_plane_in_state(dm->cached_state, plane, new_plane_state, i) {
-- 
2.43.0


