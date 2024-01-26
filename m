Return-Path: <stable+bounces-15879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED7683D7DA
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 11:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5671F2A8D0
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 10:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEF753E0F;
	Fri, 26 Jan 2024 09:55:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884AC55C00
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706262951; cv=none; b=r5T9MGHqfPon9P2tZRNy3WaAdVIQAB7fyYFJqz7icuMJd/Sa59kG+l7LT5+AkkHQX85VHNCwM+pQTQhTjFfhuMjWopP9xsoccaBljCXbwOtm6/O8AyltEymnt+Myr6eQOaAHcnkr5YwoxIwzYEfUsLZ2gIybqv1p/zh0GXRtOAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706262951; c=relaxed/simple;
	bh=7/sPTPfkh5HHh0Y4qWFhRtQv2Pg/0WpZTZgfJ7Tl+dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phrVgeaeeXRFCMAMvSccCv2DIUHXFi1etgI301L9CSkD3DV2rvDwsVU0BdsVnCxsYhIZNCNtRoNPKpRqysmVMxh7ylM/N4k2MNgRfiDHqniOPGANQdlJ7P3aFb+alnaCELIEs+OQnDxG7ACLCm9Q54xDUc1fTZnw5fEkEmiUVdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 714652F2023D; Fri, 26 Jan 2024 09:55:46 +0000 (UTC)
X-Spam-Level: 
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
	by air.basealt.ru (Postfix) with ESMTPSA id 1422E2F20238;
	Fri, 26 Jan 2024 09:55:44 +0000 (UTC)
From: oficerovas@altlinux.org
To: stable@vger.kernel.org
Cc: Alexander Ofitserov <oficerovas@altlinux.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	kovalev@altlinux.org,
	nickel@altlinux.org,
	dutyrok@altlinux.org,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH 1/2] mm: vmalloc: introduce array allocation functions
Date: Fri, 26 Jan 2024 12:55:13 +0300
Message-ID: <20240126095514.2681649-2-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240126095514.2681649-1-oficerovas@altlinux.org>
References: <20240126095514.2681649-1-oficerovas@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Ofitserov <oficerovas@altlinux.org>

From: Paolo Bonzini <pbonzini@redhat.com>

commit a8749a35c399 ("mm: vmalloc: introduce array allocation functions")

Linux has dozens of occurrences of vmalloc(array_size()) and
vzalloc(array_size()).  Allow to simplify the code by providing
vmalloc_array and vcalloc, as well as the underscored variants that let
the caller specify the GFP flags.

Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
---
 include/linux/vmalloc.h |  5 +++++
 mm/util.c               | 50 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 76dad53a410ac..0fd47f2f39eb0 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -112,6 +112,11 @@ extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
 void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
 		int node, const void *caller);
 
+extern void *__vmalloc_array(size_t n, size_t size, gfp_t flags);
+extern void *vmalloc_array(size_t n, size_t size);
+extern void *__vcalloc(size_t n, size_t size, gfp_t flags);
+extern void *vcalloc(size_t n, size_t size);
+
 extern void vfree(const void *addr);
 extern void vfree_atomic(const void *addr);
 
diff --git a/mm/util.c b/mm/util.c
index 25bfda774f6fd..7fd3c2bb3e4f5 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -686,6 +686,56 @@ static inline void *__page_rmapping(struct page *page)
 	return (void *)mapping;
 }
 
+/**
+ * __vmalloc_array - allocate memory for a virtually contiguous array.
+ * @n: number of elements.
+ * @size: element size.
+ * @flags: the type of memory to allocate (see kmalloc).
+ */
+void *__vmalloc_array(size_t n, size_t size, gfp_t flags)
+{
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(n, size, &bytes)))
+		return NULL;
+	return __vmalloc(bytes, flags);
+}
+EXPORT_SYMBOL(__vmalloc_array);
+
+/**
+ * vmalloc_array - allocate memory for a virtually contiguous array.
+ * @n: number of elements.
+ * @size: element size.
+ */
+void *vmalloc_array(size_t n, size_t size)
+{
+	return __vmalloc_array(n, size, GFP_KERNEL);
+}
+EXPORT_SYMBOL(vmalloc_array);
+
+/**
+ * __vcalloc - allocate and zero memory for a virtually contiguous array.
+ * @n: number of elements.
+ * @size: element size.
+ * @flags: the type of memory to allocate (see kmalloc).
+ */
+void *__vcalloc(size_t n, size_t size, gfp_t flags)
+{
+	return __vmalloc_array(n, size, flags | __GFP_ZERO);
+}
+EXPORT_SYMBOL(__vcalloc);
+
+/**
+ * vcalloc - allocate and zero memory for a virtually contiguous array.
+ * @n: number of elements.
+ * @size: element size.
+ */
+void *vcalloc(size_t n, size_t size)
+{
+	return __vmalloc_array(n, size, GFP_KERNEL | __GFP_ZERO);
+}
+EXPORT_SYMBOL(vcalloc);
+
 /* Neutral page->mapping pointer to address_space or anon_vma or other */
 void *page_rmapping(struct page *page)
 {
-- 
2.42.1


