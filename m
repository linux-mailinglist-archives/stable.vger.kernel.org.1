Return-Path: <stable+bounces-263329-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d8CJOHcdMGqsNwUAu9opvQ
	(envelope-from <stable+bounces-263329-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:42:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD92687CE6
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:42:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HbPnp9d4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263329-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263329-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCF6330E0302
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 15:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70EA4071C1;
	Mon, 15 Jun 2026 15:39:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BE3406823
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:39:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537948; cv=none; b=Jo/OoyrdBuKAN6qm06AWFESF9dK5aixNTbizpqA+d+H5SDHLHgsRutv4scPL2fUvd87bnl5hzEYtm3JTm7TZ3pbYQAVh9b2j//LEXaSLro3b/UyCn19LbSe7hZi+9JGPRjtOONa2e1SZlM7JhHQvse/Rzmka22HCxcdAjrIAeO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537948; c=relaxed/simple;
	bh=LyOsnTho+uIfSYCKB15FNWXdG6l95aL0diaAMbC6aVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ba1gM2cOt2cv+gkkxvReKyENXboY1FtmoUlDK1DPpQFB3eGZmwkDZ+jjJ5QK1qQl1brarIyROSSuH72tYz4HgOCwQ48utNgXhvXogoHhRBzIvgLyCstpE0isblstjDb9LN8O/jcY9ZdtSImrSMNLZlY7T1A544d03Wg4NQe/PL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbPnp9d4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA211F00A3A;
	Mon, 15 Jun 2026 15:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781537947;
	bh=R2oIvEWc47WTpl+bLUgAYE7jxNgbdkV1dBsuO+hG1XM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HbPnp9d4QPO+JSQWeMDiqDDT5oW9ro6743hwq6JQ6U5ugRIws0QyVXiMGrRqDAQ6c
	 jOUd/DKQ/3EQnTGSGIbUr4eGnVJ+nROoelKNpWU+T07sgNgAVmwyN8/Kjvn0LfBiVA
	 W+t6nlnwu5VZNONOV4g8X5choHG2axLlHY61enjrCi6GLgtTcT4Gz4mQq47C+LkdzC
	 FRt3pEDjVmqF1N/M8hIUmMbGBrMHUvT11sUP2LbOvhsjaHHC8FdhzZ9CDbGK3XmcQ8
	 uxwKGqMzhz5qPW195uVOzW5c1NOUkPXlYSV8BlXXEg+ADCfNEVbje3wxD2eO5pjNea
	 fz1yE73gbr2lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/5] mm/migrate: don't call folio_putback_active_hugetlb() on dst hugetlb folio
Date: Mon, 15 Jun 2026 11:39:00 -0400
Message-ID: <20260615153903.2214102-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615153903.2214102-1-sashal@kernel.org>
References: <2026061513-untracked-crane-019d@gregkh>
 <20260615153903.2214102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:david@redhat.com,m:baolin.wang@linux.alibaba.com,m:willy@infradead.org,m:muchun.song@linux.dev,m:sidhartha.kumar@oracle.com,m:akpm@linux-foundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263329-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email,infradead.org:email,vger.kernel.org:from_smtp,alibaba.com:email,linux.dev:email,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DD92687CE6

From: David Hildenbrand <david@redhat.com>

[ Upstream commit ba23f58de896842028b4b33b95530f08288396fe ]

We replaced a simple put_page() by a putback_active_hugepage() call in
commit 3aaa76e125c1 ("mm: migrate: hugetlb: putback destination hugepage
to active list"), to set the "active" flag on the dst hugetlb folio.

Nowadays, we decoupled the "active" list from the flag, by calling the
flag "migratable".

Calling "putback" on something that wasn't allocated is weird and not
future proof, especially if we might reach that path when migration failed
and we just want to free the freshly allocated hugetlb folio.

Let's simply handle the migratable flag and the active list flag in
move_hugetlb_state(), where we know that allocation succeeded and already
handle the temporary flag; use a simple folio_put() to return our
reference.

Link: https://lkml.kernel.org/r/20250113131611.2554758-4-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 3c2d42b8ee34 ("mm/memory-failure: fix hugetlb_lock AA deadlock in get_huge_page_for_hwpoison")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 10 ++++++++++
 mm/migrate.c |  8 ++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b0df6ebbf0820d..0c6b34dbe9e133 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7339,6 +7339,16 @@ void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int re
 		}
 		spin_unlock_irq(&hugetlb_lock);
 	}
+
+	/*
+	 * Our old folio is isolated and has "migratable" cleared until it
+	 * is putback. As migration succeeded, set the new folio "migratable"
+	 * and add it to the active list.
+	 */
+	spin_lock_irq(&hugetlb_lock);
+	folio_set_hugetlb_migratable(new_folio);
+	list_move_tail(&new_folio->lru, &(folio_hstate(new_folio))->hugepage_activelist);
+	spin_unlock_irq(&hugetlb_lock);
 }
 
 /*
diff --git a/mm/migrate.c b/mm/migrate.c
index 1d632aa4f526ae..bd3ab46c989c79 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1461,14 +1461,14 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 		list_move_tail(&src->lru, ret);
 
 	/*
-	 * If migration was not successful and there's a freeing callback, use
-	 * it.  Otherwise, put_page() will drop the reference grabbed during
-	 * isolation.
+	 * If migration was not successful and there's a freeing callback,
+	 * return the folio to that special allocator. Otherwise, simply drop
+	 * our additional reference.
 	 */
 	if (put_new_folio)
 		put_new_folio(dst, private);
 	else
-		folio_putback_active_hugetlb(dst);
+		folio_put(dst);
 
 	return rc;
 }
-- 
2.53.0


