Return-Path: <stable+bounces-217262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNj5BTOclWmsSgIAu9opvQ
	(envelope-from <stable+bounces-217262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 12:02:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E56155C3F
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 12:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3E4A30268B7
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 11:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C056303A30;
	Wed, 18 Feb 2026 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/+TltNQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAC630596D
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771412513; cv=none; b=J9pkdbLmiJHGaBqlRFftTZZLcoLz5GArbHjSyWjqYVbf4aUmmnLTRwDSRi8Wgf/HTxCUJSCvZt5qrCGpuGGDAqj9jNcXv8d1ag6uGE0R9p+pg5xAapJckAW7noKB0hSquUfnn52XHqZzDw582qAzBYjDpA0qbvIu8Nfb2JURLkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771412513; c=relaxed/simple;
	bh=1bht8Tpqraf9dvK6mi+HcVvYMPfVmAZiLHiDKqSOogY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xpg8Oh59xzVICOUSAvKOOzV+7zgms+oe5FY5raTBfsNUCK3MrSJJFbWb/fxIfhP7j8Ei8Gv2bWmV/GE/Ee8s+94OH5au+aDj0Ec9r6+KZOL4GZJJ4SEi0TM8kbHKWu7MO1Kc+UoNr+IOgdvkneyaKCq4jStyvA4r+fzr8BrthcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/+TltNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E813BC19421;
	Wed, 18 Feb 2026 11:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771412512;
	bh=1bht8Tpqraf9dvK6mi+HcVvYMPfVmAZiLHiDKqSOogY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d/+TltNQ8ORPSrhGXeg2bQTdrS8GNaESKLx+qAHeBox5igvAyIWqDto1u1qtJlA8u
	 XOJ96TecQzizzNqPtl3YEJbyVrgv70a+nZTUx4ScC2EeGaq1sUWdz8lDmfDoqu3Wx4
	 M7uwTR6Mk+onFiLs0uN9WuFk0GW388KFnG6qICo+9KiDJWLvSsV/zj2ap+6p2ZSZa6
	 XiFv6mW/e/0+1K/ssGcvmov2C5DKZe01d6qeAEyt6vlV5QaB8hpo64XVRgRzNthF8O
	 AlcJZV7XSECM/LFGLKd91p280FSo8llhpiocAW3N0147lXBGyF3aXJxGTQNDAVacFQ
	 qVyYSY+lg2IpA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Laurence Oberman <loberman@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Oscar Salvador <osalvador@suse.de>,
	Liu Shixin <liushixin2@huawei.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Lance Yang <lance.yang@linux.dev>,
	"Uschakow, Stanislav" <suschako@amazon.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y 5/6] mm/rmap: fix two comments related to huge_pmd_unshare()
Date: Wed, 18 Feb 2026 12:01:28 +0100
Message-ID: <20260218110129.41578-6-david@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218110129.41578-1-david@kernel.org>
References: <2026012608-tulip-moisten-c6f6@gregkh>
 <20260218110129.41578-1-david@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217262-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,amazon.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,surriel.com:email]
X-Rspamd-Queue-Id: 84E56155C3F
X-Rspamd-Action: no action

From: "David Hildenbrand (Red Hat)" <david@kernel.org>

PMD page table unsharing no longer touches the refcount of a PMD page
table.  Also, it is not about dropping the refcount of a "PMD page" but
the "PMD page table".

Let's just simplify by saying that the PMD page table was unmapped,
consequently also unmapping the folio that was mapped into this page.

This code should be deduplicated in the future.

Link: https://lkml.kernel.org/r/20251223214037.580860-4-david@kernel.org
Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Cc: Liu Shixin <liushixin2@huawei.com>
Cc: Harry Yoo <harry.yoo@oracle.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: "Uschakow, Stanislav" <suschako@amazon.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit a8682d500f691b6dfaa16ae1502d990aeb86e8be)
[ David: We don't have 40549ba8f8e0 ("hugetlb: use new vma_lock
  for pmd sharing synchronization") so there are some contextual
  differences. ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/rmap.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index cb133bd49e02..5093d53f196e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1489,13 +1489,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 							      range.end);
 
 				/*
-				 * The ref count of the PMD page was dropped
-				 * which is part of the way map counting
-				 * is done for shared PMDs.  Return 'true'
-				 * here.  When there is no other sharing,
-				 * huge_pmd_unshare returns false and we will
-				 * unmap the actual page and drop map count
-				 * to zero.
+				 * The PMD table was unmapped,
+				 * consequently unmapping the folio.
 				 */
 				page_vma_mapped_walk_done(&pvmw);
 				break;
@@ -1808,13 +1803,8 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 							      range.end);
 
 				/*
-				 * The ref count of the PMD page was dropped
-				 * which is part of the way map counting
-				 * is done for shared PMDs.  Return 'true'
-				 * here.  When there is no other sharing,
-				 * huge_pmd_unshare returns false and we will
-				 * unmap the actual page and drop map count
-				 * to zero.
+				 * The PMD table was unmapped,
+				 * consequently unmapping the folio.
 				 */
 				page_vma_mapped_walk_done(&pvmw);
 				break;
-- 
2.43.0


