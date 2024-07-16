Return-Path: <stable+bounces-59380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA398931E45
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 03:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9FE1F21D3B
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 01:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CA0187F;
	Tue, 16 Jul 2024 01:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZO4tJMWa"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F17AD24
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 01:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721092025; cv=none; b=Z53I07iounld7maKvTUSrDYnyd04C8ZJLazq+s++YaacGPQ1mMKls8KO/8UD6HDECGnS+jXDrF70ZfXJSTqZTnCuku5eyX1LaJjv6JN2dPFZEAjIHWAtXfNqqnoEq7kBHY6D/M+SAeGsNgpZqyH1wx8aQiDnSh/GhCKcY0dB9Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721092025; c=relaxed/simple;
	bh=P6vSg+1O7xfvHhGHr28oCMXp05yXPY2sLApC0Izkq0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtjirCZCLut22ZaFTtG5xMEafyPs93VMsVQhPNTMSuT0DRKGbYDW3lotMZS17EQ/Ai+O2iCWIa/2QsWB7KYuNmBUd7qIlA1jr2LMPqUY/LKYom70oEEDn8qN701Qo9GEYXhVT3T1WtjEVOHOStKd9fhmbY3xd45EWBIzLhGHF18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZO4tJMWa; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-367975543a8so3004844f8f.3
        for <stable@vger.kernel.org>; Mon, 15 Jul 2024 18:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721092022; x=1721696822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvcH0OpAvnhSKZAMR6OOQCJWbBdaQvsE4fmU0ZI1i2M=;
        b=ZO4tJMWa/flz4Mj+wETwOIGj5dUEYUwJeLs0A67fNoPZogHfSbJHyEvhEzdmObXmij
         AGEds5fhngFNx8YfbEB0Z61CmVWM0Mt8zYlErJpAsFM4WOnkyFkgqcZrL0Wu2AY1PzRH
         pyLkumGMO2vhoPwNJDMgAGnlaqcyW3E41+pcsliF2tlB6+zR0HziHoShL2UCVTjyY+3l
         52gomqjJ3JytofLPH+lBw/loBPksSzFT54EAKEWeVynHPRoiOdJMHr/5EmAFlqO4SYoq
         VHwedXpsFiI75VNpSVCkXVcmxybwkTPBykKj2Yp0diz3CGtbjwx8o4OI8vCsDqbEcmy7
         q9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721092022; x=1721696822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvcH0OpAvnhSKZAMR6OOQCJWbBdaQvsE4fmU0ZI1i2M=;
        b=nDtqEQVxRCpBdBDlRZQh3CzCyDtA60E3Zio5ye99jeosvE3l/S/9QI5kXBGeIX8BA3
         KBZZEu+vsAiQKfFdOEwCjZpa8QEhteZE1AbKLmWaMAeNTTTPVtHoBMuVjJ12hpWj9kBR
         vmNOBlaiJF3rtHwpoPDQK/TPCPTM/BHRP6sgEIpjktbki4HMJUO0tb8yMB12wqgrnjg+
         k0qoSX//kNt20V+GNI6TF4ztTvPegB24McFBCYGqJC91MNUq0ByU873UfNANKHeD84Az
         gjSoFc2QtQ9QPBVM/r7R/qIG243weSEAyF2w+eSQbnFSTy35olABeYytuSOm0D5skC/Q
         3eoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8r3Er2JxZgFzw/i67vdFxEzf5q+NvOwjj1qgg3A9xS0K2TYdLEiG6SPmO5f4Er+QW4DV/KcrtftwIjndrH7qMlYDNJ74J
X-Gm-Message-State: AOJu0Yy/JeNYAnjrYNHOZmgyey9WRagJabyuIoHMz9nCw+qZtAIy0Ugg
	mVrHpEpgaPWG1YVhpb+E5nGiWEOcKLQLXvARJ8VghnvOG3PYoGAiGCkltLuGXbhOTUjBfWSshG9
	v+TXowNgGDV2BFF2813oGzZIPx3NHgdrn0Hxt
