Return-Path: <stable+bounces-161835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4908DB03EE7
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 14:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66AA21898D2C
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 12:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787C624888C;
	Mon, 14 Jul 2025 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IdT6A/8G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2111991B6
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496840; cv=none; b=lnUaK3mhRqI2kSAms2GCKQW3YfH407UhzO7skZmXEjZxjoqJYchuUypztYSZVTXRBH6rxXhbAoUunl65h1129c9lqMBuiU1M1nJ/pm+H5eMV435KO0Rd5CJD9BD6QdDJTPxyET/mZ/K95nXrMv2nszkbw+qqLh5eYRnZ06O3wH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496840; c=relaxed/simple;
	bh=9t4fWiplyObsN2ZgPHLV+Ei/k2Fh5vp9t4BNXEAx2DI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mmXrzmEd+z8/mnNsIIQdfZ6NVgigyHiPuqx5XY2DSslv4TyocgPFDz7TBXTmVuXB7za1j8jJbBYWudXnN2mU6nhCjYycnuH/SLpYWtE3zhVUQ1MYNOXiRmjhxXcSd+aX14ZwHcgZjuJV+JAGz1XOY+kAGahy2+l9I7fe7G8qfHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IdT6A/8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D87EC4CEED;
	Mon, 14 Jul 2025 12:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752496839;
	bh=9t4fWiplyObsN2ZgPHLV+Ei/k2Fh5vp9t4BNXEAx2DI=;
	h=Subject:To:Cc:From:Date:From;
	b=IdT6A/8GHPuEHoVLwm82zef8Zeh1f7EHtBtriaeB8HqUXIX7YIsbzTzv3l6ia5tLv
	 ZXkBgcXy7pXxTh3s9vKitHCb0s+kazaKGfXQNBTGNt2k6YDDAIP09pBMg98xCtKlkY
	 GqnmkYFPYMw/gfrtM5nbByZc5ANOg0Jyytev4cxs=
Subject: FAILED: patch "[PATCH] bpf, sockmap: Fix panic when calling skb_linearize" failed to apply to 5.15-stable tree
To: jiayuan.chen@linux.dev,ast@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Jul 2025 14:40:37 +0200
Message-ID: <2025071437-unloaded-unstitch-e838@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5ca2e29f6834c64c0e5a9ccf1278c21fb49b827e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025071437-unloaded-unstitch-e838@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5ca2e29f6834c64c0e5a9ccf1278c21fb49b827e Mon Sep 17 00:00:00 2001
From: Jiayuan Chen <jiayuan.chen@linux.dev>
Date: Mon, 7 Apr 2025 22:21:22 +0800
Subject: [PATCH] bpf, sockmap: Fix panic when calling skb_linearize
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The panic can be reproduced by executing the command:
./bench sockmap -c 2 -p 1 -a --rx-verdict-ingress --rx-strp 100000

Then a kernel panic was captured:
'''
[  657.460555] kernel BUG at net/core/skbuff.c:2178!
[  657.462680] Tainted: [W]=WARN
[  657.463287] Workqueue: events sk_psock_backlog
...
[  657.469610]  <TASK>
[  657.469738]  ? die+0x36/0x90
[  657.469916]  ? do_trap+0x1d0/0x270
[  657.470118]  ? pskb_expand_head+0x612/0xf40
[  657.470376]  ? pskb_expand_head+0x612/0xf40
[  657.470620]  ? do_error_trap+0xa3/0x170
[  657.470846]  ? pskb_expand_head+0x612/0xf40
[  657.471092]  ? handle_invalid_op+0x2c/0x40
[  657.471335]  ? pskb_expand_head+0x612/0xf40
[  657.471579]  ? exc_invalid_op+0x2d/0x40
[  657.471805]  ? asm_exc_invalid_op+0x1a/0x20
[  657.472052]  ? pskb_expand_head+0xd1/0xf40
[  657.472292]  ? pskb_expand_head+0x612/0xf40
[  657.472540]  ? lock_acquire+0x18f/0x4e0
[  657.472766]  ? find_held_lock+0x2d/0x110
[  657.472999]  ? __pfx_pskb_expand_head+0x10/0x10
[  657.473263]  ? __kmalloc_cache_noprof+0x5b/0x470
[  657.473537]  ? __pfx___lock_release.isra.0+0x10/0x10
[  657.473826]  __pskb_pull_tail+0xfd/0x1d20
[  657.474062]  ? __kasan_slab_alloc+0x4e/0x90
[  657.474707]  sk_psock_skb_ingress_enqueue+0x3bf/0x510
[  657.475392]  ? __kasan_kmalloc+0xaa/0xb0
[  657.476010]  sk_psock_backlog+0x5cf/0xd70
[  657.476637]  process_one_work+0x858/0x1a20
'''

