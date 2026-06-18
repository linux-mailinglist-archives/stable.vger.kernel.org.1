Return-Path: <stable+bounces-267179-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oXKwLeMeNGo7PAYAu9opvQ
	(envelope-from <stable+bounces-267179-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 18:37:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 049FB6A1A2C
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 18:37:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IkKffwhT;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267179-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267179-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D88B3075C1C
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 16:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA39533E351;
	Thu, 18 Jun 2026 16:35:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F8130C153
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 16:35:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781800518; cv=none; b=ubv7w2dAX4SeZoN/hTdkNgjLK4ZkPbAxvoy5Wysew1KOi+WF0nNiB4jAJo9PSKA1l4jHGf+gLfevfGeLYNQyiO14aTZ8QFwnTgQuL9KCG9/65iWNHyfDhbjyGGKz+sftT7fUw0qcuIxVQ/cpv5JTtSBx+V4ua6J7iXQxZLw2+AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781800518; c=relaxed/simple;
	bh=PVL8U/2/TebHkLLz5lm2x0/z5ani/+LNiIl+qvX5FLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gw/r2JM6PY/JRE1Q4ZXM94JonADSWHC2Bjeb7NjTcqPBreM+FWkmv+ZImi3MIn/HR3kEYBG8rtzh3GtM3d9j2S6xzZZ7zsE0W0vS2P6aJI4bf+K+LbVe9JcFtch+glW23DX1Zw5yJ1dks2AQ8JCbGtAWQolqtmse8/9TWHBA50c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkKffwhT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB35D1F00A3F;
	Thu, 18 Jun 2026 16:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781800517;
	bh=mEZ38Ah7thJNMn06RE2NRidSQIpM5KeELyohb03ZcYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IkKffwhTVvtjO6hOyDdhJdIGlzDuJG2hMb3ldjJHEeEFJvxjQWOs4X2h+qhXAHjuh
	 7h13g1e+vojWMkr4VoZEze0SpG8Z4p9WKJJLAN10VKqmbaJfkuE7F/sn+zTuAIwzGj
	 IIrPJyTg+jChE2uK8L1GZ4ATCLBzgGRX+/yaBGQnQ9b8h33GNA0gLoSn0wntg+zwnp
	 QSmx3es0YiHbNCMoDv6N46mDVEBl9Eu+8G+1EKajgqgyRO0D9sSLwGpqafJKKg+EQy
	 DdWQtDAV7ZmY7rz1kdwlnOIcvn/BdLzZNOr+mC3QPPgoQn1RdFts+EjC2JMh9IPH/Y
	 aJlk+Atn95BSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Helen Koike <koike@igalia.com>,
	syzbot+b8ca586b9fc235f0c0df@syzkaller.appspotmail.com,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] debugobjects: Do not fill_pool() if pi_blocked_on
Date: Thu, 18 Jun 2026 12:35:15 -0400
Message-ID: <20260618163515.797362-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061612-blizzard-paced-855b@gregkh>
References: <2026061612-blizzard-paced-855b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267179-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:koike@igalia.com,m:syzbot+b8ca586b9fc235f0c0df@syzkaller.appspotmail.com,m:tglx@kernel.org,m:sashal@kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,b8ca586b9fc235f0c0df];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,igalia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 049FB6A1A2C

From: Helen Koike <koike@igalia.com>

[ Upstream commit 5f41161059fd0f1bbf18c90f3180e38cc45a14eb ]

On RT enabled kernels, fill_pool() ends up calling rtlock_lock(), which
asserts if current::pi_blocked_on is set, because a task can obviously only
block on one lock as otherwise the priority inheritenace chain gets
corrupted.

Prevent this by expanding the conditional to take current::pi_blocked_on
into account.

Fixes: 4bedcc28469a ("debugobjects: Make them PREEMPT_RT aware")
Reported-by: syzbot+b8ca586b9fc235f0c0df@syzkaller.appspotmail.com
Signed-off-by: Helen Koike <koike@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260511215359.3351259-1-koike@igalia.com
Closes: https://syzkaller.appspot.com/bug?extid=b8ca586b9fc235f0c0df
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/debugobjects.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 0b0449ee21aa97..06bef7d6b67010 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -609,9 +609,14 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
 
 	/*
 	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context:
+	 * context and not enqueued on an rt_mutex:
 	 */
+#ifdef CONFIG_RT_MUTEXES
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) ||
+	    (preemptible() && current->pi_blocked_on == NULL))
+#else
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
+#endif
 		fill_pool();
 
 	db = get_bucket((unsigned long) addr);
-- 
2.53.0


