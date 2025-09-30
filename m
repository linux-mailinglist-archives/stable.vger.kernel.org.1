Return-Path: <stable+bounces-182019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23890BAB60F
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 06:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 716AC7A4369
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 04:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912712248B9;
	Tue, 30 Sep 2025 04:36:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921862CCC5
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 04:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759206976; cv=none; b=DYXk/NBW1CCX+HC9cHcugty6slQzuZwbBj/NUqpFyZEQuO1bfhepgqYyUnwE+3MNCug3bjS5ZUEZxSK9WtjbOK/JfUmJnJ6Rlyy/oRywgW+vB2NOlcsxENQhQPYo5d5ZewTE7Kczym2KOTaF8uncoUTgpLNmebWSw4wEz2KFoG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759206976; c=relaxed/simple;
	bh=FhQ9VWRw1ZA+Yi6bSgIWZwVJAwP/nZXVn5FHR9OVQeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DnhZW6oDvqzE4vR5kuFa+sP0eyVpnc4CKxK/geZ9yUXNHLqICN4s07WBGo6jgc5omICex6r0BEjXWNZCuHOLlmcY/T+0B387z2uL6VqsdY1CfRMWGqEqdVzw7LuaB3/crG7Qp0WqFYDN6Cv3jE6LUiHbgtPoMfpz1GmhNbUH3pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso3673908f8f.2
        for <stable@vger.kernel.org>; Mon, 29 Sep 2025 21:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759206973; x=1759811773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fm5G8/vjhsIUjpmRZq3jBHzITraDiDjFFu8BBE5iGww=;
        b=HptsfOtXt6g+Dqzmyy1X8NdNjKFv56f/XdzOfbI6L0aH4H2ToAkE2pPO1R6ZAkyAuj
         xTsxY92kwRcKAtpiZi1Z/+wopS1aAlZ4fYxj8xlFHQQtPQ6jSckbFq0si46zIDF/IWGu
         px0JgxfjgdnNVxFQahthxuyzRGDswUpeBjP+Mpw9eg9ZmkkU9/KI0rg0GUxunE2+IPtM
         NYYNORkm/zhfOkQlAO2d9v0rd2zr8ehYuvi6eZ9GJcOfco95yjSHRPHKudP/qnICpBvK
         ZxoNYIwDhcCdmQGqYJWcsPoJS5+Uho/zzeyJ98RXeUcaA8PEP+QByBg1LQQ/vjJnB6SS
         2fVw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ4jy1aDpQyWAzWt0PBOqp+HWqwKAMtUaMzxaVN/A/jl/PEVygKo42XE9HI+1Uhy9TizV5UwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWEZs/5/2D0VFJKUHi7zkvLqInAJ5oshLV/YfTtiVL+XpNai83
	LxJleMJUHKj2EjxBa3f7F+U77PIceVt52lAxxgcBHctYikHaSuu2kaj3
X-Gm-Gg: ASbGncusdOxmVEybMC7peYyDGFbJ7Jh2eEsOk6aZ9AR3+rbgSTJzPn1ZP1A4yej58Ef
	qut4SYnyoY/uAYIT8sg65YO8TXTNV4bTdn7peRMuNtOJqJsrZGTSRlGi7EX0b/edcgqPNfoFKC4
	j3irQpYYwbxXI1BbozanrJ/2Lzd+dCPLfqJqPYSDGqRE3HyIXoiH30EWhrWyFTpcF7NWUHTg67e
	PpMIUYogZ93S6JvJBcy7tZkG9LcF/c0ptP9SYthzOUrCP8zZziu8oyEZpInEgoYcOuV58UAXVXD
	rleUsnz0NMCAMuPyNVfCRlTVPERHIGERA5XrcAbTefPKVxJwMPvK9r9kT3CYhKLIRunUpYGg41k
	pzLIhkUSDSx7/LxQB/Iy/v1VQEShyeej7jCOJmuarOlv520QhUA==
X-Google-Smtp-Source: AGHT+IFBQFR5WWYgcTfynxJt/Hg+yCz06L3cy9rUJ/5SIpRbrAFoiE+fVMS62c0opwP4Z9BkumTQuQ==
X-Received: by 2002:a05:6000:1acb:b0:3ec:c50c:715b with SMTP id ffacd0b85a97d-40e4458ce21mr15661043f8f.19.1759206972744;
        Mon, 29 Sep 2025 21:36:12 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::301b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb71esm20934560f8f.1.2025.09.29.21.36.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Sep 2025 21:36:12 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: peterx@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	npache@redhat.com,
	riel@surriel.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	harry.yoo@oracle.com,
	jannh@google.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	usamaarif642@gmail.com,
	yuzhao@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ioworker0@gmail.com,
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v2 1/1] mm/rmap: fix soft-dirty and uffd-wp bit loss when remapping zero-filled mTHP subpage to shared zeropage
Date: Tue, 30 Sep 2025 12:33:51 +0800
Message-ID: <20250930043351.34927-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

When splitting an mTHP and replacing a zero-filled subpage with the shared
zeropage, try_to_map_unused_to_zeropage() currently drops several important
PTE bits.

For userspace tools like CRIU, which rely on the soft-dirty mechanism for
incremental snapshots, losing the soft-dirty bit means modified pages are
missed, leading to inconsistent memory state after restore.

As pointed out by David, the more critical uffd-wp bit is also dropped.
This breaks the userfaultfd write-protection mechanism, causing writes
to be silently missed by monitoring applications, which can lead to data
corruption.

Preserve both the soft-dirty and uffd-wp bits from the old PTE when
creating the new zeropage mapping to ensure they are correctly tracked.

Cc: <stable@vger.kernel.org>
Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Dev Jain <dev.jain@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
v1 -> v2:
 - Avoid calling ptep_get() multiple times (per Dev)
 - Double-check the uffd-wp bit (per David)
 - Collect Acked-by from David - thanks!
 - https://lore.kernel.org/linux-mm/20250928044855.76359-1-lance.yang@linux.dev/

 mm/migrate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index ce83c2c3c287..50aa91d9ab4e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -300,13 +300,14 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 					  unsigned long idx)
 {
 	struct page *page = folio_page(folio, idx);
+	pte_t oldpte = ptep_get(pvmw->pte);
 	pte_t newpte;
 
 	if (PageCompound(page))
 		return false;
 	VM_BUG_ON_PAGE(!PageAnon(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
+	VM_BUG_ON_PAGE(pte_present(oldpte), page);
 
 	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
 	    mm_forbids_zeropage(pvmw->vma->vm_mm))
@@ -322,6 +323,12 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 
 	newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
 					pvmw->vma->vm_page_prot));
+
+	if (pte_swp_soft_dirty(oldpte))
+		newpte = pte_mksoft_dirty(newpte);
+	if (pte_swp_uffd_wp(oldpte))
+		newpte = pte_mkuffd_wp(newpte);
+
 	set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
 
 	dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
-- 
2.49.0


