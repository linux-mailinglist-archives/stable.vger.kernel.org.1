Return-Path: <stable+bounces-79210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB1E98D71E
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17AB51F2468E
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930381D079D;
	Wed,  2 Oct 2024 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W0Gi9gnp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF3C1D0799;
	Wed,  2 Oct 2024 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876762; cv=none; b=jIwt6psod1LIWi8vfrKd00OPjbRazMQIpnEjwlNe+4nYqo2Zb/MaE0ecw8o1a7+XRT55EEhMY5b1peFG6vwrrJpjwlYGGQ1F/HebVdGA8fqp3yX+4Y5GczAqKgZOZ4cXhvvKG5xF8Vlo+ISfjT4yE1zLZV3wAevs90CSH6u2X08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876762; c=relaxed/simple;
	bh=1vpVhZWPL3w645XtZxWA0JF6zSJR9tu/vJV8xmm4sYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsxXvKrVoCtqH/Wd+6Ly20WJf9aWfMEWxIKzXpUaSYg3TZLjkajioc0qouV+qf81M5wVSX1hOnbcRWtmFmF2P/gyAgE+eE4yB0oyFDOcYYt/Ifkicv39HSlroGOFeqBSd27SfAbt4691DuoRoeohqQhuUfFMZxPQkBgda3/d7vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W0Gi9gnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A7DC4CEC5;
	Wed,  2 Oct 2024 13:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727876762;
	bh=1vpVhZWPL3w645XtZxWA0JF6zSJR9tu/vJV8xmm4sYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0Gi9gnpeAVrA3c03GEbcuUSER0SFhYDhTAIiIC5iYiMkrCxdgEOmtU/mZe9O8Sap
	 Ft4ctqcgRi7m2lX8Zf3dxE1VWXYIQWlN997pX5ZEpUfz3bJkDc56EdvYRCo6g2QwLx
	 iIUA/CPYSb1cwC4rVMHP4BBTtyjmN4CHTuhV+CVU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Martin Tsai <martin.tsai@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.11 553/695] drm/amd/display: Clean up dsc blocks in accelerated mode
Date: Wed,  2 Oct 2024 14:59:11 +0200
Message-ID: <20241002125844.578597107@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Tsai <martin.tsai@amd.com>

commit 3766a840e093d30e1a2522f650d8a6ac892a8719 upstream.

[WHY]
DSC on eDP could be enabled during VBIOS post. The enabled
DSC may not be disabled when enter to OS, once the system was
in second screen only mode before entering to S4. In this
case, OS will not send setTimings to reset eDP path again.

The enabled DSC HW will make a new stream without DSC cannot
output normally if it reused this pipe with enabled DSC.

[HOW]
In accelerated mode, to clean up DSC blocks if eDP is on link
but not active when we are not in fast boot and seamless boot.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Martin Tsai <martin.tsai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c |   50 ++++++++++++++
 1 file changed, 50 insertions(+)

--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -57,6 +57,7 @@
 #include "panel_cntl.h"
 #include "dc_state_priv.h"
 #include "dpcd_defs.h"
+#include "dsc.h"
 /* include DCE11 register header files */
 #include "dce/dce_11_0_d.h"
 #include "dce/dce_11_0_sh_mask.h"
@@ -1815,6 +1816,48 @@ static void get_edp_links_with_sink(
 	}
 }
 
+static void clean_up_dsc_blocks(struct dc *dc)
+{
+	struct display_stream_compressor *dsc = NULL;
+	struct timing_generator *tg = NULL;
+	struct stream_encoder *se = NULL;
+	struct dccg *dccg = dc->res_pool->dccg;
+	struct pg_cntl *pg_cntl = dc->res_pool->pg_cntl;
+	int i;
+
+	if (dc->ctx->dce_version != DCN_VERSION_3_5 &&
+		dc->ctx->dce_version != DCN_VERSION_3_51)
+		return;
+
+	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
+		struct dcn_dsc_state s  = {0};
+
+		dsc = dc->res_pool->dscs[i];
+		dsc->funcs->dsc_read_state(dsc, &s);
+		if (s.dsc_fw_en) {
+			/* disable DSC in OPTC */
+			if (i < dc->res_pool->timing_generator_count) {
+				tg = dc->res_pool->timing_generators[i];
+				tg->funcs->set_dsc_config(tg, OPTC_DSC_DISABLED, 0, 0);
+			}
+			/* disable DSC in stream encoder */
+			if (i < dc->res_pool->stream_enc_count) {
+				se = dc->res_pool->stream_enc[i];
+				se->funcs->dp_set_dsc_config(se, OPTC_DSC_DISABLED, 0, 0);
+				se->funcs->dp_set_dsc_pps_info_packet(se, false, NULL, true);
+			}
+			/* disable DSC block */
+			if (dccg->funcs->set_ref_dscclk)
+				dccg->funcs->set_ref_dscclk(dccg, dsc->inst);
+			dsc->funcs->dsc_disable(dsc);
+
+			/* power down DSC */
+			if (pg_cntl != NULL)
+				pg_cntl->funcs->dsc_pg_control(pg_cntl, dsc->inst, false);
+		}
+	}
+}
+
 /*
  * When ASIC goes from VBIOS/VGA mode to driver/accelerated mode we need:
  *  1. Power down all DC HW blocks
@@ -1917,6 +1960,13 @@ void dce110_enable_accelerated_mode(stru
 		clk_mgr_exit_optimized_pwr_state(dc, dc->clk_mgr);
 
 		power_down_all_hw_blocks(dc);
+
+		/* DSC could be enabled on eDP during VBIOS post.
+		 * To clean up dsc blocks if eDP is in link but not active.
+		 */
+		if (edp_link_with_sink && (edp_stream_num == 0))
+			clean_up_dsc_blocks(dc);
+
 		disable_vga_and_power_gate_all_controllers(dc);
 		if (edp_link_with_sink && !keep_edp_vdd_on)
 			dc->hwss.edp_power_control(edp_link_with_sink, false);



