Return-Path: <stable+bounces-95542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F199D9A87
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 16:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461EF164A0A
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 15:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F451D63EF;
	Tue, 26 Nov 2024 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQf531Xo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200041D63DB
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732635562; cv=none; b=ad0tlwt9Qfgl2vH3Y7qcnnFpSTlkI7UGHSQJXyTTtLl1wy4wK6zWVS6MjeYj5CJ0acAZhJB1PvOdYFebzR1GolGpi9x2QWMmrO0IIgurpUpqWSa/Bputny/Cq1svDZW3Ab48SaQMgdQ930ohVaKfjMgtM+Seh2EZSTfAb2xvwow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732635562; c=relaxed/simple;
	bh=6Xxb3CZZVYzj57KbBL7u7QgYbAwsa7vHXZ4T1HtZ6PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ll57+7SNAc3fPirRjs/qIk/4hrKGlC1wUJGUwSszygxTNbvEcV2COXHXQ2e/A5944DuqlABRcmEzlV4VMzUe7yVe8dFvvNux/sglLTmMaceIJI2NKM/ui1m0dNtUKEzd/ZRyApAFAnOgnOaAXgLzhRmIo2xyFzk3XAycOHVMWWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQf531Xo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EFEC4CECF;
	Tue, 26 Nov 2024 15:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732635561;
	bh=6Xxb3CZZVYzj57KbBL7u7QgYbAwsa7vHXZ4T1HtZ6PI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PQf531XoyTvsIO/enMmKf6yLkjRINFIXmOmO07umVsDu9GGzllfC4yytE7kPxjVV/
	 KJENsSFTRsWPhep6P5W3TWyXOC7Ib27J4h2WppO8Gk9UtaX3p9q/Q6bAW+Jf4j5dBF
	 PRW5bmZC7cyLfcKTNatvLei8GhfHPWltgO2hli2oqoVdM45BXE4hW5MWbtrpnpxXzE
	 OJYXygMQliezJhPyDxMftnpWkk8/ApD6TeSesazSq5/2YF+Rx0oX03cK30ww+RGYNt
	 aGoKhrb0eLB9qPG01qOIgTQjVfAOE8B7c0vIFwPlNikrlsiOxHQmzeZfBWMnRki2HC
	 QbkBVFYKYIINA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] drm/amd/display: Check null-initialized variables
Date: Tue, 26 Nov 2024 10:39:19 -0500
Message-ID: <20241126081820-8578f4c079e309c5@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241126112326.3844609-2-xiangyu.chen@eng.windriver.com>
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

Note: The patch differs from the upstream commit:
---
--- -	2024-11-26 08:14:33.990182074 -0500
+++ /tmp/tmp.tdrBcl0SiJ	2024-11-26 08:14:33.983934870 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 367cd9ceba1933b63bc1d87d967baf6d9fd241d2 ]
+
 [WHAT & HOW]
 drr_timing and subvp_pipe are initialized to null and they are not
 always assigned new values. It is necessary to check for null before
@@ -11,15 +13,16 @@
 Signed-off-by: Alex Hung <alex.hung@amd.com>
 Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
 Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
  drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 7 ++++---
  1 file changed, 4 insertions(+), 3 deletions(-)
 
 diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
-index 9d399c4ce957d..4cb0227bdd270 100644
+index 3d82cbef1274..ac6357c089e7 100644
 --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
 +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
-@@ -871,8 +871,9 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context)
+@@ -932,8 +932,9 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context)
  	 * for VBLANK: (VACTIVE region of the SubVP pipe can fit the MALL prefetch, VBLANK frame time,
  	 * and the max of (VBLANK blanking time, MALL region)).
  	 */
@@ -31,12 +34,15 @@
  		schedulable = true;
  
  	return schedulable;
-@@ -937,7 +938,7 @@ static bool subvp_vblank_schedulable(struct dc *dc, struct dc_state *context)
- 		if (!subvp_pipe && pipe_mall_type == SUBVP_MAIN)
+@@ -995,7 +996,7 @@ static bool subvp_vblank_schedulable(struct dc *dc, struct dc_state *context)
+ 		if (!subvp_pipe && pipe->stream->mall_stream_config.type == SUBVP_MAIN)
  			subvp_pipe = pipe;
  	}
 -	if (found) {
 +	if (found && subvp_pipe) {
- 		phantom_stream = dc_state_get_paired_subvp_stream(context, subvp_pipe->stream);
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
| stable/linux-6.6.y        |  Success    |  Success   |

