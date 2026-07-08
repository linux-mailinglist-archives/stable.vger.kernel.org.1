Return-Path: <stable+bounces-272644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ANFJKgBCTmo9JwIAu9opvQ
	(envelope-from <stable+bounces-272644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 14:26:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D2F7264C0
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 14:26:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=CtaObjrd;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272644-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272644-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5D80309B45E
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 12:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E9E43D50C;
	Wed,  8 Jul 2026 12:21:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B67643C7BC
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 12:20:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513261; cv=none; b=ZLi5DZDRNIBxb/V14fsBm9oNDMdOLyBd2jLk0RGonw4RqFB2eGlRu9XL/hCRitlTj5/i4YYCYdhjGPeyoDbOK5I66d0Ys8WSL0U/eBByNVRJMiRcmHShdLl4dK9Vk+HeJ7dw9BEHO5UaQvS28O1XkCmoMANUYa9gGtiuZDZ3oJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513261; c=relaxed/simple;
	bh=hcfXO1FwHvS4lII212fe7K/4042LkzgU7vpSSEXp+Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPIbtAlGuMVLu7GBqESypL2UJ8NPbLlj0FARLAiMU7/S8EpvzgSspHTo7QhA4FMFHwbuIkLJY3h7vuU+iwxDtnI46wvQBTWhC1X4bBqLOc7SpIpSnfsvTVOwl6fZIX4xIGk/f8cALI94HDKMxBYUnPMQFM2MucPc1+L996z2ZOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CtaObjrd; arc=none smtp.client-ip=91.218.175.173
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783513257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Fn1VOZHGCiDZaYCm98LuGj7iddLxiK8xDaGMUh3nqA=;
	b=CtaObjrdR977XBk5Te7aEsP20O9ZZ1icNmNajWdyd2wpUY/OdU9o0CqFpIc2L3g1OKXtBF
	o5Vy+Rv/QkfN+NdURZyX6kVlf1nGAIIzF4AmBh24KQVSICX6gerC569Cb0Etg4f3HmitjY
	+rF24lBH4avmkC6JF2hd2DODvXvECAc=
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
Subject: [PATCH v2 2/3] mm/madvise: skip device-private PMDs in cold and pageout walks
Date: Wed,  8 Jul 2026 05:20:08 -0700
Message-ID: <20260708122040.861335-3-usama.arif@linux.dev>
In-Reply-To: <20260708122040.861335-1-usama.arif@linux.dev>
References: <20260708122040.861335-1-usama.arif@linux.dev>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272644-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:apopple@nvidia.com,m:balbirs@nvidia.com,m:baohua@kernel.org,m:baolin.wang@linux.alibaba.com,m:byungchul@sk.com,m:david@kernel.org,m:dev.jain@arm.com,m:gourry@gourry.net,m:jannh@google.com,m:joshua.hahnjy@gmail.com,m:lance.yang@linux.dev,m:liam@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:ljs@kernel.org,m:matthew.brost@intel.com,m:npache@redhat.com,m:rakie.kim@sk.com,m:ryan.roberts@arm.com,m:usama.arif@linux.dev,m:vbabka@kernel.org,m:ying.huang@linux.alibaba.com,m:ziy@nvidia.com,m:shakeel.butt@linux.dev,m:hannes@cmpxchg.org,m:sashiko-bot@kernel.org,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[usama.arif@linux.dev,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[linux-foundation.org,nvidia.com,kernel.org,linux.alibaba.com,sk.com,arm.com,gourry.net,google.com,gmail.com,linux.dev,infradead.org,vger.kernel.org,kvack.org,intel.com,redhat.com,cmpxchg.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim,nvidia.com:email,sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45D2F7264C0

madvise_cold_or_pageout_pte_range() takes pmd_trans_huge_lock(), whose
pmd_is_huge() check returns true for a device-private PMD. The subsequent
!pmd_present() branch has a VM_BUG_ON() asserting migration is the only
allowed non-present case; a device-private PMD trips it.

Allow device-private PMDs in that non-present assertion and continue to
huge_unlock before calling pmd_folio(). This keeps the assertion for
unexpected PMD softleafs while skipping device-private PMDs like other
non-present PMDs in this path.

Potential trigger: an HMM-based GPU driver races with
madvise(MADV_COLD)/MADV_PAGEOUT: pmd_trans_huge(*pmd) reads true, then
migrate_vma_pages() flips the PMD to a device-private entry before the
PMD lock is acquired.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260703173903.3789516-1-usama.arif%40linux.dev?part=6
Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
Cc: <stable@vger.kernel.org>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/madvise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 9292f60b19aa..1065b5a84ea7 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -389,7 +389,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 
 		if (unlikely(!pmd_present(orig_pmd))) {
 			VM_BUG_ON(thp_migration_supported() &&
-					!pmd_is_migration_entry(orig_pmd));
+					!pmd_is_migration_entry(orig_pmd) &&
+					!pmd_is_device_private_entry(orig_pmd));
 			goto huge_unlock;
 		}
 
-- 
2.53.0-Meta


