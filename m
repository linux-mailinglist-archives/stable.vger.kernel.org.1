Return-Path: <stable+bounces-199571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C87CA1005
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 19:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A282930D8950
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7428034B68A;
	Wed,  3 Dec 2025 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ChzS+WEs"
X-Original-To: stable@vger.kernel.org
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785F934B413
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764780235; cv=none; b=Ul642VwN1CVaiVgcLhrGzUdN35a5mqo6qr6NWNvEg0FFA8lXkaq8xSoTr5kpLCRSYxOLTO6umOJn3CxCZSJ6bfoM/t5pheMhI7TtuuxNsi4quOK2WYZm92xlr8oEUNY20+wiImW9NMYewzLBv+bhX4cBqXvGljZMvjSx6zhGQSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764780235; c=relaxed/simple;
	bh=C347GRmJDNHW6eA8F9VxDj4f7e7nJ4BRnT7xWbVUM0M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/bav1xKhYJjQ9pAVUf/tih3i8VqkXaihBj8bg36DpjHJ+TH+OmkzCFQ+X2TCdGihgUe3+sg8vImjBkJEgnDRh7q9RVxH2LVURCJD1jcRKpBLr2MeNO0JZ7LK7wTnSEDSzkCkkSxos3WpeR97nlkafkBwdkNpjXN9aVbk3OQu4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ChzS+WEs; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1764780229; x=1765039429;
	bh=nxrvBXGpA1Q+nnlGY6f0s+0LHNsraSWWBUdSBcXFF08=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ChzS+WEsjeMWAL/FoYDDx8ErAUE1ldyouBZhZrMc58wd/Wb4ajYmXBHagzFO1uJWR
	 yBsOF7rUr7qHvjP/Cmu7iJyqfrl4VeW1O6XfEIuY92AtHWK4p+apC3NOTLchtUsG9r
	 IpvoR1lHrM8kKfm10b9mZbwaw6BudNM/yH1N0kpnzwBtdSxMsM8A1CGMU2cceRRDTT
	 zfs6HhYi3HYFAf29GkWCDS7nDiDWB3LTRBr3n3hQGfGCdI7mET+u1qWgxIbZAiFYGj
	 arZx81GcvT/9nDR1Z9Nxm9NZ9TyJEo5YFcqptxFOTr6uyzCx1scz7coSnQ3oo9E89J
	 xDFqpt2Dj2KyQ==
Date: Wed, 03 Dec 2025 16:43:43 +0000
To: Andrey Konovalov <andreyknvl@gmail.com>
From: =?utf-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <m.wieczorretman@pm.me>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>, stable@vger.kernel.org, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] kasan: Refactor pcpu kasan vmalloc unpoison
Message-ID: <bi7dif47rpmdymfu3fkuz432vv5p2tmabk5snpqo27f5fitq5x@xap7rkeqejrj>
In-Reply-To: <CA+fCnZcNoLERGmjyVV=ykD62hPRkPua4AqKE083BBm6OHmGtPw@mail.gmail.com>
References: <cover.1764685296.git.m.wieczorretman@pm.me> <3907c330d802e5b86bfe003485220de972aaac18.1764685296.git.m.wieczorretman@pm.me> <CA+fCnZcNoLERGmjyVV=ykD62hPRkPua4AqKE083BBm6OHmGtPw@mail.gmail.com>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 0dd43d3234ed39ac31442c89bad75ed3613a9e3d
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2025-12-03 at 16:53:04 +0100, Andrey Konovalov wrote:
>On Tue, Dec 2, 2025 at 3:29=E2=80=AFPM Maciej Wieczor-Retman
><m.wieczorretman@pm.me> wrote:
>>
>> From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>>
...
>> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
>> index d4c14359feaf..7884ea7d13f9 100644
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
>> @@ -582,3 +583,19 @@ bool __kasan_check_byte(const void *address, unsign=
ed long ip)
>>         }
>>         return true;
>>  }
>> +
>> +#ifdef CONFIG_KASAN_VMALLOC
>> +void kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms,
>> +                              kasan_vmalloc_flags_t flags)
>
>kasan_unpoison_vmap_areas() needs to be defined in
>inclunde/linux/kasan.h and call __kasan_unpoison_vmap_areas() when
>kasan_enabled() =3D=3D true, similar to the other wrappers.
>
>And check my comment for patch #2: with that, you should not need to
>add so many new __helpers: just __kasan_unpoison_vmalloc and
>__kasan_unpoison_vmap_areas should suffice.

Okay, I think I see what you mean. I was trying to avoid using
__kasan_unpoison_vmalloc() here so that it compiled properly, but that
was before I added the ifdef guard. Now there is not reason not to use
it here.

I'll make the changes you mentioned.

Kind regards
Maciej Wiecz=C3=B3r-Retman

>
>> +{
>> +       unsigned long size;
>> +       void *addr;
>> +       int area;
>> +
>> +       for (area =3D 0 ; area < nr_vms ; area++) {
>> +               size =3D vms[area]->size;
>> +               addr =3D vms[area]->addr;
>> +               vms[area]->addr =3D __kasan_unpoison_vmap_areas(addr, si=
ze, flags);
>> +       }
>> +}
>> +#endif


