Return-Path: <stable+bounces-4063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF118045D8
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1781F1C20C71
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528D46FB1;
	Tue,  5 Dec 2023 03:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZEvMi3qK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1086F6AA0;
	Tue,  5 Dec 2023 03:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841F8C433C8;
	Tue,  5 Dec 2023 03:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746523;
	bh=GClaHJv+vNeUj5IO5cwrp96Yb6CSwjqOphbT+2Cw2DI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZEvMi3qKj7KEhBL2RDwgCbX1wfNEA49Xwn3RqDE2sUej2ldW4ekZ9l0Vk5Lzp+Lhs
	 3Ibfre01uMDj8DeB3k4E6har0VGYcAMyYfzfPDLCJ7oJcN4JFMZl8VBvnwKVxZF/vc
	 10hancH/sd11K3OSOTNP092Jzv9R6CpjroHgARpc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Syed Hassan <syed.hassan@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 032/134] drm/amd/display: Remove min_dst_y_next_start check for Z8
Date: Tue,  5 Dec 2023 12:15:04 +0900
Message-ID: <20231205031537.507134807@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
References: <20231205031535.163661217@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

commit 08448812acb2ab701cd5ff7e1a1dc97f7f10260c upstream.

[Why]
Flickering occurs on DRR supported panels when engaged in DRR due to
min_dst_y_next becoming larger than the frame size itself.

[How]
In general, we should be able to enter Z8 when this is engaged but it
might be a net power loss even if the calculation wasn't bugged.

Don't support enabling Z8 during the DRR region.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Syed Hassan <syed.hassan@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c |   15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -948,10 +948,8 @@ static enum dcn_zstate_support_state  de
 {
 	int plane_count;
 	int i;
-	unsigned int min_dst_y_next_start_us;
 
 	plane_count = 0;
-	min_dst_y_next_start_us = 0;
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (context->res_ctx.pipe_ctx[i].plane_state)
 			plane_count++;
@@ -973,26 +971,15 @@ static enum dcn_zstate_support_state  de
 	else if (context->stream_count == 1 &&  context->streams[0]->signal == SIGNAL_TYPE_EDP) {
 		struct dc_link *link = context->streams[0]->sink->link;
 		struct dc_stream_status *stream_status = &context->stream_status[0];
-		struct dc_stream_state *current_stream = context->streams[0];
 		int minmum_z8_residency = dc->debug.minimum_z8_residency_time > 0 ? dc->debug.minimum_z8_residency_time : 1000;
 		bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > (double)minmum_z8_residency;
 		bool is_pwrseq0 = link->link_index == 0;
-		bool isFreesyncVideo;
-
-		isFreesyncVideo = current_stream->adjust.v_total_min == current_stream->adjust.v_total_max;
-		isFreesyncVideo = isFreesyncVideo && current_stream->timing.v_total < current_stream->adjust.v_total_min;
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			if (context->res_ctx.pipe_ctx[i].stream == current_stream && isFreesyncVideo) {
-				min_dst_y_next_start_us = context->res_ctx.pipe_ctx[i].dlg_regs.min_dst_y_next_start_us;
-				break;
-			}
-		}
 
 		/* Don't support multi-plane configurations */
 		if (stream_status->plane_count > 1)
 			return DCN_ZSTATE_SUPPORT_DISALLOW;
 
-		if (is_pwrseq0 && (context->bw_ctx.dml.vba.StutterPeriod > 5000.0 || min_dst_y_next_start_us > 5000))
+		if (is_pwrseq0 && context->bw_ctx.dml.vba.StutterPeriod > 5000.0)
 			return DCN_ZSTATE_SUPPORT_ALLOW;
 		else if (is_pwrseq0 && link->psr_settings.psr_version == DC_PSR_VERSION_1 && !link->panel_config.psr.disable_psr)
 			return allow_z8 ? DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY : DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;



