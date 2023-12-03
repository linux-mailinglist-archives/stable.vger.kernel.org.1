Return-Path: <stable+bounces-3760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D87880242F
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 14:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6D3280E1C
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7C1EED5;
	Sun,  3 Dec 2023 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CAsTFJLE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE55C8CB
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 13:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C908AC433C8;
	Sun,  3 Dec 2023 13:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701609727;
	bh=MoEwRRO0++N/aNpC0KwrR04MiL6LGJ2ZcVDL4NLjaJs=;
	h=Subject:To:Cc:From:Date:From;
	b=CAsTFJLETViox4iJIDzsK84PTI0MPL37UO1wXgSvzFvluID+d7hkePbbSURaO8PdJ
	 SsS1Bsvq6y4g4UQbzuShLA7UAKxpIizPMnA3/dLUkOhRz6kYgjYYhmJ2d0Jx1ygN9l
	 NGiR6lzM7sxU0UiOHoG9dgsOrMCOGoPJGvkNpfh0=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix some HostVM parameters in DML" failed to apply to 6.6-stable tree
To: syed.hassan@amd.com,Roman.Li@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,hamza.mahfooz@amd.com,nicholas.kazlauskas@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Dec 2023 14:22:04 +0100
Message-ID: <2023120304-yarn-handrail-44c8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a2ab248d94f5af2c609c8c3329875f92324782c5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120304-yarn-handrail-44c8@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

a2ab248d94f5 ("drm/amd/display: Fix some HostVM parameters in DML")
cab667a87133 ("drm/amd/display: Feed SR and Z8 watermarks into DML2 for DCN35")
7966f319c66d ("drm/amd/display: Introduce DML2")
6e2c4941ce0c ("drm/amd/display: Move dml code under CONFIG_DRM_AMD_DC_FP guard")
c51d87202d1f ("drm/amd/display: do not attempt ODM power optimization if minimal transition doesn't exist")
88ca2f8a962e ("drm/amd/display: clean up one inconsistent indenting")
1cb87e048975 ("drm/amd/display: Add DCN35 blocks to Makefile")
69cc1864c99a ("drm/amd/display: Add DCN35 DML")
39d39a019657 ("drm/amd/display: switch to new ODM policy for windowed MPO ODM support")
0b9dc439f404 ("drm/amd/display: Write flip addr to scratch reg for subvp")
96182df99dad ("drm/amd/display: Enable runtime register offset init for DCN32 DMUB")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a2ab248d94f5af2c609c8c3329875f92324782c5 Mon Sep 17 00:00:00 2001
From: Taimur Hassan <syed.hassan@amd.com>
Date: Fri, 10 Nov 2023 10:24:20 -0500
Subject: [PATCH] drm/amd/display: Fix some HostVM parameters in DML

[Why]
A number of DML parameters related to HostVM were either missing or
being set incorrectly, which may cause inaccuracies in calculating
margins and determining BW limitations.

[How]
Correct these values where needed and populate the missing values.

Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Taimur Hassan <syed.hassan@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 21c17d3296a3..39cf1ae3a3e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -330,6 +330,39 @@ void dcn35_update_bw_bounding_box_fpu(struct dc *dc,
 	dml_init_instance(&dc->dml, &dcn3_5_soc, &dcn3_5_ip,
 				DML_PROJECT_DCN31);
 
+	/*copy to dml2, before dml2_create*/
+	if (clk_table->num_entries > 2) {
+
+		for (i = 0; i < clk_table->num_entries; i++) {
+			dc->dml2_options.bbox_overrides.clks_table.num_states =
+				clk_table->num_entries;
+			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].dcfclk_mhz =
+				clock_limits[i].dcfclk_mhz;
+			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].fclk_mhz =
+				clock_limits[i].fabricclk_mhz;
+			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].dispclk_mhz =
+				clock_limits[i].dispclk_mhz;
+			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].dppclk_mhz =
+				clock_limits[i].dppclk_mhz;
+			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].socclk_mhz =
+				clock_limits[i].socclk_mhz;
+			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].memclk_mhz =
+				clk_table->entries[i].memclk_mhz * clk_table->entries[i].wck_ratio;
+			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_dcfclk_levels =
+				clk_table->num_entries;
+			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_fclk_levels =
+				clk_table->num_entries;
+			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_dispclk_levels =
+				clk_table->num_entries;
+			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_dppclk_levels =
+				clk_table->num_entries;
+			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_socclk_levels =
+				clk_table->num_entries;
+			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_memclk_levels =
+				clk_table->num_entries;
+		}
+	}
+
 	/* Update latency values */
 	dc->dml2_options.bbox_overrides.dram_clock_change_latency_us = dcn3_5_soc.dram_clock_change_latency_us;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 48caa34a5ce7..fa8fe5bf7e57 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -1057,9 +1057,12 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 	}
 
 	//Generally these are set by referencing our latest BB/IP params in dcn32_resource.c file
-	dml_dispcfg->plane.GPUVMEnable = true;
-	dml_dispcfg->plane.GPUVMMaxPageTableLevels = 4;
-	dml_dispcfg->plane.HostVMEnable = false;
+	dml_dispcfg->plane.GPUVMEnable = dml2->v20.dml_core_ctx.ip.gpuvm_enable;
+	dml_dispcfg->plane.GPUVMMaxPageTableLevels = dml2->v20.dml_core_ctx.ip.gpuvm_max_page_table_levels;
+	dml_dispcfg->plane.HostVMEnable = dml2->v20.dml_core_ctx.ip.hostvm_enable;
+	dml_dispcfg->plane.HostVMMaxPageTableLevels = dml2->v20.dml_core_ctx.ip.hostvm_max_page_table_levels;
+	if (dml2->v20.dml_core_ctx.ip.hostvm_enable)
+		dml2->v20.dml_core_ctx.policy.AllowForPStateChangeOrStutterInVBlankFinal = dml_prefetch_support_uclk_fclk_and_stutter;
 
 	dml2_populate_pipe_to_plane_index_mapping(dml2, context);
 


