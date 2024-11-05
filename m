Return-Path: <stable+bounces-89907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C36FD9BD353
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 18:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58FA4B22237
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640E01E1308;
	Tue,  5 Nov 2024 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZEePTv84"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE061D9A7E
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827577; cv=none; b=XviMpo3vZY6dKwSLbON+0xCDPUDKEgJM7K6TqbREfPsbi9UqvS8nN/TdZS222hR5yWLoNaVU/GtrnF2+GauqRLWVJvpMApQcvvOuFcNbwBvbInyZG4HDORRWBiZhTZf3DWnGIu9dzIgNUtms+rmeet5dVTm9A083QqVZqcd3y6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827577; c=relaxed/simple;
	bh=enJflvxNHaa//jqjrUSz9YOOb5OYL1UzNUoOBUS6vP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vx9I7TqEXVOyBmhLjanDq0BjMCZLB2ldMs4ca0j2KuxX4Wz5Zy2SbwAUNErwykgPR+CBcESmN8iKxCCyN3H1iJ4L4F+7ozsW9EoqZJoNvR35495PAjw8VkvPsUtPgfWFiFtwXK8V7nkcF9/ZC19xT+0PQAEMvAUzgnOJRGg0Cf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZEePTv84; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730827574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uPVfe0mnR2uQKohBVUGV3/ckMZioqOKm7BSmR/ojZmE=;
	b=ZEePTv84Yf9fiVOvmHbfQNkwyCDi59YKpf8+sFxruVa7qei2Pc9wW3tyUepr5pJONUzOW2
	3eZ5jmSlrKS/ORh6TfHrBTMO8c2Fueg3Lcl+kyu/5VFmYl/Lj1Cstl2mCVUWjxdw3izFAr
	AQ0h7zZXdAkY26Jr0oKRNfDa7mLc/yQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-SeycrI_nNOevzZnWkCbCpQ-1; Tue,
 05 Nov 2024 12:26:11 -0500
X-MC-Unique: SeycrI_nNOevzZnWkCbCpQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 708AE1955F25;
	Tue,  5 Nov 2024 17:26:08 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.88.242])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 15324196BBC5;
	Tue,  5 Nov 2024 17:26:01 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Hildenbrand <david@redhat.com>,
	Leo Fu <bfu@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Hugh Dickins <hughd@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 6.6.y 2/2] mm: don't install PMD mappings when THPs are disabled by the hw/process/vma
Date: Tue,  5 Nov 2024 18:25:50 +0100
Message-ID: <20241105172550.969951-3-david@redhat.com>
In-Reply-To: <20241105172550.969951-1-david@redhat.com>
References: <2024101842-empty-espresso-c8a3@gregkh>
 <20241105172550.969951-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

We (or rather, readahead logic :) ) might be allocating a THP in the
pagecache and then try mapping it into a process that explicitly disabled
THP: we might end up installing PMD mappings.

This is a problem for s390x KVM, which explicitly remaps all PMD-mapped
THPs to be PTE-mapped in s390_enable_sie()->thp_split_mm(), before
starting the VM.

For example, starting a VM backed on a file system with large folios
supported makes the VM crash when the VM tries accessing such a mapping
using KVM.

Is it also a problem when the HW disabled THP using
TRANSPARENT_HUGEPAGE_UNSUPPORTED?  At least on x86 this would be the case
without X86_FEATURE_PSE.

In the future, we might be able to do better on s390x and only disallow
PMD mappings -- what s390x and likely TRANSPARENT_HUGEPAGE_UNSUPPORTED
really wants.  For now, fix it by essentially performing the same check as
would be done in __thp_vma_allowable_orders() or in shmem code, where this
works as expected, and disallow PMD mappings, making us fallback to PTE
mappings.

Link: https://lkml.kernel.org/r/20241011102445.934409-3-david@redhat.com
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Signed-off-by: David Hildenbrand <david@redhat.com>
Reported-by: Leo Fu <bfu@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 2b0f922323ccfa76219bcaacd35cd50aeaa13592)
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index b6ddfe22c5d5c..742c2f65c2c85 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4293,6 +4293,15 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	pmd_t entry;
 	vm_fault_t ret = VM_FAULT_FALLBACK;
 
+	/*
+	 * It is too late to allocate a small folio, we already have a large
+	 * folio in the pagecache: especially s390 KVM cannot tolerate any
+	 * PMD mappings, but PTE-mapped THP are fine. So let's simply refuse any
+	 * PMD mappings if THPs are disabled.
+	 */
+	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vma->vm_flags))
+		return ret;
+
 	if (!transhuge_vma_suitable(vma, haddr))
 		return ret;
 
-- 
2.47.0


