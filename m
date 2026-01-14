Return-Path: <stable+bounces-208355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFC3D1EB64
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 13:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AB3C306EAED
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 12:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A3C395245;
	Wed, 14 Jan 2026 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="KlGVeJ/m"
X-Original-To: stable@vger.kernel.org
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEA9304BCB
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393050; cv=none; b=P413Ou0EGCx/Wu+OtQ0BZnVSg8h6+YOR2FNkLQZw/dIQtImk3Hdmz9/Gy1lyhVI1Ep7bNyiHGc95xcXDaC8+rAHoQ24ThQkeyrqN7bRtbfP8mgmos32tGxvj04WLfbpPjPYfxxVFw+xmIYAYijLoSQsxUtFt07ZJjxvfatJaILo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393050; c=relaxed/simple;
	bh=ccJsKRNjZBnySW4Ku+fzxER7ls1LX2R6+aB7PGzcvAQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jve5kKZiBwku0AsnPu7ezDm8Sfqk8VaihUFoMNLcxKkNnZl70NPmDm48Q+MGVWR/MJkrsUmioVruhlSRFMcrsG5FONlYJT046qa+p9uXry3L3h+QITQbxGi/tlT1sJhhfkU+3AzYTUyuMBnUs95j7Dba61gAuXQltnceFMHietA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=KlGVeJ/m; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1768393040; x=1768652240;
	bh=38Vfj0jf5OEFbTnSianKjy7lCeGnbxOyBRt1UQTdjUY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KlGVeJ/mpzbSvLJukRjrqyUIhoOMgUz1f5jmbnEcVI+ECOgljv1sbTT0TAs8DxhiA
	 F0VRTDX1oLIPWgwzmiktz66MmqSxjXW1mn1zExnvPKvnldrzJn+thG60F4pAbh1Lng
	 GM5tAOwYAN5jde/hZpLU+SIT5+ejVg3ZZq29yWK4TAD7td10yAg0xofF1nNOQIDlZt
	 2yDhqa7+FwbEH6mDgH9aKjCK7xg7Dvv6BtL27F2Pa2EO4ZJFUGxDyiT9J5NVDlKIC2
	 r2vdzfG9KSqDtPxyqPRVlM2Hpc1SZY4yBCZAIFUGbsH77zEvkkydQyL2HC7YMjKczq
	 R6d4dxXQWSvVQ==
Date: Wed, 14 Jan 2026 12:17:13 +0000
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: Andrew Morton <akpm@linux-foundation.org>, =?utf-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com, Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, joonki.min@samsung-slsi.corp-partner.google.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/kasan: Fix KASAN poisoning in vrealloc()
Message-ID: <aWd2wquw1aEB2rON@wieczorr-mobl1.localdomain>
In-Reply-To: <20260113191516.31015-1-ryabinin.a.a@gmail.com>
References: <CANP3RGeuRW53vukDy7WDO3FiVgu34-xVJYkfpm08oLO3odYFrA@mail.gmail.com> <20260113191516.31015-1-ryabinin.a.a@gmail.com>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: bf1405530f43e5d2b345f5d47b7d43e403f0b146
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tested in generic and sw_tags modes. Compiles and runs okay with and withou=
t my
KASAN sw tags patches on x86. Kunit tests also seem fine.

Tested-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

