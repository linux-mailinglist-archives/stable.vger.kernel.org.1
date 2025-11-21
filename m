Return-Path: <stable+bounces-196516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E41C7AB3D
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 17:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E692E3A0FBA
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D3B2BDC1B;
	Fri, 21 Nov 2025 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hUs1AU2A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA9428B3E2
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741079; cv=none; b=NZ44oLKGmH8y2VoVGeRnEHX3E9jfU9JMdfvpOgZiJ3fGVraeK4RltdZOnUfp4wqFKbhv/wl4rbYruLad4CDMHR0fS98xXzBbYAYoJhIYKXjVHnwUWbaDcZ9eA8QMT/AD3wmCg4qr+OmpFob5VFKthmRCn9afjD+cLQ8BFeN2X3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741079; c=relaxed/simple;
	bh=HOCuX516x51tLLuhNM093ew0n6cmLC3BBSuhFrdO4pc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GBLtmsauEJhVtYs/9lrsQqVeFdJhS1Wcyz9kzIKbNHKyYvL4uRVh6VX7AHTx/CGIjPsYfHlFrtQZGS0mA0mow6yLjIpnzKyHepceePAznrVkhUDxKTotc5I6iqdjrdoPKkADIYJguitupCz0P05BPv72MKOsJNMRVEiZ80jUOLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hUs1AU2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB683C4CEF1;
	Fri, 21 Nov 2025 16:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763741079;
	bh=HOCuX516x51tLLuhNM093ew0n6cmLC3BBSuhFrdO4pc=;
	h=Subject:To:Cc:From:Date:From;
	b=hUs1AU2A0tRTcHJKu5sHCt57erXQ1wFt4Xf4clPjN3PY9C8TpwfKSAE5/hdlhjVry
	 R+nhuiFBxrXMGq1vb5WLsqyI07UE/3QxJjJcLFU9JNs6aFPZOizuI5H80nw9ANgnEq
	 H9XYz6zTvumwp8iIjduMz4PlItEA4+e+8/npiMHo=
Subject: FAILED: patch "[PATCH] kho: increase metadata bitmap size to PAGE_SIZE" failed to apply to 6.17-stable tree
To: pasha.tatashin@soleen.com,akpm@linux-foundation.org,brauner@kernel.org,corbet@lwn.net,dmatlack@google.com,graf@amazon.com,jgg@ziepe.ca,masahiroy@kernel.org,ojeda@kernel.org,pratyush@kernel.org,rdunlap@infradead.org,rppt@kernel.org,skhawaja@google.com,stable@vger.kernel.org,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 21 Nov 2025 17:04:36 +0100
Message-ID: <2025112136-panama-nape-342b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x a2fff99f92dae9c0eaf0d75de3def70ec68dad92
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112136-panama-nape-342b@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a2fff99f92dae9c0eaf0d75de3def70ec68dad92 Mon Sep 17 00:00:00 2001
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 20 Oct 2025 20:08:51 -0400
Subject: [PATCH] kho: increase metadata bitmap size to PAGE_SIZE

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

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 0bc9001e532a..9217d2fdd2d3 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -69,10 +69,10 @@ early_param("kho", kho_parse_enable);
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
@@ -80,12 +80,14 @@ early_param("kho", kho_parse_enable);
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
@@ -133,19 +135,19 @@ static struct kho_out kho_out = {
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
@@ -218,8 +220,7 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 		}
 	}
 
-	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS,
-				sizeof(*bits));
+	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
 	if (IS_ERR(bits))
 		return PTR_ERR(bits);
 


