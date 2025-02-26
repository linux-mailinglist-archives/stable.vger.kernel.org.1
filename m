Return-Path: <stable+bounces-119719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EF8A4667A
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 17:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8193AC955
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 16:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9BF22068B;
	Wed, 26 Feb 2025 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XfCtt16T"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3FC21E0BF
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587027; cv=none; b=Nv4RkYGslowT5bICYp9ZmC9tqPJpSihWvWERxDtc3IacANoTkjOeZKJq0WmtAO9JG+gAR74kIRmX2he7bL1MtXxfNJbpr0qSLfdF/j41Ez1pGjDfwAaMQbTjdUHwXWnDILrfKao7kO5rJ0Qgll7J0i8Xk4CRvomHI3kLt9Qw+I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587027; c=relaxed/simple;
	bh=40fHOJaclUGDk2yZBiDnH2nN4+0I24hmqSzejuEcnXo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZZ+Mt3LrV7ri1m/quxVVCoUxVvfktDXkoaC4n3w+wxOu6UkjoNAA2h8L7GPnTF2Y1F+itgkyJfQNSo+h/AyE9hzzmlHi9i966W2QcqORP2oU7L3OGMG34RlGHtzs0DFneEZ7FSkAy8GG1SLH/g2sdC/JSmZkO+50bcwYxqfMQRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XfCtt16T; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6e659664db8so697726d6.2
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 08:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740587025; x=1741191825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1iZBOUn5TfaKdJ8fUW/ohyeEciVeQe808dYANdbYN7A=;
        b=XfCtt16TXVL1tMQTOpTFfPKMl+joh7tggd5Z9pWOjByztV1gDsun8i1baaCz0uy7e0
         S1EADGNLGZHypZd2BM9k3jY7o31gV7W1FoM1bZhHcJnaQr8Qedn9xEQ5fLAZE2rtelMX
         FNfgjMUg+F7Z8tS/PDPsd2yESKjjBsJZITgGNVIlvZYOfSTCFBorom9pVvaG3rczt1LK
         D+A1RpODiNvI1LE5e1be7U7luIb3ZIyIiPG3wZPqXOQQ4wXK7oI7NMtoqz9qDPI25yFH
         B72AbcZd8s41WtKUZd09CKE+AWSx7/RrcsJewfd1C+uss0/oDY0pjgJmU36i5iypsIm1
         6O8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740587025; x=1741191825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1iZBOUn5TfaKdJ8fUW/ohyeEciVeQe808dYANdbYN7A=;
        b=tp0J7W2jIti6u7giUkqE0CS25AJbj0cATjm5DWUTomgbPIr/3IcV1yi2cxmIbIbRzH
         JG1MYc7A9/oaJR50CI+/J/MSxgDN+QTVPNrbhalpyCThb75V7KBiwfmArWKm0nbpIAEJ
         0cAv6IfQGYOALu8P8HzpE/FjIfTLsBIxX/jqUkYCLVH7dUy7YxRHh9/QCZ4vM1iWBs/2
         qXbpDj87R8w0w9jq3pbIO/zdAzfq/NRWpoZnoFxou5unjWMwzF972vRiseFPg6cjCRWb
         aa/3YmQxP9QWBVF+7k0iaG/xDigD/wYVJdCVLqbieWJgXXyDLOx1G1VKnu0O5S2AyTA7
         GGKA==
X-Forwarded-Encrypted: i=1; AJvYcCVMp4u1TaMrpcn+mpBuP3hvRr51u5+VL3Iskbg2hP53eKfEPu8gD7O8se63UyRQM57K5vJc6FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YytjDrN47vqiLg1Ql+Frrs5To+0f7VJYZTR9SQv+XWsCQJZyWK7
	Lkhqb3jWISsM7vixG8kzuJHOsGRPLGPmFB83JiwSYXPsJ6a0aCmcoAXJFL2FkoXNA26KGdyDnT3
	2Hmrj8g==
X-Google-Smtp-Source: AGHT+IGETZUu141OjsGUsrKL/0fxcfLOq3YpRMsVuVapIyy/5BXoaepYsdLR4P7IA7Dg0sPqBGRJHRWtp8Cd
X-Received: from qvbml23.prod.google.com ([2002:a05:6214:5857:b0:6dd:d16:e8ab])
 (user=bgeffon job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6214:130b:b0:6d4:c6d:17fe
 with SMTP id 6a1803df08f44-6e87ab52085mr112509186d6.25.1740587024722; Wed, 26
 Feb 2025 08:23:44 -0800 (PST)
Date: Wed, 26 Feb 2025 11:23:41 -0500
In-Reply-To: <20250226114815.758217-1-bgeffon@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250226114815.758217-1-bgeffon@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250226162341.915535-1-bgeffon@google.com>
Subject: [PATCH v2] mm: fix finish_fault() handling for large folios
From: Brian Geffon <bgeffon@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <ziy@nvidia.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, 
	Brian Geffon <bgeffon@google.com>, stable@vger.kernel.org, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Marek Maslanka <mmaslanka@google.com>
Content-Type: text/plain; charset="UTF-8"

When handling faults for anon shmem finish_fault() will attempt to install
ptes for the entire folio. Unfortunately if it encounters a single
non-pte_none entry in that range it will bail, even if the pte that
triggered the fault is still pte_none. When this situation happens the
fault will be retried endlessly never making forward progress.

This patch fixes this behavior and if it detects that a pte in the range
is not pte_none it will fall back to setting a single pte.

Cc: stable@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>
Fixes: 43e027e41423 ("mm: memory: extend finish_fault() to support large folio")
Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reported-by: Marek Maslanka <mmaslanka@google.com>
Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 mm/memory.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b4d3d4893267..b6c467fdbfa4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5183,7 +5183,11 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	bool is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
 		      !(vma->vm_flags & VM_SHARED);
 	int type, nr_pages;
-	unsigned long addr = vmf->address;
+	unsigned long addr;
+	bool needs_fallback = false;
+
+fallback:
+	addr = vmf->address;
 
 	/* Did we COW the page? */
 	if (is_cow)
@@ -5222,7 +5226,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	 * approach also applies to non-anonymous-shmem faults to avoid
 	 * inflating the RSS of the process.
 	 */
-	if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma))) {
+	if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
+			unlikely(needs_fallback)) {
 		nr_pages = 1;
 	} else if (nr_pages > 1) {
 		pgoff_t idx = folio_page_idx(folio, page);
@@ -5258,9 +5263,9 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 		ret = VM_FAULT_NOPAGE;
 		goto unlock;
 	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
-		update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
-		ret = VM_FAULT_NOPAGE;
-		goto unlock;
+		needs_fallback = true;
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		goto fallback;
 	}
 
 	folio_ref_add(folio, nr_pages - 1);
-- 
2.48.1.711.g2feabab25a-goog


