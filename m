Return-Path: <stable+bounces-236259-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DDpMRoX3WmXZwkAu9opvQ
	(envelope-from <stable+bounces-236259-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:17:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C137C3EE8FB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43251302A0BA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E412737E0;
	Mon, 13 Apr 2026 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MrD5OUKA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB2F257844;
	Mon, 13 Apr 2026 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096452; cv=none; b=pFaB8B7yQnWGUlNneo6xKJ6yPi1Kx/A/U6NQVQY6/1Co7MAdgfoCuvgv11eTy+84b+MVAx3uqa1By7A+scXX8XFJrLEZqNKvHVFVcEQg3Uk1apNavZ2BCiNdJJ1ZVgcn0Op6oqaSY6Tmcd8IbyQ4FViD+S1g2YbRm+b/tUivtSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096452; c=relaxed/simple;
	bh=icwh5/63dA6FUmFqs/gmvf4T3Aa8KcFOTiiZ7cZBMeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByBb/o1xa0VjFiP2fh3daEdl5TL0ACyySLYAmemudkO4sHK7vP1rA8gXnAY9ImYcZ8KDM5bgDFQk9yMJfLxeANvBTtkqwsEfueQbsM8Fz/wxUEo2+BIR4+ayqsWvxgvnjtWqtREdADa9nzmG103EJBlZ4YXkOKLJs1UKLxVHZ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MrD5OUKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF14C2BCAF;
	Mon, 13 Apr 2026 16:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096452;
	bh=icwh5/63dA6FUmFqs/gmvf4T3Aa8KcFOTiiZ7cZBMeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MrD5OUKAx3XFGVUhPGHKEYwuvROsTy9zvKNnuSBTMrSUVz+wlQ/cm/qUxEXN3lPlg
	 UCTpE4vsIJdha1/QWkdPeSG+rfSejJmZ/InF3rtJmT5QtAAb5LRXhd74UELX9fCZh9
	 ShLvNydlYCAl7PQEDdSVw3jobdgWoiEmjqenHb3Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 17/83] af_unix: Simplify GC state.
Date: Mon, 13 Apr 2026 17:59:45 +0200
Message-ID: <20260413155731.667969487@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236259-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: C137C3EE8FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit 6b6f3c71fe568aa8ed3e16e9135d88a5f4fd3e84 ]

GC manages its state by two variables, unix_graph_maybe_cyclic
and unix_graph_grouped, both of which are set to false in the
initial state.

When an AF_UNIX socket is passed to an in-flight AF_UNIX socket,
unix_update_graph() sets unix_graph_maybe_cyclic to true and
unix_graph_grouped to false, making the next GC invocation call
unix_walk_scc() to group SCCs.

Once unix_walk_scc() finishes, sockets in the same SCC are linked
via vertex->scc_entry.  Then, unix_graph_grouped is set to true
so that the following GC invocations can skip Tarjan's algorithm
and simply iterate through the list in unix_walk_scc_fast().

In addition, if we know there is at least one cyclic reference,
we set unix_graph_maybe_cyclic to true so that we do not skip GC.

So the state transitions as follows:

  (unix_graph_maybe_cyclic, unix_graph_grouped)
  =
  (false, false) -> (true, false) -> (true, true) or (false, true)
                         ^.______________/________________/

There is no transition to the initial state where both variables
are false.

If we consider the initial state as grouped, we can see that the
GC actually has a tristate.

Let's consolidate two variables into one enum.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20251115020935.2643121-3-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e5b31d988a41 ("af_unix: Give up GC if MSG_PEEK intervened.")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/garbage.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 9f62d50979735..7528e2db1293f 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -121,8 +121,13 @@ static struct unix_vertex *unix_edge_successor(struct unix_edge *edge)
 	return edge->successor->vertex;
 }
 
-static bool unix_graph_maybe_cyclic;
-static bool unix_graph_grouped;
+enum {
+	UNIX_GRAPH_NOT_CYCLIC,
+	UNIX_GRAPH_MAYBE_CYCLIC,
+	UNIX_GRAPH_CYCLIC,
+};
+
+static unsigned char unix_graph_state;
 
 static void unix_update_graph(struct unix_vertex *vertex)
 {
@@ -132,8 +137,7 @@ static void unix_update_graph(struct unix_vertex *vertex)
 	if (!vertex)
 		return;
 
-	unix_graph_maybe_cyclic = true;
-	unix_graph_grouped = false;
+	unix_graph_state = UNIX_GRAPH_MAYBE_CYCLIC;
 }
 
 static LIST_HEAD(unix_unvisited_vertices);
@@ -536,8 +540,7 @@ static void unix_walk_scc(struct sk_buff_head *hitlist)
 	swap(unix_vertex_unvisited_index, unix_vertex_grouped_index);
 
 	unix_graph_cyclic_sccs = cyclic_sccs;
-	unix_graph_maybe_cyclic = !!unix_graph_cyclic_sccs;
-	unix_graph_grouped = true;
+	unix_graph_state = cyclic_sccs ? UNIX_GRAPH_CYCLIC : UNIX_GRAPH_NOT_CYCLIC;
 }
 
 static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
@@ -570,7 +573,7 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 
 	unix_graph_cyclic_sccs = cyclic_sccs;
-	unix_graph_maybe_cyclic = !!unix_graph_cyclic_sccs;
+	unix_graph_state = cyclic_sccs ? UNIX_GRAPH_CYCLIC : UNIX_GRAPH_NOT_CYCLIC;
 }
 
 static bool gc_in_progress;
@@ -582,14 +585,14 @@ static void __unix_gc(struct work_struct *work)
 
 	spin_lock(&unix_gc_lock);
 
-	if (!unix_graph_maybe_cyclic) {
+	if (unix_graph_state == UNIX_GRAPH_NOT_CYCLIC) {
 		spin_unlock(&unix_gc_lock);
 		goto skip_gc;
 	}
 
 	__skb_queue_head_init(&hitlist);
 
-	if (unix_graph_grouped)
+	if (unix_graph_state == UNIX_GRAPH_CYCLIC)
 		unix_walk_scc_fast(&hitlist);
 	else
 		unix_walk_scc(&hitlist);
-- 
2.53.0




