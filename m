Return-Path: <stable+bounces-135687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11526A98FC6
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782B93ADF3F
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90042284681;
	Wed, 23 Apr 2025 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NhdsjbnP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0F020D4F8;
	Wed, 23 Apr 2025 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420580; cv=none; b=tlPPlXpHoL1tH3o73GATDznESh+nKiCwEFMu+fyRi3W5Digp5F9soOnT66vcG47LH3smXD0mpwhi5xd4fHcvPUAChwAT+D2NOLAycOS/eySiD1qDlKOMoKv3or06aMkyFtB1aP1vVuwxFrD+Mjh9ygTUxBm7w53y2T6i8Pn4zlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420580; c=relaxed/simple;
	bh=LPtVh8LKwkY+DThY7fvW7Ue/yAtuMdLnjnL0STEtjiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwJS1usaRO/j/SBDTGcdrfFQbiYC+C/PEpaQnpO+hD+NDUD9/ncqv6fKemk8dSZwqrdiiEYl6IYqKTOGFdW9l64CaljIyzH/StBEebhMowkzq6n/hJvQmw3+hyzSAd0ziovtmPP2eBH2roBwU9JKo0m4EONTPQRUIeFiZPiMyBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NhdsjbnP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE4EC4CEE2;
	Wed, 23 Apr 2025 15:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420579;
	bh=LPtVh8LKwkY+DThY7fvW7Ue/yAtuMdLnjnL0STEtjiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NhdsjbnPVe4BExkrDDkkHqFUh3A+qm5w1qQYR+1FXX6zHCKFIFayHBVALxQTb9ZSY
	 3lYJZKIVHcBsgjsNIqu/X4yP5EXFMgYB4Vj6OC/XSvruc3zkJ8jfJu9ePxD4B9X42I
	 klYNi/CWQLYmu6K/UHuYZOSS5doL5kPUu4AG7pOQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yijun Shen <Yijun.Shen@dell.com>,
	Yijun Shen <Yijun_Shen@Dell.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.12 143/223] platform/x86: amd: pmf: Fix STT limits
Date: Wed, 23 Apr 2025 16:43:35 +0200
Message-ID: <20250423142623.010978071@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
References: <20250423142617.120834124@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit fcf27a6a926fd9eeba39e9c3fde43c9298fe284e upstream.

On some platforms it has been observed that STT limits are not being
applied properly causing poor performance as power limits are set too low.

STT limits that are sent to the platform are supposed to be in Q8.8
format.  Convert them before sending.

Reported-by: Yijun Shen <Yijun.Shen@dell.com>
Fixes: 7c45534afa443 ("platform/x86/amd/pmf: Add support for PMF Policy Binary")
Cc: stable@vger.kernel.org
Tested-by: Yijun Shen <Yijun_Shen@Dell.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20250407181915.1482450-1-superm1@kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/amd/pmf/auto-mode.c |    4 ++--
 drivers/platform/x86/amd/pmf/cnqf.c      |    8 ++++----
 drivers/platform/x86/amd/pmf/core.c      |   14 ++++++++++++++
 drivers/platform/x86/amd/pmf/pmf.h       |    1 +
 drivers/platform/x86/amd/pmf/sps.c       |   12 ++++++++----
 drivers/platform/x86/amd/pmf/tee-if.c    |    6 ++++--
 6 files changed, 33 insertions(+), 12 deletions(-)

--- a/drivers/platform/x86/amd/pmf/auto-mode.c
+++ b/drivers/platform/x86/amd/pmf/auto-mode.c
@@ -120,9 +120,9 @@ static void amd_pmf_set_automode(struct
 	amd_pmf_send_cmd(dev, SET_SPPT_APU_ONLY, false, pwr_ctrl->sppt_apu_only, NULL);
 	amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false, pwr_ctrl->stt_min, NULL);
 	amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
-			 pwr_ctrl->stt_skin_temp[STT_TEMP_APU], NULL);
+			 fixp_q88_fromint(pwr_ctrl->stt_skin_temp[STT_TEMP_APU]), NULL);
 	amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
