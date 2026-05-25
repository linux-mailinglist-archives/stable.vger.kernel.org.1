Return-Path: <stable+bounces-254062-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAwTEXy5E2r/FAcAu9opvQ
	(envelope-from <stable+bounces-254062-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 04:52:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5345C5755
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 04:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD6423006B33
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 02:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCADD283C82;
	Mon, 25 May 2026 02:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JuRlLaRZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66A3242D6B
	for <stable@vger.kernel.org>; Mon, 25 May 2026 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779677558; cv=none; b=iDs3VQ9eTgzXtTNoeGNrISfIzqChaoswVoZxSCVcboP6WnR8JBP9DCm2mENgMYcaH5SkuahfPW9lMawHelftSUKoiVeO09zGVvT6pRVcYA0Pndg9rpJn7Cu021GICtXYvlNEG8qns011xVhsB4ycwYTP2MRZ1QN9OxHN3mJYX3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779677558; c=relaxed/simple;
	bh=nHQY9QXjiD5On6yyl9oIYY/vSVbNsWlP0beGt1pgmK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V5xWKzwU1sJd6+FF60rMkiUwIfewxSvR9Y1skc5G4wJBsqD7aENfOT8dE/h0jVxmLBBCGXLfo0gac7ByjUrs4rWrR9wj+yn2wJL+uXx2GKMnZmQqHSbE7Xqs7bRCED3xnnHyFRfrko/uoTULaUO6S6hdd2d+aZ/wszFT/kHajKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JuRlLaRZ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba6485d219so69798525ad.3
        for <stable@vger.kernel.org>; Sun, 24 May 2026 19:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1779677556; x=1780282356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj/X4pvgFZcL9zGnArV+92F7pzdoDEC4xvQFc9PbqWU=;
        b=JuRlLaRZu9RrGtX6vdEIFBha03SBU13yk9KeKfJCe7GuqTED8J6ZS2XruybXujww5z
         s2iO6g6hpXp8oG6u7l5KkGc1v7x2EzvAHi4A/aYkK1TG4OAnLN6YjMthAClKtK1mSDgN
         +Py0RcLcAebkDA3JGY3ujUORtthmxb/Gkm+mrBUsoADRSKCVtZ9+/AufbtyWe9h7iOcU
         a0b6EvIWUP3Rh1Mr6sE74epWCG8ymdmqS0nE3p/BdOeraGj1H4LvcSLdp/YoFIt59l/G
         v25lKPOs/fZIfHdbTFv+ZKR8ZSKkeUVboXXHyY8y2NFJVih9lTGiT5YiEw5pf+ic9Fd1
         sKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779677556; x=1780282356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zj/X4pvgFZcL9zGnArV+92F7pzdoDEC4xvQFc9PbqWU=;
        b=rVDHg1eFUw9wbrkI03UEWcSTdW6btoUP3dUKd7Ii7wUQx1H8A1daikjZw4iGeGLu2k
         I3ZkPQWkBJWLYPkVbwedE0NvN0WcaeK0MR6KlG0IR2feNGTTsstULiZFlh0l0V4ee2FL
         WiEygkW/dh6DogaNLDKyy+LUFdlRNNwqCJEGh9TVTdqIRPY13/L8Q+jOK80lauyXhbQf
         DRBNxT+EV8snfAHAIUGM28g6/101NAcYZnGYFb75UbNISAXqBf0EB8zOPTcCga4Q5PwS
         EjydXlXSuUw3Cg/T7AA8vVJEED/TNHEtiFgppQ1OkAlHoqvFEOJ85aJmnIdjOvA/VI3O
         vqnw==
X-Forwarded-Encrypted: i=1; AFNElJ+saCLqXI+5B/7MO8dfy2QEtLoepgsDiFRdzVCu+tR64a7ImvMIBP66/DcldqU/rSR1kV1BrKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn+RlII5LChQl1MMpVKnP5jZv4Bli+OpqD+OiNHYUSt4YKdLRx
	XREl96xWFEtxMRqdZz0iIODrnW5cqqxX1hLhBxL32Mxoq6kkGKj8BNelfeB9geDImzg=
X-Gm-Gg: Acq92OFnHRNP1Jp7hdNl9zx6Y6m3BjSzst0maNgQjR1oeHvTdpTOLUBYlqfkYqkL7WE
	a1UfBVZ1Lu975FofdysWwFmRjakvBq2iW1R09bq8MZ/EkSvPXaunTYKK0xDJApadBitJPJVE3JO
	FuLRwWXQjSqQ9B6KVj815TjtUGAET/xiP4HideiQ2pzdjZwHCmdyJZykZqaat+gcIX23ImzE0zD
	NhvOlH+CCAg9X5rSEJrBl2j3w2llxNbAiwi9Rik5DluTc1di5KQ+fEB9v++4bZkuB3/ugvsa0Zw
	+5mi5MATl9jkNFe/WJypVF4H+DZlDAejS7fplCXkj7GKcY0lk/1EW/FPcMDTHoj90g5xImqX4pt
	qZZE5tQQYOQgQBpbHMO0J7T5sFoF/cYQrbSD9LzikRyfxCGBXKLOHiC9H9dXNyAkkf4RzoFihPP
	E3R3C8J/EMfMQyWz5Zo2TdYMdk3WIi
X-Received: by 2002:a17:903:3c6d:b0:2b7:86be:7673 with SMTP id d9443c01a7336-2beb0366450mr131723115ad.6.1779677555752;
        Sun, 24 May 2026 19:52:35 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::347])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695f54sm80182155ad.10.2026.05.24.19.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 19:52:34 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm/hugetlb_vmemmap: fix incorrect vmemmap restore in rollback
