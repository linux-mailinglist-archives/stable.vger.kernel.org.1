Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC357353F0
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjFSKu2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjFSKtY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:49:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816E1172C
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:49:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16F0060670
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDA2C433C8;
        Mon, 19 Jun 2023 10:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171762;
        bh=MS+RDxyshMG/5IO9RS3iraWPZfM1UETS5z4jCbnUr9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KkmtGmleC+pZ5FL2MKbbuXYeqyuU+c7tIeUFW47W7IIJC+IsfBTYd82h94HVvd0nf
         887FDAmd+r2Y8Mq5bnnrO6WB2ueTRd00+ou4yAB7OMm1OlEO0OdYtV8zR6VoTsielz
         PR9qm6OW35Ij2uq3LZTOf4OO/JbciOhBQaTFPHsA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fedor Pchelkin <pchelkin@ispras.ru>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 148/166] net: macsec: fix double free of percpu stats
Date:   Mon, 19 Jun 2023 12:30:25 +0200
Message-ID: <20230619102201.888804141@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
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

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit 0c0cf3db83f8c7c9bb141c2771a34043bcf952ef ]

Inside macsec_add_dev() we free percpu macsec->secy.tx_sc.stats and
macsec->stats on some of the memory allocation failure paths. However, the
net_device is already registered to that moment: in macsec_newlink(), just
before calling macsec_add_dev(). This means that during unregister process
its priv_destructor - macsec_free_netdev() - will be called and will free
the stats again.

Remove freeing percpu stats inside macsec_add_dev() because
macsec_free_netdev() will correctly free the already allocated ones. The
pointers to unallocated stats stay NULL, and free_percpu() treats that
correctly.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 0a28bfd4971f ("net/macsec: Add MACsec skb_metadata_dst Tx Data path support")
Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macsec.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 038a787943927..983cabf9a0f67 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3981,17 +3981,15 @@ static int macsec_add_dev(struct net_device *dev, sci_t sci, u8 icv_len)
 		return -ENOMEM;
 
 	secy->tx_sc.stats = netdev_alloc_pcpu_stats(struct pcpu_tx_sc_stats);
-	if (!secy->tx_sc.stats) {
-		free_percpu(macsec->stats);
+	if (!secy->tx_sc.stats)
 		return -ENOMEM;
-	}
 
 	secy->tx_sc.md_dst = metadata_dst_alloc(0, METADATA_MACSEC, GFP_KERNEL);
-	if (!secy->tx_sc.md_dst) {
-		free_percpu(secy->tx_sc.stats);
-		free_percpu(macsec->stats);
+	if (!secy->tx_sc.md_dst)
+		/* macsec and secy percpu stats will be freed when unregistering
+		 * net_device in macsec_free_netdev()
+		 */
 		return -ENOMEM;
-	}
 
 	if (sci == MACSEC_UNDEF_SCI)
 		sci = dev_to_sci(dev, MACSEC_PORT_ES);
-- 
2.39.2



