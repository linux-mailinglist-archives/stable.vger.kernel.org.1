Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD647E2462
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjKFNVV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjKFNVT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:21:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECF710B
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:21:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4858C433CB;
        Mon,  6 Nov 2023 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276876;
        bh=707In8Gs8XIREYXmeqKd4Cu3hguwejan+8Iu01OFCU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MWrFZyeeHJUlLcZInppK2g9g+TPXwS4zPZIvSdqmIThajtD37scf2H4qaZjn+HXem
         osa9AfyAysSifx3B7bbrTA5ckdBfV2m3YDR6PtlbYO1kEG0oeGir7fTcHvrZhoGROt
         bXcqu/VV1RBuRW9ky1BBVA7HR9jpTh7mPUDGg9MA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 19/74] gtp: fix fragmentation needed check with gso
Date:   Mon,  6 Nov 2023 14:03:39 +0100
Message-ID: <20231106130302.371993817@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.687882731@linuxfoundation.org>
References: <20231106130301.687882731@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 4530e5b8e2dad63dcad2206232dd86e4b1489b6c ]

Call skb_gso_validate_network_len() to check if packet is over PMTU.

Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/gtp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 0409afe9a53d6..c2e649a4f1bf4 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -544,8 +544,9 @@ static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
 
 	rt->dst.ops->update_pmtu(&rt->dst, NULL, skb, mtu, false);
 
-	if (!skb_is_gso(skb) && (iph->frag_off & htons(IP_DF)) &&
-	    mtu < ntohs(iph->tot_len)) {
+	if (iph->frag_off & htons(IP_DF) &&
+	    ((!skb_is_gso(skb) && skb->len > mtu) ||
+	     (skb_is_gso(skb) && !skb_gso_validate_network_len(skb, mtu)))) {
 		netdev_dbg(dev, "packet too big, fragmentation needed\n");
 		icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED,
 			      htonl(mtu));
-- 
2.42.0



