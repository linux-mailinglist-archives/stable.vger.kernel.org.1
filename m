Return-Path: <stable+bounces-125652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDCDA6A70A
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 14:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EFB57A6E00
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 13:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FEB2AE99;
	Thu, 20 Mar 2025 13:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jg4KrDYK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76701ADC9B
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742476950; cv=none; b=UZWg3kY6pqJ8ZEDWKD+0ES9NnO9cN/etOlFbtQtbfAQ1iBgdYdurQJEVX3JwSIMiX3RqpM53q3/UP8ucZMTNoAuJcAtj8lb4XPa6GJ7JIwNUDV9SFbHqfY4c92MnBJ9S3lO0oxKotSYAMBJpd3Espxfdrx8WvedPUw07CXTnYlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742476950; c=relaxed/simple;
	bh=clqAwnuO+VGBdNpIYVeWERX2vHMppanG54cRzo7EoQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cNXjBB0pYkjYXxt+VrpHehVCd5XMy5Vho8bksWbAtCuO/CMZYspE1S1Na9B/9KFLxzTQS/LkFKfkVD0sTfDyYIsTGR+S1be0QBO/iuqdwrRQCTBiVqLva1wnYH2FZv1PXNP6YkUVmjnOoVXmIX6nr2wHvyJdRwudmyFhiClyiGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jg4KrDYK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742476949; x=1774012949;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=clqAwnuO+VGBdNpIYVeWERX2vHMppanG54cRzo7EoQA=;
  b=jg4KrDYKcb9Kv+x4gSvtR0rbmV6zqPEVg24qFZrifLVzVAAFhGX9to4R
   bpDn5MeBoGBv08cU8Kuog9xKCmvDezuCaEUlWA9jCoSnYT62l892xU8dc
   ekwNo5eGCqtBtG8aKVgv6rmnJGDOEcJ9JNukVedR06KDZIO+CtL6idg7G
   K7xo0FhFYjDnmJOHE5X1XTQVq7tvvqN0fyTAJI7qysRwbPCWrz4i1SxND
   4EJKiYf1X3+8aXauzChL4E4kMVqq55vSxRFO/5z2hREKaQl+0D8g979GI
   F8fPznNg2jJehgiX/zno4yjbPRJGsRjYhPcbc0fLigNSBLj3JZDslO2iX
   g==;
X-CSE-ConnectionGUID: B0ArTRSsRqW6hlEgS8s3cQ==
X-CSE-MsgGUID: rxDiiXLNQg6dMCdxQu6QPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="47586002"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="47586002"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:22:28 -0700
X-CSE-ConnectionGUID: 5JbwMLidSnmCM/3ypqx6Lw==
X-CSE-MsgGUID: R87ymMcAQxGvsmiKHBdHog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="127930880"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO egrumbac-mobl6.intel.com) ([10.245.250.196])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:22:26 -0700
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: stable@vger.kernel.org
Cc: frankgor@google.com,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 6.6] wifi: iwlwifi: support BIOS override for 5G9 in CA also in LARI version 8
Date: Thu, 20 Mar 2025 15:22:20 +0200
Message-ID: <20250320132220.33536-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

commit b1e8102a4048003097c7054cbc00bbda91a5ced7 upstream

