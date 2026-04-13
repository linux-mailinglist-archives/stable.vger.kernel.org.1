Return-Path: <stable+bounces-236055-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOkXF4/n3GmUYAkAu9opvQ
	(envelope-from <stable+bounces-236055-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:54:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7DC3EC3E5
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 520A3306C347
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF463C8724;
	Mon, 13 Apr 2026 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d2eE4cjO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F9E3C872C
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776084651; cv=none; b=s7jDKxqSGivFnLWnQS+cMf3eN8DZicbjo0SgcH0cc35LaK8+2wfjOaaxm4rQSGaHITwOyNUCScD8sXCxeweqVx7CctiC09W6Q86+Xjty1QOwfx9UPGfd6CTlL2zD81O7ntJe+u28czg+3j6pkLsVbyaSbzBqhCVxNlZ/npz9MlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776084651; c=relaxed/simple;
	bh=gNIidP06NoteS6dPA7OoB/BHiYs3qZkiF6Q/pkccyQU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UTnP5ASYTtJivfPfflY7zTHBVjwHUAX7vaGbs9YxwQLecoc1Z139G8Z75UToE9J1/rPM2Aizehmr80gELUXodw9mahoPX/asDjhGXhu0CDRK7ERNKUgGjFlJbQttdVPQ21WFnn4tcIlECJBK+F7VHFP7M3LsqC47HjDOO9wCWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d2eE4cjO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E2DC2BCAF;
	Mon, 13 Apr 2026 12:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776084651;
	bh=gNIidP06NoteS6dPA7OoB/BHiYs3qZkiF6Q/pkccyQU=;
	h=Subject:To:Cc:From:Date:From;
	b=d2eE4cjOTu39SJFkKpUsyG+WzZokTaRkNzALNpuxDll8FxPfngtyB+coNFjMoLU3h
	 xydfHmvpCO9uz2lya5nWjdI7qEosqqQHpW8wq0SeaRYUrpgfZgVs6M3fox1rjUVrgq
	 l/wj4HKRcWs8/P/exMoYfc5NPawGca1QiYuroonM=
Subject: FAILED: patch "[PATCH] rxrpc: Fix call removal to use RCU safe deletion" failed to apply to 6.1-stable tree
To: dhowells@redhat.com,horms@kernel.org,jaltman@auristor.com,kuba@kernel.org,marc.dionne@auristor.com,torvalds@linux-foundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Apr 2026 14:30:32 +0200
Message-ID: <2026041332-thimble-aftermost-285c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236055-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,sashiko.dev:url,msgid.link:url,auristor.com:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: DA7DC3EC3E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 146d4ab94cf129ee06cd467cb5c71368a6b5bad6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026041332-thimble-aftermost-285c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 146d4ab94cf129ee06cd467cb5c71368a6b5bad6 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Wed, 8 Apr 2026 13:12:32 +0100
Subject: [PATCH] rxrpc: Fix call removal to use RCU safe deletion

Fix rxrpc call removal from the rxnet->calls list to use list_del_rcu()
rather than list_del_init() to prevent stuffing up reading
/proc/net/rxrpc/calls from potentially getting into an infinite loop.

This, however, means that list_empty() no longer works on an entry that's
been deleted from the list, making it harder to detect prior deletion.  Fix
this by:

Firstly, make rxrpc_destroy_all_calls() only dump the first ten calls that
are unexpectedly still on the list.  Limiting the number of steps means
there's no need to call cond_resched() or to remove calls from the list
here, thereby eliminating the need for rxrpc_put_call() to check for that.

rxrpc_put_call() can then be fixed to unconditionally delete the call from
the list as it is the only place that the deletion occurs.

Fixes: 2baec2c3f854 ("rxrpc: Support network namespacing")
Closes: https://sashiko.dev/#/patchset/20260319150150.4189381-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260408121252.2249051-5-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 869f97c9bf73..a826cd80007b 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -347,7 +347,7 @@
 	EM(rxrpc_call_see_release,		"SEE release ") \
 	EM(rxrpc_call_see_userid_exists,	"SEE u-exists") \
 	EM(rxrpc_call_see_waiting_call,		"SEE q-conn  ") \
-	E_(rxrpc_call_see_zap,			"SEE zap     ")
+	E_(rxrpc_call_see_still_live,		"SEE !still-l")
 
 #define rxrpc_txqueue_traces \
 	EM(rxrpc_txqueue_await_reply,		"AWR") \
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 918f41d97a2f..59329cfe1532 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -654,11 +654,9 @@ void rxrpc_put_call(struct rxrpc_call *call, enum rxrpc_call_trace why)
 	if (dead) {
 		ASSERTCMP(__rxrpc_call_state(call), ==, RXRPC_CALL_COMPLETE);
 
-		if (!list_empty(&call->link)) {
-			spin_lock(&rxnet->call_lock);
-			list_del_init(&call->link);
-			spin_unlock(&rxnet->call_lock);
-		}
+		spin_lock(&rxnet->call_lock);
+		list_del_rcu(&call->link);
+		spin_unlock(&rxnet->call_lock);
 
 		rxrpc_cleanup_call(call);
 	}
@@ -730,24 +728,20 @@ void rxrpc_destroy_all_calls(struct rxrpc_net *rxnet)
 	_enter("");
 
 	if (!list_empty(&rxnet->calls)) {
+		int shown = 0;
+
 		spin_lock(&rxnet->call_lock);
 
-		while (!list_empty(&rxnet->calls)) {
-			call = list_entry(rxnet->calls.next,
-					  struct rxrpc_call, link);
-			_debug("Zapping call %p", call);
-
-			rxrpc_see_call(call, rxrpc_call_see_zap);
-			list_del_init(&call->link);
+		list_for_each_entry(call, &rxnet->calls, link) {
+			rxrpc_see_call(call, rxrpc_call_see_still_live);
 
 			pr_err("Call %p still in use (%d,%s,%lx,%lx)!\n",
 			       call, refcount_read(&call->ref),
 			       rxrpc_call_states[__rxrpc_call_state(call)],
 			       call->flags, call->events);
 
-			spin_unlock(&rxnet->call_lock);
-			cond_resched();
-			spin_lock(&rxnet->call_lock);
+			if (++shown >= 10)
+				break;
 		}
 
 		spin_unlock(&rxnet->call_lock);


