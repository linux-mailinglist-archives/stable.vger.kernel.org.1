Return-Path: <stable+bounces-52662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0AB90CA4C
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BE6CB27BBD
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 11:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA46E19CD1F;
	Tue, 18 Jun 2024 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6qXp5mx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92BA19CD14
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718708983; cv=none; b=UwYs7mjWY7mIM0ZLxS6tO18IB/xsenB4oYLVAHpd+8oduEQrfrD/x3UQNDj9s9B5g5PtnhOOF+qwCw7EmirfX1OIRGe7sDX/yLeVxP3EH303cXmP8+sVb95RjHBqnoO6xnBs2fjcx6llxnF8IJD4s0pgO4rVsJu7rRbnJ/dbJb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718708983; c=relaxed/simple;
	bh=lF1z6VCJM5UVgkQmuyfVEpEddQRivDshBtGqTE8MQDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RIVBlc7XktST4nSo7CNhnR4MU8KhjteraHS28RB52DyiF+PanDgpa2MtJ2RgNuxTwdi89Dna7Hc+wzrWtn3FqN64Dps9Cz4PEXpbiQ1/Q9Di68XmXHP/68KYJLMlwIf2lHh2M2Q6OFWR92H0lcUMf9pWxkid+1unhMR6Vg8FBCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V6qXp5mx; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718708982; x=1750244982;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lF1z6VCJM5UVgkQmuyfVEpEddQRivDshBtGqTE8MQDk=;
  b=V6qXp5mxma/SZIRX92dcleTwZXxZJoFsWRRIXRTFZcIKJts/nSlZNOli
   nXWz17fmn212NzABBgQHrEk6usuUWv3wyw5tdYlpPqIIlb/zcIiNg8hrP
   n08noPVA4JI9eNwSSvgsl+ZO/mSsASlzO1g+28kYsR5TF8l1xVWMM+Yf6
   QwRZgXkFPh6A3Tle5IKLGsGD1hGUaKj244ZDv8G0cYvz7EnVkuPysQLLi
   +8NXJYauoi/kVCH+3aTZqICs2s7CpeGg6qaJ739P4d/kCfy1pjeqNL35d
   EccA2VfWzDbBXIL+eoK7LBsy3GcHd6YV91SPR2jQGcHuplUk0hcxOBYYA
   g==;
X-CSE-ConnectionGUID: 1qsE4MYxRJq6lu7YalCVcw==
X-CSE-MsgGUID: opm5orhgTvSpi+RKLdWiLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="26992530"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26992530"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 04:09:39 -0700
X-CSE-ConnectionGUID: 5YE4Q74LTTWoSK7rNsmyPQ==
X-CSE-MsgGUID: MoixhJn/SgGpu1YTiBNTVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="72262531"
Received: from egrumbac-mobl1.ger.corp.intel.com (HELO egrumbac-mobl1.intel.com) ([10.245.249.213])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 04:09:38 -0700
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.9 1/2] wifi: iwlwifi: mvm: support iwl_dev_tx_power_cmd_v8
Date: Tue, 18 Jun 2024 14:09:23 +0300
Message-ID: <20240618110924.24509-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 8f892e225f416fcf2b55a0f9161162e08e2b0cc7 upstream.

This just adds a __le32 that we (currently) don't use.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218963
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240319100755.29ff7a88ddac.I39cf2ff1d1ddf0fa62722538698dc7f21aaaf39e@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 30 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  4 ++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 ++-
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 0bf38243f88a..ce18ef9d3128 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -385,6 +385,33 @@ struct iwl_dev_tx_power_cmd_v7 {
 	__le32 timer_period;
 	__le32 flags;
 } __packed; /* TX_REDUCED_POWER_API_S_VER_7 */
+
+/**
+ * struct iwl_dev_tx_power_cmd_v8 - TX power reduction command version 8
+ * @per_chain: per chain restrictions
+ * @enable_ack_reduction: enable or disable close range ack TX power
+ *	reduction.
+ * @per_chain_restriction_changed: is per_chain_restriction has changed
+ *	from last command. used if set_mode is
+ *	IWL_TX_POWER_MODE_SET_SAR_TIMER.
+ *	note: if not changed, the command is used for keep alive only.
+ * @reserved: reserved (padding)
+ * @timer_period: timer in milliseconds. if expires FW will change to default
+ *	BIOS values. relevant if setMode is IWL_TX_POWER_MODE_SET_SAR_TIMER
+ * @flags: reduce power flags.
+ * @tpc_vlp_backoff_level: user backoff of UNII5,7 VLP channels in USA.
+ *	Not in use.
+ */
+struct iwl_dev_tx_power_cmd_v8 {
+	__le16 per_chain[IWL_NUM_CHAIN_TABLES_V2][IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V2];
+	u8 enable_ack_reduction;
+	u8 per_chain_restriction_changed;
+	u8 reserved[2];
+	__le32 timer_period;
+	__le32 flags;
+	__le32 tpc_vlp_backoff_level;
+} __packed; /* TX_REDUCED_POWER_API_S_VER_8 */
+
 /**
  * struct iwl_dev_tx_power_cmd - TX power reduction command (multiversion)
  * @common: common part of the command
@@ -392,6 +419,8 @@ struct iwl_dev_tx_power_cmd_v7 {
  * @v4: version 4 part of the command
  * @v5: version 5 part of the command
  * @v6: version 6 part of the command
+ * @v7: version 7 part of the command
+ * @v8: version 8 part of the command
  */
 struct iwl_dev_tx_power_cmd {
 	struct iwl_dev_tx_power_common common;
@@ -401,6 +430,7 @@ struct iwl_dev_tx_power_cmd {
 		struct iwl_dev_tx_power_cmd_v5 v5;
 		struct iwl_dev_tx_power_cmd_v6 v6;
 		struct iwl_dev_tx_power_cmd_v7 v7;
+		struct iwl_dev_tx_power_cmd_v8 v8;
 	};
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index e1c2b7fc92ab..df3b29b998cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -896,11 +896,13 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 	u32 n_subbands;
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
 					   IWL_FW_CMD_VER_UNKNOWN);
-	if (cmd_ver == 7) {
+	if (cmd_ver >= 7) {
 		len = sizeof(cmd.v7);
 		n_subbands = IWL_NUM_SUB_BANDS_V2;
 		per_chain = cmd.v7.per_chain[0][0];
 		cmd.v7.flags = cpu_to_le32(mvm->fwrt.reduced_power_flags);
+		if (cmd_ver == 8)
+			len = sizeof(cmd.v8);
 	} else if (cmd_ver == 6) {
 		len = sizeof(cmd.v6);
 		n_subbands = IWL_NUM_SUB_BANDS_V2;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 7ed7444c9871..2403ac2fcdc3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1399,7 +1399,9 @@ int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (tx_power == IWL_DEFAULT_MAX_TX_POWER)
 		cmd.common.pwr_restriction = cpu_to_le16(IWL_DEV_MAX_TX_POWER);
 
-	if (cmd_ver == 7)
+	if (cmd_ver == 8)
+		len = sizeof(cmd.v8);
+	else if (cmd_ver == 7)
 		len = sizeof(cmd.v7);
 	else if (cmd_ver == 6)
 		len = sizeof(cmd.v6);
-- 
2.45.2


