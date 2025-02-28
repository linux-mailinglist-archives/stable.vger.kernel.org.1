Return-Path: <stable+bounces-119949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE24A49C1D
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 15:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A6A07A8D4A
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 14:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3EE26E652;
	Fri, 28 Feb 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAHIOvNY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8539D26E140;
	Fri, 28 Feb 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753251; cv=none; b=R2jttrpK+zIaEBNWbHJJQn3kTiH1gxv2XhUuERLel98FYEaEnU+3bvIZx89KaM1AlZBNORpvHPlJ9fDyxuMk3BCIQS4/xcFqjXpwBt6rNRRibbe8nuXFWtk0sw4vv1h8WfBLwLfG3MNP7PxCcGzxZ6/nYgCv/acKGyx4G1JRLqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753251; c=relaxed/simple;
	bh=CzIbW0o33OzQ/dvtghW+Ev6TO3WApyZt22MutK31V7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hhm6y4nUu7XM1e6ByHqey22L+9ZRaWBC7vyox+M+JWZJ+DxW7YF7XXLfD5Gj6CPxbNzUbxp083u8z0LFLQWJ5XgsDfjlNONJn3TQbrsREZF9L6nEmAgvBkfl+IQU5O7SstIjUwWFULNlJSuArpsOFgkyd6scuS6pEqLIjmBULPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAHIOvNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229DCC4CEEE;
	Fri, 28 Feb 2025 14:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740753251;
	bh=CzIbW0o33OzQ/dvtghW+Ev6TO3WApyZt22MutK31V7U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VAHIOvNYdMIAEn2JDo6OfpohcWKWwLEvVeJ432gTT1s/5jXAKnhcciSJ3sow/SsdA
	 IQgfOvmVs6qm3vI0vVgCOlkqIEn9ZSItUDZIc1NJ8PhE8Ph5rCk3jxOCIDW513mEXJ
	 6EHCA9lLHAGrhIIdiS/f5ZtY0upFYxzSYw5QXYCYL+aGBUEmqm2/KXHg8XX3C3JXi0
	 M8EWNKWKhDwLqzDKmk7uCqk+sVyQJEn9K2YhZD/9f0U99xAoqz6bU9BUYiGcprNjF+
	 eifmBl8eEGpichwcjoC4l+ECCGh6i9xnczCQTbOGMlq22DqOj9ki2D5r/Y1qL95+B7
	 qtt19AknrlNTw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e0813bd105so3650810a12.1;
        Fri, 28 Feb 2025 06:34:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCULLTP+jYSUpv9yhLu92H1XcidTBJnvIV3sbCJYMvvtlLlweDeWIAMSya6t8JZ/L6nvzkkP3/WPCggT@vger.kernel.org, AJvYcCWHGW75mlw6eKMrecP3rsaQ4sZ1fIJrketC58cJby88nUG1qkZSyYlix1gqozubYPr5LNP8pboq@vger.kernel.org, AJvYcCXrUcw0ADsoSupLCNya1KHlRaNREBD9aS9fgHEDPjdL4x2WpueCuq/lMwf/aBChPZh9InukB/HhFT0VGliU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw09aWSC24giHCHlcrrUpWR8zS23CShkC565/0QTT2c+UBnmc4O
	REUckDtZCQ6Bsix2VBsi/NUuVoLT1uQTk8F9PFcOyH6jEy8gph0XgLCOfChPCNf2ECE42LZM9Hv
	2Nat9wrML2lRmPwSBstAJ/G/eyQ==
X-Google-Smtp-Source: AGHT+IG31uJKnlHKhPFsag5MHSdByYhINhrZhKlmGSnjI3Xy2zVPMvBXVlqCu3vFyWFZ2V7qRG6b611uun2gLaCfG9o=
X-Received: by 2002:a05:6402:5247:b0:5db:e7eb:1b34 with SMTP id
 4fb4d7f45d1cf-5e4d6ae14a1mr3066052a12.13.1740753249564; Fri, 28 Feb 2025
 06:34:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008220624.551309-1-quic_obabatun@quicinc.com>
 <20241008220624.551309-2-quic_obabatun@quicinc.com> <20250226115044.zw44p5dxlhy5eoni@pengutronix.de>