-			 pwr_ctrl->stt_skin_temp[STT_TEMP_HS2], NULL);
+			 fixp_q88_fromint(pwr_ctrl->stt_skin_temp[STT_TEMP_HS2]), NULL);
 
 	if (is_apmf_func_supported(dev, APMF_FUNC_SET_FAN_IDX))
 		apmf_update_fan_idx(dev, config_store.mode_set[idx].fan_control.manual,
--- a/drivers/platform/x86/amd/pmf/cnqf.c
+++ b/drivers/platform/x86/amd/pmf/cnqf.c
@@ -81,10 +81,10 @@ static int amd_pmf_set_cnqf(struct amd_p
 	amd_pmf_send_cmd(dev, SET_SPPT, false, pc->sppt, NULL);
 	amd_pmf_send_cmd(dev, SET_SPPT_APU_ONLY, false, pc->sppt_apu_only, NULL);
 	amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false, pc->stt_min, NULL);
-	amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false, pc->stt_skin_temp[STT_TEMP_APU],
-			 NULL);
-	amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false, pc->stt_skin_temp[STT_TEMP_HS2],
-			 NULL);
+	amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
+			 fixp_q88_fromint(pc->stt_skin_temp[STT_TEMP_APU]), NULL);
+	amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
+			 fixp_q88_fromint(pc->stt_skin_temp[STT_TEMP_HS2]), NULL);
 
 	if (is_apmf_func_supported(dev, APMF_FUNC_SET_FAN_IDX))
 		apmf_update_fan_idx(dev,
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -176,6 +176,20 @@ static void __maybe_unused amd_pmf_dump_
 	dev_dbg(dev->dev, "AMD_PMF_REGISTER_MESSAGE:%x\n", value);
 }
 
+/**
+ * fixp_q88_fromint: Convert integer to Q8.8
+ * @val: input value
+ *
+ * Converts an integer into binary fixed point format where 8 bits
+ * are used for integer and 8 bits are used for the decimal.
+ *
+ * Return: unsigned integer converted to Q8.8 format
+ */
+u32 fixp_q88_fromint(u32 val)
+{
+	return val << 8;
+}
+
 int amd_pmf_send_cmd(struct amd_pmf_dev *dev, u8 message, bool get, u32 arg, u32 *data)
 {
 	int rc;
--- a/drivers/platform/x86/amd/pmf/pmf.h
+++ b/drivers/platform/x86/amd/pmf/pmf.h
@@ -746,6 +746,7 @@ int apmf_install_handler(struct amd_pmf_
 int apmf_os_power_slider_update(struct amd_pmf_dev *dev, u8 flag);
 int amd_pmf_set_dram_addr(struct amd_pmf_dev *dev, bool alloc_buffer);
 int amd_pmf_notify_sbios_heartbeat_event_v2(struct amd_pmf_dev *dev, u8 flag);
+u32 fixp_q88_fromint(u32 val);
 
 /* SPS Layer */
 int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf);
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -198,9 +198,11 @@ static void amd_pmf_update_slider_v2(str
 	amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false,
 			 apts_config_store.val[idx].stt_min_limit, NULL);
 	amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
-			 apts_config_store.val[idx].stt_skin_temp_limit_apu, NULL);
+			 fixp_q88_fromint(apts_config_store.val[idx].stt_skin_temp_limit_apu),
+			 NULL);
 	amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
-			 apts_config_store.val[idx].stt_skin_temp_limit_hs2, NULL);
+			 fixp_q88_fromint(apts_config_store.val[idx].stt_skin_temp_limit_hs2),
+			 NULL);
 }
 
 void amd_pmf_update_slider(struct amd_pmf_dev *dev, bool op, int idx,
@@ -217,9 +219,11 @@ void amd_pmf_update_slider(struct amd_pm
 		amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false,
 				 config_store.prop[src][idx].stt_min, NULL);
 		amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
-				 config_store.prop[src][idx].stt_skin_temp[STT_TEMP_APU], NULL);
+				 fixp_q88_fromint(config_store.prop[src][idx].stt_skin_temp[STT_TEMP_APU]),
+				 NULL);
 		amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
-				 config_store.prop[src][idx].stt_skin_temp[STT_TEMP_HS2], NULL);
+				 fixp_q88_fromint(config_store.prop[src][idx].stt_skin_temp[STT_TEMP_HS2]),
+				 NULL);
 	} else if (op == SLIDER_OP_GET) {
 		amd_pmf_send_cmd(dev, GET_SPL, true, ARG_NONE, &table->prop[src][idx].spl);
 		amd_pmf_send_cmd(dev, GET_FPPT, true, ARG_NONE, &table->prop[src][idx].fppt);
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -123,7 +123,8 @@ static void amd_pmf_apply_policies(struc
 
 		case PMF_POLICY_STT_SKINTEMP_APU:
 			if (dev->prev_data->stt_skintemp_apu != val) {
-				amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false, val, NULL);
+				amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
+						 fixp_q88_fromint(val), NULL);
 				dev_dbg(dev->dev, "update STT_SKINTEMP_APU: %u\n", val);
 				dev->prev_data->stt_skintemp_apu = val;
 			}
@@ -131,7 +132,8 @@ static void amd_pmf_apply_policies(struc
 
 		case PMF_POLICY_STT_SKINTEMP_HS2:
 			if (dev->prev_data->stt_skintemp_hs2 != val) {
-				amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false, val, NULL);
+				amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
+						 fixp_q88_fromint(val), NULL);
 				dev_dbg(dev->dev, "update STT_SKINTEMP_HS2: %u\n", val);
 				dev->prev_data->stt_skintemp_hs2 = val;
 			}



