Return-Path: <stable+bounces-225860-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uN4UHZ5AuWmB9QEAu9opvQ
	(envelope-from <stable+bounces-225860-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:53:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C19832A9451
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC14D3038D72
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB1D3B4E98;
	Tue, 17 Mar 2026 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RL00PGsN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE193B4EB2
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748260; cv=none; b=eQf85gDZz4HtJ4GM1agQcPsfyjzo2oQkV6fiPJOki7ytrt7YjtN1sOqWR88nVcgXyVQ5Os7Wj4fmwEh1j2qIXmX/YlqOpeC23YcGFt2psSAlnu2vE+IOdesfCnyBUo5FTmweQkDvCxT9pG2vO5v5ZkATQvpCtvcjvP6mbh1PEeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748260; c=relaxed/simple;
	bh=9rKTbtBi8O48e/OJDLBjKC8j+5ncwQVcLbs5A0gqnfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SP2O09sMSvuD/aniTtEYZbccX3plkdCgSpKNqg2GGoAH0eOTdnis15e6+3GypEr502LerhyLMHSO9Il/gxpRn2wg1XpHFaUwz8aviejbAkQ1l+71g7MpRXA4+TbBmqevlALObFVaCJN9u/1yLVRxWFeEoASBF7UBIESdNkPNNew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RL00PGsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B40C2BCAF;
	Tue, 17 Mar 2026 11:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773748260;
	bh=9rKTbtBi8O48e/OJDLBjKC8j+5ncwQVcLbs5A0gqnfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RL00PGsNmYCivdTjYbJx/Jt02o0EH5qAJZ+lTTKsTDgBP/+HMVMPRbvCsUGMmGsPD
	 PMyOflwpc0b0IJDSPLgsZCbfb4LYZtDQcLV8/PvLTrumU1fDHyMN794wPFhP6OJGQq
	 rRqv1j7TP5CmHhBo0YMA19UwPdxTBkKpxeGaLz0h/rNtMf38wuYCXxTR+N4IOztiSP
	 fbyfqe9oxq5AdeNyB6kfXHnis/DEzlFqfk3Hsp+3+AEM7VstlGA9f/bJYvjqilD2wI
	 8UrqrkgZmQ6ZaN053PeGSrAySx49L+0eumMYsXo+4xd4aBFfEBVSOQSsS1G15kkW73
	 YewV0z1UI5QNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] mm/page_alloc: forward the gfp flags from alloc_contig_range() to post_alloc_hook()
Date: Tue, 17 Mar 2026 07:50:53 -0400
Message-ID: <20260317115054.127467-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317115054.127467-1-sashal@kernel.org>
References: <2026031724-slimness-shell-ed87@gregkh>
 <20260317115054.127467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,suse.cz,suse.de,csgroup.eu,linux.ibm.com,ellerman.id.au,kernel.org,gmail.com,nvidia.com,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-225860-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,linux-foundation.org:email,suse.de:email,ellerman.id.au:email,csgroup.eu:email]
X-Rspamd-Queue-Id: C19832A9451
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 7b755570064fcb9cde37afd48f6bc65151097ba7 ]

In the __GFP_COMP case, we already pass the gfp_flags to
prep_new_page()->post_alloc_hook().  However, in the !__GFP_COMP case, we
essentially pass only hardcoded __GFP_MOVABLE to post_alloc_hook(),
preventing some action modifiers from being effective..

Let's pass our now properly adjusted gfp flags there as well.

This way, we can now support __GFP_ZERO for alloc_contig_*().

As a side effect, we now also support __GFP_SKIP_ZERO and__GFP_ZEROTAGS;
but we'll keep the more special stuff (KASAN, NOLOCKDEP) disabled for now.

It's worth noting that with __GFP_ZERO, we might unnecessarily zero pages
when we have to release part of our range using free_contig_range() again.
This can be optimized in the future, if ever required; the caller we'll
be converting (powernv/memtrace) next won't trigger this.

Link: https://lkml.kernel.org/r/20241203094732.200195-6-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: d155aab90fff ("mm/kfence: fix KASAN hardware tag faults during late enablement")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0a0497a3d1109..6eff98b22b3b6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6579,7 +6579,7 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
 	return (ret < 0) ? ret : 0;
 }
 
-static void split_free_pages(struct list_head *list)
+static void split_free_pages(struct list_head *list, gfp_t gfp_mask)
 {
 	int order;
 
@@ -6590,7 +6590,7 @@ static void split_free_pages(struct list_head *list)
 		list_for_each_entry_safe(page, next, &list[order], lru) {
 			int i;
 
-			post_alloc_hook(page, order, __GFP_MOVABLE);
+			post_alloc_hook(page, order, gfp_mask);
 			set_page_refcounted(page);
 			if (!order)
 				continue;
@@ -6608,7 +6608,8 @@ static void split_free_pages(struct list_head *list)
 static int __alloc_contig_verify_gfp_mask(gfp_t gfp_mask, gfp_t *gfp_cc_mask)
 {
 	const gfp_t reclaim_mask = __GFP_IO | __GFP_FS | __GFP_RECLAIM;
-	const gfp_t action_mask = __GFP_COMP | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
+	const gfp_t action_mask = __GFP_COMP | __GFP_RETRY_MAYFAIL | __GFP_NOWARN |
+				  __GFP_ZERO | __GFP_ZEROTAGS | __GFP_SKIP_ZERO;
 	const gfp_t cc_action_mask = __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
 
 	/*
@@ -6756,7 +6757,7 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
 	}
 
 	if (!(gfp_mask & __GFP_COMP)) {
-		split_free_pages(cc.freepages);
+		split_free_pages(cc.freepages, gfp_mask);
 
 		/* Free head and tail (if any) */
 		if (start != outer_start)
-- 
2.51.0


