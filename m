Return-Path: <stable+bounces-124877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F536A683D3
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 04:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2267417E506
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 03:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C3324E01C;
	Wed, 19 Mar 2025 03:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CmjlEsir"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9B8207E11
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 03:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742355334; cv=none; b=sYd375CGfa2fLv1w3ZBNJQTF11DMLgWvUwxcKDIcKDL1VtNC/Np5PpPCnqYcDhUuSHYrn/nTLzIJzwUbZ2cl3ggXFzUXjhFRcWt345pvq+iUut1etNtFAIyisecnfpdXNxTYPvj/+lKAVEsRtosdsq9wu1CuaKq/Lub4rUFGRHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742355334; c=relaxed/simple;
	bh=Hci/3CsZb65ypppDc73oxREkEn6yYwNHVBtLzmK0uos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7+naQz/fAKWkIXsZ1suh4JS6PnJxy4PXbsuwVOjuBBmcZkAjF195pDT2EEDcMPIkQ/ymg1IW4MBkZfaBWKmjF3w+HeXWD1zLAfhbgdOSohZinwHFrK+Nburk+J7l5GAVXYpO0ZEP5o9LZNmiwCW4x+L4V8RO5H5rWtB8SErvVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CmjlEsir; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5cbd8b19bso3586a12.1
        for <stable@vger.kernel.org>; Tue, 18 Mar 2025 20:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742355331; x=1742960131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1eGmQWoQGN9Dkax1HXc1+f2DIdudnDU/1Bx3UVDXHM=;
        b=CmjlEsiruGBUH0buOuZE+HHVLjNfmFwGKcesJcFXX5F38SzrRyBOgcOXwKqeESpkhh
         HbBi7EJUDMpw02G59zaPqx6KpuZwrk1UwGoVeeuQ74uij79dVVpdZiCz4mWWhUmOF/fE
         SZ/wN//oGkWLSSr1XXhIzeG+ppw7CPTPXuLCrR3U4hCx4keV828XnM06rqFhyKe72yIs
         nAo4XUhZAk/0MYvpVpCCeIajc0CHBHYvYXtoMYydmwW4gut3qtKZ6nhDlmE2Sc+xbzls
         r2PfMO9GOSWYuLkpfeeP33AOT+D6NC7mBWuu+XZ8481ljZBvNxqnfwUMEzN87TaBYHO7
         aC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742355331; x=1742960131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1eGmQWoQGN9Dkax1HXc1+f2DIdudnDU/1Bx3UVDXHM=;
        b=ij5QyrsEVApaRIs2zocfs5cfjEOCguO+OyHi67RSOhowGRphGAkiZxWXz4qsvbI1yU
         CemyxVsioEUFrdimLD1avpUcIFyuLZAxbyRMIbF543mHpSnTqsVxRt9XwSkJZr/i0ys3
         uoLmM1LVG6QyNCqE2bxqfodA6Hx+uXUhaFJu8jZDh7O00LzpXn6Q2v3/biTuIQY2qU3B
         03O4i+n3ITS4sFboQqmYKIDRrIK6JWQG732c1aBQ19S94vjHSFM7ceLte6VZVanssrXn
         rpIH1MIUz1Tm0Uirbz/JmRGO7x+Y2yL5aG+IvBPAzLfueRFgtN8gUOFS5AqgmnAOnfSf
         aKiA==
X-Forwarded-Encrypted: i=1; AJvYcCWB3JGuxFHGjKyAAMiaXi4xa0ZZgmJ+kckRPaewADbMF2TuR/VxRBF2aR7D22jhS5oNFpV1JYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjFDq67rx5vUbDmoZPQ+Bv22cdbmXWvVXDcn2LTqF/95b7+9+V
	r+TZAMZjqjj/40Je7fJdm6I+gplg6KK3af5bdjb8qP50sWRSwZI0s81rhHXeMSwNdnM5symSZH8
	QGU53o/zFQNrWcmbDuwg31guiOFVwNJHYL0th
X-Gm-Gg: ASbGncuGufKhxHIKq5c/zk1EaSWr1RMbcpirS1/uHBkWNCncSqAVs6+gBEm1hpMrO99
	aQNo0CJ8NVkWP7K6xfvsmzkABUOyStKGvB5um8ln8Z5s/E+7y3fK54oMZ2WOBCu69/uUeOSCL+7
	dBe2Pw7IjCoMZo6urKDyMs1YhNqIfrvtYNnPgqBfKUgxM+aeENJohWYAnAwCZpfItipA==
X-Google-Smtp-Source: AGHT+IEt+19WG9IHzZ81Mv9euoAb/rztC5JqY4WZb1WW6DcgrlMezNBnKgRxYmL642WrrToMiGpcBZS+CqAISTXPMYI=
X-Received: by 2002:aa7:c1da:0:b0:5e5:c024:ec29 with SMTP id
 4fb4d7f45d1cf-5eb7e96330cmr62254a12.0.1742355330636; Tue, 18 Mar 2025
 20:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318214035.481950-1-pcc@google.com> <20250318214035.481950-2-pcc@google.com>
 <202503181957.55A0E0A@keescook>
