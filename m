Return-Path: <stable+bounces-77462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDF8985D7E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27921C20F5F
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8A01B2514;
	Wed, 25 Sep 2024 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWhG1gLO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A0817A5AA;
	Wed, 25 Sep 2024 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265869; cv=none; b=Dlo/l0tItmIkYzEM2MTcvcA+D4PJgr9EbfNx3WgopKF8y2n9wapvoutNTUmTNH3jIW1ZOIisAI7JvsYPvFHhtIsg/4It/yZoFmDHR+L1w3l+KHfqwgp9ab1N9TE+O8dpEI7jwVDZ+87KxyYQQqnxHC5oOffMeb7+Ijmvj7AxzQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265869; c=relaxed/simple;
	bh=vhzDgu30H12Drwnkuo3MWI94gDBfPLzqqmSZTHcM+DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=um5NT7cjG/WkPdx33P5GAN/CkV7Hz3DXeNR2RsCr1cWksWUBuoeh1awQ2PhmZWfmv7hGxM/mWrwJ0azggwXI6KWhOGXz+JRZZ55SGYxAyfL0iQJ1CWU1dJG/c/wnwgXvS35Ir34Q/2XYCR/e0VT4KS1LcmkmX2r33utauGH2FsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWhG1gLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A672C4CEC3;
	Wed, 25 Sep 2024 12:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265869;
	bh=vhzDgu30H12Drwnkuo3MWI94gDBfPLzqqmSZTHcM+DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AWhG1gLOQV8hxL3/uYUfGH7DWrO+AyqE4peghby86Bf+Ok4KCcvCPfmzGkMHmzher
	 n+9wjBrMXELOXvX4lXkyYN2wKSRS02216LTATG8Dg+UDK1YqVMNPORpVcidbbUuB9r
	 /rNVBiRslGsHB4Z+mV3Bp0kjpY4i5K9THaJrwVoYa5SXeZu3n8bZzaqVeBgmymOsMj
	 FQ70zJwsrg3lh2qKt7qLHUuz6TvHc2fWGxZx0JR7KrX46BFICnSopZKVFGs9eq/SlF
	 qVTEjX5VlMeVdOI8BhscQWXDJtbUwzgi7EDlT25B11FQpn17xlItZm2w7YQBQzq8AU
	 GnwcBMcyHmwMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	moadhuri@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 117/197] drm/amd/display: Add null check for head_pipe in dcn201_acquire_free_pipe_for_layer
Date: Wed, 25 Sep 2024 07:52:16 -0400
Message-ID: <20240925115823.1303019-117-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit f22f4754aaa47d8c59f166ba3042182859e5dff7 ]

This commit addresses a potential null pointer dereference issue in the
`dcn201_acquire_free_pipe_for_layer` function. The issue could occur
when `head_pipe` is null.

The fix adds a check to ensure `head_pipe` is not null before asserting
it. If `head_pipe` is null, the function returns NULL to prevent a
potential null pointer dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn201/dcn201_resource.c:1016 dcn201_acquire_free_pipe_for_layer() error: we previously assumed 'head_pipe' could be null (see line 1010)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c  | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
index 070a4efb308bd..1aeede348bd39 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
@@ -1005,8 +1005,10 @@ static struct pipe_ctx *dcn201_acquire_free_pipe_for_layer(
 	struct pipe_ctx *head_pipe = resource_get_otg_master_for_stream(res_ctx, opp_head_pipe->stream);
 	struct pipe_ctx *idle_pipe = resource_find_free_secondary_pipe_legacy(res_ctx, pool, head_pipe);
 
-	if (!head_pipe)
+	if (!head_pipe) {
 		ASSERT(0);
+		return NULL;
+	}
 
 	if (!idle_pipe)
 		return NULL;
-- 
2.43.0