In-Reply-To: <20250226115044.zw44p5dxlhy5eoni@pengutronix.de>
From: Rob Herring <robh@kernel.org>
Date: Fri, 28 Feb 2025 08:33:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKvRQdbBOsz4_mWAJ+MDcM+6hdhgyT6hd22z7Oi9bGAkA@mail.gmail.com>
X-Gm-Features: AQ5f1JqbbdBcDaexIIwlgZLPXjCHtCF0EsZOabXXIFNikLd4BEgsDUlAYiFa0bM
Message-ID: <CAL_JsqKvRQdbBOsz4_mWAJ+MDcM+6hdhgyT6hd22z7Oi9bGAkA@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] of: reserved_mem: Restruture how the reserved
 memory regions are processed
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, aisheng.dong@nxp.com, 
	andy@black.fi.intel.com, catalin.marinas@arm.com, devicetree@vger.kernel.org, 
	hch@lst.de, iommu@lists.linux.dev, kernel@quicinc.com, klarasmodin@gmail.com, 
	linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, 
	quic_ninanaik@quicinc.com, robin.murphy@arm.com, saravanak@google.com, 
	will@kernel.org, stable@vger.kernel.org, kernel@pengutronix.de, 
	sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 5:51=E2=80=AFAM Marco Felsch <m.felsch@pengutronix.=
