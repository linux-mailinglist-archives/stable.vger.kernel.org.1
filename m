Return-Path: <stable+bounces-196576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE29C7C514
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 04:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 573574E1CDD
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 03:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552F1126BF7;
	Sat, 22 Nov 2025 03:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K842ogoi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F1A10E3
	for <stable@vger.kernel.org>; Sat, 22 Nov 2025 03:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763783159; cv=none; b=fp9FfW5u6vsvJquxtBT0kVS3UAkA7nsLzdJ/QhuoI3iLLtDsXuI+fCQIuXHdEUW0myfoxNiWDjgt/kYt/vspbbAHoUTmkvwuvWm+kzJbIe437NQP1FuaggL35Ze82je5ClbC2WQzMYEfC/g8j5W9Vu3aHmczxwSfYLmZa3DKtI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763783159; c=relaxed/simple;
	bh=uoLzGgkWH/H66JS03jhEW6AG8BsXMUG66pakc20rGig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDDWqsfz8WOW/JiDriMwX5mgiSUWGIFUMqgtwn+WzRh76yORMYv6FkvS/9wxpE2bn7rneqc++UQOkC5dS/UdN75rHp/xvGc8wug/kjiLQxA3swECxHS4dfKqgFyRcH605uAFhio9K97CSMuiBHnd6wZcmWnJwGhuz2Pbw635znQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K842ogoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D7AC19421;
	Sat, 22 Nov 2025 03:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763783158;
	bh=uoLzGgkWH/H66JS03jhEW6AG8BsXMUG66pakc20rGig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K842ogoiq8lv9Ra1cwCXkYF8o6ru5Sxt5Ncf8tI/dkJatKJ8da3fSNS7+rvfe9bRp
	 oyiQrbb3CX2+Y1/adLCqg7ctaleMRIhj63H28iPX93T7iS+quzPdvW/CMFgw/BJp3o
	 oTql2baKS6aOUMMIqSteyiBYjO4cobynWoSi1kbVq24UpT9Ed9hEmDftWeSHweOnWf
	 UOWUb+K5Qrt3x2+cl9O1vAsx77uTxz/mYTJw2oNEPj1DMHO9f30C5bCTYRgFkzsGCf
	 9QhYMGIyL3dEfVtp32KphxAZL12KGVHEcADyDH4ArVjSAR+ccbShoSRg/MwQP3h+Ba
	 Pv4mZFYlq/qcw==
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
Subject: [PATCH 6.17.y 3/3] kho: increase metadata bitmap size to PAGE_SIZE
Date: Fri, 21 Nov 2025 22:45:52 -0500
Message-ID: <20251122034552.2782626-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251122034552.2782626-1-sashal@kernel.org>
References: <2025112136-panama-nape-342b@gregkh>
 <20251122034552.2782626-1-sashal@kernel.org>
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


