Return-Path: <stable+bounces-268357-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JQHtATETPWqswggAu9opvQ
	(envelope-from <stable+bounces-268357-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:38:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 039B46C52F2
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:38:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=HRZxSSoC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268357-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-268357-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 098F2306F7FF
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3EA3DB623;
	Thu, 25 Jun 2026 11:30:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19F53DB63F;
	Thu, 25 Jun 2026 11:30:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782387041; cv=none; b=JU0HNPR7QFZXi4DBuNARWy1X88llFPTmbXn6MS8T78+bTpee+wdXycEGlYKy8evRvV8YAZcUMwpuG6k9O9wJORfC/oJZ1JtpYW/FAUShsmSLnL7II315zk7sWepu5CSvcFiHi/U6tZgCIKPmYebfY5RdtiDSHPRq7N4lj7fOKMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782387041; c=relaxed/simple;
	bh=JOkyYoKGZVws+y2+vmN9YpBtKEwEn/j5yavI9jEFAmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cb+eieWtRGCK6CmtGQWj2pWxQHnD1yLC1jAu/Y5dFyycrDiuUjGez6U6B0xhj5DSx0xHsubeE/oNekDwkmjmLoGJUCJxF07OnYDvvho+9aJ2gLO/VvJkTaKqIHKCd5RjMAjzqDs0VrIfDFN2WwUNEUA1TC/LoW0HL6z0//Y+dPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HRZxSSoC; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4547232AD;
	Thu, 25 Jun 2026 04:30:34 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E0F3A3F62B;
	Thu, 25 Jun 2026 04:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782387038; bh=JOkyYoKGZVws+y2+vmN9YpBtKEwEn/j5yavI9jEFAmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HRZxSSoCdsFKyHQSKFqPXzo5e1bfb1d0NEPHf3RMNJajp0QYStiKg/Vgbi2YEH6yW
	 ZlKHPkn3b0tpmJUQ2jnPfVaAexLjTsDpyaSxTnzsHtlNzCSyzg7/zrcXoAXYy+aJy0
	 IYrPDR1Ax3981AssSUlNsanBGRqoHg66FQ/kJPuI=
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
	mel@csn.ul.ie,
	nao.horiguchi@gmail.com,
	ak@linux.intel.com,
	j-nomura@ce.jp.nec.com,
	pfalcato@suse.de,
	dave.hansen@intel.com,
	tglx@kernel.org,
	jpoimboe@kernel.org,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH 3/5] mm/migrate: use huge_ptep_get() in remove_migration_pte()
Date: Thu, 25 Jun 2026 11:29:52 +0000
Message-ID: <20260625112955.3254283-4-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625112955.3254283-1-dev.jain@arm.com>
References: <20260625112955.3254283-1-dev.jain@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[arm.com,surriel.com,kernel.org,google.com,linux.dev,kvack.org,vger.kernel.org,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,csn.ul.ie,linux.intel.com,ce.jp.nec.com,suse.de];
	TAGGED_FROM(0.00)[bounces-268357-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:muchun.song@linux.dev,m:osalvador@suse.de,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:david@kernel.org,m:liam@infradead.org,m:dev.jain@arm.com,m:riel@surriel.com,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:lance.yang@linux.dev,m:kas@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:rcampbell@nvidia.com,m:apopple@nvidia.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:gourry@gourry.net,m:ying.huang@linux.alibaba.com,m:mel@csn.ul.ie,m:nao.horiguchi@gmail.com,m:ak@linux.intel.com,m:j-nomura@ce.jp.nec.com,m:pfalcato@suse.de,m:dave.hansen@intel.com,m:tglx@kernel.org,m:jpoimboe@kernel.org,m:ryan.roberts@arm.com,m:anshuman.khandual@arm.com,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,m:naohoriguchi@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,arm.com:dkim,arm.com:email,arm.com:mid,arm.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 039B46C52F2

remove_migration_pte() converts migration entries back to present PTEs
after folio migration completes. For hugetlb folios,
page_vma_mapped_walk() returns the pte pointer to the hugetlb folio in
pvmw.pte, but the code reads it with ptep_get().

On arches which provide their own huge_ptep_get() to dereference a huge
pte pointer, accessing via ptep_get() would cause pte_pfn(),
pte_present() etc to misbehave.

It is not clear whether this has a trivially visible effect to userspace.

Use huge_ptep_get() to dereference a huge pte pointer.

Fixes: 290408d4a250 ("hugetlb: hugepage migration core")
Cc: stable@vger.kernel.org
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/migrate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index d9b23909d716c..c65f0f43df7eb 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -371,7 +371,11 @@ static bool remove_migration_pte(struct folio *folio,
 			continue;
 		}
 #endif
-		old_pte = ptep_get(pvmw.pte);
+		if (folio_test_hugetlb(folio))
+			old_pte = huge_ptep_get(vma->vm_mm, pvmw.address,
+						pvmw.pte);
+		else
+			old_pte = ptep_get(pvmw.pte);
 		if (rmap_walk_arg->map_unused_to_zeropage &&
 		    try_to_map_unused_to_zeropage(&pvmw, folio, old_pte, idx))
 			continue;
-- 
2.43.0


