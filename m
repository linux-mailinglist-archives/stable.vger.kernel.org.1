Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AFC735240
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjFSKc6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjFSKcs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:32:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BCAE58
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:32:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C15BA60B58
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DCFC433C0;
        Mon, 19 Jun 2023 10:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170766;
        bh=Ys+J8zyZScPPe4uXqKJZpQIViFuX+QXqtdsc0LeVe9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tZFn5GfmpH6lijFs6y21BnAvWOd6hBhsv89RW+iFRTDMBSSiW5BvsNjDruMGBNQm9
         pRzi2VL2URbc+AeE6GG85oIdA6tH0acBQkSCacshgNoPeAcj0+Z+CaQFM1+qrAMpKC
         d1YLiaMmuCyWSgYd+bNkMHb9lbPxj4hZMUQxDyvA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alejandro Lucero <alejandro.lucero-palau@amd.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 027/187] sfc: fix devlink info error handling
Date:   Mon, 19 Jun 2023 12:27:25 +0200
Message-ID: <20230619102158.952771939@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alejandro Lucero <alejandro.lucero-palau@amd.com>

[ Upstream commit cfcb942863f6fce9266e1957a021e6c7295dee42 ]

Avoid early devlink info return if errors arise with MCDI commands
executed for getting the required info from the device. The rationale
is some commands can fail but later ones could still give useful data.
Moreover, some nvram partitions could not be present which needs to be
handled as a non error.

The specific errors are reported through system messages and if any
error appears, it will be reported generically through extack.

Fixes 14743ddd2495 ("sfc: add devlink info support for ef100")
Signed-off-by: Alejandro Lucero <alejandro.lucero-palau@amd.com>
Acked-by: Martin Habets <habetsm.xilinx@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/sfc/efx_devlink.c | 95 ++++++++++++--------------
 1 file changed, 45 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_devlink.c b/drivers/net/ethernet/sfc/efx_devlink.c
index 381b805659d39..ef9971cbb695d 100644
--- a/drivers/net/ethernet/sfc/efx_devlink.c
+++ b/drivers/net/ethernet/sfc/efx_devlink.c
@@ -171,9 +171,14 @@ static int efx_devlink_info_nvram_partition(struct efx_nic *efx,
 
 	rc = efx_mcdi_nvram_metadata(efx, partition_type, NULL, version, NULL,
 				     0);
+
+	/* If the partition does not exist, that is not an error. */
+	if (rc == -ENOENT)
+		return 0;
+
 	if (rc) {
-		netif_err(efx, drv, efx->net_dev, "mcdi nvram %s: failed\n",
-			  version_name);
+		netif_err(efx, drv, efx->net_dev, "mcdi nvram %s: failed (rc=%d)\n",
+			  version_name, rc);
 		return rc;
 	}
 
@@ -187,36 +192,33 @@ static int efx_devlink_info_nvram_partition(struct efx_nic *efx,
 static int efx_devlink_info_stored_versions(struct efx_nic *efx,
 					    struct devlink_info_req *req)
 {
-	int rc;
-
-	rc = efx_devlink_info_nvram_partition(efx, req,
-					      NVRAM_PARTITION_TYPE_BUNDLE,
-					      DEVLINK_INFO_VERSION_GENERIC_FW_BUNDLE_ID);
-	if (rc)
-		return rc;
-
-	rc = efx_devlink_info_nvram_partition(efx, req,
-					      NVRAM_PARTITION_TYPE_MC_FIRMWARE,
-					      DEVLINK_INFO_VERSION_GENERIC_FW_MGMT);
-	if (rc)
-		return rc;
-
-	rc = efx_devlink_info_nvram_partition(efx, req,
-					      NVRAM_PARTITION_TYPE_SUC_FIRMWARE,
-					      EFX_DEVLINK_INFO_VERSION_FW_MGMT_SUC);
-	if (rc)
-		return rc;
-
-	rc = efx_devlink_info_nvram_partition(efx, req,
-					      NVRAM_PARTITION_TYPE_EXPANSION_ROM,
-					      EFX_DEVLINK_INFO_VERSION_FW_EXPROM);
-	if (rc)
-		return rc;
+	int err;
 
-	rc = efx_devlink_info_nvram_partition(efx, req,
-					      NVRAM_PARTITION_TYPE_EXPANSION_UEFI,
-					      EFX_DEVLINK_INFO_VERSION_FW_UEFI);
-	return rc;
+	/* We do not care here about the specific error but just if an error
+	 * happened. The specific error will be reported inside the call
+	 * through system messages, and if any error happened in any call
+	 * below, we report it through extack.
+	 */
+	err = efx_devlink_info_nvram_partition(efx, req,
+					       NVRAM_PARTITION_TYPE_BUNDLE,
+					       DEVLINK_INFO_VERSION_GENERIC_FW_BUNDLE_ID);
+
+	err |= efx_devlink_info_nvram_partition(efx, req,
+						NVRAM_PARTITION_TYPE_MC_FIRMWARE,
+						DEVLINK_INFO_VERSION_GENERIC_FW_MGMT);
+
+	err |= efx_devlink_info_nvram_partition(efx, req,
+						NVRAM_PARTITION_TYPE_SUC_FIRMWARE,
+						EFX_DEVLINK_INFO_VERSION_FW_MGMT_SUC);
+
+	err |= efx_devlink_info_nvram_partition(efx, req,
+						NVRAM_PARTITION_TYPE_EXPANSION_ROM,
+						EFX_DEVLINK_INFO_VERSION_FW_EXPROM);
+
+	err |= efx_devlink_info_nvram_partition(efx, req,
+						NVRAM_PARTITION_TYPE_EXPANSION_UEFI,
+						EFX_DEVLINK_INFO_VERSION_FW_UEFI);
+	return err;
 }
 
 #define EFX_VER_FLAG(_f)	\
@@ -587,27 +589,20 @@ static int efx_devlink_info_get(struct devlink *devlink,
 {
 	struct efx_devlink *devlink_private = devlink_priv(devlink);
 	struct efx_nic *efx = devlink_private->efx;
-	int rc;
+	int err;
 
-	/* Several different MCDI commands are used. We report first error
-	 * through extack returning at that point. Specific error
-	 * information via system messages.
+	/* Several different MCDI commands are used. We report if errors
+	 * happened through extack. Specific error information via system
+	 * messages inside the calls.
 	 */
-	rc = efx_devlink_info_board_cfg(efx, req);
-	if (rc) {
-		NL_SET_ERR_MSG_MOD(extack, "Getting board info failed");
-		return rc;
-	}
-	rc = efx_devlink_info_stored_versions(efx, req);
-	if (rc) {
-		NL_SET_ERR_MSG_MOD(extack, "Getting stored versions failed");
-		return rc;
-	}
-	rc = efx_devlink_info_running_versions(efx, req);
-	if (rc) {
-		NL_SET_ERR_MSG_MOD(extack, "Getting running versions failed");
-		return rc;
-	}
+	err = efx_devlink_info_board_cfg(efx, req);
+
+	err |= efx_devlink_info_stored_versions(efx, req);
+
+	err |= efx_devlink_info_running_versions(efx, req);
+
+	if (err)
+		NL_SET_ERR_MSG_MOD(extack, "Errors when getting device info. Check system messages");
 
 	return 0;
 }
-- 
2.39.2



