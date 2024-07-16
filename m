Return-Path: <stable+bounces-60173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200AC932DB4
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424DC1C20B30
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69F519DF75;
	Tue, 16 Jul 2024 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3oLky64"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5111DDCE
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721146101; cv=none; b=TSyxcrnJgHS9nHVzM4Vlha++qrElb+UWptaqr8NqvFtWSWEU6szAsRwUIfpdsgfAZ/eVk80GrkkgcOL7IU3qGOP7giwgE++O93vViS5pxa8r+EhbtsLmp+vweIrV4MCB13zw0glmj300esaS9JnAyhh7rLghGRzYzsBHMA4HR9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721146101; c=relaxed/simple;
	bh=DFDnSBk4NO2R96ux3etY/JcefEfAOczRWpKadA+u/1k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVfrdPP2BVGG2rJEJ0YXMh2zam/Ku2fg6E751Nrtm0tEsRne+QQGdC3ezezU/770PCQ7sbCIOqD/7z11vf+el5tGt3LLCvrk7FvGncmvYr7uReEc9FQX1NTAASPB+E49Siu3qV6MejeYXgjcayBxABpa1K9RjqaMJqPkr4vXEJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G3oLky64; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721146099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3ipenqAtXhjvOVSJMy0lWBKKlh+WfjKn0PEfbMykXk=;
	b=G3oLky64swjn50EYEmuDrreem65C21nZTjXDGA6eZAlVhFX3zclweWpgtNDP1pYvgNcYqR
	XXjRq+ADubSFNK+0P0u1HZdouiuGDZMGvgX1pHajL4R3py9OS01l5z5GdnA6zjk+ULxiYN
	zzvyVVDfvaqk5Wdz6P27JqA/kxuwgpE=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-QxgXQhqVNr-QIzmfAUs_QA-1; Tue, 16 Jul 2024 12:08:17 -0400
X-MC-Unique: QxgXQhqVNr-QIzmfAUs_QA-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f6218c0d68so707434539f.3
        for <stable@vger.kernel.org>; Tue, 16 Jul 2024 09:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721146096; x=1721750896;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v3ipenqAtXhjvOVSJMy0lWBKKlh+WfjKn0PEfbMykXk=;
        b=PNsecdBFlWF56xatQXd1FjCBE+PoHVzy1QUcVps0xrcZiiuXDXnfgG6xYIeS7v5bRd
         9yCZ4vouxJOVSphJlNs0uHz7ro3+t1Y1ePXa/21ZXvP/LmEa+dpWezegMV5CtwLqLYGv
         ibgI6yO0dKcrMdaa8uGYPqz1beMwfCo9iSBPu4cLmPBHD2B9VN6fAG86TGU6mF/j15/y
         nr9k8gPr/XNxRDbqt53z5bmGsZd9e7E4k+E48YVOtkRuArK9qtNymuKLa6BjVLS187kO
         c+UPmudk0sJ7JK5E82ClQWozmoENorS+BXpUD0L3UgFfYhEiHm9Zr1nEmrwd2v8w1PlJ
         eX8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmx9kT3sRyDf6DKYVqku8R9CLkbqGkHH08X6XjidIZouOJW6+JJFBQlLzAf2vTyNfOE7c08MRv3JtNaOBM8Dp256q4qdXi
X-Gm-Message-State: AOJu0YwFz6LDhaK7IOToDFl0zZ90X40l7KqffLSwh1T9Ujy1ebNFS6rH
	kGuD+JPkau3vS5DWuD6q8MUzrmUADUd3xEo20rJdnzDz6rFFnYAvZT6ClOIbW5RXkGDFSRm/8Ef
	aJ/vF1oVpaIfpT8KLeuSeTTA9zdQVqDd67BKuAE+3S+cIJRVf78AY7w==
X-Received: by 2002:a05:6602:6b88:b0:7f6:1cb2:8027 with SMTP id ca18e2360f4ac-81576bdea12mr322110139f.17.1721146096314;
        Tue, 16 Jul 2024 09:08:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1e8FsDROcQTGGq7/PxXkqQBAUruYIa6s/I1iSCL5WORNgS0BE2ltk/ZA9wX87llCWlDigBQ==
X-Received: by 2002:a05:6602:6b88:b0:7f6:1cb2:8027 with SMTP id ca18e2360f4ac-81576bdea12mr322102539f.17.1721146095929;
        Tue, 16 Jul 2024 09:08:15 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-80e115fc350sm199763139f.7.2024.07.16.09.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 09:08:15 -0700 (PDT)
