Return-Path: <stable+bounces-89906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD3A9BD352
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 18:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A411283EEB
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41271D90B4;
	Tue,  5 Nov 2024 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORKEK3l4"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967BE1D9A7E
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827570; cv=none; b=Z0Yw3hqdMDiC/1rYroreMn1bQvdOWD67LEYmZL4YJrichWsztcNKLHfb5Ws+IDmk62Y7GR8R7xfECEPMg0+FQDsNeuujDLENe6fM6IMZXXjxP01paq1+KbtyPCnaD3YzBRQe3g8h9JiC3sIpc3dpt4d2ewYAvtgKhowJag7b09E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827570; c=relaxed/simple;
	bh=5OhO67kBZh2StBBiXL9zhjBSdoAurPrcMPzLWf2Rj5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OayrxH7pK/Et59K4SleETP+pZpvDLgTUm3iHm8bJ4E2o4zDWB7wFz4kz7m+JnqTmG61dzVpjBy6PzvcU8R30y3f3CLP6GUz/ep+cSiItrdTSG6SgKK6XNfHJWBhO8mhcE9A/rzU2SixIhu2ctfra9crWTpsvkPlVldQ4kO+01q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ORKEK3l4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730827567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TUlNVsP0DAzCfk0ksm+h+OOLUXhO7GR+9etfcUG18IA=;
	b=ORKEK3l4C19wj7GdejBsWFPmx1L23C5tnjP6dUoFpfVwAtoRhhwo/2T7DTIhOZd/mdUYdp
	vpY5hBNgF+XYbmyvWdiOE4JAx+UKltV08kWGmZXh/IfHNc0DxM87iJLJ8XLzew3ZHA/mTn
	e0Urnl006eVCW/9DbJe2E/3/EKRKLVg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-A4JCUZ_CN2CBg7t63VYJ8A-1; Tue,
 05 Nov 2024 12:26:04 -0500
X-MC-Unique: A4JCUZ_CN2CBg7t63VYJ8A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB5951955BD2;
	Tue,  5 Nov 2024 17:26:00 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.88.242])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 039C219560AD;
	Tue,  5 Nov 2024 17:25:55 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Leo Fu <bfu@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Hugh Dickins <hughd@google.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 6.6.y 1/2] mm: huge_memory: add vma_thp_disabled() and thp_disabled_by_hw()
Date: Tue,  5 Nov 2024 18:25:49 +0100
Message-ID: <20241105172550.969951-2-david@redhat.com>
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

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Patch series "mm: don't install PMD mappings when THPs are disabled by the
hw/process/vma".

During testing, it was found that we can get PMD mappings in processes
where THP (and more precisely, PMD mappings) are supposed to be disabled.
While it works as expected for anon+shmem, the pagecache is the
problematic bit.

For s390 KVM this currently means that a VM backed by a file located on
filesystem with large folio support can crash when KVM tries accessing the
problematic page, because the readahead logic might decide to use a
PMD-sized THP and faulting it into the page tables will install a PMD
mapping, something that s390 KVM cannot tolerate.

This might also be a problem with HW that does not support PMD mappings,
but I did not try reproducing it.

Fix it by respecting the ways to disable THPs when deciding whether we can
install a PMD mapping.  khugepaged should already be taking care of not
collapsing if THPs are effectively disabled for the hw/process/vma.

This patch (of 2):

Add vma_thp_disabled() and thp_disabled_by_hw() helpers to be shared by
shmem_allowable_huge_orders() and __thp_vma_allowable_orders().

[david@redhat.com: rename to vma_thp_disabled(), split out thp_disabled_by_hw() ]
Link: https://lkml.kernel.org/r/20241011102445.934409-2-david@redhat.com
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Reported-by: Leo Fu <bfu@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Cc: Boqiao Fu <bfu@redhat.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 963756aac1f011d904ddd9548ae82286d3a91f96)
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/huge_mm.h | 18 ++++++++++++++++++
 mm/huge_memory.c        | 13 +------------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index fa0350b0812ab..fc789c0ac85b8 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -137,6 +137,24 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
 	(transparent_hugepage_flags &					\
 	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
 
+static inline bool vma_thp_disabled(struct vm_area_struct *vma,
+		unsigned long vm_flags)
+{
+	/*
+	 * Explicitly disabled through madvise or prctl, or some
+	 * architectures may disable THP for some mappings, for
+	 * example, s390 kvm.
+	 */
+	return (vm_flags & VM_NOHUGEPAGE) ||
+	       test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags);
+}
+
+static inline bool thp_disabled_by_hw(void)
+{
+	/* If the hardware/firmware marked hugepage support disabled. */
+	return transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED);
+}
+
 unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9aea11b1477c8..7b4cb5c68b61b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -78,18 +78,7 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
 	if (!vma->vm_mm)		/* vdso */
 		return false;
 
-	/*
-	 * Explicitly disabled through madvise or prctl, or some
-	 * architectures may disable THP for some mappings, for
-	 * example, s390 kvm.
-	 * */
-	if ((vm_flags & VM_NOHUGEPAGE) ||
-	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
-		return false;
-	/*
-	 * If the hardware/firmware marked hugepage support disabled.
-	 */
-	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
+	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags))
 		return false;
 
 	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
-- 
2.47.0


