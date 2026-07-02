Return-Path: <stable+bounces-270330-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +QfFEbPzRWo/HAsAu9opvQ
	(envelope-from <stable+bounces-270330-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 07:14:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D74726F3871
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 07:14:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=QOBxtron;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270330-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270330-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 517FE300B445
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 05:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784CC36492D;
	Thu,  2 Jul 2026 05:14:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570CB363C6C;
	Thu,  2 Jul 2026 05:14:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782969264; cv=none; b=YuEVKHLEUGXZDHiyEkVoREuSdK0pE3S+bsw+fN+nobzkbZ52RCSECHdalSDNvrPrnfNCBCairgw6AZNhXedhJ6vBQSjC414SEVDYg9r0Jey2B675Qlifwoc+MUdfKJCN2nwN4JRicLlsO+e1/1rdhtwOc4p4KlRyt3Sl7P26x9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782969264; c=relaxed/simple;
	bh=T62Rm8CforrQHCgI1jL51VN6OPOgVlXbC7gVEXEkr9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lv5idwzRr1FLgYyhHo0PV993wIRNU5bF+AvdIwHv7zP3Y64MGJPOM94ec410NKfDpjHEkUOhrMsD/XPgLPzz7AVflFCSL9TF4Ggvu78BkmZD75M+vf0cK7YhFr5B+PgfS7T2WXM8Dr2siCrwaVHtSwQ2a1ExSP5BSOEFrvBshVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QOBxtron; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D6CB3582;
	Wed,  1 Jul 2026 22:14:17 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 218A43F85F;
	Wed,  1 Jul 2026 22:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782969261; bh=T62Rm8CforrQHCgI1jL51VN6OPOgVlXbC7gVEXEkr9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QOBxtronwSwnHmv9SwXu4hDfj37PApl4TlCG0do4RCYGpXUWt4nD5YqM9fmYpV7+8
	 Z0BzPJY/0ZDSSsWbBljm+FgtEHXp0U26TjOlmBTEeL/gukZ7RANUd01Z6J9oyC0xTc
	 4ACwViY/VzUpniG0iOXDyzwZGa6p6YDnhaVNJ4CQ=
From: Dev Jain <dev.jain@arm.com>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	david@kernel.org,
	liam@infradead.org
Cc: Dev Jain <dev.jain@arm.com>,
	riel@surriel.com,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	kas@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	rcampbell@nvidia.com,
	apopple@nvidia.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	j-nomura@ce.jp.nec.com,
	nao.horiguchi@gmail.com,
	ak@linux.intel.com,
	mel@csn.ul.ie,
	pfalcato@suse.de,
	jpoimboe@kernel.org,
	dave.hansen@intel.com,
	tglx@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/6] arm64: make huge_ptep_get handled unaligned addresses
Date: Thu,  2 Jul 2026 05:13:35 +0000
Message-ID: <20260702051341.126509-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702051341.126509-1-dev.jain@arm.com>
References: <20260702051341.126509-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[arm.com,surriel.com,kernel.org,google.com,linux.dev,kvack.org,vger.kernel.org,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,ce.jp.nec.com,linux.intel.com,csn.ul.ie,suse.de,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-270330-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:muchun.song@linux.dev,m:osalvador@suse.de,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:david@kernel.org,m:liam@infradead.org,m:dev.jain@arm.com,m:riel@surriel.com,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:lance.yang@linux.dev,m:kas@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:rcampbell@nvidia.com,m:apopple@nvidia.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:gourry@gourry.net,m:ying.huang@linux.alibaba.com,m:j-nomura@ce.jp.nec.com,m:nao.horiguchi@gmail.com,m:ak@linux.intel.com,m:mel@csn.ul.ie,m:pfalcato@suse.de,m:jpoimboe@kernel.org,m:dave.hansen@intel.com,m:tglx@kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:ryan.roberts@arm.com,m:anshuman.khandual@arm.com,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,m:naohoriguchi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dev.jain@arm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev.jain@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,arm.com:email,arm.com:mid,arm.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D74726F3871

huge_ptep_get() can be handed a virtual address pointing to the middle of
a contpmd/contpte mapped hugetlb folio (examples of callers are
pagemap_hugetlb_range, page_mapped_in_vma).

The arm64 helper rewalks the pgtables in find_num_contig to answer whether
the huge pte we have maps a contpmd or a contpte hugetlb folio, and
returns CONT_PMDS or CONT_PTES, so that it can collect a/d bits over the
contiguous ptes. We can falsely return CONT_PTES instead of CONT_PMDS
if the addr is not aligned.

Fix this by aligning the pmdp pointer down to a contpmd base before
checking equality with the passed huge pte pointer, to correctly answer
whether the huge pte is the base of a contpmd block.

Fixes: 29cb80519689 ("arm64: hugetlb: Cleanup huge_pte size discovery mechanisms")
Cc: stable@vger.kernel.org
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 arch/arm64/mm/hugetlbpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 30772a909aea3..8e799c1fe0aa6 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -87,7 +87,7 @@ static int find_num_contig(struct mm_struct *mm, unsigned long addr,
 	p4dp = p4d_offset(pgdp, addr);
 	pudp = pud_offset(p4dp, addr);
 	pmdp = pmd_offset(pudp, addr);
-	if ((pte_t *)pmdp == ptep) {
+	if ((pte_t *)PTR_ALIGN_DOWN(pmdp, sizeof(*pmdp) * CONT_PMDS) == ptep) {
 		*pgsize = PMD_SIZE;
 		return CONT_PMDS;
 	}
-- 
2.43.0


