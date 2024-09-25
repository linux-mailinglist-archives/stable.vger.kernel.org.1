Return-Path: <stable+bounces-77277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A66CE985B5F
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BCCB285305
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB22192D77;
	Wed, 25 Sep 2024 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTCZI32k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15984183CBC;
	Wed, 25 Sep 2024 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264910; cv=none; b=nRLIUwgoKI9Xym2dTU9Y55IJGvhkELWaCQ74xvmPbUsiNyFDqNW5CXke13J1ZuuE9Ela7HgAhdOiCwNqOs8vPPiiqwdtqmZIL/ymiX7QMKMjc3xtYJ2+FBZJPHwogV4M02Chab7uMcLFf+8X4VYebU6H++9VZGr8yBlIhg/pPK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264910; c=relaxed/simple;
	bh=ziyUKEgpN1AStBIwgF5ydpi+eC9lKzD+DmohgRxNSIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5d30D6RQqdFwHu701+NuFxr4vxLylttNNHgeg7zaKtHDsNclVV0auM0+/Wr665WeNfbDspi26gbpbjvzsBNrcvDo8AeeY7ARAQH9Ot0SSqweXJAa8Gn3RKLDR12AFDTKH+C54LtU4qApKPKdaViGhKwh63cOR2K6UDQGnGO4l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTCZI32k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59255C4CEC3;
	Wed, 25 Sep 2024 11:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264909;
	bh=ziyUKEgpN1AStBIwgF5ydpi+eC9lKzD+DmohgRxNSIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WTCZI32kDq1uttG/7tOpZvd2de+RXt+DSI3ymzRVG65UICbAD36NB2nFDner5Jd6p
	 4pCZH2wwvL3BDl3pltJJFG1ywU++G+80z2V+xtc7ppRnHXT/1FD+nhnXe6uFG9hvkG
	 mdrt/12GGKTo9kE4LnLH3fefYmt4MchEMebQANpg8PiZs8KcyUFLeKKtvCoKtosSPs
	 Uvlchqy0oIxZmgm9+tVGP7n24pbPMUaN3WcRyGNSPubA1AM65DSvmemvWv4VC4WNoB
	 laM/X8dBHivBiTyhgn28SLgO8fKj1SIkRhiF9freRjHFcnWawTt/ae32dbPs50Lgc3
	 1A1YM913IfDnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	ivlipski@amd.com,
	colin.i.king@gmail.com,
	aurabindo.pillai@amd.com,
	jiapeng.chong@linux.alibaba.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 179/244] drm/amd/display: Initialize denominators' default to 1
Date: Wed, 25 Sep 2024 07:26:40 -0400
Message-ID: <20240925113641.1297102-179-sashal@kernel.org>
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

[ Upstream commit b995c0a6de6c74656a0c39cd57a0626351b13e3c ]

[WHAT & HOW]
Variables used as denominators and maybe not assigned to other values,
should not be 0. Change their default to 1 so they are never 0.

This fixes 10 DIVIDE_BY_ZERO issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c | 2 +-
 .../display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
index 7c56ad0f88122..e7019c95ba79e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
@@ -78,7 +78,7 @@ static void calculate_ttu_cursor(struct display_mode_lib *mode_lib,
 
 static unsigned int get_bytes_per_element(enum source_format_class source_format, bool is_chroma)
 {
-	unsigned int ret_val = 0;
+	unsigned int ret_val = 1;
 
 	if (source_format == dm_444_16) {
 		if (!is_chroma)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
index dae13f202220e..d8bfc85e5dcd0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
@@ -39,7 +39,7 @@
 
 static unsigned int get_bytes_per_element(enum source_format_class source_format, bool is_chroma)
 {
-	unsigned int ret_val = 0;
+	unsigned int ret_val = 1;
 
 	if (source_format == dm_444_16) {
 		if (!is_chroma)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
index 81f0a6f19f87b..679b200319034 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
@@ -9386,8 +9386,8 @@ static void CalculateVMGroupAndRequestTimes(
 	double TimePerVMRequestVBlank[],
 	double TimePerVMRequestFlip[])
 {
-	unsigned int num_group_per_lower_vm_stage = 0;
-	unsigned int num_req_per_lower_vm_stage = 0;
+	unsigned int num_group_per_lower_vm_stage = 1;
+	unsigned int num_req_per_lower_vm_stage = 1;
 
 #ifdef __DML_VBA_DEBUG__
 	dml2_printf("DML::%s: NumberOfActiveSurfaces = %u\n", __func__, NumberOfActiveSurfaces);
-- 
2.43.0