X-Google-Smtp-Source: AGHT+IFNzpbx/auXzo4ZpqmQQ3KZIWJNGUS1pmr0uRBHDlxlQhLx/2fi66kmHgpB7FOSc/kcRx8iNz8lPryR2x7pNqg=
X-Received: by 2002:a5d:408e:0:b0:367:4dc9:52e8 with SMTP id
 ffacd0b85a97d-36826105d92mr259791f8f.16.1721092021796; Mon, 15 Jul 2024
 18:07:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACzhbgRoMEAzkEVZPMEHR2JsNn5ZNw1SwKqP1FVzej4g_87snQ@mail.gmail.com>
 <20240715203541.389415-1-axelrasmussen@google.com> <20240715162145.6e13cbff.alex.williamson@redhat.com>
In-Reply-To: <20240715162145.6e13cbff.alex.williamson@redhat.com>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Mon, 15 Jul 2024 18:06:25 -0700
Message-ID: <CAJHvVcgQUoEFF93m-TADJ-n6pDKGJH=xr0mx9bW6Qw5nq5KzOw@mail.gmail.com>
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

On Mon, Jul 15, 2024 at 3:21=E2=80=AFPM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Mon, 15 Jul 2024 13:35:41 -0700
> Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> > I tried out Sasha's suggestion. Note that *just* taking
> > aac6db75a9 ("vfio/pci: Use unmap_mapping_range()") is not sufficient, w=
e also
> > need b7c5e64fec ("vfio: Create vfio_fs_type with inode per device").
> >
> > But, the good news is both of those apply more or less cleanly to 6.6. =
And, at
> > least under a very basic test which exercises VFIO memory mapping, thin=
gs seem
> > to work properly with that change.
> >
> > I would agree with Leah that these seem a bit big to be stable fixes. B=
ut, I'm
> > encouraged by the fact that Sasha suggested taking them. If there are n=
o big
> > objections (Alex? :) ) I can send the backport patches this week.
> >
>
> If you were to take those, I think you'd also want:
>
> d71a989cf5d9 ("vfio/pci: Insert full vma on mmap'd MMIO fault")
>
> which helps avoid a potential regression in VM startup latency vs
> faulting each page of the VMA.  Ideally we'd have had huge_fault
> working for pfnmaps before this conversion to avoid the latter commit.
>
> I'm a bit confused by the lineage here though, 35e351780fa9 ("fork:
> defer linking file vma until vma is fully initialized") entered v6.9
> whereas these vfio changes all came in v6.10, so why does the v6.6
> backport end up with dependencies on these newer commits?  Is there
> something that needs to be fixed in v6.9-stable as well?

Right, I believe 35e351780fa9 introduced a bug for VFIO by calling
vm_ops->open() *before* copy_page_range(). So I think this bug affects
not just 6.6 (to which 35e351780fa9 was stable backported) but also
6.9 as you say.

The reason to bring up all these newer commits is, it's unclear how to
fix the bug. :) We thought we had a simple solution to just reorder
when vm_ops->open() is called, but Miaohe pointed out elsewhere in
this thread an issue with doing that.

Assuming the reordering is unworkable, the only other idea I have for
fixing the bug without the larger refactor is:

1. Mark VFIO VMAs VM_WIPEONFORK so we don't copy_page_range after
vm_ops->open() is called
2. Remove the WARN_ON_ONCE(1) in get_pat_info() so when VFIO zaps a
not-fully-populated range (expected if we never copy_page_range!) we
don't get a warning

There are downsides to this fix. It's kind of abusing VM_WIPEONFORK
for a new purpose. It's removing a warning which may catch other
legitimate problems. And it's diverging stable kernels from upstream
as Sasha points out.

Just backporting the refactors fixes (well, totally avoids) the bug,
and it doesn't require special hackery only for stable kernels.

>
> Aside from the size of aac6db75a9 in particular, I'm not aware of any
> outstanding issues that would otherwise dissuade backport to
> v6.6-stable.  Thanks,
>
> Alex
>

