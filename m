Return-Path: <stable+bounces-198093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C00C9BC76
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 15:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B013A7219
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 14:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9896F272811;
	Tue,  2 Dec 2025 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="NRGZ6d4+"
X-Original-To: stable@vger.kernel.org
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch [185.70.43.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BC02192FA
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685771; cv=none; b=XM6gMxbtnIvMkSQDF2p8BehJ3HHsPgXf22RPPlEFJvAXjPZIFl32ciRmHTGr7vQqfF0L74UvAUn7fqJyok753MusukvGVrn4n8871H98zL6NgKeVWbO0mf9xtLHX3KNo/PB9OLU7mKOazh3wdevvsa/gmb74l8QJx5GuqYWtLk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685771; c=relaxed/simple;
	bh=c0+oxpkOUiZWuRgBaYNVGy1z2k3GZ3+3MlsRSxx+X5k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBhMAY+HrqaacihwQR/rF69qkw6kfUxggNVkDGEnhQ+5yY+dFwKF4xoHJZGo2AwzArsiiB1xY6uJCsydEYy3XzOZNgGLcLjadn69VmWyPVniaP9ihYG52BeG84ZhCUPT/gjdBdyjcakK8gUtGGBPo6S6JqLBJYx7exC/V/9lL8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=NRGZ6d4+; arc=none smtp.client-ip=185.70.43.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1764685760; x=1764944960;
	bh=cxvGIY83ye9YgTgKuvjuMWrA1hnR8fL/ldcb4UtoE+A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NRGZ6d4+04HGZNVf2o6gyp1B8hOsaMCbLjx6U19LwJTosYjrSR8DPJQzQ7GAc3hb7
	 8Yu4KjEb93EOHb9kpciwshWxjqqFU4/m2UGkJKRE9mFOp6F0NfcSiAJtkGek24Nj8S
	 NL6wBjvEZApPHsZ5acYJkwHOKUYix4KhCRjSiY3/D1iRWM9EgahIxh0uxs5TegCxyn
	 2VKXIadE4qsAulkORP6VyXw37NAlyzwZKFWWKuyP6Uba3XaikCfYNjjwrnIS1zeuhu
	 QGIDs9d+cgcogZWGBmv4SlQ4WeVWxJHD7+E8aN3zN9WkDqNRWOZGzL4XrlLmcWSDm8
	 jGzreVUYFUd7g==
Date: Tue, 02 Dec 2025 14:29:17 +0000
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: Maciej Wieczor-Retman <m.wieczorretman@pm.me>, stable@vger.kernel.org, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 1/2] kasan: Refactor pcpu kasan vmalloc unpoison
Message-ID: <3907c330d802e5b86bfe003485220de972aaac18.1764685296.git.m.wieczorretman@pm.me>
In-Reply-To: <cover.1764685296.git.m.wieczorretman@pm.me>
References: <cover.1764685296.git.m.wieczorretman@pm.me>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 39231ba515aa7720d08908d2e3bb7dc16ac86540
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

Refactor code by reusing __kasan_unpoison_vmalloc in a new helper in
preparation for the actual fix.

Changelog v1 (after splitting of from the KASAN series):
- Rewrite first paragraph of the patch message to point at the user
  impact of the issue.
- Move helper to common.c so it can be compiled in all KASAN modes.

Fixes: 1d96320f8d53 ("kasan, vmalloc: add vmalloc tagging for SW_TAGS")
Cc: <stable@vger.kernel.org> # 6.1+
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v2:
- Redo the whole patch so it's an actual refactor.

 include/linux/kasan.h | 16 +++++++++++++---
 mm/kasan/common.c     | 17 +++++++++++++++++
 mm/kasan/hw_tags.c    | 15 +++++++++++++--
 mm/kasan/shadow.c     | 16 ++++++++++++++--
 mm/vmalloc.c          |  4 +---
 5 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index d12e1a5f5a9a..4a3d3dba9764 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -595,14 +595,14 @@ static inline void kasan_release_vmalloc(unsigned lon=
g start,
=20
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
=20
-void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
-=09=09=09       kasan_vmalloc_flags_t flags);
+void *__kasan_random_unpoison_vmalloc(const void *start, unsigned long siz=
e,
+=09=09=09=09      kasan_vmalloc_flags_t flags);
 static __always_inline void *kasan_unpoison_vmalloc(const void *start,
 =09=09=09=09=09=09unsigned long size,
 =09=09=09=09=09=09kasan_vmalloc_flags_t flags)
 {
 =09if (kasan_enabled())
-=09=09return __kasan_unpoison_vmalloc(start, size, flags);
+=09=09return __kasan_random_unpoison_vmalloc(start, size, flags);
 =09return (void *)start;
 }
