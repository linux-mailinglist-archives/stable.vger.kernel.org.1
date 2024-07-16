Return-Path: <stable+bounces-60274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F03932F05
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 19:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96ECCB23053
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750ED19FA6C;
	Tue, 16 Jul 2024 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzZ0oe7K"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6855919F499
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721150738; cv=none; b=tR2PsHgK77+nNgeV94olF7ZgN9cFNdQmH88NaDiYbQFWuvqHr3lUntv0Jt2pQvaDHzzxtTm+iAITBjamdCMrQiKQrpPqpc9Twu8zExzVYtEoumiMa5pk3fXXEq2akkx5h4gZNNQqrU6VnoTiAN0E0Ia4OtVQIV2reaASbYSVajw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721150738; c=relaxed/simple;
	bh=TtO+2oBrVUJejgO+0pt0RVD19TgzVhYzYM3PlZeLnpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3o+NzO1AyykhYnKKguJqgK0BVfLUBKw8tC1GgLNaO8fLT9Jw9Ilf7jp1wg28SdYoF9kStqcpo1xQBQuPvh+eruFVmgHu7/lu5FETAkdRdMGzYG+8OvZ940KxBsSUgqYcPg+vdw4mdmUOB8s+pigUuboutjyrFu+2kyNoqq9j2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KzZ0oe7K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721150735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8S9ThcrDetrR7Lq5Ep/tvPEUpcVVlHhcs4+t5/LQIdA=;
	b=KzZ0oe7KVBNHaR65yvjpwVQ45pUrccaTo0vVDiSX8S9CAju6RHhrSM/gM68sbwrkHoCA1d
	IoEMvuCX0fmHG/EaViZWyHLxlgtF3AtQMaObNKPYavx7kdysElFN0OBB6SBPjOfZUxxmyD
	b9A2osDAghT0vsEqN+IB19haFyyW3as=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-ar5hIdFOMmuN3mBqE2V_ZA-1; Tue, 16 Jul 2024 13:25:34 -0400
X-MC-Unique: ar5hIdFOMmuN3mBqE2V_ZA-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f61da4d7beso3214639f.2
        for <stable@vger.kernel.org>; Tue, 16 Jul 2024 10:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721150733; x=1721755533;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8S9ThcrDetrR7Lq5Ep/tvPEUpcVVlHhcs4+t5/LQIdA=;
        b=GunSfnlFFtS9VnsgurytAVb/mCpbmULiF00tuPK8z6QOfEcqqSTl9Jct3gdLx8H7Jx
         d7Nhlyz7Mlq5ZdusmurvaFaXNlGo5DkN0zaxhVqzwrUEPjLuYomz8EqKH7ZitFuYoY4s
         KbhoaLiQAY0dSvoXWi/4QY0YHIOSphqcvgaNk5ak+h/Yl4PhG+fivTIDiJxhVFW1EEoU
         6OeVjqUtsW9KBDdcQOZtUaSbe0a6o02TfoQsBKOMxlSCikJC+QIs4pnGq+kqJ3JXKdvE
         QASJJmqD47oXYDcEa2OaLVIKIu8Ntk/zwOKJcaRexUN32z2ETeyJ2LSk7Y/dACDOYE5M
         5srQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpo7MgBRM5WcciCZUyHARlrVELy/pPSXoGzgJjSnwCmI/mF5/ddnxnukcF26q8F1AqJKUt+kPMacjLs1qsfhx1DRb+XO8E
X-Gm-Message-State: AOJu0YznG5oi7O9eo3RZJnSWd214eG9g7bivoUPTlsQJIrL05FCPaawq
	F4zxWlH2QPpW4vjJeZ6Gwlw0l9giv1e/lYpuZQc0/tNo+3+tM2Iu+6LNM2ZsTjslZ0v6H0zrO4o
	ujlm+X84MbMaUd/T777HYful6pmeL3AOipVuMOASXO0oIpW0agDbf1Q==
