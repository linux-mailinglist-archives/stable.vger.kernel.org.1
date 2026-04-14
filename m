Return-Path: <stable+bounces-237805-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHXkLXEj3mk1ngkAu9opvQ
	(envelope-from <stable+bounces-237805-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:22:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BDB3F9432
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECE83300BC9E
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA9A3A641C;
	Tue, 14 Apr 2026 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8T1LzrY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61017397E86
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165725; cv=none; b=SewiwkapQVC6YMcfBpwamUgnnIb4qoK/u2r7um+wvA3ik1iWS+pRAj6Odt+xDtjsbOyuPTTMsC10vp45bEoow59PJYrYuXKMI0MS7ZchsdQ8rLI2tAaUAZl4rQ831yy8AwXRDlJ4o2VDEqe+JI8lH1ptjXaprPBv68JL044ev4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165725; c=relaxed/simple;
	bh=jB1BMVgR7rW4LEJeZS5QWK+Fq4TTthAcHENuJuGfiV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRxLxtj56e8SrJNqV44YQ4a4/w1dVgnCoSMaYlHa/TCTPghE0YwiClGaALyyJOgTKOGxJuO+vHnv+uy06rbUCMwgOelbx5BbdUiVJhKTmM/G591TRYdyFpXBCO/7OjiXbXdvJ55cu7I5e5tyi921dUj3t3g3MAq/nRAe4Nvqp1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8T1LzrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4147AC19425;
	Tue, 14 Apr 2026 11:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776165725;
	bh=jB1BMVgR7rW4LEJeZS5QWK+Fq4TTthAcHENuJuGfiV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j8T1LzrYFsZF0+JDTKyCfxeNp+Tx3H48Cte+hAp7N8yyodqVcbdMGN+noRVuHnnSN
	 LH8dpEjhOia2/v0H1L4+Hh2MKFE5EJ6fVS1mq4gHwBlGr/BgL/PDXK2vERQqtw1/sB
	 liwhqhe4IipL49cTlpHaAiFh2adyACGOLJAFDulEqlLn2wqYzHZsNaYuG6VM7GBFH8
	 JPjHmThtCLFzREkcfrJyrllniIdJ6F5UjS4xNmz39jdjBJFm9y+AKH/iNPCbdCWQyJ
	 93ei3a9UNQmyRhoUwbL4gO3q0ckJ4Tbmj4+n8sWR2sx2pBWeR6OPgmve0/YY1tiVDm
	 IHs9qFv9j3J1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] rxrpc: Fix call removal to use RCU safe deletion
Date: Tue, 14 Apr 2026 07:22:02 -0400
Message-ID: <20260414112202.389116-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041333-library-handclasp-83b5@gregkh>
References: <2026041333-library-handclasp-83b5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237805-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,msgid.link:url,sashiko.dev:url,linux-foundation.org:email]
X-Rspamd-Queue-Id: 18BDB3F9432
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Howells <dhowells@redhat.com>

[ Upstream commit 146d4ab94cf129ee06cd467cb5c71368a6b5bad6 ]

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
[ adapted spin_lock/spin_unlock to write_lock/write_unlock ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/call_object.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 10dad2834d5b6..2240e93b0048a 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -634,11 +634,9 @@ void rxrpc_put_call(struct rxrpc_call *call, enum rxrpc_call_trace op)
 		_debug("call %d dead", call->debug_id);
 		ASSERTCMP(call->state, ==, RXRPC_CALL_COMPLETE);
 
-		if (!list_empty(&call->link)) {
-			write_lock(&rxnet->call_lock);
-			list_del_init(&call->link);
-			write_unlock(&rxnet->call_lock);
-		}
+		write_lock(&rxnet->call_lock);
+		list_del_rcu(&call->link);
+		write_unlock(&rxnet->call_lock);
 
 		rxrpc_cleanup_call(call);
 	}
@@ -709,24 +707,20 @@ void rxrpc_destroy_all_calls(struct rxrpc_net *rxnet)
 	_enter("");
 
 	if (!list_empty(&rxnet->calls)) {
-		write_lock(&rxnet->call_lock);
+		int shown = 0;
 
-		while (!list_empty(&rxnet->calls)) {
-			call = list_entry(rxnet->calls.next,
-					  struct rxrpc_call, link);
-			_debug("Zapping call %p", call);
+		write_lock(&rxnet->call_lock);
 
+		list_for_each_entry(call, &rxnet->calls, link) {
 			rxrpc_see_call(call);
-			list_del_init(&call->link);
 
 			pr_err("Call %p still in use (%d,%s,%lx,%lx)!\n",
 			       call, refcount_read(&call->ref),
 			       rxrpc_call_states[call->state],
 			       call->flags, call->events);
 
-			write_unlock(&rxnet->call_lock);
-			cond_resched();
-			write_lock(&rxnet->call_lock);
+			if (++shown >= 10)
+				break;
 		}
 
 		write_unlock(&rxnet->call_lock);
-- 
2.53.0


