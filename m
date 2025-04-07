Return-Path: <stable+bounces-128766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BEAA7EB81
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7740918819B4
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C647421CA0D;
	Mon,  7 Apr 2025 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MITHkW4d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A0521C19C;
	Mon,  7 Apr 2025 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049962; cv=none; b=tBZ8a4SqaVEnODBWEM4EnulJ1rtUnvp0ea64H2QTm8CjJRpsnVo5jCvYh4I9sj2IbJS2KLyfCV6gNyNgWEI5/wptlebj+abP/tJdf5NwFNEnJTF3K2/0IvS0AXdX56YO1fiULMDIJgHRcyibVBKrCYPPpDLBzazcWlVrv8DwSHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049962; c=relaxed/simple;
	bh=rBlHWm98sN38kK8Uh4zkts9r9GzgSlhUaJr7PKZVXV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jms6CCkRC5Jjrl9Mnt8gsxlxPuQpq32DTSJ3kC6muJfwLNijqWCAmkg4wT1Q2XN/Bol63W9g4KvgnbNZBU7v9ZCv/aFl614/8f5YXOyZQhXQyR90OHtkXKvlbeeFaTj725z96KXxAe948PavFWVkGqutUXlu7DmHof+V47UM/yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MITHkW4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A450C4CEE7;
	Mon,  7 Apr 2025 18:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049962;
	bh=rBlHWm98sN38kK8Uh4zkts9r9GzgSlhUaJr7PKZVXV0=;
	h=From:To:Cc:Subject:Date:From;
	b=MITHkW4dyLrwkcsuypypFdOQ32TLtbtSujbclvZcyJPSAB6GqaxmCzbqwDoX3vids
	 J5PajsBFOydcnmAumciqYwQWwiu3DKGIsFBZd48QDB6HSqYzmHok1ei9teMScmMzCh
	 JhT+9pLNeNtG1udTNHWcy/0KWguzQm+O22Ii1u1ne6mIhGNe+OeQaFpR/NbjIM98t9
	 zIPTf/sx84CxXF0e4GSRZZhDFS9/pPGpmeo+JBMPwsSxlJ8mPoSci/roMcCMY+Vild
	 S3CgCgY55QKRlbTEgMd798a8n5ldpejHtSISL1P0eNnpYHx1um29yXT7NHPGuLS6jX
	 ggCYD7NhSJm7g==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	Shyam-sundar.S-k@amd.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: Yijun Shen <Yijun.Shen@dell.com>,
	stable@vger.kernel.org,
	Yijun Shen <Yijun_Shen@Dell.com>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v3] platform/x86: amd: pmf: Fix STT limits
Date: Mon,  7 Apr 2025 13:18:21 -0500
Message-ID: <20250407181915.1482450-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

On some platforms it has been observed that STT limits are not being
applied properly causing poor performance as power limits are set too low.

STT limits that are sent to the platform are supposed to be in Q8.8
format.  Convert them before sending.

Reported-by: Yijun Shen <Yijun.Shen@dell.com>
Fixes: 7c45534afa443 ("platform/x86/amd/pmf: Add support for PMF Policy Binary")
Cc: stable@vger.kernel.org
Tested-by: Yijun Shen <Yijun_Shen@Dell.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * Add a helper with a generic name (so it can be easily be moved to library
   code in the future)
---
 drivers/platform/x86/amd/pmf/auto-mode.c |  4 ++--
 drivers/platform/x86/amd/pmf/cnqf.c      |  8 ++++----
 drivers/platform/x86/amd/pmf/core.c      | 14 ++++++++++++++
 drivers/platform/x86/amd/pmf/pmf.h       |  1 +
 drivers/platform/x86/amd/pmf/sps.c       | 12 ++++++++----
 drivers/platform/x86/amd/pmf/tee-if.c    |  6 ++++--
 6 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/auto-mode.c b/drivers/platform/x86/amd/pmf/auto-mode.c
index 02ff68be10d01..1400ac70c52d1 100644
--- a/drivers/platform/x86/amd/pmf/auto-mode.c
+++ b/drivers/platform/x86/amd/pmf/auto-mode.c
@@ -120,9 +120,9 @@ static void amd_pmf_set_automode(struct amd_pmf_dev *dev, int idx,
 	amd_pmf_send_cmd(dev, SET_SPPT_APU_ONLY, false, pwr_ctrl->sppt_apu_only, NULL);
 	amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false, pwr_ctrl->stt_min, NULL);
 	amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
-			 pwr_ctrl->stt_skin_temp[STT_TEMP_APU], NULL);
+			 fixp_q88_from_integer(pwr_ctrl->stt_skin_temp[STT_TEMP_APU]), NULL);
 	amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
