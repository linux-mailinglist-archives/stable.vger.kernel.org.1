Return-Path: <stable+bounces-60273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1FF932EC9
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134761F23239
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C5F19F486;
	Tue, 16 Jul 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0yAfE4kH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B6217CA0E
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721149155; cv=none; b=OiKFwGjSVU/IekZqHVUX2jQoepSxkkWF8EWLX/UqXFslpMDJOLut4BaO3rCA5CGRRigspcfqKWS5YfFN88gieuJY3AjtlbwB49FrAKmSEDqMWY1okVvmFjA+/ODgIK4anSg+7jloHRWDohfxOAK0Lxmsud41t554d+VEQ6Dk8as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721149155; c=relaxed/simple;
	bh=p5uun+IkdYZb1SMfmlwb0Tj98pbmILXXKnTS7dg843M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6DF+3cZ2WgUjkOtLhGVtgrOQI1QogRKfWHbJ1f36/iCO4ykAPd9jrVtWy8G2z+yDx2QWYxxDGhVMhne58uGCnE77lohfZm34XPgCCvA6DjIkeEDOJsrFq5gpgHMxpBf3BhYAFOAzqpDOODO97RmQAjVqbxpWKCtVwzBiV+tazs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0yAfE4kH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42793fc0a6dso39243285e9.0
        for <stable@vger.kernel.org>; Tue, 16 Jul 2024 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721149152; x=1721753952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QABpovxSGfU8kEcjH91lohwMP7HIgY54q6Q0Fj9if7g=;
        b=0yAfE4kH4ECQSoBKSYX2rRw5M/1IdBoAmnVVGKPsnqBADq/K6xZl1+EKcabxEtQ69e
         YPkk04x159Vl5jtyGmk/Z4OgAN0U2GoTuMJrqAJREU0fhSoSdvsNtTupR8ON77W6K7Op
         sVazG66/BL5LzRC7vQbCjxl3rTYVy6yeJeqPU2fMor/LTGwGv4zVOKOM7N4MpQZ3VXkZ
         ymqnWb1kfdqlPBIPOjDAF+Cxcn7KbsVeWN7n3kGgAgjjSxC7O5qPrbSeoX171dkFR9w6
         L0bjWNrYijy6ySgD5wqwETsiWZ6Py4tj02LS0FtJ6AEgDQY5bytpLZJ2VVK6w2rCH1M0
         07bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721149152; x=1721753952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QABpovxSGfU8kEcjH91lohwMP7HIgY54q6Q0Fj9if7g=;
        b=ZpsExHI3kbV2U49gtWBsngriXcRFTES/c9bmOGP4yWXIgiaIL+9YlB7Pt3q/Rojf2s
         pxZp6c4rxM0KPtLckaYe7ODEEZwckhEMyBlDXC7Jym534QdN5/HFi3KjgR2MhbBTjK1d
         p3jGu9Y1A+KD2WqJPBPrvQf6shV36gRAwOUWhwNxgVFncs9f04Ho16XpwV2aiUFDzg9E
         Xkvf9t11xCYlVi3DunmQM2qKv8TX6EYY75IG7v1Jt5LhYcHDHgxR1Xn2+F2+A9I6ExMB
         MsRu/n0k53BjaRn0DLdt6CKHmHUcaXZDIAQbXHb+pfdxYj8z9bjRIPcyBUlA3PcWGw6P
         w4gg==
X-Forwarded-Encrypted: i=1; AJvYcCVjWhsuY1Oa1fz+5iL54g20TFac9GAE4O0yFteIiio8+GLMt2cDJhiVpXierktdC7iF/YSFDRN0JS/q4sHlPHOzM7yq5yA3
X-Gm-Message-State: AOJu0Ywr0vVnWULod8WiRft+ZUUozGGpqBRJW33OWisg1Px81heRQVgH
	hiZCMnQ5Tn/skLLGpRVQp+r1nvDFX0bM1LZmcXU8qFV+pBGFNsBnUo26RX2I03QuZm0GmbvUmOg
	US2YGKrLSDG51I+wGazFidr1NCswEGGMC+CcS
X-Google-Smtp-Source: AGHT+IGtKFOCtON5kgMdkjjkB6znWMmtY3e3PwHZFFIqjt5jE0NyUfDvxVmL2s657zDafJHS/4DyRJxfMr5cdBIu+ic=
X-Received: by 2002:a05:600c:35c2:b0:426:6416:aa73 with SMTP id
 5b1f17b1804b1-427ba6293d1mr20194245e9.12.1721149151739; Tue, 16 Jul 2024
 09:59:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACzhbgRoMEAzkEVZPMEHR2JsNn5ZNw1SwKqP1FVzej4g_87snQ@mail.gmail.com>
 <20240715203541.389415-1-axelrasmussen@google.com> <20240715162145.6e13cbff.alex.williamson@redhat.com>
 <CAJHvVcgQUoEFF93m-TADJ-n6pDKGJH=xr0mx9bW6Qw5nq5KzOw@mail.gmail.com> <20240716100813.72430d00.alex.williamson@redhat.com>
