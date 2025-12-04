Return-Path: <stable+bounces-200065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D5FCA50A7
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 20:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62EA8304194B
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 19:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0AA344050;
	Thu,  4 Dec 2025 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="MGFUiyyI"
X-Original-To: stable@vger.kernel.org
Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch [109.224.244.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D4434402B
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764874820; cv=none; b=c/OGhPtpepVk/k6KQZWqPupSdbT2R1NcaU6w7A+C3MR7GEpaep6lbHpFpOmH+DdPa109dqFntVUtckPaUoPOfzKOXEMlMCjw7VOiVat//9nkc49dhLlUk1Y+LvYdxPfCUdd6sHRUcfFhR9YJsTU8UYwx83+UWGQxrzr77RkEeHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764874820; c=relaxed/simple;
	bh=lSB8h/UwqS3wNM+YXAjrnejEoTPkVg0wGq9NbdvpHCw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AY9huggsN+NpqDL5xkZvrfGxJwsOG9SmVIwJ97CG0ODmvaBGRPs5YZHF3WYnv2vHSrwYAIFD516Jr79xCTzM27WHkwVgI/MJWHkswtT5MZtLr50HuNN9oyYBexIgA226QqoLAVluw5Gj4mOIrSElx8AdiHsRbLECsh2hM8j2ijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=MGFUiyyI; arc=none smtp.client-ip=109.224.244.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1764874815; x=1765134015;
	bh=OkoBRhgSwjuQLuLgL6yseexB7KxkTDwJEiXAnUMLOgo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MGFUiyyIDKtVbJTiczN/PWRSWvLhh11G6a4GRU9xXEEewJkCTZxEmuxNpqmyytJiZ
	 D+HattnA4aU9m28WTAhKFXHgJPLJAXelaYDyr+J79xtORsVLTBbyQoeJCy56B8b30H
	 RPU23LVvrseHJ6PDlrp5wIGFfIB/voK1OsWmC61UvRydlyrdZ1DaxCh7zd2Gboy/Ok
	 uO6okFnUrx4K3A7nutPQLkGK6Je4mIty4LjAsen/CCpZ19YnrFfIGJRROER9xX8082
	 LhDuEBFtt61LoqKRyWcqrUYhicukpYFPdJYNjQfLEmEPTzNqN217K7xo0vooaXYvsQ
	 z4POOsS7x2YaQ==
Date: Thu, 04 Dec 2025 19:00:11 +0000
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Marco Elver <elver@google.com>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: m.wieczorretman@pm.me, jiayuan.chen@linux.dev, stable@vger.kernel.org, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] kasan: Unpoison vms[area] addresses with a common tag
Message-ID: <873821114a9f722ffb5d6702b94782e902883fdf.1764874575.git.m.wieczorretman@pm.me>
In-Reply-To: <cover.1764874575.git.m.wieczorretman@pm.me>
References: <cover.1764874575.git.m.wieczorretman@pm.me>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 68527f4c7d069f0e80ad4d48c006acca2241fe68
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
Cc: <stable@vger.kernel.org> # 6.1+
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v3:
- Redo the patch by using a flag instead of a new argument in
  __kasan_unpoison_vmalloc() (Andrey Konovalov)

Changelog v2:
- Revise the whole patch to match the fixed refactorization from the
  first patch.

Changelog v1:
- Rewrite the patch message to point at the user impact of the issue.
- Move helper to common.c so it can be compiled in all KASAN modes.

 mm/kasan/common.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 1ed6289d471a..496bb2c56911 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -591,11 +591,28 @@ void __kasan_unpoison_vmap_areas(struct vm_struct **v=
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
+=09if (flags & KASAN_VMALLOC_KEEP_TAG) {
+=09=09pr_warn("KASAN_VMALLOC_KEEP_TAG flag shouldn't be already set!\n");
+=09=09return;
+=09}
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



