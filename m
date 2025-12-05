Return-Path: <stable+bounces-200128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D900FCA6F12
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 10:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBCBD319EA92
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 08:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDD333C523;
	Fri,  5 Dec 2025 07:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="kvFx/xmZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EB633D6F6;
	Fri,  5 Dec 2025 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764921335; cv=none; b=kk9vnX0PFdysvXJ6D56fWxOgi3sbfEF9M5ZXi0rTIUTl6zzhEmHAYm5NuShhB/8R+V8Ojy9jecKekF1gSiSqqPRs9S3REqU14g7QddSGt0yAm5+yjb0rmJO8L1/+rm0dT4x69V2q36R/IK6Vtwp5SwITiVI69rVEFse6b9S3vXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764921335; c=relaxed/simple;
	bh=WrH8oMtw5SmmwLNk3h5lEY/JRSKwxQuJxd0+b1L+6sU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VcefDrbnXJpJpogq5/8Ay3YslED1Eon9QvksT8jfF8uEmcPsZj8v66yYS9OxLAckEaI1qR0LptuE7dHcCRoIWZr4we2mhkJ4oBTpJENTGdfAwugwEHEzLxw6ocfw1NQhzOIbNud9ISteaJzlLD6TCIN4q0qNm5ppIu7eSYrpXRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=kvFx/xmZ; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1764921307; x=1765180507;
	bh=eiqow6AcLnuWm1OdBsmeLZ5HYj8tUdXBpN9mWfYflcc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kvFx/xmZyPHAKz30NarZ1fmnaBZi4q2DISbTJQWJqwuiLWqwDAFVMgfVhPtW6+3lN
	 T+qcK/wAOc+iAoEXl3S7vPawn+ZnyRPN6TDEtAERsy1fLrYzuBsor82zfqMtxOlc4t
	 +F1nZwI+yDMuKL9lo5nSM+ZZlU0TDzkQBWXUKD9iECzfuY/rbsXW9PbzsPx/Tkz0s6
	 v7U1YgNPKDOIga4EX5jagdZde9ME/o+/Zl5cQzdzn+MWFQFQwlmJIqQwlXkfZYXS3G
	 owBB+wERT44JXHTbDhbzHcvuDHa35BRdf10UqUILaekSYK6iW927qQDuAQ2PTE49dG
	 gyXSGcJBIbWUQ==
Date: Fri, 05 Dec 2025 07:55:02 +0000
To: Andrey Konovalov <andreyknvl@gmail.com>
From: =?utf-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <m.wieczorretman@pm.me>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marco Elver <elver@google.com>, jiayuan.chen@linux.dev, stable@vger.kernel.org, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] kasan: Unpoison vms[area] addresses with a common tag
Message-ID: <qg2tmzw5me43idoal3egqtr5i6rdizhxsaybtsesahec3lrrus@3ccq3qtarfyj>
In-Reply-To: <CA+fCnZfBqNKAkwKmdu7YAPWjPDWY=wRkUiWuYjEzK4_tNhSGFA@mail.gmail.com>
References: <cover.1764874575.git.m.wieczorretman@pm.me> <873821114a9f722ffb5d6702b94782e902883fdf.1764874575.git.m.wieczorretman@pm.me> <CA+fCnZeuGdKSEm11oGT6FS71_vGq1vjq-xY36kxVdFvwmag2ZQ@mail.gmail.com> <20251204192237.0d7a07c9961843503c08ebab@linux-foundation.org> <CA+fCnZfBqNKAkwKmdu7YAPWjPDWY=wRkUiWuYjEzK4_tNhSGFA@mail.gmail.com>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 0439dadbcca67de10a77ca7cb46b286e26d6834d
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for checking the patches out, do you want me to send v4 with this
correction or is it redundant now that Andrew already wrote it?

Kind regards
Maciej Wiecz=C3=B3r-Retman

On 2025-12-05 at 04:38:27 +0100, Andrey Konovalov wrote:
>On Fri, Dec 5, 2025 at 4:22=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>>
>> On Fri, 5 Dec 2025 02:09:06 +0100 Andrey Konovalov <andreyknvl@gmail.com=
> wrote:
>>
>> > > --- a/mm/kasan/common.c
>> > > +++ b/mm/kasan/common.c
>> > > @@ -591,11 +591,28 @@ void __kasan_unpoison_vmap_areas(struct vm_str=
uct **vms, int nr_vms,
>> > >         unsigned long size;
>> > >         void *addr;
>> > >         int area;
>> > > +       u8 tag;
>> > > +
>> > > +       /*
>> > > +        * If KASAN_VMALLOC_KEEP_TAG was set at this point, all vms[=
] pointers
>> > > +        * would be unpoisoned with the KASAN_TAG_KERNEL which would=
 disable
>> > > +        * KASAN checks down the line.
>> > > +        */
>> > > +       if (flags & KASAN_VMALLOC_KEEP_TAG) {
>> >
>> > I think we can do a WARN_ON() here: passing KASAN_VMALLOC_KEEP_TAG to
>> > this function would be a bug in KASAN annotations and thus a kernel
>> > bug. Therefore, printing a WARNING seems justified.
>>
>> This?
>>
>> --- a/mm/kasan/common.c~kasan-unpoison-vms-addresses-with-a-common-tag-f=
ix
>> +++ a/mm/kasan/common.c
>> @@ -598,7 +598,7 @@ void __kasan_unpoison_vmap_areas(struct
>>          * would be unpoisoned with the KASAN_TAG_KERNEL which would dis=
able
>>          * KASAN checks down the line.
>>          */
>> -       if (flags & KASAN_VMALLOC_KEEP_TAG) {
>> +       if (WARN_ON_ONCE(flags & KASAN_VMALLOC_KEEP_TAG)) {
>>                 pr_warn("KASAN_VMALLOC_KEEP_TAG flag shouldn't be alread=
y set!\n");
>>                 return;
>>         }
>> _
>>
>
>Can also drop pr_warn(), but this is fine too. Thanks!


