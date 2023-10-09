Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437147BDDD3
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376877AbjJINNk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376929AbjJINNZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:13:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CD019B4
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:12:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72086C433C9;
        Mon,  9 Oct 2023 13:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857160;
        bh=aGYWqowK+S5KjC6IlZ7zNqQTteh7kbweK+nYYh58mNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vckjx7RwhUI6YwvX8mjDWYpoKS2M+4oKqvfKEBXv0Fm4wB0EmuQsjkDo0UcM6h15L
         nisfBMywdm1OaqbC4N8qYYw7DFrubYBGZHPan00coSCFud/RcyGIGKC8+CRxNyXCRj
         i6CCKWpOVLWs7eyg+Rg/mSeBQWI178/3VzdEXTLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Wilder <dwilder@us.ibm.com>,
        Nick Child <nnac123@linux.ibm.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 116/163] ibmveth: Remove condition to recompute TCP header checksum.
Date:   Mon,  9 Oct 2023 15:01:20 +0200
Message-ID: <20231009130127.230109711@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Wilder <dwilder@us.ibm.com>

[ Upstream commit 51e7a66666e0ca9642c59464ef8359f0ac604d41 ]

In some OVS environments the TCP pseudo header checksum may need to be
recomputed. Currently this is only done when the interface instance is
configured for "Trunk Mode". We found the issue also occurs in some
Kubernetes environments, these environments do not use "Trunk Mode",
therefor the condition is removed.

Performance tests with this change show only a fractional decrease in
throughput (< 0.2%).

Fixes: 7525de2516fb ("ibmveth: Set CHECKSUM_PARTIAL if NULL TCP CSUM.")
Signed-off-by: David Wilder <dwilder@us.ibm.com>
Reviewed-by: Nick Child <nnac123@linux.ibm.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmveth.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 832a2ae019509..a8d79ee350f8d 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1303,24 +1303,23 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 	 * the user space for finding a flow. During this process, OVS computes
 	 * checksum on the first packet when CHECKSUM_PARTIAL flag is set.
 	 *
-	 * So, re-compute TCP pseudo header checksum when configured for
-	 * trunk mode.
+	 * So, re-compute TCP pseudo header checksum.
 	 */
+
 	if (iph_proto == IPPROTO_TCP) {
 		struct tcphdr *tcph = (struct tcphdr *)(skb->data + iphlen);
+
 		if (tcph->check == 0x0000) {
 			/* Recompute TCP pseudo header checksum  */
-			if (adapter->is_active_trunk) {
-				tcphdrlen = skb->len - iphlen;
-				if (skb_proto == ETH_P_IP)
-					tcph->check =
-					 ~csum_tcpudp_magic(iph->saddr,
-					iph->daddr, tcphdrlen, iph_proto, 0);
-				else if (skb_proto == ETH_P_IPV6)
-					tcph->check =
-					 ~csum_ipv6_magic(&iph6->saddr,
-					&iph6->daddr, tcphdrlen, iph_proto, 0);
-			}
+			tcphdrlen = skb->len - iphlen;
+			if (skb_proto == ETH_P_IP)
+				tcph->check =
+				 ~csum_tcpudp_magic(iph->saddr,
+				iph->daddr, tcphdrlen, iph_proto, 0);
+			else if (skb_proto == ETH_P_IPV6)
+				tcph->check =
+				 ~csum_ipv6_magic(&iph6->saddr,
+				&iph6->daddr, tcphdrlen, iph_proto, 0);
 			/* Setup SKB fields for checksum offload */
 			skb_partial_csum_set(skb, iphlen,
 					     offsetof(struct tcphdr, check));
-- 
2.40.1



