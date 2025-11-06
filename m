Return-Path: <stable+bounces-192624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB920C3BF20
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 16:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B893F4F491D
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 15:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA15C345CB3;
	Thu,  6 Nov 2025 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="GDYgoEl4"
X-Original-To: stable@vger.kernel.org
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E982A3451AE
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441267; cv=none; b=hhAlxBaZEtIBz/BcZE1aW15cCvtcRZa5PY0u4CuEUbbo3bcp0WohA/CcKNXC/YOETIxcQi4le2aAKo7hUyGy7Z+CS2QMdF0uH5YuwyVlWBY3qt/wZZDp6gAhDBcCzH4OLzi1nXQPyO+QC2BlYR24Mgj8xWgUPwF+vNldPJM04E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441267; c=relaxed/simple;
	bh=vOLSZCP+9mJjD/w5bHEK4PSG6JNi4Vvac0nQEDaz1Qc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2304rr/Qr7cP816Yg+hpHShQS7vHn8Cm7sRdsxe+XLF78xfemQ8/XvOIACdy20sqiHpyWtMBPklwyIW9GR9gN2UErXsfbL6zrTli2UsSDk/0MMCDYkqpJVtSjljO4I3/t+6kzB2ToMqefOxDcqfVPr+PbXgZyBNeN9fYDHcEIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=GDYgoEl4; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1762441258; x=1762700458;
	bh=N20bsF88qmtxzuIu4gZ0s1r8sTe/QYH+2BKK9mK/6ww=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GDYgoEl4LngLY9+ZW1gVaKIEyG1SHIh1SrAsD0+vRBpdfjCgYfaPLDAPwJfY3+yzw
	 FM3YmOlNxdYCwvJIbRt5N+t44b4i6tycDlu2qT+b9CTSO2CW3ZuVk4ODp1LRjvE+zq
	 U6/rFnbBoh6thQdjr+7rJvDv8h1HYgsLNqtsX7U/Z+hlsF5GCWKAjXB1dzGUj8uGhh
	 Z9hvn1NzeQJfGZMeqGeoKSj/c8khdplqqaypqby7h+36/mTHSXYtuOq4GYSm8VSr17
	 Wm6KvSW8MZ4R139G/SiBRC0gjQ5eTyQXUndhuv6XFYXclR1d11kW1EM+NN+7EeIvxE
	 JzF/g66ef3xhg==
Date: Thu, 06 Nov 2025 15:00:48 +0000
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
From: =?utf-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <m.wieczorretman@pm.me>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>, stable@vger.kernel.org, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Baoquan He <bhe@redhat.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 1/2] kasan: Unpoison pcpu chunks with base address tag
Message-ID: <v75jgljobtrc6d7plw2x5caloipqkclfhh6w3quylarqrzczkk@5blzaptwme4l>
In-Reply-To: <00818656-41d0-4ebd-8a82-ad6922586ac4@lucifer.local>
References: <cover.1762267022.git.m.wieczorretman@pm.me> <821677dd824d003cc5b7a77891db4723e23518ea.1762267022.git.m.wieczorretman@pm.me> <00818656-41d0-4ebd-8a82-ad6922586ac4@lucifer.local>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 321924270825e08940ed773dce8975504f8a0244
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

As Andrey noticed I'll have to rework this function to be a proper
refactor of the previous thing.

This solution seems okay, after noticing the issue I was thinking about
adding a new file for vmalloc code that is shared between different
KASAN modes. But I'll have to add different mode code in here too
anyway. So it's probably okay to keep this function behind the ifdef, I
see shadow.c and hw-tags.c doing something similar too.