X-Received: by 2002:a05:6602:6b87:b0:7f9:59af:c26b with SMTP id ca18e2360f4ac-816c5882376mr8159739f.17.1721150733178;
        Tue, 16 Jul 2024 10:25:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr4Vz46Tb8yZ1yuIdW+BxaTKBrzHBAcQbUUt2laratVtJjO3IHmW9CZo+Qx+d9DUsPj1C1IQ==
X-Received: by 2002:a05:6602:6b87:b0:7f9:59af:c26b with SMTP id ca18e2360f4ac-816c5882376mr8156939f.17.1721150732779;
        Tue, 16 Jul 2024 10:25:32 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c210bbef80sm23654173.27.2024.07.16.10.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 10:25:32 -0700 (PDT)
Date: Tue, 16 Jul 2024 11:25:30 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Leah Rumancik <leah.rumancik@gmail.com>, Sasha Levin
 <sashal@kernel.org>, stable@vger.kernel.org, Miaohe Lin
 <linmiaohe@huawei.com>, Thorvald Natvig <thorvald@google.com>, Jane Chu
 <jane.chu@oracle.com>, Christian Brauner <brauner@kernel.org>, Heiko
 Carstens <hca@linux.ibm.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mateusz Guzik
 <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>, Muchun Song
 <muchun.song@linux.dev>, Oleg Nesterov <oleg@redhat.com>, Peng Zhang
 <zhangpeng.00@bytedance.com>, Tycho Andersen <tandersen@netflix.com>,
 Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.6] fork: defer linking file vma until vma is fully
 initialized
Message-ID: <20240716112530.2562c41b.alex.williamson@redhat.com>
In-Reply-To: <CAJHvVcjA4KJTSTa1_PFs3yBzV0Gbv2SVEHfqBbOX0GEXMciDUw@mail.gmail.com>
References: <CACzhbgRoMEAzkEVZPMEHR2JsNn5ZNw1SwKqP1FVzej4g_87snQ@mail.gmail.com>
	<20240715203541.389415-1-axelrasmussen@google.com>
	<20240715162145.6e13cbff.alex.williamson@redhat.com>
	<CAJHvVcgQUoEFF93m-TADJ-n6pDKGJH=xr0mx9bW6Qw5nq5KzOw@mail.gmail.com>
	<20240716100813.72430d00.alex.williamson@redhat.com>
	<CAJHvVcjA4KJTSTa1_PFs3yBzV0Gbv2SVEHfqBbOX0GEXMciDUw@mail.gmail.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jul 2024 09:58:34 -0700
Axel Rasmussen <axelrasmussen@google.com> wrote:

