Return-Path: <stable+bounces-178738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6479AB47FDD
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188873C3BFD
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C71E269CE6;
	Sun,  7 Sep 2025 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u9Fa8EU3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499454315A;
	Sun,  7 Sep 2025 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757277800; cv=none; b=rojA8/ivEmab1xrjxDzI6hvSdtUeVdoDz4/e2NVZZ2zLUmTrGB8N0o1ZvS9qycM0UgCVgTxUbDthQ6yRyjGBROjsdp4MbUgjNiPdqSJ+oYFVEKXZzUyV3pSbx/c+cHdhnsnq5niMqZzk23Jgrl1KgT49YNjKiQbefKX4h3wUPHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757277800; c=relaxed/simple;
	bh=/wAfvfA523OhhkSMCcqz10j+Rt/2skyH1yzi6rVzOW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKVM8Ush+Lighc4k1TPsvX7n0NBE2XZz+/7HvKCdMrKhTk5f2660GV9y1t9yWMhU9yNY21XIR0aCNlVawyiKTxae+yluo72iBtG9JZlJsZsAZg/2oYK7gg59GTWGGkQ+3Bk8nCGBjCoLnp7PyFr2wOzaMReqfKEQS4A06ZoftmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u9Fa8EU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1F8C4CEF0;
	Sun,  7 Sep 2025 20:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757277800;
	bh=/wAfvfA523OhhkSMCcqz10j+Rt/2skyH1yzi6rVzOW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u9Fa8EU3SNnLOcF7gq2UJ7ZV0ecI09E3CxiaFddrBMJzL9KskDkcymglQRIX0gL71
	 UVLX5Twp5NPxZrrTonLhQbOKAlRmTHl9ZbWN9+siDA/t6/JyiFX7g7Z4DPgxFcCzRJ
	 +IATrX9ugDGuKc01UzP4+b7cYss6MXJM1Jte1oTM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Sun peng (Leo) Li" <sunpeng.li@amd.com>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.16 128/183] drm/amd/display: Clear the CUR_ENABLE register on DCN314 w/out DPP PG
Date: Sun,  7 Sep 2025 21:59:15 +0200
Message-ID: <20250907195618.835263556@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
References: <20250907195615.802693401@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Lipski <ivan.lipski@amd.com>

commit 3ebf766c35464ebdeefb6068246267147503dc04 upstream.

[Why&How]
ON DCN314, clearing DPP SW structure without power gating it can cause a
double cursor in full screen with non-native scaling.

A W/A that clears CURSOR0_CONTROL cursor_enable flag if
dcn10_plane_atomic_power_down is called and DPP power gating is disabled.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4168
Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 645f74f1dc119dad5a2c7bbc05cc315e76883011)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c      |    9 +
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h      |    2 
 drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c      |    1 
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c |   72 ++++++++++++++
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h |    2 
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c  |    1 
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h               |    3 
 7 files changed, 90 insertions(+)

--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
@@ -520,6 +520,15 @@ void dpp1_dppclk_control(
 		REG_UPDATE(DPP_CONTROL, DPP_CLOCK_ENABLE, 0);
 }
 
