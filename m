Return-Path: <stable+bounces-192463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D1BC339AB
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 02:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B755B1886178
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 01:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A7123D7C3;
	Wed,  5 Nov 2025 01:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtEKpxQt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2CD27462
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 01:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305218; cv=none; b=B6KhbNqtUdy2jZBbhHOX6j1le0aJScfH38MBpiOSlVIrVBGiXD03jc1g5cAVJRirlSa0Vxg7E4sbPnVlnfPXXXFKcxtPQBq/JBisQ9C7Glywetged38B8tQa05pH1SxYwcxaYJNwaFWFCyeS0EYYZSt0ccjRJ/43PXybxDLCLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305218; c=relaxed/simple;
	bh=5arAMjyHHi3Cwg8Wi4M3FG09zP84n+z6/YMddKV3cXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+OhpPoB5lR3B60ANdPxyxVc5jX8vz0xxsMbPDAHu1SlV/8M8plv+1oHkMLDAPsDlu5z0SbcP+DwX8H5S8iJEPFon6W9s4H1Lp0A3KOyDPb9crBS/znX7cEsfmIxgPwDbt/haCeniAwq255hAVvkUh8vwz23fbs46RltT9dq+o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtEKpxQt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-421851bca51so5182553f8f.1
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 17:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762305215; x=1762910015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87sj/urHj778WRrZXS7UN3zWW0S51mEqs7jth+xOmiY=;
        b=NtEKpxQttUF8brEGgaCLqm5qVjqRerb63hT6vLgReqdTUx0ob21Ra2PGx+MnMBbCbc
         1LMKVTZ0wCLd0FC++5EfUGV9kS/6ruhoVJvbUaqycT0QnbVVW4TFP+8Yl6D+If6Bmecj
         RKDMkw5+H5QbzTRgwRLMzljJFkBmU4cB7wzx1ckMOJ9znuzl5dAV+xA980WBJp3jBCc6
         kkjCU2RY9SJ35F1/6n+BlxNy3QOZmW9n+NC4mIofb9+Hzgw2rj8kMyNwpCHw0f4CWNq5
         6xtCmiXXonEcDSLEBbSlbNPok6mSSjWg8bCDt1oZAY9AWr3+kesa4tYM+AkMemQsgVfd
         VOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762305215; x=1762910015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87sj/urHj778WRrZXS7UN3zWW0S51mEqs7jth+xOmiY=;
        b=ZhO0QcZxCUE63/ddmIK0ZoZUEHxUfATwX6J/l5FBLLqzR9BZSH19UPQ7XsbEkGeQpl
         w9Lf5sl1O+Ygoej5upctlvWOV1yIU1Jx7Vud3cd13ui7EvTsYlxPHhB0dJw+wcMu+0VC
         PpR+Sgo9kmYOPAoRztS21QB+zIkcQgX6VMAzVFlnYbv24g01Qb9JvKbiXbSSrkMHiQU8
         dqLBuGezuVQnC5SjuqGo/TEEiZlDQk/onMDAi2s2WIbC8aImp2lN29FkEIvp/XJBBiVV
         jQkX6nCADgAW18PxjNC9+upWURYFwWO7qijmYkyTLHUC7Rm0tCzidcBT5G8hZjBYGte4
         numw==
X-Forwarded-Encrypted: i=1; AJvYcCU4mk8MWzry0afihw4+3+/fxdmjy2xTRv/OYE9SnCAE7K7zBlgQNjnudczhE8vMYZVmXCyJaeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlavmq9+Ytt7x7bcLHCuUojVczVw+sUaUsdVnEPIjLCDApb0d1
	nYs9TPKGErrXbJlaSUMoGvC8xLhVpx+Y8xBvygFcX2s4GMXshDjZjPUnHKe35L+FMpPjm4No3fZ
	GPwy+uAq0WQa+dqE2XXzBrUp5lgZHWw4=
X-Gm-Gg: ASbGncsE24AlsGvsRx/mkmGUc0zgI2BcM1+Yu9vPCAG+yTvAy0Gx15ZbgZJih6bKgBj
	sFLUhYcA252FmoO9mjUA1iYE6oNJJi/zgyOeT+dQZCzHaAU/eTG0Os8Bnd0j+mPcWafKEMY0SIQ
	wOLgx4pfJU1nQyNs4TovUBqyowbHQlKdKu5wibyM9F/ikZolW89deXJBX4/2UhkgTHS88mo53qd
	oek3H3eadkfdEqiK3hhyEftqzkStxxtdqFAcWN4wYU+5RBrCGldSPfjDTi2ZCAfMNTP3LkFiuB2
	JREsARD/luF9vaT/zvpJUGg3S60gzQ==
