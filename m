Return-Path: <stable+bounces-163224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8080BB08744
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 09:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8324E2DAD
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 07:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFD82652AC;
	Thu, 17 Jul 2025 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ilo7pYmH"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2827A253F18
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738272; cv=none; b=Sk+WFedf1yFNAsG/ZygVhTEqNnXFWwihCDcLum3CeXwNvLrpcMpGSXV2k1uCAnSusxtE1cL82UdKzfS217ugJ4FORJCXQlaXLQiFmrsFmWpQiNL46VbY91VGKjnlwqKJs0aJjrWzVctWiwa1OjIBuIPxabFIb/YGjah1fNPTyog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738272; c=relaxed/simple;
	bh=NivspibC5Ar+l4fo7XhiPM74d5GHcCKgpPQsarKpa6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPxp1t3Hh1d0blYXgeoG6z+vDdWnDX06T0vvG7u+TNjZvZdiyHZUtGx1OZb350W6e9mGZMjAqb9crQmRT88dk26YQVmMPfM3RsCLFi6o0Z+Lnqvxdkj8X82gaGfscPksFVrL+8qGY1+Gc8sPuuO04ioYACCTbymCBJ190vKe9qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ilo7pYmH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752738270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySKCD9H+f5jDMmODuJA3EecbcSXS8rN66SNZmiDu2dY=;
	b=Ilo7pYmHsndlK2CuEgST41VGyrCjpq+FXre67sk4iIqqL+caqgpEYB0azVCrhERhk4XJeu
	ox8AP8EmF8epjCpnwi2SStRB/sSBuXFL5o8lQgD2wpyLaSxc1xvJZJk2+sGSOuNqDNzQSU
	E05gEShQ+l1r2qxPQ33BwCJ9iUGhptc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-S4T2HXWyOMaBR22p9Dputw-1; Thu,
 17 Jul 2025 03:44:26 -0400
X-MC-Unique: S4T2HXWyOMaBR22p9Dputw-1
X-Mimecast-MFC-AGG-ID: S4T2HXWyOMaBR22p9Dputw_1752738264
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52FD61800295;
	Thu, 17 Jul 2025 07:44:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF5D5180045B;
	Thu, 17 Jul 2025 07:44:17 +0000 (UTC)
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
	Jeffrey Altman <jaltman@auristor.com>,
	"Junvyyang, Tencent Zhuque Lab" <zhuque@tencent.com>,
	LePremierHomme <kwqcheii@proton.me>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2 3/5] rxrpc: Fix notification vs call-release vs recvmsg
Date: Thu, 17 Jul 2025 08:43:43 +0100
Message-ID: <20250717074350.3767366-4-dhowells@redhat.com>
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

When a call is released, rxrpc takes the spinlock and removes it from
->recvmsg_q in an effort to prevent racing recvmsg() invocations from
seeing the same call.  Now, rxrpc_recvmsg() only takes the spinlock when
actually removing a call from the queue; it doesn't, however, take it in
the lead up to that when it checks to see if the queue is empty.  It *does*
hold the socket lock, which prevents a recvmsg/recvmsg race - but this
doesn't prevent sendmsg from ending the call because sendmsg() drops the
socket lock and relies on the call->user_mutex.

Fix this by firstly removing the bit in rxrpc_release_call() that dequeues
the released call and, instead, rely on recvmsg() to simply discard
released calls (done in a preceding fix).

Secondly, rxrpc_notify_socket() is abandoned if the call is already marked
as released rather than trying to be clever by setting both pointers in
call->recvmsg_link to NULL to trick list_empty().  This isn't perfect and
can still race, resulting in a released call on the queue, but recvmsg()
will now clean that up.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Junvyyang, Tencent Zhuque Lab <zhuque@tencent.com>
cc: LePremierHomme <kwqcheii@proton.me>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@vger.kernel.org
---

Notes:
    Changes
    =======
    ver #2)
     - Moved in missing trace note declaration from later patch

 include/trace/events/rxrpc.h |  3 ++-
 net/rxrpc/call_object.c      | 28 ++++++++++++----------------
 net/rxrpc/recvmsg.c          |  4 ++++
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index e7dcfb1369b6..de6f6d25767c 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -322,10 +322,10 @@
 	EM(rxrpc_call_put_kernel,		"PUT kernel  ") \
 	EM(rxrpc_call_put_poke,			"PUT poke    ") \
 	EM(rxrpc_call_put_recvmsg,		"PUT recvmsg ") \
