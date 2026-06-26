Return-Path: <stable+bounces-268727-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ORKTKuv8PWod+AgAu9opvQ
	(envelope-from <stable+bounces-268727-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 06:15:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7F36CA138
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 06:15:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=SuEfzjrA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268727-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268727-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EF4D30500FE
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 04:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7059130C618;
	Fri, 26 Jun 2026 04:15:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE83D175A66
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:15:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782447334; cv=none; b=HnaMNtny2C6JHMiR7CYa9Xt7K3DmPvynWh0KniDex1h87MPnZH2I899aJSDVtuwY/lyV/yyEcqTbouEc4f7L+Bl8yo4JUgJ13ES1ajKnqm4gMngSsH+aZ+5CzcEfmpiOJUg6viH3TaNYLK1RkMicwpCyXV1lYEMBT9sUv5lA6Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782447334; c=relaxed/simple;
	bh=tGr1XVCj+1ijt3qB6qRf0NKuWl5+B3+kUFyoONdCMn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B3+oMk6PtJGwI+y67OeX/9kjuma6U/HwBmhHml3qWuFysp85CUR78yAAOLs7zQOQ17TWEADb8wBYbKWYdiB1wlMlnN83+BAPcG6H/fZarvlbhVk2wgbEQv+TToeilAEZC+GRs4+L9AQ8EARFpwSTMjsKPoUShhI432TVnUlYT9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SuEfzjrA; arc=none smtp.client-ip=54.254.200.128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782447275;
	bh=BA7vdXf55dDOr7FQv2tGiUfuTD8Cf/dE2Nvj3fUyp0c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=SuEfzjrALjlGWEOaa93n525qNnGXK3unbbLwCQJMN+8wk9N3sfEHga0r0ScY/VDWb
	 paWgV1tBbUoSMPC8hiCuPh8uXV0XpXkz0+v/CSivUxrciezk1rzNHT12OqR5MhjtmY
	 p3Z4VtycZ5KiR6HGTubKtgdXNQlpyl/3VPmR/OBc=
X-QQ-mid: zesmtpgz1t1782447272t53b6348b
X-QQ-Originating-IP: jZvK+8v8fzE22D2FWZPclg7CHCI4guiH2PgHftld8qo=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jun 2026 12:14:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11950418412262077908
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	foss+kernel@0leil.net
Cc: stable@vger.kernel.org,
	brauner@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 6.6.y 3/8] eventpoll: split __ep_remove()
