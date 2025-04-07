Return-Path: <stable+bounces-128542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC1EA7DF93
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 15:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762181696E0
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 13:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6F61A287E;
	Mon,  7 Apr 2025 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDrj0VYp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFFB1A23AD;
	Mon,  7 Apr 2025 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033031; cv=none; b=T+0c70F1LbRYbRqf8tFKYlhbCdHmJabO7b/TjmaC6p42CY6gHLURbkS2haeJI47qDlUefY1tU29Qg+p0EgnY/Z1S8u+BP+7fRpuZCEOXZuyiA+6HNV8EmteHfHMgajWcg6qkrQyheHXwnfgHKkfpwfL/K9Nmcr2iYBRQnZgFMRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033031; c=relaxed/simple;
	bh=ojoaa/oRMtKL1QU8BXTxKKy9okgmuxLbcMMDvyCPil4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D+3v+k2Pgix6LDbPQ9sz5xOuZgmAANjo7SZV7yZ4t60tymZI9KeTUTLFBGZopuj/CaISpvGQpGWPp/mM9fRKnWtg1wcwGD4L8qJew8IhCrq16KtPX9lcop5SrpzP5wVfU7x2XfHcK5zy4OK7CMXJ2DqsczkRl4OaDlPMTjVAbeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDrj0VYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BCDC4CEED;
	Mon,  7 Apr 2025 13:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744033030;
	bh=ojoaa/oRMtKL1QU8BXTxKKy9okgmuxLbcMMDvyCPil4=;
	h=From:To:Cc:Subject:Date:From;
	b=LDrj0VYpD7lRJCsYtOH4eCk93evFg+J9fcqSEtbG1qf7VgxFs0j3/RUAhieg/KQyR
	 zXJJAhyZ0lmkuhUMUHH+/m9p4WaUwHGdGte7Rk7teymDUrIm/AhnqCUX5VisnqTPM3
	 +BgthCxXnatAQIdLeUFo8AaLkSr/tQirprusN2qSA9dMdXDU4FAcrbz16Q4gj2tmx0
	 2hxhwqG/UUKIcFaRkHQheAfwUv8CnsS9zFngpTJwRIwTFEtOk0Ibf7vaKe7mSRwXQZ
	 NdMVGHLdQDDOtaDZmVSeS+qDuGlqb30+nTkMNgHnMv8kw+8cQPl4f0T/xbSNhEhxuG
	 mqsNa9raoRvfg==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	Shyam-sundar.S-k@amd.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: Yijun Shen <Yijun.Shen@dell.com>,
	stable@vger.kernel.org,
	Yijun Shen <Yijun_Shen@Dell.com>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v2] platform/x86: amd: pmf: Fix STT limits
Date: Mon,  7 Apr 2025 08:36:37 -0500
Message-ID: <20250407133645.783434-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

On some platforms it has been observed that STT limits are not being applied
properly causing poor performance as power limits are set too low.

STT limits that are sent to the platform are supposed to be in Q8.8
format.  Convert them before sending.

Reported-by: Yijun Shen <Yijun.Shen@dell.com>
Fixes: 7c45534afa443 ("platform/x86/amd/pmf: Add support for PMF Policy Binary")
Cc: stable@vger.kernel.org
Tested-By: Yijun Shen <Yijun_Shen@Dell.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Handle cases for auto-mode, cnqf, and sps as well
---
 drivers/platform/x86/amd/pmf/auto-mode.c | 4 ++--
 drivers/platform/x86/amd/pmf/cnqf.c      | 4 ++--
 drivers/platform/x86/amd/pmf/sps.c       | 8 ++++----
 drivers/platform/x86/amd/pmf/tee-if.c    | 4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/auto-mode.c b/drivers/platform/x86/amd/pmf/auto-mode.c
index 02ff68be10d01..df37f8a84a007 100644
--- a/drivers/platform/x86/amd/pmf/auto-mode.c
+++ b/drivers/platform/x86/amd/pmf/auto-mode.c
@@ -120,9 +120,9 @@ static void amd_pmf_set_automode(struct amd_pmf_dev *dev, int idx,
 	amd_pmf_send_cmd(dev, SET_SPPT_APU_ONLY, false, pwr_ctrl->sppt_apu_only, NULL);
 	amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false, pwr_ctrl->stt_min, NULL);
 	amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
-			 pwr_ctrl->stt_skin_temp[STT_TEMP_APU], NULL);
+			 pwr_ctrl->stt_skin_temp[STT_TEMP_APU] << 8, NULL);
 	amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
