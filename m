Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ACF76AF2A
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjHAJp0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbjHAJpK (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:45:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723ED1FCB
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:43:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EB61614FF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3A7C433C7;
        Tue,  1 Aug 2023 09:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883013;
        bh=HwuGX4DSN1NBlbEaLKFPQH9lbqpV1tDj6YmnLmmUkOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oH8IOxFTkwSWsBFmRAffjoWWRlvrQcx2Tfl7+zcvHcD6gKulbmflktjBFFhCcLYDb
         Pkm9SZUVOj2PdFO03ZhUxpA44rCjYJR5jmMC0q8GJXTyCPgIfTAGRUVnzzZbDdaAC9
         OJFLvG0pQFEkFVJmmFifUWruZ9IJgoNc1suxVqUs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Simon Horman <simon.horman@corigine.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 083/239] net: stmmac: Apply redundant write work around on 4.xx too
Date:   Tue,  1 Aug 2023 11:19:07 +0200
Message-ID: <20230801091928.738490181@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vincent Whitchurch <vincent.whitchurch@axis.com>

[ Upstream commit 284779dbf4e98753458708783af8c35630674a21 ]

commit a3a57bf07de23fe1ff779e0fdf710aa581c3ff73 ("net: stmmac: work
around sporadic tx issue on link-up") worked around a problem with TX
sometimes not working after a link-up by avoiding a redundant write to
MAC_CTRL_REG (aka GMAC_CONFIG), since the IP appeared to have problems
with handling multiple writes to that register in some cases.

That commit however only added the work around to dwmac_lib.c (apart
from the common code in stmmac_main.c), but my systems with version
4.21a of the IP exhibit the same problem, so add the work around to
dwmac4_lib.c too.

Fixes: a3a57bf07de2 ("net: stmmac: work around sporadic tx issue on link-up")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230721-stmmac-tx-workaround-v1-1-9411cbd5ee07@axis.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
index df41eac54058f..03ceb6a940732 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
@@ -240,13 +240,15 @@ void stmmac_dwmac4_set_mac_addr(void __iomem *ioaddr, const u8 addr[6],
 void stmmac_dwmac4_set_mac(void __iomem *ioaddr, bool enable)
 {
 	u32 value = readl(ioaddr + GMAC_CONFIG);
+	u32 old_val = value;
 
 	if (enable)
 		value |= GMAC_CONFIG_RE | GMAC_CONFIG_TE;
 	else
 		value &= ~(GMAC_CONFIG_TE | GMAC_CONFIG_RE);
 
-	writel(value, ioaddr + GMAC_CONFIG);
+	if (value != old_val)
+		writel(value, ioaddr + GMAC_CONFIG);
 }
 
 void stmmac_dwmac4_get_mac_addr(void __iomem *ioaddr, unsigned char *addr,
-- 
2.39.2



