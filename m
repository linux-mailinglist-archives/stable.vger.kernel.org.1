Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93382713E49
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjE1TeE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjE1TeE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:34:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C3EB1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:34:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 963FF61DE2
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6205C433EF;
        Sun, 28 May 2023 19:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302442;
        bh=47S9jJwwtVN/qOds1qZIgSAekEnFnv9MB8hS7edp/D0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LWcaqc/8tVXQeHIhYgRTYuiCbAYHnvufgXuL/clHOoJWN9ywKe6aFV0NZWC3Q3PJN
         oF04PdscOb0dTx2QCr70JtdnUC8U6j3aFvVzpXAxXSpNMyftDy98kcewyUmA+EhbEp
         +kqI1QkENorfIOZoTud3OtkEGexFkpbYZuxn/t9g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.3 125/127] net: ethernet: mtk_eth_soc: fix QoS on DSA MAC on non MTK_NETSYS_V2 SoCs
Date:   Sun, 28 May 2023 20:11:41 +0100
Message-Id: <20230528190840.299070084@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arınç ÜNAL <arinc.unal@arinc9.com>

commit 04910d8cbfed65dad21c31723c6c1a8d9f990fb6 upstream.

The commit c6d96df9fa2c ("net: ethernet: mtk_eth_soc: drop generic vlan rx
offload, only use DSA untagging") makes VLAN RX offloading to be only used
on the SoCs without the MTK_NETSYS_V2 ability (which are not just MT7621
and MT7622). The commit disables the proper handling of special tagged
(DSA) frames, added with commit 87e3df4961f4 ("net-next: ethernet:
mediatek: add CDM able to recognize the tag for DSA"), for non
MTK_NETSYS_V2 SoCs when it finds a MAC that does not use DSA. So if the
other MAC uses DSA, the CDMQ component transmits DSA tagged frames to the
CPU improperly. This issue can be observed on frames with TCP, for example,
a TCP speed test using iperf3 won't work.

The commit disables the proper handling of special tagged (DSA) frames
because it assumes that these SoCs don't use more than one MAC, which is
wrong. Although I made Frank address this false assumption on the patch log
when they sent the patch on behalf of Felix, the code still made changes
with this assumption.

Therefore, the proper handling of special tagged (DSA) frames must be kept
enabled in all circumstances as it doesn't affect non DSA tagged frames.

Hardware DSA untagging, introduced with the commit 2d7605a72906 ("net:
ethernet: mtk_eth_soc: enable hardware DSA untagging"), and VLAN RX
offloading are operations on the two CDM components of the frame engine,
CDMP and CDMQ, which connect to Packet DMA (PDMA) and QoS DMA (QDMA) and
are between the MACs and the CPU. These operations apply to all MACs of the
SoC so if one MAC uses DSA and the other doesn't, the hardware DSA
untagging operation will cause the CDMP component to transmit non DSA
tagged frames to the CPU improperly.

Since the VLAN RX offloading feature configuration was dropped, VLAN RX
offloading can only be used along with hardware DSA untagging. So, for the
case above, we need to disable both features and leave it to the CPU,
therefore software, to untag the DSA and VLAN tags.

So the correct way to handle this is:

For all SoCs:

Enable the proper handling of special tagged (DSA) frames
(MTK_CDMQ_IG_CTRL).

For non MTK_NETSYS_V2 SoCs:

Enable hardware DSA untagging (MTK_CDMP_IG_CTRL).
Enable VLAN RX offloading (MTK_CDMP_EG_CTRL).

When a non MTK_NETSYS_V2 SoC MAC does not use DSA:

Disable hardware DSA untagging (MTK_CDMP_IG_CTRL).
Disable VLAN RX offloading (MTK_CDMP_EG_CTRL).

Fixes: c6d96df9fa2c ("net: ethernet: mtk_eth_soc: drop generic vlan rx offload, only use DSA untagging")
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3272,18 +3272,14 @@ static int mtk_open(struct net_device *d
 			eth->dsa_meta[i] = md_dst;
 		}
 	} else {
-		/* Hardware special tag parsing needs to be disabled if at least
-		 * one MAC does not use DSA.
+		/* Hardware DSA untagging and VLAN RX offloading need to be
+		 * disabled if at least one MAC does not use DSA.
 		 */
 		u32 val = mtk_r32(eth, MTK_CDMP_IG_CTRL);
 
 		val &= ~MTK_CDMP_STAG_EN;
 		mtk_w32(eth, val, MTK_CDMP_IG_CTRL);
 
-		val = mtk_r32(eth, MTK_CDMQ_IG_CTRL);
-		val &= ~MTK_CDMQ_STAG_EN;
-		mtk_w32(eth, val, MTK_CDMQ_IG_CTRL);
-
 		mtk_w32(eth, 0, MTK_CDMP_EG_CTRL);
 	}
 


