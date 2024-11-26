Return-Path: <stable+bounces-95538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD019D9A83
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 16:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DEA4164A0A
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 15:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382251D63DD;
	Tue, 26 Nov 2024 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLMpqun7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9971CD219
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732635556; cv=none; b=GdmpgE81LVaFQ8WykW3FINEFFG7Q86eebkAULtFT/fWR4iJk+xORhSMG4T632wIiVS+j/EAqcZNcfGEsERDq8Mtyq1kE35QvrpYGI7zsG1Ee8851Cjjgglz1uDErfkvZx0iiG9et5NdrGgQzvY4z1nJ+R0gunwvF7jcMp80EKOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732635556; c=relaxed/simple;
	bh=sSwVykrQpOL6jclysbyBZjzl2PdXfrS9Zj59uzyY2hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glxkj9qdk0r8QOcpDynTo86n7DGvvREqF3C6OSXAE02i1V4JiSSORS2xyxh/eYqxgTFSHZf8vmUJQHL4R7LtdcYFAKp1w5xPgSNQXJU6qvknRCgGEKdiO1ccPp5onkS6+sSUV3FFJqS1IcULfSHJ2yZinahyZ6rhBHLUbEI9U30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLMpqun7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B598C4CECF;
	Tue, 26 Nov 2024 15:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732635553;
	bh=sSwVykrQpOL6jclysbyBZjzl2PdXfrS9Zj59uzyY2hA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aLMpqun7zOr71AveZQaeTcTLE4DluSxkKCHUo0b9Yq07RPa5FokdZoEURLY+S+3AE
	 RqoOLBy8y+Rn610MTe8dQWmdGnWl0o/8Jw+AdgQn3tXKF380csgNh+aezlxObhMd0o
	 QjeKky8VCEPhzcH3u2hGRTpvVAOst0XZUs/tZ9ncGNZkCBzmszKVQ5mEyRzTM12ewU
	 9miEOcWkpFnngG2KdPdsc82q5WLiWKTE1DdzarGFqUmHQQeSOaBJj12yxd+/bWkFgz
	 KE1FYagfWQIg0S654VRAQledZZ2WElbZIRD5VeowPVwrrYfqiFS3/F2+2aT7oDgmkC
	 SGzGcLjVgeJ/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] drm/amd/display: Add null check for pipe_ctx->plane_state in dcn20_program_pipe
Date: Tue, 26 Nov 2024 10:39:11 -0500
Message-ID: <20241126103613-4633bda59a58ba44@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241126065532.318085-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 8e4ed3cf1642df0c4456443d865cff61a9598aa8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 65a6fee22d5c)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-26 10:32:22.782798199 -0500
+++ /tmp/tmp.h38Qae9tjS	2024-11-26 10:32:22.774777464 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 8e4ed3cf1642df0c4456443d865cff61a9598aa8 ]
+
 This commit addresses a null pointer dereference issue in the
 `dcn20_program_pipe` function. The issue could occur when
 `pipe_ctx->plane_state` is null.
@@ -18,17 +20,23 @@
 Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
 Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
 Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+[Xiangyu: BP to fix CVE: CVE-2024-49914, modified the file path from
+drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn20/dcn20_hwseq.c to
+drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c
+and minor conflict resolution]
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
- .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 30 ++++++++++++-------
- 1 file changed, 19 insertions(+), 11 deletions(-)
+ .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 22 ++++++++++++-------
+ 1 file changed, 14 insertions(+), 8 deletions(-)
 
-diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
-index 270e337ae27bb..5a6064999033b 100644
---- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
-+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
-@@ -1922,22 +1922,29 @@ static void dcn20_program_pipe(
- 				dc->res_pool->hubbub, pipe_ctx->plane_res.hubp->inst, pipe_ctx->hubp_regs.det_size);
- 	}
+diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+index 12af2859002f..cd1d1b7283ab 100644
+--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
++++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+@@ -1732,17 +1732,22 @@ static void dcn20_program_pipe(
+ 		dc->res_pool->hubbub->funcs->program_det_size(
+ 			dc->res_pool->hubbub, pipe_ctx->plane_res.hubp->inst, pipe_ctx->det_buffer_size_kb);
  
 -	if (pipe_ctx->update_flags.raw || pipe_ctx->plane_state->update_flags.raw || pipe_ctx->stream->update_flags.raw)
 +	if (pipe_ctx->update_flags.raw ||
@@ -42,16 +50,6 @@
 +	    (pipe_ctx->plane_state && pipe_ctx->plane_state->update_flags.bits.hdr_mult))
  		hws->funcs.set_hdr_multiplier(pipe_ctx);
  
- 	if (hws->funcs.populate_mcm_luts) {
--		hws->funcs.populate_mcm_luts(dc, pipe_ctx, pipe_ctx->plane_state->mcm_luts,
--				pipe_ctx->plane_state->lut_bank_a);
--		pipe_ctx->plane_state->lut_bank_a = !pipe_ctx->plane_state->lut_bank_a;
-+		if (pipe_ctx->plane_state) {
-+			hws->funcs.populate_mcm_luts(dc, pipe_ctx, pipe_ctx->plane_state->mcm_luts,
-+						     pipe_ctx->plane_state->lut_bank_a);
-+			pipe_ctx->plane_state->lut_bank_a = !pipe_ctx->plane_state->lut_bank_a;
-+		}
- 	}
  	if (pipe_ctx->update_flags.bits.enable ||
 -	    pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change ||
 -	    pipe_ctx->plane_state->update_flags.bits.gamma_change ||
@@ -65,7 +63,7 @@
  		hws->funcs.set_input_transfer_func(dc, pipe_ctx, pipe_ctx->plane_state);
  
  	/* dcn10_translate_regamma_to_hw_format takes 750us to finish
-@@ -1947,7 +1954,8 @@ static void dcn20_program_pipe(
+@@ -1752,7 +1757,8 @@ static void dcn20_program_pipe(
  	if (pipe_ctx->update_flags.bits.enable ||
  			pipe_ctx->update_flags.bits.plane_changed ||
  			pipe_ctx->stream->update_flags.bits.out_tf ||
@@ -75,7 +73,7 @@
  		hws->funcs.set_output_transfer_func(dc, pipe_ctx, pipe_ctx->stream);
  
  	/* If the pipe has been enabled or has a different opp, we
-@@ -1971,7 +1979,7 @@ static void dcn20_program_pipe(
+@@ -1776,7 +1782,7 @@ static void dcn20_program_pipe(
  	}
  
  	/* Set ABM pipe after other pipe configurations done */
@@ -84,3 +82,6 @@
  		if (pipe_ctx->stream_res.abm) {
  			dc->hwss.set_pipe(pipe_ctx);
  			pipe_ctx->stream_res.abm->funcs->set_abm_level(pipe_ctx->stream_res.abm,
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

