Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6000E7DD532
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376453AbjJaRsF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376470AbjJaRsE (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:48:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3A8129
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:47:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA0FC433C9;
        Tue, 31 Oct 2023 17:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774471;
        bh=c4cUGdYCDqW3utYO/pZ4pKouJPUnuWbN5DTbdUVtmwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QmlMlwZRq04l8nBArmc5De1tbS8BL8g3J//sAaQE6RCeIXjVeXsuXiJjizCo4/HTA
         x72yP0Gdcrd1PY94nhUS/HuQ9zZyTdKWvPWY+xMGEy/GASqusGtIq3gZnQIt49hKvN
         SpA/TNoSZNHBzuIw6RybDyaslJNrgTfdo3K2eCpU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 056/112] net: do not leave an empty skb in write queue
Date:   Tue, 31 Oct 2023 18:00:57 +0100
Message-ID: <20231031165903.082981401@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 72bf4f1767f0386970dc04726dc5bc2e3991dc19 ]

Under memory stress conditions, tcp_sendmsg_locked()
might call sk_stream_wait_memory(), thus releasing the socket lock.

If a fresh skb has been allocated prior to this,
we should not leave it in the write queue otherwise
tcp_write_xmit() could panic.

This apparently does not happen often, but a future change
in __sk_mem_raise_allocated() that Shakeel and others are
considering would increase chances of being hurt.

Under discussion is to remove this controversial part:

    /* Fail only if socket is _under_ its sndbuf.
     * In this case we cannot block, so that we have to fail.
     */
    if (sk->sk_wmem_queued + size >= sk->sk_sndbuf) {
        /* Force charge with __GFP_NOFAIL */
        if (memcg_charge && !charged) {
            mem_cgroup_charge_skmem(sk->sk_memcg, amt,
                gfp_memcg_charge() | __GFP_NOFAIL);
        }
        return 1;
    }

Fixes: fdfc5c8594c2 ("tcp: remove empty skb from write queue in error cases")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Link: https://lore.kernel.org/r/20231019112457.1190114-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 9bdc1b2eaf734..a0a87446f827c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -925,10 +925,11 @@ int tcp_send_mss(struct sock *sk, int *size_goal, int flags)
 	return mss_now;
 }
 
-/* In some cases, both sendmsg() could have added an skb to the write queue,
- * but failed adding payload on it.  We need to remove it to consume less
+/* In some cases, sendmsg() could have added an skb to the write queue,
+ * but failed adding payload on it. We need to remove it to consume less
  * memory, but more importantly be able to generate EPOLLOUT for Edge Trigger
- * epoll() users.
+ * epoll() users. Another reason is that tcp_write_xmit() does not like
+ * finding an empty skb in the write queue.
  */
 void tcp_remove_empty_skb(struct sock *sk)
 {
@@ -1286,6 +1287,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 
 wait_for_space:
 		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		tcp_remove_empty_skb(sk);
 		if (copied)
 			tcp_push(sk, flags & ~MSG_MORE, mss_now,
 				 TCP_NAGLE_PUSH, size_goal);
-- 
2.42.0



