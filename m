Return-Path: <stable+bounces-136063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A08EA9923D
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF4C92510E
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8ED28150B;
	Wed, 23 Apr 2025 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oVv138Hn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C87C1EEA3E;
	Wed, 23 Apr 2025 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421558; cv=none; b=ipXGXyQe1TDjtVThTQrDMQeK7cTa4p1oXyaOeBunL9DVvyb2M+TZGv0OaccDWg4qqpeSmMtQK8ksyS4kX8WChQBskwcNgeozOKveZGyxnzDHIhQPXMV6+riLcqmkFGGF81Lm1lNU2KTaNpVdVcmoA+Zk8Q98/F41LBC3g8hAqoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421558; c=relaxed/simple;
	bh=MwJuP400XVhD0kvQkd4RZeAQdb3jjXJi5ax7qcSvCt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufjbEr63WM2dCcsrvIk+ashRTxtygrXhkozU3eN9VotoYY54N/Aw0NkjyQNdTKE+QEpm3dxVgQGyGbivKRfKDQBXX/2DnV/nVfnGwmlYevM1yTzbsw7ZQjt0B7PdSr954j1QYjdviLVSTe9ojkHObQ+a9o4IBcmNCToedz4VZfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oVv138Hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9266AC4CEE2;
	Wed, 23 Apr 2025 15:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421557;
	bh=MwJuP400XVhD0kvQkd4RZeAQdb3jjXJi5ax7qcSvCt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oVv138HnfLuHA50DYHWwW7rm1QLO6O6JzMXXYPBnga+44VtAgnVX/0beo5amv6g4T
	 nratsB1qu+PC63/bM6RfMk7Vy5nnk4v3BDZlS0ubrpzItZaoXnTwOteH5qgBOCMsPF
	 R0lUgjbfHGDTDFIrG4xP9/rPeXqIPL8RJEKnN2fI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xin Long <lucien.xin@gmail.com>,
	=?UTF-8?q?Ricardo=20Ca=C3=B1uelo=20Navarro?= <rcn@igalia.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1 134/291] sctp: detect and prevent references to a freed transport in sendmsg
Date: Wed, 23 Apr 2025 16:42:03 +0200
Message-ID: <20250423142629.871754095@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142624.409452181@linuxfoundation.org>
References: <20250423142624.409452181@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo Cañuelo Navarro <rcn@igalia.com>

commit f1a69a940de58b16e8249dff26f74c8cc59b32be upstream.

sctp_sendmsg() re-uses associations and transports when possible by
doing a lookup based on the socket endpoint and the message destination
address, and then sctp_sendmsg_to_asoc() sets the selected transport in
all the message chunks to be sent.

There's a possible race condition if another thread triggers the removal
of that selected transport, for instance, by explicitly unbinding an
address with setsockopt(SCTP_SOCKOPT_BINDX_REM), after the chunks have
been set up and before the message is sent. This can happen if the send
buffer is full, during the period when the sender thread temporarily
releases the socket lock in sctp_wait_for_sndbuf().

This causes the access to the transport data in
sctp_outq_select_transport(), when the association outqueue is flushed,
to result in a use-after-free read.

This change avoids this scenario by having sctp_transport_free() signal
the freeing of the transport, tagging it as "dead". In order to do this,
the patch restores the "dead" bit in struct sctp_transport, which was
removed in
commit 47faa1e4c50e ("sctp: remove the dead field of sctp_transport").

Then, in the scenario where the sender thread has released the socket
lock in sctp_wait_for_sndbuf(), the bit is checked again after
re-acquiring the socket lock to detect the deletion. This is done while
holding a reference to the transport to prevent it from being freed in
the process.

If the transport was deleted while the socket lock was relinquished,
sctp_sendmsg_to_asoc() will return -EAGAIN to let userspace retry the
send.

The bug was found by a private syzbot instance (see the error report [1]
and the C reproducer that triggers it [2]).

Link: https://people.igalia.com/rcn/kernel_logs/20250402__KASAN_slab-use-after-free_Read_in_sctp_outq_select_transport.txt [1]
Link: https://people.igalia.com/rcn/kernel_logs/20250402__KASAN_slab-use-after-free_Read_in_sctp_outq_select_transport__repro.c [2]
Cc: stable@vger.kernel.org
Fixes: df132eff4638 ("sctp: clear the transport of some out_chunk_list chunks in sctp_assoc_rm_peer")
Suggested-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>
Acked-by: Xin Long <lucien.xin@gmail.com>
Link: https://patch.msgid.link/20250404-kasan_slab-use-after-free_read_in_sctp_outq_select_transport__20250404-v1-1-5ce4a0b78ef2@igalia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/sctp/structs.h |    3 ++-
 net/sctp/socket.c          |   22 ++++++++++++++--------
 net/sctp/transport.c       |    2 ++
 3 files changed, 18 insertions(+), 9 deletions(-)

