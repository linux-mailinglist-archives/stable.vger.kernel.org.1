Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1376679BA26
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243982AbjIKVIH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240897AbjIKO4w (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:56:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833F0E4D
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:56:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76E7C433C8;
        Mon, 11 Sep 2023 14:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444206;
        bh=xNHDj8BRyL+7Dj3S0cZyWFnTaLuhuoLNKEAFz3vV+KM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ekFVIS7vLIvy4obN6nMeQleCj23c1s4Kbfb0t05um9Rm3S4TWy4MXoJiPMQzSPKT+
         793CxjYf3pe8HKRrs/wl74EQ8tOMJMpdfH7Xyh+q660+aGel7u0R57tbT6ZWR7tAX/
         IMp+6mUt9pKDsKxSa5sQeZhTpQxVNd5c4Q8aWCsI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mohamed Khalfella <mkhalfella@purestorage.com>,
        Amit Goyal <agoyal@purestorage.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.4 640/737] skbuff: skb_segment, Call zero copy functions before using skbuff frags
Date:   Mon, 11 Sep 2023 15:48:19 +0200
Message-ID: <20230911134708.408129246@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mohamed Khalfella <mkhalfella@purestorage.com>

commit 2ea35288c83b3d501a88bc17f2df8f176b5cc96f upstream.

