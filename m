Return-Path: <stable+bounces-263444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UqayAbhVMGrrRgUAu9opvQ
	(envelope-from <stable+bounces-263444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 21:42:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F53C68983B
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 21:42:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WG7IGtRY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263444-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263444-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D547F3030D14
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 19:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264363AFAEA;
	Mon, 15 Jun 2026 19:42:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0043AE193
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 19:42:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552561; cv=none; b=UP3gB5wEjlDtnGFtokyH6arDImW3FKwYPEnnVGBUikXYF2MTriolYCBs8kNE0cRFG6GsXq3RaPho2d+iDWI2TFRbVZH5GF2XPTlZjPsNwqNghz3XBgt+RT2aWbdAMNZUnQzztvfADMURon2R8I6gri3cwwdqTZrZfLMBtFEzvWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552561; c=relaxed/simple;
	bh=6EY6dHNugwj19v/skf+xRuBem+7q1FJsNJ0TzgQw07M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gmx3XU0MvytiDKJ03016prUvhNHYCFqIfI9R2ypR2nWsmZeHpJPfdCU/CYqrzP1hw447ivPC+VVmIKO+AabcPL/oG6pM8LigrM6S15M1wiS1BHcMqVT9+QPpG00BibjcSBosc7s3UfFpxsm+55M4ryxmJILZOy7pd0EruHStgtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WG7IGtRY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A9C1F00A3D;
	Mon, 15 Jun 2026 19:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781552560;
	bh=tNPVBI8r8wXoesm9LjwwDbdt86s8NuLupy0hVDpDw2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WG7IGtRYQZ6iXKy4ehgyPIPAohaPSQx1Lc6tXTtTCEkCdwo2HQq0RBvsttDpwGY/E
	 wbC2NHoJ4slWh53ryCSRcIDvMeYpQawOn9Mu/dPRQ2ZmVcfLERqfh5P1gahDd5LsGT
	 XS9C/E2EuL8wKwPfdUT7p3QGlwESg1Rd/aP+eLYL9Oiedr8z+qwbmn3cI1F6fagKep
	 1e0Q/Nr7u8xFCj4Fxrpl+2Zin/PP4eyBcNFH14SXndPYZB4jaO1iRw5DUMb8ynPJU3
	 2p4aS1r0Ijedtqnm6Daik1mvr2LwajgHp7FIvlbsGnDqFaQX3duMDKFQoa8uxuDH2/
	 Y52nyBcW+FlxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] mm/migrate: don't call folio_putback_active_hugetlb() on dst hugetlb folio
Date: Mon, 15 Jun 2026 15:42:34 -0400
Message-ID: <20260615194237.2391157-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615194237.2391157-1-sashal@kernel.org>
References: <2026061514-giblet-unsworn-8735@gregkh>
 <20260615194237.2391157-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:david@redhat.com,m:baolin.wang@linux.alibaba.com,m:willy@infradead.org,m:muchun.song@linux.dev,m:sidhartha.kumar@oracle.com,m:akpm@linux-foundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263444-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,alibaba.com:email,infradead.org:email,linux-foundation.org:email,oracle.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F53C68983B

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
index bde99cd3525784..bac2a00f7dbf08 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7537,6 +7537,16 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 		}
 		spin_unlock_irq(&hugetlb_lock);
 	}
+
+	/*
+	 * Our old page is isolated and has "migratable" cleared until it
+	 * is putback. As migration succeeded, set the new page "migratable"
+	 * and add it to the active list.
+	 */
+	spin_lock_irq(&hugetlb_lock);
+	SetHPageMigratable(newpage);
+	list_move_tail(&newpage->lru, &(page_hstate(newpage))->hugepage_activelist);
+	spin_unlock_irq(&hugetlb_lock);
 }
 
 /*
diff --git a/mm/migrate.c b/mm/migrate.c
index 9271f9dbd352a1..328071b861c368 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1460,14 +1460,14 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 		list_move_tail(&src->lru, ret);
 
 	/*
-	 * If migration was not successful and there's a freeing callback, use
-	 * it.  Otherwise, put_page() will drop the reference grabbed during
-	 * isolation.
+	 * If migration was not successful and there's a freeing callback,
+	 * return the folio to that special allocator. Otherwise, simply drop
+	 * our additional reference.
 	 */
 	if (put_new_page)
 		put_new_page(new_hpage, private);
 	else
-		putback_active_hugepage(new_hpage);
+		folio_put(dst);
 
 	return rc;
 }
-- 
2.53.0


