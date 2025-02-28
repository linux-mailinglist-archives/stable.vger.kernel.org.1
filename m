Return-Path: <stable+bounces-119961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D62CCA49E6E
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 17:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A2D1885C76
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 16:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08CE274253;
	Fri, 28 Feb 2025 16:13:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64095274249
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759202; cv=none; b=azZqrgEMtjglr1uwoQ59ny4I8trpvmpblS4aJEXY51jimEF2IegG4JRwzue8c9vVfEzm3z5t2se/4QvET+RJaT3Wxb6GV0kwcT/dVP9r75m0/bZu2le3JLHAdc/senBquP3GpG8sty66jxOwsxYVqodggrgxIvW2eWNgrC0JXf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759202; c=relaxed/simple;
	bh=OricpVIncJC0ieP9+duPGCaBtyVw/RdQoIOpd5NTvwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnUol+prgvj4ps5tNEDDBOa6PYCqVe2wNhSNmyu/YoIwr1HI99Xs8N98B1H+7nE+6FPV2EI8ub63U8nxC0cZvjLWvLPNXoUWrEaXO/AZuefIloZVXkN7n6w6e5W/Gu/ACI51a96a3Bxy8wbfkcLIxnBQs55vNUdFKBEktEgIXJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1to2yu-000117-VL; Fri, 28 Feb 2025 17:12:56 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1to2yr-003KBR-04;
	Fri, 28 Feb 2025 17:12:53 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1to2yq-005N7q-2s;
	Fri, 28 Feb 2025 17:12:52 +0100
Date: Fri, 28 Feb 2025 17:12:52 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Rob Herring <robh@kernel.org>
Cc: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, aisheng.dong@nxp.com,
	andy@black.fi.intel.com, catalin.marinas@arm.com,
	devicetree@vger.kernel.org, hch@lst.de, iommu@lists.linux.dev,
	kernel@quicinc.com, klarasmodin@gmail.com,
	linux-kernel@vger.kernel.org, m.szyprowski@samsung.com,
	quic_ninanaik@quicinc.com, robin.murphy@arm.com,
	saravanak@google.com, will@kernel.org, stable@vger.kernel.org,
	kernel@pengutronix.de, sashal@kernel.org
Subject: Re: [PATCH v10 1/2] of: reserved_mem: Restruture how the reserved
 memory regions are processed
Message-ID: <20250228161252.jbo5lp5iuvrpqi57@pengutronix.de>
References: <20241008220624.551309-1-quic_obabatun@quicinc.com>
 <20241008220624.551309-2-quic_obabatun@quicinc.com>
 <20250226115044.zw44p5dxlhy5eoni@pengutronix.de>
 <CAL_JsqKvRQdbBOsz4_mWAJ+MDcM+6hdhgyT6hd22z7Oi9bGAkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKvRQdbBOsz4_mWAJ+MDcM+6hdhgyT6hd22z7Oi9bGAkA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

