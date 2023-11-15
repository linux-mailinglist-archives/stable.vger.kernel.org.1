Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1D47ECE11
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbjKOTkT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbjKOTkO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:40:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B731BD
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:40:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888ECC43391;
        Wed, 15 Nov 2023 19:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077204;
        bh=OVRfcbCxM+w376JIFD1jY/nnUH0UlqqsTcfvceowIPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dovyQvUmGeSlQ2oMHvt5WAop8TXVlz0remGRRACsmr4WRshEFPhc+G6eWXrXzgqaX
         EQq1H78avwUjZ16WxsRpGRsQYRm8FKwbnGCmx/xGxgwCON/Udi+Xrbps2TqlEotwdv
         B9LCMBkfwhYJs6WKLbkeMEoRsWLZxdkICxHOfWdY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 144/603] wifi: iwlwifi: mvm: fix netif csum flags
Date:   Wed, 15 Nov 2023 14:11:29 -0500
Message-ID: <20231115191623.159274287@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 08365d3b9140c751a84f8027ac7d2e662958f768 ]

We shouldn't advertise arbitrary checksum flags since we had
to remove support for it due to broken hardware.

Fixes: ec18e7d4d20d ("wifi: iwlwifi: mvm: use old checksum for Bz A-step")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20231017115047.e37327f1a129.Iaee86b00db4db791cd90adaf15384b8c87d2ad49@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c     | 4 ++--
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c     | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 5 +----
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 3d223014cfe6d..42e765fe3cfe1 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -158,7 +158,7 @@ const struct iwl_cfg iwl_cfg_bz = {
 	.fw_name_mac = "bz",
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_BZ_EHT,
 };
 
@@ -166,7 +166,7 @@ const struct iwl_cfg iwl_cfg_gl = {
 	.fw_name_mac = "gl",
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_BZ_EHT,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index d6243025993ea..604e9cef6baac 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -151,7 +151,7 @@ const struct iwl_cfg iwl_cfg_sc = {
 	.fw_name_mac = "sc",
 	.uhb_supported = true,
 	IWL_DEVICE_SC,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_SC_EHT,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 241a9e3f2a1a7..f45f645ca6485 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -86,10 +86,7 @@ enum iwl_nvm_type {
 #define IWL_DEFAULT_MAX_TX_POWER 22
 #define IWL_TX_CSUM_NETIF_FLAGS (NETIF_F_IPV6_CSUM | NETIF_F_IP_CSUM |\
 				 NETIF_F_TSO | NETIF_F_TSO6)
-#define IWL_TX_CSUM_NETIF_FLAGS_BZ (NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6)
-#define IWL_CSUM_NETIF_FLAGS_MASK (IWL_TX_CSUM_NETIF_FLAGS | \
-				   IWL_TX_CSUM_NETIF_FLAGS_BZ | \
-				   NETIF_F_RXCSUM)
+#define IWL_CSUM_NETIF_FLAGS_MASK (IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM)
 
 /* Antenna presence definitions */
 #define	ANT_NONE	0x0
-- 
2.42.0