X-Google-Smtp-Source: AGHT+IEXctqZ43eVgXzLv0CJFnyc3Kfy26yvEcBKYGcg4QJgkHctqT2bEMWIDUrAUHBo0KkSYrEo3ePYt/M239opaW8=
X-Received: by 2002:a05:6000:210c:b0:429:b751:792b with SMTP id
 ffacd0b85a97d-429e33064femr697123f8f.32.1762305214961; Tue, 04 Nov 2025
 17:13:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762267022.git.m.wieczorretman@pm.me> <cf8fe0ffcdbf54e06d9df26c8473b123c4065f02.1762267022.git.m.wieczorretman@pm.me>
In-Reply-To: <cf8fe0ffcdbf54e06d9df26c8473b123c4065f02.1762267022.git.m.wieczorretman@pm.me>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 5 Nov 2025 02:13:22 +0100
X-Gm-Features: AWmQ_bliHxtRFT6WIWfcnl1BDrwXrFHVP_La30Dhwz3XgybJKCGbopAvefwnxWk
Message-ID: <CA+fCnZdUMTQNq=hgn8KbNwv2+LsRqoZ_R0CK0uWnjB41nHzvyg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] kasan: Unpoison vms[area] addresses with a common tag
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Marco Elver <elver@google.com>, stable@vger.kernel.org, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Baoquan He <bhe@redhat.com>, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 3:49=E2=80=AFPM Maciej Wieczor-Retman
<m.wieczorretman@pm.me> wrote:
>
> From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>
> A KASAN tag mismatch, possibly causing a kernel panic, can be observed
> on systems with a tag-based KASAN enabled and with multiple NUMA nodes.
> It was reported on arm64 and reproduced on x86. It can be explained in
> the following points:
>
>         1. There can be more than one virtual memory chunk.
>         2. Chunk's base address has a tag.
>         3. The base address points at the first chunk and thus inherits
>            the tag of the first chunk.
>         4. The subsequent chunks will be accessed with the tag from the
>            first chunk.
>         5. Thus, the subsequent chunks need to have their tag set to
>            match that of the first chunk.
>
> Unpoison all vm_structs after allocating them for the percpu allocator.
> Use the same tag to resolve the pcpu chunk address mismatch.
>
> Fixes: 1d96320f8d53 ("kasan, vmalloc: add vmalloc tagging for SW_TAGS")
> Cc: <stable@vger.kernel.org> # 6.1+
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> Tested-by: Baoquan He <bhe@redhat.com>
> ---
> Changelog v1 (after splitting of from the KASAN series):
> - Rewrite the patch message to point at the user impact of the issue.
> - Move helper to common.c so it can be compiled in all KASAN modes.
>
>  mm/kasan/common.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index c63544a98c24..a6bbc68984cd 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -584,12 +584,20 @@ bool __kasan_check_byte(const void *address, unsign=
ed long ip)
>         return true;
>  }
>
> +/*
> + * A tag mismatch happens when calculating per-cpu chunk addresses, beca=
use
> + * they all inherit the tag from vms[0]->addr, even when nr_vms is bigge=
r
> + * than 1. This is a problem because all the vms[]->addr come from separ=
ate
> + * allocations and have different tags so while the calculated address i=
s
> + * correct the tag isn't.
> + */
>  void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms)
>  {
>         int area;
>
>         for (area =3D 0 ; area < nr_vms ; area++) {
>                 kasan_poison(vms[area]->addr, vms[area]->size,
> -                            arch_kasan_get_tag(vms[area]->addr), false);
> +                            arch_kasan_get_tag(vms[0]->addr), false);
> +               arch_kasan_set_tag(vms[area]->addr, arch_kasan_get_tag(vm=
s[0]->addr));

set_tag() does not set the tag in place, its return value needs to be assig=
ned.

So if this patch fixes the issue, there's something off (is
vms[area]->addr never used for area !=3D 0)?

>         }
>  }

> --
> 2.51.0
>
>