+	EM(rxrpc_call_put_release_recvmsg_q,	"PUT rls-rcmq") \
 	EM(rxrpc_call_put_release_sock,		"PUT rls-sock") \
 	EM(rxrpc_call_put_release_sock_tba,	"PUT rls-sk-a") \
 	EM(rxrpc_call_put_sendmsg,		"PUT sendmsg ") \
-	EM(rxrpc_call_put_unnotify,		"PUT unnotify") \
 	EM(rxrpc_call_put_userid_exists,	"PUT u-exists") \
 	EM(rxrpc_call_put_userid,		"PUT user-id ") \
 	EM(rxrpc_call_see_accept,		"SEE accept  ") \
@@ -338,6 +338,7 @@
 	EM(rxrpc_call_see_disconnected,		"SEE disconn ") \
 	EM(rxrpc_call_see_distribute_error,	"SEE dist-err") \
 	EM(rxrpc_call_see_input,		"SEE input   ") \
+	EM(rxrpc_call_see_notify_released,	"SEE nfy-rlsd") \
 	EM(rxrpc_call_see_recvmsg,		"SEE recvmsg ") \
 	EM(rxrpc_call_see_release,		"SEE release ") \
 	EM(rxrpc_call_see_userid_exists,	"SEE u-exists") \
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 15067ff7b1f2..918f41d97a2f 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -561,7 +561,7 @@ static void rxrpc_cleanup_rx_buffers(struct rxrpc_call *call)
 void rxrpc_release_call(struct rxrpc_sock *rx, struct rxrpc_call *call)
 {
 	struct rxrpc_connection *conn = call->conn;
-	bool put = false, putu = false;
+	bool putu = false;
 
 	_enter("{%d,%d}", call->debug_id, refcount_read(&call->ref));
 
@@ -573,23 +573,13 @@ void rxrpc_release_call(struct rxrpc_sock *rx, struct rxrpc_call *call)
 
 	rxrpc_put_call_slot(call);
 
-	/* Make sure we don't get any more notifications */
+	/* Note that at this point, the call may still be on or may have been
+	 * added back on to the socket receive queue.  recvmsg() must discard
+	 * released calls.  The CALL_RELEASED flag should prevent further
+	 * notifications.
+	 */
 	spin_lock_irq(&rx->recvmsg_lock);
-
-	if (!list_empty(&call->recvmsg_link)) {
-		_debug("unlinking once-pending call %p { e=%lx f=%lx }",
-		       call, call->events, call->flags);
-		list_del(&call->recvmsg_link);
-		put = true;
-	}
-
-	/* list_empty() must return false in rxrpc_notify_socket() */
-	call->recvmsg_link.next = NULL;
-	call->recvmsg_link.prev = NULL;
-
 	spin_unlock_irq(&rx->recvmsg_lock);
-	if (put)
-		rxrpc_put_call(call, rxrpc_call_put_unnotify);
 
 	write_lock(&rx->call_lock);
 
@@ -638,6 +628,12 @@ void rxrpc_release_calls_on_socket(struct rxrpc_sock *rx)
 		rxrpc_put_call(call, rxrpc_call_put_release_sock);
 	}
 
+	while ((call = list_first_entry_or_null(&rx->recvmsg_q,
+						struct rxrpc_call, recvmsg_link))) {
+		list_del_init(&call->recvmsg_link);
+		rxrpc_put_call(call, rxrpc_call_put_release_recvmsg_q);
+	}
+
 	_leave("");
 }
 
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 6990e37697de..7fa7e77f6bb9 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -29,6 +29,10 @@ void rxrpc_notify_socket(struct rxrpc_call *call)
 
 	if (!list_empty(&call->recvmsg_link))
 		return;
+	if (test_bit(RXRPC_CALL_RELEASED, &call->flags)) {
+		rxrpc_see_call(call, rxrpc_call_see_notify_released);
+		return;
+	}
 
 	rcu_read_lock();
 


