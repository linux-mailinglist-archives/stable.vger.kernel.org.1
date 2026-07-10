Return-Path: <stable+bounces-273194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SRsIO+XPUGqM5QIAu9opvQ
	(envelope-from <stable+bounces-273194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 12:56:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D74739E3C
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 12:56:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=bmuMWEqB;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273194-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-273194-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23D77300E17C
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 10:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B1B40B362;
	Fri, 10 Jul 2026 10:56:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9B0404BF7
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 10:56:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680993; cv=none; b=MF8jDvxKWv1zrWc/B9FCQHqBWgTNXcK3T18vsrQQjVkmcgA+KKnfjPBzAIl0cuLOoyOi16OmbNkhDQA1bpI3MVKvC1wpqisCi+z8wK/LKvKW3NTZcJH9yBKW5neHsoGBbLDm1R7C79V7xcGGxQ/lWx0Kf6tnQRSNuskJ9TCrIT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680993; c=relaxed/simple;
	bh=vYqCA5l4YYyso/Zv6g8ueWerNWkYhpLDNjGM/O+OJQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heiVy5yM3TpGpL0/a2AeuGzpiF+Kmm2cpVTVYGzPJPaObcYQ52eRZTZJB8byEdDZsgKYyHVC3ozACnFLnhmGmzur96WLO5RDIqA/VmPRjU9NKGxhpd/YO8c+csdArPoD38FqqahLrpHhB17IbYuBNz48KtahJHaVAUorQG0SDZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bmuMWEqB; arc=none smtp.client-ip=95.215.58.182
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783680989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJFhjNRrGWhFd4/UKA3CK1oa3jEQdlfP2tw+6VJV9xw=;
	b=bmuMWEqByFKDrkHgq9LDQ6o45YZlph9ybTzEW8i06SsYucuVvujsPEGBhDUpbjqtdhsKfL
	jhwH5WR8sqYPFgztSmKHzp0vKZBjKMZpxrZHRBlZp3njKcJL/ax8+eKpsEOYAEIe0qumbn
	AFi3rsYxug8QgbCe+Ffc0PToTIGkSeM=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	apopple@nvidia.com,
	balbirs@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	byungchul@sk.com,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	lance.yang@linux.dev,
	liam@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	matthew.brost@intel.com,
	npache@redhat.com,
	rakie.kim@sk.com,
	ryan.roberts@arm.com,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org
Cc: sashiko-bot <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] mm/mempolicy: skip non-present PMDs when queueing folios
Date: Fri, 10 Jul 2026 03:55:21 -0700
Message-ID: <20260710105557.1987433-2-usama.arif@linux.dev>
In-Reply-To: <20260710105557.1987433-1-usama.arif@linux.dev>
References: <20260710105557.1987433-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:apopple@nvidia.com,m:balbirs@nvidia.com,m:baohua@kernel.org,m:baolin.wang@linux.alibaba.com,m:byungchul@sk.com,m:david@kernel.org,m:dev.jain@arm.com,m:gourry@gourry.net,m:jannh@google.com,m:joshua.hahnjy@gmail.com,m:lance.yang@linux.dev,m:liam@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:ljs@kernel.org,m:matthew.brost@intel.com,m:npache@redhat.com,m:rakie.kim@sk.com,m:ryan.roberts@arm.com,m:usama.arif@linux.dev,m:vbabka@kernel.org,m:ying.huang@linux.alibaba.com,m:ziy@nvidia.com,m:shakeel.butt@linux.dev,m:hannes@cmpxchg.org,m:sashiko-bot@kernel.org,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[linux-foundation.org,nvidia.com,kernel.org,linux.alibaba.com,sk.com,arm.com,gourry.net,google.com,gmail.com,linux.dev,infradead.org,vger.kernel.org,kvack.org,intel.com,redhat.com,cmpxchg.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER(0.00)[usama.arif@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273194-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5D74739E3C

queue_folios_pmd() is called under pmd_trans_huge_lock(), whose
pmd_is_huge() check returns true for any non-present, non-none PMD
softleaf. Passing such a PMD to pmd_folio() treats the softleaf encoding
as a hardware PFN and can return a bogus folio pointer.

Mirror queue_folios_pte_range(): handle non-present entries before
looking up a folio. Keep migration entries counted as failures, but skip
other non-present PMDs such as device-private entries.

Potential trigger: an HMM-based GPU driver migrates an anonymous THP
folio to device memory via migrate_vma_pages(), leaving a device-private
PMD. Userspace then calls mbind(), migrate_pages() or
set_mempolicy_home_node() on that range.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260703173903.3789516-1-usama.arif%40linux.dev?part=6
Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
Cc: <stable@vger.kernel.org>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/mempolicy.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 914f81863db5..69a00a324ef5 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -654,12 +654,14 @@ static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
 {
 	struct folio *folio;
 	struct queue_pages *qp = walk->private;
+	pmd_t pmdval = pmdp_get(pmd);
 
-	if (unlikely(pmd_is_migration_entry(*pmd))) {
-		qp->nr_failed++;
+	if (unlikely(!pmd_present(pmdval))) {
+		if (pmd_is_migration_entry(pmdval))
+			qp->nr_failed++;
 		return;
 	}
-	folio = pmd_folio(*pmd);
+	folio = pmd_folio(pmdval);
 	if (is_huge_zero_folio(folio)) {
 		walk->action = ACTION_CONTINUE;
 		return;
-- 
2.53.0-Meta


