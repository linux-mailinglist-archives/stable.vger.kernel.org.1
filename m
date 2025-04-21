Return-Path: <stable+bounces-134780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC7BA95048
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9374D18883D0
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 11:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10507264626;
	Mon, 21 Apr 2025 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ilrZ0cu+"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5EC2641E9;
	Mon, 21 Apr 2025 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745235416; cv=none; b=kAx44DASJqJ5M57zdjwyckdzrufJYNbUeS2mwTyRs0EB/ODRvpt8ep/7kEH0u3BRqi/e3MVzmuzVMAtYQJMPBs5FDxOj/yC4WomBPwUBy8IjL2JBsK8aay/L2GpSxTyXxVU4L9r/h1RGZeseQp+SFeAxeOhdZD+mobyrlxW92wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745235416; c=relaxed/simple;
	bh=265k6cYt0LmMD0Rv4irIu0Q9OfhUxiLe93SYFcoB1oI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cXMNebjmM5NdIto1H/FhBDBxOZHsbviEo7l4fnANGjxwICDvzoYrMp+F38Cj9VqUWCUGeugyHs3n5Ou8n8eDtiMyFeC4oN9i2JwxIE2co4caIoz/MevL3zlxK5SmC7cygXjhvozeAcYMJO/EU+RW1q9GHDdjlTDwcPJbzGMOMrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ilrZ0cu+; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0WV+sEZDF9ez+F5UP3x6NyJfVwDmxFkP96tBYKSZl4o=; b=ilrZ0cu+qKDNMMbuaROMCgqMxR
	r4q40+hvDmmeRAoyzpE1QjVDb9kO3y7elxwM1KW2Bcrd4/ZexTI/yDtiNGjfKAh0obakQDZE07DHQ
	dQag8oiPnB9hdQ6Fu0kJT7qvILWEc+Zj/enHpkGZdE0lSsnIZehNjiYqbFmW6P/zsQdagI8tJ9LeZ
	f5Gb3XhAvzM//uLqm4wc5+THtZw/InZYxg7+tTtpx68TGVLjDUTcabXfVVPbLJdUT5rAUw7xX/Je4
	4334lCd3ZuJvcBaZ10GauUNLbdnFatUUCfRVlJ7swBAvhqPyljwe2OBxp7EUpgmKS/MDpff3td7dR
	N856rgHg==;
Received: from 114-44-233-154.dynamic-ip.hinet.net ([114.44.233.154] helo=gavin-HP-Z840-Workstation..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1u6pRp-005w62-FG; Mon, 21 Apr 2025 13:36:26 +0200
From: Gavin Guo <gavinguo@igalia.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: gshan@redhat.com,
	david@redhat.com,
	willy@infradead.org,
	ziy@nvidia.com,
	linmiaohe@huawei.com,
	hughd@google.com,
	revest@google.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] mm/huge_memory: fix dereferencing invalid pmd migration entry
Date: Mon, 21 Apr 2025 19:35:36 +0800
Message-ID: <20250421113536.3682201-1-gavinguo@igalia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When migrating a THP, concurrent access to the PMD migration entry
during a deferred split scan can lead to an invalid address access, as
illustrated below. To prevent this invalid access, it is necessary to
check the PMD migration entry and return early. In this context, there
is no need to use pmd_to_swp_entry and pfn_swap_entry_to_page to verify
the equality of the target folio. Since the PMD migration entry is
locked, it cannot be served as the target.

Mailing list discussion and explanation from Hugh Dickins:
"An anon_vma lookup points to a location which may contain the folio of
interest, but might instead contain another folio: and weeding out those
other folios is precisely what the "folio != pmd_folio((*pmd)" check
(and the "risk of replacing the wrong folio" comment a few lines above
it) is for."

BUG: unable to handle page fault for address: ffffea60001db008
CPU: 0 UID: 0 PID: 2199114 Comm: tee Not tainted 6.14.0+ #4 NONE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:split_huge_pmd_locked+0x3b5/0x2b60
Call Trace:
<TASK>
try_to_migrate_one+0x28c/0x3730
rmap_walk_anon+0x4f6/0x770
unmap_folio+0x196/0x1f0
split_huge_page_to_list_to_order+0x9f6/0x1560
deferred_split_scan+0xac5/0x12a0
shrinker_debugfs_scan_write+0x376/0x470
full_proxy_write+0x15c/0x220
vfs_write+0x2fc/0xcb0
ksys_write+0x146/0x250
do_syscall_64+0x6a/0x120
entry_SYSCALL_64_after_hwframe+0x76/0x7e

The bug is found by syzkaller on an internal kernel, then confirmed on
upstream.

Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
Cc: stable@vger.kernel.org
Signed-off-by: Gavin Guo <gavinguo@igalia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Hugh Dickins <hughd@google.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Link: https://lore.kernel.org/all/20250414072737.1698513-1-gavinguo@igalia.com/
Link: https://lore.kernel.org/all/20250418085802.2973519-1-gavinguo@igalia.com/
---
V1 -> V2: Add explanation from Hugh and correct the wording from page
fault to invalid address access.
V2 -> V3: Improve the commit message and the nested if condition.

 mm/huge_memory.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2a47682d1ab7..47d76d03ce30 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3075,6 +3075,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 			   pmd_t *pmd, bool freeze, struct folio *folio)
 {
+	bool pmd_migration = is_pmd_migration_entry(*pmd);
+
 	VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
 	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
 	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
@@ -3085,9 +3087,12 @@ void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 	 * require a folio to check the PMD against. Otherwise, there
 	 * is a risk of replacing the wrong folio.
 	 */
-	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
-	    is_pmd_migration_entry(*pmd)) {
-		if (folio && folio != pmd_folio(*pmd))
+	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) || pmd_migration) {
+		/*
+		 * Do not apply pmd_folio() to a migration entry; and folio lock
+		 * guarantees that it must be of the wrong folio anyway.
+		 */
+		if (folio && (pmd_migration || folio != pmd_folio(*pmd)))
 			return;
 		__split_huge_pmd_locked(vma, pmd, address, freeze);
 	}

base-commit: 9d7a0577c9db35c4cc52db90bc415ea248446472
-- 
2.43.0


