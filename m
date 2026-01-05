Return-Path: <stable+bounces-204760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA139CF3A17
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 13:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CDA130081BE
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 12:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA6C348452;
	Mon,  5 Jan 2026 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f4+udDbH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C46034845E
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617256; cv=none; b=W0N/WUgvN+2PUk1k+qINIPAGYaBmFhSvessTe4qFxGZHvtCb7wtyYHr68YOvmMmpOzlP7KKbZtysS/5SM2JSAHP8tFpaEIpaTkH7QjZwJhAR6o/jtgvHxNa6nzYQgFP4uguTyrri0Sq1DeBK01UYgaQQ1SZmEF79GLCChyyJ4Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617256; c=relaxed/simple;
	bh=ySDDuWEB3/FI13IRm6z2Jd3OoprR2kDPvdIiKOISBD0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WOHCWHBRW2Vx3yMEZEdijSBD2rTjgC6+Eac9iPlOx0KftlCP1rAI4O2IJkzSJ9/b0iRAKcK56HZj6ec5zvk1sViRllvPr0QS3adqScgWyn5+NX9vzRiRQRb9aGhx1onI6cJ7o1jiF9yxYf5w8EjrtMdEZVZKVPR1KgVHswbGqLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f4+udDbH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14D0C116D0;
	Mon,  5 Jan 2026 12:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767617256;
	bh=ySDDuWEB3/FI13IRm6z2Jd3OoprR2kDPvdIiKOISBD0=;
	h=Subject:To:Cc:From:Date:From;
	b=f4+udDbHAv/eanygNrFDZTkbLx1E3DSNTX0yB+PdH3GTQYuwimrbZRYJKbzYt+fiY
	 HLp2jSoQoZEwrsfpedZvYcCynV+61HRORHskKlT54pJkoZWxQrWj1OaieMYPWXOztk
	 C9Kvq2UmPwPkUe9LxkzeP3wcZuZ0l2iURO2dzSUE=
Subject: FAILED: patch "[PATCH] kasan: unpoison vms[area] addresses with a common tag" failed to apply to 6.1-stable tree
To: maciej.wieczor-retman@intel.com,akpm@linux-foundation.org,andreyknvl@gmail.com,dakr@kernel.org,dvyukov@google.com,elver@google.com,glider@google.com,jiayuan.chen@linux.dev,kees@kernel.org,ryabinin.a.a@gmail.com,stable@vger.kernel.org,urezki@gmail.com,vincenzo.frascino@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 13:47:32 +0100
Message-ID: <2026010532-stained-crumpet-3d80@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6a0e5b333842cf65d6f4e4f0a2a4386504802515
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010532-stained-crumpet-3d80@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6a0e5b333842cf65d6f4e4f0a2a4386504802515 Mon Sep 17 00:00:00 2001
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Date: Thu, 4 Dec 2025 19:00:11 +0000
Subject: [PATCH] kasan: unpoison vms[area] addresses with a common tag

A KASAN tag mismatch, possibly causing a kernel panic, can be observed on
systems with a tag-based KASAN enabled and with multiple NUMA nodes.  It
was reported on arm64 and reproduced on x86.  It can be explained in the
following points:

1. There can be more than one virtual memory chunk.
2. Chunk's base address has a tag.
3. The base address points at the first chunk and thus inherits
   the tag of the first chunk.
4. The subsequent chunks will be accessed with the tag from the
   first chunk.
5. Thus, the subsequent chunks need to have their tag set to
   match that of the first chunk.

Use the new vmalloc flag that disables random tag assignment in
__kasan_unpoison_vmalloc() - pass the same random tag to all the
vm_structs by tagging the pointers before they go inside
__kasan_unpoison_vmalloc().  Assigning a common tag resolves the pcpu
chunk address mismatch.

[akpm@linux-foundation.org: use WARN_ON_ONCE(), per Andrey]
  Link: https://lkml.kernel.org/r/CA+fCnZeuGdKSEm11oGT6FS71_vGq1vjq-xY36kxVdFvwmag2ZQ@mail.gmail.com
[maciej.wieczor-retman@intel.com: remove unneeded pr_warn()]
  Link: https://lkml.kernel.org/r/919897daaaa3c982a27762a2ee038769ad033991.1764945396.git.m.wieczorretman@pm.me
Link: https://lkml.kernel.org/r/873821114a9f722ffb5d6702b94782e902883fdf.1764874575.git.m.wieczorretman@pm.me
Fixes: 1d96320f8d53 ("kasan, vmalloc: add vmalloc tagging for SW_TAGS")
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Kees Cook <kees@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: <stable@vger.kernel.org>	[6.1+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index b2b40c59ce18..ed489a14dddf 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -584,11 +584,26 @@ void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms,
 	unsigned long size;
 	void *addr;
 	int area;
+	u8 tag;
 
-	for (area = 0 ; area < nr_vms ; area++) {
+	/*
+	 * If KASAN_VMALLOC_KEEP_TAG was set at this point, all vms[] pointers
+	 * would be unpoisoned with the KASAN_TAG_KERNEL which would disable
+	 * KASAN checks down the line.
+	 */
+	if (WARN_ON_ONCE(flags & KASAN_VMALLOC_KEEP_TAG))
+		return;
+
+	size = vms[0]->size;
+	addr = vms[0]->addr;
+	vms[0]->addr = __kasan_unpoison_vmalloc(addr, size, flags);
+	tag = get_tag(vms[0]->addr);
+
+	for (area = 1 ; area < nr_vms ; area++) {
 		size = vms[area]->size;
-		addr = vms[area]->addr;
-		vms[area]->addr = __kasan_unpoison_vmalloc(addr, size, flags);
+		addr = set_tag(vms[area]->addr, tag);
+		vms[area]->addr =
+			__kasan_unpoison_vmalloc(addr, size, flags | KASAN_VMALLOC_KEEP_TAG);
 	}
 }
 #endif


