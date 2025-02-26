Return-Path: <stable+bounces-119663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE3DA45DD3
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 12:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1253ADF08
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 11:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F66F21CC7D;
	Wed, 26 Feb 2025 11:51:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F0E21D3D3
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570670; cv=none; b=jo9Fu/JAYKQkVQJyJLAWASWyNGhMNB91LSXxK8vp2qEdkK4fRpwkjsYuHYppHOUtB3X5A9oyYDFl4H8Tji3A4caZ8sqfM+kMEy7xg0ITWITvg4hY58gC7VnpVUojrY4iOt4ybaqJd5s3xAA1KHO4LyS0etVnjvt67FWMPuKEAzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570670; c=relaxed/simple;
	bh=Egxyts38uhbzI5cTqjv6hFuVzM23SG1kUUM0YXjMQEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPDnHnnPQV0s7h6UcCo6LruwpYx8bDqSHaSoq69lyGc1ttHwfuum1NBlTnBh1xQVd/UekVPwdXHRqgLeRJ7M5FZtHCP/lWH+69/zmfDuMX3NNOHHlU3mme/eVIvodgPdroui4j0Kv4uMFVhvSVAHWjNmwjKypiAjiwGGL4F0L+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1tnFw7-0001NV-6m; Wed, 26 Feb 2025 12:50:47 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tnFw4-002wSZ-28;
	Wed, 26 Feb 2025 12:50:44 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tnFw4-001Xwx-1i;
	Wed, 26 Feb 2025 12:50:44 +0100
Date: Wed, 26 Feb 2025 12:50:44 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: robh@kernel.org, aisheng.dong@nxp.com, andy@black.fi.intel.com,
	catalin.marinas@arm.com, devicetree@vger.kernel.org, hch@lst.de,
	iommu@lists.linux.dev, kernel@quicinc.com, klarasmodin@gmail.com,
	linux-kernel@vger.kernel.org, m.szyprowski@samsung.com,
	quic_ninanaik@quicinc.com, robin.murphy@arm.com,
	saravanak@google.com, will@kernel.org, stable@vger.kernel.org,
	kernel@pengutronix.de, sashal@kernel.org
Subject: Re: [PATCH v10 1/2] of: reserved_mem: Restruture how the reserved
 memory regions are processed
Message-ID: <20250226115044.zw44p5dxlhy5eoni@pengutronix.de>
References: <20241008220624.551309-1-quic_obabatun@quicinc.com>
 <20241008220624.551309-2-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008220624.551309-2-quic_obabatun@quicinc.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Hi,

On 24-10-08, Oreoluwa Babatunde wrote:
> Reserved memory regions defined in the devicetree can be broken up into
> two groups:
> i) Statically-placed reserved memory regions
> i.e. regions defined with a static start address and size using the
>      "reg" property.
> ii) Dynamically-placed reserved memory regions.
> i.e. regions defined by specifying an address range where they can be
>      placed in memory using the "alloc_ranges" and "size" properties.
> 
> These regions are processed and set aside at boot time.
> This is done in two stages as seen below:
> 
> Stage 1:
> At this stage, fdt_scan_reserved_mem() scans through the child nodes of
> the reserved_memory node using the flattened devicetree and does the
> following:
> 
> 1) If the node represents a statically-placed reserved memory region,
>    i.e. if it is defined using the "reg" property:
>    - Call memblock_reserve() or memblock_mark_nomap() as needed.
>    - Add the information for that region into the reserved_mem array
>      using fdt_reserved_mem_save_node().
>      i.e. fdt_reserved_mem_save_node(node, name, base, size).
> 
> 2) If the node represents a dynamically-placed reserved memory region,
>    i.e. if it is defined using "alloc-ranges" and "size" properties:
>    - Add the information for that region to the reserved_mem array with
>      the starting address and size set to 0.
>      i.e. fdt_reserved_mem_save_node(node, name, 0, 0).
>    Note: This region is saved to the array with a starting address of 0
>    because a starting address is not yet allocated for it.
> 
> Stage 2:
> After iterating through all the reserved memory nodes and storing their
> relevant information in the reserved_mem array,fdt_init_reserved_mem() is
> called and does the following:
> 
> 1) For statically-placed reserved memory regions:
>    - Call the region specific init function using
>      __reserved_mem_init_node().
> 2) For dynamically-placed reserved memory regions:
>    - Call __reserved_mem_alloc_size() which is used to allocate memory
>      for each of these regions, and mark them as nomap if they have the
>      nomap property specified in the DT.
>    - Call the region specific init function.
> 
> The current size of the resvered_mem array is 64 as is defined by
> MAX_RESERVED_REGIONS. This means that there is a limitation of 64 for
> how many reserved memory regions can be specified on a system.
> As systems continue to grow more and more complex, the number of
> reserved memory regions needed are also growing and are starting to hit
> this 64 count limit, hence the need to make the reserved_mem array
> dynamically sized (i.e. dynamically allocating memory for the
> reserved_mem array using membock_alloc_*).
> 
> On architectures such as arm64, memory allocated using memblock is
> writable only after the page tables have been setup. This means that if
> the reserved_mem array is going to be dynamically allocated, it needs to
> happen after the page tables have been setup, not before.
> 
> Since the reserved memory regions are currently being processed and
> added to the array before the page tables are setup, there is a need to
> change the order in which some of the processing is done to allow for
> the reserved_mem array to be dynamically sized.
> 
> It is possible to process the statically-placed reserved memory regions
> without needing to store them in the reserved_mem array until after the
> page tables have been setup because all the information stored in the
> array is readily available in the devicetree and can be referenced at
> any time.
> Dynamically-placed reserved memory regions on the other hand get
> assigned a start address only at runtime, and hence need a place to be
> stored once they are allocated since there is no other referrence to the
> start address for these regions.
> 
> Hence this patch changes the processing order of the reserved memory
> regions in the following ways:
> 
> Step 1:
> fdt_scan_reserved_mem() scans through the child nodes of
> the reserved_memory node using the flattened devicetree and does the
> following:
> 
> 1) If the node represents a statically-placed reserved memory region,
>    i.e. if it is defined using the "reg" property:
>    - Call memblock_reserve() or memblock_mark_nomap() as needed.
> 
> 2) If the node represents a dynamically-placed reserved memory region,
>    i.e. if it is defined using "alloc-ranges" and "size" properties:
>    - Call __reserved_mem_alloc_size() which will:
>      i) Allocate memory for the reserved region and call
>      memblock_mark_nomap() as needed.
>      ii) Call the region specific initialization function using
>      fdt_init_reserved_mem_node().
>      iii) Save the region information in the reserved_mem array using
>      fdt_reserved_mem_save_node().
> 
> Step 2:
> 1) This stage of the reserved memory processing is now only used to add
>    the statically-placed reserved memory regions into the reserved_mem
>    array using fdt_scan_reserved_mem_reg_nodes(), as well as call their
>    region specific initialization functions.
> 
> 2) This step has also been moved to be after the page tables are
>    setup. Moving this will allow us to replace the reserved_mem
>    array with a dynamically sized array before storing the rest of
>    these regions.
> 
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
>  drivers/of/fdt.c             |   5 +-
>  drivers/of/of_private.h      |   3 +-
>  drivers/of/of_reserved_mem.c | 168 ++++++++++++++++++++++++-----------
>  3 files changed, 122 insertions(+), 54 deletions(-)

