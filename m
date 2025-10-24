Return-Path: <stable+bounces-189184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EB9C04104
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 03:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 821A44ED41D
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 01:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CACD1E7660;
	Fri, 24 Oct 2025 01:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwbzwW2f"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B9E1E47A8
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 01:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271004; cv=none; b=o7MAHj2ggdPeYiIRMXC9B6RqQLYJlmPW0WI4Eek4yteUGjhT9GqSSje5bi3m70ZO9RVMfWX3Dufuq/aZ8ur+p9mF9WoJzXZjja1PwbOj57XeuupwfGlmJPo7b4XgHq49bqI3oT4ssU0N29blm2v/mKfqXN9ZcSPddEwHfNnhJO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271004; c=relaxed/simple;
	bh=Ax8jVriTeOqqfQC9Vr39bqUKOZgnU715FWf5Nl9i0Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYJGaVoRNXIkY4jPvSZUQu9qqMs+nfbtZF3WwhRtIF83qIFArrQnlUkbwB0TGwtyruSritTYFb8WOuU/yEg0pRn9PZFtNUTfmcqiqLLanDrB+3MnPaChXeK74kePsMsYZnpiCOL7gEkc/a111fE7ypm9UmhtoR/KSTBgOz8WyJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwbzwW2f; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5c7fda918feso1773167137.0
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 18:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761271002; x=1761875802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3wXd6gCAHDSdcT184SwaO/DYF8T98vh52YBZMXknyg=;
        b=mwbzwW2fKu4RUEkODlZH/XwKTCfpucRTB4PiiH2Bd2CvzGjAp1ev9hQ/B+En62Xtrp
         Mxn7je6p8WUbzsvMSLxGHscxx5tlsTIfUJXS796QWiUQyyrgEIcj3KftVfAeAEy84dMr
         o+GzmOr3+oRyiFoONJmB/4phEPUIGcQdEKyPfdupnjjwZ4NWQrQwHW7OEvn5TOw4Pv3+
         unFvey1sJ6hwlD2VyO+KYhqHtslz60atCaCfhUa/s5EJeIL5pU95TfJ3PQz8j+ScQEBT
         V/i2bvVDT3JKA2M++vFO8Z4qRTe26F5r5qnAkyMImK9BUZzYJBd3xu1djm/sJpSQ4QNf
         PJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761271002; x=1761875802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3wXd6gCAHDSdcT184SwaO/DYF8T98vh52YBZMXknyg=;
        b=MT/lpbhil2ibJzjbH2thk6/nwnVgcPCWxeqKYhc4Z3EgcnA/A4rgybe+yLi+JsBsFF
         ZOjK9xEFDifFcKY80fbssRSowVmi10k8pefaqHRjwMm6xwI7/fsRVfT7mx/yxqtCK583
         HwIvpHI/9tfreWK12wlceBnKL1eqvF2TxNRKkabAj7elA7ilo0iGE5dEeXv4CJOCcKaw
         /Y2podMTLgVB6rt2Wf4X76e+pWaDx4nF3F6PKXEcGxIuSLPLNqv0UWF/lY2xsGicefs7
         CzIxG4StBtrRztTNqx3XIHbKKCOofsGDOT+I1mYAwVx7BmTTSmlzSJO2g4Dij9cDf1C9
         4Xdw==
X-Forwarded-Encrypted: i=1; AJvYcCVlMOEXG59QVFr30odQ7BtwZRS0W+rPJxLhYIC5aSebP9po2wUfIYf+pq+h5V59Dg1mhwlUb/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd8iUqwg38PRFc/nuICa+QS93Dtd7a4JSbyabPmDRRJzhB4cBK
	OvmqgjkRvlHf3jQhjbvvBBEvRQ7PqdQpLMxx0zhb4v8P7SfKUxKNy5iaagb5AN5QMKjTug37jLJ
	u2I6XsdqhHhFP7NRycZvWOzX7mRnkFTA=
