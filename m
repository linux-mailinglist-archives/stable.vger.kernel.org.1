Return-Path: <stable+bounces-211576-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGY2Fjlpd2nCfQEAu9opvQ
	(envelope-from <stable+bounces-211576-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:16:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA33F88B0E
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9BC13016EE3
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 13:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F12F19D074;
	Mon, 26 Jan 2026 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VZtWAWUd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E147494
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769433333; cv=none; b=me9zX8shO063/dTbp3qKjxWTeUndc5R7BUQAyjFFin+1BRSC0uLKRwGDbN7slmh/ikHE7QiK/Y1fHJ5h+GFtdJZLAQdcIN2z7BGRuuvDTOpC98O9USTbfx+g/OhpM3rgczqMETuexxZikLqPQ9J86ULRaZfHlhZ3krbjohHnu+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769433333; c=relaxed/simple;
	bh=LTuhVUdBU7jgSID6olEEyzNO68PugEL1xol4FQ5Xeag=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RriilaoIUwwsI9QlUVCOuHQQA5goHTuu05pLEJ4z2pA0xdQWwrUlCvu7aKZN46gYpF2h2nIsIlPyiWLTL/pDjiPEnn7wp04PC4UpbXRhjiKvlx58Xk89Vcrm97e3WI6F6WR2GoYunDR8BR1sGBFe/cXA6kUL0plmYMOdOVwJ57w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VZtWAWUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF25C116C6;
	Mon, 26 Jan 2026 13:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769433333;
	bh=LTuhVUdBU7jgSID6olEEyzNO68PugEL1xol4FQ5Xeag=;
	h=Subject:To:Cc:From:Date:From;
	b=VZtWAWUdvTr1cRtTEm6wpriNdtnskTbZlBAPAOOpyCQdihuyq/brmbKlQV7DGmgVe
	 sTGWHGuWpo7Ceb6VuvP2J+6kVRYEnZVj09XvPbFTsDQOtA7L8Y40HBTa71pxzvRdQH
	 ifZz4vwgSe2kHpLKgOiSfKSjauHaSelwAW81Q/iA=
Subject: FAILED: patch "[PATCH] rxrpc: Fix recvmsg() unconditional requeue" failed to apply to 6.12-stable tree
To: dhowells@redhat.com,faith@zellic.io,horms@kernel.org,kuba@kernel.org,marc.dionne@auristor.com,niro@wiz.io,pumpkin@devco.re,w@1wt.eu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Jan 2026 14:15:30 +0100
Message-ID: <2026012630-roamer-sled-ef0e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211576-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,gregkh:email,wiz.io:email,zellic.io:email,linuxfoundation.org:dkim,infradead.org:email]
X-Rspamd-Queue-Id: AA33F88B0E
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 2c28769a51deb6022d7fbd499987e237a01dd63a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012630-roamer-sled-ef0e@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2c28769a51deb6022d7fbd499987e237a01dd63a Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Wed, 14 Jan 2026 22:03:23 +0000
Subject: [PATCH] rxrpc: Fix recvmsg() unconditional requeue

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

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index de6f6d25767c..869f97c9bf73 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -322,6 +322,7 @@
 	EM(rxrpc_call_put_kernel,		"PUT kernel  ") \
 	EM(rxrpc_call_put_poke,			"PUT poke    ") \
 	EM(rxrpc_call_put_recvmsg,		"PUT recvmsg ") \
+	EM(rxrpc_call_put_recvmsg_peek_nowait,	"PUT peek-nwt") \
 	EM(rxrpc_call_put_release_recvmsg_q,	"PUT rls-rcmq") \
 	EM(rxrpc_call_put_release_sock,		"PUT rls-sock") \
 	EM(rxrpc_call_put_release_sock_tba,	"PUT rls-sk-a") \
@@ -340,6 +341,9 @@
 	EM(rxrpc_call_see_input,		"SEE input   ") \
 	EM(rxrpc_call_see_notify_released,	"SEE nfy-rlsd") \
 	EM(rxrpc_call_see_recvmsg,		"SEE recvmsg ") \
+	EM(rxrpc_call_see_recvmsg_requeue,	"SEE recv-rqu") \
+	EM(rxrpc_call_see_recvmsg_requeue_first, "SEE recv-rqF") \
+	EM(rxrpc_call_see_recvmsg_requeue_move,	"SEE recv-rqM") \
 	EM(rxrpc_call_see_release,		"SEE release ") \
 	EM(rxrpc_call_see_userid_exists,	"SEE u-exists") \
 	EM(rxrpc_call_see_waiting_call,		"SEE q-conn  ") \
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 7fa7e77f6bb9..e1f7513a46db 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -518,7 +518,8 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	if (rxrpc_call_has_failed(call))
 		goto call_failed;
 
-	if (!skb_queue_empty(&call->recvmsg_queue))
+	if (!(flags & MSG_PEEK) &&
+	    !skb_queue_empty(&call->recvmsg_queue))
 		rxrpc_notify_socket(call);
 	goto not_yet_complete;
 
@@ -549,11 +550,21 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 error_requeue_call:
 	if (!(flags & MSG_PEEK)) {
 		spin_lock_irq(&rx->recvmsg_lock);
-		list_add(&call->recvmsg_link, &rx->recvmsg_q);
-		spin_unlock_irq(&rx->recvmsg_lock);
+		if (list_empty(&call->recvmsg_link)) {
+			list_add(&call->recvmsg_link, &rx->recvmsg_q);
+			rxrpc_see_call(call, rxrpc_call_see_recvmsg_requeue);
+			spin_unlock_irq(&rx->recvmsg_lock);
+		} else if (list_is_first(&call->recvmsg_link, &rx->recvmsg_q)) {
+			spin_unlock_irq(&rx->recvmsg_lock);
+			rxrpc_put_call(call, rxrpc_call_see_recvmsg_requeue_first);
+		} else {
+			list_move(&call->recvmsg_link, &rx->recvmsg_q);
+			spin_unlock_irq(&rx->recvmsg_lock);
+			rxrpc_put_call(call, rxrpc_call_see_recvmsg_requeue_move);
+		}
 		trace_rxrpc_recvmsg(call_debug_id, rxrpc_recvmsg_requeue, 0);
 	} else {
-		rxrpc_put_call(call, rxrpc_call_put_recvmsg);
+		rxrpc_put_call(call, rxrpc_call_put_recvmsg_peek_nowait);
 	}
 error_no_call:
 	release_sock(&rx->sk);


