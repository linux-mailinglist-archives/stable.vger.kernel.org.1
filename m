Return-Path: <stable+bounces-163494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 181B8B0BB11
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 04:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230B2169F6D
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 02:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329B01E7C18;
	Mon, 21 Jul 2025 02:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLSIKUwx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB41D540
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 02:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753066667; cv=none; b=eNF81IJZVVFN1cSC38scecuDh+loHq6Ns5PsagqRuoVENAM68uWhBRuZNM4riEye8/nJiqL/bizBTL4S+qqVqqEN8bG37+TjsStdRlhUXBWHvBXPjUU7Yhj231gZz9XIPEbG9CIxQdoYuFVrw85ZVLMgsv5hz7W1yq6CW85qRHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753066667; c=relaxed/simple;
	bh=w3/BeVOgH55YrKhsHO+yvspp0Hc3bxj8uVYRQlmCPeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fp3etVI3dxXyWKM+4ElZ5/IJckCN38cb3p0yJ0W8MYl0U1RPAOW+R4QjWUDWb/kKHUlSQ9nyCup+RSaz5cnKZzgGDfZZSwhgHZNjljGA9YiNsMJokQ75IN29KJedSiCYqe9L+ooki9bbzs7vU5bvUPxR7oN3Q+nAOtUIoO9Jjp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLSIKUwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C16C4CEE7;
	Mon, 21 Jul 2025 02:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753066666;
	bh=w3/BeVOgH55YrKhsHO+yvspp0Hc3bxj8uVYRQlmCPeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fLSIKUwxo9KsvA7+y8HiMawOMQjU/uNbMrdM6z2NksBi/RYke7VVKEB6OJGZXJ0e/
	 B7HdGAURwmlpsNcXkDG5778QROaGTUT/C0yZUGA6EGGu8E/jwp2z82Dv8cmI5Bwxdi
	 s7RfWxTGlnCWTIHC40oqobZSbAuGBE4MmtxsD6pjfcLIZ9M6niEiNaC8WRXN7PDTQw
	 Dnsnss04gNY+iUJvoG/NTPDGrcdjLFBImsrWiee9D4VkckRUO/wNc1FlpG4GJETZyY
	 PvQL5f20C9yOyQ5tB1y1YvnGmF41OxQU/ocPjjagmWQAUi+vX8L9EnxrWN3QhSe4VE
	 y3eoGt7XdIrwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] bpf, sockmap: Fix panic when calling skb_linearize
Date: Sun, 20 Jul 2025 22:57:32 -0400
Message-Id: <20250721025732.786030-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025071437-unloaded-unstitch-e838@gregkh>
References: <2025071437-unloaded-unstitch-e838@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <jiayuan.chen@linux.dev>

[ Upstream commit 5ca2e29f6834c64c0e5a9ccf1278c21fb49b827e ]

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
[ adapted skb_linearize() fix to 5.15's sk_psock_skb_ingress_enqueue implementation without the s_data parameter ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skmsg.c | 50 ++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index ee38b50eacae5..1d7cf920bf4e1 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -525,26 +525,35 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 					u32 off, u32 len,
 					struct sk_psock *psock,
 					struct sock *sk,
-					struct sk_msg *msg)
+					struct sk_msg *msg,
+					bool take_ref)
 {
 	int num_sge, copied;
 
-	/* skb linearize may fail with ENOMEM, but lets simply try again
-	 * later if this happens. Under memory pressure we don't want to
-	 * drop the skb. We need to linearize the skb so that the mapping
-	 * in skb_to_sgvec can not error.
+	/* skb_to_sgvec will fail when the total number of fragments in
+	 * frag_list and frags exceeds MAX_MSG_FRAGS. For example, the
+	 * caller may aggregate multiple skbs.
 	 */
-	if (skb_linearize(skb))
-		return -EAGAIN;
 	num_sge = skb_to_sgvec(skb, msg->sg.data, off, len);
-	if (unlikely(num_sge < 0))
-		return num_sge;
+	if (num_sge < 0) {
+		/* skb linearize may fail with ENOMEM, but lets simply try again
+		 * later if this happens. Under memory pressure we don't want to
+		 * drop the skb. We need to linearize the skb so that the mapping
+		 * in skb_to_sgvec can not error.
+		 * Note that skb_linearize requires the skb not to be shared.
+		 */
+		if (skb_linearize(skb))
+			return -EAGAIN;
+		num_sge = skb_to_sgvec(skb, msg->sg.data, off, len);
+		if (unlikely(num_sge < 0))
+			return num_sge;
+	}
 
 	copied = len;
 	msg->sg.start = 0;
 	msg->sg.size = copied;
 	msg->sg.end = num_sge;
-	msg->skb = skb;
+	msg->skb = take_ref ? skb_get(skb) : skb;
 
 	sk_psock_queue_msg(psock, msg);
 	sk_psock_data_ready(sk, psock);
@@ -552,7 +561,7 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 }
 
 static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-				     u32 off, u32 len);
+				     u32 off, u32 len, bool take_ref);
 
 static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 				u32 off, u32 len)
@@ -566,7 +575,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	 * correctly.
 	 */
 	if (unlikely(skb->sk == sk))
-		return sk_psock_skb_ingress_self(psock, skb, off, len);
+		return sk_psock_skb_ingress_self(psock, skb, off, len, true);
 	msg = sk_psock_create_ingress_msg(sk, skb);
 	if (!msg)
 		return -EAGAIN;
@@ -578,7 +587,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	 * into user buffers.
 	 */
 	skb_set_owner_r(skb, sk);
-	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg);
+	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, true);
 	if (err < 0)
 		kfree(msg);
 	return err;
@@ -589,7 +598,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
  * because the skb is already accounted for here.
  */
 static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-				     u32 off, u32 len)
+				     u32 off, u32 len, bool take_ref)
 {
 	struct sk_msg *msg = kzalloc(sizeof(*msg), __GFP_NOWARN | GFP_ATOMIC);
 	struct sock *sk = psock->sk;
@@ -599,7 +608,7 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 		return -EAGAIN;
 	sk_msg_init(msg);
 	skb_set_owner_r(skb, sk);
-	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg);
+	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
 	if (err < 0)
 		kfree(msg);
 	return err;
@@ -608,18 +617,13 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
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
@@ -1016,7 +1020,7 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 				off = stm->offset;
 				len = stm->full_len;
 			}
-			err = sk_psock_skb_ingress_self(psock, skb, off, len);
+			err = sk_psock_skb_ingress_self(psock, skb, off, len, false);
 		}
 		if (err < 0) {
 			spin_lock_bh(&psock->ingress_lock);
-- 
2.39.5