Commit bf5c25d60861 ("skbuff: in skb_segment, call zerocopy functions
once per nskb") added the call to zero copy functions in skb_segment().
The change introduced a bug in skb_segment() because skb_orphan_frags()
may possibly change the number of fragments or allocate new fragments
altogether leaving nrfrags and frag to point to the old values. This can
cause a panic with stacktrace like the one below.

[  193.894380] BUG: kernel NULL pointer dereference, address: 00000000000000bc
[  193.895273] CPU: 13 PID: 18164 Comm: vh-net-17428 Kdump: loaded Tainted: G           O      5.15.123+ #26
[  193.903919] RIP: 0010:skb_segment+0xb0e/0x12f0
[  194.021892] Call Trace:
[  194.027422]  <TASK>
[  194.072861]  tcp_gso_segment+0x107/0x540
[  194.082031]  inet_gso_segment+0x15c/0x3d0
[  194.090783]  skb_mac_gso_segment+0x9f/0x110
[  194.095016]  __skb_gso_segment+0xc1/0x190
[  194.103131]  netem_enqueue+0x290/0xb10 [sch_netem]
[  194.107071]  dev_qdisc_enqueue+0x16/0x70
[  194.110884]  __dev_queue_xmit+0x63b/0xb30
[  194.121670]  bond_start_xmit+0x159/0x380 [bonding]
[  194.128506]  dev_hard_start_xmit+0xc3/0x1e0
[  194.131787]  __dev_queue_xmit+0x8a0/0xb30
[  194.138225]  macvlan_start_xmit+0x4f/0x100 [macvlan]
[  194.141477]  dev_hard_start_xmit+0xc3/0x1e0
[  194.144622]  sch_direct_xmit+0xe3/0x280
[  194.147748]  __dev_queue_xmit+0x54a/0xb30
[  194.154131]  tap_get_user+0x2a8/0x9c0 [tap]
[  194.157358]  tap_sendmsg+0x52/0x8e0 [tap]
[  194.167049]  handle_tx_zerocopy+0x14e/0x4c0 [vhost_net]
[  194.173631]  handle_tx+0xcd/0xe0 [vhost_net]
[  194.176959]  vhost_worker+0x76/0xb0 [vhost]
[  194.183667]  kthread+0x118/0x140
[  194.190358]  ret_from_fork+0x1f/0x30
[  194.193670]  </TASK>

In this case calling skb_orphan_frags() updated nr_frags leaving nrfrags
local variable in skb_segment() stale. This resulted in the code hitting
i >= nrfrags prematurely and trying to move to next frag_skb using
list_skb pointer, which was NULL, and caused kernel panic. Move the call
to zero copy functions before using frags and nr_frags.

Fixes: bf5c25d60861 ("skbuff: in skb_segment, call zerocopy functions once per nskb")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reported-by: Amit Goyal <agoyal@purestorage.com>
Cc: stable@vger.kernel.org
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/skbuff.c |   34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4370,21 +4370,20 @@ struct sk_buff *skb_segment(struct sk_bu
 	struct sk_buff *segs = NULL;
 	struct sk_buff *tail = NULL;
 	struct sk_buff *list_skb = skb_shinfo(head_skb)->frag_list;
-	skb_frag_t *frag = skb_shinfo(head_skb)->frags;
 	unsigned int mss = skb_shinfo(head_skb)->gso_size;
 	unsigned int doffset = head_skb->data - skb_mac_header(head_skb);
-	struct sk_buff *frag_skb = head_skb;
 	unsigned int offset = doffset;
 	unsigned int tnl_hlen = skb_tnl_header_len(head_skb);
 	unsigned int partial_segs = 0;
 	unsigned int headroom;
 	unsigned int len = head_skb->len;
+	struct sk_buff *frag_skb;
+	skb_frag_t *frag;
 	__be16 proto;
 	bool csum, sg;
-	int nfrags = skb_shinfo(head_skb)->nr_frags;
 	int err = -ENOMEM;
 	int i = 0;
-	int pos;
+	int nfrags, pos;
 
 	if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
 	    mss != GSO_BY_FRAGS && mss != skb_headlen(head_skb)) {
@@ -4461,6 +4460,13 @@ normal:
 	headroom = skb_headroom(head_skb);
 	pos = skb_headlen(head_skb);
 
+	if (skb_orphan_frags(head_skb, GFP_ATOMIC))
+		return ERR_PTR(-ENOMEM);
+
+	nfrags = skb_shinfo(head_skb)->nr_frags;
+	frag = skb_shinfo(head_skb)->frags;
+	frag_skb = head_skb;
+
 	do {
 		struct sk_buff *nskb;
 		skb_frag_t *nskb_frag;
@@ -4481,6 +4487,10 @@ normal:
 		    (skb_headlen(list_skb) == len || sg)) {
 			BUG_ON(skb_headlen(list_skb) > len);
 
+			nskb = skb_clone(list_skb, GFP_ATOMIC);
+			if (unlikely(!nskb))
+				goto err;
+
 			i = 0;
 			nfrags = skb_shinfo(list_skb)->nr_frags;
 			frag = skb_shinfo(list_skb)->frags;
@@ -4499,12 +4509,8 @@ normal:
 				frag++;
 			}
 
-			nskb = skb_clone(list_skb, GFP_ATOMIC);
 			list_skb = list_skb->next;
 
-			if (unlikely(!nskb))
-				goto err;
-
 			if (unlikely(pskb_trim(nskb, len))) {
 				kfree_skb(nskb);
 				goto err;
@@ -4580,12 +4586,16 @@ normal:
 		skb_shinfo(nskb)->flags |= skb_shinfo(head_skb)->flags &
 					   SKBFL_SHARED_FRAG;
 
-		if (skb_orphan_frags(frag_skb, GFP_ATOMIC) ||
-		    skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
+		if (skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
 			goto err;
 
 		while (pos < offset + len) {
 			if (i >= nfrags) {
+				if (skb_orphan_frags(list_skb, GFP_ATOMIC) ||
+				    skb_zerocopy_clone(nskb, list_skb,
+						       GFP_ATOMIC))
+					goto err;
+
 				i = 0;
 				nfrags = skb_shinfo(list_skb)->nr_frags;
 				frag = skb_shinfo(list_skb)->frags;
@@ -4599,10 +4609,6 @@ normal:
 					i--;
 					frag--;
 				}
-				if (skb_orphan_frags(frag_skb, GFP_ATOMIC) ||
-				    skb_zerocopy_clone(nskb, frag_skb,
-						       GFP_ATOMIC))
-					goto err;
 
 				list_skb = list_skb->next;
 			}


