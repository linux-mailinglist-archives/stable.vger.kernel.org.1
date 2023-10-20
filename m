Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C16F7D1507
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 19:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377934AbjJTRmI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 13:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377939AbjJTRmH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 13:42:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4F5FA
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 10:42:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04326C433C8;
        Fri, 20 Oct 2023 17:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697823725;
        bh=kUsH6I5CpzwmqmndnMcFm/tJUwjW5QQo2g2eUGALUow=;
        h=Subject:To:Cc:From:Date:From;
        b=lLmVY4yt2KJGbj4XsGhOFAQsjV2VcavIvN2pz2fXs7mXpV9IyAxAvnE71mDy/eXrp
         CwczlIxZ9U4mOWfm8LwKOaYMpV+Qkiw52yLHqVQZuBQCZHvbJDeqBi8y7hgP/B+bLY
         NnML2ZmrhQ53Mgt0+Ma1CV/7dKuBLxFuKVz3OoMQ=
Subject: FAILED: patch "[PATCH] mptcp: more conservative check for zero probes" failed to apply to 5.15-stable tree
To:     pabeni@redhat.com, cpaasch@apple.com, kuba@kernel.org,
        martineau@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 19:42:02 +0200
Message-ID: <2023102002-grooving-carnivore-aa31@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 72377ab2d671befd6390a1d5677f5cca61235b65
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102002-grooving-carnivore-aa31@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 72377ab2d671befd6390a1d5677f5cca61235b65 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 18 Oct 2023 11:23:54 -0700
Subject: [PATCH] mptcp: more conservative check for zero probes

Christoph reported that the MPTCP protocol can find the subflow-level
write queue unexpectedly not empty while crafting a zero-window probe,
hitting a warning:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 188 at net/mptcp/protocol.c:1312 mptcp_sendmsg_frag+0xc06/0xe70
Modules linked in:
CPU: 0 PID: 188 Comm: kworker/0:2 Not tainted 6.6.0-rc2-g1176aa719d7a #47
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
Workqueue: events mptcp_worker
RIP: 0010:mptcp_sendmsg_frag+0xc06/0xe70 net/mptcp/protocol.c:1312
RAX: 47d0530de347ff6a RBX: 47d0530de347ff6b RCX: ffff8881015d3c00
RDX: ffff8881015d3c00 RSI: 47d0530de347ff6b RDI: 47d0530de347ff6b
RBP: 47d0530de347ff6b R08: ffffffff8243c6a8 R09: ffffffff82042d9c
R10: 0000000000000002 R11: ffffffff82056850 R12: ffff88812a13d580
R13: 0000000000000001 R14: ffff88812b375e50 R15: ffff88812bbf3200
FS:  0000000000000000(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000695118 CR3: 0000000115dfc001 CR4: 0000000000170ef0
Call Trace:
 <TASK>
 __subflow_push_pending+0xa4/0x420 net/mptcp/protocol.c:1545
 __mptcp_push_pending+0x128/0x3b0 net/mptcp/protocol.c:1614
 mptcp_release_cb+0x218/0x5b0 net/mptcp/protocol.c:3391
 release_sock+0xf6/0x100 net/core/sock.c:3521
 mptcp_worker+0x6e8/0x8f0 net/mptcp/protocol.c:2746
 process_scheduled_works+0x341/0x690 kernel/workqueue.c:2630
 worker_thread+0x3a7/0x610 kernel/workqueue.c:2784
 kthread+0x143/0x180 kernel/kthread.c:388
 ret_from_fork+0x4d/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:304
 </TASK>

The root cause of the issue is that expectations are wrong: e.g. due
to MPTCP-level re-injection we can hit the critical condition.

Explicitly avoid the zero-window probe when the subflow write queue
is not empty and drop the related warnings.

Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/444
Fixes: f70cad1085d1 ("mptcp: stop relying on tcp_tx_skb_cache")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20231018-send-net-20231018-v1-3-17ecb002e41d@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d1902373c974..4e30e5ba3795 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1298,7 +1298,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	if (copy == 0) {
 		u64 snd_una = READ_ONCE(msk->snd_una);
 
-		if (snd_una != msk->snd_nxt) {
+		if (snd_una != msk->snd_nxt || tcp_write_queue_tail(ssk)) {
 			tcp_remove_empty_skb(ssk);
 			return 0;
 		}
@@ -1306,11 +1306,6 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		zero_window_probe = true;
 		data_seq = snd_una - 1;
 		copy = 1;
-
-		/* all mptcp-level data is acked, no skbs should be present into the
-		 * ssk write queue
-		 */
-		WARN_ON_ONCE(reuse_skb);
 	}
 
 	copy = min_t(size_t, copy, info->limit - info->sent);
@@ -1339,7 +1334,6 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	if (reuse_skb) {
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_PSH;
 		mpext->data_len += copy;
-		WARN_ON_ONCE(zero_window_probe);
 		goto out;
 	}
 

