Return-Path: <stable+bounces-152684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26B6ADA668
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 04:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BA93AECC7
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 02:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1BE1DE2D8;
	Mon, 16 Jun 2025 02:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qAvm0dxt"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B121E1BF58
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750041621; cv=none; b=oVoKib4GwPS+8ka1wYe61/6DPFkemtHNs+mdC+Plykz50DMz41SlEirpG1OKz3+BwlNvxsJoofG7ECgm0HqYGJQw9kg//LZ2fHgn+2kCLgz3dPsCG8iOJwdwUfgHMtu8Wikzi5rSUS3ugd6tosgWBsN2TjouEoeYeabqxY5WDU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750041621; c=relaxed/simple;
	bh=8TKnp2sgzfyisx6FU82pbX312kpI4nd34aS5f067AC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixCPRZA9AZHsqN0mg3/zssi6GDlqWrSAhm8s8RbrXph8UaDRPN6OLC9xX58CHee1X/stXgjf2CULyEwSks9/catSK/igMf3sGvHbGTGwhQpHfffgt3vES9NNIlyTW+OWeoIlBl5tuxrLFV0DdAgtGn7iEk9CxlOyWYZ3sHlh9R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qAvm0dxt; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=McC4Cl3TPrTTq+jkKam6e8eYltYxhxRm7nj5/fsGivU=; b=qAvm0dxt0oIVamIL9ZJjjXlQV2
	iMN2cPfX84M+ROBmdHfL3qWTZOreiUMdNl0b56dG6Uc0U7PfHMJobyj6HbDvC8DzhDpLOwal8ABlN
	/0W8X9dGTYOQjUKO4nuwoclrRU6tuBS0iZ8/pEQCSP/8VUnY//NkbRiiSwV4nOAW0OTQMewCcaRmK
	WXVW5geHH9SgOAhCObfPE2XhbYvI/E4UVpEArTxLqWU7zhVeVE4EuJWsMqBuUT/jeYCkhRNEIgOsM
	qD/Reqx+0RhPbMRdmz6iUn+e5SUuT+yBx+zShKJFMCU5Zp1CKnqF8QNZ+1o0P2Rm7PifwZ9JuQsLt
	qnObPBnA==;
Received: from 114-44-254-110.dynamic-ip.hinet.net ([114.44.254.110] helo=gavin-HP-Z840-Workstation..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uQzlX-003vWJ-Oj; Mon, 16 Jun 2025 04:40:08 +0200
From: Gavin Guo <gavinguo@igalia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Gavin Shan <gshan@redhat.com>,
	Florent Revest <revest@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	stable@vger.kernel.org
Subject: [PATCH 5.10.y] mm/huge_memory: fix dereferencing invalid pmd migration entry
Date: Mon, 16 Jun 2025 10:40:00 +0800
Message-ID: <20250616024000.1781230-1-gavinguo@igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025051205-work-bronze-e167@gregkh>
References: <2025051205-work-bronze-e167@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit be6e843fc51a584672dfd9c4a6a24c8cb81d5fb7 ]

When migrating a THP, concurrent access to the PMD migration entry during
a deferred split scan can lead to an invalid address access, as
illustrated below.  To prevent this invalid access, it is necessary to
check the PMD migration entry and return early.  In this context, there is
no need to use pmd_to_swp_entry and pfn_swap_entry_to_page to verify the
equality of the target folio.  Since the PMD migration entry is locked, it
cannot be served as the target.

Mailing list discussion and explanation from Hugh Dickins: "An anon_vma
lookup points to a location which may contain the folio of interest, but
might instead contain another folio: and weeding out those other folios is
precisely what the "folio != pmd_folio((*pmd)" check (and the "risk of
replacing the wrong folio" comment a few lines above it) is for."

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

Link: https://lkml.kernel.org/r/20250421113536.3682201-1-gavinguo@igalia.com
Link: https://lore.kernel.org/all/20250414072737.1698513-1-gavinguo@igalia.com/
Link: https://lore.kernel.org/all/20250418085802.2973519-1-gavinguo@igalia.com/
Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
Signed-off-by: Gavin Guo <gavinguo@igalia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Hugh Dickins <hughd@google.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Cc: Florent Revest <revest@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[gavin: backport the migration checking logic to __split_huge_pmd]
Signed-off-by: Gavin Guo <gavinguo@igalia.com>
---
 mm/huge_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e4c690c21fc9..24565c2cbc6e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2227,7 +2227,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	VM_BUG_ON(freeze && !page);
 	if (page) {
 		VM_WARN_ON_ONCE(!PageLocked(page));
-		if (page != pmd_page(*pmd))
+		if (is_pmd_migration_entry(*pmd) || page != pmd_page(*pmd))
 			goto out;
 	}
 
@@ -2262,7 +2262,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		}
 		if (PageMlocked(page))
 			clear_page_mlock(page);
-	} else if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
+	} else if (!pmd_devmap(*pmd))
 		goto out;
 	__split_huge_pmd_locked(vma, pmd, range.start, freeze);
 out:

base-commit: 01e7e36b8606e5d4fddf795938010f7bfa3aa277
-- 
2.43.0


