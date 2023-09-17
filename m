Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58A97A3AD7
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbjIQUJi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240505AbjIQUJK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:09:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3BE101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:09:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905BFC433CA;
        Sun, 17 Sep 2023 20:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981344;
        bh=Z4rAYBhErl/55ysdholWsiDYl1cOT33ndSa/SGvIy3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1GdTLfvKfO2n55oYKRcS8mtPUAVUBHdbgSVbJza8OXlx61FKSu0qSieUuwG6y0Nwm
         6gQse0CShyHk4NFjUJs2KTWbbnxIHj6AqOtXpK4ZqspXHnAlPbwWx8y7gsg2H24ply
         XOy4vqRaVzYv7QXtDIP32WWMRtahgizHWsS4vwro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Xu Kuohai <xukuohai@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 107/219] bpf, sockmap: Fix skb refcnt race after locking changes
Date:   Sun, 17 Sep 2023 21:13:54 +0200
Message-ID: <20230917191044.861055247@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit a454d84ee20baf7bd7be90721b9821f73c7d23d9 ]

There is a race where skb's from the sk_psock_backlog can be referenced
after userspace side has already skb_consumed() the sk_buff and its refcnt
dropped to zer0 causing use after free.

The flow is the following:

  while ((skb = skb_peek(&psock->ingress_skb))
    sk_psock_handle_Skb(psock, skb, ..., ingress)
    if (!ingress) ...
    sk_psock_skb_ingress
       sk_psock_skb_ingress_enqueue(skb)
          msg->skb = skb
          sk_psock_queue_msg(psock, msg)
    skb_dequeue(&psock->ingress_skb)

The sk_psock_queue_msg() puts the msg on the ingress_msg queue. This is
what the application reads when recvmsg() is called. An application can
read this anytime after the msg is placed on the queue. The recvmsg hook
will also read msg->skb and then after user space reads the msg will call
consume_skb(skb) on it effectively free'ing it.

But, the race is in above where backlog queue still has a reference to
the skb and calls skb_dequeue(). If the skb_dequeue happens after the
user reads and free's the skb we have a use after free.

The !ingress case does not suffer from this problem because it uses
sendmsg_*(sk, msg) which does not pass the sk_buff further down the
stack.

The following splat was observed with 'test_progs -t sockmap_listen':

  [ 1022.710250][ T2556] general protection fault, ...
  [...]
  [ 1022.712830][ T2556] Workqueue: events sk_psock_backlog
  [ 1022.713262][ T2556] RIP: 0010:skb_dequeue+0x4c/0x80
  [ 1022.713653][ T2556] Code: ...
  [...]
  [ 1022.720699][ T2556] Call Trace:
  [ 1022.720984][ T2556]  <TASK>
  [ 1022.721254][ T2556]  ? die_addr+0x32/0x80^M
  [ 1022.721589][ T2556]  ? exc_general_protection+0x25a/0x4b0
  [ 1022.722026][ T2556]  ? asm_exc_general_protection+0x22/0x30
  [ 1022.722489][ T2556]  ? skb_dequeue+0x4c/0x80
  [ 1022.722854][ T2556]  sk_psock_backlog+0x27a/0x300
  [ 1022.723243][ T2556]  process_one_work+0x2a7/0x5b0
  [ 1022.723633][ T2556]  worker_thread+0x4f/0x3a0
  [ 1022.723998][ T2556]  ? __pfx_worker_thread+0x10/0x10
  [ 1022.724386][ T2556]  kthread+0xfd/0x130
  [ 1022.724709][ T2556]  ? __pfx_kthread+0x10/0x10
  [ 1022.725066][ T2556]  ret_from_fork+0x2d/0x50
  [ 1022.725409][ T2556]  ? __pfx_kthread+0x10/0x10
  [ 1022.725799][ T2556]  ret_from_fork_asm+0x1b/0x30
  [ 1022.726201][ T2556]  </TASK>

To fix we add an skb_get() before passing the skb to be enqueued in the
engress queue. This bumps the skb->users refcnt so that consume_skb()
and kfree_skb will not immediately free the sk_buff. With this we can
be sure the skb is still around when we do the dequeue. Then we just
need to decrement the refcnt or free the skb in the backlog case which
we do by calling kfree_skb() on the ingress case as well as the sendmsg
case.

Before locking change from fixes tag we had the sock locked so we
couldn't race with user and there was no issue here.

Fixes: 799aa7f98d53e ("skmsg: Avoid lock_sock() in sk_psock_backlog()")
Reported-by: Jiri Olsa  <jolsa@kernel.org>
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: Xu Kuohai <xukuohai@huawei.com>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/20230901202137.214666-1-john.fastabend@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skmsg.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 296e45b6c3c0d..a5c1f67dc96ec 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -611,12 +611,18 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
 			       u32 off, u32 len, bool ingress)
 {
+	int err = 0;
+
 	if (!ingress) {
 		if (!sock_writeable(psock->sk))
 			return -EAGAIN;
 		return skb_send_sock(psock->sk, skb, off, len);
 	}
-	return sk_psock_skb_ingress(psock, skb, off, len);
+	skb_get(skb);
+	err = sk_psock_skb_ingress(psock, skb, off, len);
+	if (err < 0)
+		kfree_skb(skb);
+	return err;
 }
 
 static void sk_psock_skb_state(struct sk_psock *psock,
@@ -684,9 +690,7 @@ static void sk_psock_backlog(struct work_struct *work)
 		} while (len);
 
 		skb = skb_dequeue(&psock->ingress_skb);
-		if (!ingress) {
-			kfree_skb(skb);
-		}
+		kfree_skb(skb);
 	}
 end:
 	mutex_unlock(&psock->work_mutex);
-- 
2.40.1



