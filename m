Return-Path: <stable+bounces-237697-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBmGDM2Z3WmqgQkAu9opvQ
	(envelope-from <stable+bounces-237697-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 03:35:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A390B3F4CEB
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 03:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4650A3027331
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 01:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD695242D9B;
	Tue, 14 Apr 2026 01:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XY9GJMXb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A110F18A6CF
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 01:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776130505; cv=none; b=BhMNJoy+ACu52Vht3sdkLtI97eb7THDgUcn1iEV95z4MoO4CkR2cj5NYxxE46uoU3bj17pljS0q4raf9E51Jx3SiITKM+6Cz1FsCN3Z1H1ALhESysiK4V62HFt5TH4gGav9wQyPgpLgS0ZmzGdFMLOYHZEhwiqaccisxNRMhvdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776130505; c=relaxed/simple;
	bh=CG41oxMu97RRpy6MVKyEVcoyecZ5qolgl5ckqP4J020=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1lWcEYeUvmgX/fz4gdL40TSdufu88Jq8o83belzKU1d0CBkU/6E0JxasVbsYrEMmjqigC+Ag30J6X2z9TkobW8Sz1nmTRlIqSC7KUHtZlGm+JfXVtLvnquStmyuwSHzGhpYZ6U71ugYzCJXhVMvICMmOSbHxmtJ5KKQAVxFaog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XY9GJMXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B61C2BCAF;
	Tue, 14 Apr 2026 01:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776130505;
	bh=CG41oxMu97RRpy6MVKyEVcoyecZ5qolgl5ckqP4J020=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XY9GJMXbtYcXVqJpEyjAwsWdpej3ws10X4rysVy3uKejJFpKxatG3beHhKLm8srAC
	 3t+GgIVg/UO/UUkcTCePyntDGt8l5F7eQviAXgtfaqi8TBVnJ1GQurHwP/TeNahcER
	 SDFNWkObwIdQO1isK+LXglYG4/+46AZA6+1zyVpgxDPJBPOSrCorgtkgtPAN3h4eJJ
	 ROc/0uqsLdkUzlhQvpuvFo11fXBlV8cIHGDv8uMogjZFf+WVtB/SVp+n5GaDW5y2c2
	 qugf83QZmPWuy3Q286V7QKCn+mOss0wjciJ/YST0wnixHhG08I8X38y6AGpZlsHTog
	 E2CPIWN7UPLCA==
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
Subject: [PATCH 5.15.y] rxrpc: Fix call removal to use RCU safe deletion
Date: Mon, 13 Apr 2026 21:35:02 -0400
Message-ID: <20260414013502.3857050-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041333-uncoated-appendix-fea5@gregkh>
References: <2026041333-uncoated-appendix-fea5@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237697-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,auristor.com:email,sashiko.dev:url,linux-foundation.org:email]
X-Rspamd-Queue-Id: A390B3F4CEB
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
[ adapted to older API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/call_object.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 6401cdf7a6246..33165080f4685 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -634,11 +634,9 @@ void rxrpc_put_call(struct rxrpc_call *call, enum rxrpc_call_trace op)
 		_debug("call %d dead", call->debug_id);
 		ASSERTCMP(call->state, ==, RXRPC_CALL_COMPLETE);
 
-		if (!list_empty(&call->link)) {
-			spin_lock_bh(&rxnet->call_lock);
-			list_del_init(&call->link);
-			spin_unlock_bh(&rxnet->call_lock);
-		}
+		spin_lock_bh(&rxnet->call_lock);
+		list_del_rcu(&call->link);
+		spin_unlock_bh(&rxnet->call_lock);
 
 		rxrpc_cleanup_call(call);
 	}
@@ -709,24 +707,20 @@ void rxrpc_destroy_all_calls(struct rxrpc_net *rxnet)
 	_enter("");
 
 	if (!list_empty(&rxnet->calls)) {
-		spin_lock_bh(&rxnet->call_lock);
+		int shown = 0;
 
-		while (!list_empty(&rxnet->calls)) {
-			call = list_entry(rxnet->calls.next,
-					  struct rxrpc_call, link);
-			_debug("Zapping call %p", call);
+		spin_lock_bh(&rxnet->call_lock);
 
+		list_for_each_entry(call, &rxnet->calls, link) {
 			rxrpc_see_call(call);
-			list_del_init(&call->link);
 
 			pr_err("Call %p still in use (%d,%s,%lx,%lx)!\n",
 			       call, refcount_read(&call->ref),
 			       rxrpc_call_states[call->state],
 			       call->flags, call->events);
 
-			spin_unlock_bh(&rxnet->call_lock);
-			cond_resched();
-			spin_lock_bh(&rxnet->call_lock);
+			if (++shown >= 10)
+				break;
 		}
 
 		spin_unlock_bh(&rxnet->call_lock);
-- 
2.53.0


