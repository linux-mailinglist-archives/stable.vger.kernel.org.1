Return-Path: <stable+bounces-225859-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBhKM5tAuWmB9QEAu9opvQ
	(envelope-from <stable+bounces-225859-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:52:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D33F92A9449
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6BDD30388AE
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CAF3B4EA8;
	Tue, 17 Mar 2026 11:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjxuhn+S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7F33B3BF0
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748258; cv=none; b=o+GSZ5W+DbVtrRAABpCIAGOpRN2h+Va3C+4ba4GHz2kbcEG0yVNymbAHH5cBaHUrq32gyQqC++q+dar5CccwE3gVIg1AumZ+YOLS0RLUYWScx0mMN0d4DnNV3EdPVCqlOA9RSKiN1NpjLJ1LAvutVSnGZEQ+CwjDbUmbwHYGc2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748258; c=relaxed/simple;
	bh=QVZxWUvyeHggkOVf9TUf/5gSOXj4Q6wVTHhbFkbnodU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfiVko3Sdn6p3KE1Q14+p1RC1gcijOiaJx3E5DUHt8E3HyGLNrKqApsKtcV15dGw3/it2SCFdCLrX2cICuVi8GF66dwcVM/VsnfHhA5br4xaxUNsVS0lZX3CNBAPy9NGfwjwa1PkoBqfmsL9BVel2PMxtGsoLrvivw3q/T2d5jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjxuhn+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC96C2BCB1;
	Tue, 17 Mar 2026 11:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773748258;
	bh=QVZxWUvyeHggkOVf9TUf/5gSOXj4Q6wVTHhbFkbnodU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hjxuhn+SaXYI27o2wxLTfpqNy1gNVF/IjNhU3b8GX8BoAv9UAkafWOXNeOMxS7CnK
	 pUH29wMt7wNLoq12rYc/W/4en3d36PEY6dTio03NNzD2oCKEz03wGG953MjCQgrR/8
	 pvfUXnKkTZTuAECGscXnIVWTWmoX6RWoVdRgh5p4pnRRwLgJ/+F7+eut0PpKdutTNn
	 1kuzu5JqoIRkLXao1wYZMnUMqhza8fhWbEzWycb/K58TluI1/ACDOnB+U7/G4yWlc4
	 +VklsDlJiOQacqgFhsnh1WrJcYk8+E+GggG3v8hykdXCbc0WEEyIFRImgG2zP/ps6n
	 HdH7kdPzw0UdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] mm/page_alloc: sort out the alloc_contig_range() gfp flags mess
Date: Tue, 17 Mar 2026 07:50:52 -0400
Message-ID: <20260317115054.127467-2-sashal@kernel.org>
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
	FREEMAIL_CC(0.00)[redhat.com,nvidia.com,suse.cz,suse.de,csgroup.eu,linux.ibm.com,ellerman.id.au,kernel.org,gmail.com,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-225859-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,suse.cz:email,linux-foundation.org:email,suse.de:email,csgroup.eu:email,ellerman.id.au:email]
X-Rspamd-Queue-Id: D33F92A9449
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Hildenbrand <david@redhat.com>

[ Upstream commit f6037a4a686523dee1967ef7620349822e019ff8 ]

It's all a bit complicated for alloc_contig_range().  For example, we
don't support many flags, so let's start bailing out on unsupported ones
-- ignoring the placement hints, as we are already given the range to
allocate.

While we currently set cc.gfp_mask, in __alloc_contig_migrate_range() we
simply create yet another GFP mask whereby we ignore the reclaim flags
specify by the caller.  That looks very inconsistent.

Let's clean it up, constructing the gfp flags used for
compaction/migration exactly once.  Update the documentation of the
gfp_mask parameter for alloc_contig_range() and alloc_contig_pages().

