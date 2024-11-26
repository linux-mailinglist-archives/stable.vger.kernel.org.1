Return-Path: <stable+bounces-95541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC17C9D9A86
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 16:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79A1164AD8
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 15:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3B31D63E9;
	Tue, 26 Nov 2024 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2PudRlP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE841D63DB
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732635559; cv=none; b=hiuU5wz7AdQ5RZgAIENko3njQY7JTEoos/k5/Yq+PTF2zYPtytjBJdIuD4cxuV5wj0KV/Ujz5haIHAlFG+ZYqOjy9/3shRvFhr6n4hyOn1vQUOAQIDfspY5TSFAgwnUe8ORUpF5wtrbBoY6rbWup9q3QkH9piW+vxuTzsjD0OvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732635559; c=relaxed/simple;
	bh=0UIv2OAaOxHczo8ckGeMaTXUuA94VWoWLPwy+QUDo24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/73919Ou2i1AWUzI4hFRZ7MONVwD+z9B8ANeJvUcPOphStMvTen3VA/umhUa6pOZz8KFOm1A9oRy+ZObdoMxdWho+DASToAw2Ayx68Fy6JCj9L0+EvrWBSqdDoJpXkWd4mlLm68O/peNkKnU8Xrk+HnA/316Z3+cyOK8Jg7l3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2PudRlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B564C4CECF;
	Tue, 26 Nov 2024 15:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732635559;
	bh=0UIv2OAaOxHczo8ckGeMaTXUuA94VWoWLPwy+QUDo24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2PudRlPVO+qYEu4p3URimR0xqpQnMM6nLqVTLBNIQbdi0DMojD+4iJ4yTn5fVCJQ
	 7uNFwHmdRJoJFWhQID7gegM57ltTW8yCOdngnXBJIDS6tpoeQz5UF67UXMJE5dciIb
	 6TFFSxmjcXu7M6zBYFFGxckrngAhlQ9MCZUf8l8h3LBLimoY9Np4Wyzh36bTJgwn4g
	 6sr4/X9CxFyQ5IO13uphtU4apfjK7f339jULGPsEvA90DwUjowTtFOx6581ka81hax
	 u7JKV/xiMqDXf5n42fQ87DNQZ/hzK450jYXXJRZQavzy2/lVfVmck6uqws8cgH06Ry
	 zEgTi9Icv2+nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] drm/amd/display: Check null-initialized variables
Date: Tue, 26 Nov 2024 10:39:17 -0500
Message-ID: <20241126081432-f77ceac16bc94932@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241126112326.3844609-1-xiangyu.chen@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 367cd9ceba1933b63bc1d87d967baf6d9fd241d2

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Alex Hung <alex.hung@amd.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 115b1a3b0944)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-26 08:11:03.228502071 -0500
+++ /tmp/tmp.yx1D4yo5Xl	2024-11-26 08:11:03.222888690 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 367cd9ceba1933b63bc1d87d967baf6d9fd241d2 ]
+
 [WHAT & HOW]
 drr_timing and subvp_pipe are initialized to null and they are not
 always assigned new values. It is necessary to check for null before
@@ -11,15 +13,17 @@
 Signed-off-by: Alex Hung <alex.hung@amd.com>
 Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
 Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
+[Xiangyu: BP to fix CVE: CVE-2024-49898, Minor conflict resolution]
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
  drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 7 ++++---
  1 file changed, 4 insertions(+), 3 deletions(-)
 
 diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
-index 9d399c4ce957d..4cb0227bdd270 100644
+index 85e0d1c2a908..9d8917f72d18 100644
 --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
 +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
-@@ -871,8 +871,9 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context)
+@@ -900,8 +900,9 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context, struc
  	 * for VBLANK: (VACTIVE region of the SubVP pipe can fit the MALL prefetch, VBLANK frame time,
  	 * and the max of (VBLANK blanking time, MALL region)).
  	 */
@@ -31,12 +35,15 @@
  		schedulable = true;
  
  	return schedulable;
-@@ -937,7 +938,7 @@ static bool subvp_vblank_schedulable(struct dc *dc, struct dc_state *context)
- 		if (!subvp_pipe && pipe_mall_type == SUBVP_MAIN)
- 			subvp_pipe = pipe;
- 	}
--	if (found) {
-+	if (found && subvp_pipe) {
- 		phantom_stream = dc_state_get_paired_subvp_stream(context, subvp_pipe->stream);
+@@ -966,7 +967,7 @@ static bool subvp_vblank_schedulable(struct dc *dc, struct dc_state *context)
+ 	if (found && context->res_ctx.pipe_ctx[vblank_index].stream->ignore_msa_timing_param) {
+ 		// SUBVP + DRR case
+ 		schedulable = subvp_drr_schedulable(dc, context, &context->res_ctx.pipe_ctx[vblank_index]);
+-	} else if (found) {
++	} else if (found && subvp_pipe) {
  		main_timing = &subvp_pipe->stream->timing;
- 		phantom_timing = &phantom_stream->timing;
+ 		phantom_timing = &subvp_pipe->stream->mall_stream_config.paired_stream->timing;
+ 		vblank_timing = &context->res_ctx.pipe_ctx[vblank_index].stream->timing;
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

