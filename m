Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD2C7BDDCB
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376950AbjJINN1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376989AbjJINNN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:13:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFB01988
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:12:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A458EC433CA;
        Mon,  9 Oct 2023 13:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857137;
        bh=ne1u9WoazvFeUrkisEgnYTJY0pcnwG1Y2qPqMySl4ZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w2cLSF63B3W59TPECWU3T9WrcYSKMIoSmuGBA9lktsUn6WtI2myJ4TV3ZwEbiHiCi
         j6Cy1SN9r1keh/f6Pjdq6TbDvVpwNgzoOxIozd42HOSS+Rx1awq1BXo0t2Gm+j+nye
         c2sAao6V8BswZPKLBlii8gwbhH0PV3ITtqXYDu+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ilya Maximets <i.maximets@ovn.org>,
        Florian Westphal <fw@strlen.de>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 109/163] ipv6: tcp: add a missing nf_reset_ct() in 3WHS handling
Date:   Mon,  9 Oct 2023 15:01:13 +0200
Message-ID: <20231009130127.033296399@linuxfoundation.org>
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

From: Ilya Maximets <i.maximets@ovn.org>

[ Upstream commit 9593c7cb6cf670ef724d17f7f9affd7a8d2ad0c5 ]

Commit b0e214d21203 ("netfilter: keep conntrack reference until
IPsecv6 policy checks are done") is a direct copy of the old
commit b59c270104f0 ("[NETFILTER]: Keep conntrack reference until
IPsec policy checks are done") but for IPv6.  However, it also
copies a bug that this old commit had.  That is: when the third
packet of 3WHS connection establishment contains payload, it is
added into socket receive queue without the XFRM check and the
drop of connection tracking context.

That leads to nf_conntrack module being impossible to unload as
it waits for all the conntrack references to be dropped while
the packet release is deferred in per-cpu cache indefinitely, if
not consumed by the application.

The issue for IPv4 was fixed in commit 6f0012e35160 ("tcp: add a
missing nf_reset_ct() in 3WHS handling") by adding a missing XFRM
check and correctly dropping the conntrack context.  However, the
issue was introduced to IPv6 code afterwards.  Fixing it the
same way for IPv6 now.

Fixes: b0e214d21203 ("netfilter: keep conntrack reference until IPsecv6 policy checks are done")
Link: https://lore.kernel.org/netdev/d589a999-d4dd-2768-b2d5-89dec64a4a42@ovn.org/
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Acked-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20230922210530.2045146-1-i.maximets@ovn.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/tcp_ipv6.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 3a88545a265d6..44b6949d72b22 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1640,9 +1640,12 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		struct sock *nsk;
 
 		sk = req->rsk_listener;
-		drop_reason = tcp_inbound_md5_hash(sk, skb,
-						   &hdr->saddr, &hdr->daddr,
-						   AF_INET6, dif, sdif);
+		if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb))
+			drop_reason = SKB_DROP_REASON_XFRM_POLICY;
+		else
+			drop_reason = tcp_inbound_md5_hash(sk, skb,
+							   &hdr->saddr, &hdr->daddr,
+							   AF_INET6, dif, sdif);
 		if (drop_reason) {
 			sk_drops_add(sk, skb);
 			reqsk_put(req);
@@ -1689,6 +1692,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 			}
 			goto discard_and_relse;
 		}
+		nf_reset_ct(skb);
 		if (nsk == sk) {
 			reqsk_put(req);
 			tcp_v6_restore_cb(skb);
-- 
2.40.1



