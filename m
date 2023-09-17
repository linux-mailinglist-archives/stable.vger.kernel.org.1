Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A947A38CF
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbjIQTkt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239882AbjIQTk3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:40:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ACDD9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:40:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDEEC433C7;
        Sun, 17 Sep 2023 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979623;
        bh=bzyg6akzCAWLa9+n5itahdGiYhRgm6OQ1WJnzEhqUyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gyVC6lis0DU2F35GMyoZTJj2YU52eTdo2PvbgNk2FSvYiIMDbjT7vMmHb9INWOHuf
         Lw27/yQzJWOtkPjd73hjY99XH9ey17ngkoHLf45G7//yDGy4LqRzcYmAKo346CrVUu
         Ena89OSy+jPnkiXYzS/p/NbeXqajUlJSVcjHOSgU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 342/406] sctp: annotate data-races around sk->sk_wmem_queued
Date:   Sun, 17 Sep 2023 21:13:16 +0200
Message-ID: <20230917191110.309877563@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit dc9511dd6f37fe803f6b15b61b030728d7057417 ]

sk->sk_wmem_queued can be read locklessly from sctp_poll()

Use sk_wmem_queued_add() when the field is changed,
and add READ_ONCE() annotations in sctp_writeable()
and sctp_assocs_seq_show()

syzbot reported:

BUG: KCSAN: data-race in sctp_poll / sctp_wfree

read-write to 0xffff888149d77810 of 4 bytes by interrupt on cpu 0:
sctp_wfree+0x170/0x4a0 net/sctp/socket.c:9147
skb_release_head_state+0xb7/0x1a0 net/core/skbuff.c:988
skb_release_all net/core/skbuff.c:1000 [inline]
__kfree_skb+0x16/0x140 net/core/skbuff.c:1016
consume_skb+0x57/0x180 net/core/skbuff.c:1232
sctp_chunk_destroy net/sctp/sm_make_chunk.c:1503 [inline]
sctp_chunk_put+0xcd/0x130 net/sctp/sm_make_chunk.c:1530
sctp_datamsg_put+0x29a/0x300 net/sctp/chunk.c:128
sctp_chunk_free+0x34/0x50 net/sctp/sm_make_chunk.c:1515
sctp_outq_sack+0xafa/0xd70 net/sctp/outqueue.c:1381
sctp_cmd_process_sack net/sctp/sm_sideeffect.c:834 [inline]
sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1366 [inline]
sctp_side_effects net/sctp/sm_sideeffect.c:1198 [inline]
sctp_do_sm+0x12c7/0x31b0 net/sctp/sm_sideeffect.c:1169
sctp_assoc_bh_rcv+0x2b2/0x430 net/sctp/associola.c:1051
sctp_inq_push+0x108/0x120 net/sctp/inqueue.c:80
sctp_rcv+0x116e/0x1340 net/sctp/input.c:243
sctp6_rcv+0x25/0x40 net/sctp/ipv6.c:1120
ip6_protocol_deliver_rcu+0x92f/0xf30 net/ipv6/ip6_input.c:437
ip6_input_finish net/ipv6/ip6_input.c:482 [inline]
NF_HOOK include/linux/netfilter.h:303 [inline]
ip6_input+0xbd/0x1b0 net/ipv6/ip6_input.c:491
dst_input include/net/dst.h:468 [inline]
ip6_rcv_finish+0x1e2/0x2e0 net/ipv6/ip6_input.c:79
NF_HOOK include/linux/netfilter.h:303 [inline]
ipv6_rcv+0x74/0x150 net/ipv6/ip6_input.c:309
__netif_receive_skb_one_core net/core/dev.c:5452 [inline]
__netif_receive_skb+0x90/0x1b0 net/core/dev.c:5566
process_backlog+0x21f/0x380 net/core/dev.c:5894
__napi_poll+0x60/0x3b0 net/core/dev.c:6460
napi_poll net/core/dev.c:6527 [inline]
net_rx_action+0x32b/0x750 net/core/dev.c:6660
__do_softirq+0xc1/0x265 kernel/softirq.c:553
run_ksoftirqd+0x17/0x20 kernel/softirq.c:921
smpboot_thread_fn+0x30a/0x4a0 kernel/smpboot.c:164
kthread+0x1d7/0x210 kernel/kthread.c:389
ret_from_fork+0x2e/0x40 arch/x86/kernel/process.c:145
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

