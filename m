Return-Path: <stable+bounces-198094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB98C9BC7C
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 15:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7A57344DFA
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 14:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1578721CA02;
	Tue,  2 Dec 2025 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="OLO1VZQq"
X-Original-To: stable@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255A221D3EC
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685783; cv=none; b=dQXEmG1ndafP6qwajUCdW4gxHxR42qx3tsV/DKtPc8JW3edC76fm9Lbz5YZK3B5/vJ1ncNatl7omAL/D5WNG1vTGJf0TeSCZREJsRKxlWOu/A6l5Djof2158wwk/ExrKtzvzvHJ0PoTR3CgYKnYvOcCYt24fWYrT6OloSQeJH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685783; c=relaxed/simple;
	bh=0Ab3QKrH4PdLWaqrX5J9+3/2TCkeWIn5/xg6WydBgPU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yko2PRC7gmcjEgRBffuoj8oLE1Nivy6pEjw2vpGZR9ts/BOvK1M9ECtOrAOz9lwRW4syZzewtAGOYY9RZdfzAlNnYBpnTb3zS+VJ7JvZHDKKm3Ympk/w7ZbMXjXbPNYQ8aKEah7L0szJNT2FyYEUyI+ow0IGHOgiMkZ5T+q3tFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=OLO1VZQq; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1764685774; x=1764944974;
	bh=N+YMyXrUIDlvdwT88k+hzchw//5574kLYOWxbowQd+Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OLO1VZQqFWzj+DN9B0D2HPGIJo+ITebJMu7zH98a5j/ALNxRNFtR+KtxeEpUYnUgB
	 6bc8rY5Ac12NLTP29EQHiQ2xDycv7DznWVLU2LeZohPZZb5TrYqWk4JUjZEvV1DWqz
	 TqDc444iZBFbQyKrpRqF7fd/MMr9eycaleu+XL7kgm3VG9xAxsSjSkbukfpFoUClMH
	 HbGT1NBt1av02FxLJEUMiz8W18hTVfzVv0chKYNjWfir42/0O6H0OGaHbCpj1ALicE
	 ziqDFswMLPEbGob8rKY+iRYfRqes/U7TFCaeUPQKkuEhihhor8zcKeNa3HG7uQZNeU
	 293qcGZFqQFQw==
Date: Tue, 02 Dec 2025 14:29:28 +0000
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Marco Elver <elver@google.com>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: Maciej Wieczor-Retman <m.wieczorretman@pm.me>, stable@vger.kernel.org, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] kasan: Unpoison vms[area] addresses with a common tag
Message-ID: <325c5fa1043408f1afe94abab202cde9878240c5.1764685296.git.m.wieczorretman@pm.me>
In-Reply-To: <cover.1764685296.git.m.wieczorretman@pm.me>
References: <cover.1764685296.git.m.wieczorretman@pm.me>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 87d59c9c44924853cf81bc1e8bd9a2df71af726c
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

Use the modified __kasan_unpoison_vmalloc() to pass the tag of the first
vm_struct's address when vm_structs are unpoisoned in
pcpu_get_vm_areas(). Assigning a common tag resolves the pcpu chunk
address mismatch.

Fixes: 1d96320f8d53 ("kasan, vmalloc: add vmalloc tagging for SW_TAGS")
Cc: <stable@vger.kernel.org> # 6.1+
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v2:
- Revise the whole patch to match the fixed refactorization from the
  first patch.

Changelog v1:
- Rewrite the patch message to point at the user impact of the issue.
- Move helper to common.c so it can be compiled in all KASAN modes.

 mm/kasan/common.c  |  3 ++-
 mm/kasan/hw_tags.c | 12 ++++++++----
 mm/kasan/shadow.c  | 15 +++++++++++----
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 7884ea7d13f9..e5a867a5670b 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -591,11 +591,12 @@ void kasan_unpoison_vmap_areas(struct vm_struct **vms=
, int nr_vms,
 =09unsigned long size;
 =09void *addr;
 =09int area;
+=09u8 tag =3D get_tag(vms[0]->addr);
=20
 =09for (area =3D 0 ; area < nr_vms ; area++) {
 =09=09size =3D vms[area]->size;
 =09=09addr =3D vms[area]->addr;
-=09=09vms[area]->addr =3D __kasan_unpoison_vmap_areas(addr, size, flags);
+=09=09vms[area]->addr =3D __kasan_unpoison_vmap_areas(addr, size, flags, t=
ag);
 =09}
 }
 #endif
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 4b7936a2bd6f..2a02b898b9d8 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -317,7 +317,7 @@ static void init_vmalloc_pages(const void *start, unsig=
ned long size)
 }
