Return-Path: <stable+bounces-192492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F2DC354D2
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 12:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6E21899AF6
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 11:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0ED30F551;
	Wed,  5 Nov 2025 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="IynIMTyr"
X-Original-To: stable@vger.kernel.org
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBA230FC00
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 11:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341195; cv=none; b=Ipw1QG7llcdphIT2jgKTpkDaXcT9U2WD6bPKC6LH8oZqw6CYwOu+gYCBvlpqZ/FAJzyUMYx/eBgvtiqFSK8/xNlvDDulCGTVEdiUczWq6Ny76HT+mkdeBXyDUVZAvS7ffMyEN976vnBiLV8h5OChVA7sYmDxL2JmztV3KTs1w9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341195; c=relaxed/simple;
	bh=nQMee2/Jkv7M+Rcqa58Sh+4rIg8reEy8IZtYmf6VepA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qw3dkT/WEHiQhXctYSRQFCQuJkR1+l95RQfX4jvhi5iQWbO7FYmL9I7Hvf4119DMslB6YFfQ8cTRnpJkaCrznTXiIRO76Q80sC81uq63eY9J1cmlPp1bU5pFzPr1LwOBSwl51F3+ENlMeNf+qo6cip6br5+u3nIgtkAV8K8l2Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=IynIMTyr; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1762341185; x=1762600385;
	bh=MhOL772gDQt3HjlEW0CKt9Wxom0RYSxrQeQWZ+rjImo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IynIMTyrNWBlf4PhOmhXwPzcshBVn1bvwsGpIzoT+fFZDNBYsCY4t116aDu5ENCsc
	 u9OIwrF5zikcMNOI4NqGkovwN0zaLpnRkdAi8buGUu73pc2/Lx2E8WX5oO+yea9aoQ
	 Jy2u/U/p3nX5d7IeaKkUJWrgP2GiCNnwyU1Nu06Ej/WO2Wsa7jSSvRL1WJ7F0NOKiZ
	 mWJD/b9C6YCsfwZIqlOUqqKmByhU1SzSAlsOWuMpaoyOBxMcPIsTZ/mOrIT9Vx+eLS
	 KwGAJ9Vk6UVm3LoycXsk4/SVrr2juYIj0IrzoyNXaIdWOPk5qqNDZzq/L2wnbxUb/D
	 RGQbgT+gxlcEQ==
Date: Wed, 05 Nov 2025 11:13:00 +0000
To: Andrey Konovalov <andreyknvl@gmail.com>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Marco Elver <elver@google.com>, stable@vger.kernel.org, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Baoquan He <bhe@redhat.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] kasan: Unpoison vms[area] addresses with a common tag
Message-ID: <cc4xh64s47ftujtp76hizmjqaczbgpzvmpbtzjtya2tuqyc75x@3obiajea2eem>
In-Reply-To: <CA+fCnZdUMTQNq=hgn8KbNwv2+LsRqoZ_R0CK0uWnjB41nHzvyg@mail.gmail.com>
References: <cover.1762267022.git.m.wieczorretman@pm.me> <cf8fe0ffcdbf54e06d9df26c8473b123c4065f02.1762267022.git.m.wieczorretman@pm.me> <CA+fCnZdUMTQNq=hgn8KbNwv2+LsRqoZ_R0CK0uWnjB41nHzvyg@mail.gmail.com>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 9bc93b4823ad8fa97869a332ca0a7f37c2bec3e2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2025-11-05 at 02:13:22 +0100, Andrey Konovalov wrote:
>On Tue, Nov 4, 2025 at 3:49=E2=80=AFPM Maciej Wieczor-Retman
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
>> Unpoison all vm_structs after allocating them for the percpu allocator.
>> Use the same tag to resolve the pcpu chunk address mismatch.
>>
>> Fixes: 1d96320f8d53 ("kasan, vmalloc: add vmalloc tagging for SW_TAGS")
>> Cc: <stable@vger.kernel.org> # 6.1+
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> Tested-by: Baoquan He <bhe@redhat.com>
>> ---
>> Changelog v1 (after splitting of from the KASAN series):
>> - Rewrite the patch message to point at the user impact of the issue.
>> - Move helper to common.c so it can be compiled in all KASAN modes.
>>
>>  mm/kasan/common.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
>> index c63544a98c24..a6bbc68984cd 100644
>> --- a/mm/kasan/common.c
>> +++ b/mm/kasan/common.c
>> @@ -584,12 +584,20 @@ bool __kasan_check_byte(const void *address, unsig=
ned long ip)
>>         return true;
>>  }
>>
>> +/*
>> + * A tag mismatch happens when calculating per-cpu chunk addresses, bec=
ause
>> + * they all inherit the tag from vms[0]->addr, even when nr_vms is bigg=
er
>> + * than 1. This is a problem because all the vms[]->addr come from sepa=
rate
>> + * allocations and have different tags so while the calculated address =
is
>> + * correct the tag isn't.
>> + */
>>  void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms)
>>  {
>>         int area;
>>
>>         for (area =3D 0 ; area < nr_vms ; area++) {
>>                 kasan_poison(vms[area]->addr, vms[area]->size,
>> -                            arch_kasan_get_tag(vms[area]->addr), false)=
;
>> +                            arch_kasan_get_tag(vms[0]->addr), false);
>> +               arch_kasan_set_tag(vms[area]->addr, arch_kasan_get_tag(v=
ms[0]->addr));
>
>set_tag() does not set the tag in place, its return value needs to be assi=
gned.

Right, not sure how I missed that

>
>So if this patch fixes the issue, there's something off (is
>vms[area]->addr never used for area !=3D 0)?

Maybe there is something off with my tests then. I'll try to run them in a
couple of different environments.

--=20
Kind regards
Maciej Wiecz=C3=B3r-Retman