-			 pwr_ctrl->stt_skin_temp[STT_TEMP_HS2], NULL);
+			 pwr_ctrl->stt_skin_temp[STT_TEMP_HS2] << 8, NULL);
 
 	if (is_apmf_func_supported(dev, APMF_FUNC_SET_FAN_IDX))
 		apmf_update_fan_idx(dev, config_store.mode_set[idx].fan_control.manual,
diff --git a/drivers/platform/x86/amd/pmf/cnqf.c b/drivers/platform/x86/amd/pmf/cnqf.c
index bc8899e15c914..6a5ecc05961d9 100644
--- a/drivers/platform/x86/amd/pmf/cnqf.c
+++ b/drivers/platform/x86/amd/pmf/cnqf.c
@@ -81,9 +81,9 @@ static int amd_pmf_set_cnqf(struct amd_pmf_dev *dev, int src, int idx,
 	amd_pmf_send_cmd(dev, SET_SPPT, false, pc->sppt, NULL);
 	amd_pmf_send_cmd(dev, SET_SPPT_APU_ONLY, false, pc->sppt_apu_only, NULL);
 	amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false, pc->stt_min, NULL);
-	amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false, pc->stt_skin_temp[STT_TEMP_APU],
+	amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false, pc->stt_skin_temp[STT_TEMP_APU] << 8,
 			 NULL);
-	amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false, pc->stt_skin_temp[STT_TEMP_HS2],
+	amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false, pc->stt_skin_temp[STT_TEMP_HS2] << 8,
 			 NULL);
 
 	if (is_apmf_func_supported(dev, APMF_FUNC_SET_FAN_IDX))
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index d3083383f11fb..ec10db1bfa5ec 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -198,9 +198,9 @@ static void amd_pmf_update_slider_v2(struct amd_pmf_dev *dev, int idx)
 	amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false,
 			 apts_config_store.val[idx].stt_min_limit, NULL);
 	amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
-			 apts_config_store.val[idx].stt_skin_temp_limit_apu, NULL);
+			 apts_config_store.val[idx].stt_skin_temp_limit_apu << 8, NULL);
 	amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
-			 apts_config_store.val[idx].stt_skin_temp_limit_hs2, NULL);
+			 apts_config_store.val[idx].stt_skin_temp_limit_hs2 << 8, NULL);
 }
 
 void amd_pmf_update_slider(struct amd_pmf_dev *dev, bool op, int idx,
@@ -217,9 +217,9 @@ void amd_pmf_update_slider(struct amd_pmf_dev *dev, bool op, int idx,
 		amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false,
 				 config_store.prop[src][idx].stt_min, NULL);
 		amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
-				 config_store.prop[src][idx].stt_skin_temp[STT_TEMP_APU], NULL);
+				 config_store.prop[src][idx].stt_skin_temp[STT_TEMP_APU] << 8, NULL);
 		amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
-				 config_store.prop[src][idx].stt_skin_temp[STT_TEMP_HS2], NULL);
+				 config_store.prop[src][idx].stt_skin_temp[STT_TEMP_HS2] << 8, NULL);
 	} else if (op == SLIDER_OP_GET) {
 		amd_pmf_send_cmd(dev, GET_SPL, true, ARG_NONE, &table->prop[src][idx].spl);
 		amd_pmf_send_cmd(dev, GET_FPPT, true, ARG_NONE, &table->prop[src][idx].fppt);
diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
index d6a871f0d8ff2..7096923107929 100644
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -142,7 +142,7 @@ static void amd_pmf_apply_policies(struct amd_pmf_dev *dev, struct ta_pmf_enact_
 
 		case PMF_POLICY_STT_SKINTEMP_APU:
 			if (dev->prev_data->stt_skintemp_apu != val) {
-				amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false, val, NULL);
+				amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false, val << 8, NULL);
 				dev_dbg(dev->dev, "update STT_SKINTEMP_APU: %u\n", val);
 				dev->prev_data->stt_skintemp_apu = val;
 			}
@@ -150,7 +150,7 @@ static void amd_pmf_apply_policies(struct amd_pmf_dev *dev, struct ta_pmf_enact_
 
 		case PMF_POLICY_STT_SKINTEMP_HS2:
 			if (dev->prev_data->stt_skintemp_hs2 != val) {
-				amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false, val, NULL);
+				amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false, val << 8, NULL);
 				dev_dbg(dev->dev, "update STT_SKINTEMP_HS2: %u\n", val);
 				dev->prev_data->stt_skintemp_hs2 = val;
 			}
-- 
2.43.0