read to 0xffff888149d77810 of 4 bytes by task 17828 on cpu 1:
sctp_writeable net/sctp/socket.c:9304 [inline]
sctp_poll+0x265/0x410 net/sctp/socket.c:8671
sock_poll+0x253/0x270 net/socket.c:1374
vfs_poll include/linux/poll.h:88 [inline]
do_pollfd fs/select.c:873 [inline]
do_poll fs/select.c:921 [inline]
do_sys_poll+0x636/0xc00 fs/select.c:1015
__do_sys_ppoll fs/select.c:1121 [inline]
__se_sys_ppoll+0x1af/0x1f0 fs/select.c:1101
__x64_sys_ppoll+0x67/0x80 fs/select.c:1101
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x00019e80 -> 0x0000cc80

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 17828 Comm: syz-executor.1 Not tainted 6.5.0-rc7-syzkaller-00185-g28f20a19294d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Xin Long <lucien.xin@gmail.com>
Link: https://lore.kernel.org/r/20230830094519.950007-1-edumazet@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/proc.c   |  2 +-
 net/sctp/socket.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/sctp/proc.c b/net/sctp/proc.c
index 982a87b3e11f8..963b94517ec20 100644
--- a/net/sctp/proc.c
+++ b/net/sctp/proc.c
@@ -284,7 +284,7 @@ static int sctp_assocs_seq_show(struct seq_file *seq, void *v)
 		assoc->init_retries, assoc->shutdown_retries,
 		assoc->rtx_data_chunks,
 		refcount_read(&sk->sk_wmem_alloc),
-		sk->sk_wmem_queued,
+		READ_ONCE(sk->sk_wmem_queued),
 		sk->sk_sndbuf,
 		sk->sk_rcvbuf);
 	seq_printf(seq, "\n");
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index fa4d31b507f29..68d53e3f0d07a 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -68,7 +68,7 @@
 #include <net/sctp/stream_sched.h>
 
 /* Forward declarations for internal helper functions. */
-static bool sctp_writeable(struct sock *sk);
+static bool sctp_writeable(const struct sock *sk);
 static void sctp_wfree(struct sk_buff *skb);
 static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
 				size_t msg_len);
@@ -138,7 +138,7 @@ static inline void sctp_set_owner_w(struct sctp_chunk *chunk)
 
 	refcount_add(sizeof(struct sctp_chunk), &sk->sk_wmem_alloc);
 	asoc->sndbuf_used += chunk->skb->truesize + sizeof(struct sctp_chunk);
-	sk->sk_wmem_queued += chunk->skb->truesize + sizeof(struct sctp_chunk);
+	sk_wmem_queued_add(sk, chunk->skb->truesize + sizeof(struct sctp_chunk));
 	sk_mem_charge(sk, chunk->skb->truesize);
 }
 
@@ -8900,7 +8900,7 @@ static void sctp_wfree(struct sk_buff *skb)
 	struct sock *sk = asoc->base.sk;
 
 	sk_mem_uncharge(sk, skb->truesize);
-	sk->sk_wmem_queued -= skb->truesize + sizeof(struct sctp_chunk);
+	sk_wmem_queued_add(sk, -(skb->truesize + sizeof(struct sctp_chunk)));
 	asoc->sndbuf_used -= skb->truesize + sizeof(struct sctp_chunk);
 	WARN_ON(refcount_sub_and_test(sizeof(struct sctp_chunk),
 				      &sk->sk_wmem_alloc));
@@ -9055,9 +9055,9 @@ void sctp_write_space(struct sock *sk)
  * UDP-style sockets or TCP-style sockets, this code should work.
  *  - Daisy
  */
-static bool sctp_writeable(struct sock *sk)
+static bool sctp_writeable(const struct sock *sk)
 {
-	return sk->sk_sndbuf > sk->sk_wmem_queued;
+	return READ_ONCE(sk->sk_sndbuf) > READ_ONCE(sk->sk_wmem_queued);
 }
 
 /* Wait for an association to go into ESTABLISHED state. If timeout is 0,
-- 
2.40.1



