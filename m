Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71D870361D
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243649AbjEORGz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243656AbjEORGi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:06:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A18183D5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:05:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A2F062AAB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFEDC433EF;
        Mon, 15 May 2023 17:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170306;
        bh=uDRo++hqK3SzFxaKPIVM1dD1G5nxJYJJupxA11R3zyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uSjDw18T51QCUCX5wBeZ/nt1fcmjn81/cuY2AaCyILgdd25BulylSNV21PWcetRRJ
         9KD8welRpiOMPPgWACkj6pQwrrfeDGlPOeNBItd/pRg6PCBHPoKLdm5mtAY1yWZMx9
         BHIRQGAY/LLh9FSllQJV8DkTUMf6EB/0XoLWs/Xo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andy Moreton <andy.moreton@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 060/239] sfc: Fix module EEPROM reporting for QSFP modules
Date:   Mon, 15 May 2023 18:25:23 +0200
Message-Id: <20230515161723.502215889@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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

From: Andy Moreton <andy.moreton@amd.com>

[ Upstream commit 281900a923d4c50df109b52a22ae3cdac150159b ]

The sfc driver does not report QSFP module EEPROM contents correctly
as only the first page is fetched from hardware.

Commit 0e1a2a3e6e7d ("ethtool: Add SFF-8436 and SFF-8636 max EEPROM
length definitions") added ETH_MODULE_SFF_8436_MAX_LEN for the overall
size of the EEPROM info, so use that to report the full EEPROM contents.

Fixes: 9b17010da57a ("sfc: Add ethtool -m support for QSFP modules")
Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/sfc/mcdi_port_common.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/mcdi_port_common.c b/drivers/net/ethernet/sfc/mcdi_port_common.c
index 899cc16710048..0ab14f3d01d4d 100644
--- a/drivers/net/ethernet/sfc/mcdi_port_common.c
+++ b/drivers/net/ethernet/sfc/mcdi_port_common.c
@@ -972,12 +972,15 @@ static u32 efx_mcdi_phy_module_type(struct efx_nic *efx)
 
 	/* A QSFP+ NIC may actually have an SFP+ module attached.
 	 * The ID is page 0, byte 0.
+	 * QSFP28 is of type SFF_8636, however, this is treated
+	 * the same by ethtool, so we can also treat them the same.
 	 */
 	switch (efx_mcdi_phy_get_module_eeprom_byte(efx, 0, 0)) {
-	case 0x3:
+	case 0x3: /* SFP */
 		return MC_CMD_MEDIA_SFP_PLUS;
-	case 0xc:
-	case 0xd:
+	case 0xc: /* QSFP */
+	case 0xd: /* QSFP+ */
+	case 0x11: /* QSFP28 */
 		return MC_CMD_MEDIA_QSFP_PLUS;
 	default:
 		return 0;
@@ -1075,7 +1078,7 @@ int efx_mcdi_phy_get_module_info(struct efx_nic *efx, struct ethtool_modinfo *mo
 
 	case MC_CMD_MEDIA_QSFP_PLUS:
 		modinfo->type = ETH_MODULE_SFF_8436;
-		modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;
+		modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
 		break;
 
 	default:
-- 
2.39.2



