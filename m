Return-Path: <stable+bounces-200064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C34DBCA5095
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 20:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6BDD3050CCD
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 19:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D882F2F5461;
	Thu,  4 Dec 2025 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="rtyWO8Mh"
X-Original-To: stable@vger.kernel.org
Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9411629C323;
	Thu,  4 Dec 2025 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764874813; cv=none; b=rjqLhtWpT8xdmlRp94coTY4xd3heFGW1h4AVXpWe0hKn74oCKLR9dvseUDdQ8abszTszaXkv0H/Qen6AocqZfCJ2QFukYXqmDEoctjGGyzMK4u9euP1/sT7UaBXgQYfhbbfVYTB/li6UjqI5Ryak3aM92uLW1KMwPyOeE0EUG00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764874813; c=relaxed/simple;
	bh=hwQ0hFNswBQ3R/fPEPYmghV/Mw4YmlpGWO2uf5Kcms4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQP4fKhL+vjybGnTPXVjtvbHuk7/lcW0XY/PvMSPw96bhELDuEIQLkhgFb38KlhgQIoJNO9w32uUgbetAtevSf881A++TTu9Et90RTeHgirncHinex8ZYti5a2q2tNYMzE7voj/dA2IkUNWQxGRy61/Axk9fZ1R3aE21LTpjPq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=rtyWO8Mh; arc=none smtp.client-ip=79.135.106.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1764874809; x=1765134009;
	bh=IkyiGHAPhFI7mnPUmSkIC1C5JfoL+QfGKczkbPsXbcs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rtyWO8Mhp0k18ZcQhE62dU64ZWyjWu8gN4X48g8L7vsLbz32pen4vX2yR817pv5nq
	 UR/DJUVaJVGf1bfG1/ykN0eJQ4sDYYb5PEPyTVVi2VqWnMDFG7HqizX9h4BRSVYHy+
	 eltUby5UQqhC/4NhV5za0t/SkcGg5cZm/OA96J6Qk12U91Va9FC19YF8ueSVubUIAy
	 duTz/653G7dC15XWOBSwTkf/Si9UYE1w2DliI/x0CvNxxYkY3WJG7guCxZiKWkcg4S
	 c33NbGc7cAxKHLjIp4qUt7Siq939KZEJ3PTx7ASwE+XXkLee4Mjq8qy1R6V0b2VWa0
	 YsmXZfQBkLZZA==
Date: Thu, 04 Dec 2025 19:00:04 +0000
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: m.wieczorretman@pm.me, jiayuan.chen@linux.dev, stable@vger.kernel.org, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 2/3] kasan: Refactor pcpu kasan vmalloc unpoison
Message-ID: <eb61d93b907e262eefcaa130261a08bcb6c5ce51.1764874575.git.m.wieczorretman@pm.me>
In-Reply-To: <cover.1764874575.git.m.wieczorretman@pm.me>
References: <cover.1764874575.git.m.wieczorretman@pm.me>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 258475af37f58ec18af8ccf0e0fabf0466575111
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
Changelog v3:
- Redo the patch after applying Andrey's comments to align the code more
  with what's already in include/linux/kasan.h

Changelog v2:
- Redo the whole patch so it's an actual refactor.

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



