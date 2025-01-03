Return-Path: <stable+bounces-106739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3732AA0101F
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 23:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03141884909
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 22:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429731C1F30;
	Fri,  3 Jan 2025 22:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="va0M00/t"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFA71C07E3
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 22:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735942354; cv=none; b=t6wlH/y2TuVIqUyu7nqUKXbaGQZwXxw1P8g4kM0DURzQuZD5h4jpgIP8/zXaFlF0MHi097rR3ttZDBbdjgDxOkY6qFm7TO1r8NYVgBAGHfW5d7mH4zgszdZHsS/0w4gtb/Cw0MSQxGPm23MzDYuQbonEtN5ZwYPSKAH0LWt3rnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735942354; c=relaxed/simple;
	bh=N7/d8BnRpznW25kvX1oaV/75TgA55ldiCx4YUh46ot8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Au5RxFVgpe6m3MOwOCNCkedOnNcxus3UdNMrPbLkTqfwuzabv+8YJi/FFGpk9PCjZnLQsN7/5xq5paGm2KeV7gK3xayY1gDch1AR0zIOAi2UpIiywZvq0i6K7+E0iLAY00KU70UVJfuJCGnrG01LQmzF1MQ6X7NmD2r5Qyj/few=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=va0M00/t; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3e638e1b4so286a12.1
        for <stable@vger.kernel.org>; Fri, 03 Jan 2025 14:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735942347; x=1736547147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouzVuGMJ+dx/HtbR1hKCwiT87khuIIWB4azGn/h74wc=;
        b=va0M00/tP9l8sIu+QGB9Cn2fWtJzEQrNwvi/iHL32VkGBcgbFwwSzMUPJtKYlkz6A7
         wo/AKdzYXkYHiU8Om2KZDgjmPrHZeKu/WDWa8QvvtfLZ2VCcpUM4dpb1uGbWTxFRJ2ME
         9TMgA3+URmRvnIIAJJjPgQiPSDO1Vnj+KgLNMIMwLH+SjrTC+lg9zjcnGcbAgGmGli5h
         iNaUz5z3XX2mU2fBWNqavQCaxTjPBUNswzMAJ7lnmlLiTXtnPB93a4S2zkPoxGMMPsyq
         KI2aogTE5no/PLJl8LsCwal4ebTlGMHdvNisMhyohh5Eg6Df6l1cfsZNzZ9PA2XfPnon
         sFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735942347; x=1736547147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouzVuGMJ+dx/HtbR1hKCwiT87khuIIWB4azGn/h74wc=;
        b=mncIzo/EEvP2mOfT2Gygvdhh6PIpsVaX/UFS1u8qIb7dY+hX7Qar/uGOgpgppMxyOh
         nbn7BUD7HC9TAdqJD05PDFBkpv4Nvk11WLiCnW6I5Yo0Rs+6pxD1/yW2XHLUdJhHxjS8
         fbGRQjLX2k9a4XPFmDob6ciV+zAgTvHH4QFwQJJ0pr/ZEZZzNZ0ucmfSFcFEThgFwRSV
         Uy/GnaiEBX2ud0ch5CO74wn8UEai4DJ+PSVqKzH2/uvfxEDu+ZiSD0eZ/VsrfmLHGRvM
         8QiwCidaUTLIXpXQgEMmQcVqMK1s5gDWU2PEqDoNSC3Nfl60Pdyn8iSoedWYHJK2NQCW
         jHow==
X-Forwarded-Encrypted: i=1; AJvYcCUcFSD0OAms6j02Sne4bO16xxqYa27ncCDgzsTHOA2fb3tKY91/SejGHuUFH+ib6gCeudQm3Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT7vq+3zvXLpqbu7Ehw0OE9HU1ULqNApbiOQAakwLK0SgGfrEw
	yyhbpxDHX8Eo7vrxHuZ92ghGPNGQkOfcZVwl4pvbtHC0nAXP7N6f8cm/BldpG9Qd2+fHlGDvUNT
	xk4xqyvZp+1J1eHt1X9JuDsrysM/hRAsF+AeM
X-Gm-Gg: ASbGncvgKl4QqakT/GYLRYH+QR5LGAlSlv11D8MkI+svomzdaWrgYXIiDs4murYX9To
	F7z5AXRd2L0tsGqdcq8pq+f7Badr/KSDdDZXoa/5QE9YSspb27tKmO04idH+2c8W1Jw==
X-Google-Smtp-Source: AGHT+IH2nTuYsUZwgLAEUP1UUEKgqxPZDFH+lco++J+d2KuQMwGjlQ499ykyAps9/L1ZD/dRxu2zG01eE7yQuJSJQPE=
X-Received: by 2002:a50:f690:0:b0:5d1:22e1:7458 with SMTP id
 4fb4d7f45d1cf-5d929e3dbb0mr17001a12.4.1735942347178; Fri, 03 Jan 2025
 14:12:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103-x86-collapse-flush-fix-v1-1-3c521856cfa6@google.com> <a1fff596435121b01766bed27e401e8a27bf8f92.camel@surriel.com>
In-Reply-To: <a1fff596435121b01766bed27e401e8a27bf8f92.camel@surriel.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 3 Jan 2025 23:11:51 +0100
X-Gm-Features: AbW1kvbz3sFjQRVgQTwK2nmJwfanIw07ifL6HQW9Fg9SPbjiINESXxchPM_6Vlc
Message-ID: <CAG48ez1d9VdW+UQ3RYXMAe1-9muqz3SrC_cZ4UvcB=jpfR2X=Q@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Fix flush_tlb_range() when used for zapping
 normal PMDs
To: Rik van Riel <riel@surriel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 10:55=E2=80=AFPM Rik van Riel <riel@surriel.com> wro=
te:
> On Fri, 2025-01-03 at 19:39 +0100, Jann Horn wrote:
> > 02fc2aa06e9e0ecdba3fe948cafe5892b72e86c0..3da645139748538daac70166618d
> > 8ad95116eb74 100644
> > --- a/arch/x86/include/asm/tlbflush.h
> > +++ b/arch/x86/include/asm/tlbflush.h
> > @@ -242,7 +242,7 @@ void flush_tlb_multi(const struct cpumask
> > *cpumask,
> >       flush_tlb_mm_range((vma)->vm_mm, start,
> > end,                  \
> >                          ((vma)->vm_flags &
> > VM_HUGETLB)           \
> >                               ?
> > huge_page_shift(hstate_vma(vma))      \
> > -                             : PAGE_SHIFT, false)
> > +                             : PAGE_SHIFT, true)
> >
> >
>
> The code looks good, but should this macro get
> a comment indicating that code that only frees
> pages, but not page tables, should be calling
> flush_tlb() instead?

Documentation/core-api/cachetlb.rst seems to be the common place
that's supposed to document the rules - the macro I'm touching is just
the x86 implementation. (The arm64 implementation also has some fairly
extensive comments that say flush_tlb_range() "also invalidates any
walk-cache entries associated with translations for the specified
address range" while flush_tlb_page() "only invalidates a single,
last-level page-table entry and therefore does not affect any
walk-caches".) I wouldn't want to add yet more documentation for this
API inside the X86 code. I guess it would make sense to add pointers
from the x86 code to the documentation (and copy the details about
last-level TLBs from the arm64 code into the docs).

I don't see a function flush_tlb() outside of some (non-x86) arch code.

I don't know if it makes sense to tell developers to not use
flush_tlb_range() for freeing pages. If the performance of
flush_tlb_range() actually is an issue, I guess one fix would be to
refactor this and add a parameter or something?

