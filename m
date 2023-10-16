Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F9B7CA20A
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjJPIpA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjJPIo7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:44:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1433EB4
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:44:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DF3C433C8;
        Mon, 16 Oct 2023 08:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697445894;
        bh=ncavapu+B+96TIPb0W7wa4g+w5DygAIUKvaj/Pgxvzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x4s83nZsA1VLLzKlokd3eRnHtEiU8bw2cqM7K4pvbrTqDz3mcg0qDIQzY5zqyxHIx
         hOjZGMtWZc6Ckt9E0091zo0QQ5boKXOYTFydcUs67S0CSpmQrmwvBVLSF1lCjC1w15
         94KGTNxbWAphE9jsOaRmz9qGerkYa5jdTcTG3yFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 033/102] net: phy: mscc: macsec: reject PN update requests
Date:   Mon, 16 Oct 2023 10:40:32 +0200
Message-ID: <20231016083954.583685341@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>

[ Upstream commit e0a8c918daa58700609ebd45e3fcd49965be8bbc ]

Updating the PN is not supported.
Return -EINVAL if update_pn is true.

The following command succeeded, but it should fail because the driver
does not update the PN:
ip macsec set macsec0 tx sa 0 pn 232 on

Fixes: 28c5107aa904 ("net: phy: mscc: macsec support")
Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/mscc/mscc_macsec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/mscc/mscc_macsec.c b/drivers/net/phy/mscc/mscc_macsec.c
index c00eef457b850..bec270785c594 100644
--- a/drivers/net/phy/mscc/mscc_macsec.c
+++ b/drivers/net/phy/mscc/mscc_macsec.c
@@ -880,6 +880,9 @@ static int vsc8584_macsec_upd_rxsa(struct macsec_context *ctx)
 {
 	struct macsec_flow *flow;
 
+	if (ctx->sa.update_pn)
+		return -EINVAL;
+
 	flow = vsc8584_macsec_find_flow(ctx, MACSEC_INGR);
 	if (IS_ERR(flow))
 		return PTR_ERR(flow);
@@ -929,6 +932,9 @@ static int vsc8584_macsec_upd_txsa(struct macsec_context *ctx)
 {
 	struct macsec_flow *flow;
 
+	if (ctx->sa.update_pn)
+		return -EINVAL;
+
 	flow = vsc8584_macsec_find_flow(ctx, MACSEC_EGR);
 	if (IS_ERR(flow))
 		return PTR_ERR(flow);
-- 
2.40.1



