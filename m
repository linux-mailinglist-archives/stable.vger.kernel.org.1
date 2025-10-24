Return-Path: <stable+bounces-189183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FF2C0406B
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 03:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DAC1A67F18
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 01:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCFA1494D9;
	Fri, 24 Oct 2025 01:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7xnt6Se"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDA012D1F1
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 01:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761269753; cv=none; b=OX915SLGmMqE0DufV1AHWwSD+ut+PNdQawSnnkeojmVJPqLasVld7LjcjZFO+MhLT3w+I0mkbxQMuMJHNhEuGBYubXzccmKugNmXL0DCSzmeVu2qYFhO+tsuPel08GeFTwlaJESs03KHxv1YlMy5zPlgH/kLvkiyk8rxSoE4hhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761269753; c=relaxed/simple;
	bh=AXzVrNH1TUa6ogzDoknpnZyRp4WPedbef4fmxOb9fUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbDpC4GckMS7nmgX8uGClgyu0sh+nMreesxrFJv9X5zI+at1ljGaMCC3qC8AO+O5NG84KgVr1BTVaz5LHSEgZiV2ipZav2CEz/q8sjng4KimBD7yfbdG9W5BDd4ZOiL1hDZo4FwF114YZ4zb3pFYfFuabuBkae+yBpj9yXgba3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7xnt6Se; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e6a6a5e42so8109645e9.0
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 18:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761269750; x=1761874550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cq8gqqeYooxgW5KYKmBo5Rs/wh49wN/6rTY6x+8D8QA=;
        b=g7xnt6Se7/yVB1ZbzVBGgJk4ETl3P0xx46mJNkDb1lSY1oO+91BsK+wrHpNDc76HuR
         FpQ2EX0sayF2S8XHS/cP6Jyf+cCiZDtnTtbkuP01dHbSqrdRWn2uN1rbUhLgWf2WniAM
         YNngzVRqp6YHi2DbZsB4sE8izhYFyhGWKoL3cPWYwtkHNclvBJv9/QYwgYNYrQP7oIV4
         fjMGM+qLLq2V5TBHV/1z46d2CSWpOJRQpvJdtyfcnUyqZQNxevmflcK5+zVRFsB8oE2k
         MJOJNuWO/xqxKF5tUiWRpzjhe9j+8KBFVBQ/pARS5DCYt4eFCVzD6zq+Q4mIOxxs8Kch
         5wqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761269750; x=1761874550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cq8gqqeYooxgW5KYKmBo5Rs/wh49wN/6rTY6x+8D8QA=;
        b=U+/VjbsbXm30fIvspdBOfWM8EyLFbWu6EioB1dQittl0bgKe1dRtMeYhSa9THpFRRk
         TOB46xcvgIln6Ko095ml2O5Igz7/NGC09vboctzfhJbwzdCZHDEfJ6jd4h3e6jPfI7s2
         UZQjZO8B4mWGCe5ghEPBiEy+qIwPNrtPtxTlZDpMGFwUoUOiSNziRvfy7KGurmNpCZ+y
         UUCdnzPu5TT0LPUmnZShCqze/zqOre3u9LeH4u4koTRKt9Y639Yj39VpiQ5NVQ6Lerov
         aHUT7QIWmCKTE4cd6XcEQxn8GIXaJZlgVJ8Me+sLRI/ltLF6XSOYFeFdbbcdPxu/oa4D
         Mniw==
X-Forwarded-Encrypted: i=1; AJvYcCWg7LfIpSIBQvvactrbbgBw7BQz35FSusjV3qbv/6cjlf2y03TCWsbD6djH5GbSo9Wwa/PqHe8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1H/2sHsEYzKsXgXvDFs2JJKIlH/yPudwVJiIYgOxQqIMtq5H5
	gsqjP6CmT5YFp/tCvfGeh055QMP8+17/QbPc/yAqBO8UMcisHeXX80UqTRjo1YQPrJ8YfyLj/FL
	wiNGY9XxdGw0f6+wJhIcRlH4TE0U281I=
X-Gm-Gg: ASbGncscY7zv9EieT8wwx+SLaCk2TLNsl7jyn/DLI+UWytHqXVOla2mcGn2v2ScN3Qw
	hrLeDWJLaaIQEy/sbTcePHB71ALMOHENXCnRPZnbG0u13rz/2R2zHbOGtza23Uly2k1RetaMrfD
	EQmUalpI57w8r5OhoUJDfwFVqsy34huOcQXV1iGH0uqdIMMwH8d/tS336790DYRs/z7w5kX/wAe
	Bjkib0KSAfkFDbsWjHlQ92wrkrOiE9e7cVHKFRFUkb+UnIlzslnGbPGjfII+0XkgZqq9FnAeKDn
	7PuYRiRPmcnPrWfgE10=
X-Google-Smtp-Source: AGHT+IGwrfelWdU2yhalAC0i9vt/hIf2/MMW3kPsGCKlhtSvPHBTMPWNKLBb8oATlrSieozyy7lk2jNHzMN+c5GsljA=
X-Received: by 2002:a05:600d:4355:b0:46e:45f7:34f3 with SMTP id
 5b1f17b1804b1-475d39b9552mr1422285e9.8.1761269749552; Thu, 23 Oct 2025
 18:35:49 -0700 (PDT)
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
Date: Fri, 24 Oct 2025 03:35:38 +0200
X-Gm-Features: AWmQ_blTT_7WNBqDPFmuMJp8o4vQAMauOpamt3NvIm4L5ZNNRzy9gCKm7HE9f0E
Message-ID: <CA+fCnZezciDNL4-Yto8d3bPOc3U07hY1Q_DMk926-1H17Ugx3Q@mail.gmail.com>
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

*HW_TAGS KASAN

SW_TAGS KASAN works with kasan_disable_current().

HW_TAGS KASAN does not and instead relies on the pointer tag being
reset for the access to be unchecked.

On another side note, unpoisoning slabobj_ext memory with either of
the TAGS modes would require it to be aligned to 16 bytes, not just 8.
(But those modes do not embed metadata after each object in a slab, so
your patch seems fine to me.)

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
>
> > - How come we haven't seen any issues regarding this so far? :/
>
> As you pointed out, we don't unpoison the memory that stores KASAN
> metadata and instead just disable KASAN error reporting. This is done
> deliberately to allow KASAN catching accesses into that memory that
> happen outside of the slab/KASAN code.