Date: Mon, 25 May 2026 10:52:13 +0800
Message-ID: <20260525025213.2229628-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bytedance.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254062-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[songmuchun@bytedance.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bytedance.com:email,bytedance.com:mid,bytedance.com:dkim]
X-Rspamd-Queue-Id: 9E5345C5755
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

vmemmap_restore_pte() rebuilds restored vmemmap pages from a
tail-page template derived from compound_head(). This is wrong when the
current PTE already maps a page whose contents are not tail-page
metadata.

In the rollback path of vmemmap_remap_free(), the first restored PTE is
backed by vmemmap_head and contains head-page metadata. Reconstructing
that page from a tail-page template overwrites the head-page state and
corrupts the restored vmemmap page.

Fix this by copying the full page from the page currently mapped by the
PTE. Also pass vmemmap_tail to the rollback walk so only PTEs backed by
the shared tail page are restored, while the head PTE remains mapped to
vmemmap_head. Add VM_WARN_ON_ONCE() checks for unexpected cases.

Fixes: c0b495b91a47 ("mm/hugetlb: refactor code around vmemmap_walk")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4a077d231d3a..133b46dfb09f 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -207,6 +207,8 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
 
 	/* Remapping the head page requires r/w */
 	if (unlikely(walk->nr_walked == 0 && walk->vmemmap_head)) {
+		VM_WARN_ON_ONCE(!PageHead((const struct page *)addr));
+
 		list_del(&walk->vmemmap_head->lru);
 
 		/*
@@ -218,6 +220,8 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
 
 		entry = mk_pte(walk->vmemmap_head, PAGE_KERNEL);
 	} else {
+		VM_WARN_ON_ONCE(!PageTail((const struct page *)addr));
+
 		/*
 		 * Remap the tail pages as read-only to catch illegal write
 		 * operation to the tail pages.
@@ -232,33 +236,28 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
 static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
 				struct vmemmap_remap_walk *walk)
 {
-	struct page *page;
-	struct page *from, *to;
-
-	page = list_first_entry(walk->vmemmap_pages, struct page, lru);
-	list_del(&page->lru);
+	struct page *src = pte_page(ptep_get(pte)), *dst;
 
 	/*
-	 * Initialize tail pages in the newly allocated vmemmap page.
-	 *
-	 * There is folio-scope metadata that is encoded in the first few
-	 * tail pages.
-	 *
-	 * Use the value last tail page in the page with the head page
-	 * to initialize the rest of tail pages.
+	 * When rolling back vmemmap_remap_free(), keep the copied head page
+	 * mapping and restore only PTEs currently pointing at the shared tail
+	 * page.
 	 */
-	from = compound_head((struct page *)addr) +
-		PAGE_SIZE / sizeof(struct page) - 1;
-	to = page_to_virt(page);
-	for (int i = 0; i < PAGE_SIZE / sizeof(struct page); i++, to++)
-		*to = *from;
+	if (walk->vmemmap_tail && walk->vmemmap_tail != src)
+		return;
+
+	VM_WARN_ON_ONCE(PageHead((const struct page *)addr));
+
+	dst = list_first_entry(walk->vmemmap_pages, struct page, lru);
+	list_del(&dst->lru);
+	copy_page(page_to_virt(dst), page_to_virt(src));
 
 	/*
 	 * Makes sure that preceding stores to the page contents become visible
 	 * before the set_pte_at() write.
 	 */
 	smp_wmb();
-	set_pte_at(&init_mm, addr, pte, mk_pte(page, PAGE_KERNEL));
+	set_pte_at(&init_mm, addr, pte, mk_pte(dst, PAGE_KERNEL));
 }
 
 /**
@@ -324,6 +323,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 	 */
 	walk = (struct vmemmap_remap_walk) {
 		.remap_pte	= vmemmap_restore_pte,
+		.vmemmap_tail	= vmemmap_tail,
 		.vmemmap_pages	= vmemmap_pages,
 		.flags		= 0,
 	};

base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
-- 
2.54.0


