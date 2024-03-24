Return-Path: <stable+bounces-30791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F65D888CF3
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 05:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49D65B2A784
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 04:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F952E4B4F;
	Mon, 25 Mar 2024 00:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUKQh40o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1152C17C180;
	Sun, 24 Mar 2024 23:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323756; cv=none; b=LKwELuS530vjDxTYPVxJE/tdh9e2JPSU8Ja7uLnCr+iVT+2FRZp2dQoLac5QIazaAxYsof6WyZkf/pQkjLkVnThPb8c4Fsb+gOpVQ3PaOfFvVSejvTtYKVaKBMUFtUsoT37rs8VsQuAp+yHt+4Vl6rmfKM/WQTTKiv8ETET19ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323756; c=relaxed/simple;
	bh=2rcsvd97JtGVplEBrVhPiZV3D81CDlfHGkt6mfZmiLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJ6WATWvJDUcw4LITAqtCmHd5OU6sZPt3TndB1OvdYmnRHimh8aIY+n4viKmzkPh1vKF3QqqW6rvugMzzL1Aq80OSgfrJDKxigU89oz1rnGrJyAxFbbvQCxSRm1uKhu6k10FSJs65NfcB1rf8faaRQgHNLWohEbg8DyUOioe638=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUKQh40o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF057C433C7;
	Sun, 24 Mar 2024 23:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323754;
	bh=2rcsvd97JtGVplEBrVhPiZV3D81CDlfHGkt6mfZmiLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oUKQh40oaAJj75CyMDmD3YbyMEY2uBTTX1pa2b3LP1jpjRxS9KPPL6VVIfQyYLeVs
	 RweeysyaTkub11SQhq3YjOvUvqbI9151dbbHzX5GgNUc38kddfSYTzrtdDUvkvEyyI
	 AtS3oxxpLM4tGn7dtADRjkHo9NWlTEwzgAW6cZGr1FXWXRYMujZmiLeSPt3Dr4Rb2k
	 PwRWWg89jX3js3RycTVJI+JthYsnqF6x9XCLIp4qtp9ODUTt1HC/IHARWXTBxBbIhg
	 N20q7bvLljT4R0sltP07sXhckCrxM+yjSsbtHSYWrESCDIUCj6+eykRmyvst6JbSge
	 6MYzUeS2+d45w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Wyatt Wood <wyatt.wood@amd.com>,
	Anthony Koo <Anthony.Koo@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 129/238] drm/amd/display: Fix potential NULL pointer dereferences in 'dcn10_set_output_transfer_func()'
Date: Sun, 24 Mar 2024 19:38:37 -0400
Message-ID: <20240324234027.1354210-130-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 9ccfe80d022df7c595f1925afb31de2232900656 ]

The 'stream' pointer is used in dcn10_set_output_transfer_func() before
the check if 'stream' is NULL.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn10/dcn10_hwseq.c:1892 dcn10_set_output_transfer_func() warn: variable dereferenced before check 'stream' (see line 1875)

Fixes: ddef02de0d71 ("drm/amd/display: add null checks before logging")
Cc: Wyatt Wood <wyatt.wood@amd.com>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 1c669f115dd80..8cf6e307ae36e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1669,6 +1669,9 @@ bool dcn10_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 {
 	struct dpp *dpp = pipe_ctx->plane_res.dpp;
 
+	if (!stream)
+		return false;
+
 	if (dpp == NULL)
 		return false;
 
@@ -1691,8 +1694,8 @@ bool dcn10_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 	} else
 		dpp->funcs->dpp_program_regamma_pwl(dpp, NULL, OPP_REGAMMA_BYPASS);
 
-	if (stream != NULL && stream->ctx != NULL &&
-			stream->out_transfer_func != NULL) {
+	if (stream->ctx &&
+	    stream->out_transfer_func) {
 		log_tf(stream->ctx,
 				stream->out_transfer_func,
 				dpp->regamma_params.hw_points_num);
-- 
2.43.0