In-Reply-To: <20240716100813.72430d00.alex.williamson@redhat.com>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Tue, 16 Jul 2024 09:58:34 -0700
Message-ID: <CAJHvVcjA4KJTSTa1_PFs3yBzV0Gbv2SVEHfqBbOX0GEXMciDUw@mail.gmail.com>
Subject: Re: [PATCH 6.6] fork: defer linking file vma until vma is fully initialized
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Leah Rumancik <leah.rumancik@gmail.com>, Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, 
	Miaohe Lin <linmiaohe@huawei.com>, Thorvald Natvig <thorvald@google.com>, 
	Jane Chu <jane.chu@oracle.com>, Christian Brauner <brauner@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Muchun Song <muchun.song@linux.dev>, 
	Oleg Nesterov <oleg@redhat.com>, Peng Zhang <zhangpeng.00@bytedance.com>, 
	Tycho Andersen <tandersen@netflix.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 9:08=E2=80=AFAM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Mon, 15 Jul 2024 18:06:25 -0700
> Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> > On Mon, Jul 15, 2024 at 3:21=E2=80=AFPM Alex Williamson
> > <alex.williamson@redhat.com> wrote:
> > >
> > > On Mon, 15 Jul 2024 13:35:41 -0700
> > > Axel Rasmussen <axelrasmussen@google.com> wrote:
> > >
> > > > I tried out Sasha's suggestion. Note that *just* taking
> > > > aac6db75a9 ("vfio/pci: Use unmap_mapping_range()") is not sufficien=
t, we also
> > > > need b7c5e64fec ("vfio: Create vfio_fs_type with inode per device")=
.
> > > >
> > > > But, the good news is both of those apply more or less cleanly to 6=
.6. And, at
> > > > least under a very basic test which exercises VFIO memory mapping, =
things seem
> > > > to work properly with that change.
> > > >
> > > > I would agree with Leah that these seem a bit big to be stable fixe=
s. But, I'm
> > > > encouraged by the fact that Sasha suggested taking them. If there a=
re no big
> > > > objections (Alex? :) ) I can send the backport patches this week.
> > > >
> > >
> > > If you were to take those, I think you'd also want:
> > >
> > > d71a989cf5d9 ("vfio/pci: Insert full vma on mmap'd MMIO fault")
> > >
> > > which helps avoid a potential regression in VM startup latency vs
> > > faulting each page of the VMA.  Ideally we'd have had huge_fault
> > > working for pfnmaps before this conversion to avoid the latter commit=
.
> > >
> > > I'm a bit confused by the lineage here though, 35e351780fa9 ("fork:
> > > defer linking file vma until vma is fully initialized") entered v6.9
> > > whereas these vfio changes all came in v6.10, so why does the v6.6
> > > backport end up with dependencies on these newer commits?  Is there
> > > something that needs to be fixed in v6.9-stable as well?
> >
> > Right, I believe 35e351780fa9 introduced a bug for VFIO by calling
> > vm_ops->open() *before* copy_page_range(). So I think this bug affects
> > not just 6.6 (to which 35e351780fa9 was stable backported) but also
> > 6.9 as you say.
> >
> > The reason to bring up all these newer commits is, it's unclear how to
> > fix the bug. :) We thought we had a simple solution to just reorder
> > when vm_ops->open() is called, but Miaohe pointed out elsewhere in
> > this thread an issue with doing that.
> >
> > Assuming the reordering is unworkable, the only other idea I have for
> > fixing the bug without the larger refactor is:
> >
> > 1. Mark VFIO VMAs VM_WIPEONFORK so we don't copy_page_range after
> > vm_ops->open() is called
> > 2. Remove the WARN_ON_ONCE(1) in get_pat_info() so when VFIO zaps a
> > not-fully-populated range (expected if we never copy_page_range!) we
> > don't get a warning
> >
> > There are downsides to this fix. It's kind of abusing VM_WIPEONFORK
> > for a new purpose. It's removing a warning which may catch other
> > legitimate problems. And it's diverging stable kernels from upstream
> > as Sasha points out.
> >
> > Just backporting the refactors fixes (well, totally avoids) the bug,
> > and it doesn't require special hackery only for stable kernels.
>
> Yes, I'd agree that we want to stay as close as possible to the current
> upstream solution, even if we got there pretty haphazardly.  Therefore
> it sounds like we should queue the following for v6.9-stable:
>
> d71a989cf5d9 ("vfio/pci: Insert full vma on mmap'd MMIO fault")
> aac6db75a9fc ("vfio/pci: Use unmap_mapping_range()")
> b7c5e64fecfa ("vfio: Create vfio_fs_type with inode per device")
>
> And then anywhere that 35e351780fa9 ("fork: defer linking file vma
> until vma is fully initialized") gets backported, those will also need
> to follow.

Sounds good to me. I can send these patches for 6.9 and then 6.6.

>
> Did anyone report an issue with 35e351780fa9 and vfio on v6.9 or the
> previous v6.6 backport to use as a test case or do we just know it's an
> issue from inspection?  The revert only notes an xfstest issue.  Thanks,

I'm not aware of any reports of this, besides our own detection internally.

We originally noticed via xfstests the failure mode where we call
copy_page_range, so underneath untrack_pfn we find a 'hole' in the
mapping so we WARN. A fair question is, why does running xfstests
involve exercising vfio-pci? :) Internally our test machines use
vfio-pci for other reasons, xfstests is an innocent bystander here. We
just happened to trigger this WARN while xfstests was running, so it
noticed + reported the WARN in the test results.

Since that repro is specific to our test machine setup, it
unfortunately isn't an easily shareable regression test. :/

>
> Alex
>

