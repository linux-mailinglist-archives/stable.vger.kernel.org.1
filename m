Return-Path: <stable+bounces-196582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EBCC7C6F8
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 05:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5C43A7661
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 04:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F035A285CA8;
	Sat, 22 Nov 2025 04:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ng7Fz73o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A466E24677D
	for <stable@vger.kernel.org>; Sat, 22 Nov 2025 04:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763787149; cv=none; b=Udxn6LU1qqHSGzpFjxfrUT2q61KCrpX5blOU8yZcnWaTBggyzon2xCuXI0jolSLhCDhjR7ML6WwbCSzMKGtufjHWpmO7kX+/uQ7GNMIirdq7oAPRfiR7vzVb6ZxfBB0lP7VuYn1if+vEu+GmKxuh7h0fwihQ1omB2MPMmwhKWXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763787149; c=relaxed/simple;
	bh=mWpuRONY4yuSlK/u5EsduRU2Vu73XpaMMdqaaRtFWrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxDKYfxJAff8odV7gOFCdY//EvikJguuCxJrhD1FFUfM1rQph8D+/j3lepSmVzOGMNknT+gI3XPeaLJJQGKo9SD6FnwjWrfgsnbikl8AfDpJ+DGITSJK607RcLTtxnp/NwKQGQlgfDj+zLt7yXeiUFvFhjVXN1pYuefuHTCrkdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ng7Fz73o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C115C4CEF5;
	Sat, 22 Nov 2025 04:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763787149;
	bh=mWpuRONY4yuSlK/u5EsduRU2Vu73XpaMMdqaaRtFWrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ng7Fz73opGjmylpGneOpRPmiXUszM+bNpDiEOzl94vVtX4tfCfCJewYyCqk8CxuG/
	 aB5Giw72C1h4CctxUW6kqvZn18XRx/t/6aVawRvMw/Fdu8MNiK+7LpKjroeNOQOluX
	 S/c8qkM0IDZz2XCLGLhBNpDMf+h7i+bZHkFiziD4Tam0x8yekYcXWaVRzzqoYcmTuk
	 Cyu+6Z4D0ejVJ3H/XzG+U9DrK/w3RBbpSMtCvbVSas3YRTSbrmilD4DByNwOoVGewG
	 NWJW3dF7tm+YK5GRJpppRE6Pb+YiyQV9lw+8gM7eHVZvcqS8X0WaHhchkOqSv1drtJ
	 HHrgWIc0ZoPuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Christian Brauner <brauner@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 3/4] kho: increase metadata bitmap size to PAGE_SIZE
Date: Fri, 21 Nov 2025 23:52:21 -0500
Message-ID: <20251122045222.2798582-3-sashal@kernel.org>
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

[ Upstream commit a2fff99f92dae9c0eaf0d75de3def70ec68dad92 ]

KHO memory preservation metadata is preserved in 512 byte chunks which
requires their allocation from slab allocator.  Slabs are not safe to be
used with KHO because of kfence, and because partial slabs may lead leaks
to the next kernel.  Change the size to be PAGE_SIZE.

The kfence specifically may cause memory corruption, where it randomly
provides slab objects that can be within the scratch area.  The reason for
that is that kfence allocates its objects prior to KHO scratch is marked
as CMA region.

While this change could potentially increase metadata overhead on systems
with sparsely preserved memory, this is being mitigated by ongoing work to
reduce sparseness during preservation via 1G guest pages.  Furthermore,
this change aligns with future work on a stateless KHO, which will also
use page-sized bitmaps for its radix tree metadata.

Link: https://lkml.kernel.org/r/20251021000852.2924827-3-pasha.tatashin@soleen.com
Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: David Matlack <dmatlack@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: fa759cd75bce ("kho: allocate metadata directly from the buddy allocator")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kexec_handover.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 492e40b6b8023..040cfeb1d3fab 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -52,10 +52,10 @@ early_param("kho", kho_parse_enable);
  * Keep track of memory that is to be preserved across KHO.
  *
  * The serializing side uses two levels of xarrays to manage chunks of per-order
- * 512 byte bitmaps. For instance if PAGE_SIZE = 4096, the entire 1G order of a
- * 1TB system would fit inside a single 512 byte bitmap. For order 0 allocations
- * each bitmap will cover 16M of address space. Thus, for 16G of memory at most
- * 512K of bitmap memory will be needed for order 0.
+ * PAGE_SIZE byte bitmaps. For instance if PAGE_SIZE = 4096, the entire 1G order
+ * of a 8TB system would fit inside a single 4096 byte bitmap. For order 0
+ * allocations each bitmap will cover 128M of address space. Thus, for 16G of
+ * memory at most 512K of bitmap memory will be needed for order 0.
  *
  * This approach is fully incremental, as the serialization progresses folios
  * can continue be aggregated to the tracker. The final step, immediately prior
@@ -63,12 +63,14 @@ early_param("kho", kho_parse_enable);
  * successor kernel to parse.
  */
 
-#define PRESERVE_BITS (512 * 8)
+#define PRESERVE_BITS (PAGE_SIZE * 8)
 
 struct kho_mem_phys_bits {
 	DECLARE_BITMAP(preserve, PRESERVE_BITS);
 };
 
+static_assert(sizeof(struct kho_mem_phys_bits) == PAGE_SIZE);
+
 struct kho_mem_phys {
 	/*
 	 * Points to kho_mem_phys_bits, a sparse bitmap array. Each bit is sized
@@ -116,19 +118,19 @@ static struct kho_out kho_out = {
 	.finalized = false,
 };
 
-static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
+static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
 {
 	void *res = xa_load(xa, index);
 
 	if (res)
 		return res;
 
-	void *elm __free(kfree) = kzalloc(sz, GFP_KERNEL);
+	void *elm __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
 
 	if (!elm)
 		return ERR_PTR(-ENOMEM);
 
-	if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz)))
+	if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), PAGE_SIZE)))
 		return ERR_PTR(-EINVAL);
 
 	res = xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
@@ -201,8 +203,7 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 		}
 	}
 
-	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS,
-				sizeof(*bits));
+	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
 	if (IS_ERR(bits))
 		return PTR_ERR(bits);
 
-- 
2.51.0


