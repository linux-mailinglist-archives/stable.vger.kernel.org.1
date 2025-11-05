Return-Path: <stable+bounces-192490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24CDC35238
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 11:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4957C5635BE
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 10:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C613A305078;
	Wed,  5 Nov 2025 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="SXTGtxux"
X-Original-To: stable@vger.kernel.org
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00D1305E1F
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339187; cv=none; b=EnebGyKZVTa/vLDsteELBTpb3xXl070a/+yrXp6+y164kMy71/tnDj8a/goHNh6mCLkdp+stU8i5G4I3qSQwkDaZXtW+Aq/Hsl5B40I7NnWdlYrAsw+TXsv5SUV8qqkt0U2XqyNXDmrnLaIq5P+0sSMcQXxDdW9TA7B3apLlTuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339187; c=relaxed/simple;
	bh=ZIU/g0f3ujVCoVHFZcUoc+tRtgmFrNOpcE/V/s5QBnc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LB3J7sRFiXP/4idQfE4zH+t07iBW+IBYakxvkTp6+FlDTjqIcBo6aQYXiXzoiXlx0/tR8ASEr90p8jbvap6Zset7WGSrR/kXeS61SLhUpRuUiSz9o8tLbP2mJkk6oGT8btSIqL6H6pZfqoMfh1FdVCuWQYT1mqdqqBSZ9VQhA3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=SXTGtxux; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1762339182; x=1762598382;
	bh=fZU25+bCLq4D6+jp/5EA8hJsFqIIvHsWyKp0ucrZ3c0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SXTGtxuxL028rdm3htg4zrochHSggNQRjRRAqQAbc9AP9sPGuAPBaJ0esAdk6ObVC
	 f+6sEWVF4SEQ2NU0kmN6a+Lu7CqQeKAozRos0pvMBiASq3hhGanrim8FdoMFDTtE//
	 R0/HoCz2JOeXkLy57jfc/9b3ZRotC3qjHyMO2y3D61RjE4ZXTNWnoFyWMpHqsIzZ7e
	 KEnOFTMsJAPQmNy8FY2zN82YOrRf/Mih5oUnvJrSMF0o5CXGgSrvY7Rqfhr+rgKYJQ
	 8exk0bv2ajecqEdR2bucMgDV9r8F9iVV8bBjseM93A6PyNzEJr75u93s0HyZuveWuW
	 rH+mpCRh/PtDg==
Date: Wed, 05 Nov 2025 10:39:37 +0000
To: Andrey Konovalov <andreyknvl@gmail.com>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>, stable@vger.kernel.org, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Baoquan He <bhe@redhat.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 1/2] kasan: Unpoison pcpu chunks with base address tag
Message-ID: <uhjap3ppoeglldgbu7wtsz57dqmtbntwfssnqfbsnkebni2mdm@7i67d3zoxqbe>
In-Reply-To: <CA+fCnZefD8F7rMu3-M4uDTbWR5R8y7qfLzjrB34sK3bz4di03g@mail.gmail.com>
References: <cover.1762267022.git.m.wieczorretman@pm.me> <821677dd824d003cc5b7a77891db4723e23518ea.1762267022.git.m.wieczorretman@pm.me> <CA+fCnZefD8F7rMu3-M4uDTbWR5R8y7qfLzjrB34sK3bz4di03g@mail.gmail.com>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: c3c3d40e79cb1f13113d2e16d176828d0dc0a69a
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2025-11-05 at 02:12:49 +0100, Andrey Konovalov wrote:
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
...
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
>>         }
>>         return true;
>>  }
>> +
>> +void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms)
>> +{
>> +       int area;
>> +
>> +       for (area =3D 0 ; area < nr_vms ; area++) {
>> +               kasan_poison(vms[area]->addr, vms[area]->size,
>> +                            arch_kasan_get_tag(vms[area]->addr), false)=
;
>
>The patch description says this patch is a refactoring, but the patch
>changes the logic of the code.
>
>We don't call __kasan_unpoison_vmalloc() anymore and don't perform all
>the related checks. This might be OK, assuming the checks always
>succeed/fail, but this needs to be explained (note that there two
>versions of __kasan_unpoison_vmalloc() with different checks).
>
>And also we don't assign a random tag anymore - we should.

Thanks for the pointers, I'll revise the two versions and make it an actual
refactor.

>Also, you can just use get/set_tag(), no need to use the arch_ version
>(and in the following patch too).

Thanks :)

--=20
Kind regards
Maciej Wiecz=C3=B3r-Retman


