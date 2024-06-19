Return-Path: <stable+bounces-53760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A03D90E60A
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7906C1C213C4
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762107BB13;
	Wed, 19 Jun 2024 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="geCad1AX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365E9770EF
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786372; cv=none; b=a2H0w1Va+OJoGY1zaCO3evYVzu+5H5hhu+7++bdvP/wkDyjGMSQ3xRsJ1TilOzCru9cVsylp8ZHsdm5lQbEBEBCKc8WcYJvXAe2DJ4x15poai8G0CoZFNUSxGc8UkvtKysLVfExRRw9ifxcoaUKwfgqr0AYgBlPql6CMBzg3wLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786372; c=relaxed/simple;
	bh=3dhF/MhQ5x7ljAjHf+yzdsSDwnC0owakaUBRerT2g4E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nePUg4CAgLs4xJjJiPTg+AnM8X4A5zmsUjAAhoot10y7E2k69w/gg7a2SFOd0g7noh+iWs+NOmZO5FgUcZB6t12vj5+iHTlRB2qYkNLpN2mITdlrByTOhiWp4W0A9pz7wl3dKrMbuIM3+ybUl+LgRFbUhFZ+SIkcsZsj2S32O7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=geCad1AX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D3DC2BBFC;
	Wed, 19 Jun 2024 08:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786372;
	bh=3dhF/MhQ5x7ljAjHf+yzdsSDwnC0owakaUBRerT2g4E=;
	h=Subject:To:Cc:From:Date:From;
	b=geCad1AX+TOcM5QhabTIrxonMBJAnCgzzP7JbAn4gb23jzRDp6Od5KGDSS6NtpEI6
	 PeETKltYOt5rLTSkJ5vp3aFt5XviDtB8FrL91bWr2pbNBIz4Tzf2TzaUUk7T+b4WfV
	 TMn74j5Md7kg++jvYdoNKvOHeHWnUHJujMcOGx2A=
Subject: FAILED: patch "[PATCH] drm/amd/display: Adjust dprefclk by down spread percentage." failed to apply to 6.1-stable tree
To: zhongwei.zhang@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,nicholas.kazlauskas@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:38:57 +0200
Message-ID: <2024061957-length-husked-03d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 364b1c1de6de36c1b28690265c904c682aecc266
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061957-length-husked-03d3@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

364b1c1de6de ("drm/amd/display: Adjust dprefclk by down spread percentage.")
1ba65e749dc6 ("drm/amd/display: Send DTBCLK disable message on first commit")
3a6a32b31a11 ("Revert "drm/amd/display: Send DTBCLK disable message on first commit"")
f2a905b01c6d ("drm/amd/display: fix invalid reg access on DCN35 FPGA")
f341055b10bd ("drm/amd/display: Send DTBCLK disable message on first commit")
038c53234641 ("drm/amd/display: Update P010 scaling cap")
17e74e11ac2b ("drm/amd/display: To adjust dprefclk by down spread percentage")
23cf5a5cd33a ("drm/amd/display: insert drv-pmfw log + rollback to new context")
061a5bf210cd ("drm/amd/display: Allow DTBCLK disable for DCN35")
220db802cb50 ("drm/amd/display: Do not read DPREFCLK spread info from LUT on DCN35")
fd7cedccdde3 ("drm/amd/display: Fix OTG disable workaround logic")
1288d7020809 ("drm/amd/display: Improve x86 and dmub ips handshake")
c0f8b83188c7 ("drm/amd/display: disable IPS")
93a66cef607c ("drm/amd/display: Add IPS control flag")
dc01c4b79bfe ("drm/amd/display: Update driver and IPS interop")
4f43d753bf9c ("drm/amd/display: Correct z8 watermark mask")
0fa45b6aeae4 ("drm/amd/display: Add DCN35 Resource")
ec129fa356be ("drm/amd/display: Add DCN35 init")
65138eb72e1f ("drm/amd/display: Add DCN35 DMUB")
8774029f76b9 ("drm/amd/display: Add DCN35 CLK_MGR")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 364b1c1de6de36c1b28690265c904c682aecc266 Mon Sep 17 00:00:00 2001
From: Zhongwei <zhongwei.zhang@amd.com>
Date: Wed, 27 Mar 2024 13:49:40 +0800
Subject: [PATCH] drm/amd/display: Adjust dprefclk by down spread percentage.

[Why]
OLED panels show no display for large vtotal timings.

[How]
Check if ss is enabled and read from lut for spread spectrum percentage.
Adjust dprefclk as required. DP_DTO adjustment is for edp only.

Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Zhongwei <zhongwei.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 8efde1cfb49a..6c9b4e6491a5 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -73,6 +73,12 @@
 #define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL_MASK		0x00000007L
 #define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_DIV_MASK		0x000F0000L
 