-			 pwr_ctrl->stt_skin_temp[STT_TEMP_HS2], NULL);
+			 fixp_q88_from_integer(pwr_ctrl->stt_skin_temp[STT_TEMP_HS2]), NULL);
 
 	if (is_apmf_func_supported(dev, APMF_FUNC_SET_FAN_IDX))
 		apmf_update_fan_idx(dev, config_store.mode_set[idx].fan_control.manual,
diff --git a/drivers/platform/x86/amd/pmf/cnqf.c b/drivers/platform/x86/amd/pmf/cnqf.c
index bc8899e15c914..3cde8a5de64a9 100644
--- a/drivers/platform/x86/amd/pmf/cnqf.c
+++ b/drivers/platform/x86/amd/pmf/cnqf.c
@@ -81,10 +81,10 @@ static int amd_pmf_set_cnqf(struct amd_pmf_dev *dev, int src, int idx,
 	amd_pmf_send_cmd(dev, SET_SPPT, false, pc->sppt, NULL);
 	amd_pmf_send_cmd(dev, SET_SPPT_APU_ONLY, false, pc->sppt_apu_only, NULL);
 	amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false, pc->stt_min, NULL);
-	amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false, pc->stt_skin_temp[STT_TEMP_APU],
-			 NULL);
-	amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false, pc->stt_skin_temp[STT_TEMP_HS2],
-			 NULL);
+	amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
+			 fixp_q88_from_integer(pc->stt_skin_temp[STT_TEMP_APU]), NULL);
+	amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
+			 fixp_q88_from_integer(pc->stt_skin_temp[STT_TEMP_HS2]), NULL);
 
 	if (is_apmf_func_supported(dev, APMF_FUNC_SET_FAN_IDX))
 		apmf_update_fan_idx(dev,
diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index a2cb2d5544f5b..5209996eba674 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -176,6 +176,20 @@ static void __maybe_unused amd_pmf_dump_registers(struct amd_pmf_dev *dev)
 	dev_dbg(dev->dev, "AMD_PMF_REGISTER_MESSAGE:%x\n", value);
 }
 
+/**
+ * fixp_q88_from_integer: Convert integer to Q8.8
+ * @val: input value
+ *
+ * Converts an integer into binary fixed point format where 8 bits
+ * are used for integer and 8 bits are used for the decimal.
+ *
+ * Return: unsigned integer converted to Q8.8 format
+ */
+u32 fixp_q88_from_integer(u32 val)
+{
+	return val << 8;
+}
+
 int amd_pmf_send_cmd(struct amd_pmf_dev *dev, u8 message, bool get, u32 arg, u32 *data)
 {
 	int rc;
diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/amd/pmf/pmf.h
index e6bdee68ccf34..2865e0a70b43d 100644
--- a/drivers/platform/x86/amd/pmf/pmf.h
+++ b/drivers/platform/x86/amd/pmf/pmf.h
@@ -777,6 +777,7 @@ int apmf_install_handler(struct amd_pmf_dev *pmf_dev);
 int apmf_os_power_slider_update(struct amd_pmf_dev *dev, u8 flag);
 int amd_pmf_set_dram_addr(struct amd_pmf_dev *dev, bool alloc_buffer);
 int amd_pmf_notify_sbios_heartbeat_event_v2(struct amd_pmf_dev *dev, u8 flag);
+u32 fixp_q88_from_integer(u32 val);
 
 /* SPS Layer */
 int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf);
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index d3083383f11fb..dfc5285b681f7 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -198,9 +198,11 @@ static void amd_pmf_update_slider_v2(struct amd_pmf_dev *dev, int idx)
 	amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false,
 			 apts_config_store.val[idx].stt_min_limit, NULL);
 	amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
-			 apts_config_store.val[idx].stt_skin_temp_limit_apu, NULL);
+			 fixp_q88_from_integer(apts_config_store.val[idx].stt_skin_temp_limit_apu),
+			 NULL);
 	amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
-			 apts_config_store.val[idx].stt_skin_temp_limit_hs2, NULL);
+			 fixp_q88_from_integer(apts_config_store.val[idx].stt_skin_temp_limit_hs2),
+			 NULL);
 }
 
 void amd_pmf_update_slider(struct amd_pmf_dev *dev, bool op, int idx,
@@ -217,9 +219,11 @@ void amd_pmf_update_slider(struct amd_pmf_dev *dev, bool op, int idx,
 		amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false,
 				 config_store.prop[src][idx].stt_min, NULL);
 		amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
-				 config_store.prop[src][idx].stt_skin_temp[STT_TEMP_APU], NULL);
+				 fixp_q88_from_integer(config_store.prop[src][idx].stt_skin_temp[STT_TEMP_APU]),
+				 NULL);
 		amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
-				 config_store.prop[src][idx].stt_skin_temp[STT_TEMP_HS2], NULL);
+				 fixp_q88_from_integer(config_store.prop[src][idx].stt_skin_temp[STT_TEMP_HS2]),
+				 NULL);
 	} else if (op == SLIDER_OP_GET) {
 		amd_pmf_send_cmd(dev, GET_SPL, true, ARG_NONE, &table->prop[src][idx].spl);
 		amd_pmf_send_cmd(dev, GET_FPPT, true, ARG_NONE, &table->prop[src][idx].fppt);
diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
index a1e43873a07b0..22d48048f9d01 100644
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -123,7 +123,8 @@ static void amd_pmf_apply_policies(struct amd_pmf_dev *dev, struct ta_pmf_enact_
 
 		case PMF_POLICY_STT_SKINTEMP_APU:
 			if (dev->prev_data->stt_skintemp_apu != val) {
-				amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false, val, NULL);
+				amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
+						 fixp_q88_from_integer(val), NULL);
 				dev_dbg(dev->dev, "update STT_SKINTEMP_APU: %u\n", val);
 				dev->prev_data->stt_skintemp_apu = val;
 			}
@@ -131,7 +132,8 @@ static void amd_pmf_apply_policies(struct amd_pmf_dev *dev, struct ta_pmf_enact_
 
 		case PMF_POLICY_STT_SKINTEMP_HS2:
 			if (dev->prev_data->stt_skintemp_hs2 != val) {
-				amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false, val, NULL);
+				amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
+						 fixp_q88_from_integer(val), NULL);
 				dev_dbg(dev->dev, "update STT_SKINTEMP_HS2: %u\n", val);
 				dev->prev_data->stt_skintemp_hs2 = val;
 			}
-- 
2.43.0