> On Tue, Jul 16, 2024 at 9:08=E2=80=AFAM Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > On Mon, 15 Jul 2024 18:06:25 -0700
> > Axel Rasmussen <axelrasmussen@google.com> wrote:
> > =20
> > > On Mon, Jul 15, 2024 at 3:21=E2=80=AFPM Alex Williamson
> > > <alex.williamson@redhat.com> wrote: =20
> > > >
> > > > On Mon, 15 Jul 2024 13:35:41 -0700
> > > > Axel Rasmussen <axelrasmussen@google.com> wrote:
> > > > =20
> > > > > I tried out Sasha's suggestion. Note that *just* taking
> > > > > aac6db75a9 ("vfio/pci: Use unmap_mapping_range()") is not suffici=
ent, we also
> > > > > need b7c5e64fec ("vfio: Create vfio_fs_type with inode per device=
").
> > > > >
> > > > > But, the good news is both of those apply more or less cleanly to=
 6.6. And, at
> > > > > least under a very basic test which exercises VFIO memory mapping=
, things seem
> > > > > to work properly with that change.
> > > > >
> > > > > I would agree with Leah that these seem a bit big to be stable fi=
xes. But, I'm
> > > > > encouraged by the fact that Sasha suggested taking them. If there=
 are no big
> > > > > objections (Alex? :) ) I can send the backport patches this week.
> > > > > =20
> > > >
> > > > If you were to take those, I think you'd also want:
> > > >
> > > > d71a989cf5d9 ("vfio/pci: Insert full vma on mmap'd MMIO fault")
> > > >
> > > > which helps avoid a potential regression in VM startup latency vs
> > > > faulting each page of the VMA.  Ideally we'd have had huge_fault
> > > > working for pfnmaps before this conversion to avoid the latter comm=
it.
> > > >
> > > > I'm a bit confused by the lineage here though, 35e351780fa9 ("fork:
> > > > defer linking file vma until vma is fully initialized") entered v6.9
> > > > whereas these vfio changes all came in v6.10, so why does the v6.6
> > > > backport end up with dependencies on these newer commits?  Is there
> > > > something that needs to be fixed in v6.9-stable as well? =20
> > >
> > > Right, I believe 35e351780fa9 introduced a bug for VFIO by calling
> > > vm_ops->open() *before* copy_page_range(). So I think this bug affects
> > > not just 6.6 (to which 35e351780fa9 was stable backported) but also
> > > 6.9 as you say.
> > >
> > > The reason to bring up all these newer commits is, it's unclear how to
> > > fix the bug. :) We thought we had a simple solution to just reorder
> > > when vm_ops->open() is called, but Miaohe pointed out elsewhere in
> > > this thread an issue with doing that.
> > >
> > > Assuming the reordering is unworkable, the only other idea I have for
> > > fixing the bug without the larger refactor is:
> > >
> > > 1. Mark VFIO VMAs VM_WIPEONFORK so we don't copy_page_range after
> > > vm_ops->open() is called
> > > 2. Remove the WARN_ON_ONCE(1) in get_pat_info() so when VFIO zaps a
> > > not-fully-populated range (expected if we never copy_page_range!) we
> > > don't get a warning
> > >
> > > There are downsides to this fix. It's kind of abusing VM_WIPEONFORK
> > > for a new purpose. It's removing a warning which may catch other
> > > legitimate problems. And it's diverging stable kernels from upstream
> > > as Sasha points out.
> > >
> > > Just backporting the refactors fixes (well, totally avoids) the bug,
> > > and it doesn't require special hackery only for stable kernels. =20
> >
> > Yes, I'd agree that we want to stay as close as possible to the current
> > upstream solution, even if we got there pretty haphazardly.  Therefore
> > it sounds like we should queue the following for v6.9-stable:
> >
> > d71a989cf5d9 ("vfio/pci: Insert full vma on mmap'd MMIO fault")
> > aac6db75a9fc ("vfio/pci: Use unmap_mapping_range()")
> > b7c5e64fecfa ("vfio: Create vfio_fs_type with inode per device")
> >
> > And then anywhere that 35e351780fa9 ("fork: defer linking file vma
> > until vma is fully initialized") gets backported, those will also need
> > to follow. =20
>=20
> Sounds good to me. I can send these patches for 6.9 and then 6.6.
>=20
> >
> > Did anyone report an issue with 35e351780fa9 and vfio on v6.9 or the
> > previous v6.6 backport to use as a test case or do we just know it's an
> > issue from inspection?  The revert only notes an xfstest issue.  Thanks=
, =20
>=20
> I'm not aware of any reports of this, besides our own detection internall=
y.
>=20
> We originally noticed via xfstests the failure mode where we call
> copy_page_range, so underneath untrack_pfn we find a 'hole' in the
> mapping so we WARN. A fair question is, why does running xfstests
> involve exercising vfio-pci? :) Internally our test machines use
> vfio-pci for other reasons, xfstests is an innocent bystander here. We
> just happened to trigger this WARN while xfstests was running, so it
> noticed + reported the WARN in the test results.
>=20
> Since that repro is specific to our test machine setup, it
> unfortunately isn't an easily shareable regression test. :/

Aha, that helps put the pieces together and is an interesting data
point for vfio-pci use :)  Sounds like you're then best able to verify
the issue exists on v6.9 and the fix with the above three vfio patches,
assuming you've got the bandwidth.  Let me know if you need any
support.  Thanks!

Alex


