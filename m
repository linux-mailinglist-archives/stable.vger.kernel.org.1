Return-Path: <stable+bounces-217290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF0aBU25lWm7UQIAu9opvQ
	(envelope-from <stable+bounces-217290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 14:06:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 468C8156826
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 14:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34DE53013EED
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 13:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CFA306483;
	Wed, 18 Feb 2026 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m97p7nOa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457B92FDC3C
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771419978; cv=none; b=UroLMPnTxD4Xq/WTMXweoyI0XplNDOh3I9KWR+gK/D/hxyCD6rH752Fo5yrdYNe6laX9nO0fQO5tQK8GXdfSSlvGNb27SQ/DL4UqkRpIIh7jPDVLH/7lSRywiFVMGe9Vpn9BCUNXgZT9vgnTEwIZNfv1qY/Z+GDyuHI6c1/AAwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771419978; c=relaxed/simple;
	bh=3UR3t12nE06/3+BICKDW7qlGeal7dZwuKx3i2LXcI6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCFe/jbRCSS1erakVHGknfAcMjoQgfMtPxW4F//paLaHk/X05s0xiB8dRe31nwBZqd7fGVyO+HvRtjLLtKl9zouCEOJ59rAhmIfoP722/K5hkwynTvAagO7hZPArk5DLDL8aD6dnaX/h6Hc5iN6SRbmOwpLcV03nVK5f2kxQZeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m97p7nOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3730FC19425;
	Wed, 18 Feb 2026 13:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771419977;
	bh=3UR3t12nE06/3+BICKDW7qlGeal7dZwuKx3i2LXcI6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m97p7nOa4g/xsSww4ztleeUUfP0xoVMiDxpuIpsRdIxsZQVXeH6SafI4ggN8Ut3UE
	 V9qxQkYxadQx7jLe/bvKCMJaEYspRP43szn4B9MD/ODIgEeplm35Jjb4q9wccVHsb/
	 1Dd0bjp8bwRXPYEII+Ulcydb/fJQ+NzMYlF40KgFvz24cwJidnXfmvLJ48Ml4qoAom
	 lST7uoqOqwYvhSyOUhz6G1v2sb7teLO1dCVyFnPXqOPRWlGQYbFiw2VY30DBNH9G+c
	 PhfeLwn5xmSwbutRwhLTfCfrH2ZOhifLUiax08h68KCSU7lFmMnXudfkArIAUcagY8
	 NggmtlIkQzX9g==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jane Chu <jane.chu@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Oscar Salvador <osalvador@suse.de>,
	Jann Horn <jannh@google.com>,
	Liu Shixin <liushixin2@huawei.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rik van Riel <riel@surriel.com>,
	Laurence Oberman <loberman@redhat.com>,
	Lance Yang <lance.yang@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	James Houghton <jthoughton@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH 5.10.y 4/7] mm/hugetlb: fix hugetlb_pmd_shared()
Date: Wed, 18 Feb 2026 14:05:49 +0100
Message-ID: <20260218130552.55727-5-david@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218130552.55727-1-david@kernel.org>
References: <2026012610-absolve-ducktail-3c64@gregkh>
 <20260218130552.55727-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217290-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,linux.dev:email,suse.de:email,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amazon.de:email]
X-Rspamd-Queue-Id: 468C8156826
X-Rspamd-Action: no action

From: "David Hildenbrand (Red Hat)" <david@kernel.org>

Patch series "mm/hugetlb: fixes for PMD table sharing (incl.  using
mmu_gather)", v3.

One functional fix, one performance regression fix, and two related
comment fixes.

I cleaned up my prototype I recently shared [1] for the performance fix,
deferring most of the cleanups I had in the prototype to a later point.
While doing that I identified the other things.

The goal of this patch set is to be backported to stable trees "fairly"
easily. At least patch #1 and #4.

Patch #1 fixes hugetlb_pmd_shared() not detecting any sharing
Patch #2 + #3 are simple comment fixes that patch #4 interacts with.
Patch #4 is a fix for the reported performance regression due to excessive
IPI broadcasts during fork()+exit().

The last patch is all about TLB flushes, IPIs and mmu_gather.
Read: complicated

There are plenty of cleanups in the future to be had + one reasonable
optimization on x86. But that's all out of scope for this series.

Runtime tested, with a focus on fixing the performance regression using
the original reproducer [2] on x86.

This patch (of 4):

We switched from (wrongly) using the page count to an independent shared
count.  Now, shared page tables have a refcount of 1 (excluding
speculative references) and instead use ptdesc->pt_share_count to identify
sharing.

We didn't convert hugetlb_pmd_shared(), so right now, we would never
detect a shared PMD table as such, because sharing/unsharing no longer
touches the refcount of a PMD table.

Page migration, like mbind() or migrate_pages() would allow for migrating
folios mapped into such shared PMD tables, even though the folios are not
exclusive.  In smaps we would account them as "private" although they are
"shared", and we would be wrongly setting the PM_MMAP_EXCLUSIVE in the
pagemap interface.

Fix it by properly using ptdesc_pmd_is_shared() in hugetlb_pmd_shared().

Link: https://lkml.kernel.org/r/20251223214037.580860-1-david@kernel.org
Link: https://lkml.kernel.org/r/20251223214037.580860-2-david@kernel.org
Link: https://lore.kernel.org/all/8cab934d-4a56-44aa-b641-bfd7e23bd673@kernel.org/ [1]
Link: https://lore.kernel.org/all/8cab934d-4a56-44aa-b641-bfd7e23bd673@kernel.org/ [2]
Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Tested-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Cc: Liu Shixin <liushixin2@huawei.com>
Cc: Uschakow, Stanislav" <suschako@amazon.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit ca1a47cd3f5f4c46ca188b1c9a27af87d1ab2216)
[ David: We don't have ptdesc and the wrappers, so work directly on
  page->pt_share_count. ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/hugetlb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1c03935aa3d1..0d3fece27031 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -955,7 +955,7 @@ static inline __init void hugetlb_cma_check(void)
 #ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
 static inline bool hugetlb_pmd_shared(pte_t *pte)
 {
-	return page_count(virt_to_page(pte)) > 1;
+	return atomic_read(&virt_to_page(pte)->pt_share_count);
 }
 #else
 static inline bool hugetlb_pmd_shared(pte_t *pte)
-- 
2.43.0


