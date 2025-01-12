Return-Path: <stable+bounces-108325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B685CA0A8CE
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 12:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C864D161C92
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 11:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B6B1AF0BD;
	Sun, 12 Jan 2025 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jCziRxGa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A801ACECA;
	Sun, 12 Jan 2025 11:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736682823; cv=none; b=O3jVByUJ+u0VbwixNYmhwjTQdciVsq0bYUoxlo+EI6IIJWk6lke8lN/5pNF9NGMLd2pPTtaIZgfbkCjaH7PdKUDH3ic1tVvwSWpU9X5GF1n7oJWVW8Jqpg6EAjlyVr7BxXRoEVJAdOI7kKHqQTktXlgDPRdrfGNSaDGT95R8BXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736682823; c=relaxed/simple;
	bh=TR1c65Hv1ZAlN20+wMqF50NT5X4N66oVTcOztbvcE38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RudE/5slEK7dXHfirQjPV5AgI9YZwX321w632fGzKxTgDoMtzTOLEuVxxdi7TMKNULisOvvpbvP1hIhmIUIclHLOd6BeilZ7WDXKm+zniqATmixqASsC3+He0Q39y2qUaTIJSZ2Q+HfrY5BQsZ+Lm5NU5YmxJS+Po/t+N7rm6vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jCziRxGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49732C4CEDF;
	Sun, 12 Jan 2025 11:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736682822;
	bh=TR1c65Hv1ZAlN20+wMqF50NT5X4N66oVTcOztbvcE38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jCziRxGaJkmz1OZBeNxanUZsrAB0FjX978nh1Bya32U64vRYAwIZ0zbdG9Va4Eltt
	 8weyffkrRYrR6jWFkdqq/4kjsUBulRiHvHyX/7lopkJHWjbuLSDe2dwov84r6Qd8oD
	 gKRBnR6mE2EqYRq88c1/hLLyYOwDph7dtwxRgOMg=
Date: Sun, 12 Jan 2025 12:53:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Will Deacon <will@kernel.org>, Steven Price <steven.price@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Baruch Siach <baruch@tkos.co.il>, Petr Tesarik <ptesarik@suse.com>,
	Joey Gouly <joey.gouly@arm.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Baoquan He <bhe@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH stable 5.4] arm64: mm: account for hotplug memory when
 randomizing the linear region
Message-ID: <2025011217-swizzle-unusual-dd7b@gregkh>
References: <20250109165419.1623683-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109165419.1623683-1-florian.fainelli@broadcom.com>

On Thu, Jan 09, 2025 at 08:54:16AM -0800, Florian Fainelli wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> commit 97d6786e0669daa5c2f2d07a057f574e849dfd3e upstream
> 
> As a hardening measure, we currently randomize the placement of
> physical memory inside the linear region when KASLR is in effect.
> Since the random offset at which to place the available physical
> memory inside the linear region is chosen early at boot, it is
> based on the memblock description of memory, which does not cover
> hotplug memory. The consequence of this is that the randomization
> offset may be chosen such that any hotplugged memory located above
> memblock_end_of_DRAM() that appears later is pushed off the end of
> the linear region, where it cannot be accessed.
> 
> So let's limit this randomization of the linear region to ensure
> that this can no longer happen, by using the CPU's addressable PA
> range instead. As it is guaranteed that no hotpluggable memory will
> appear that falls outside of that range, we can safely put this PA
> range sized window anywhere in the linear region.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Link: https://lore.kernel.org/r/20201014081857.3288-1-ardb@kernel.org
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  arch/arm64/mm/init.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index cbcac03c0e0d..a6034645d6f7 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -392,15 +392,18 @@ void __init arm64_memblock_init(void)
>  
>  	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
>  		extern u16 memstart_offset_seed;
> -		u64 range = linear_region_size -
> -			    (memblock_end_of_DRAM() - memblock_start_of_DRAM());
> +		u64 mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
> +		int parange = cpuid_feature_extract_unsigned_field(
> +					mmfr0, ID_AA64MMFR0_PARANGE_SHIFT);
> +		s64 range = linear_region_size -
> +			    BIT(id_aa64mmfr0_parange_to_phys_shift(parange));
>  
>  		/*
>  		 * If the size of the linear region exceeds, by a sufficient
> -		 * margin, the size of the region that the available physical
> -		 * memory spans, randomize the linear region as well.
> +		 * margin, the size of the region that the physical memory can
> +		 * span, randomize the linear region as well.
>  		 */
> -		if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
> +		if (memstart_offset_seed > 0 && range >= (s64)ARM64_MEMSTART_ALIGN) {
>  			range /= ARM64_MEMSTART_ALIGN;
>  			memstart_addr -= ARM64_MEMSTART_ALIGN *
>  					 ((range * memstart_offset_seed) >> 16);
> -- 
> 2.43.0
> 
> 

You are not providing any information as to WHY this is needed in stable
kernels at all.  It just looks like an unsolicted backport with no
changes from upstream, yet no hint as to any bug it fixes.

And you all really have hotpluggable memory on systems that are running
th is old kernel?  Why are they not using newer kernels if they need
this?  Surely lots of other bugs they need are resolved there, right?

thanks,

greg k-h

