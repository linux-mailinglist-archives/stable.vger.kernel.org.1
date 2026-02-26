Return-Path: <stable+bounces-219745-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEfZFLCzn2kpdQQAu9opvQ
	(envelope-from <stable+bounces-219745-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 03:45:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D84091A0321
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 03:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 711E5301A38E
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 02:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD6037E314;
	Thu, 26 Feb 2026 02:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RNl8NcKR"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373112D7DD9;
	Thu, 26 Feb 2026 02:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073765; cv=none; b=XwFNXJ5/AAjFfxIzRlm9tTx1u9wHqnejtEodrGUu28804VIjvaUvpN83kPtUkWOGE55kvYksQCR5UvN0IHu9C3LrKnc1d5FboXqXO+hIl5WduAxfQBZVNaWMRrwrKHTC2P2DDULMAUfkz+CJccMtgF8pvmorkLuep2IiPbt20Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073765; c=relaxed/simple;
	bh=4X4xeZaAEDiSH5/EyfICbKLACJ826PFhGinFJCgeVoU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FQJmoZqRy5HdXTh2W6DOkTCAd3kGdLfA9d5zPE2SXJZEkiv0Wn2wBSTvNreWFOCHt+7fDUb2r3f8x0N1n2NwZn4RGvdVWpiOQ674FZOzgSSxf/82rrvR+bRc5Q8Sg2OhRzwLj8VVPytTFZHIqiMCTtNzNyFkXMvt9VMyJR1N3jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RNl8NcKR; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=cs
	j3I2Hh0axpARrMAY/JNBtqgshUyDLfkG9MfsSGEus=; b=RNl8NcKR7+6I+n+kXI
	8zwfeKNmhDac11onaRdTORVzGiOS7yHWJE6mgL/z9AfIU41gtzfn0lKUsUrns2Sz
	p1prq/79ugWvsnsPlrJPulpTN5Ja6JxNxkbqUrK9Rt4e3FsHbKbS84KQfsi5Juy0
	bETVBrxc3nkVRxgI9iY+TlADs=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3B0K_sp9pVNYaOA--.27764S2;
	Thu, 26 Feb 2026 10:41:04 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>,
	Robert Garcia <rob_garcia@163.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Faith <faith@zellic.io>,
	Pumpkin Chang <pumpkin@devco.re>,
	Nir Ohfeld <niro@wiz.io>,
	Willy Tarreau <w@1wt.eu>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH 6.6.y] rxrpc: Fix recvmsg() unconditional requeue
Date: Thu, 26 Feb 2026 10:41:02 +0800
Message-Id: <20260226024102.3522867-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3B0K_sp9pVNYaOA--.27764S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF4Duw4DWryxKF17Cry7trb_yoWrury8pF
	n8ArsxZw18Xw1IvFZ3GFy8W3WUWFs7Wr17Jr1fZasakr1xZw4vqF1jgw45ZF1rGanrArWU
	XF1DWw4jyrs8X37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UIdgZUUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbDAQEfimmfssFDeQAA3q
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219745-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[auristor.com,163.com,goodmis.org,vger.kernel.org,kernel.org,davemloft.net,google.com,redhat.com,lists.infradead.org,zellic.io,devco.re,wiz.io,1wt.eu];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob_garcia@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wiz.io:email]
X-Rspamd-Queue-Id: D84091A0321
X-Rspamd-Action: no action

From: David Howells <dhowells@redhat.com>

[ Upstream commit 2c28769a51deb6022d7fbd499987e237a01dd63a ]

If rxrpc_recvmsg() fails because MSG_DONTWAIT was specified but the call at
the front of the recvmsg queue already has its mutex locked, it requeues
the call - whether or not the call is already queued.  The call may be on
the queue because MSG_PEEK was also passed and so the call was not dequeued
or because the I/O thread requeued it.

The unconditional requeue may then corrupt the recvmsg queue, leading to
things like UAFs or refcount underruns.

Fix this by only requeuing the call if it isn't already on the queue - and
moving it to the front if it is already queued.  If we don't queue it, we
have to put the ref we obtained by dequeuing it.

