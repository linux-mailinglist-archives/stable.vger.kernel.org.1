Return-Path: <stable+bounces-105612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA279FAE2D
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 13:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0571629BB
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 12:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E521A8F62;
	Mon, 23 Dec 2024 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjv8Xu65"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4691A0721
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734956060; cv=none; b=HYQ1LvaVpzmMUqXb6cPZe0mYlJWu9L8thXa7xLX+dCF8vFyYgchsa2SHseqXL0KH5NB4oamLxF8AO0bVbjV2e5VNW2mrAwhellZCF+eB6I/32aZ41rF0RO3oWOclr3wTSbSzSNDhbYR994q0uNjPLA0gSvhHFZJWikSXDXlY4K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734956060; c=relaxed/simple;
	bh=Puv4pPYZGB7fdIacwZtXr6sZZGDQiaZrU3Iz5mE9+Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+milK3UO88SWrZ9qEuCLPJQsbv1DwU49bZeoSJLfaCmuoY5lqSXGcfb0jm6+i7xiP+/q38Bpxn4Kc8Lpf8Fmy0ILsI043I6HOQmQg/4rTjSZpg8W7NLqi5gdcgo420AlE4RmMHyLUyP1PMVhPqYOI/DgmF+3ejq7WJ7YANv/jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mjv8Xu65; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734956058; x=1766492058;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Puv4pPYZGB7fdIacwZtXr6sZZGDQiaZrU3Iz5mE9+Cc=;
  b=mjv8Xu65E43BNhakUOdLVYxp+LzZO0m2Yisur+kDTLh5BOdwFVxBzulS
   h3geO5uxB6YKXCTvPTmlqXLSz+NDHhTFpRv/FFbIPVhhmRe2+Xvm7r6og
   oolW9RL8n8iR6xCbzsYlTUbqVuWrLUPgajtCVfhZx/7DcD7Te3sKuozZl
   cr8xO40czNHD8aGqFQlVhM0pYekFplLuV68CLXGVznDmshxDLKA/u5QEu
   zpQfWpQabqskOdy6aaVIjam29BSrdg0a2Md8bDB1zbBlydEAqBjDYwMIj
   6S0j7FPPg86aOMDjFpFFrh9eyCbq52MWg2YVsl1V+nkWzPSxMsRfD+BN6
   g==;
X-CSE-ConnectionGUID: JmKJk/JMTg2KbERygI1Eug==
X-CSE-MsgGUID: CTrKE+ZVSp6YG0+S58qPvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="57883513"
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="57883513"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 04:14:17 -0800
X-CSE-ConnectionGUID: AAi/HchURMilwSNGbADxWQ==
X-CSE-MsgGUID: gza/8QBYR6GBM1IRMlcK2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="99712189"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO egrumbac-mobl6.intel.com) ([10.245.248.98])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 04:14:14 -0800
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.12] wifi: iwlwifi: be less noisy if the NIC is dead in S3
Date: Mon, 23 Dec 2024 14:13:59 +0200
Message-ID: <20241223121359.65312-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 0572b7715ffd2cac20aac00333706f3094028180 upstream

If the NIC is dead upon resume, try to catch the error earlier and exit
earlier. We'll print less error messages and get to the same recovery
path as before: reload the firmware.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20241028135215.3a18682261e5.I18f336a4537378a4c1a8537d7246cee1fc82b42c@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219597
---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 13 +++++----
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 28 ++++++++++++++-----
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  2 ++
 3 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index e95ffe303547..c70da7281551 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1074,12 +1074,13 @@ int iwl_trans_read_config32(struct iwl_trans *trans, u32 ofs,
 void iwl_trans_debugfs_cleanup(struct iwl_trans *trans);
 #endif
 
-#define iwl_trans_read_mem_bytes(trans, addr, buf, bufsize)		      \
-	do {								      \
-		if (__builtin_constant_p(bufsize))			      \
-			BUILD_BUG_ON((bufsize) % sizeof(u32));		      \
-		iwl_trans_read_mem(trans, addr, buf, (bufsize) / sizeof(u32));\
-	} while (0)
+#define iwl_trans_read_mem_bytes(trans, addr, buf, bufsize)	\
+	({							\
+		if (__builtin_constant_p(bufsize))		\
+			BUILD_BUG_ON((bufsize) % sizeof(u32));	\
+		iwl_trans_read_mem(trans, addr, buf,		\
+				   (bufsize) / sizeof(u32));	\
+	})
 
 int iwl_trans_write_imr_mem(struct iwl_trans *trans, u32 dst_addr,
 			    u64 src_addr, u32 byte_cnt);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 244ca8cab9d1..1a814eb6743e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -3032,13 +3032,18 @@ static bool iwl_mvm_rt_status(struct iwl_trans *trans, u32 base, u32 *err_id)
 		/* cf. struct iwl_error_event_table */
 		u32 valid;
 		__le32 err_id;
-	} err_info;
+	} err_info = {};
+	int ret;
 
 	if (!base)
 		return false;
 
-	iwl_trans_read_mem_bytes(trans, base,
-				 &err_info, sizeof(err_info));
+	ret = iwl_trans_read_mem_bytes(trans, base,
+				       &err_info, sizeof(err_info));
+
+	if (ret)
+		return true;
+
 	if (err_info.valid && err_id)
 		*err_id = le32_to_cpu(err_info.err_id);
 
@@ -3635,22 +3640,31 @@ int iwl_mvm_fast_resume(struct iwl_mvm *mvm)
 	iwl_fw_dbg_read_d3_debug_data(&mvm->fwrt);
 
 	if (iwl_mvm_check_rt_status(mvm, NULL)) {
+		IWL_ERR(mvm,
+			"iwl_mvm_check_rt_status failed, device is gone during suspend\n");
 		set_bit(STATUS_FW_ERROR, &mvm->trans->status);
 		iwl_mvm_dump_nic_error_log(mvm);
 		iwl_dbg_tlv_time_point(&mvm->fwrt,
 				       IWL_FW_INI_TIME_POINT_FW_ASSERT, NULL);
 		iwl_fw_dbg_collect_desc(&mvm->fwrt, &iwl_dump_desc_assert,
 					false, 0);
-		return -ENODEV;
+		mvm->trans->state = IWL_TRANS_NO_FW;
+		ret = -ENODEV;
+
+		goto out;
 	}
 	ret = iwl_mvm_d3_notif_wait(mvm, &d3_data);
+
+	if (ret) {
+		IWL_ERR(mvm, "Couldn't get the d3 notif %d\n", ret);
+		mvm->trans->state = IWL_TRANS_NO_FW;
+	}
+
+out:
 	clear_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
 	mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
 	mvm->fast_resume = false;
 
-	if (ret)
-		IWL_ERR(mvm, "Couldn't get the d3 notif %d\n", ret);
-
 	return ret;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 3b9943eb6934..d19b3bd0866b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1643,6 +1643,8 @@ int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 out:
 	if (*status == IWL_D3_STATUS_ALIVE)
 		ret = iwl_pcie_d3_handshake(trans, false);
+	else
+		trans->state = IWL_TRANS_NO_FW;
 
 	return ret;
 }
-- 
2.47.1