On 25-02-28, Rob Herring wrote:
> On Wed, Feb 26, 2025 at 5:51 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
> >
> > Hi,
> >
> > On 24-10-08, Oreoluwa Babatunde wrote:
> > > Reserved memory regions defined in the devicetree can be broken up into
> > > two groups:
> > > i) Statically-placed reserved memory regions
> > > i.e. regions defined with a static start address and size using the
> > >      "reg" property.
> > > ii) Dynamically-placed reserved memory regions.
> > > i.e. regions defined by specifying an address range where they can be
> > >      placed in memory using the "alloc_ranges" and "size" properties.
> > >
> > > These regions are processed and set aside at boot time.
> > > This is done in two stages as seen below:
> > >
> > > Stage 1:
> > > At this stage, fdt_scan_reserved_mem() scans through the child nodes of
> > > the reserved_memory node using the flattened devicetree and does the
> > > following:
> > >
> > > 1) If the node represents a statically-placed reserved memory region,
> > >    i.e. if it is defined using the "reg" property:
> > >    - Call memblock_reserve() or memblock_mark_nomap() as needed.
> > >    - Add the information for that region into the reserved_mem array
> > >      using fdt_reserved_mem_save_node().
> > >      i.e. fdt_reserved_mem_save_node(node, name, base, size).
> > >
> > > 2) If the node represents a dynamically-placed reserved memory region,
> > >    i.e. if it is defined using "alloc-ranges" and "size" properties:
> > >    - Add the information for that region to the reserved_mem array with
> > >      the starting address and size set to 0.
> > >      i.e. fdt_reserved_mem_save_node(node, name, 0, 0).
> > >    Note: This region is saved to the array with a starting address of 0
> > >    because a starting address is not yet allocated for it.
> > >
> > > Stage 2:
> > > After iterating through all the reserved memory nodes and storing their
> > > relevant information in the reserved_mem array,fdt_init_reserved_mem() is
> > > called and does the following:
> > >
> > > 1) For statically-placed reserved memory regions:
> > >    - Call the region specific init function using
> > >      __reserved_mem_init_node().
> > > 2) For dynamically-placed reserved memory regions:
> > >    - Call __reserved_mem_alloc_size() which is used to allocate memory
> > >      for each of these regions, and mark them as nomap if they have the
> > >      nomap property specified in the DT.
> > >    - Call the region specific init function.
> > >
> > > The current size of the resvered_mem array is 64 as is defined by
> > > MAX_RESERVED_REGIONS. This means that there is a limitation of 64 for
> > > how many reserved memory regions can be specified on a system.
> > > As systems continue to grow more and more complex, the number of
> > > reserved memory regions needed are also growing and are starting to hit
> > > this 64 count limit, hence the need to make the reserved_mem array
> > > dynamically sized (i.e. dynamically allocating memory for the
> > > reserved_mem array using membock_alloc_*).
> > >
> > > On architectures such as arm64, memory allocated using memblock is
> > > writable only after the page tables have been setup. This means that if
> > > the reserved_mem array is going to be dynamically allocated, it needs to
> > > happen after the page tables have been setup, not before.
> > >
> > > Since the reserved memory regions are currently being processed and
> > > added to the array before the page tables are setup, there is a need to
> > > change the order in which some of the processing is done to allow for
> > > the reserved_mem array to be dynamically sized.
> > >
> > > It is possible to process the statically-placed reserved memory regions
> > > without needing to store them in the reserved_mem array until after the
> > > page tables have been setup because all the information stored in the
> > > array is readily available in the devicetree and can be referenced at
> > > any time.
> > > Dynamically-placed reserved memory regions on the other hand get
> > > assigned a start address only at runtime, and hence need a place to be
> > > stored once they are allocated since there is no other referrence to the
> > > start address for these regions.
> > >
> > > Hence this patch changes the processing order of the reserved memory
> > > regions in the following ways:
> > >
> > > Step 1:
> > > fdt_scan_reserved_mem() scans through the child nodes of
> > > the reserved_memory node using the flattened devicetree and does the
> > > following:
> > >
> > > 1) If the node represents a statically-placed reserved memory region,
> > >    i.e. if it is defined using the "reg" property:
> > >    - Call memblock_reserve() or memblock_mark_nomap() as needed.
> > >
> > > 2) If the node represents a dynamically-placed reserved memory region,
> > >    i.e. if it is defined using "alloc-ranges" and "size" properties:
> > >    - Call __reserved_mem_alloc_size() which will:
> > >      i) Allocate memory for the reserved region and call
> > >      memblock_mark_nomap() as needed.
> > >      ii) Call the region specific initialization function using
> > >      fdt_init_reserved_mem_node().
> > >      iii) Save the region information in the reserved_mem array using
> > >      fdt_reserved_mem_save_node().
> > >
> > > Step 2:
> > > 1) This stage of the reserved memory processing is now only used to add
> > >    the statically-placed reserved memory regions into the reserved_mem
> > >    array using fdt_scan_reserved_mem_reg_nodes(), as well as call their
> > >    region specific initialization functions.
> > >
> > > 2) This step has also been moved to be after the page tables are
> > >    setup. Moving this will allow us to replace the reserved_mem
> > >    array with a dynamically sized array before storing the rest of
> > >    these regions.
> > >
> > > Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> > > ---
> > >  drivers/of/fdt.c             |   5 +-
> > >  drivers/of/of_private.h      |   3 +-
> > >  drivers/of/of_reserved_mem.c | 168 ++++++++++++++++++++++++-----------
> > >  3 files changed, 122 insertions(+), 54 deletions(-)
> >
> > this patch got into stable kernel 6.12.13++ as part of Stable-dep-of.
> > The stable kernel commit is: 9a0fe62f93ede02c27aaca81112af1e59c8c0979.
> >
> > With the patch applied I see that the cma area pool is misplaced which
> > cause my 4G device to fail to activate the cma pool. Below are some
> > logs:
> >
> > *** Good case (6.12)
> >
> > root@test:~# dmesg|grep -i cma
> > [    0.000000] OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
> > [    0.000000] OF: reserved mem: 0x0000000044200000..0x00000000541fffff (262144 KiB) map reusable linux,cma
> > [    0.056915] Memory: 3695024K/4194304K available (15552K kernel code, 2510K rwdata, 5992K rodata, 6016K init, 489K bss, 231772K reserved, 262144K cma-reserved)
> >
> > *** Bad (6.12.16)
> >
> > root@test:~# dmesg|grep -i cma
> > [    0.000000] Reserved memory: created CMA memory pool at 0x00000000f2000000, size 256 MiB
> > [    0.000000] OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
> > [    0.000000] OF: reserved mem: 0x00000000f2000000..0x0000000101ffffff (262144 KiB) map reusable linux,cma
> 
> >                 /*
> >                  * The CMA area must be in the lower 32-bit address range.
> >                  */
> >                 alloc-ranges = <0x0 0x42000000 0 0xc0000000>;
> 
> Are you expecting that 0xc0000000 is the end address rather than the
> size? Because your range ends at 0x1_0200_0000. Looks to me like the
> kernel correctly followed what the DT said was allowed. Why it moved,
> I don't know. If you change 0xc0000000 to 0xbe000000, does it work?

Argh.. you're absolutely right, we had the wrong size specified and
didn't noticed it till the kernel update :/ I don't know why I didn't
noticed this earlier.

With the length/size set to 0xbe000000, the cma is now allocated
correctly:

root@test:~# dmesg|grep cma
[    0.000000] OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x00000000f0000000..0x00000000ffffffff (262144 KiB) map reusable linux,cma
[    0.060910] Memory: 3694896K/4194304K available (15616K kernel code, 2512K rwdata, 6016K rodata, 6080K init, 491K bss, 231900K reserved, 262144K cma-reserved)

As you said the the placing was changed too, not sure why but that's
okay. To be honest, placing it at the end and not somewhere in between
sounds far more reasonable to me.

Thanks for the support,
Marco