On 2026-01-13 at 20:15:15 +0100, Andrey Ryabinin wrote:
>A KASAN warning can be triggered when vrealloc() changes the requested
>size to a value that is not aligned to KASAN_GRANULE_SIZE.
>
>    ------------[ cut here ]------------
>    WARNING: CPU: 2 PID: 1 at mm/kasan/shadow.c:174 kasan_unpoison+0x40/0x=
48
>    ...
>    pc : kasan_unpoison+0x40/0x48
>    lr : __kasan_unpoison_vmalloc+0x40/0x68
>    Call trace:
>     kasan_unpoison+0x40/0x48 (P)
>     vrealloc_node_align_noprof+0x200/0x320
>     bpf_patch_insn_data+0x90/0x2f0
>     convert_ctx_accesses+0x8c0/0x1158
>     bpf_check+0x1488/0x1900
>     bpf_prog_load+0xd20/0x1258
>     __sys_bpf+0x96c/0xdf0
>     __arm64_sys_bpf+0x50/0xa0
>     invoke_syscall+0x90/0x160
>
>Introduce a dedicated kasan_vrealloc() helper that centralizes
>KASAN handling for vmalloc reallocations. The helper accounts for KASAN
>granule alignment when growing or shrinking an allocation and ensures
>that partial granules are handled correctly.
>
>Use this helper from vrealloc_node_align_noprof() to fix poisoning
>logic.
>
>Reported-by: Maciej =C5=BBenczykowski <maze@google.com>
>Reported-by: <joonki.min@samsung-slsi.corp-partner.google.com>
>Closes: https://lkml.kernel.org/r/CANP3RGeuRW53vukDy7WDO3FiVgu34-xVJYkfpm0=
8oLO3odYFrA@mail.gmail.com
>Fixes: d699440f58ce ("mm: fix vrealloc()'s KASAN poisoning logic")
>Cc: stable@vger.kernel.org
>Signed-off-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
>---
> include/linux/kasan.h |  6 ++++++
> mm/kasan/shadow.c     | 24 ++++++++++++++++++++++++
> mm/vmalloc.c          |  7 ++-----
> 3 files changed, 32 insertions(+), 5 deletions(-)
>
>diff --git a/include/linux/kasan.h b/include/linux/kasan.h
>index 9c6ac4b62eb9..ff27712dd3c8 100644
>--- a/include/linux/kasan.h
>+++ b/include/linux/kasan.h
>@@ -641,6 +641,9 @@ kasan_unpoison_vmap_areas(struct vm_struct **vms, int =
nr_vms,
> =09=09__kasan_unpoison_vmap_areas(vms, nr_vms, flags);
> }
>=20
>+void kasan_vrealloc(const void *start, unsigned long old_size,
>+=09=09unsigned long new_size);
>+
> #else /* CONFIG_KASAN_VMALLOC */
>=20
> static inline void kasan_populate_early_vm_area_shadow(void *start,
>@@ -670,6 +673,9 @@ kasan_unpoison_vmap_areas(struct vm_struct **vms, int =
nr_vms,
> =09=09=09  kasan_vmalloc_flags_t flags)
> { }
>=20
>+static inline void kasan_vrealloc(const void *start, unsigned long old_si=
ze,
>+=09=09=09=09unsigned long new_size) { }
>+
> #endif /* CONFIG_KASAN_VMALLOC */
>=20
> #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
>diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
>index 32fbdf759ea2..e9b6b2d8e651 100644
>--- a/mm/kasan/shadow.c
>+++ b/mm/kasan/shadow.c
>@@ -651,6 +651,30 @@ void __kasan_poison_vmalloc(const void *start, unsign=
ed long size)
> =09kasan_poison(start, size, KASAN_VMALLOC_INVALID, false);
> }
>=20
>+void kasan_vrealloc(const void *addr, unsigned long old_size,
>+=09=09unsigned long new_size)
>+{
>+=09if (!kasan_enabled())
>+=09=09return;
>+
>+=09if (new_size < old_size) {
>+=09=09kasan_poison_last_granule(addr, new_size);
>+
>+=09=09new_size =3D round_up(new_size, KASAN_GRANULE_SIZE);
>+=09=09old_size =3D round_up(old_size, KASAN_GRANULE_SIZE);
>+=09=09if (new_size < old_size)
>+=09=09=09__kasan_poison_vmalloc(addr + new_size,
>+=09=09=09=09=09old_size - new_size);
>+=09} else if (new_size > old_size) {
>+=09=09old_size =3D round_down(old_size, KASAN_GRANULE_SIZE);
>+=09=09__kasan_unpoison_vmalloc(addr + old_size,
>+=09=09=09=09=09new_size - old_size,
>+=09=09=09=09=09KASAN_VMALLOC_PROT_NORMAL |
>+=09=09=09=09=09KASAN_VMALLOC_VM_ALLOC |
>+=09=09=09=09=09KASAN_VMALLOC_KEEP_TAG);
>+=09}
>+}
>+
> #else /* CONFIG_KASAN_VMALLOC */
>=20
> int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
>diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>index 41dd01e8430c..2536d34df058 100644
>--- a/mm/vmalloc.c
>+++ b/mm/vmalloc.c
>@@ -4322,7 +4322,7 @@ void *vrealloc_node_align_noprof(const void *p, size=
_t size, unsigned long align
> =09=09if (want_init_on_free() || want_init_on_alloc(flags))
> =09=09=09memset((void *)p + size, 0, old_size - size);
> =09=09vm->requested_size =3D size;
>-=09=09kasan_poison_vmalloc(p + size, old_size - size);
>+=09=09kasan_vrealloc(p, old_size, size);
> =09=09return (void *)p;
> =09}
>=20
>@@ -4330,16 +4330,13 @@ void *vrealloc_node_align_noprof(const void *p, si=
ze_t size, unsigned long align
> =09 * We already have the bytes available in the allocation; use them.
> =09 */
> =09if (size <=3D alloced_size) {
>-=09=09kasan_unpoison_vmalloc(p + old_size, size - old_size,
>-=09=09=09=09       KASAN_VMALLOC_PROT_NORMAL |
>-=09=09=09=09       KASAN_VMALLOC_VM_ALLOC |
>-=09=09=09=09       KASAN_VMALLOC_KEEP_TAG);
> =09=09/*
> =09=09 * No need to zero memory here, as unused memory will have
> =09=09 * already been zeroed at initial allocation time or during
> =09=09 * realloc shrink time.
> =09=09 */
> =09=09vm->requested_size =3D size;
>+=09=09kasan_vrealloc(p, old_size, size);
> =09=09return (void *)p;
> =09}
>=20
>--=20
>2.52.0
>

--=20
Kind regards
Maciej Wiecz=C3=B3r-Retman