=20
@@ -614,6 +614,11 @@ static __always_inline void kasan_poison_vmalloc(const=
 void *start,
 =09=09__kasan_poison_vmalloc(start, size);
 }
=20
+void *__kasan_unpoison_vmap_areas(void *addr, unsigned long size,
+=09=09=09=09  kasan_vmalloc_flags_t flags, u8 tag);
+void kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms,
+=09=09=09       kasan_vmalloc_flags_t flags);
+
 #else /* CONFIG_KASAN_VMALLOC */
=20
 static inline void kasan_populate_early_vm_area_shadow(void *start,
@@ -638,6 +643,11 @@ static inline void *kasan_unpoison_vmalloc(const void =
*start,
 static inline void kasan_poison_vmalloc(const void *start, unsigned long s=
ize)
 { }
=20
+static __always_inline void
+kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms,
+=09=09=09  kasan_vmalloc_flags_t flags)
+{ }
+
 #endif /* CONFIG_KASAN_VMALLOC */
=20
 #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index d4c14359feaf..7884ea7d13f9 100644
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
@@ -582,3 +583,19 @@ bool __kasan_check_byte(const void *address, unsigned =
long ip)
 =09}
 =09return true;
 }
+
+#ifdef CONFIG_KASAN_VMALLOC
+void kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms,
+=09=09=09       kasan_vmalloc_flags_t flags)
+{
+=09unsigned long size;
+=09void *addr;
+=09int area;
+
+=09for (area =3D 0 ; area < nr_vms ; area++) {
+=09=09size =3D vms[area]->size;
+=09=09addr =3D vms[area]->addr;
+=09=09vms[area]->addr =3D __kasan_unpoison_vmap_areas(addr, size, flags);
+=09}
+}
+#endif
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 1c373cc4b3fa..4b7936a2bd6f 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -316,8 +316,8 @@ static void init_vmalloc_pages(const void *start, unsig=
ned long size)
 =09}
 }
=20
-void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
-=09=09=09=09kasan_vmalloc_flags_t flags)
+static void *__kasan_unpoison_vmalloc(const void *start, unsigned long siz=
e,
+=09=09=09=09      kasan_vmalloc_flags_t flags)
 {
 =09u8 tag;
 =09unsigned long redzone_start, redzone_size;
@@ -387,6 +387,12 @@ void *__kasan_unpoison_vmalloc(const void *start, unsi=
gned long size,
 =09return (void *)start;
 }
=20
+void *__kasan_random_unpoison_vmalloc(const void *start, unsigned long siz=
e,
+=09=09=09=09      kasan_vmalloc_flags_t flags)
+{
+=09return __kasan_unpoison_vmalloc(start, size, flags);
+}
+
 void __kasan_poison_vmalloc(const void *start, unsigned long size)
 {
 =09/*
@@ -396,6 +402,11 @@ void __kasan_poison_vmalloc(const void *start, unsigne=
d long size)
 =09 */
 }
=20
+void *__kasan_unpoison_vmap_areas(void *addr, unsigned long size,
+=09=09=09=09  kasan_vmalloc_flags_t flags, u8 tag)
+{
+=09return __kasan_unpoison_vmalloc(addr, size, flags);
+}
 #endif
=20
 void kasan_enable_hw_tags(void)
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 5d2a876035d6..0a8d8bf6e9cf 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -624,8 +624,8 @@ void kasan_release_vmalloc(unsigned long start, unsigne=
d long end,
 =09}
 }
=20
-void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
-=09=09=09       kasan_vmalloc_flags_t flags)
+static void *__kasan_unpoison_vmalloc(const void *start, unsigned long siz=
e,
+=09=09=09=09      kasan_vmalloc_flags_t flags)
 {
 =09/*
 =09 * Software KASAN modes unpoison both VM_ALLOC and non-VM_ALLOC
@@ -653,6 +653,18 @@ void *__kasan_unpoison_vmalloc(const void *start, unsi=
gned long size,
 =09return (void *)start;
 }
=20
+void *__kasan_random_unpoison_vmalloc(const void *start, unsigned long siz=
e,
+=09=09=09=09      kasan_vmalloc_flags_t flags)
+{
+=09return __kasan_unpoison_vmalloc(start, size, flags);
+}
+
+void *__kasan_unpoison_vmap_areas(void *addr, unsigned long size,
+=09=09=09=09  kasan_vmalloc_flags_t flags, u8 tag)
+{
+=09return __kasan_unpoison_vmalloc(addr, size, flags);
+}
+
 /*
  * Poison the shadow for a vmalloc region. Called as part of the
  * freeing process at the time the region is freed.
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 798b2ed21e46..32ecdb8cd4b8 100644
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
+=09kasan_unpoison_vmap_areas(vms, nr_vms, KASAN_VMALLOC_PROT_NORMAL);
=20
 =09kfree(vas);
 =09return vms;
--=20
2.52.0