The panic originates from the assertion BUG_ON(skb_shared(skb)) in
skb_linearize(). A previous commit(see Fixes tag) introduced skb_get()
to avoid race conditions between skb operations in the backlog and skb
release in the recvmsg path. However, this caused the panic to always
occur when skb_linearize is executed.

The "--rx-strp 100000" parameter forces the RX path to use the strparser
module which aggregates data until it reaches 100KB before calling sockmap
logic. The 100KB payload exceeds MAX_MSG_FRAGS, triggering skb_linearize.

To fix this issue, just move skb_get into sk_psock_skb_ingress_enqueue.

'''
sk_psock_backlog:
    sk_psock_handle_skb
       skb_get(skb) <== we move it into 'sk_psock_skb_ingress_enqueue'
       sk_psock_skb_ingress____________
                                       ↓
                                       |
                                       | → sk_psock_skb_ingress_self
                                       |      sk_psock_skb_ingress_enqueue
sk_psock_verdict_apply_________________↑          skb_linearize
'''

Note that for verdict_apply path, the skb_get operation is unnecessary so
we add 'take_ref' param to control it's behavior.

Fixes: a454d84ee20b ("bpf, sockmap: Fix skb refcnt race after locking changes")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://lore.kernel.org/r/20250407142234.47591-4-jiayuan.chen@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 9533b3e40ad7..276934673066 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -530,16 +530,22 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 					u32 off, u32 len,
 					struct sk_psock *psock,
 					struct sock *sk,
-					struct sk_msg *msg)
+					struct sk_msg *msg,
+					bool take_ref)
 {
 	int num_sge, copied;
 
+	/* skb_to_sgvec will fail when the total number of fragments in
+	 * frag_list and frags exceeds MAX_MSG_FRAGS. For example, the
+	 * caller may aggregate multiple skbs.
+	 */
 	num_sge = skb_to_sgvec(skb, msg->sg.data, off, len);
 	if (num_sge < 0) {
 		/* skb linearize may fail with ENOMEM, but lets simply try again
 		 * later if this happens. Under memory pressure we don't want to
 		 * drop the skb. We need to linearize the skb so that the mapping
 		 * in skb_to_sgvec can not error.
+		 * Note that skb_linearize requires the skb not to be shared.
 		 */
 		if (skb_linearize(skb))
 			return -EAGAIN;
@@ -556,7 +562,7 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 	msg->sg.start = 0;
 	msg->sg.size = copied;
 	msg->sg.end = num_sge;
-	msg->skb = skb;
+	msg->skb = take_ref ? skb_get(skb) : skb;
 
 	sk_psock_queue_msg(psock, msg);
 	sk_psock_data_ready(sk, psock);
@@ -564,7 +570,7 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 }
 
 static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-				     u32 off, u32 len);
+				     u32 off, u32 len, bool take_ref);
 
 static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 				u32 off, u32 len)
@@ -578,7 +584,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	 * correctly.
 	 */
 	if (unlikely(skb->sk == sk))
-		return sk_psock_skb_ingress_self(psock, skb, off, len);
+		return sk_psock_skb_ingress_self(psock, skb, off, len, true);
 	msg = sk_psock_create_ingress_msg(sk, skb);
 	if (!msg)
 		return -EAGAIN;
@@ -590,7 +596,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	 * into user buffers.
 	 */
 	skb_set_owner_r(skb, sk);
-	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg);
+	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, true);
 	if (err < 0)
 		kfree(msg);
 	return err;
@@ -601,7 +607,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
  * because the skb is already accounted for here.
  */
 static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-				     u32 off, u32 len)
+				     u32 off, u32 len, bool take_ref)
 {
 	struct sk_msg *msg = alloc_sk_msg(GFP_ATOMIC);
 	struct sock *sk = psock->sk;
@@ -610,7 +616,7 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 	if (unlikely(!msg))
 		return -EAGAIN;
 	skb_set_owner_r(skb, sk);
-	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg);
+	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
 	if (err < 0)
 		kfree(msg);
 	return err;
@@ -619,18 +625,13 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
 			       u32 off, u32 len, bool ingress)
 {
-	int err = 0;
-
 	if (!ingress) {
 		if (!sock_writeable(psock->sk))
 			return -EAGAIN;
 		return skb_send_sock(psock->sk, skb, off, len);
 	}
-	skb_get(skb);
-	err = sk_psock_skb_ingress(psock, skb, off, len);
-	if (err < 0)
-		kfree_skb(skb);
-	return err;
+
+	return sk_psock_skb_ingress(psock, skb, off, len);
 }
 
 static void sk_psock_skb_state(struct sk_psock *psock,
@@ -1019,7 +1020,7 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 				off = stm->offset;
 				len = stm->full_len;
 			}
-			err = sk_psock_skb_ingress_self(psock, skb, off, len);
+			err = sk_psock_skb_ingress_self(psock, skb, off, len, false);
 		}
 		if (err < 0) {
 			spin_lock_bh(&psock->ingress_lock);


