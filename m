Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B397A3C9E
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241097AbjIQUdL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241220AbjIQUdB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:33:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92262101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:32:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8770C433C8;
        Sun, 17 Sep 2023 20:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982776;
        bh=lt0zbP3hBW83ZdViEThNxoMs3CDBBmRQ/DUYSk21mfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IR8G0RP+C3pJBbLxnty7F6nwJb5L1ScGDXvd7kGazwH8c/veRyvV28zdaKTs00gwz
         i3XXVcl+c0pN1kr3jan22CmZ09zifatVSaIfVf9T9AASU3MoYNF0/n+oiRI8PDATIb
         0F83xB+/BC8mTQFn7u5hcU25kItaG5lCADcvJUek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jann Horn <jannh@google.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 350/511] dccp: Fix out of bounds access in DCCP error handler
Date:   Sun, 17 Sep 2023 21:12:57 +0200
Message-ID: <20230917191122.257869384@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 977ad86c2a1bcaf58f01ab98df5cc145083c489c upstream.

There was a previous attempt to fix an out-of-bounds access in the DCCP
error handlers, but that fix assumed that the error handlers only want
to access the first 8 bytes of the DCCP header. Actually, they also look
at the DCCP sequence number, which is stored beyond 8 bytes, so an
explicit pskb_may_pull() is required.

Fixes: 6706a97fec96 ("dccp: fix out of bound access in dccp_v4_err()")
Fixes: 1aa9d1a0e7ee ("ipv6: dccp: fix out of bound access in dccp_v6_err()")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dccp/ipv4.c |   13 +++++++++----
 net/dccp/ipv6.c |   15 ++++++++++-----
 2 files changed, 19 insertions(+), 9 deletions(-)

--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -250,12 +250,17 @@ static int dccp_v4_err(struct sk_buff *s
 	int err;
 	struct net *net = dev_net(skb->dev);
 
-	/* Only need dccph_dport & dccph_sport which are the first
-	 * 4 bytes in dccp header.
+	/* For the first __dccp_basic_hdr_len() check, we only need dh->dccph_x,
+	 * which is in byte 7 of the dccp header.
 	 * Our caller (icmp_socket_deliver()) already pulled 8 bytes for us.
+	 *
+	 * Later on, we want to access the sequence number fields, which are
+	 * beyond 8 bytes, so we have to pskb_may_pull() ourselves.
 	 */
-	BUILD_BUG_ON(offsetofend(struct dccp_hdr, dccph_sport) > 8);
-	BUILD_BUG_ON(offsetofend(struct dccp_hdr, dccph_dport) > 8);
+	dh = (struct dccp_hdr *)(skb->data + offset);
+	if (!pskb_may_pull(skb, offset + __dccp_basic_hdr_len(dh)))
+		return -EINVAL;
+	iph = (struct iphdr *)skb->data;
 	dh = (struct dccp_hdr *)(skb->data + offset);
 
 	sk = __inet_lookup_established(net, &dccp_hashinfo,
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -74,7 +74,7 @@ static inline __u64 dccp_v6_init_sequenc
 static int dccp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 			u8 type, u8 code, int offset, __be32 info)
 {
-	const struct ipv6hdr *hdr = (const struct ipv6hdr *)skb->data;
+	const struct ipv6hdr *hdr;
 	const struct dccp_hdr *dh;
 	struct dccp_sock *dp;
 	struct ipv6_pinfo *np;
@@ -83,12 +83,17 @@ static int dccp_v6_err(struct sk_buff *s
 	__u64 seq;
 	struct net *net = dev_net(skb->dev);
 
-	/* Only need dccph_dport & dccph_sport which are the first
-	 * 4 bytes in dccp header.
+	/* For the first __dccp_basic_hdr_len() check, we only need dh->dccph_x,
+	 * which is in byte 7 of the dccp header.
 	 * Our caller (icmpv6_notify()) already pulled 8 bytes for us.
+	 *
+	 * Later on, we want to access the sequence number fields, which are
+	 * beyond 8 bytes, so we have to pskb_may_pull() ourselves.
 	 */
-	BUILD_BUG_ON(offsetofend(struct dccp_hdr, dccph_sport) > 8);
-	BUILD_BUG_ON(offsetofend(struct dccp_hdr, dccph_dport) > 8);
+	dh = (struct dccp_hdr *)(skb->data + offset);
+	if (!pskb_may_pull(skb, offset + __dccp_basic_hdr_len(dh)))
+		return -EINVAL;
+	hdr = (const struct ipv6hdr *)skb->data;
 	dh = (struct dccp_hdr *)(skb->data + offset);
 
 	sk = __inet6_lookup_established(net, &dccp_hashinfo,


