Return-Path: <stable+bounces-106306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE619FE7C6
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 16:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C78161E18
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F5414F136;
	Mon, 30 Dec 2024 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QaZKxvOy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B582594B6;
	Mon, 30 Dec 2024 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735573518; cv=none; b=VTBfztP1BFwR3aUdyoC5RG40gS1dTggfmjMbftzXa+YKEvjGlMP8jEkBH8CD+WtWOnhgxUmmqKBwZAE9THlwiRm1lAyB9N/nzK/QdlFob8zaPCWC00vcH73izNDgAaM+eXb7LJeCfJpLk0APRpJhr8UL/+hFXcHOgzaRNZdxfak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735573518; c=relaxed/simple;
	bh=iXZ0lnIBufGw1SlLY4Elbks0RlcRpGEvSsDVVeCznuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IF8vlTQdwuURv0Nx9fo2DkAd7OA7LnpPvt4C4LyPkAAlUWHawVq3HbpjtFgO1+Uy16MBajNesID5dhc6HErrKlJbsbTO97cB8BFdtEnE5U8FoXYibpeedbZEdBKn8mtx71qgYqhgOR+l5h3cI5rbbUx4CRbvkEvFJ+Lv/yuyXas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QaZKxvOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE20C4CED0;
	Mon, 30 Dec 2024 15:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735573517;
	bh=iXZ0lnIBufGw1SlLY4Elbks0RlcRpGEvSsDVVeCznuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QaZKxvOyGSPSDhG9a6TFBaQQaUkWE77UBApQezpHS/Sh7m4NsmS2FMcqnjzLI1/7R
	 bhHLOoskOiP/5QYyFBuKKH9l8aWL5cV8z0TXpjWPsd2wa23xrggom0AQ4Ank/z7og6
	 LujQ9O6HAfl7/feFfrZpps7b8gfGrBe5r6SYRuPY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijian Zhang <zijianzhang@bytedance.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 04/60] tcp_bpf: Add sk_rmem_alloc related logic for tcp_bpf ingress redirection
Date: Mon, 30 Dec 2024 16:42:14 +0100
Message-ID: <20241230154207.446628510@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230154207.276570972@linuxfoundation.org>
References: <20241230154207.276570972@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijian Zhang <zijianzhang@bytedance.com>

[ Upstream commit d888b7af7c149c115dd6ac772cc11c375da3e17c ]

When we do sk_psock_verdict_apply->sk_psock_skb_ingress, an sk_msg will
be created out of the skb, and the rmem accounting of the sk_msg will be
handled by the skb.

For skmsgs in __SK_REDIRECT case of tcp_bpf_send_verdict, when redirecting
to the ingress of a socket, although we sk_rmem_schedule and add sk_msg to
the ingress_msg of sk_redir, we do not update sk_rmem_alloc. As a result,
except for the global memory limit, the rmem of sk_redir is nearly
unlimited. Thus, add sk_rmem_alloc related logic to limit the recv buffer.

Since the function sk_msg_recvmsg and __sk_psock_purge_ingress_msg are
used in these two paths. We use "msg->skb" to test whether the sk_msg is
skb backed up. If it's not, we shall do the memory accounting explicitly.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20241210012039.1669389-3-zijianzhang@bytedance.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/skmsg.h | 11 ++++++++---
 net/core/skmsg.c      |  6 +++++-
 net/ipv4/tcp_bpf.c    |  4 +++-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 062fe440f5d0..6ccfd9236387 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -308,17 +308,22 @@ static inline void sock_drop(struct sock *sk, struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
-static inline void sk_psock_queue_msg(struct sk_psock *psock,
+static inline bool sk_psock_queue_msg(struct sk_psock *psock,
 				      struct sk_msg *msg)
 {
+	bool ret;
+
 	spin_lock_bh(&psock->ingress_lock);
-	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
+	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
 		list_add_tail(&msg->list, &psock->ingress_msg);
-	else {
+		ret = true;
+	} else {
 		sk_msg_free(psock->sk, msg);
 		kfree(msg);
+		ret = false;
 	}
 	spin_unlock_bh(&psock->ingress_lock);
+	return ret;
 }
 
 static inline struct sk_msg *sk_psock_dequeue_msg(struct sk_psock *psock)
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 584516387fda..65764952bc68 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -444,8 +444,10 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 			if (likely(!peek)) {
 				sge->offset += copy;
 				sge->length -= copy;
-				if (!msg_rx->skb)
+				if (!msg_rx->skb) {
 					sk_mem_uncharge(sk, copy);
+					atomic_sub(copy, &sk->sk_rmem_alloc);
+				}
 				msg_rx->sg.size -= copy;
 
 				if (!sge->length) {
@@ -771,6 +773,8 @@ static void __sk_psock_purge_ingress_msg(struct sk_psock *psock)
 
 	list_for_each_entry_safe(msg, tmp, &psock->ingress_msg, list) {
 		list_del(&msg->list);
+		if (!msg->skb)
+			atomic_sub(msg->sg.size, &psock->sk->sk_rmem_alloc);
 		sk_msg_free(psock->sk, msg);
 		kfree(msg);
 	}
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index cd999c55da99..a8db010e9e61 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -56,6 +56,7 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 		}
 
 		sk_mem_charge(sk, size);
+		atomic_add(size, &sk->sk_rmem_alloc);
 		sk_msg_xfer(tmp, msg, i, size);
 		copied += size;
 		if (sge->length)
@@ -74,7 +75,8 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 
 	if (!ret) {
 		msg->sg.start = i;
-		sk_psock_queue_msg(psock, tmp);
+		if (!sk_psock_queue_msg(psock, tmp))
+			atomic_sub(copied, &sk->sk_rmem_alloc);
 		sk_psock_data_ready(sk, psock);
 	} else {
 		sk_msg_free(sk, tmp);
-- 
2.39.5




