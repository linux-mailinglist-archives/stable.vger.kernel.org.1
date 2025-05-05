Return-Path: <stable+bounces-141383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B24AAB30A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C181C02F72
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4AB44F2FE;
	Tue,  6 May 2025 00:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcRfWfAR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF31927F4D6;
	Mon,  5 May 2025 22:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485975; cv=none; b=MQUUOAY8YPmlwLxSmnhVKMxHY6ZQHPpm9bBxLqv2fSfuXtsQqaJlnK2qVj+mA4A+oZ6LMmGDhjfJuLL+uENywOb2gkWlXVcUsaPyKRbKhK5+m2fh5OJscFvN155B+vbgaR3Qm70Qh7LFjnsM1CIaJod2SJKMTRD45QNtMiY43uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485975; c=relaxed/simple;
	bh=3Pgg6N8w4Jx0oH1uw1uu9uMOcDKdmoACmzq5HC9hKbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gtJDgDU8gon6B6AvyBhS8TO+0tECPKMT7/G2icYSyPBfhMARkweIOt4r9pnjtoRoCQ46eVjZ//rPCXN2kD8XASAl4SYCV5kRiRPXew9p+lmRds1SjukZyOH2x0d4EB5vS16Abrgte0poCJNx8W0yElzupaKNKefzMstt2ypwlbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcRfWfAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0897EC4CEE4;
	Mon,  5 May 2025 22:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485975;
	bh=3Pgg6N8w4Jx0oH1uw1uu9uMOcDKdmoACmzq5HC9hKbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QcRfWfARsBXpu224uzVD4VnZHyg7LME5XBQ62WWCpPU0RoDNhqcRVrY1d2yMcAsag
	 u4sRgYA+2eVJk7Tq1qS7F+FZ0gJxGSdX/pXDFkR7SEWDSd3q2Id0JWwywm1SWkaLME
	 Ii90V5w4oOoST5UXvhBhsI+v4vjxJo9IEoyWII/rl43uuY4La6UsMhYMs0qzifQa1Q
	 OrWhSY41iiyFe7GwKkdGPez34qquBBCS8Er3frDwGS/eAxl0xaRp+hwrv2uIaB5oBu
	 s8n3ST/eeBmqssN55Tt7RDudgXmX/SWQtTqAFz/989AbdmJlNLLatQyd1rbDYgymSU
	 haGNaY37cOySw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhikai Zhai <zhikai.zhai@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 094/294] drm/amd/display: calculate the remain segments for all pipes
Date: Mon,  5 May 2025 18:53:14 -0400
Message-Id: <20250505225634.2688578-94-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Zhikai Zhai <zhikai.zhai@amd.com>

[ Upstream commit d3069feecdb5542604d29b59acfd1fd213bad95b ]

[WHY]
In some cases the remain de-tile buffer segments will be greater
than zero if we don't add the non-top pipe to calculate, at
this time the override de-tile buffer size will be valid and used.
But it makes the de-tile buffer segments used finally for all of pipes
exceed the maximum.

[HOW]
Add the non-top pipe to calculate the remain de-tile buffer segments.
Don't set override size to use the average according to pipe count
if the value exceed the maximum.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Zhikai Zhai <zhikai.zhai@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/dcn315/dcn315_resource.c   | 42 +++++++++----------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 597fa0364a3a9..d1601d61f05ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1692,7 +1692,7 @@ static int dcn315_populate_dml_pipes_from_context(
 		pipes[pipe_cnt].dout.dsc_input_bpc = 0;
 		DC_FP_START();
 		dcn31_zero_pipe_dcc_fraction(pipes, pipe_cnt);
-		if (pixel_rate_crb && !pipe->top_pipe && !pipe->prev_odm_pipe) {
+		if (pixel_rate_crb) {
 			int bpp = source_format_to_bpp(pipes[pipe_cnt].pipe.src.source_format);
 			/* Ceil to crb segment size */
 			int approx_det_segs_required_for_pstate = dcn_get_approx_det_segs_required_for_pstate(
@@ -1749,28 +1749,26 @@ static int dcn315_populate_dml_pipes_from_context(
 				continue;
 			}
 
-			if (!pipe->top_pipe && !pipe->prev_odm_pipe) {
-				bool split_required = pipe->stream->timing.pix_clk_100hz >= dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc)
-						|| (pipe->plane_state && pipe->plane_state->src_rect.width > 5120);
-
-				if (remaining_det_segs > MIN_RESERVED_DET_SEGS && crb_pipes != 0)
-					pipes[pipe_cnt].pipe.src.det_size_override += (remaining_det_segs - MIN_RESERVED_DET_SEGS) / crb_pipes +
-							(crb_idx < (remaining_det_segs - MIN_RESERVED_DET_SEGS) % crb_pipes ? 1 : 0);
-				if (pipes[pipe_cnt].pipe.src.det_size_override > 2 * DCN3_15_MAX_DET_SEGS) {
-					/* Clamp to 2 pipe split max det segments */
-					remaining_det_segs += pipes[pipe_cnt].pipe.src.det_size_override - 2 * (DCN3_15_MAX_DET_SEGS);
-					pipes[pipe_cnt].pipe.src.det_size_override = 2 * DCN3_15_MAX_DET_SEGS;
-				}
-				if (pipes[pipe_cnt].pipe.src.det_size_override > DCN3_15_MAX_DET_SEGS || split_required) {
-					/* If we are splitting we must have an even number of segments */
-					remaining_det_segs += pipes[pipe_cnt].pipe.src.det_size_override % 2;
-					pipes[pipe_cnt].pipe.src.det_size_override -= pipes[pipe_cnt].pipe.src.det_size_override % 2;
-				}
-				/* Convert segments into size for DML use */
-				pipes[pipe_cnt].pipe.src.det_size_override *= DCN3_15_CRB_SEGMENT_SIZE_KB;
-
-				crb_idx++;
+			bool split_required = pipe->stream->timing.pix_clk_100hz >= dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc)
+					|| (pipe->plane_state && pipe->plane_state->src_rect.width > 5120);
+
+			if (remaining_det_segs > MIN_RESERVED_DET_SEGS && crb_pipes != 0)
+				pipes[pipe_cnt].pipe.src.det_size_override += (remaining_det_segs - MIN_RESERVED_DET_SEGS) / crb_pipes +
+						(crb_idx < (remaining_det_segs - MIN_RESERVED_DET_SEGS) % crb_pipes ? 1 : 0);
+			if (pipes[pipe_cnt].pipe.src.det_size_override > 2 * DCN3_15_MAX_DET_SEGS) {
+				/* Clamp to 2 pipe split max det segments */
+				remaining_det_segs += pipes[pipe_cnt].pipe.src.det_size_override - 2 * (DCN3_15_MAX_DET_SEGS);
+				pipes[pipe_cnt].pipe.src.det_size_override = 2 * DCN3_15_MAX_DET_SEGS;
+			}
+			if (pipes[pipe_cnt].pipe.src.det_size_override > DCN3_15_MAX_DET_SEGS || split_required) {
+				/* If we are splitting we must have an even number of segments */
+				remaining_det_segs += pipes[pipe_cnt].pipe.src.det_size_override % 2;
+				pipes[pipe_cnt].pipe.src.det_size_override -= pipes[pipe_cnt].pipe.src.det_size_override % 2;
 			}
+			/* Convert segments into size for DML use */
+			pipes[pipe_cnt].pipe.src.det_size_override *= DCN3_15_CRB_SEGMENT_SIZE_KB;
+
+			crb_idx++;
 			pipe_cnt++;
 		}
 	}
-- 
2.39.5


