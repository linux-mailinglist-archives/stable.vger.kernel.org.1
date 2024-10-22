Return-Path: <stable+bounces-87691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 355399A9DF2
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 11:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1542285B34
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 09:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F34158DAC;
	Tue, 22 Oct 2024 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOQCNNzw"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6A61940BC
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588089; cv=none; b=Gl6hyKvGt2gTZf9q2nLcsSppA6gC0IZst/+HPsbiWtxgInqH2xPdtnmJItd324GrQGlkw4UODtTUZqCfnNqA0CmkiugzbOZFdmJBFzFedx5QBMwYbIbl3+gXXFlJl1eTYJwGuWoGo5qCvPk3vTWEbhyHRTlp0p3LWGoGlB38i7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588089; c=relaxed/simple;
	bh=ESMDUQlucGrU0og+KQQjgRRF58Y2glVB4n2zfrxb714=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZswhIwbFDk1KcKUxQcQAb9KyinNqdcVrnPv6ZxBvG0B5ve0XICqlQ3HgTGTqvEUsmSeu9FS+YeVyhyWIcugF4akdziUbufR16DnhuSu83Bz73D4iJo48mulLtiryuXv677YYyCsH12XPC9MEkSb2Eum7Ohf1T8cDAmQOsqQ16Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jOQCNNzw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729588086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l74OXyrns1B5Xbh2f9FQ6P6MMI0cwys+x20mCt/wM9w=;
	b=jOQCNNzw+Jxd4klmF35P561tAGmmRzfDmItT6px7hWZewUpHNTcOZki5G4ek4XyY3JCjHZ
	ha0V/1kFqDpKpuiJf3zr232X47k8nifo2Vnmf3MlUtrGcvVYd0y9VmmuyUV8M8ze9dxMQV
	lsOdL7x2QKjtwdUwid/3VanqVYBY7Io=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-Vz4kdbg2N12vuWfofOT22w-1; Tue,
 22 Oct 2024 05:08:03 -0400
X-MC-Unique: Vz4kdbg2N12vuWfofOT22w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E16E19560AD;
	Tue, 22 Oct 2024 09:08:01 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.88.114])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F39F19560AE;
	Tue, 22 Oct 2024 09:07:56 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: stable@vger.kernel.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	David Hildenbrand <david@redhat.com>,
	Leo Fu <bfu@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Hugh Dickins <hughd@google.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 6.6.y] mm: huge_memory: add vma_thp_disabled() and thp_disabled_by_hw()
Date: Tue, 22 Oct 2024 11:07:55 +0200
Message-ID: <20241022090755.4097604-1-david@redhat.com>
In-Reply-To: <2024101842-empty-espresso-c8a3@gregkh>
References: <2024101842-empty-espresso-c8a3@gregkh>
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

The change in mm/shmem.c does not exist yet.

This patch is required to backport the fix
2b0f922323ccfa76219bcaacd35cd50aeaa13592, for which a backport will
be sent separately in reply to the "FAILED: ..." mail.

---
 include/linux/huge_mm.h | 18 ++++++++++++++++++
 mm/huge_memory.c        | 15 ++-------------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index fa0350b0812a..fc789c0ac85b 100644
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
index 9aea11b1477c..dfd6577225d8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -78,19 +78,8 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
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
-		return false;
+	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags))
+		return 0;
 
 	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
 	if (vma_is_dax(vma))
-- 
2.46.1


