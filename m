Return-Path: <stable+bounces-43279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4FB8BF136
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC5C1C22F4A
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2CC13D509;
	Tue,  7 May 2024 23:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URTlsLSo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E142112B163;
	Tue,  7 May 2024 23:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122929; cv=none; b=dj9ReQR4l7k5ulkUfnGKkeFTSlZf8kWdnfAeldSwirX1xIrBH7NDNMMkQ7VJVuux6ZVyJRZGKRup5hWFTyvWA5n0pYe0TbhJcfXog0M935sn1Qo9jcSsan0kpCqmSbtJ56pKqay9GV8E0qIFiIfxrLOJtiAAhjAwIu6k4z+knho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122929; c=relaxed/simple;
	bh=/vI2vAORbGe6dlIg7gvs2UgWVFM4jEnbGfNAbZdbNsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqOhmxIl3MfFamOc333mLdGpD7PAqAaaytq07mlrl2vnipUJwG8V05GyTq/fuQhMFWfFHgICIO5AzJ8jz7lgDHw6sXxgVNpKUF4YeEs949RYqifrvOYoK44WZkZHXew6JzhLhw28qdaCz57bRUlW9YIW5L4bVU5CW44zAJe3DKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URTlsLSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BADBC4AF17;
	Tue,  7 May 2024 23:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122928;
	bh=/vI2vAORbGe6dlIg7gvs2UgWVFM4jEnbGfNAbZdbNsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URTlsLSoWohIhIZE1+zTdkk8dBimjq8+unG6kPkiRw0EIFEG1BQzjQ1J9MVQN15n+
	 Ir87U9DmYQviVkdyUTVpmIU2Rn/2+aETDYAbMEOLB2zN8TUOtWNieDppTWZSagB7pw
	 mjfUpgMPvGvLEP9Rh6W54uFh7PUGyl60D9THQJ85PQ3kdiB0zfLmPseJOjqaLHxJZn
	 QIGUTbm+mhLnTOd+bkt8lL0+JXPFHME72ihha3+FNQzmtAhLN2gV1cSbO4hmlaLxAN
	 ho9J8DTWxYy8bAbBKKkiM7P9c9n/9Lzpbb3AxO4agyDaXSbDN5AR0gjW2oiyjrtaxI
	 oEhM4r7QHGXcA==
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
Subject: [PATCH AUTOSEL 4.19 3/3] drm/amd/display: Set color_mgmt_changed to true on unsuspend
Date: Tue,  7 May 2024 19:01:56 -0400
Message-ID: <20240507230159.392002-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230159.392002-1-sashal@kernel.org>
References: <20240507230159.392002-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.313
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
index 98d51bc204172..e4139723c473c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -816,6 +816,7 @@ static int dm_resume(void *handle)
 			dc_stream_release(dm_new_crtc_state->stream);
 			dm_new_crtc_state->stream = NULL;
 		}
+		dm_new_crtc_state->base.color_mgmt_changed = true;
 	}
 
 	for_each_new_plane_in_state(dm->cached_state, plane, new_plane_state, i) {
-- 
2.43.0


