Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428747556DB
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjGPUyp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjGPUyo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:54:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAB4E9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:54:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 463F560E2C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A35C433C8;
        Sun, 16 Jul 2023 20:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540882;
        bh=/PhxY4V5E80pAksI2zKQIGvzllHUzYkdvsVt/hMMRD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mYmigH6OJ7obyAbrVPCrxyVk4+/qar2Kp7HykomcgwPPkLrrg3MYQQvln36lBOf/j
         glcfFSTwaYn1AvJLMwYp8kUkKF8LbjtOjDIOYy4+kFqH+6s6Z+d0fLBc3b3Y/DeFn3
         9R2leB9AwNQtuRqB4naGYCZatIqRHh7/VT8i2bxc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 494/591] octeontx2-af: Fix mapping for NIX block from CGX connection
Date:   Sun, 16 Jul 2023 21:50:33 +0200
Message-ID: <20230716194936.677303877@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hariprasad Kelam <hkelam@marvell.com>

[ Upstream commit 2e7bc57b976bb016c6569a54d95c1b8d88f9450a ]

Firmware configures NIX block mapping for all MAC blocks.
The current implementation reads the configuration and
creates the mapping between RVU PF  and NIX blocks. But
this configuration is only valid for silicons that support
multiple blocks. For all other silicons, all MAC blocks
map to NIX0.

This patch corrects the mapping by adding a check for the same.

Fixes: c5a73b632b90 ("octeontx2-af: Map NIX block from CGX connection")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h     | 11 +++++++++++
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index d493b533cf76e..a3346ea7876c5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -23,6 +23,7 @@
 #define	PCI_DEVID_OCTEONTX2_LBK			0xA061
 
 /* Subsystem Device ID */
+#define PCI_SUBSYS_DEVID_98XX                  0xB100
 #define PCI_SUBSYS_DEVID_96XX                  0xB200
 #define PCI_SUBSYS_DEVID_CN10K_A	       0xB900
 #define PCI_SUBSYS_DEVID_CNF10K_B              0xBC00
@@ -646,6 +647,16 @@ static inline u16 rvu_nix_chan_cpt(struct rvu *rvu, u8 chan)
 	return rvu->hw->cpt_chan_base + chan;
 }
 
+static inline bool is_rvu_supports_nix1(struct rvu *rvu)
+{
+	struct pci_dev *pdev = rvu->pdev;
+
+	if (pdev->subsystem_device == PCI_SUBSYS_DEVID_98XX)
+		return true;
+
+	return false;
+}
+
 /* Function Prototypes
  * RVU
  */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 9eca38547b783..e284a14ca1203 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -112,7 +112,7 @@ static void rvu_map_cgx_nix_block(struct rvu *rvu, int pf,
 	p2x = cgx_lmac_get_p2x(cgx_id, lmac_id);
 	/* Firmware sets P2X_SELECT as either NIX0 or NIX1 */
 	pfvf->nix_blkaddr = BLKADDR_NIX0;
-	if (p2x == CMR_P2X_SEL_NIX1)
+	if (is_rvu_supports_nix1(rvu) && p2x == CMR_P2X_SEL_NIX1)
 		pfvf->nix_blkaddr = BLKADDR_NIX1;
 }
 
-- 
2.39.2



