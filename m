Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769F77ED03F
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbjKOTxp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbjKOTxp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:53:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D9FB8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:53:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B492C433C9;
        Wed, 15 Nov 2023 19:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078021;
        bh=mTtIKhKIYLdQERi/6OEKIkBBjDw6JobJEhrU/MT9AuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ptlbPD2q8SaK0kgwYXbwWw+vPxW3j382F9uBFfA2mYQB2c/ET+sVn9yKRv8HpWubm
         0xTyVapmw6DIYwsOtPzdy4zCnzSsmZ00zBElQespld2MY9Ttt5vMQFXJgT2nVYxnHX
         jLbxuGAa6iAdD27ApJmpL3iyaZ36lp5tZqfomlG4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 026/379] wifi: iwlwifi: honor the enable_ini value
Date:   Wed, 15 Nov 2023 14:21:41 -0500
Message-ID: <20231115192646.703439815@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit e0c1ca236e28e4263fba76d47a108ed95dcae33e ]

In case the user sets the enable_ini to some preset, we want to honor
the value.

Remove the ops to set the value of the module parameter is runtime, we
don't want to allow to modify the value in runtime since we configure
the firmware once at the beginning on its life.

Fixes: b49c2b252b58 ("iwlwifi: Configure FW debug preset via module param.")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230830112059.5734e0f374bb.I6698eda8ed2112378dd47ac5d62866ebe7a94f77@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  1 +
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |  5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 51 +++++++------------
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  4 ++
 4 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index ba538d70985f4..39bee9c00e071 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -13,6 +13,7 @@
 #define IWL_FW_INI_DOMAIN_ALWAYS_ON		0
 #define IWL_FW_INI_REGION_ID_MASK		GENMASK(15, 0)
 #define IWL_FW_INI_REGION_DUMP_POLICY_MASK	GENMASK(31, 16)
+#define IWL_FW_INI_PRESET_DISABLE		0xff
 
 /**
  * struct iwl_fw_ini_hcmd
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
index 128059ca77e60..06fb7d6653905 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #ifndef __iwl_dbg_tlv_h__
 #define __iwl_dbg_tlv_h__
@@ -10,7 +10,8 @@
 #include <fw/file.h>
 #include <fw/api/dbg-tlv.h>
 
-#define IWL_DBG_TLV_MAX_PRESET 15
+#define IWL_DBG_TLV_MAX_PRESET	15
+#define ENABLE_INI		(IWL_DBG_TLV_MAX_PRESET + 1)
 
 /**
  * struct iwl_dbg_tlv_node - debug TLV node
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index a2203f661321c..5eba1a355f043 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1722,6 +1722,22 @@ struct iwl_drv *iwl_drv_start(struct iwl_trans *trans)
 #endif
 
 	drv->trans->dbg.domains_bitmap = IWL_TRANS_FW_DBG_DOMAIN(drv->trans);
+	if (iwlwifi_mod_params.enable_ini != ENABLE_INI) {
+		/* We have a non-default value in the module parameter,
+		 * take its value
+		 */
+		drv->trans->dbg.domains_bitmap &= 0xffff;
+		if (iwlwifi_mod_params.enable_ini != IWL_FW_INI_PRESET_DISABLE) {
+			if (iwlwifi_mod_params.enable_ini > ENABLE_INI) {
+				IWL_ERR(trans,
+					"invalid enable_ini module parameter value: max = %d, using 0 instead\n",
+					ENABLE_INI);
+				iwlwifi_mod_params.enable_ini = 0;
+			}
+			drv->trans->dbg.domains_bitmap =
+				BIT(IWL_FW_DBG_DOMAIN_POS + iwlwifi_mod_params.enable_ini);
+		}
+	}
 
 	ret = iwl_request_firmware(drv, true);
 	if (ret) {
@@ -1770,8 +1786,6 @@ void iwl_drv_stop(struct iwl_drv *drv)
 	kfree(drv);
 }
 
-#define ENABLE_INI	(IWL_DBG_TLV_MAX_PRESET + 1)
-
 /* shared module parameters */
 struct iwl_mod_params iwlwifi_mod_params = {
 	.fw_restart = true,
@@ -1891,38 +1905,7 @@ module_param_named(uapsd_disable, iwlwifi_mod_params.uapsd_disable, uint, 0644);
 MODULE_PARM_DESC(uapsd_disable,
 		 "disable U-APSD functionality bitmap 1: BSS 2: P2P Client (default: 3)");
 
-static int enable_ini_set(const char *arg, const struct kernel_param *kp)
-{
-	int ret = 0;
-	bool res;
-	__u32 new_enable_ini;
-
-	/* in case the argument type is a number */
-	ret = kstrtou32(arg, 0, &new_enable_ini);
-	if (!ret) {
-		if (new_enable_ini > ENABLE_INI) {
-			pr_err("enable_ini cannot be %d, in range 0-16\n", new_enable_ini);
-			return -EINVAL;
-		}
-		goto out;
-	}
-
-	/* in case the argument type is boolean */
-	ret = kstrtobool(arg, &res);
-	if (ret)
-		return ret;
-	new_enable_ini = (res ? ENABLE_INI : 0);
-
-out:
-	iwlwifi_mod_params.enable_ini = new_enable_ini;
-	return 0;
-}
-
-static const struct kernel_param_ops enable_ini_ops = {
-	.set = enable_ini_set
-};
-
-module_param_cb(enable_ini, &enable_ini_ops, &iwlwifi_mod_params.enable_ini, 0644);
+module_param_named(enable_ini, iwlwifi_mod_params.enable_ini, uint, 0444);
 MODULE_PARM_DESC(enable_ini,
 		 "0:disable, 1-15:FW_DBG_PRESET Values, 16:enabled without preset value defined,"
 		 "Debug INI TLV FW debug infrastructure (default: 16)");
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index d659ccd065f78..c9729e2718dc0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -56,6 +56,10 @@
  *	6) Eventually, the free function will be called.
  */
 
+/* default preset 0 (start from bit 16)*/
+#define IWL_FW_DBG_DOMAIN_POS	16
+#define IWL_FW_DBG_DOMAIN	BIT(IWL_FW_DBG_DOMAIN_POS)
+
 #define IWL_TRANS_FW_DBG_DOMAIN(trans)	IWL_FW_INI_DOMAIN_ALWAYS_ON
 
 #define FH_RSCSR_FRAME_SIZE_MSK		0x00003FFF	/* bits 0-13 */
-- 
2.42.0



