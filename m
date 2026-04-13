Return-Path: <stable+bounces-236310-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLnsOG4Y3WnoZwkAu9opvQ
	(envelope-from <stable+bounces-236310-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:23:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E859D3EEC30
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A5943049DC3
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A0D3033FD;
	Mon, 13 Apr 2026 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xaZrBC2S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4A82DCF4C;
	Mon, 13 Apr 2026 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096578; cv=none; b=mYqyaBjLAm+SbgMPSRwiaAoQGEzhLSDotz3dBbt6VHARFB585FN2Wigx7GQvB5I1+RLmwxRd9lS2WGbEmZbgcJIUmfRTP9H8wooVyqphv9TEnxTnO2IkyxwX6cxahbvGb6G3EyEBcjAM5qvo532SjVZmc5XeT0q1Jg541xcdhsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096578; c=relaxed/simple;
	bh=0/bubUCD2AbiQ9sLZpDwkIOYcdmq/4IFQoad7vqJJM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhqZ2NyZHmM0jl9LuMp6ZmFZAzPVbITtp/2pqRtTzxonRpSwz17SrZDS9EI70isDSyTeg/NhQxc7zk/R6W+34hTyrjzj8kTWb6oNPXSNvVWGCDoTvagz58pIR+KP12Sw8Nsd54xuhG+lZ0h+TO/IKI92LTh3ImapT04p/uzuOXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xaZrBC2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2121EC2BCB0;
	Mon, 13 Apr 2026 16:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096578;
	bh=0/bubUCD2AbiQ9sLZpDwkIOYcdmq/4IFQoad7vqJJM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xaZrBC2SMuaJkA9hNHUspDbbD2ikYrlHoXf4tm5CiJs0zxkfxahntzBXbWzH7D9BP
	 fSJjlx5pa+wV83Sb+FxRhuS3pRj0RTQZo3um56WDSLVf4I2yBUYsrE9IpnObvt1FHN
	 astcWBXDaHBLA8YhqX8DSADikEAqN7rSPASPGqp0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 65/83] rxrpc: Fix call removal to use RCU safe deletion
Date: Mon, 13 Apr 2026 18:00:33 +0200
Message-ID: <20260413155733.434638220@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.019638460@linuxfoundation.org>
References: <20260413155731.019638460@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236310-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[auristor.com:email,msgid.link:url,infradead.org:email,sashiko.dev:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linux-foundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E859D3EEC30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit 146d4ab94cf129ee06cd467cb5c71368a6b5bad6 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/trace/events/rxrpc.h |    2 +-
 net/rxrpc/call_object.c      |   24 +++++++++---------------
 2 files changed, 10 insertions(+), 16 deletions(-)

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
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -654,11 +654,9 @@ void rxrpc_put_call(struct rxrpc_call *c
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
@@ -730,24 +728,20 @@ void rxrpc_destroy_all_calls(struct rxrp
 	_enter("");
 
 	if (!list_empty(&rxnet->calls)) {
-		spin_lock(&rxnet->call_lock);
+		int shown = 0;
 
-		while (!list_empty(&rxnet->calls)) {
-			call = list_entry(rxnet->calls.next,
-					  struct rxrpc_call, link);
-			_debug("Zapping call %p", call);
+		spin_lock(&rxnet->call_lock);
 
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