+void dpp_force_disable_cursor(struct dpp *dpp_base)
+{
+	struct dcn10_dpp *dpp = TO_DCN10_DPP(dpp_base);
+
+	/* Force disable cursor */
+	REG_UPDATE(CURSOR0_CONTROL, CUR0_ENABLE, 0);
+	dpp_base->pos.cur0_ctl.bits.cur0_enable = 0;
+}
+
 static const struct dpp_funcs dcn10_dpp_funcs = {
 		.dpp_read_state = dpp_read_state,
 		.dpp_reset = dpp_reset,
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h
@@ -1525,4 +1525,6 @@ void dpp1_construct(struct dcn10_dpp *dp
 
 void dpp1_cm_get_gamut_remap(struct dpp *dpp_base,
 			     struct dpp_grph_csc_adjustment *adjust);
+void dpp_force_disable_cursor(struct dpp *dpp_base);
+
 #endif
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -1494,6 +1494,7 @@ static struct dpp_funcs dcn30_dpp_funcs
 	.dpp_dppclk_control		= dpp1_dppclk_control,
 	.dpp_set_hdr_multiplier		= dpp3_set_hdr_multiplier,
 	.dpp_get_gamut_remap		= dpp3_cm_get_gamut_remap,
+	.dpp_force_disable_cursor 	= dpp_force_disable_cursor,
 };
 
 
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -528,3 +528,75 @@ void dcn314_disable_link_output(struct d
 
 	apply_symclk_on_tx_off_wa(link);
 }
+
+/**
+ * dcn314_dpp_pg_control - DPP power gate control.
+ *
+ * @hws: dce_hwseq reference.
+ * @dpp_inst: DPP instance reference.
+ * @power_on: true if we want to enable power gate, false otherwise.
+ *
+ * Enable or disable power gate in the specific DPP instance.
+ * If power gating is disabled, will force disable cursor in the DPP instance.
+ */
+void dcn314_dpp_pg_control(
+		struct dce_hwseq *hws,
+		unsigned int dpp_inst,
+		bool power_on)
+{
+	uint32_t power_gate = power_on ? 0 : 1;
+	uint32_t pwr_status = power_on ? 0 : 2;
+
+
+	if (hws->ctx->dc->debug.disable_dpp_power_gate) {
+		/* Workaround for DCN314 with disabled power gating */
+		if (!power_on) {
+
+			/* Force disable cursor if power gating is disabled */
+			struct dpp *dpp = hws->ctx->dc->res_pool->dpps[dpp_inst];
+			if (dpp && dpp->funcs->dpp_force_disable_cursor)
+				dpp->funcs->dpp_force_disable_cursor(dpp);
+		}
+		return;
+	}
+	if (REG(DOMAIN1_PG_CONFIG) == 0)
+		return;
+
+	switch (dpp_inst) {
+	case 0: /* DPP0 */
+		REG_UPDATE(DOMAIN1_PG_CONFIG,
+				DOMAIN1_POWER_GATE, power_gate);
+
+		REG_WAIT(DOMAIN1_PG_STATUS,
+				DOMAIN1_PGFSM_PWR_STATUS, pwr_status,
+				1, 1000);
+		break;
+	case 1: /* DPP1 */
+		REG_UPDATE(DOMAIN3_PG_CONFIG,
+				DOMAIN3_POWER_GATE, power_gate);
+
+		REG_WAIT(DOMAIN3_PG_STATUS,
+				DOMAIN3_PGFSM_PWR_STATUS, pwr_status,
+				1, 1000);
+		break;
+	case 2: /* DPP2 */
+		REG_UPDATE(DOMAIN5_PG_CONFIG,
+				DOMAIN5_POWER_GATE, power_gate);
+
+		REG_WAIT(DOMAIN5_PG_STATUS,
+				DOMAIN5_PGFSM_PWR_STATUS, pwr_status,
+				1, 1000);
+		break;
+	case 3: /* DPP3 */
+		REG_UPDATE(DOMAIN7_PG_CONFIG,
+				DOMAIN7_POWER_GATE, power_gate);
+
+		REG_WAIT(DOMAIN7_PG_STATUS,
+				DOMAIN7_PGFSM_PWR_STATUS, pwr_status,
+				1, 1000);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		break;
+	}
+}
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
@@ -47,4 +47,6 @@ void dcn314_dpp_root_clock_control(struc
 
 void dcn314_disable_link_output(struct dc_link *link, const struct link_resource *link_res, enum signal_type signal);
 
+void dcn314_dpp_pg_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool power_on);
+
 #endif /* __DC_HWSS_DCN314_H__ */
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -141,6 +141,7 @@ static const struct hwseq_private_funcs
 	.enable_power_gating_plane = dcn314_enable_power_gating_plane,
 	.dpp_root_clock_control = dcn314_dpp_root_clock_control,
 	.hubp_pg_control = dcn31_hubp_pg_control,
+	.dpp_pg_control = dcn314_dpp_pg_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn314_update_odm,
 	.dsc_pg_control = dcn314_dsc_pg_control,
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
@@ -349,6 +349,9 @@ struct dpp_funcs {
 		struct dpp *dpp_base,
 		enum dc_color_space color_space,
 		struct dc_csc_transform cursor_csc_color_matrix);
+
+	void (*dpp_force_disable_cursor)(struct dpp *dpp_base);
+
 };
 
 



