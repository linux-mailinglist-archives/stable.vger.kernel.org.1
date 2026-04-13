Return-Path: <stable+bounces-236056-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGZMIZTn3GmUYAkAu9opvQ
	(envelope-from <stable+bounces-236056-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:54:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFFE3EC3F5
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90FD5306DA46
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B193C8724;
	Mon, 13 Apr 2026 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pJreuULc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0533C7E0C
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776084654; cv=none; b=dUgXaCz39EXOODMHUkzKzU0DlnJx2DxqJLZvEhH4IqB1Bi4mtKoufP4+FgK331aZ3yHAOG3z0zHS0fNgd4lUTV/wtvSTG8Mg5uPXe/DLY9rIAnDSeWUJXA/Yf/hyX21Oaksshs0anAPAVUpDvAECI767Z3GmqH8AlRNOSSl/thQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776084654; c=relaxed/simple;
	bh=TfQStdlNgBPniWU5QvvPvzsa9jCBm2Comm4iYxjXvN0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MM7bWp1+6k+vJLHRDquPjQLScAddJeICJHjc4bPTELsx+WG3S6dQR6Tu+/qtrQLuGtnMsuPeYK3eYZEBICVl5kialp/JfC2OLptNsjWGH2WNtD6cNS6iQ85AwpY0HncgqyG/8rd9PEH0Nj18IrGyopVLqeslpHDK/8OhPY6RjoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pJreuULc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE467C2BCAF;
	Mon, 13 Apr 2026 12:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776084654;
	bh=TfQStdlNgBPniWU5QvvPvzsa9jCBm2Comm4iYxjXvN0=;
	h=Subject:To:Cc:From:Date:From;
	b=pJreuULc2ZZI87jG63Pbhao9AjuaaMMx66PtYrQ8+7tnVwW9Rz2wSEJf73fYsg8iy
	 Ov80iV2YV6VtmBc56y2gabH2Ha+jjECvoeXZDkJFfghaPBZzPjhHIMaw1By1+mVD3G
	 fwYEgOvpYzLdpgvM4XNX/MVSCWxZT9cADWq8vh2E=
Subject: FAILED: patch "[PATCH] rxrpc: Fix call removal to use RCU safe deletion" failed to apply to 5.10-stable tree
To: dhowells@redhat.com,horms@kernel.org,jaltman@auristor.com,kuba@kernel.org,marc.dionne@auristor.com,torvalds@linux-foundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Apr 2026 14:30:33 +0200
Message-ID: <2026041333-library-handclasp-83b5@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236056-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,linux-foundation.org:email,linuxfoundation.org:dkim,gregkh:email,sashiko.dev:url,msgid.link:url,auristor.com:email]
X-Rspamd-Queue-Id: 1CFFE3EC3F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 146d4ab94cf129ee06cd467cb5c71368a6b5bad6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026041333-library-handclasp-83b5@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