In-Reply-To: <202503181957.55A0E0A@keescook>
From: Peter Collingbourne <pcc@google.com>
Date: Tue, 18 Mar 2025 20:35:19 -0700
X-Gm-Features: AQ5f1Jq3z05plokQ9oy7A8yZz95pSsT-oxsin3iEVaTMKIK56JFI_UIbnlyp_vI
Message-ID: <CAMn1gO7TG0xXMFNFXTm9W8n4hdit9Yr40m4jvFCjdv9fGiU5iw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
To: Kees Cook <kees@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 8:06=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Mar 18, 2025 at 02:40:32PM -0700, Peter Collingbourne wrote:
> > The call to read_word_at_a_time() in sized_strscpy() is problematic
> > with MTE because it may trigger a tag check fault when reading
> > across a tag granule (16 bytes) boundary. To make this code
> > MTE compatible, let's start using load_unaligned_zeropad()
> > on architectures where it is available (i.e. architectures that
> > define CONFIG_DCACHE_WORD_ACCESS). Because load_unaligned_zeropad()
> > takes care of page boundaries as well as tag granule boundaries,
> > also disable the code preventing crossing page boundaries when using
> > load_unaligned_zeropad().
> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Link: https://linux-review.googlesource.com/id/If4b22e43b5a4ca49726b4bf=
98ada827fdf755548
> > Fixes: 94ab5b61ee16 ("kasan, arm64: enable CONFIG_KASAN_HW_TAGS")
> > Cc: stable@vger.kernel.org
> > ---
> > v2:
> > - new approach
> >
> >  lib/string.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/string.c b/lib/string.c
> > index eb4486ed40d25..b632c71df1a50 100644
> > --- a/lib/string.c
> > +++ b/lib/string.c
> > @@ -119,6 +119,7 @@ ssize_t sized_strscpy(char *dest, const char *src, =
size_t count)
> >       if (count =3D=3D 0 || WARN_ON_ONCE(count > INT_MAX))
> >               return -E2BIG;
> >
> > +#ifndef CONFIG_DCACHE_WORD_ACCESS
> >  #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>
> I would prefer this were written as:
>
> #if !defined(CONFIG_DCACHE_WORD_ACCESS) && \
>     defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
>
> Having 2 #ifs makes me think there is some reason for having them
> separable. But the logic here is for a single check.

There is indeed a reason for having two: there's an #else in the
middle (which pertains to CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
only).

>
> >       /*
> >        * If src is unaligned, don't cross a page boundary,
> > @@ -133,12 +134,14 @@ ssize_t sized_strscpy(char *dest, const char *src=
, size_t count)
> >       /* If src or dest is unaligned, don't do word-at-a-time. */
> >       if (((long) dest | (long) src) & (sizeof(long) - 1))
> >               max =3D 0;
> > +#endif
> >  #endif
>
> (Then no second #endif needed)
>
> >
> >       /*
> > -      * read_word_at_a_time() below may read uninitialized bytes after=
 the
> > -      * trailing zero and use them in comparisons. Disable this optimi=
zation
> > -      * under KMSAN to prevent false positive reports.
> > +      * load_unaligned_zeropad() or read_word_at_a_time() below may re=
ad
> > +      * uninitialized bytes after the trailing zero and use them in
> > +      * comparisons. Disable this optimization under KMSAN to prevent
> > +      * false positive reports.
> >        */
> >       if (IS_ENABLED(CONFIG_KMSAN))
> >               max =3D 0;
> > @@ -146,7 +149,11 @@ ssize_t sized_strscpy(char *dest, const char *src,=
 size_t count)
> >       while (max >=3D sizeof(unsigned long)) {
> >               unsigned long c, data;
> >
> > +#ifdef CONFIG_DCACHE_WORD_ACCESS
> > +             c =3D load_unaligned_zeropad(src+res);
> > +#else
> >               c =3D read_word_at_a_time(src+res);
> > +#endif
> >               if (has_zero(c, &data, &constants)) {
> >                       data =3D prep_zero_mask(c, data, &constants);
> >                       data =3D create_zero_mask(data);
>
> The rest seems good. Though I do wonder: what happens on a page boundary
> for read_word_at_a_time(), then? We get back zero-filled remainder? Will
> that hide a missing NUL terminator? As in, it's not actually there
> because of the end of the page/granule, but a zero was put in, so now
> it looks like it's been terminated and the exception got eaten? And
> doesn't this hide MTE faults since we can't differentiate "overran MTE
> tag" from "overran granule while over-reading"?

Correct. The behavior I implemented seems good enough for now IMO (and
at least good enough for backports). If we did want to detect this
case, we would need an alternative to "load_unaligned_zeropad" that
would do something other than fill the unreadable bytes with zeros in
the fault handler. For example, it could fill them with all-ones. That
would prevent the loop from being terminated by the tag check fault,
and we would proceed to the next granule, take another tag check fault
which would recur in the fault handler and cause the bug to be
detected.

Peter

