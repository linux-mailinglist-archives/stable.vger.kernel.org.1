Return-Path: <stable+bounces-199966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A6FCA2BB5
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 09:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74D5130285F9
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 08:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B527A325492;
	Thu,  4 Dec 2025 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="cKTHayI7"
X-Original-To: stable@vger.kernel.org
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394003218B8
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835287; cv=none; b=hHabOZJq902qMQUMS4e37REDTZoN/WPVhIdo/QKe6L7N2sZRGhkVKXRVESVsmH10m3DaL+kaWO0eGosBsdy4Enh0QbKC+B1ADjxlU1q5uyD44kmXM1pZsBjkEqJv4dzvpgabXtC+STtCmBpAYUcjaQfedlVDb8KDRcBfb6KvqPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835287; c=relaxed/simple;
	bh=E1Wk/0nNR6+P/CX9MKpY8SSb9fRlCkM0kQehwNkCTgQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRPlOd/e+OZmqZvzVUkFiKvu0PqCZ4v3BFeJZj1Q+AH+lCEaG/4w0ut4p+VyqwDxhVQAusM9w6qxri4HCEx3ys3XKYo9aBRlJK7N+iEvPHgMYNODGy0RB4i4j8RhD73t5w4lTJCuxQ8To42/3sANwaNxn2AX67/CLsxCUp7aJYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=cKTHayI7; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1764835259; x=1765094459;
	bh=i4FXTFHzuPffFYRyp6V0hVOyP7tuWfTZncVwhcPuX9A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cKTHayI7NDW43zw81lUMTpPRn9uwQkUbRr+XYxDJM0qNryYWACf2aStPOFZN6prqY
	 v/mzdDGKBptFGjxNarTkl2bTp9fJcP1JksTFjOCDqj5uyG4LpLSBNMKt8CXZaSz0h0
	 tl4jVcMY2ifJaMmqdU9/XzsWFbyH11awkHT64+5FMNavyPQ1ooD0J0CkLAbaX32Hjs
	 HZXoe5w7chAGg6EUdLqoOHk6XOWkdu08tx5sgVjjeCzFsZvQrYRSKjaZvqcIH79MmM
	 nCuQaiw98Ytz7ZP0kzftNNs+JCtLPYailKgiRTH3unnBC5SdiYg+OzuWa5du4sT4BW
	 QAoXk4koBlPuw==
Date: Thu, 04 Dec 2025 08:00:54 +0000
To: Andrey Konovalov <andreyknvl@gmail.com>
From: =?utf-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <m.wieczorretman@pm.me>
Cc: jiayuan.chen@linux.dev, Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Marco Elver <elver@google.com>, stable@vger.kernel.org, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] kasan: Unpoison vms[area] addresses with a common tag
Message-ID: <yb3cniky6tpgwmdkp5652dzrbkkplkzsrywl76borcb7b4zmya@s4smffgybwgf>
In-Reply-To: <CA+fCnZeCayQN3448h6zWy55wc4SpDZ30Xr8WVYW7KQSrxNxhFw@mail.gmail.com>
References: <cover.1764685296.git.m.wieczorretman@pm.me> <325c5fa1043408f1afe94abab202cde9878240c5.1764685296.git.m.wieczorretman@pm.me> <CA+fCnZdzBdC4hdjOLa5U_9g=MhhBfNW24n+gHpYNqW8taY_Vzg@mail.gmail.com> <phrugqbctcakjmy2jhea56k5kwqszuua646cxfj4afrj5wk4wg@gdji4pf7kzhz> <CA+fCnZeCayQN3448h6zWy55wc4SpDZ30Xr8WVYW7KQSrxNxhFw@mail.gmail.com>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 25c7909c6bfc2f467818931ed514a481d5a0ae37
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2025-12-04 at 01:43:36 +0100, Andrey Konovalov wrote:
>On Wed, Dec 3, 2025 at 5:24=E2=80=AFPM Maciej Wiecz=C3=B3r-Retman
><m.wieczorretman@pm.me> wrote:
>> I was sure the vms[0]->addr was already tagged (I recall checking this
>> so I'm not sure if something changed or my previous check was wrong) but
>> the problem here is that vms[0]->addr, vms[1]->addr ... were unpoisoned
>> with random addresses, specifically different random addresses. So then
>> later in the pcpu chunk code vms[1] related pointers would get the tag
>> from vms[0]->addr.
>>
>> So I think we still need a separate way to do __kasan_unpoison_vmalloc
>> with a specific tag.
>
>Why?
>
>Assuming KASAN_VMALLOC_KEEP_TAG takes the tag from the pointer, just do:
>
>tag =3D kasan_random_tag();
>for (area =3D 0; ...) {
>    vms[area]->addr =3D set_tag(vms[area]->addr, tag);
>    __kasan_unpoison_vmalloc(vms[area]->addr, vms[area]->size, flags |
>KASAN_VMALLOC_KEEP_TAG);
>}
>
>Or maybe even better:
>
>vms[0]->addr =3D __kasan_unpoison_vmalloc(vms[0]->addr, vms[0]->size, flag=
s);
>tag =3D get_tag(vms[0]->addr);
>for (area =3D 1; ...) {
>    vms[area]->addr =3D set_tag(vms[area]->addr, tag);
>    __kasan_unpoison_vmalloc(vms[area]->addr, vms[area]->size, flags |
>KASAN_VMALLOC_KEEP_TAG);
>}
>
>This way we won't assign a random tag unless it's actually needed
>(i.e. when KASAN_VMALLOC_PROT_NORMAL is not provided; assuming we care
>to support that case).

Oh, right yes, that would work nicely. I thought putting these behind
helpers would end up clean but this is very neat too.

I suppose I'll wait for Jiayuan to update his patch and then I'll make
these changes on top of that.

Thanks! :)

--=20
Kind regards
Maciej Wiecz=C3=B3r-Retman


