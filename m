Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEDF72C193
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbjFLK66 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbjFLKyl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:54:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D24035B6
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6F07623CE
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CA7C433EF;
        Mon, 12 Jun 2023 10:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566459;
        bh=6Y6/0m5cmc2yHceB393htXJuSpcOf+tERViRuoHXJdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ekvluzz5Dd86HmdB2PEfzFBJuFSsDsHwAvcegr6fD8xmc9mP/vKbPAbj+Bfq1QAQF
         SK4UNoLvdyX2/EKPLpZdJSQrCJhMhpfPMTLFqPY2+8gxK6bCe+824+sv4gDrhFR9eU
         StjXyw8GADotN2FfUUi3vpSZYaweal6pyKcUoF3g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 040/132] tcp: gso: really support BIG TCP
Date:   Mon, 12 Jun 2023 12:26:14 +0200
Message-ID: <20230612101712.064304973@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 82a01ab35bd02ba4b0b4e12bc95c5b69240eb7b0 ]

We missed that tcp_gso_segment() was assuming skb->len was smaller than 65535 :

oldlen = (u16)~skb->len;

This part came with commit 0718bcc09b35 ("[NET]: Fix CHECKSUM_HW GSO problems.")

This leads to wrong TCP checksum.

Adapt the code to accept arbitrary packet length.

v2:
  - use two csum_add() instead of csum_fold() (Alexander Duyck)
  - Change delta type to __wsum to reduce casts (Alexander Duyck)

Fixes: 09f3d1a3a52c ("ipv6/gso: remove temporary HBH/jumbo header")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230605161647.3624428-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_offload.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 45dda78893870..4851211aa60d6 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -60,12 +60,12 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	struct tcphdr *th;
 	unsigned int thlen;
 	unsigned int seq;
-	__be32 delta;
 	unsigned int oldlen;
 	unsigned int mss;
 	struct sk_buff *gso_skb = skb;
 	__sum16 newcheck;
 	bool ooo_okay, copy_destructor;
+	__wsum delta;
 
 	th = tcp_hdr(skb);
 	thlen = th->doff * 4;
@@ -75,7 +75,7 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, thlen))
 		goto out;
 
-	oldlen = (u16)~skb->len;
+	oldlen = ~skb->len;
 	__skb_pull(skb, thlen);
 
 	mss = skb_shinfo(skb)->gso_size;
@@ -110,7 +110,7 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	if (skb_is_gso(segs))
 		mss *= skb_shinfo(segs)->gso_segs;
 
-	delta = htonl(oldlen + (thlen + mss));
+	delta = (__force __wsum)htonl(oldlen + thlen + mss);
 
 	skb = segs;
 	th = tcp_hdr(skb);
@@ -119,8 +119,7 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	if (unlikely(skb_shinfo(gso_skb)->tx_flags & SKBTX_SW_TSTAMP))
 		tcp_gso_tstamp(segs, skb_shinfo(gso_skb)->tskey, seq, mss);
 
-	newcheck = ~csum_fold((__force __wsum)((__force u32)th->check +
-					       (__force u32)delta));
+	newcheck = ~csum_fold(csum_add(csum_unfold(th->check), delta));
 
 	while (skb->next) {
 		th->fin = th->psh = 0;
@@ -165,11 +164,11 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 			WARN_ON_ONCE(refcount_sub_and_test(-delta, &skb->sk->sk_wmem_alloc));
 	}
 
-	delta = htonl(oldlen + (skb_tail_pointer(skb) -
-				skb_transport_header(skb)) +
-		      skb->data_len);
-	th->check = ~csum_fold((__force __wsum)((__force u32)th->check +
-				(__force u32)delta));
+	delta = (__force __wsum)htonl(oldlen +
+				      (skb_tail_pointer(skb) -
+				       skb_transport_header(skb)) +
+				      skb->data_len);
+	th->check = ~csum_fold(csum_add(csum_unfold(th->check), delta));
 	if (skb->ip_summed == CHECKSUM_PARTIAL)
 		gso_reset_checksum(skb, ~th->check);
 	else
-- 
2.39.2