Date: Fri, 26 Jun 2026 12:13:58 +0800
Message-Id: <20260626041403.85968-4-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260626041403.85968-1-guanwentao@uniontech.com>
References: <20260626041403.85968-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NIdmeS6o+CORWMS6ANDNY5kR0D7E7GrIDhcONXJSUymoJWbrkxmQyTVk
	2gLxFARTqMUweh7wT8j4Gy3qpHbitedJpCQBb05s7+Bi32DMqyflbOD1im3evwb/7agiBLg
	PgIlssT8drWehC+V8YewoVreHZ3XpB7XwT4i2Au1P+qmXx00CRQ0YHepYGV10Vu8PdGw4JQ
	hvy1qqIHX7d9L9MC5tZk3ZLAhYF0kQPmbHQ32uepz/FGgVpoDT9MjSydIUITxjzXnrwP32/
	fqXdTxW7qkoKS5Qj4zrG/mzZl83dw1EgG+yp/3bLV7fOyX9u0r4Prts12edspItkuhBsdcu
	C9gcdlLQWpRayEmX3RpYem8hSE/WWGhojjzce99NAgZRM+iUJbPjwD5vXVcuGAgxUX59w5N
	bHtuWlxjeU4iu/3IAZ6tevtATvEAJaYgv8Nw4RhYO5SwSrkjoEzBNGB7nRLfckq2sLEa071
	CIUyiGnYOQGRmYtRyfMOqWqHuP4RDWvG7KMOOCWQZAFyotxi2SolYH+1vcb0Brf8KUklOrx
	c29sQMQjoPNoAe5zZiTowHAdSSqi45iXQimnDbIIIAI1P6X++xjqixm8jntYV8uBVVgRdMq
	T1b1whVtkHubWhVsBvkAjqqGo6U9+6cw07YqTv6nPcmz77B27pGGIPCKXT/5EfZ/gdAcWzw
	llU7wkBf1PTBpaDGwHdduX7mVCnA0iuvXW/qu38C2LBiCAD+UMabftoyCAkxKvMsYzt/DR/
	1WQJmsD+99TIU80bywtKGnGLVO1y0LBDAycZjvtlS3p8x/rj9UIvQ3NdSfRDvSewL8dg1Qc
	8q2rDuvMXJXvysO8IOzooG/HIoJzDcPJqqpNU7Uja6C6CL3R6w9gGfrzCaxjBxmFkD4U47t
	yqKKp9Ns900PqOcyTduJWs3FBQHkWi41ztN2eM59ItpbEqxwnHiOrhyzxpU/g5+AzmaDyoX
	TyZus6b5z63xvcAGNZE247QGL/tgyUuKQNGomny9lTYgorWTzE25db1Y5buPcpk5t06dcu1
	pTi/ap4zlHubh4bhBhIR8x2uvps9+pAk1+dSyTRp53x1wE6luP0IUBILCqRTtzvIhlgzUgN
	w45etDQUrcZULSbEgSzFg+f1GSnbuUvzWHowJEacUCp
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268727-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:foss+kernel@0leil.net,m:stable@vger.kernel.org,m:brauner@kernel.org,m:torvalds@linux-foundation.org,m:quentin.schulz@cherry.de,m:foss@0leil.net,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B7F36CA138

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 0f7bdfd413000985de09fc39eb9efa1e091a3ce0 ]

Split __ep_remove() to delineate file removal from epoll item removal.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://patch.msgid.link/20260423-work-epoll-uaf-v1-2-2470f9eec0f5@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 fs/eventpoll.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4f05d12a05031..ae9cb82764482 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -715,6 +715,9 @@ static void ep_free(struct eventpoll *ep)
 	kfree_rcu(ep, rcu);
 }
 
+static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi, struct file *file);
+static bool __ep_remove_epi(struct eventpoll *ep, struct epitem *epi);
+
 /*
  * Removes a "struct epitem" from the eventpoll RB tree and deallocates
  * all the associated resources. Must be called with "mtx" held.
@@ -726,8 +729,6 @@ static void ep_free(struct eventpoll *ep)
 static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 {
 	struct file *file = epi->ffd.file;
-	struct epitems_head *to_free;
-	struct hlist_head *head;
 
 	lockdep_assert_irqs_enabled();
 
@@ -743,8 +744,21 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 		return false;
 	}
 
-	to_free = NULL;
-	head = file->f_ep;
+	__ep_remove_file(ep, epi, file);
+	return __ep_remove_epi(ep, epi);
+}
+
+/*
+ * Called with &file->f_lock held,
+ * returns with it released
+ */
+static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi, struct file *file)
+{
+	struct epitems_head *to_free = NULL;
+	struct hlist_head *head = file->f_ep;
+
+	lockdep_assert_held(&ep->mtx);
+
 	if (hlist_is_singular_node(&epi->fllink, head)) {
 		/* See eventpoll_release() for details. */
 		WRITE_ONCE(file->f_ep, NULL);
@@ -758,6 +772,11 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 	hlist_del_rcu(&epi->fllink);
 	spin_unlock(&file->f_lock);
 	free_ephead(to_free);
+}
+
+static bool __ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
+{
+	lockdep_assert_held(&ep->mtx);
 
 	rb_erase_cached(&epi->rbn, &ep->rbr);
 
-- 
2.30.2