Link: https://lkml.kernel.org/r/20241203094732.200195-5-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: d155aab90fff ("mm/kfence: fix KASAN hardware tag faults during late enablement")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0bd0784952386..0a0497a3d1109 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6509,7 +6509,7 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
 	int ret = 0;
 	struct migration_target_control mtc = {
 		.nid = zone_to_nid(cc->zone),
-		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+		.gfp_mask = cc->gfp_mask,
 		.reason = MR_CONTIG_RANGE,
 	};
 	struct page *page;
@@ -6605,6 +6605,39 @@ static void split_free_pages(struct list_head *list)
 	}
 }
 
+static int __alloc_contig_verify_gfp_mask(gfp_t gfp_mask, gfp_t *gfp_cc_mask)
+{
+	const gfp_t reclaim_mask = __GFP_IO | __GFP_FS | __GFP_RECLAIM;
+	const gfp_t action_mask = __GFP_COMP | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
+	const gfp_t cc_action_mask = __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
+
+	/*
+	 * We are given the range to allocate; node, mobility and placement
+	 * hints are irrelevant at this point. We'll simply ignore them.
+	 */
+	gfp_mask &= ~(GFP_ZONEMASK | __GFP_RECLAIMABLE | __GFP_WRITE |
+		      __GFP_HARDWALL | __GFP_THISNODE | __GFP_MOVABLE);
+
+	/*
+	 * We only support most reclaim flags (but not NOFAIL/NORETRY), and
+	 * selected action flags.
+	 */
+	if (gfp_mask & ~(reclaim_mask | action_mask))
+		return -EINVAL;
+
+	/*
+	 * Flags to control page compaction/migration/reclaim, to free up our
+	 * page range. Migratable pages are movable, __GFP_MOVABLE is implied
+	 * for them.
+	 *
+	 * Traditionally we always had __GFP_HARDWALL|__GFP_RETRY_MAYFAIL set,
+	 * keep doing that to not degrade callers.
+	 */
+	*gfp_cc_mask = (gfp_mask & (reclaim_mask | cc_action_mask)) |
+			__GFP_HARDWALL | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL;
+	return 0;
+}
+
 /**
  * alloc_contig_range() -- tries to allocate given range of pages
  * @start:	start PFN to allocate
@@ -6613,7 +6646,9 @@ static void split_free_pages(struct list_head *list)
  *			#MIGRATE_MOVABLE or #MIGRATE_CMA).  All pageblocks
  *			in range must have the same migratetype and it must
  *			be either of the two.
- * @gfp_mask:	GFP mask to use during compaction
+ * @gfp_mask:	GFP mask. Node/zone/placement hints are ignored; only some
+ *		action and reclaim modifiers are supported. Reclaim modifiers
+ *		control allocation behavior during compaction/migration/reclaim.
  *
  * The PFN range does not have to be pageblock aligned. The PFN range must
  * belong to a single zone.
@@ -6639,11 +6674,14 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
 		.mode = MIGRATE_SYNC,
 		.ignore_skip_hint = true,
 		.no_set_skip_hint = true,
-		.gfp_mask = current_gfp_context(gfp_mask),
 		.alloc_contig = true,
 	};
 	INIT_LIST_HEAD(&cc.migratepages);
 
+	gfp_mask = current_gfp_context(gfp_mask);
+	if (__alloc_contig_verify_gfp_mask(gfp_mask, (gfp_t *)&cc.gfp_mask))
+		return -EINVAL;
+
 	/*
 	 * What we do here is we mark all pageblocks in range as
 	 * MIGRATE_ISOLATE.  Because pageblock and max order pages may
@@ -6785,7 +6823,9 @@ static bool zone_spans_last_pfn(const struct zone *zone,
 /**
  * alloc_contig_pages() -- tries to find and allocate contiguous range of pages
  * @nr_pages:	Number of contiguous pages to allocate
- * @gfp_mask:	GFP mask to limit search and used during compaction
+ * @gfp_mask:	GFP mask. Node/zone/placement hints limit the search; only some
+ *		action and reclaim modifiers are supported. Reclaim modifiers
+ *		control allocation behavior during compaction/migration/reclaim.
  * @nid:	Target node
  * @nodemask:	Mask for other possible nodes
  *
-- 
2.51.0


