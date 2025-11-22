Return-Path: <stable+bounces-196583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00107C7C6FB
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 05:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4EA93A76A6
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 04:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AD82868BD;
	Sat, 22 Nov 2025 04:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GE18GyUO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7468248C
	for <stable@vger.kernel.org>; Sat, 22 Nov 2025 04:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763787151; cv=none; b=c06Txa4b3IkQtZyD6fLg8q+r83SaJuktL4L/ZMBczWfFTk02N6PHu5R4jyIn/Tcr0BvopViMRwWzAQO2JWEndbtaAST2BfuZFmW30Kyq0gAKbNKbZWrgWdriOAMhxU/rW3GgZtp59ya4omT9iWYcCxpdKoNv9NOd6fQJIYI+XyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763787151; c=relaxed/simple;
	bh=FWLl64j3OG27t2fEX87ru8O4T/Nkn3nKaztfaTaQhFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jefVJq+zOglf9JNWSkeHMY2TncwdOxyJt9Um4YjeAAujGfjnBFQZEUx3S2tZyr1ijxx+1et/zaEkYKkVvh2RR1r9n2v552QFvZJCuQ9GVNsO03hFqn334fD3oQPN7bsCFxaS1A8oqIxJ1j9wXO7Ecwf22D7sDEzIC2VIYXap1jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GE18GyUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6797FC113D0;
	Sat, 22 Nov 2025 04:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763787151;
	bh=FWLl64j3OG27t2fEX87ru8O4T/Nkn3nKaztfaTaQhFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GE18GyUOISXotTELnXjM3bNp6/u4SqqM/Jrgb8E3cN5W8U5RicYHcX11k0vt6NJfg
	 tr4o8Kba+X8bKqXrCrvGaXrrVZzhFZhWmcsiqgplxdA4B8IKrD8WlnUwMwuPqly/70
	 xFoHZJDWyFyWMHgfRfkFwmEsFIOD73UDaJfoh+9fp8HnbvapVmEDDCC3mdueU5HPhj
	 /hw7R1J9j/OUHXi5cuxVITCv08dPIzCyFY7ftqAQSrnw9Mijz6I1XkyvtzgJsAikU8
	 AAAXiYi050kk73e0qr+/x0sr2ojD6+zcCaDFhntHFr0jKVEm8Uvyj1T4kzAtgJTTdG
	 2jUJygsTY1U6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Alexander Graf <graf@amazon.com>,
	Christian Brauner <brauner@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 4/4] kho: allocate metadata directly from the buddy allocator
Date: Fri, 21 Nov 2025 23:52:22 -0500
Message-ID: <20251122045222.2798582-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251122045222.2798582-1-sashal@kernel.org>
References: <2025112149-ahoy-manliness-1554@gregkh>
 <20251122045222.2798582-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pasha Tatashin <pasha.tatashin@soleen.com>

[ Upstream commit fa759cd75bce5489eed34596daa53f721849a86f ]

KHO allocates metadata for its preserved memory map using the slab
allocator via kzalloc().  This metadata is temporary and is used by the
next kernel during early boot to find preserved memory.

A problem arises when KFENCE is enabled.  kzalloc() calls can be randomly
intercepted by kfence_alloc(), which services the allocation from a
dedicated KFENCE memory pool.  This pool is allocated early in boot via
memblock.

When booting via KHO, the memblock allocator is restricted to a "scratch
area", forcing the KFENCE pool to be allocated within it.  This creates a
conflict, as the scratch area is expected to be ephemeral and
overwriteable by a subsequent kexec.  If KHO metadata is placed in this
KFENCE pool, it leads to memory corruption when the next kernel is loaded.

To fix this, modify KHO to allocate its metadata directly from the buddy
allocator instead of slab.

Link: https://lkml.kernel.org/r/20251021000852.2924827-4-pasha.tatashin@soleen.com
Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: David Matlack <dmatlack@google.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/gfp.h     | 3 +++
 kernel/kexec_handover.c | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 5ebf26fcdcfa3..1c599cf9b4af7 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -7,6 +7,7 @@
 #include <linux/mmzone.h>
 #include <linux/topology.h>
 #include <linux/alloc_tag.h>
+#include <linux/cleanup.h>
 #include <linux/sched.h>
 
 struct vm_area_struct;
@@ -463,4 +464,6 @@ static inline struct folio *folio_alloc_gigantic_noprof(int order, gfp_t gfp,
 /* This should be paired with folio_put() rather than free_contig_range(). */
 #define folio_alloc_gigantic(...) alloc_hooks(folio_alloc_gigantic_noprof(__VA_ARGS__))
 
+DEFINE_FREE(free_page, void *, free_page((unsigned long)_T))
+
 #endif /* __LINUX_GFP_H */
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 040cfeb1d3fab..d23855283faa4 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -125,7 +125,7 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
 	if (res)
 		return res;
 
-	void *elm __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	void *elm __free(free_page) = (void *)get_zeroed_page(GFP_KERNEL);
 
 	if (!elm)
 		return ERR_PTR(-ENOMEM);
@@ -292,9 +292,9 @@ static_assert(sizeof(struct khoser_mem_chunk) == PAGE_SIZE);
 static struct khoser_mem_chunk *new_chunk(struct khoser_mem_chunk *cur_chunk,
 					  unsigned long order)
 {
-	struct khoser_mem_chunk *chunk __free(kfree) = NULL;
+	struct khoser_mem_chunk *chunk __free(free_page) = NULL;
 
-	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	chunk = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!chunk)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.51.0


