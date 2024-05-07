Return-Path: <stable+bounces-43259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E088BF0EC
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D89E1F2144E
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E91213A24D;
	Tue,  7 May 2024 23:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qk/yQMjl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEAC86278;
	Tue,  7 May 2024 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122847; cv=none; b=mCWz9mIpwTrH9sBggr3VsWeCp+2hx5Us+xO9lq52ZH6+ASzjQSuGzkObsYK2HmRW/fcGZFjpv3JSnvEd4awugGCw1HHeeLXqopRJvdtde/NYxsTWokNAmaok8DBnuabGm6NfGLssSRlvk5fZ38zguFrzM2ga0OmkriNhQzoMm2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122847; c=relaxed/simple;
	bh=GAQEzVprht6F3Nn/e1UYM7rXjiUF38JLg/I9jnfqX+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4IcVtRFP+2jrV1AFtMDslIe8NB/WnGoYQNm41D5vXdq9r1ENIOxfzGl5weYeo1BBQeVnNyECqLTLv5uWl88K+gJGnShnb5sYlTqiSvZvdFeAERBI/HhKQgXhBC1xIE+Hc0/hfPZyEXhwV6W02am1/7HTDqfj5wQUK0OAT8+sHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qk/yQMjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76B5C4AF63;
	Tue,  7 May 2024 23:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122846;
	bh=GAQEzVprht6F3Nn/e1UYM7rXjiUF38JLg/I9jnfqX+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qk/yQMjlgvuhSGVJHuohL53lcrC/R/NBRrUwbCixfR6vbnWYvj8K+DnEruhMbLAkc
	 Tk9UJrFcz+qDLDDgUWI4v6mO7MeMbUtS4fa/UadxCKPiu+yVThx7EM8fht1dEae3OF
	 4P2nPlxdD3q0nXXGKvOZqy53pDspgUoQOmH2Y+jPhlDXofm9jVsYkB2e1tSLSkrrVx
	 amhFNXYMLTpr1Kxu5YaVrTX6VLqgIzZru2PJLbfQ5KGdm1uk+pnEYRuEKShzYXm8hy
	 85Ihf6IjsPrVDQsG1onwRFgGVPKM85uKGQVAhv9UNTt9UacCtibt/pH+rYdHyTBh3X
	 ZtXXURF/nw7ig==
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
Subject: [PATCH AUTOSEL 6.1 06/12] drm/amd/display: Set color_mgmt_changed to true on unsuspend
Date: Tue,  7 May 2024 19:00:08 -0400
Message-ID: <20240507230031.391436-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230031.391436-1-sashal@kernel.org>
References: <20240507230031.391436-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
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
index ff460c9802eb2..31bae620aeffc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2964,6 +2964,7 @@ static int dm_resume(void *handle)
 			dc_stream_release(dm_new_crtc_state->stream);
 			dm_new_crtc_state->stream = NULL;
 		}
+		dm_new_crtc_state->base.color_mgmt_changed = true;
 	}
 
 	for_each_new_plane_in_state(dm->cached_state, plane, new_plane_state, i) {
-- 
2.43.0