=20
 static void *__kasan_unpoison_vmalloc(const void *start, unsigned long siz=
e,
-=09=09=09=09      kasan_vmalloc_flags_t flags)
+=09=09=09=09      kasan_vmalloc_flags_t flags, int unpoison_tag)
 {
 =09u8 tag;
 =09unsigned long redzone_start, redzone_size;
@@ -361,7 +361,11 @@ static void *__kasan_unpoison_vmalloc(const void *star=
t, unsigned long size,
 =09=09return (void *)start;
 =09}
=20
-=09tag =3D kasan_random_tag();
+=09if (unpoison_tag < 0)
+=09=09tag =3D kasan_random_tag();
+=09else
+=09=09tag =3D unpoison_tag;
+
 =09start =3D set_tag(start, tag);
=20
 =09/* Unpoison and initialize memory up to size. */
@@ -390,7 +394,7 @@ static void *__kasan_unpoison_vmalloc(const void *start=
, unsigned long size,
 void *__kasan_random_unpoison_vmalloc(const void *start, unsigned long siz=
e,
 =09=09=09=09      kasan_vmalloc_flags_t flags)
 {
-=09return __kasan_unpoison_vmalloc(start, size, flags);
+=09return __kasan_unpoison_vmalloc(start, size, flags, -1);
 }
=20
 void __kasan_poison_vmalloc(const void *start, unsigned long size)
@@ -405,7 +409,7 @@ void __kasan_poison_vmalloc(const void *start, unsigned=
 long size)
 void *__kasan_unpoison_vmap_areas(void *addr, unsigned long size,
 =09=09=09=09  kasan_vmalloc_flags_t flags, u8 tag)
 {
-=09return __kasan_unpoison_vmalloc(addr, size, flags);
+=09return __kasan_unpoison_vmalloc(addr, size, flags, tag);
 }
 #endif
=20
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 0a8d8bf6e9cf..7a66ffc1d5b3 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -625,8 +625,10 @@ void kasan_release_vmalloc(unsigned long start, unsign=
ed long end,
 }
=20
 static void *__kasan_unpoison_vmalloc(const void *start, unsigned long siz=
e,
-=09=09=09=09      kasan_vmalloc_flags_t flags)
+=09=09=09=09      kasan_vmalloc_flags_t flags, int unpoison_tag)
 {
+=09u8 tag;
+
 =09/*
 =09 * Software KASAN modes unpoison both VM_ALLOC and non-VM_ALLOC
 =09 * mappings, so the KASAN_VMALLOC_VM_ALLOC flag is ignored.
@@ -648,7 +650,12 @@ static void *__kasan_unpoison_vmalloc(const void *star=
t, unsigned long size,
 =09    !(flags & KASAN_VMALLOC_PROT_NORMAL))
 =09=09return (void *)start;
=20
-=09start =3D set_tag(start, kasan_random_tag());
+=09if (unpoison_tag < 0)
+=09=09tag =3D kasan_random_tag();
+=09else
+=09=09tag =3D unpoison_tag;
+
+=09start =3D set_tag(start, tag);
 =09kasan_unpoison(start, size, false);
 =09return (void *)start;
 }
@@ -656,13 +663,13 @@ static void *__kasan_unpoison_vmalloc(const void *sta=
rt, unsigned long size,
 void *__kasan_random_unpoison_vmalloc(const void *start, unsigned long siz=
e,
 =09=09=09=09      kasan_vmalloc_flags_t flags)
 {
-=09return __kasan_unpoison_vmalloc(start, size, flags);
+=09return __kasan_unpoison_vmalloc(start, size, flags, -1);
 }
=20
 void *__kasan_unpoison_vmap_areas(void *addr, unsigned long size,
 =09=09=09=09  kasan_vmalloc_flags_t flags, u8 tag)
 {
-=09return __kasan_unpoison_vmalloc(addr, size, flags);
+=09return __kasan_unpoison_vmalloc(addr, size, flags, tag);
 }
=20
 /*
--=20
2.52.0