--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -777,6 +777,7 @@ struct sctp_transport {
 
 	/* Reference counting. */
 	refcount_t refcnt;
+	__u32	dead:1,
 		/* RTO-Pending : A flag used to track if one of the DATA
 		 *		chunks sent to this address is currently being
 		 *		used to compute a RTT. If this flag is 0,
@@ -786,7 +787,7 @@ struct sctp_transport {
 		 *		calculation completes (i.e. the DATA chunk
 		 *		is SACK'd) clear this flag.
 		 */
-	__u32	rto_pending:1,
+		rto_pending:1,
 
 		/*
 		 * hb_sent : a flag that signals that we have a pending
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -70,8 +70,9 @@
 /* Forward declarations for internal helper functions. */
 static bool sctp_writeable(const struct sock *sk);
 static void sctp_wfree(struct sk_buff *skb);
-static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
-				size_t msg_len);
+static int sctp_wait_for_sndbuf(struct sctp_association *asoc,
+				struct sctp_transport *transport,
+				long *timeo_p, size_t msg_len);
 static int sctp_wait_for_packet(struct sock *sk, int *err, long *timeo_p);
 static int sctp_wait_for_connect(struct sctp_association *, long *timeo_p);
 static int sctp_wait_for_accept(struct sock *sk, long timeo);
@@ -1826,7 +1827,7 @@ static int sctp_sendmsg_to_asoc(struct s
 
 	if (sctp_wspace(asoc) <= 0 || !sk_wmem_schedule(sk, msg_len)) {
 		timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
-		err = sctp_wait_for_sndbuf(asoc, &timeo, msg_len);
+		err = sctp_wait_for_sndbuf(asoc, transport, &timeo, msg_len);
 		if (err)
 			goto err;
 		if (unlikely(sinfo->sinfo_stream >= asoc->stream.outcnt)) {
@@ -9203,8 +9204,9 @@ void sctp_sock_rfree(struct sk_buff *skb
 
 
 /* Helper function to wait for space in the sndbuf.  */
-static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
-				size_t msg_len)
+static int sctp_wait_for_sndbuf(struct sctp_association *asoc,
+				struct sctp_transport *transport,
+				long *timeo_p, size_t msg_len)
 {
 	struct sock *sk = asoc->base.sk;
 	long current_timeo = *timeo_p;
@@ -9214,7 +9216,9 @@ static int sctp_wait_for_sndbuf(struct s
 	pr_debug("%s: asoc:%p, timeo:%ld, msg_len:%zu\n", __func__, asoc,
 		 *timeo_p, msg_len);
 
-	/* Increment the association's refcnt.  */
+	/* Increment the transport and association's refcnt. */
+	if (transport)
+		sctp_transport_hold(transport);
 	sctp_association_hold(asoc);
 
 	/* Wait on the association specific sndbuf space. */
@@ -9223,7 +9227,7 @@ static int sctp_wait_for_sndbuf(struct s
 					  TASK_INTERRUPTIBLE);
 		if (asoc->base.dead)
 			goto do_dead;
-		if (!*timeo_p)
+		if ((!*timeo_p) || (transport && transport->dead))
 			goto do_nonblock;
 		if (sk->sk_err || asoc->state >= SCTP_STATE_SHUTDOWN_PENDING)
 			goto do_error;
@@ -9248,7 +9252,9 @@ static int sctp_wait_for_sndbuf(struct s
 out:
 	finish_wait(&asoc->wait, &wait);
 
-	/* Release the association's refcnt.  */
+	/* Release the transport and association's refcnt. */
+	if (transport)
+		sctp_transport_put(transport);
 	sctp_association_put(asoc);
 
 	return err;
--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -117,6 +117,8 @@ fail:
  */
 void sctp_transport_free(struct sctp_transport *transport)
 {
+	transport->dead = 1;
+
 	/* Try to delete the heartbeat timer.  */
 	if (del_timer(&transport->hb_timer))
 		sctp_transport_put(transport);