Date: Tue, 16 Jul 2024 10:08:13 -0600
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
Message-ID: <20240716100813.72430d00.alex.williamson@redhat.com>
In-Reply-To: <CAJHvVcgQUoEFF93m-TADJ-n6pDKGJH=xr0mx9bW6Qw5nq5KzOw@mail.gmail.com>
References: <CACzhbgRoMEAzkEVZPMEHR2JsNn5ZNw1SwKqP1FVzej4g_87snQ@mail.gmail.com>
	<20240715203541.389415-1-axelrasmussen@google.com>
	<20240715162145.6e13cbff.alex.williamson@redhat.com>
	<CAJHvVcgQUoEFF93m-TADJ-n6pDKGJH=xr0mx9bW6Qw5nq5KzOw@mail.gmail.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Jul 2024 18:06:25 -0700
Axel Rasmussen <axelrasmussen@google.com> wrote:

> On Mon, Jul 15, 2024 at 3:21=E2=80=AFPM Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > On Mon, 15 Jul 2024 13:35:41 -0700
> > Axel Rasmussen <axelrasmussen@google.com> wrote:
> > =20
> > > I tried out Sasha's suggestion. Note that *just* taking
> > > aac6db75a9 ("vfio/pci: Use unmap_mapping_range()") is not sufficient,=
 we also
> > > need b7c5e64fec ("vfio: Create vfio_fs_type with inode per device").
> > >
> > > But, the good news is both of those apply more or less cleanly to 6.6=
. And, at
> > > least under a very basic test which exercises VFIO memory mapping, th=
ings seem
> > > to work properly with that change.
> > >
> > > I would agree with Leah that these seem a bit big to be stable fixes.=
 But, I'm
> > > encouraged by the fact that Sasha suggested taking them. If there are=
 no big
> > > objections (Alex? :) ) I can send the backport patches this week.
> > > =20
> >
> > If you were to take those, I think you'd also want:
> >
> > d71a989cf5d9 ("vfio/pci: Insert full vma on mmap'd MMIO fault")
> >
> > which helps avoid a potential regression in VM startup latency vs
> > faulting each page of the VMA.  Ideally we'd have had huge_fault
> > working for pfnmaps before this conversion to avoid the latter commit.
> >
> > I'm a bit confused by the lineage here though, 35e351780fa9 ("fork:
> > defer linking file vma until vma is fully initialized") entered v6.9
> > whereas these vfio changes all came in v6.10, so why does the v6.6
> > backport end up with dependencies on these newer commits?  Is there
> > something that needs to be fixed in v6.9-stable as well? =20
>=20
> Right, I believe 35e351780fa9 introduced a bug for VFIO by calling
> vm_ops->open() *before* copy_page_range(). So I think this bug affects
> not just 6.6 (to which 35e351780fa9 was stable backported) but also
> 6.9 as you say.
>=20
> The reason to bring up all these newer commits is, it's unclear how to
> fix the bug. :) We thought we had a simple solution to just reorder
> when vm_ops->open() is called, but Miaohe pointed out elsewhere in
> this thread an issue with doing that.
>=20
> Assuming the reordering is unworkable, the only other idea I have for
> fixing the bug without the larger refactor is:
>=20
> 1. Mark VFIO VMAs VM_WIPEONFORK so we don't copy_page_range after
> vm_ops->open() is called
> 2. Remove the WARN_ON_ONCE(1) in get_pat_info() so when VFIO zaps a
> not-fully-populated range (expected if we never copy_page_range!) we
> don't get a warning
>=20
> There are downsides to this fix. It's kind of abusing VM_WIPEONFORK
> for a new purpose. It's removing a warning which may catch other
> legitimate problems. And it's diverging stable kernels from upstream
> as Sasha points out.
>=20
> Just backporting the refactors fixes (well, totally avoids) the bug,
> and it doesn't require special hackery only for stable kernels.

Yes, I'd agree that we want to stay as close as possible to the current
upstream solution, even if we got there pretty haphazardly.  Therefore
it sounds like we should queue the following for v6.9-stable:

d71a989cf5d9 ("vfio/pci: Insert full vma on mmap'd MMIO fault")
aac6db75a9fc ("vfio/pci: Use unmap_mapping_range()")
b7c5e64fecfa ("vfio: Create vfio_fs_type with inode per device")

And then anywhere that 35e351780fa9 ("fork: defer linking file vma
until vma is fully initialized") gets backported, those will also need
to follow.

Did anyone report an issue with 35e351780fa9 and vfio on v6.9 or the
previous v6.6 backport to use as a test case or do we just know it's an
issue from inspection?  The revert only notes an xfstest issue.  Thanks,

Alex


