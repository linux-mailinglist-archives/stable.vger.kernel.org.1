Return-Path: <stable+bounces-71669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEC4966C94
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 00:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33960281C6B
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 22:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5592B1C2303;
	Fri, 30 Aug 2024 22:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wE053w2x"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520F81C173E
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725057362; cv=none; b=HnmdP80v6PgXltlgYksqR3RkfuINrP9IFxDDkpQyb+ZgLEHKdgOtOshChBNLD3Ojg8TI0pQGoHnKFSCSQgGkMRciOo3DSOeYFiP74SdzViSbNANzXBK9mqUix7+sPobDxYIOz/EOaEzJ6+eVSHsjQJU2WrDp4FjFLI+kTwG5PUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725057362; c=relaxed/simple;
	bh=Jki3kHjC/pOqeEQuN+kE4Utk1Wf3dQ8w9hFoRm2Bb3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dl8K+8Nu90YpsNqPfobWa2awEJ/MctQX3lk4mjxo4gIO7aqZewfrGf/Y89HiivPSX3soE69W9G8eAWyeVxhf5f/RjdQAaLQos6jYNbYkw2uK06qhCJPHBxSzSIUEZmMdzJ5P/U9OZJIBqzklcYEoqsNyrptUMfd8rcbOE7LoVzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wE053w2x; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-45029af1408so32601cf.1
        for <stable@vger.kernel.org>; Fri, 30 Aug 2024 15:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725057359; x=1725662159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BcN5bnCyZPtNp7WzKEseneLacj7nnrZE1HJU2+SHPU=;
        b=wE053w2xI8mEQUY/gmtNv1TNbHmuf8OrVy6JcxRSK3M/92v67J9RDNopUzXpupCwoj
         qk0A5ursgPsAl6cuqHa56BDQY/svZbAFbBjMT8PlvLJU2vy9X64hJGkP35NyD2N1WJG9
         qoBt22k6hww8wwMGM+nOcJ+mHZA3d6q01tiDsGXDwO5LzMI9nBBMijKmsji1HpLmoyor
         t9R2qeH3NV2x5K/p1WV46bFcLUzlrxkOW/xButND1SD428LcHi8lH56//e7sPTLhgSBL
         OC/WbyQ1NgDIjmpFPYULBDz7iIdhjyWFx9xsst8nfaR9wfvET7hCg+bMwW7Dxm6KDA+B
         pMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725057359; x=1725662159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BcN5bnCyZPtNp7WzKEseneLacj7nnrZE1HJU2+SHPU=;
        b=efQFVnMROIwCE2OtvY1veU4TVcvWjTXuApQl8xtztC0+4p7Lh8/zhOxALGurKT2GEi
         Vk1dRo/rGhGspabAuvTpvytKqDe3rbL9I/6x0B8cUoMD0MBo6F+N2H2ab0E0e8eANxSf
         ptWZLyOsqtn9R3KyqVV7X0NdZxJZzptkTElCzp0PAmdGEgs50TTg99qk+UdmBaref7g2
         qVtbUwkop/KhLoMAevt8zblo2nOiezk7/McRCjZbbkqo0WD2ZH0sD3JfDbvMhtdayftm
         6TRX317CPn6G+RuP/NbMo4opikrAO40rgASSmV58Unxy3+4hrj0VxbUTltEEkNtP0+cy
         QVYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkqiZoKJjgt3vJIQr3FL584hxuWySbqcdgor7jbz8YQWuU/fMK1YdISI6r7T9gZk3tFNT7UTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyASDo/H2dYHSLs48AgE0rnEjvSxS9DONxgSTcE2/MbBhDmF/zD
	XoCYaOEf/OlVMcrS/1+gxwPwCWk6LMWpa0XGme4rt+Ah/sdLCUnUnEMR0Xj9eyfl5ONCymqdgmD
	ydgTqVjQJFUUataVFZEuKObEytkqf//Ysiqgd
X-Google-Smtp-Source: AGHT+IFoSd8Mos6kY4XwhJyU0nOOLYz6b0y62Ml/7arp+4o+ejjewCSIGzaBDACK8YRr0nUuPSo/97aq7MVgfhtIGjM=
X-Received: by 2002:a05:622a:14ca:b0:453:62ee:3fe with SMTP id
 d75a77b69052e-457c420cb80mr428781cf.17.1725057358621; Fri, 30 Aug 2024
 15:35:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827143843.399359062@linuxfoundation.org> <20240827143852.163123189@linuxfoundation.org>
 <20240830221217.GA3837758@thelio-3990X>
In-Reply-To: <20240830221217.GA3837758@thelio-3990X>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 30 Aug 2024 15:35:35 -0700
Message-ID: <CAJuCfpGuOtzSshL6U+rT2ytZr2MBAH5yWAqMJd3hLDzHyZV3JA@mail.gmail.com>
Subject: Re: [PATCH 6.6 230/341] change alloc_pages name in dma_map_ops to
 avoid name conflicts
