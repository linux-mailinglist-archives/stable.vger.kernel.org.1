Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858D5787256
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240932AbjHXOxB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241829AbjHXOwc (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:52:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5F61BE
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:52:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59DAE66E9D
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8ECC433CD;
        Thu, 24 Aug 2023 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888749;
        bh=9BgpmCh2TK37oz++8FSQEYQRTmmRj4XvsahykOaevLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RoaVIMVcaNTXMTo11ngGE9tBsMKV+sQ2Fm9GI+KIhwN/Km6TC1YyIj4Zifxszyj9Z
         LvOhwCLsxW0xPuBCrYKK10fxQDAsoOHIGSa1FKe6jN90owR6yfhr08meoYHTNLX4Sa
         wADSW6jXj9U8Y+61KjuLDCc+/Ez6sowjnX3kl4Dk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Shurong <zhang_shurong@foxmail.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 028/139] firewire: net: fix use after free in fwnet_finish_incoming_packet()
Date:   Thu, 24 Aug 2023 16:49:11 +0200
Message-ID: <20230824145024.809784960@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhang Shurong <zhang_shurong@foxmail.com>

[ Upstream commit 3ff256751a2853e1ffaa36958ff933ccc98c6cb5 ]

The netif_rx() function frees the skb so we can't dereference it to
save the skb->len.

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Link: https://lore.kernel.org/r/tencent_3B3D24B66ED66A6BB73CC0E63C6A14E45109@qq.com
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firewire/net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/net.c b/drivers/firewire/net.c
index 4c3fd2eed1da4..beba0a56bb9ae 100644
--- a/drivers/firewire/net.c
+++ b/drivers/firewire/net.c
@@ -488,7 +488,7 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
 					struct sk_buff *skb, u16 source_node_id,
 					bool is_broadcast, u16 ether_type)
 {
-	int status;
+	int status, len;
 
 	switch (ether_type) {
 	case ETH_P_ARP:
@@ -542,13 +542,15 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
 		}
 		skb->protocol = protocol;
 	}
+
+	len = skb->len;
 	status = netif_rx(skb);
 	if (status == NET_RX_DROP) {
 		net->stats.rx_errors++;
 		net->stats.rx_dropped++;
 	} else {
 		net->stats.rx_packets++;
-		net->stats.rx_bytes += skb->len;
+		net->stats.rx_bytes += len;
 	}
 
 	return 0;
-- 
2.40.1