X-Gm-Gg: ASbGncsXHpdIn/nep9ymg2QSYKUIwdVU0BBUYMAe/0R9AavQHM1ej+YUkVbv1Elm4O2
	Zf3HD0U3WZM2yd0CFdkvQWx77A6foxcX2MiUaDnPKGux5fEkuQN8WAQm7uZA0F6aJ7cHQ7Hub80
	hWiOL3R10sWsBcnr+nL/2v3xxaFFrCQN3zzrUrYSwU1tYzddrgqOKRH2O2hjMMpWY/AA+mZVVlp
	qqAgXiyKEQ6ldq/dTSvoyAx/Rrad4nbJgsQh/DeFMwhKltiKqM/AKVqNcVZ4MZJtiUJ54zu4PRo
	PzP+YElXP2NscpnoBPD05kHe1mZs8A==
X-Google-Smtp-Source: AGHT+IGZqTPH/RBOw7fnpSbszzrTIc2/2WIbGOyXrK2o8Ptsd+0ZdioAaS7bZPfKFwDfzMuMlpO2/ngAh30y/Gx7L/U=
X-Received: by 2002:a05:6102:508f:b0:5d6:12fc:76e1 with SMTP id
 ada2fe7eead31-5db3f8c5d89mr162595137.17.1761271001978; Thu, 23 Oct 2025
 18:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023131600.1103431-1-harry.yoo@oracle.com>
 <aPrLF0OUK651M4dk@hyeyoo> <CA+fCnZezoWn40BaS3cgmCeLwjT+5AndzcQLc=wH3BjMCu6_YCw@mail.gmail.com>
In-Reply-To: <CA+fCnZezoWn40BaS3cgmCeLwjT+5AndzcQLc=wH3BjMCu6_YCw@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 24 Oct 2025 03:56:29 +0200
X-Gm-Features: AWmQ_bnZfgWxvUlSV_cSyZkt3ycyNMFflOIinUoHSDKlFI4Ch_9TGgYATVsEHdg
Message-ID: <CA+fCnZdkWnRpp_eXUaRG_HM7HSDm4fLATpsqJhaxT_WGjhOHLg@mail.gmail.com>
Subject: Re: [PATCH] mm/slab: ensure all metadata in slab object are word-aligned
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, 
	Alexander Potapenko <glider@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Feng Tang <feng.79.tang@gmail.com>, 
	Christoph Lameter <cl@gentwo.org>, Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 3:19=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> On Fri, Oct 24, 2025 at 2:41=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> =
wrote:
> >
> > Adding more details on how I discovered this and why I care:
> >
> > I was developing a feature that uses unused bytes in s->size as the
> > slabobj_ext metadata. Unlike other metadata where slab disables KASAN
> > when accessing it, this should be unpoisoned to avoid adding complexity
> > and overhead when accessing it.
>
> Generally, unpoisoining parts of slabs that should not be accessed by
> non-slab code is undesirable - this would prevent KASAN from detecting
> OOB accesses into that memory.
>
> An alternative to unpoisoning or disabling KASAN could be to add
> helper functions annotated with __no_sanitize_address that do the
> required accesses. And make them inlined when KASAN is disabled to
> avoid the performance hit.
>
> On a side note, you might also need to check whether SW_TAGS KASAN and
> KMSAN would be unhappy with your changes:
>
> - When we do kasan_disable_current() or metadata_access_enable(), we
> also do kasan_reset_tag();
> - In metadata_access_enable(), we disable KMSAN as well.
>
> > This warning is from kasan_unpoison():
> >         if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
> >                 return;
> >
> > on x86_64, the address passed to kasan_{poison,unpoison}() should be at
> > least aligned with 8 bytes.
> >
> > After manual investigation it turns out when the SLAB_STORE_USER flag i=
s
> > specified, any metadata after the original kmalloc request size is
> > misaligned.
> >
> > Questions:
> > - Could it cause any issues other than the one described above?
> > - Does KASAN even support architectures that have issues with unaligned
> >   accesses?
>
> Unaligned accesses are handled just fine. It's just that the start of
> any unpoisoned/accessible memory region must be aligned to 8 (or 16
> for SW_TAGS) bytes due to how KASAN encodes shadow memory values.

Misread your question: my response was about whether unaligned
accesses are instrumented/checked correctly on architectures that do
support them.

For architectures that do not: there might indeed be an issue. Though
there's KASAN support for xtensa and I suppose it works (does xtensa
support unaligned accesses?).

>
> > - How come we haven't seen any issues regarding this so far? :/
>
> As you pointed out, we don't unpoison the memory that stores KASAN
> metadata and instead just disable KASAN error reporting. This is done
> deliberately to allow KASAN catching accesses into that memory that
> happen outside of the slab/KASAN code.

