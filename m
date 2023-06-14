Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7BB719E28
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbjFANaE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjFAN3g (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:29:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C0910DB
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:29:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 155BB644E0
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3C0C433D2;
        Thu,  1 Jun 2023 13:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626127;
        bh=oyglGTGbEN3D5TQ9IFT3+7aONeguU8TCotegFKO3iVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/uWtL8y4CTLaohTXVN1sh6PNPkk4pjIRM2JmBFJ9zwRAKYyppG80ic/jx3csiLpe
         FIuMh87MkJxL2zDWKKPUDgZF1OibaSMDwqPQdeddMJKystDAgdE3R0sbSxLi+3dzyJ
         ACfJbiHOGZSwL3w3loZCUvje2fY6eYjPePEelq10=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        William Findlay <will@isovalent.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 15/42] bpf, sockmap: Convert schedule_work into delayed_work
Date:   Thu,  1 Jun 2023 14:21:24 +0100
Message-Id: <20230601131939.731926934@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131939.051934720@linuxfoundation.org>
References: <20230601131939.051934720@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit 29173d07f79883ac94f5570294f98af3d4287382 ]

Sk_buffs are fed into sockmap verdict programs either from a strparser
(when the user might want to decide how framing of skb is done by attaching
another parser program) or directly through tcp_read_sock. The
tcp_read_sock is the preferred method for performance when the BPF logic is
a stream parser.

The flow for Cilium's common use case with a stream parser is,

 tcp_read_sock()
  sk_psock_verdict_recv
    ret = bpf_prog_run_pin_on_cpu()
    sk_psock_verdict_apply(sock, skb, ret)
     // if system is under memory pressure or app is slow we may
     // need to queue skb. Do this queuing through ingress_skb and
     // then kick timer to wake up handler
     skb_queue_tail(ingress_skb, skb)
     schedule_work(work);

The work queue is wired up to sk_psock_backlog(). This will then walk the
ingress_skb skb list that holds our sk_buffs that could not be handled,
but should be OK to run at some later point. However, its possible that
the workqueue doing this work still hits an error when sending the skb.
When this happens the skbuff is requeued on a temporary 'state' struct
kept with the workqueue. This is necessary because its possible to
partially send an skbuff before hitting an error and we need to know how
and where to restart when the workqueue runs next.

Now for the trouble, we don't rekick the workqueue. This can cause a
stall where the skbuff we just cached on the state variable might never
be sent. This happens when its the last packet in a flow and no further
packets come along that would cause the system to kick the workqueue from
that side.

To fix we could do simple schedule_work(), but while under memory pressure
it makes sense to back off some instead of continue to retry repeatedly. So
instead to fix convert schedule_work to schedule_delayed_work and add
backoff logic to reschedule from backlog queue on errors. Its not obvious
though what a good backoff is so use '1'.

To test we observed some flakes whil running NGINX compliance test with
sockmap we attributed these failed test to this bug and subsequent issue.

>From on list discussion. This commit

 bec217197b41("skmsg: Schedule psock work if the cached skb exists on the psock")

was intended to address similar race, but had a couple cases it missed.
Most obvious it only accounted for receiving traffic on the local socket
so if redirecting into another socket we could still get an sk_buff stuck
here. Next it missed the case where copied=0 in the recv() handler and
then we wouldn't kick the scheduler. Also its sub-optimal to require
userspace to kick the internal mechanisms of sockmap to wake it up and
copy data to user. It results in an extra syscall and requires the app
to actual handle the EAGAIN correctly.

Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: William Findlay <will@isovalent.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/bpf/20230523025618.113937-3-john.fastabend@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/skmsg.h |  2 +-
 net/core/skmsg.c      | 21 ++++++++++++++-------
 net/core/sock_map.c   |  3 ++-
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 84f787416a54d..904ff9a32ad61 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -105,7 +105,7 @@ struct sk_psock {
 	struct proto			*sk_proto;
 	struct mutex			work_mutex;
 	struct sk_psock_work_state	work_state;
-	struct work_struct		work;
+	struct delayed_work		work;
 	struct rcu_work			rwork;
 };
 
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 2b6d9519ff29c..6a9b794861f3f 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -481,7 +481,7 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 	}
 out:
 	if (psock->work_state.skb && copied > 0)
