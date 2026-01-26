Return-Path: <stable+bounces-211612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPZjDSprd2nCfQEAu9opvQ
	(envelope-from <stable+bounces-211612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:24:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 491FD88C9A
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C408A300461E
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 13:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D60338593;
	Mon, 26 Jan 2026 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t58jwnDc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A97C3385A9
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769433892; cv=none; b=b6qtrSHal9SUvLMBXWqPHJdZwTtGipFzkMBECG6iXwDTBeuwuhLtmEgGicDRJfSvts/YkD9FWPSUsRtWXEkl7kB2mo3A/qTZog+thytG7yzNZqRI3eQdv6nvRWTjx3BWysySOhupYqcETu8VP69MG0XdZi0nTogWYIEV0I0/DWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769433892; c=relaxed/simple;
	bh=3zPDqvmPhA8srtJiAWb+JLeGx+oKblDAaHdKVnbTtqo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=H3IWpmtpxjPQB9oIOtXBYGre6dLVpTBRyZraDovQfT+r/y37GMn9kyozzHhDus/0MiqKfm0UbiGE2bb8qd3tqZ3j5xJBOzN+C5+H9I06QYowW7EPm1mvJFtgO5S1ZvczPJdTu6qlbQcEXvMnjoyKrsZHYGlJ3rax+0OKPSWi4hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t58jwnDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F66AC116C6;
	Mon, 26 Jan 2026 13:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769433892;
	bh=3zPDqvmPhA8srtJiAWb+JLeGx+oKblDAaHdKVnbTtqo=;
	h=Subject:To:Cc:From:Date:From;
	b=t58jwnDcLi/2VOaSvSEeWLncT/4l16KsLtxpnEqHw7giyFhPa/MYjYeXKAUOar7yW
	 bSfeSzN7kJ9s3rSv31KPgxKBL2gldBG6Euea8YXAmd5TKvM33i/p6vp/7092tXQ+yU
	 /0RoyTPqndiS+9JA0tzkeeK060f+2eilVQ+x6Tjc=
Subject: FAILED: patch "[PATCH] mm/hugetlb: fix hugetlb_pmd_shared()" failed to apply to 5.15-stable tree
To: david@kernel.org,akpm@linux-foundation.org,harry.yoo@oracle.com,lance.yang@linux.dev,liushixin2@huawei.com,loberman@redhat.com,lorenzo.stoakes@oracle.com,osalvador@suse.de,riel@surriel.com,stable@vger.kernel.org,suschako@amazon.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Jan 2026 14:24:43 +0100
Message-ID: <2026012643-console-pedigree-feda@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211612-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,suse.de:email,amazon.de:email,oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: 491FD88C9A
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ca1a47cd3f5f4c46ca188b1c9a27af87d1ab2216
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012643-console-pedigree-feda@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ca1a47cd3f5f4c46ca188b1c9a27af87d1ab2216 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Date: Tue, 23 Dec 2025 22:40:34 +0100
Subject: [PATCH] mm/hugetlb: fix hugetlb_pmd_shared()

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

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 019a1c5281e4..03c8725efa28 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1326,7 +1326,7 @@ static inline __init void hugetlb_cma_reserve(int order)
 #ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
 static inline bool hugetlb_pmd_shared(pte_t *pte)
 {
-	return page_count(virt_to_page(pte)) > 1;
+	return ptdesc_pmd_is_shared(virt_to_ptdesc(pte));
 }
 #else
 static inline bool hugetlb_pmd_shared(pte_t *pte)