this patch got into stable kernel 6.12.13++ as part of Stable-dep-of.
The stable kernel commit is: 9a0fe62f93ede02c27aaca81112af1e59c8c0979.

With the patch applied I see that the cma area pool is misplaced which
cause my 4G device to fail to activate the cma pool. Below are some
logs:

*** Good case (6.12)

root@test:~# dmesg|grep -i cma
[    0.000000] OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x0000000044200000..0x00000000541fffff (262144 KiB) map reusable linux,cma
[    0.056915] Memory: 3695024K/4194304K available (15552K kernel code, 2510K rwdata, 5992K rodata, 6016K init, 489K bss, 231772K reserved, 262144K cma-reserved)

*** Bad (6.12.16)

root@test:~# dmesg|grep -i cma
[    0.000000] Reserved memory: created CMA memory pool at 0x00000000f2000000, size 256 MiB
[    0.000000] OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x00000000f2000000..0x0000000101ffffff (262144 KiB) map reusable linux,cma
[    0.056968] Memory: 3694896K/4194304K available (15616K kernel code, 2512K rwdata, 6012K rodata, 6080K init, 491K bss, 231900K reserved, 262144K cma-reserved)
[    0.116920] cma: CMA area linux,cma could not be activated

*** Good (6.12.16, revert 9a0fe62f93ed)

root@test:~# dmesg|grep -i cma
[    0.000000] OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x0000000044200000..0x00000000541fffff (262144 KiB) map reusable linux,cma
[    0.060976] Memory: 3694896K/4194304K available (15616K kernel code, 2512K rwdata, 6012K rodata, 6080K init, 491K bss, 231900K reserved, 262144K cma-reserved)

Below is our reserved-memory dts node:

reserved-memory {
	#address-cells = <2>; 
	#size-cells = <2>; 
	ranges;

	linux,cma {
		compatible = "shared-dma-pool";
		reusable;
		/*
		 * The CMA area must be in the lower 32-bit address range.
		 */
		alloc-ranges = <0x0 0x42000000 0 0xc0000000>;
		size = <0x0 0x10000000>;
		alignment = <0 0x2000>;
		linux,cma-default;
	};

	optee-core@40000000 {
		reg = <0 0x40000000 0 0x1e00000>;
		no-map;
	};

	optee-shm@41e00000 {
		reg = <0 0x41e00000 0 0x200000>;
		no-map;
	};

	m7_reserved: m7@80000000 {
		reg = <0 0x80000000 0 0x1000000>;
		no-map;
	};

	vdev0vring0: vdev0vring0@55000000 {
		reg = <0 0x55000000 0 0x8000>;
		no-map;
	};

	vdev0vring1: vdev0vring1@55008000 {
		reg = <0 0x55008000 0 0x8000>;
		no-map;
	};

	rsc_table: rsc-table@550ff000 {
		reg = <0 0x550ff000 0 0x1000>;
		no-map;
	};

	ram_console_buffer: ram-console-buffer@55100000 {
		reg = <0 0x55100000 0 0x1000>;
		no-map;
	};

	vdev0buffer: vdev0buffer@55400000 {
		compatible = "shared-dma-pool";
		reg = <0 0x55400000 0 0x100000>;
		no-map;
	};
};

My current workaround is to revert commit 9a0fe62f93ed and the
dep-chain: 2d1d620ff27b444 8de4e5a92282. But I would like to get a
proper solution without having revert commits in my downstream
patchstack.

Regards,
  Marco