Commit 6b3e87cc0ca5 ("iwlwifi: Add support for LARI_CONFIG_CHANGE_CMD
cmd v9")
added a few bits to iwl_lari_config_change_cmd::oem_unii4_allow_bitmap
if the FW has LARI version >= 9.
But we also need to send those bits for version 8 if the FW is capable
of this feature (indicated with capability bits)
Add the FW capability bit, and set the additional bits in the cmd when
the version is 8 and the FW capability bit is set.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Link: https://patch.msgid.link/20241226174257.dc5836f84514.I1e38f94465a36731034c94b9811de10cb6ee5921@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h |  4 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 37 ++++++++++++++++++--
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index b36e9613a52c..b1687e6d3ad2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -372,6 +372,8 @@ typedef unsigned int __bitwise iwl_ucode_tlv_capa_t;
  *      channels even when these are not enabled.
  * @IWL_UCODE_TLV_CAPA_DUMP_COMPLETE_SUPPORT: Support for indicating dump collection
  *	complete to FW.
+ * @IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_5G9_FOR_CA: supports (de)activating 5G9
+ *	for CA from BIOS.
  *
  * @NUM_IWL_UCODE_TLV_CAPA: number of bits used
  */
@@ -468,7 +470,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_OFFLOAD_BTM_SUPPORT		= (__force iwl_ucode_tlv_capa_t)113,
 	IWL_UCODE_TLV_CAPA_STA_EXP_MFP_SUPPORT		= (__force iwl_ucode_tlv_capa_t)114,
 	IWL_UCODE_TLV_CAPA_SNIFF_VALIDATE_SUPPORT	= (__force iwl_ucode_tlv_capa_t)116,
-
+	IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_5G9_FOR_CA	= (__force iwl_ucode_tlv_capa_t)123,
 #ifdef __CHECKER__
 	/* sparse says it cannot increment the previous enum member */
 #define NUM_IWL_UCODE_TLV_CAPA 128
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 80b5c20d3a48..c597492668fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1195,11 +1195,30 @@ static u8 iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
 	return DSM_VALUE_RFI_DISABLE;
 }
 
+enum iwl_dsm_unii4_bitmap {
+	DSM_VALUE_UNII4_US_OVERRIDE_MSK		= BIT(0),
+	DSM_VALUE_UNII4_US_EN_MSK		= BIT(1),
+	DSM_VALUE_UNII4_ETSI_OVERRIDE_MSK	= BIT(2),
+	DSM_VALUE_UNII4_ETSI_EN_MSK		= BIT(3),
+	DSM_VALUE_UNII4_CANADA_OVERRIDE_MSK	= BIT(4),
+	DSM_VALUE_UNII4_CANADA_EN_MSK		= BIT(5),
+};
+
+#define DSM_UNII4_ALLOW_BITMAP (DSM_VALUE_UNII4_US_OVERRIDE_MSK		|\
+				DSM_VALUE_UNII4_US_EN_MSK		|\
+				DSM_VALUE_UNII4_ETSI_OVERRIDE_MSK	|\
+				DSM_VALUE_UNII4_ETSI_EN_MSK		|\
+				DSM_VALUE_UNII4_CANADA_OVERRIDE_MSK	|\
+				DSM_VALUE_UNII4_CANADA_EN_MSK)
+
 static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 {
 	int ret;
 	u32 value;
 	struct iwl_lari_config_change_cmd_v6 cmd = {};
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
+						   LARI_CONFIG_CHANGE), 1);
 
 	cmd.config_bitmap = iwl_acpi_get_lari_config_bitmap(&mvm->fwrt);
 
@@ -1211,8 +1230,22 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 	ret = iwl_acpi_get_dsm_u32(mvm->fwrt.dev, 0,
 				   DSM_FUNC_ENABLE_UNII4_CHAN,
 				   &iwl_guid, &value);
-	if (!ret)
-		cmd.oem_unii4_allow_bitmap = cpu_to_le32(value);
+	if (!ret) {
+		u32 _value = cpu_to_le32(value);
+
+		_value &= DSM_UNII4_ALLOW_BITMAP;
+
+		/* Since version 9, bits 4 and 5 are supported
+		 * regardless of this capability.
+		 */
+		if (cmd_ver < 9 &&
+		    !fw_has_capa(&mvm->fw->ucode_capa,
+				 IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_5G9_FOR_CA))
+			_value &= ~(DSM_VALUE_UNII4_CANADA_OVERRIDE_MSK |
+				   DSM_VALUE_UNII4_CANADA_EN_MSK);
+
+		cmd.oem_unii4_allow_bitmap = cpu_to_le32(_value);
+	}
 
 	ret = iwl_acpi_get_dsm_u32(mvm->fwrt.dev, 0,
 				   DSM_FUNC_ACTIVATE_CHANNEL,
-- 
2.48.1


