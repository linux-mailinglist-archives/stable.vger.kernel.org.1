Return-Path: <stable+bounces-200172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6926FCA80F2
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 16:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 273993065032
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 15:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B70033B6E8;
	Fri,  5 Dec 2025 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ZOWGS/m8"
X-Original-To: stable@vger.kernel.org
Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9601624BBE4
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764946806; cv=none; b=Lxz1Ozv8kfu88W0rKAWMJKQrTaS3WMYtakgnP44U8kvZIpRQIGTONselat+FMCXtE4YlKtObm383cYpEIEaXwM+FWMvwqg2ZOVyZltQfWFPM1EF7XVDshSUWhwZzpUVzLIl2RXLt1JEsuvlfcfAlDDf3qq/HA8grdqR3h/yBAOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764946806; c=relaxed/simple;
	bh=rPqFBGoEOYKVDFdJQgymk3wZJ11qBG9RpIIfItAPJcU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHFQEyUOsFfz7nig71wW3XgIQiFJsfbdXNOhwQMw+4D6jwTR38nksWHfRuzhfUaDy51J8nC4zB4sD4CMCaxHv8GUE8yfhrZkNGljB2xAz8h4u2Ofcb+mqjM4LrOWPWN7MFoQXAUCYOL76tfTrkxzSje5TvmRvS/UZVquCor9xw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=fail smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ZOWGS/m8; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1764946784; x=1765205984;
	bh=qIyabYfRYXeVwZVp9LPPfWirGseEPkYszpblk/XZ5Dw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZOWGS/m8tzXkiQ5rMpz2nfSazNtDRqiAV7taCW/XZHvZinRh0fuzw1xalMJyHG1ab
	 NmmS8SF6qxmpWheZnvotMSLFiKUAd6yB7OkYE4RINBY50RpB3Jni5l6u6ztRjB5TuB
	 5MugaFAEwCTF3DX1z800bHR88KfVIs0venVyLJnnKESz6+oIoxGVkyzuUgnWk1aAj3
	 Dodl/LWeB2nlQwDFotSW08UdY0skGH/FgEbdT/rtmxXXUyWdlpTwLTtx2WEC+1eqW1
	 VyE2NqB0hE9sZwNkvYPvhe/tk3WFgas7LfcQAvvuytTAoczZXR+1Cvxj3pOaKfz5xf
	 DeOLp3gaajH0w==
Date: Fri, 05 Dec 2025 14:59:17 +0000
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: jiayuan.chen@linux.dev, m.wieczorretman@pm.me, stable@vger.kernel.org, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v4 2/3] kasan: Refactor pcpu kasan vmalloc unpoison
Message-ID: <6dd6a10f94241cef935fec58c312cb846d352490.1764945396.git.m.wieczorretman@pm.me>
In-Reply-To: <cover.1764945396.git.m.wieczorretman@pm.me>
References: <cover.1764945396.git.m.wieczorretman@pm.me>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 948f454a99eeea8eab949328f562c02766404396
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

Fixes: 1d96320f8d53 ("kasan, vmalloc: add vmalloc tagging for SW_TAGS")
Cc: stable@vger.kernel.org # 6.1+
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
---
Changelog v1: (after splitting of from the KASAN series)
- Rewrite first paragraph of the patch message to point at the user
  impact of the issue.
- Move helper to common.c so it can be compiled in all KASAN modes.

Changelog v2:
- Redo the whole patch so it's an actual refactor.

Changelog v3:
- Redo the patch after applying Andrey's comments to align the code more
  with what's already in include/linux/kasan.h

 include/linux/kasan.h | 15 +++++++++++++++
 mm/kasan/common.c     | 17 +++++++++++++++++
 mm/vmalloc.c          |  4 +---
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 6d7972bb390c..cde493cb7702 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -615,6 +615,16 @@ static __always_inline void kasan_poison_vmalloc(const=
 void *start,
 =09=09__kasan_poison_vmalloc(start, size);
 }
=20
+void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms,
+=09=09=09=09 kasan_vmalloc_flags_t flags);
+static __always_inline void
+kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms,
+=09=09=09  kasan_vmalloc_flags_t flags)
+{
+=09if (kasan_enabled())
+=09=09__kasan_unpoison_vmap_areas(vms, nr_vms, flags);
+}
+
 #else /* CONFIG_KASAN_VMALLOC */
=20
 static inline void kasan_populate_early_vm_area_shadow(void *start,
@@ -639,6 +649,11 @@ static inline void *kasan_unpoison_vmalloc(const void =
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
index d4c14359feaf..1ed6289d471a 100644
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
+void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms,
+=09=09=09=09 kasan_vmalloc_flags_t flags)
+{
+=09unsigned long size;
+=09void *addr;
+=09int area;
+
+=09for (area =3D 0 ; area < nr_vms ; area++) {
+=09=09size =3D vms[area]->size;
+=09=09addr =3D vms[area]->addr;
+=09=09vms[area]->addr =3D __kasan_unpoison_vmalloc(addr, size, flags);
+=09}
+}
+#endif
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 22a73a087135..33e705ccafba 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4872,9 +4872,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned l=
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



