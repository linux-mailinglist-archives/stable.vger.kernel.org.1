Return-Path: <stable+bounces-240392-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKMFLK5K6WmqXQIAu9opvQ
	(envelope-from <stable+bounces-240392-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 00:24:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1205244B43A
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 00:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C66423055433
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 22:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7572E3446C5;
	Wed, 22 Apr 2026 22:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="dgUUBYsF"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9C631A56D;
	Wed, 22 Apr 2026 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776896676; cv=none; b=rZJrGiBgMDpj3lM1EHLeZsP6cEuCvUQ4GHq91lK3p9Ettbp8+dIio5EERHtDETN9eEhEftgAi0Um7TcM6yxO+qKh/cpDYpDtMab+Y1yTZf0c7+PGcJ0yiwJJY6piJ73Xyep4p3G/VlWxWSVdhzN6nWxUYE1JyrihPisucMkj++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776896676; c=relaxed/simple;
	bh=VA5GtXNyZG3VuRyaHoruMod9IIzrnfE74vmaLTT7/fw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SCQzMLebEs1OmuZWTRO4IGOkIYbXyDU3ELkVB0tscopx7N55Vl9e7boh6rV/CK6buZ+heJoOHKAnvzTXsjzzWgztJfEyHWcnebub6wi6YwOo94LR5M1uWJz0b3bjBoMSbVgnhWqjAtRGxQQ10tUstRcrOV/qUp6xMCC5eXJK1QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=dgUUBYsF; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1776896675; x=1808432675;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1Ktg8OQvEHO2xPcM6DTsWex6b3a+FfDhQOvj8Yyydcs=;
  b=dgUUBYsFYlkABZxj9689Zr4rXORDQPKt+IPb2dzjtjey0Uf5qLGlF0FB
   kAvAGhK1807EdXdcoVryAeKrVeVqCS5JLzP8HUIfq8FtRTu370bR55P8K
   xkpoA2GN5zYLiOcNE1Pn8YUeugmEp1HmB4j8lU3KxPs9XVpwis6++cQus
   54e/TruGnVcwFcVCnCKWnfQgOu0l+3A0GP2i1+cBUffEow2JD/53e/h8s
   0T3BZYhTrQunHwNPFGFD+RYpTGxhuI77VB0ZqXZgPJGZZHUPZ4ULuvQuB
   DhkbdjCHwBkeTmMeTFPTPEOlOuT5ZqhbkJ0/XeQ2N6/HSLNf0DCHsL/SK
   g==;
X-CSE-ConnectionGUID: GNou4UJdTh6YEpho1k9g/Q==
X-CSE-MsgGUID: uEAWCKSvTTu6ypDqEUT1uQ==
X-IronPort-AV: E=Sophos;i="6.23,193,1770595200"; 
   d="scan'208";a="17783595"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 22:24:34 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:28925]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.165:2525] with esmtp (Farcaster)
 id 452336f5-136b-49f8-95aa-e3e6b09f2d56; Wed, 22 Apr 2026 22:24:34 +0000 (UTC)
X-Farcaster-Flow-ID: 452336f5-136b-49f8-95aa-e3e6b09f2d56
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 22 Apr 2026 22:24:33 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 22 Apr 2026 22:24:33 +0000
From: Jay Wang <wanjay@amazon.com>
To: <stable@vger.kernel.org>
CC: <dhowells@redhat.com>, <marc.dionne@auristor.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-afs@lists.infradead.org>,
	<jay.wang.upstream@gmail.com>, Faith <faith@zellic.io>, Pumpkin Chang
	<pumpkin@devco.re>
Subject: [PATCH 5.10.y] rxrpc: Fix recvmsg() unconditional requeue
Date: Wed, 22 Apr 2026 22:24:32 +0000
Message-ID: <20260422222432.7236-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,davemloft.net,google.com,kernel.org,vger.kernel.org,lists.infradead.org,gmail.com,zellic.io,devco.re];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240392-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wanjay@amazon.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zellic.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1205244B43A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
[Adapted to 5.10: use write_lock_bh/write_unlock_bh, trace_rxrpc_call
 directly for see-call tracing, 5.10 trace enum naming convention, and
 added entries to both plain enum and EM() macro list.]
Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 include/trace/events/rxrpc.h | 8 ++++++++
 net/rxrpc/recvmsg.c          | 20 ++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -93,9 +93,13 @@ enum rxrpc_call_trace {
 	rxrpc_call_put_notimer,
 	rxrpc_call_put_timer,
 	rxrpc_call_put_userid,
+	rxrpc_call_put_recvmsg_peek_nowait,
 	rxrpc_call_queued,
 	rxrpc_call_queued_ref,
 	rxrpc_call_release,
+	rxrpc_call_see_recvmsg_requeue,
+	rxrpc_call_see_recvmsg_requeue_first,
+	rxrpc_call_see_recvmsg_requeue_move,
 	rxrpc_call_seen,
 };
 
@@ -291,9 +295,13 @@ enum rxrpc_tx_point {
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
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -607,7 +607,8 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 		if (after(call->rx_top, call->rx_hard_ack) &&
 		    call->rxtx_buffer[(call->rx_hard_ack + 1) & RXRPC_RXTX_BUFF_MASK])
-			rxrpc_notify_socket(call);
+			if (!(flags & MSG_PEEK))
+				rxrpc_notify_socket(call);
 		break;
 	default:
 		ret = 0;
@@ -642,11 +643,24 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
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
-- 
2.43.0


