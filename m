Return-Path: <stable+bounces-163223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5439CB0873E
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 09:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D023AD926
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 07:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1E625FA00;
	Thu, 17 Jul 2025 07:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="McJYO50S"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3C7256C8D
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738264; cv=none; b=VXbWRXF7JYczwneecTGiW2xrpMsV36YLyyf+HCQUl7D7U/7Axd9I93a2IPQ3XOb4Y6KaTgiazjO5M56ZyxeQUGgPgVreQqe4nn4UMky4eFLUXNxKYaiu9GJ6ilcpd24vtSzWfIB43Uc8/sUbXtV6iJs9AxArf0mBRGMQGgMVicE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738264; c=relaxed/simple;
	bh=cZ8irNic4FTGtFo1LMyLVUp2/0Pa4N8ydx4JnEJfWi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXOcbYL+cF3aG3yc6+mf6Cyyk18VqFHrxaBt3YhCLOQEp3XPn7p/FA1XycfulpayOS68KsugCgR3PVlKSf4AsCABpVyFI7nKz2X1Ny/cJJiZYRMxVwDzlL9hGSuBuT0JX9AMr9c0cmGj+J64x6QdVCoWvzUfEKoXdTFopD2Fag4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=McJYO50S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752738262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=acf6yBSPWIsxVjKSsMYGcadGErSbHyVH0MQzJet8aFE=;
	b=McJYO50SHE8mrEX3YGYDQhcklmUfaOFh/QMQTICSWzwhJocc//eRCXYZ4H14xu6hgwUrcZ
	AV+kS3kTSctguUjuIN/X9g5dhS/jNQteTumsl94lDydHUwY9mbfBNpPfgnT3SE7Gto2SCs
	XC1YwDHaq47LdWyBQoKsPrILPC5PjyA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-qHDCeVTLNnqlFSV8g4i84Q-1; Thu,
 17 Jul 2025 03:44:19 -0400
X-MC-Unique: qHDCeVTLNnqlFSV8g4i84Q-1
X-Mimecast-MFC-AGG-ID: qHDCeVTLNnqlFSV8g4i84Q_1752738257
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 316271800447;
	Thu, 17 Jul 2025 07:44:16 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CBA74180045B;
	Thu, 17 Jul 2025 07:44:11 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Junvyyang, Tencent Zhuque Lab" <zhuque@tencent.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	LePremierHomme <kwqcheii@proton.me>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/5] rxrpc: Fix recv-recv race of completed call
Date: Thu, 17 Jul 2025 08:43:42 +0100
Message-ID: <20250717074350.3767366-3-dhowells@redhat.com>
In-Reply-To: <20250717074350.3767366-1-dhowells@redhat.com>
References: <20250717074350.3767366-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

If a call receives an event (such as incoming data), the call gets placed
on the socket's queue and a thread in recvmsg can be awakened to go and
process it.  Once the thread has picked up the call off of the queue,
further events will cause it to be requeued, and once the socket lock is
dropped (recvmsg uses call->user_mutex to allow the socket to be used in
parallel), a second thread can come in and its recvmsg can pop the call off
the socket queue again.

In such a case, the first thread will be receiving stuff from the call and
the second thread will be blocked on call->user_mutex.  The first thread
can, at this point, process both the event that it picked call for and the
event that the second thread picked the call for and may see the call
terminate - in which case the call will be "released", decoupling the call
from the user call ID assigned to it (RXRPC_USER_CALL_ID in the control
message).

The first thread will return okay, but then the second thread will wake up
holding the user_mutex and, if it sees that the call has been released by
the first thread, it will BUG thusly:

	kernel BUG at net/rxrpc/recvmsg.c:474!

Fix this by just dequeuing the call and ignoring it if it is seen to be
already released.  We can't tell userspace about it anyway as the user call
ID has become stale.

Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
Reported-by: Junvyyang, Tencent Zhuque Lab <zhuque@tencent.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: LePremierHomme <kwqcheii@proton.me>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@vger.kernel.org
---
 include/trace/events/rxrpc.h |  3 +++
 net/rxrpc/call_accept.c      |  1 +
 net/rxrpc/recvmsg.c          | 19 +++++++++++++++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 378d2dfc7392..e7dcfb1369b6 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -330,12 +330,15 @@
 	EM(rxrpc_call_put_userid,		"PUT user-id ") \
 	EM(rxrpc_call_see_accept,		"SEE accept  ") \
 	EM(rxrpc_call_see_activate_client,	"SEE act-clnt") \
+	EM(rxrpc_call_see_already_released,	"SEE alrdy-rl") \
 	EM(rxrpc_call_see_connect_failed,	"SEE con-fail") \
 	EM(rxrpc_call_see_connected,		"SEE connect ") \
 	EM(rxrpc_call_see_conn_abort,		"SEE conn-abt") \
+	EM(rxrpc_call_see_discard,		"SEE discard ") \
 	EM(rxrpc_call_see_disconnected,		"SEE disconn ") \
 	EM(rxrpc_call_see_distribute_error,	"SEE dist-err") \
 	EM(rxrpc_call_see_input,		"SEE input   ") \
+	EM(rxrpc_call_see_recvmsg,		"SEE recvmsg ") \
 	EM(rxrpc_call_see_release,		"SEE release ") \
 	EM(rxrpc_call_see_userid_exists,	"SEE u-exists") \
 	EM(rxrpc_call_see_waiting_call,		"SEE q-conn  ") \
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 226b4bf82747..a4d76f2da684 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -219,6 +219,7 @@ void rxrpc_discard_prealloc(struct rxrpc_sock *rx)
 	tail = b->call_backlog_tail;
 	while (CIRC_CNT(head, tail, size) > 0) {
 		struct rxrpc_call *call = b->call_backlog[tail];
+		rxrpc_see_call(call, rxrpc_call_see_discard);
 		rcu_assign_pointer(call->socket, rx);
 		if (rx->app_ops &&
 		    rx->app_ops->discard_new_call) {
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 86a27fb55a1c..6990e37697de 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -447,6 +447,16 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		goto try_again;
 	}
 
+	rxrpc_see_call(call, rxrpc_call_see_recvmsg);
+	if (test_bit(RXRPC_CALL_RELEASED, &call->flags)) {
+		rxrpc_see_call(call, rxrpc_call_see_already_released);
+		list_del_init(&call->recvmsg_link);
+		spin_unlock_irq(&rx->recvmsg_lock);
+		release_sock(&rx->sk);
+		trace_rxrpc_recvmsg(call->debug_id, rxrpc_recvmsg_unqueue, 0);
+		rxrpc_put_call(call, rxrpc_call_put_recvmsg);
+		goto try_again;
+	}
 	if (!(flags & MSG_PEEK))
 		list_del_init(&call->recvmsg_link);
 	else
@@ -470,8 +480,13 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	release_sock(&rx->sk);
 
-	if (test_bit(RXRPC_CALL_RELEASED, &call->flags))
-		BUG();
+	if (test_bit(RXRPC_CALL_RELEASED, &call->flags)) {
+		rxrpc_see_call(call, rxrpc_call_see_already_released);
+		mutex_unlock(&call->user_mutex);
+		if (!(flags & MSG_PEEK))
+			rxrpc_put_call(call, rxrpc_call_put_recvmsg);
+		goto try_again;
+	}
 
 	ret = rxrpc_recvmsg_user_id(call, msg, flags);
 	if (ret < 0)


