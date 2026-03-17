Return-Path: <stable+bounces-226441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBfVKYuLuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:12:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 077112AF1DF
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC16931AE347
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E413B3F7889;
	Tue, 17 Mar 2026 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AlZm183C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B333F54CD;
	Tue, 17 Mar 2026 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766727; cv=none; b=EXYWRhKkgN/xo7IlHKMEueuFm2sp+mfIaGt84Aco5w3m/DetK6RC8EPMm0rYxxEgFP8Ia4NolvBgzQQdllPvAFNs0RZ3BMtCoJNnIEQmxS1nFLBoZjon5c8foKjkFp7jOBvC9sEs4bXxbxK9CiCaJT5c5a1nXYO1lrL8CZlXYFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766727; c=relaxed/simple;
	bh=xSVz1QpSQwl2wDVT0K9SkECdQVJUNWlY8ULypkFvwDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1U5zZUsBVLXY3uba4GZspeDOZdKY3S0ZFzth3k0xYTtYeVO/PidObwFISKaI9kHqisnz4N/9LFZ/0a6+SCtLOZdl5QGJ+RZ12YeSo+HUQKuGfoBtiXxEnY+8hZnMDy52uOxAFbCg8vyCOADBTkCHHPH7M4huZ9QJEDdQ4Cu3oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AlZm183C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AABC4CEF7;
	Tue, 17 Mar 2026 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766727;
	bh=xSVz1QpSQwl2wDVT0K9SkECdQVJUNWlY8ULypkFvwDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AlZm183CZJC0d0LWFoibX0Odq1E3EhSYvFEy0cElG4Z77JwBQS7r0gruRfzdbWHBx
	 Bmgz8QHQXZ+XH9pFJqm4CTsH8KtmtykOnv44MQ+oPDF8jmPqgJkyViTDG7Fybk0ShB
	 LTcerx3BBcspYYCjjZlTkjVKXzyvqrOduVvn2wJY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Zi Yan <ziy@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Alistair Popple <apopple@nvidia.com>,
	James Houghton <jthoughton@google.com>,
	Piotr Jaroszynski <pjaroszynski@nvidia.com>,
	Balbir Singh <balbirs@nvidia.com>
Subject: [PATCH 6.19 276/378] arm64: contpte: fix set_access_flags() no-op check for SMMU/ATS faults
Date: Tue, 17 Mar 2026 17:33:53 +0100
Message-ID: <20260317163017.161306779@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226441-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,arm.com:email]
X-Rspamd-Queue-Id: 077112AF1DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Piotr Jaroszynski <pjaroszynski@nvidia.com>

commit 97c5550b763171dbef61e6239cab372b9f9cd4a2 upstream.

contpte_ptep_set_access_flags() compared the gathered ptep_get() value
against the requested entry to detect no-ops. ptep_get() ORs AF/dirty
from all sub-PTEs in the CONT block, so a dirty sibling can make the
target appear already-dirty. When the gathered value matches entry, the
function returns 0 even though the target sub-PTE still has PTE_RDONLY
set in hardware.

For a CPU with FEAT_HAFDBS this gathered view is fine, since hardware may
set AF/dirty on any sub-PTE and CPU TLB behavior is effectively gathered
across the CONT range. But page-table walkers that evaluate each
descriptor individually (e.g. a CPU without DBM support, or an SMMU
without HTTU, or with HA/HD disabled in CD.TCR) can keep faulting on the
unchanged target sub-PTE, causing an infinite fault loop.

Gathering can therefore cause false no-ops when only a sibling has been
updated:
 - write faults: target still has PTE_RDONLY (needs PTE_RDONLY cleared)
 - read faults:  target still lacks PTE_AF

Fix by checking each sub-PTE against the requested AF/dirty/write state
(the same bits consumed by __ptep_set_access_flags()), using raw
per-PTE values rather than the gathered ptep_get() view, before
returning no-op. Keep using the raw target PTE for the write-bit unfold
decision.

Per Arm ARM (DDI 0487) D8.7.1 ("The Contiguous bit"), any sub-PTE in a CONT
range may become the effective cached translation and software must
maintain consistent attributes across the range.

Fixes: 4602e5757bcc ("arm64/mm: wire up PTE_CONT for user mappings")
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: stable@vger.kernel.org
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: James Houghton <jthoughton@google.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Piotr Jaroszynski <pjaroszynski@nvidia.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/mm/contpte.c |   53 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -581,6 +581,27 @@ void contpte_clear_young_dirty_ptes(stru
 }
 EXPORT_SYMBOL_GPL(contpte_clear_young_dirty_ptes);
 
+static bool contpte_all_subptes_match_access_flags(pte_t *ptep, pte_t entry)
+{
+	pte_t *cont_ptep = contpte_align_down(ptep);
+	/*
+	 * PFNs differ per sub-PTE. Match only bits consumed by
+	 * __ptep_set_access_flags(): AF, DIRTY and write permission.
+	 */
+	const pteval_t cmp_mask = PTE_RDONLY | PTE_AF | PTE_WRITE | PTE_DIRTY;
+	pteval_t entry_cmp = pte_val(entry) & cmp_mask;
+	int i;
+
+	for (i = 0; i < CONT_PTES; i++) {
+		pteval_t pte_cmp = pte_val(__ptep_get(cont_ptep + i)) & cmp_mask;
+
+		if (pte_cmp != entry_cmp)
+			return false;
+	}
+
+	return true;
+}
+
 int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
 					unsigned long addr, pte_t *ptep,
 					pte_t entry, int dirty)
@@ -590,14 +611,38 @@ int contpte_ptep_set_access_flags(struct
 	int i;
 
 	/*
-	 * Gather the access/dirty bits for the contiguous range. If nothing has
-	 * changed, its a noop.
+	 * Check whether all sub-PTEs in the CONT block already match the
+	 * requested access flags/write permission, using raw per-PTE values
+	 * rather than the gathered ptep_get() view.
+	 *
+	 * __ptep_set_access_flags() can update AF, dirty and write
+	 * permission, but only to make the mapping more permissive.
+	 *
+	 * ptep_get() gathers AF/dirty state across the whole CONT block,
+	 * which is correct for a CPU with FEAT_HAFDBS. But page-table
+	 * walkers that evaluate each descriptor individually (e.g. a CPU
+	 * without DBM support, or an SMMU without HTTU, or with HA/HD
+	 * disabled in CD.TCR) can keep faulting on the target sub-PTE if
+	 * only a sibling has been updated. Gathering can therefore cause
+	 * false no-ops when only a sibling has been updated:
+	 *  - write faults: target still has PTE_RDONLY (needs PTE_RDONLY cleared)
+	 *  - read faults:  target still lacks PTE_AF
+	 *
+	 * Per Arm ARM (DDI 0487) D8.7.1, any sub-PTE in a CONT range may
+	 * become the effective cached translation, so all entries must have
+	 * consistent attributes. Check the full CONT block before returning
+	 * no-op, and when any sub-PTE mismatches, proceed to update the whole
+	 * range.
 	 */
-	orig_pte = pte_mknoncont(ptep_get(ptep));
-	if (pte_val(orig_pte) == pte_val(entry))
+	if (contpte_all_subptes_match_access_flags(ptep, entry))
 		return 0;
 
 	/*
+	 * Use raw target pte (not gathered) for write-bit unfold decision.
+	 */
+	orig_pte = pte_mknoncont(__ptep_get(ptep));
+
+	/*
 	 * We can fix up access/dirty bits without having to unfold the contig
 	 * range. But if the write bit is changing, we must unfold.
 	 */