+#define regCLK5_0_CLK5_spll_field_8				0x464b
+#define regCLK5_0_CLK5_spll_field_8_BASE_IDX	0
+
+#define CLK5_0_CLK5_spll_field_8__spll_ssc_en__SHIFT	0xd
+#define CLK5_0_CLK5_spll_field_8__spll_ssc_en_MASK		0x00002000L
+
 #define SMU_VER_THRESHOLD 0x5D4A00 //93.74.0
 
 #define REG(reg_name) \
@@ -412,6 +418,17 @@ static void dcn35_dump_clk_registers(struct clk_state_registers_and_bypass *regs
 {
 }
 
+static bool dcn35_is_spll_ssc_enabled(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	struct dc_context *ctx = clk_mgr->base.ctx;
+	uint32_t ssc_enable;
+
+	REG_GET(CLK5_0_CLK5_spll_field_8, spll_ssc_en, &ssc_enable);
+
+	return ssc_enable == 1;
+}
+
 static void init_clk_states(struct clk_mgr *clk_mgr)
 {
 	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr);
@@ -429,7 +446,16 @@ static void init_clk_states(struct clk_mgr *clk_mgr)
 
 void dcn35_init_clocks(struct clk_mgr *clk_mgr)
 {
+	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr);
 	init_clk_states(clk_mgr);
+
+	// to adjust dp_dto reference clock if ssc is enable otherwise to apply dprefclk
+	if (dcn35_is_spll_ssc_enabled(clk_mgr))
+		clk_mgr->dp_dto_source_clock_in_khz =
+			dce_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr->dprefclk_khz);
+	else
+		clk_mgr->dp_dto_source_clock_in_khz = clk_mgr->dprefclk_khz;
+
 }
 static struct clk_bw_params dcn35_bw_params = {
 	.vram_type = Ddr4MemType,
@@ -518,6 +544,28 @@ static DpmClocks_t_dcn35 dummy_clocks;
 
 static struct dcn35_watermarks dummy_wms = { 0 };
 
+static struct dcn35_ss_info_table ss_info_table = {
+	.ss_divider = 1000,
+	.ss_percentage = {0, 0, 375, 375, 375}
+};
+
+static void dcn35_read_ss_info_from_lut(struct clk_mgr_internal *clk_mgr)
+{
+	struct dc_context *ctx = clk_mgr->base.ctx;
+	uint32_t clock_source;
+
+	REG_GET(CLK1_CLK2_BYPASS_CNTL, CLK2_BYPASS_SEL, &clock_source);
+	// If it's DFS mode, clock_source is 0.
+	if (dcn35_is_spll_ssc_enabled(&clk_mgr->base) && (clock_source < ARRAY_SIZE(ss_info_table.ss_percentage))) {
+		clk_mgr->dprefclk_ss_percentage = ss_info_table.ss_percentage[clock_source];
+
+		if (clk_mgr->dprefclk_ss_percentage != 0) {
+			clk_mgr->ss_on_dprefclk = true;
+			clk_mgr->dprefclk_ss_divider = ss_info_table.ss_divider;
+		}
+	}
+}
+
 static void dcn35_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn35_watermarks *table)
 {
 	int i, num_valid_sets;
@@ -1024,6 +1072,8 @@ void dcn35_clk_mgr_construct(
 	dce_clock_read_ss_info(&clk_mgr->base);
 	/*when clk src is from FCH, it could have ss, same clock src as DPREF clk*/
 
+	dcn35_read_ss_info_from_lut(&clk_mgr->base);
+
 	clk_mgr->base.base.bw_params = &dcn35_bw_params;
 
 	if (clk_mgr->base.base.ctx->dc->debug.pstate_enabled) {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 970644b695cd..b5e0289d2fe8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -976,7 +976,10 @@ static bool dcn31_program_pix_clk(
 	struct bp_pixel_clock_parameters bp_pc_params = {0};
 	enum transmitter_color_depth bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_24;
 
-	if (clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz != 0)
+	// Apply ssed(spread spectrum) dpref clock for edp only.
+	if (clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz != 0
+		&& pix_clk_params->signal_type == SIGNAL_TYPE_EDP
+		&& encoding == DP_8b_10b_ENCODING)
 		dp_dto_ref_khz = clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz;
 	// For these signal types Driver to program DP_DTO without calling VBIOS Command table
 	if (dc_is_dp_signal(pix_clk_params->signal_type) || dc_is_virtual_signal(pix_clk_params->signal_type)) {
@@ -1093,9 +1096,6 @@ static bool get_pixel_clk_frequency_100hz(
 	unsigned int modulo_hz = 0;
 	unsigned int dp_dto_ref_khz = clock_source->ctx->dc->clk_mgr->dprefclk_khz;
 
-	if (clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz != 0)
-		dp_dto_ref_khz = clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz;
-
 	if (clock_source->id == CLOCK_SOURCE_ID_DP_DTO) {
 		clock_hz = REG_READ(PHASE[inst]);
 