On 2025-11-05 at 22:00:41 +0000, Lorenzo Stoakes wrote:
>Hi,
>
>This patch is breaking the build for mm-new with KASAN enabled:
>
>mm/kasan/common.c:587:6: error: no previous prototype for =E2=80=98__kasan=
_unpoison_vmap_areas=E2=80=99 [-Werror=3Dmissing-prototypes]
>  587 | void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vm=
s)
>
>Looks to be because CONFIG_KASAN_VMALLOC is not set in my configuration, s=
o you
>probably need to do:
>
>#ifdef CONFIG_KASAN_VMALLOC
>void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms)
>{
>=09int area;
>
>=09for (area =3D 0 ; area < nr_vms ; area++) {
>=09=09kasan_poison(vms[area]->addr, vms[area]->size,
>=09=09=09     arch_kasan_get_tag(vms[area]->addr), false);
>=09}
>}
>#endif
>
>That fixes the build for me.
>
>Andrew - can we maybe apply this just to fix the build as a work around un=
til
>Maciej has a chance to see if he agrees with this fix?
>
>Thanks, Lorenzo
>
>On Tue, Nov 04, 2025 at 02:49:08PM +0000, Maciej Wieczor-Retman wrote:
>> From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>>
>> A KASAN tag mismatch, possibly causing a kernel panic, can be observed
>> on systems with a tag-based KASAN enabled and with multiple NUMA nodes.
>> It was reported on arm64 and reproduced on x86. It can be explained in
>> the following points:
>>
>> =091. There can be more than one virtual memory chunk.
>> =092. Chunk's base address has a tag.
>> =093. The base address points at the first chunk and thus inherits
>> =09   the tag of the first chunk.
>> =094. The subsequent chunks will be accessed with the tag from the
>> =09   first chunk.
>> =095. Thus, the subsequent chunks need to have their tag set to
>> =09   match that of the first chunk.
>>
>> Refactor code by moving it into a helper in preparation for the actual
>> fix.
>>
>> Fixes: 1d96320f8d53 ("kasan, vmalloc: add vmalloc tagging for SW_TAGS")
>> Cc: <stable@vger.kernel.org> # 6.1+
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> Tested-by: Baoquan He <bhe@redhat.com>
>> ---
>> Changelog v1 (after splitting of from the KASAN series):
>> - Rewrite first paragraph of the patch message to point at the user
>>   impact of the issue.
>> - Move helper to common.c so it can be compiled in all KASAN modes.
>>
>>  include/linux/kasan.h | 10 ++++++++++
>>  mm/kasan/common.c     | 11 +++++++++++
>>  mm/vmalloc.c          |  4 +---
>>  3 files changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
>> index d12e1a5f5a9a..b00849ea8ffd 100644
>> --- a/include/linux/kasan.h
>> +++ b/include/linux/kasan.h
>> @@ -614,6 +614,13 @@ static __always_inline void kasan_poison_vmalloc(co=
nst void *start,
>>  =09=09__kasan_poison_vmalloc(start, size);
>>  }
>>
>> +void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms);
>> +static __always_inline void kasan_unpoison_vmap_areas(struct vm_struct =
**vms, int nr_vms)
>> +{
>> +=09if (kasan_enabled())
>> +=09=09__kasan_unpoison_vmap_areas(vms, nr_vms);
>> +}
>> +
>>  #else /* CONFIG_KASAN_VMALLOC */
>>
>>  static inline void kasan_populate_early_vm_area_shadow(void *start,
>> @@ -638,6 +645,9 @@ static inline void *kasan_unpoison_vmalloc(const voi=
d *start,
>>  static inline void kasan_poison_vmalloc(const void *start, unsigned lon=
g size)
>>  { }
>>
>> +static inline void kasan_unpoison_vmap_areas(struct vm_struct **vms, in=
t nr_vms)
>> +{ }
>> +
>>  #endif /* CONFIG_KASAN_VMALLOC */
>>
>>  #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) &&=
 \
>> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
>> index d4c14359feaf..c63544a98c24 100644
>> --- a/mm/kasan/common.c
>> +++ b/mm/kasan/common.c
>> @@ -28,6 +28,7 @@
>>  #include <linux/string.h>
>>  #include <linux/types.h>
>>  #include <linux/bug.h>
>> +#include <linux/vmalloc.h>
>>
>>  #include "kasan.h"
>>  #include "../slab.h"
>> @@ -582,3 +583,13 @@ bool __kasan_check_byte(const void *address, unsign=
ed long ip)
>>  =09}
>>  =09return true;
>>  }
>> +
>> +void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms)
>> +{
>> +=09int area;
>> +
>> +=09for (area =3D 0 ; area < nr_vms ; area++) {
>> +=09=09kasan_poison(vms[area]->addr, vms[area]->size,
>> +=09=09=09     arch_kasan_get_tag(vms[area]->addr), false);
>> +=09}
>> +}
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index 798b2ed21e46..934c8bfbcebf 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -4870,9 +4870,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigne=
d long *offsets,
>>  =09 * With hardware tag-based KASAN, marking is skipped for
>>  =09 * non-VM_ALLOC mappings, see __kasan_unpoison_vmalloc().
>>  =09 */
>> -=09for (area =3D 0; area < nr_vms; area++)
>> -=09=09vms[area]->addr =3D kasan_unpoison_vmalloc(vms[area]->addr,
>> -=09=09=09=09vms[area]->size, KASAN_VMALLOC_PROT_NORMAL);
>> +=09kasan_unpoison_vmap_areas(vms, nr_vms);
>>
>>  =09kfree(vas);
>>  =09return vms;
>> --
>> 2.51.0
>>
>>
>>


