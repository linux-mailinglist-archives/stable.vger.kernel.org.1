Return-Path: <stable+bounces-202838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A37CC89F5
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 16:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F12A30B4C43
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2663446B7;
	Wed, 17 Dec 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="aaO2qhro"
X-Original-To: stable@vger.kernel.org
Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch [109.224.244.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7139E33554B
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979430; cv=none; b=sQwD3XyTNyQB78Zid1j7OEru+uvvOGXOBHL+aYDYb5qHw09mWIlFN0KDbL9WE5t77iNsR6Vu694FgMBH/BhXSsJdob/VsZZN7xtQd2YDmbl4u+rETLFuKjXgxCL9xNcxwjr2typ8xvz+gfGmGrLTXUOh2+CfqnA5iQSMth55UYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979430; c=relaxed/simple;
	bh=glj7+A8YTgGn5/eae4AlODX6x+X+AwdKY6Dto7aIRO8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQCsaHCyHCGqz8Kfbye7tkeTJc/FHQVIqKC350AMv/oBEyJoR4cQMKI9Xb42pyjRwnaE6i4rW1jk1XbsV9djNr1qbN2g8TVGp1bAvbIim5Nw5r6VAUTT4JCaVeUoYta+ubIIzLu5QDXrLvpdkOF3uwO2YMtIl2eYVTGsgop2TFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=aaO2qhro; arc=none smtp.client-ip=109.224.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1765979419; x=1766238619;
	bh=s2JYxSYT5Izoz83uHW43rnJd8Vyki+WsPGIbQcYTHRk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aaO2qhroUwaDY/buRgs8KHtp2AkOjae7AXWsAyHYPxMDMnZVOjYRehCSsZ63kLgkg
	 U2lA588W08yu2bhPUd0Yycekc6mlfvU+ZIco2y7+ZxrqTeH7bcW6H6YTZNP1DZBo0N
	 fl9Q1qY1T7XyoWrisNkMI4LInRmsQ2p2Ywjirp5dc2Ys5ElrArCbYWT0uNtQDv2kfs
	 HcCt0Apcok0wcfbxLZwS4jnk49fUcHqtevJfbAzD/qIfNQICtRCariJahFkIJj9a5f
	 hzPK/LYGwz1yjzt/7UAym22/2Vql5ksfrfpcPbRzBIxJfh1JmUSqK3IWOMGmhYvONX
	 mpHVXmnslxtsw==
Date: Wed, 17 Dec 2025 13:50:15 +0000
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: m.wieczorretman@pm.me, stable@vger.kernel.org, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v5 2/3] kasan: Refactor pcpu kasan vmalloc unpoison
Message-ID: <aac5a2493bdd16e99d879d2f92944e62314f2465.1765978969.git.m.wieczorretman@pm.me>
In-Reply-To: <cover.1765978969.git.m.wieczorretman@pm.me>
References: <cover.1765978969.git.m.wieczorretman@pm.me>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: ef69e21d81520e5a8eff366705d9de1d575b6ec0
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
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---

Changelog v3:
- Redo the patch after applying Andrey's comments to align the code more
  with what's already in include/linux/kasan.h

Changelog v2:
- Redo the whole patch so it's an actual refactor.

Changelog v1: (after splitting of from the KASAN series)
- Rewrite first paragraph of the patch message to point at the user
  impact of the issue.
- Move helper to common.c so it can be compiled in all KASAN modes.

 include/linux/kasan.h | 15 +++++++++++++++
 mm/kasan/common.c     | 17 +++++++++++++++++
 mm/vmalloc.c          |  4 +---
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index df3d8567dde9..9c6ac4b62eb9 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -631,6 +631,16 @@ static __always_inline void kasan_poison_vmalloc(const=
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
@@ -655,6 +665,11 @@ static inline void *kasan_unpoison_vmalloc(const void =
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
index 1d27f1bd260b..b2b40c59ce18 100644
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
@@ -575,3 +576,19 @@ bool __kasan_check_byte(const void *address, unsigned =
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
index 94c0a9262a46..41dd01e8430c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -5027,9 +5027,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned l=
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