Also, MSG_PEEK doesn't dequeue the call so shouldn't call
rxrpc_notify_socket() for the call if we didn't use up all the data on the
queue, so fix that also.

Fixes: 540b1c48c37a ("rxrpc: Fix deadlock between call creation and sendmsg/recvmsg")
Reported-by: Faith <faith@zellic.io>
Reported-by: Pumpkin Chang <pumpkin@devco.re>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Marc Dionne <marc.dionne@auristor.com>
cc: Nir Ohfeld <niro@wiz.io>
cc: Willy Tarreau <w@1wt.eu>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/95163.1768428203@warthog.procyon.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Use spin_unlock instead of spin_unlock_irq to maintain context consistency.]
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 include/trace/events/rxrpc.h |  4 ++++
 net/rxrpc/recvmsg.c          | 19 +++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 743f8f1f42a7..ceb09fabfb04 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -270,6 +270,7 @@
 	EM(rxrpc_call_put_kernel,		"PUT kernel  ") \
 	EM(rxrpc_call_put_poke,			"PUT poke    ") \
 	EM(rxrpc_call_put_recvmsg,		"PUT recvmsg ") \
+	EM(rxrpc_call_put_recvmsg_peek_nowait,	"PUT peek-nwt") \
 	EM(rxrpc_call_put_release_sock,		"PUT rls-sock") \
 	EM(rxrpc_call_put_release_sock_tba,	"PUT rls-sk-a") \
 	EM(rxrpc_call_put_sendmsg,		"PUT sendmsg ") \
@@ -287,6 +288,9 @@
 	EM(rxrpc_call_see_distribute_error,	"SEE dist-err") \
 	EM(rxrpc_call_see_input,		"SEE input   ") \
 	EM(rxrpc_call_see_recvmsg,		"SEE recvmsg ") \
+	EM(rxrpc_call_see_recvmsg_requeue,	"SEE recv-rqu") \
+	EM(rxrpc_call_see_recvmsg_requeue_first, "SEE recv-rqF") \
+	EM(rxrpc_call_see_recvmsg_requeue_move,	"SEE recv-rqM") \
 	EM(rxrpc_call_see_release,		"SEE release ") \
 	EM(rxrpc_call_see_userid_exists,	"SEE u-exists") \
 	EM(rxrpc_call_see_waiting_call,		"SEE q-conn  ") \
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index e24a44bae9a3..b6e524c065f0 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -430,7 +430,8 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	if (rxrpc_call_has_failed(call))
 		goto call_failed;
 
-	if (!skb_queue_empty(&call->recvmsg_queue))
+	if (!(flags & MSG_PEEK) &&
+	    !skb_queue_empty(&call->recvmsg_queue))
 		rxrpc_notify_socket(call);
 	goto not_yet_complete;
 
@@ -461,11 +462,21 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 error_requeue_call:
 	if (!(flags & MSG_PEEK)) {
 		spin_lock(&rx->recvmsg_lock);
-		list_add(&call->recvmsg_link, &rx->recvmsg_q);
-		spin_unlock(&rx->recvmsg_lock);
+		if (list_empty(&call->recvmsg_link)) {
+			list_add(&call->recvmsg_link, &rx->recvmsg_q);
+			rxrpc_see_call(call, rxrpc_call_see_recvmsg_requeue);
+			spin_unlock(&rx->recvmsg_lock);
+		} else if (list_is_first(&call->recvmsg_link, &rx->recvmsg_q)) {
+			spin_unlock(&rx->recvmsg_lock);
+			rxrpc_put_call(call, rxrpc_call_see_recvmsg_requeue_first);
+		} else {
+			list_move(&call->recvmsg_link, &rx->recvmsg_q);
+			spin_unlock(&rx->recvmsg_lock);
+			rxrpc_put_call(call, rxrpc_call_see_recvmsg_requeue_move);
+		}
 		trace_rxrpc_recvmsg(call_debug_id, rxrpc_recvmsg_requeue, 0);
 	} else {
-		rxrpc_put_call(call, rxrpc_call_put_recvmsg);
+		rxrpc_put_call(call, rxrpc_call_put_recvmsg_peek_nowait);
 	}
 error_no_call:
 	release_sock(&rx->sk);
-- 
2.34.1


