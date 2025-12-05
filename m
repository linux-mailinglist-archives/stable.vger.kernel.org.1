Return-Path: <stable+bounces-200174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F71CA80E6
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 16:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7CF263025811
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 15:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED8E33B6DC;
	Fri,  5 Dec 2025 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="N+3AZIRl"
X-Original-To: stable@vger.kernel.org
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E4E33ADA5;
	Fri,  5 Dec 2025 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764946810; cv=none; b=CUX2xXfyRFJmk2EynMqg4KHF7nJvGAeyVpjXEzeKj5aCGn2VfJJvKcku78tC3hbSOGj/gTf84PzrjRbSV6tN5mj3dv6AtafeREFSGf5suCRQEX9l76t3PYsRiY+AK1VZ4G4c1db+hgs19I1xgxFjgqoLDnLdlcY7XAVG1OihAgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764946810; c=relaxed/simple;
	bh=BTYlCktS5S4g7Exg0JxgMp8sNaVVb77iH5bFN/oFR3A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DmXkwj88xtXNh/VjanVJCqiD2wHXZPs88g6eTXkJIbNFcOs1vlpqD/+y32sRD8FivqxMQ/I+OW4YOuD1UkmbTP62FQonjGYeKsxBu/JNFCV75iv5NjKiXjzQ/uQsbqdIHJjBym/LiMbQpHJbILP0GWsGpsevMVtu0cLKc6rFshE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=N+3AZIRl; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1764946798; x=1765205998;
	bh=L0KdqaoEvJRt9/c4L5Rt4JS2SHbqfjLO2UUM/bE4AmE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=N+3AZIRlFffP95lEsDGcJwonEwcbmnmiP+y9G7XIZ4CFhPqE12ntUM7VqVh8YDUHr
	 6BJW7IfSW9jwX6j3p+t5RY5+0ZEg+L6wKYKw9NKULxp3VFb2cXmz604zMCbYqwA+V5
	 Uc/Y4JAt9Qklgc14X5IqwNYWQwjAAI3CipzqUjHEO/4J1FgCRc4nrGXFgX7anR/7gF
	 hu++oTotuKns356sfhzGjNvViiiYwVN2nam8yAPQSzrQ7f/kvvB1In/ps2JXOFIcJA
	 70YVK1WzmHJ9gRvB8H7RqV+iK5AgWStUXVHjnR8fMAeH0ZfefZcy+sv+UVxUM4WgLW
	 Z/OZs+EMukOBg==
Date: Fri, 05 Dec 2025 14:59:26 +0000
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Marco Elver <elver@google.com>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: jiayuan.chen@linux.dev, m.wieczorretman@pm.me, stable@vger.kernel.org, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] kasan: Unpoison vms[area] addresses with a common tag
Message-ID: <919897daaaa3c982a27762a2ee038769ad033991.1764945396.git.m.wieczorretman@pm.me>
In-Reply-To: <cover.1764945396.git.m.wieczorretman@pm.me>
References: <cover.1764945396.git.m.wieczorretman@pm.me>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 1f0ff2af25c0def600917e4f386d03b302b45161
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

Use the new vmalloc flag that disables random tag assignment in
__kasan_unpoison_vmalloc() - pass the same random tag to all the
vm_structs by tagging the pointers before they go inside
__kasan_unpoison_vmalloc(). Assigning a common tag resolves the pcpu
chunk address mismatch.

Fixes: 1d96320f8d53 ("kasan, vmalloc: add vmalloc tagging for SW_TAGS")
Cc: stable@vger.kernel.org # 6.1+
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
---
Changelog v4:
- Add WARN_ON_ONCE() if the new flag is already set in the helper.
  (Andrey)
- Remove pr_warn() since the comment should be enough. (Andrey)

Changelog v3:
- Redo the patch by using a flag instead of a new argument in
  __kasan_unpoison_vmalloc() (Andrey Konovalov)

Changelog v2:
- Revise the whole patch to match the fixed refactorization from the
  first patch.

Changelog v1:
- Rewrite the patch message to point at the user impact of the issue.
- Move helper to common.c so it can be compiled in all KASAN modes.

 mm/kasan/common.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 1ed6289d471a..589be3d86735 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -591,11 +591,26 @@ void __kasan_unpoison_vmap_areas(struct vm_struct **v=
ms, int nr_vms,
 =09unsigned long size;
 =09void *addr;
 =09int area;
+=09u8 tag;
+
+=09/*
+=09 * If KASAN_VMALLOC_KEEP_TAG was set at this point, all vms[] pointers
+=09 * would be unpoisoned with the KASAN_TAG_KERNEL which would disable
+=09 * KASAN checks down the line.
+=09 */
+=09if (WARN_ON_ONCE(flags & KASAN_VMALLOC_KEEP_TAG))
+=09=09return;
+
+=09size =3D vms[0]->size;
+=09addr =3D vms[0]->addr;
+=09vms[0]->addr =3D __kasan_unpoison_vmalloc(addr, size, flags);
+=09tag =3D get_tag(vms[0]->addr);
=20
-=09for (area =3D 0 ; area < nr_vms ; area++) {
+=09for (area =3D 1 ; area < nr_vms ; area++) {
 =09=09size =3D vms[area]->size;
-=09=09addr =3D vms[area]->addr;
-=09=09vms[area]->addr =3D __kasan_unpoison_vmalloc(addr, size, flags);
+=09=09addr =3D set_tag(vms[area]->addr, tag);
+=09=09vms[area]->addr =3D
+=09=09=09__kasan_unpoison_vmalloc(addr, size, flags | KASAN_VMALLOC_KEEP_T=
AG);
 =09}
 }
 #endif
--=20
2.52.0



