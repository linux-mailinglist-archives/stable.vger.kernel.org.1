Return-Path: <stable+bounces-192412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA55C31A1F
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 15:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA391189947C
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 14:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463CF2F6189;
	Tue,  4 Nov 2025 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="sLxtTSkC"
X-Original-To: stable@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A9D24679F
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267763; cv=none; b=PnbBwhvwm+bnwvBfV/ydDZBhx3WYE735ChLXC+AHmrVEd7Q2k8JRJkzCKgIvMgeiHNwGiELllfRAZipooOavUYAJA1usrBeRCrPU63ahC2mJ+vYvhDVNFPJlaC8nPnrysusmRjK0TNn90+wdJSS+vzWxcFlvkby7NoVrtJF2cz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267763; c=relaxed/simple;
	bh=7bvapD1uqsnNYi1Q3JJRh8kAisoWEx0DwRXG2a9BbQQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pm7F09FD9YY2fGBqL7eRIEFasZyv/z5C2hTCFKCSMgnAVQxhYklINENPr5C6SK2+/Qy0yGRF71s7E22cNR7lrLyBmdJUyGrkGgyt24KSYLlpevUFYFlw0AcRnUXrDrEHlLNdYJVTf4ipvGRvCDW0qjy4hahx8X1JcPGR2Jj+5iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=sLxtTSkC; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1762267753; x=1762526953;
	bh=xfqs8NGDzi/GLs93yh/ZnyHEZsNbd7BFWZBeJoDbuBw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=sLxtTSkCbLJUhXOFbUAzkkZTsRM3HZRQToyIFBaRu0PGKyO5fKHZRIxLblCnA8aYq
	 1xoYfY5qfeaDniIW4yU04b5OalIS28PDRxj+azfnN/T1tuuyxwhtvNxmTqubXlVhCP
	 5Wmk14Q2eC7LgmtAM6XkOP6t9k8j5zagrcZeoLWy3Eae2EIy/LmGPcSjjXKunZHQeT
	 6DVds+bC8KILEg+9m7m6wV+oKy6hyY+wCp12XaOtqDKrgK/+buG6nEwcCt2Jf1PjPB
	 p+2mjdRnk6A4YqsQfKo4GSIhwGBNCXB6TR/nuFpapEoYpzSN1o6Ve3JeLMfBT0hAo7
	 YpBYBfB6AI79A==
Date: Tue, 04 Nov 2025 14:49:08 +0000
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: m.wieczorretman@pm.me, stable@vger.kernel.org, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Baoquan He <bhe@redhat.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v1 1/2] kasan: Unpoison pcpu chunks with base address tag
Message-ID: <821677dd824d003cc5b7a77891db4723e23518ea.1762267022.git.m.wieczorretman@pm.me>
In-Reply-To: <cover.1762267022.git.m.wieczorretman@pm.me>
References: <cover.1762267022.git.m.wieczorretman@pm.me>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: fd6efc8602e9b03ae9b37c660c7f86c9a4b17086
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

A KASAN tag mismatch, possibly causing a kernel panic, can be observed
on systems with a tag-based KASAN enabled and with multiple NUMA nodes.
It was reported on arm64 and reproduced on x86. It can be explained in
the following points:

=091. There can be more than one virtual memory chunk.
=092. Chunk's base address has a tag.
=093. The base address points at the first chunk and thus inherits
=09   the tag of the first chunk.
=094. The subsequent chunks will be accessed with the tag from the
=09   first chunk.
=095. Thus, the subsequent chunks need to have their tag set to
=09   match that of the first chunk.

Refactor code by moving it into a helper in preparation for the actual
fix.

Fixes: 1d96320f8d53 ("kasan, vmalloc: add vmalloc tagging for SW_TAGS")
Cc: <stable@vger.kernel.org> # 6.1+
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Tested-by: Baoquan He <bhe@redhat.com>
---
Changelog v1 (after splitting of from the KASAN series):
- Rewrite first paragraph of the patch message to point at the user
  impact of the issue.
- Move helper to common.c so it can be compiled in all KASAN modes.

 include/linux/kasan.h | 10 ++++++++++
 mm/kasan/common.c     | 11 +++++++++++
 mm/vmalloc.c          |  4 +---
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index d12e1a5f5a9a..b00849ea8ffd 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -614,6 +614,13 @@ static __always_inline void kasan_poison_vmalloc(const=
 void *start,
 =09=09__kasan_poison_vmalloc(start, size);
 }
=20
+void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms);
+static __always_inline void kasan_unpoison_vmap_areas(struct vm_struct **v=
ms, int nr_vms)
+{
+=09if (kasan_enabled())
+=09=09__kasan_unpoison_vmap_areas(vms, nr_vms);
+}
+
 #else /* CONFIG_KASAN_VMALLOC */
=20
 static inline void kasan_populate_early_vm_area_shadow(void *start,
@@ -638,6 +645,9 @@ static inline void *kasan_unpoison_vmalloc(const void *=
start,
 static inline void kasan_poison_vmalloc(const void *start, unsigned long s=
ize)
 { }
=20
+static inline void kasan_unpoison_vmap_areas(struct vm_struct **vms, int n=
r_vms)
+{ }
+
 #endif /* CONFIG_KASAN_VMALLOC */
=20
 #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index d4c14359feaf..c63544a98c24 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -28,6 +28,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/bug.h>
+#include <linux/vmalloc.h>
=20
 #include "kasan.h"
 #include "../slab.h"
@@ -582,3 +583,13 @@ bool __kasan_check_byte(const void *address, unsigned =
long ip)
 =09}
 =09return true;
 }
+
+void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms)
+{
+=09int area;
+
+=09for (area =3D 0 ; area < nr_vms ; area++) {
+=09=09kasan_poison(vms[area]->addr, vms[area]->size,
+=09=09=09     arch_kasan_get_tag(vms[area]->addr), false);
+=09}
+}
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 798b2ed21e46..934c8bfbcebf 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4870,9 +4870,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned l=
ong *offsets,
 =09 * With hardware tag-based KASAN, marking is skipped for
 =09 * non-VM_ALLOC mappings, see __kasan_unpoison_vmalloc().
 =09 */
-=09for (area =3D 0; area < nr_vms; area++)
-=09=09vms[area]->addr =3D kasan_unpoison_vmalloc(vms[area]->addr,
-=09=09=09=09vms[area]->size, KASAN_VMALLOC_PROT_NORMAL);
+=09kasan_unpoison_vmap_areas(vms, nr_vms);
=20
 =09kfree(vas);
 =09return vms;
--=20
2.51.0



