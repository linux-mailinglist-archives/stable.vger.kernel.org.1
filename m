Return-Path: <stable+bounces-77228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB8A985AA5
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374211C23AA3
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67F317C985;
	Wed, 25 Sep 2024 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJpJ6nX1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7450F140360;
	Wed, 25 Sep 2024 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264590; cv=none; b=lePIzKx2q0jpVlvzcIJEMaViLLtTq+at+KV699yUfRYCFPVi/ahXE8ghVZJZ+VxFBHyqfVydvOw0BDrO2RZF5PW2TjyG7KWBiyz5kRfL2nGrJeDNMfkHW2HPkc/HfLJc0YD461wL6PrwC+upuFXa083vQN8Rt6S5gHOMaVesXro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264590; c=relaxed/simple;
	bh=9Zv+1G7marrz5gAVlyrNED3DvmZTx+UVPq0V6Q2L8Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNqJW5ci7zLdZWFgOa6s0iGpT6zV52Zgmas0sA/P8ZNiGJbZivQ+st1WhjalQ7X/7vuVttVDcRF5XpSCv3eQ6iFMWb1K6mtrAZ4QO13cgjytsWl8JTgtp8KpGj5laeT4B9e4zyym3iAcnlJ+6Zz/fJ+L1qSSpo2gozBdp+Axgo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJpJ6nX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8B0C4CEC3;
	Wed, 25 Sep 2024 11:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264590;
	bh=9Zv+1G7marrz5gAVlyrNED3DvmZTx+UVPq0V6Q2L8Vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJpJ6nX1BmQ8fM4tA/UrSq9soSU39McKGgPgIDDb78CvSN1b87SVNMVYKnJEWPFIG
	 269CTcUdKJnHvAuW1JybN0sMwoyuzk7fFOc3zwxnTVMoawkYSotYrGfzF/Mmx87yqW
	 g4kqg5QPYIAK71/rCc4gOB2vVGG8RTKvMtl92YZkAuZe0RvDcuuEddbH6XQyJ58Xdq
	 v3cLDBbQ9K1bpRGm3zOvzCxnwCmm9jKcEzOr/4bG1O4UM/he+pCnJCG3jusrfYXum+
	 TlVNoyRn3j/XOr+SwZLtfdnkEkLssG72RXuwoxouxlzb5LssGIF1Ws4EnuAZclVz3K
	 MENwPWKE7GMgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
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
	aurabindo.pillai@amd.com,
	hamza.mahfooz@amd.com,
	ivlipski@amd.com,
	moadhuri@amd.com,
	dillon.varone@amd.com,
	bigeasy@linutronix.de,
	u202112078@hust.edu.cn,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 130/244] drm/amd/display: Pass non-null to dcn20_validate_apply_pipe_split_flags
Date: Wed, 25 Sep 2024 07:25:51 -0400
Message-ID: <20240925113641.1297102-130-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 5559598742fb4538e4c51c48ef70563c49c2af23 ]

[WHAT & HOW]
"dcn20_validate_apply_pipe_split_flags" dereferences merge, and thus it
cannot be a null pointer. Let's pass a valid pointer to avoid null
dereference.

This fixes 2 FORWARD_NULL issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index 5e7cfa8e8ec93..eea2b3b307cd5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -2040,6 +2040,7 @@ bool dcn20_fast_validate_bw(
 {
 	bool out = false;
 	int split[MAX_PIPES] = { 0 };
+	bool merge[MAX_PIPES] = { false };
 	int pipe_cnt, i, pipe_idx, vlevel;
 
 	ASSERT(pipes);
@@ -2064,7 +2065,7 @@ bool dcn20_fast_validate_bw(
 	if (vlevel > context->bw_ctx.dml.soc.num_states)
 		goto validate_fail;
 
-	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, NULL);
+	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
 
 	/*initialize pipe_just_split_from to invalid idx*/
 	for (i = 0; i < MAX_PIPES; i++)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index 8663cbc3d1cf5..347e6aaea582f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -774,6 +774,7 @@ bool dcn21_fast_validate_bw(struct dc *dc,
 {
 	bool out = false;
 	int split[MAX_PIPES] = { 0 };
+	bool merge[MAX_PIPES] = { false };
 	int pipe_cnt, i, pipe_idx, vlevel;
 
 	ASSERT(pipes);
@@ -816,7 +817,7 @@ bool dcn21_fast_validate_bw(struct dc *dc,
 			goto validate_fail;
 	}
 
-	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, NULL);
+	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
 
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-- 
2.43.0