de> wrote:
>
> Hi,
>
> On 24-10-08, Oreoluwa Babatunde wrote:
> > Reserved memory regions defined in the devicetree can be broken up into
> > two groups:
> > i) Statically-placed reserved memory regions
> > i.e. regions defined with a static start address and size using the
> >      "reg" property.
> > ii) Dynamically-placed reserved memory regions.
> > i.e. regions defined by specifying an address range where they can be
> >      placed in memory using the "alloc_ranges" and "size" properties.
> >
> > These regions are processed and set aside at boot time.
> > This is done in two stages as seen below:
> >
> > Stage 1:
> > At this stage, fdt_scan_reserved_mem() scans through the child nodes of
> > the reserved_memory node using the flattened devicetree and does the
> > following:
> >
> > 1) If the node represents a statically-placed reserved memory region,
> >    i.e. if it is defined using the "reg" property:
> >    - Call memblock_reserve() or memblock_mark_nomap() as needed.
> >    - Add the information for that region into the reserved_mem array
> >      using fdt_reserved_mem_save_node().
> >      i.e. fdt_reserved_mem_save_node(node, name, base, size).
> >
> > 2) If the node represents a dynamically-placed reserved memory region,
> >    i.e. if it is defined using "alloc-ranges" and "size" properties:
> >    - Add the information for that region to the reserved_mem array with
> >      the starting address and size set to 0.
> >      i.e. fdt_reserved_mem_save_node(node, name, 0, 0).
> >    Note: This region is saved to the array with a starting address of 0
> >    because a starting address is not yet allocated for it.
> >
> > Stage 2:
> > After iterating through all the reserved memory nodes and storing their
> > relevant information in the reserved_mem array,fdt_init_reserved_mem() =
is
> > called and does the following:
> >
> > 1) For statically-placed reserved memory regions:
> >    - Call the region specific init function using
> >      __reserved_mem_init_node().
> > 2) For dynamically-placed reserved memory regions:
> >    - Call __reserved_mem_alloc_size() which is used to allocate memory
> >      for each of these regions, and mark them as nomap if they have the
> >      nomap property specified in the DT.
> >    - Call the region specific init function.
> >
> > The current size of the resvered_mem array is 64 as is defined by
> > MAX_RESERVED_REGIONS. This means that there is a limitation of 64 for
> > how many reserved memory regions can be specified on a system.
> > As systems continue to grow more and more complex, the number of
> > reserved memory regions needed are also growing and are starting to hit
> > this 64 count limit, hence the need to make the reserved_mem array
> > dynamically sized (i.e. dynamically allocating memory for the
> > reserved_mem array using membock_alloc_*).
> >
> > On architectures such as arm64, memory allocated using memblock is
> > writable only after the page tables have been setup. This means that if
> > the reserved_mem array is going to be dynamically allocated, it needs t=
o
> > happen after the page tables have been setup, not before.
> >
> > Since the reserved memory regions are currently being processed and
> > added to the array before the page tables are setup, there is a need to
> > change the order in which some of the processing is done to allow for
> > the reserved_mem array to be dynamically sized.
> >
> > It is possible to process the statically-placed reserved memory regions
> > without needing to store them in the reserved_mem array until after the
> > page tables have been setup because all the information stored in the
> > array is readily available in the devicetree and can be referenced at
> > any time.
> > Dynamically-placed reserved memory regions on the other hand get
> > assigned a start address only at runtime, and hence need a place to be
> > stored once they are allocated since there is no other referrence to th=
e
> > start address for these regions.
> >
> > Hence this patch changes the processing order of the reserved memory
> > regions in the following ways:
> >
> > Step 1:
> > fdt_scan_reserved_mem() scans through the child nodes of
> > the reserved_memory node using the flattened devicetree and does the
> > following:
> >
> > 1) If the node represents a statically-placed reserved memory region,
> >    i.e. if it is defined using the "reg" property:
> >    - Call memblock_reserve() or memblock_mark_nomap() as needed.
> >
> > 2) If the node represents a dynamically-placed reserved memory region,
> >    i.e. if it is defined using "alloc-ranges" and "size" properties:
> >    - Call __reserved_mem_alloc_size() which will:
> >      i) Allocate memory for the reserved region and call
> >      memblock_mark_nomap() as needed.
> >      ii) Call the region specific initialization function using
> >      fdt_init_reserved_mem_node().
> >      iii) Save the region information in the reserved_mem array using
> >      fdt_reserved_mem_save_node().
> >
> > Step 2:
> > 1) This stage of the reserved memory processing is now only used to add
> >    the statically-placed reserved memory regions into the reserved_mem
> >    array using fdt_scan_reserved_mem_reg_nodes(), as well as call their
> >    region specific initialization functions.
> >
> > 2) This step has also been moved to be after the page tables are
> >    setup. Moving this will allow us to replace the reserved_mem
> >    array with a dynamically sized array before storing the rest of
> >    these regions.
> >
> > Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> > ---
> >  drivers/of/fdt.c             |   5 +-
> >  drivers/of/of_private.h      |   3 +-
> >  drivers/of/of_reserved_mem.c | 168 ++++++++++++++++++++++++-----------
> >  3 files changed, 122 insertions(+), 54 deletions(-)
>
> this patch got into stable kernel 6.12.13++ as part of Stable-dep-of.
> The stable kernel commit is: 9a0fe62f93ede02c27aaca81112af1e59c8c0979.
>
> With the patch applied I see that the cma area pool is misplaced which
> cause my 4G device to fail to activate the cma pool. Below are some
> logs:
>
> *** Good case (6.12)
>
> root@test:~# dmesg|grep -i cma
> [    0.000000] OF: reserved mem: initialized node linux,cma, compatible i=
d shared-dma-pool
> [    0.000000] OF: reserved mem: 0x0000000044200000..0x00000000541fffff (=
262144 KiB) map reusable linux,cma
> [    0.056915] Memory: 3695024K/4194304K available (15552K kernel code, 2=
510K rwdata, 5992K rodata, 6016K init, 489K bss, 231772K reserved, 262144K =
cma-reserved)
>
> *** Bad (6.12.16)
>
> root@test:~# dmesg|grep -i cma
> [    0.000000] Reserved memory: created CMA memory pool at 0x00000000f200=
0000, size 256 MiB
> [    0.000000] OF: reserved mem: initialized node linux,cma, compatible i=
d shared-dma-pool
> [    0.000000] OF: reserved mem: 0x00000000f2000000..0x0000000101ffffff (=
262144 KiB) map reusable linux,cma

>                 /*
>                  * The CMA area must be in the lower 32-bit address range=
.
>                  */
>                 alloc-ranges =3D <0x0 0x42000000 0 0xc0000000>;

Are you expecting that 0xc0000000 is the end address rather than the
size? Because your range ends at 0x1_0200_0000. Looks to me like the
kernel correctly followed what the DT said was allowed. Why it moved,
I don't know. If you change 0xc0000000 to 0xbe000000, does it work?

Rob

