Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A466D79B53A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348210AbjIKV2q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241421AbjIKPIR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:08:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B624FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:08:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C203C433C9;
        Mon, 11 Sep 2023 15:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444892;
        bh=Mj7jXKGo0sintG9T7jvkgvcYBJzqZaktGJIdjTdMGOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=edGz6wkNnT2PznV0ZPTE4+FHJMKbUUX5t+g1utQOMmPXNy7qjCV+oZVkbYQnYWtWh
         02VPcPVcftAlMT/er6c+WFjGb5GijT6G79Gq8KiyrSOdEpqwCrhTERjcSrmp6+8U9q
         X7OEEtHPazK3PV+29i4GeB5lKFnDvwHbxhJK/jAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Joe Stringer <joe@cilium.io>,
        Lorenz Bauer <lmb@isovalent.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 152/600] bpf: reject unhashed sockets in bpf_sk_assign
Date:   Mon, 11 Sep 2023 15:43:05 +0200
Message-ID: <20230911134638.096373407@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenz Bauer <lmb@isovalent.com>

[ Upstream commit 67312adc96b5a585970d03b62412847afe2c6b01 ]

The semantics for bpf_sk_assign are as follows:

    sk = some_lookup_func()
    bpf_sk_assign(skb, sk)
    bpf_sk_release(sk)

That is, the sk is not consumed by bpf_sk_assign. The function
therefore needs to make sure that sk lives long enough to be
consumed from __inet_lookup_skb. The path through the stack for a
TCPv4 packet is roughly:

  netif_receive_skb_core: takes RCU read lock
    __netif_receive_skb_core:
      sch_handle_ingress:
        tcf_classify:
          bpf_sk_assign()
      deliver_ptype_list_skb:
        deliver_skb:
          ip_packet_type->func == ip_rcv:
            ip_rcv_core:
            ip_rcv_finish_core:
              dst_input:
                ip_local_deliver:
                  ip_local_deliver_finish:
                    ip_protocol_deliver_rcu:
                      tcp_v4_rcv:
                        __inet_lookup_skb:
                          skb_steal_sock

The existing helper takes advantage of the fact that everything
happens in the same RCU critical section: for sockets with
SOCK_RCU_FREE set bpf_sk_assign never takes a reference.
skb_steal_sock then checks SOCK_RCU_FREE again and does sock_put
if necessary.

This approach assumes that SOCK_RCU_FREE is never set on a sk
between bpf_sk_assign and skb_steal_sock, but this invariant is
violated by unhashed UDP sockets. A new UDP socket is created
in TCP_CLOSE state but without SOCK_RCU_FREE set. That flag is only
added in udp_lib_get_port() which happens when a socket is bound.

When bpf_sk_assign was added it wasn't possible to access unhashed
UDP sockets from BPF, so this wasn't a problem. This changed
in commit 0c48eefae712 ("sock_map: Lift socket state restriction
for datagram sockets"), but the helper wasn't adjusted accordingly.
The following sequence of events will therefore lead to a refcount
leak:

1. Add socket(AF_INET, SOCK_DGRAM) to a sockmap.
2. Pull socket out of sockmap and bpf_sk_assign it. Since
   SOCK_RCU_FREE is not set we increment the refcount.
3. bind() or connect() the socket, setting SOCK_RCU_FREE.
4. skb_steal_sock will now set refcounted = false due to
   SOCK_RCU_FREE.
5. tcp_v4_rcv() skips sock_put().

Fix the problem by rejecting unhashed sockets in bpf_sk_assign().
This matches the behaviour of __inet_lookup_skb which is ultimately
the goal of bpf_sk_assign().

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Cc: Joe Stringer <joe@cilium.io>
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20230720-so-reuseport-v6-2-7021b683cdae@isovalent.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 419ce7c61bd6b..9fd7c88b5db4e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7259,6 +7259,8 @@ BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
 		return -ENETUNREACH;
 	if (unlikely(sk_fullsock(sk) && sk->sk_reuseport))
 		return -ESOCKTNOSUPPORT;
+	if (sk_unhashed(sk))
+		return -EOPNOTSUPP;
 	if (sk_is_refcounted(sk) &&
 	    unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
 		return -ENOENT;
-- 
2.40.1