To: Nathan Chancellor <nathan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	stable@vger.kernel.org, patches@lists.linux.dev, 
	Kees Cook <keescook@chromium.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Benno Lossin <benno.lossin@proton.me>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Christoph Lameter <cl@linux.com>, Dennis Zhou <dennis@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Miguel Ojeda <ojeda@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 3:12=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Hi Greg and Sasha,
>
> On Tue, Aug 27, 2024 at 04:37:41PM +0200, Greg Kroah-Hartman wrote:
> > 6.6-stable review patch.  If anyone has any objections, please let me k=
now.
> >
> > ------------------
> >
> > From: Suren Baghdasaryan <surenb@google.com>
> >
> > [ Upstream commit 8a2f11878771da65b8ac135c73b47dae13afbd62 ]
> >
> > After redefining alloc_pages, all uses of that name are being replaced.
> > Change the conflicting names to prevent preprocessor from replacing the=
m
> > when it's not intended.
> >
> > Link: https://lkml.kernel.org/r/20240321163705.3067592-18-surenb@google=
.com
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Tested-by: Kees Cook <keescook@chromium.org>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Alex Gaynor <alex.gaynor@gmail.com>
> > Cc: Alice Ryhl <aliceryhl@google.com>
> > Cc: Andreas Hindborg <a.hindborg@samsung.com>
> > Cc: Benno Lossin <benno.lossin@proton.me>
> > Cc: "Bj=C3=B6rn Roy Baron" <bjorn3_gh@protonmail.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Dennis Zhou <dennis@kernel.org>
> > Cc: Gary Guo <gary@garyguo.net>
> > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > Stable-dep-of: 61ebe5a747da ("mm/vmalloc: fix page mapping if vm_area_a=
lloc_pages() with high order fallback to order 0")
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  arch/alpha/kernel/pci_iommu.c           | 2 +-
> >  arch/mips/jazz/jazzdma.c                | 2 +-
> >  arch/powerpc/kernel/dma-iommu.c         | 2 +-
> >  arch/powerpc/platforms/ps3/system-bus.c | 4 ++--
> >  arch/powerpc/platforms/pseries/vio.c    | 2 +-
> >  arch/x86/kernel/amd_gart_64.c           | 2 +-
> >  drivers/iommu/dma-iommu.c               | 2 +-
> >  drivers/parisc/ccio-dma.c               | 2 +-
> >  drivers/parisc/sba_iommu.c              | 2 +-
> >  drivers/xen/grant-dma-ops.c             | 2 +-
> >  drivers/xen/swiotlb-xen.c               | 2 +-
> >  include/linux/dma-map-ops.h             | 2 +-
> >  kernel/dma/mapping.c                    | 4 ++--
> >  13 files changed, 15 insertions(+), 15 deletions(-)
>
> This patch breaks the build for s390:
>
> arch/s390/pci/pci_dma.c:724:10: error: 'const struct dma_map_ops' has no =
member named 'alloc_pages'; did you mean 'alloc_pages_op'?
>   724 |         .alloc_pages    =3D dma_common_alloc_pages,
>       |          ^~~~~~~~~~~
>       |          alloc_pages_op
>
> https://storage.tuxsuite.com/public/clangbuiltlinux/continuous-integratio=
n2/builds/2lNUl0tacZpSlu9Edrlk3QoSElM/build.log
>
> This change happened after commit c76c067e488c ("s390/pci: Use dma-iommu
> layer") in mainline, which explains how it was missed for stable.
>
> The fix seems simple:
>
> diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
> index 99209085c75b..ce0f2990cb04 100644
> --- a/arch/s390/pci/pci_dma.c
> +++ b/arch/s390/pci/pci_dma.c
> @@ -721,7 +721,7 @@ const struct dma_map_ops s390_pci_dma_ops =3D {
>         .unmap_page     =3D s390_dma_unmap_pages,
>         .mmap           =3D dma_common_mmap,
>         .get_sgtable    =3D dma_common_get_sgtable,
> -       .alloc_pages    =3D dma_common_alloc_pages,
> +       .alloc_pages_op =3D dma_common_alloc_pages,
>         .free_pages     =3D dma_common_free_pages,
>         /* dma_supported is unconditionally true without a callback */
>  };
>
> but I think the better question is why this patch is even needed in the
> first place? It claims that it is a stable dependency of 61ebe5a747da
> but this patch does not even touch mm/vmalloc.c and 61ebe5a747da does
> not mention or touch anything with alloc_pages_op, so it seems like this
> change should just be reverted from 6.6?

Hmm, Nathan is right. I don't see any dependency between this patch
and 61ebe5a747da. Maybe some other patch that uses .alloc_pages_op got
backported and that caused a dependency but then that other patch
should be changed to use .alloc_pages. I'm syncing stable 6.6 to
check. Thanks for pointing this out Nathan!


>
> Cheers,
> Nathan

