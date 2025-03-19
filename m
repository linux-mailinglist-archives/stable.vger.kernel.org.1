Return-Path: <stable+bounces-125425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC20A690A6
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B247AD823
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF10220681;
	Wed, 19 Mar 2025 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="spBzN7v7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792421DED4A;
	Wed, 19 Mar 2025 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395178; cv=none; b=u9rIRQ5oz8n0SBLtDJy1jhQfihB9PDtvg+MINyyWhUI0SLg24FzhxuzdkmaphDBVfNLiASQi5wtOfS7+LrGZTJVGAS2PG6btWznmPlh/EhgA6L2RESCcx1AsiJg87IOCYN4UZR+LWWeXZZO1JoZmph76IzKC0PXjm6Fwr/BAs3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395178; c=relaxed/simple;
	bh=/qJL2IRTJPlOytCl6ADy2bSK5ZjfRfXUBKCb2hRoXo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3saiWpa4rfGR3Ec8DQOTR+708si2vsfPvUAQsww11ROFIE+pvH9/TfYHdjK/CKswoi8g2pDVRsEKfc2jN4+viFngUOkSHbpyZqkbOtA2SppTd6/6H9CjvrDEhZNRxzxW6ZmW7bm3RpMD3jc5NRHw/hhh8urJZKFSZyRIij/lsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=spBzN7v7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5227FC4CEE4;
	Wed, 19 Mar 2025 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395178;
	bh=/qJL2IRTJPlOytCl6ADy2bSK5ZjfRfXUBKCb2hRoXo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=spBzN7v7PJ9gUlNnKBVlEf4IitRXVCgBBPiRSHS83SPf5JEaGbtyB7HYYFKQmv5H0
	 rSOs9xjbz+DJM3KkFu9zgzv68xljUJEyN8/0fxZBv5ooapQgOzZ9ltk2nFXMISvrKA
	 kRR7FNBgkrP+5lA/5jf6juN6/KggryYlBUbGmnZw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xueming Feng <kuro@kuroa.me>,
	Lorenzo Colitti <lorenzo@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Youngmin Nam <youngmin.nam@samsung.com>
Subject: [PATCH 6.6 007/166] tcp: fix forever orphan socket caused by tcp_abort
Date: Wed, 19 Mar 2025 07:29:38 -0700
Message-ID: <20250319143020.181824586@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143019.983527953@linuxfoundation.org>
References: <20250319143019.983527953@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xueming Feng <kuro@kuroa.me>

commit bac76cf89816bff06c4ec2f3df97dc34e150a1c4 upstream.

We have some problem closing zero-window fin-wait-1 tcp sockets in our
environment. This patch come from the investigation.

Previously tcp_abort only sends out reset and calls tcp_done when the
socket is not SOCK_DEAD, aka orphan. For orphan socket, it will only
purging the write queue, but not close the socket and left it to the
timer.

While purging the write queue, tp->packets_out and sk->sk_write_queue
is cleared along the way. However tcp_retransmit_timer have early
return based on !tp->packets_out and tcp_probe_timer have early
return based on !sk->sk_write_queue.

This caused ICSK_TIME_RETRANS and ICSK_TIME_PROBE0 not being resched
and socket not being killed by the timers, converting a zero-windowed
orphan into a forever orphan.

This patch removes the SOCK_DEAD check in tcp_abort, making it send
reset to peer and close the socket accordingly. Preventing the
timer-less orphan from happening.

According to Lorenzo's email in the v1 thread, the check was there to
prevent force-closing the same socket twice. That situation is handled
by testing for TCP_CLOSE inside lock, and returning -ENOENT if it is
already closed.

The -ENOENT code comes from the associate patch Lorenzo made for
iproute2-ss; link attached below, which also conform to RFC 9293.

At the end of the patch, tcp_write_queue_purge(sk) is removed because it
was already called in tcp_done_with_error().

p.s. This is the same patch with v2. Resent due to mis-labeled "changes
requested" on patchwork.kernel.org.

Link: https://patchwork.ozlabs.org/project/netdev/patch/1450773094-7978-3-git-send-email-lorenzo@google.com/
Fixes: c1e64e298b8c ("net: diag: Support destroying TCP sockets.")
Signed-off-by: Xueming Feng <kuro@kuroa.me>
Tested-by: Lorenzo Colitti <lorenzo@google.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20240826102327.1461482-1-kuro@kuroa.me
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/lkml/Z9OZS%2Fhc+v5og6%2FU@perf/
[youngmin: Resolved minor conflict in net/ipv4/tcp.c]
Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4620,6 +4620,13 @@ int tcp_abort(struct sock *sk, int err)
 		/* Don't race with userspace socket closes such as tcp_close. */
 		lock_sock(sk);
 
+	/* Avoid closing the same socket twice. */
+	if (sk->sk_state == TCP_CLOSE) {
+		if (!has_current_bpf_ctx())
+			release_sock(sk);
+		return -ENOENT;
+	}
+
 	if (sk->sk_state == TCP_LISTEN) {
 		tcp_set_state(sk, TCP_CLOSE);
 		inet_csk_listen_stop(sk);
@@ -4629,15 +4636,12 @@ int tcp_abort(struct sock *sk, int err)
 	local_bh_disable();
 	bh_lock_sock(sk);
 
-	if (!sock_flag(sk, SOCK_DEAD)) {
-		if (tcp_need_reset(sk->sk_state))
-			tcp_send_active_reset(sk, GFP_ATOMIC);
-		tcp_done_with_error(sk, err);
-	}
+	if (tcp_need_reset(sk->sk_state))
+		tcp_send_active_reset(sk, GFP_ATOMIC);
+	tcp_done_with_error(sk, err);
 
 	bh_unlock_sock(sk);
 	local_bh_enable();
-	tcp_write_queue_purge(sk);
 	if (!has_current_bpf_ctx())
 		release_sock(sk);
 	return 0;



