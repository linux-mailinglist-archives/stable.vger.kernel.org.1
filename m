Return-Path: <stable+bounces-257101-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP3LDz0VG2pV/AgAu9opvQ
	(envelope-from <stable+bounces-257101-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:50:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1B160E796
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97E083019145
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC3939478D;
	Sat, 30 May 2026 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ygS+UeMj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A7331A56;
	Sat, 30 May 2026 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780159800; cv=none; b=JYdgPE/bXXKcDGAHrd2Se8gxHC8y7O+JeYQCqF+y7XpbOWa3R7ARwgcNFKLJJ0j0b08EIE9Gmctc0sA6VeKuhM/nsI+KSjVQYZ+lH6F0SWkMAL1kRjkATbDhgmSmga+nVGOJfDNrAg28n8UHXRKnjWNdCTXdA3GLupe0+WqhEn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780159800; c=relaxed/simple;
	bh=uENCymiA/Jb3M6jxcDKD9JTLQyV8EhIdl+Sg6fYvVGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrWuQRY1J6MHe2QUYDEcza128IQYqD+j5HeP8LKoWCpANDyMaPnHtOSGfv1eWzor7sFS51BFQ2NX963goBXGLdJXEIzsSnpm1F0sgNFt4vMhuGr+M91/5QESCVsLk4psR38A0L3yYJdoj5Y+irt5ieuc5aMp5Nl4IPUpn5ADVI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ygS+UeMj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBB61F00893;
	Sat, 30 May 2026 16:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780159799;
	bh=N5YjIgegJqnI1ywj1ru6/hkI2sz/Y4JzU4Pfm3dxM6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ygS+UeMj1F7CKunEcXeZniu1oGMag11h6snOK6EzUKFzJT9CfBUDs2R3w6WPLIJo6
	 R8+9IF7aawhUDiQt9jTcYoZCDEgs6n3n9sJMMnnywyztOjfmCdUjXvnQpAV95uGof7
	 so103BRN2jA0Rt+SU4EOpeKJsalbLCMcM/8/SNU8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Faith <faith@zellic.io>,
	Pumpkin Chang <pumpkin@devco.re>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jay Wang <wanjay@amazon.com>
Subject: [PATCH 6.1 134/969] rxrpc: Fix recvmsg() unconditional requeue
Date: Sat, 30 May 2026 17:54:18 +0200
Message-ID: <20260530160304.269157392@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257101-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AC1B160E796
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 2c28769a51deb6022d7fbd499987e237a01dd63a ]

If rxrpc_recvmsg() fails because MSG_DONTWAIT was specified but the call
at the front of the recvmsg queue already has its mutex locked, it
requeues the call - whether or not the call is already queued.  The call
may be on the queue because MSG_PEEK was also passed and so the call was
not dequeued or because the I/O thread requeued it.

The unconditional requeue may then corrupt the recvmsg queue, leading to
things like UAFs or refcount underruns.

Fix this by only requeuing the call if it isn't already on the queue -
and moving it to the front if it is already queued.  If we don't queue
it, we have to put the ref we obtained by dequeuing it.

Also, MSG_PEEK doesn't dequeue the call so shouldn't call
rxrpc_notify_socket() for the call if we didn't use up all the data on
the queue, so fix that also.

Fixes: 540b1c48c37a ("rxrpc: Fix deadlock between call creation and sendmsg/recvmsg")
Reported-by: Faith <faith@zellic.io>
Reported-by: Pumpkin Chang <pumpkin@devco.re>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Cc: stable@vger.kernel.org
[Adapted to 6.1: use write_lock_bh/write_unlock_bh, trace_rxrpc_call
 directly for see-call tracing, and 6.1 trace enum naming convention.]
Signed-off-by: Jay Wang <wanjay@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/trace/events/rxrpc.h |    4 ++++
 net/rxrpc/recvmsg.c          |   22 ++++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -82,9 +82,13 @@
 	EM(rxrpc_call_put_notimer,		"PnT") \
 	EM(rxrpc_call_put_timer,		"PTM") \
 	EM(rxrpc_call_put_userid,		"Pus") \
+	EM(rxrpc_call_put_recvmsg_peek_nowait,	"PpN") \
 	EM(rxrpc_call_queued,			"QUE") \
 	EM(rxrpc_call_queued_ref,		"QUR") \
 	EM(rxrpc_call_release,			"RLS") \
+	EM(rxrpc_call_see_recvmsg_requeue,	"SrQ") \
+	EM(rxrpc_call_see_recvmsg_requeue_first,"SrF") \
+	EM(rxrpc_call_see_recvmsg_requeue_move,	"SrM") \
 	E_(rxrpc_call_seen,			"SEE")
 
 #define rxrpc_transmit_traces \
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -607,7 +607,8 @@ try_again:
 
 		if (after(call->rx_top, call->rx_hard_ack) &&
 		    call->rxtx_buffer[(call->rx_hard_ack + 1) & RXRPC_RXTX_BUFF_MASK])
-			rxrpc_notify_socket(call);
+			if (!(flags & MSG_PEEK))
+				rxrpc_notify_socket(call);
 		break;
 	default:
 		ret = 0;
@@ -642,11 +643,24 @@ error_unlock_call:
 error_requeue_call:
 	if (!(flags & MSG_PEEK)) {
 		write_lock_bh(&rx->recvmsg_lock);
-		list_add(&call->recvmsg_link, &rx->recvmsg_q);
-		write_unlock_bh(&rx->recvmsg_lock);
+		if (list_empty(&call->recvmsg_link)) {
+			list_add(&call->recvmsg_link, &rx->recvmsg_q);
+			trace_rxrpc_call(call->debug_id,
+					 rxrpc_call_see_recvmsg_requeue,
+					 refcount_read(&call->ref),
+					 __builtin_return_address(0), NULL);
+			write_unlock_bh(&rx->recvmsg_lock);
+		} else if (list_is_first(&call->recvmsg_link, &rx->recvmsg_q)) {
+			write_unlock_bh(&rx->recvmsg_lock);
+			rxrpc_put_call(call, rxrpc_call_see_recvmsg_requeue_first);
+		} else {
+			list_move(&call->recvmsg_link, &rx->recvmsg_q);
+			write_unlock_bh(&rx->recvmsg_lock);
+			rxrpc_put_call(call, rxrpc_call_see_recvmsg_requeue_move);
+		}
 		trace_rxrpc_recvmsg(call, rxrpc_recvmsg_requeue, 0, 0, 0, 0);
 	} else {
-		rxrpc_put_call(call, rxrpc_call_put);
+		rxrpc_put_call(call, rxrpc_call_put_recvmsg_peek_nowait);
 	}
 error_no_call:
 	release_sock(&rx->sk);



