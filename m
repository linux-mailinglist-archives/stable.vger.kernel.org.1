Return-Path: <stable+bounces-87692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 478BF9A9DF7
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 11:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19D01F225C5
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 09:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D911547E9;
	Tue, 22 Oct 2024 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b529A95H"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DDE14C5A1
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588208; cv=none; b=kXhlRWUapcg4PrwyezPYYrhsgEw8jG1liHsGO1ixI5Sx9WcD9i/EHMLA8n0ygAKA94k12Gsz2ZsZRC/bgoahYZvoBcPTpZMLAuqysh0HDscEOLRlKtOiJHEBiiKowof6b4HQd2XUIry6eoL58j+QXmIprURN8+QYE78Fa/5BSFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588208; c=relaxed/simple;
	bh=KzlVTrdA5Dbq3KetoHWU+wwm2yZXvasu7Aur6guoXFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwv3q/vxcajKwuZQBytkQPE0eJsQCUNQ43z5r+Jh9HFt4Bfe74ijIm7hCPy9B4rLHFUoakxM3t2M/asP8zO1e3YwCi/h/kunl1Na3XmdjDPJDKEa2lvkLxnG7B5xhP1QDAhsJfYmOipIDJbU5gN4sDFb4nll2i+SDnE4eoK1wwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b529A95H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729588205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6atlNrywQf6L1FuctvXZuXYBGuhOpE6LyddYsn3PAm4=;
	b=b529A95HffTtzEtKfHNBBuBcw2fTJf1BjYVbTW9aC5jnWYSPRnF7x/ED5uoqsPAS3Vgiv0
	DaXtU0YsRBuuOSeLmIEr45DVfMbqTYx71hJS1PKNw1A/g9i0ZHXy/XEfjMo/Fqed+HQdtu
	soPHHBlyqtKi7zlrBoKPWIgfZxuSnG0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-Wicz0LVpMrKSeY-2KDLYTg-1; Tue,
 22 Oct 2024 05:10:03 -0400
X-MC-Unique: Wicz0LVpMrKSeY-2KDLYTg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04C7019560B4;
	Tue, 22 Oct 2024 09:10:02 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.88.114])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7441319560AE;
	Tue, 22 Oct 2024 09:09:57 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Leo Fu <bfu@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Hugh Dickins <hughd@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 6.6.y] mm: don't install PMD mappings when THPs are disabled by the hw/process/vma
Date: Tue, 22 Oct 2024 11:09:52 +0200
Message-ID: <20241022090952.4101444-1-david@redhat.com>
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

Minor contextual difference.

Note that the backport of 963756aac1f011d904ddd9548ae82286d3a91f96 is
required (send separately as reply to the "FAILED:" mail).

---
 mm/memory.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index b6ddfe22c5d5..742c2f65c2c8 100644
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
2.46.1


