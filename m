Return-Path: <stable+bounces-199225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C704CA0421
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 18:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 699C93003077
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98683451CD;
	Wed,  3 Dec 2025 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="lEgqJXRZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB8C3451B0
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779101; cv=none; b=iLwFAIj4kxNk68IxHtsAN0MVuG9T5DixLfB1tvP3mc110BZuET1A7jMhdcWm0Mtm9RTr3eu9bYWbkTc0J0UlJZvBp0DSrJyOsNjvEATIWEWrLtOZ6PRqRDzZmqwOj3kseSPoLh+IxzfgFE3OEE4HQ6GAlsuWhKWzamfGo2YjCnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779101; c=relaxed/simple;
	bh=rN8l9g9xmeNI40ioI37JBxpNYuQXpnuB7KF+RA2lcfI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/k8imcmg6I8cWNICg+d/1kNE3UaNOsTggdcxKx6X+ZCL0v5tD8oUmKQeNisxg8jcetgnqx2XokQrt6Ujgx/k6ufduNYWFT/LGicCCEFJ7aHUP++9sUAUZB2StVtbKJvX997YSrGVDSMbbQgIdwSgGX9YYT9SODjFZFfKKD9zfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=lEgqJXRZ; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1764779083; x=1765038283;
	bh=uYhB0X4kqL3Bw7rIqDJ1oTSdN5flbXlU0EovctUC5cg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lEgqJXRZLW4oBURmYtj6mfljuMNw2sHU3RyU0n8jtqXfnoRWGI63Pxk6Q0tzxL7+j
	 s7aNz8ueEwlJCIY+Ux3q/ZJDIZwXNSxBIe9mUfdOzWu73XT0bcOzJIxEklLTbNhyqI
	 cWrM3vODcmVKzWxg/44O4ukTCb5AtYj8n217QIzWe3OdgZbFItTvzDy4NkJ0S3Pn61
	 YFfDNAybDHiRv2IlgCg/lWP/rtqjWsups+PZgT9+u187vckvKPkqmlPnH6bpsS3CjQ
	 w7t6j1pOrAkYN7DfEfghad+qdm8bha+5Ye1uOCEpQ/Cm8LjBLzGTgaQyW1f1hkyZyF
	 vBeGV7ZrbBTJA==
Date: Wed, 03 Dec 2025 16:24:36 +0000
To: Andrey Konovalov <andreyknvl@gmail.com>
From: =?utf-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <m.wieczorretman@pm.me>
Cc: jiayuan.chen@linux.dev, Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Marco Elver <elver@google.com>, stable@vger.kernel.org, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] kasan: Unpoison vms[area] addresses with a common tag
Message-ID: <phrugqbctcakjmy2jhea56k5kwqszuua646cxfj4afrj5wk4wg@gdji4pf7kzhz>
In-Reply-To: <CA+fCnZdzBdC4hdjOLa5U_9g=MhhBfNW24n+gHpYNqW8taY_Vzg@mail.gmail.com>
References: <cover.1764685296.git.m.wieczorretman@pm.me> <325c5fa1043408f1afe94abab202cde9878240c5.1764685296.git.m.wieczorretman@pm.me> <CA+fCnZdzBdC4hdjOLa5U_9g=MhhBfNW24n+gHpYNqW8taY_Vzg@mail.gmail.com>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 4ee2cb0b262a61c236058e955b9c6d1886736ca1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2025-12-03 at 16:53:01 +0100, Andrey Konovalov wrote:
>On Tue, Dec 2, 2025 at 3:29=E2=80=AFPM Maciej Wieczor-Retman
><m.wieczorretman@pm.me> wrote:
>>
>> From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>>
>> A KASAN tag mismatch, possibly causing a kernel panic, can be observed
>> on systems with a tag-based KASAN enabled and with multiple NUMA nodes.
>> It was reported on arm64 and reproduced on x86. It can be explained in
>> the following points:
>>
>>         1. There can be more than one virtual memory chunk.
>>         2. Chunk's base address has a tag.
>>         3. The base address points at the first chunk and thus inherits
>>            the tag of the first chunk.
>>         4. The subsequent chunks will be accessed with the tag from the
>>            first chunk.
>>         5. Thus, the subsequent chunks need to have their tag set to
>>            match that of the first chunk.
>>
>> Use the modified __kasan_unpoison_vmalloc() to pass the tag of the first
>> vm_struct's address when vm_structs are unpoisoned in
>> pcpu_get_vm_areas(). Assigning a common tag resolves the pcpu chunk
>> address mismatch.
>>
>> Fixes: 1d96320f8d53 ("kasan, vmalloc: add vmalloc tagging for SW_TAGS")
>> Cc: <stable@vger.kernel.org> # 6.1+
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>> Changelog v2:
>> - Revise the whole patch to match the fixed refactorization from the
>>   first patch.
>>
>> Changelog v1:
>> - Rewrite the patch message to point at the user impact of the issue.
>> - Move helper to common.c so it can be compiled in all KASAN modes.
>>
>>  mm/kasan/common.c  |  3 ++-
>>  mm/kasan/hw_tags.c | 12 ++++++++----
>>  mm/kasan/shadow.c  | 15 +++++++++++----
>>  3 files changed, 21 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
>> index 7884ea7d13f9..e5a867a5670b 100644
>> --- a/mm/kasan/common.c
>> +++ b/mm/kasan/common.c
>> @@ -591,11 +591,12 @@ void kasan_unpoison_vmap_areas(struct vm_struct **=
vms, int nr_vms,
>>         unsigned long size;
>>         void *addr;
>>         int area;
>> +       u8 tag =3D get_tag(vms[0]->addr);
>>
>>         for (area =3D 0 ; area < nr_vms ; area++) {
>>                 size =3D vms[area]->size;
>>                 addr =3D vms[area]->addr;
>> -               vms[area]->addr =3D __kasan_unpoison_vmap_areas(addr, si=
ze, flags);
>> +               vms[area]->addr =3D __kasan_unpoison_vmap_areas(addr, si=
ze, flags, tag);
>
>I'm thinking what you can do here is:
>
>vms[area]->addr =3D set_tag(addr, tag);
>__kasan_unpoison_vmalloc(addr, size, flags | KASAN_VMALLOC_KEEP_TAG);


I noticed that something like this wouldn't work once I started trying
to rebase my work onto Jiayuan's. The line:
+       u8 tag =3D get_tag(vms[0]->addr);
is wrong and should be
+       u8 tag =3D kasan_random_tag();
I was sure the vms[0]->addr was already tagged (I recall checking this
so I'm not sure if something changed or my previous check was wrong) but
the problem here is that vms[0]->addr, vms[1]->addr ... were unpoisoned
with random addresses, specifically different random addresses. So then
later in the pcpu chunk code vms[1] related pointers would get the tag
from vms[0]->addr.

So I think we still need a separate way to do __kasan_unpoison_vmalloc
with a specific tag.

>
>This is with the assumption that Jiayuan's patch is changed to add
>KASAN_VMALLOC_KEEP_TAG to kasan_vmalloc_flags_t.
>
>Then you should not need that extra __kasan_random_unpoison_vmalloc helper=
.

I already rewrote the patch rebased onto Jiayuan's patch. I was able to
ditch the __kasan_random_unpoison_vmalloc but I needed to add
__kasan_unpoison_vrealloc - so I can pass the tag of the start pointer
to __kasan_unpoison_vmalloc. I was hoping to post it today/tomorrow so
Jiayuan can check my changes don't break his solution. I'm just waiting
to check it compiles against all the fun kernel configs.

--=20
kind regards
Maciej Wiecz=C3=B3r-Retman


