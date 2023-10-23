Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60E07D3554
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbjJWLrM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbjJWLrK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:47:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667DDE4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:47:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5275C433C7;
        Mon, 23 Oct 2023 11:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061628;
        bh=eyzEg+DRUU5G+ieUva3YpeIwBlEMUMXGHc8rVRsl7cQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NRd3sjk31lWWEqli2KPa5GqCTYmfr3+DQBORT0rqNz3xcef8OQDWKANpKiDUSau0x
         D/F43e8lqwcrd+FBg5Hb//EIB5NSW4+l8dJ4VmpaAcdcGYwql3z+Yipx5Vc4eSiVB8
         pP9Kpl2YBu/MFIgNPt2WcMuZuOLUTmey3RW8X5t8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stefan Wahren <wahrenst@gmx.net>,
        Eric Dumazet <edumazet@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10 111/202] tcp: tsq: relax tcp_small_queue_check() when rtx queue contains a single skb
Date:   Mon, 23 Oct 2023 12:56:58 +0200
Message-ID: <20231023104829.780448499@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit f921a4a5bffa8a0005b190fb9421a7fc1fd716b6 upstream.

In commit 75eefc6c59fd ("tcp: tsq: add a shortcut in tcp_small_queue_check()")
we allowed to send an skb regardless of TSQ limits being hit if rtx queue
was empty or had a single skb, in order to better fill the pipe
when/if TX completions were slow.

Then later, commit 75c119afe14f ("tcp: implement rb-tree based
retransmit queue") accidentally removed the special case for
one skb in rtx queue.

Stefan Wahren reported a regression in single TCP flow throughput
using a 100Mbit fec link, starting from commit 65466904b015 ("tcp: adjust
TSO packet sizes based on min_rtt"). This last commit only made the
regression more visible, because it locked the TCP flow on a particular
behavior where TSQ prevented two skbs being pushed downstream,
adding silences on the wire between each TSO packet.

Many thanks to Stefan for his invaluable help !

Fixes: 75c119afe14f ("tcp: implement rb-tree based retransmit queue")
Link: https://lore.kernel.org/netdev/7f31ddc8-9971-495e-a1f6-819df542e0af@gmx.net/
Reported-by: Stefan Wahren <wahrenst@gmx.net>
Tested-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Link: https://lore.kernel.org/r/20231017124526.4060202-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_output.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2482,6 +2482,18 @@ static bool tcp_pacing_check(struct sock
 	return true;
 }
 
+static bool tcp_rtx_queue_empty_or_single_skb(const struct sock *sk)
+{
+	const struct rb_node *node = sk->tcp_rtx_queue.rb_node;
+
+	/* No skb in the rtx queue. */
+	if (!node)
+		return true;
+
+	/* Only one skb in rtx queue. */
+	return !node->rb_left && !node->rb_right;
+}
+
 /* TCP Small Queues :
  * Control number of packets in qdisc/devices to two packets / or ~1 ms.
  * (These limits are doubled for retransmits)
@@ -2519,12 +2531,12 @@ static bool tcp_small_queue_check(struct
 		limit += extra_bytes;
 	}
 	if (refcount_read(&sk->sk_wmem_alloc) > limit) {
-		/* Always send skb if rtx queue is empty.
+		/* Always send skb if rtx queue is empty or has one skb.
 		 * No need to wait for TX completion to call us back,
 		 * after softirq/tasklet schedule.
 		 * This helps when TX completions are delayed too much.
 		 */
-		if (tcp_rtx_queue_empty(sk))
+		if (tcp_rtx_queue_empty_or_single_skb(sk))
 			return false;
 
 		set_bit(TSQ_THROTTLED, &sk->sk_tsq_flags);