-		schedule_work(&psock->work);
+		schedule_delayed_work(&psock->work, 0);
 	return copied;
 }
 EXPORT_SYMBOL_GPL(sk_msg_recvmsg);
@@ -639,7 +639,8 @@ static void sk_psock_skb_state(struct sk_psock *psock,
 
 static void sk_psock_backlog(struct work_struct *work)
 {
-	struct sk_psock *psock = container_of(work, struct sk_psock, work);
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct sk_psock *psock = container_of(dwork, struct sk_psock, work);
 	struct sk_psock_work_state *state = &psock->work_state;
 	struct sk_buff *skb = NULL;
 	bool ingress;
@@ -679,6 +680,12 @@ static void sk_psock_backlog(struct work_struct *work)
 				if (ret == -EAGAIN) {
 					sk_psock_skb_state(psock, state, skb,
 							   len, off);
+
+					/* Delay slightly to prioritize any
+					 * other work that might be here.
+					 */
+					if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
+						schedule_delayed_work(&psock->work, 1);
 					goto end;
 				}
 				/* Hard errors break pipe and stop xmit. */
@@ -733,7 +740,7 @@ struct sk_psock *sk_psock_init(struct sock *sk, int node)
 	INIT_LIST_HEAD(&psock->link);
 	spin_lock_init(&psock->link_lock);
 
-	INIT_WORK(&psock->work, sk_psock_backlog);
+	INIT_DELAYED_WORK(&psock->work, sk_psock_backlog);
 	mutex_init(&psock->work_mutex);
 	INIT_LIST_HEAD(&psock->ingress_msg);
 	spin_lock_init(&psock->ingress_lock);
@@ -822,7 +829,7 @@ static void sk_psock_destroy(struct work_struct *work)
 
 	sk_psock_done_strp(psock);
 
-	cancel_work_sync(&psock->work);
+	cancel_delayed_work_sync(&psock->work);
 	mutex_destroy(&psock->work_mutex);
 
 	psock_progs_drop(&psock->progs);
@@ -937,7 +944,7 @@ static int sk_psock_skb_redirect(struct sk_psock *from, struct sk_buff *skb)
 	}
 
 	skb_queue_tail(&psock_other->ingress_skb, skb);
-	schedule_work(&psock_other->work);
+	schedule_delayed_work(&psock_other->work, 0);
 	spin_unlock_bh(&psock_other->ingress_lock);
 	return 0;
 }
@@ -1017,7 +1024,7 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 			spin_lock_bh(&psock->ingress_lock);
 			if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
 				skb_queue_tail(&psock->ingress_skb, skb);
-				schedule_work(&psock->work);
+				schedule_delayed_work(&psock->work, 0);
 				err = 0;
 			}
 			spin_unlock_bh(&psock->ingress_lock);
@@ -1048,7 +1055,7 @@ static void sk_psock_write_space(struct sock *sk)
 	psock = sk_psock(sk);
 	if (likely(psock)) {
 		if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
-			schedule_work(&psock->work);
+			schedule_delayed_work(&psock->work, 0);
 		write_space = psock->saved_write_space;
 	}
 	rcu_read_unlock();
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index a68a7290a3b2b..d382672018928 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1624,9 +1624,10 @@ void sock_map_close(struct sock *sk, long timeout)
 		rcu_read_unlock();
 		sk_psock_stop(psock);
 		release_sock(sk);
-		cancel_work_sync(&psock->work);
+		cancel_delayed_work_sync(&psock->work);
 		sk_psock_put(sk, psock);
 	}
+
 	/* Make sure we do not recurse. This is a bug.
 	 * Leak the socket instead of crashing on a stack overflow.
 	 */
-- 
2.39.2



