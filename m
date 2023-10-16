Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182587CABF9
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjJPOsL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjJPOsK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:48:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE89AB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:48:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B884C433C7;
        Mon, 16 Oct 2023 14:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467689;
        bh=MhKO85ljGZNyFH57705miLzNWqvFo5Vs05NCQcdPVGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NvKrYFIndBXCiye2KZyqmqUWO/8u2F5m6ZVlAqBT803mBATwkeYO/0p6Aji2aYNRc
         54ScMHwW11spR5bj8WXnwJ8NXxsX4bWKUE3g+vnTbt4tDRrsRnTVnut84KQR5vP3sO
         KL5sLmrlCnK7tUvjPGHuI8ODH2QbYk7IGhhUz3dQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 071/191] octeontx2-pf: mcs: update PN only when update_pn is true
Date:   Mon, 16 Oct 2023 10:40:56 +0200
Message-ID: <20231016084017.066067048@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>

[ Upstream commit 4dcf38ae3ca16b8872f151d46ba5ac28dd580b60 ]

When updating SA, update the PN only when the update_pn flag is true.
Otherwise, the PN will be reset to its previous value using the
following command and this should not happen:
$ ip macsec set macsec0 tx sa 0 on

Fixes: c54ffc73601c ("octeontx2-pf: mcs: Introduce MACSEC hardware offloading")
Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/marvell/octeontx2/nic/cn10k_macsec.c   | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index 59b138214af2f..6cc7a78968fc1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -1357,10 +1357,12 @@ static int cn10k_mdo_upd_txsa(struct macsec_context *ctx)
 
 	if (netif_running(secy->netdev)) {
 		/* Keys cannot be changed after creation */
-		err = cn10k_write_tx_sa_pn(pfvf, txsc, sa_num,
-					   sw_tx_sa->next_pn);
-		if (err)
-			return err;
+		if (ctx->sa.update_pn) {
+			err = cn10k_write_tx_sa_pn(pfvf, txsc, sa_num,
+						   sw_tx_sa->next_pn);
+			if (err)
+				return err;
+		}
 
 		err = cn10k_mcs_link_tx_sa2sc(pfvf, secy, txsc,
 					      sa_num, sw_tx_sa->active);
@@ -1529,6 +1531,9 @@ static int cn10k_mdo_upd_rxsa(struct macsec_context *ctx)
 		if (err)
 			return err;
 
+		if (!ctx->sa.update_pn)
+			return 0;
+
 		err = cn10k_mcs_write_rx_sa_pn(pfvf, rxsc, sa_num,
 					       rx_sa->next_pn);
 		if (err)
-- 
2.40.1



