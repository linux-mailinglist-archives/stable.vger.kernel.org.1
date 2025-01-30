Return-Path: <stable+bounces-111256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C35A22948
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 08:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 896797A2ADB
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 07:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307631A4F21;
	Thu, 30 Jan 2025 07:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ws446NIH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8387C2FB;
	Thu, 30 Jan 2025 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738222993; cv=none; b=dF4DNMHi/YIeANwxZz2JYGqXkUtUp/Sy7ZLeKyu7/sMQvf+A0bd8l6KZEt9sM35Oi/PvUqMXyktMUMUWiLQJ2FYreyakR+GmdyLYqNcG6yc6uJTW4vYjfCsYnpFUnxKCJ1E1HnDsNSgQ40YHcjpF5ijNFy8pG5nc0XJGVEqghds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738222993; c=relaxed/simple;
	bh=5J6jJrnq3XsDB9NlG9FzYa+g3HytaqGWsBfOymeBtSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghYIqc8gRvUuFbBcOgKwC9NW8Ngu/kUt8FvotR1B1fpcwxEGgfbWGCPLMOwTm0HbG6PsKLiDcrFWomzVrf2/dzBr9mNCSikdBAcG9Cuk0vdrX9UODZXhJqqL5bR0DngsStoeapeI24DkCkHTVW4cHDuZkZTFM9VtEfL8pKVXhOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ws446NIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02EDC4CED2;
	Thu, 30 Jan 2025 07:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738222992;
	bh=5J6jJrnq3XsDB9NlG9FzYa+g3HytaqGWsBfOymeBtSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ws446NIHaDfG++kFb3Hc1OTu4MRk+Xgff+axwOLG92mI95W8tFEsPOgivVlLiEZnS
	 6EuOM6xPO+whBvojZBC5W1SUPE9JmW/HWGfrvBh8KQMVUlNOCvKl1fQQ8g2QaxJZyo
	 6WbfqYS3nqfBA/ENbcd64t6hrzkpd2q1FsZtJXUI=
Date: Thu, 30 Jan 2025 08:43:09 +0100
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
Message-ID: <2025013002-discuss-twine-36b1@gregkh>
References: <20250109165419.1623683-1-florian.fainelli@broadcom.com>
 <2025011217-swizzle-unusual-dd7b@gregkh>
 <213f28ff-2034-467e-8269-58b6e6f578df@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <213f28ff-2034-467e-8269-58b6e6f578df@broadcom.com>

On Wed, Jan 29, 2025 at 10:05:29AM -0800, Florian Fainelli wrote:
> On 1/12/25 03:53, Greg KH wrote:
> > On Thu, Jan 09, 2025 at 08:54:16AM -0800, Florian Fainelli wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > > 
> > > commit 97d6786e0669daa5c2f2d07a057f574e849dfd3e upstream
> > > 
> > > As a hardening measure, we currently randomize the placement of
> > > physical memory inside the linear region when KASLR is in effect.
> > > Since the random offset at which to place the available physical
> > > memory inside the linear region is chosen early at boot, it is
> > > based on the memblock description of memory, which does not cover
> > > hotplug memory. The consequence of this is that the randomization
> > > offset may be chosen such that any hotplugged memory located above
> > > memblock_end_of_DRAM() that appears later is pushed off the end of
> > > the linear region, where it cannot be accessed.
> > > 
> > > So let's limit this randomization of the linear region to ensure
> > > that this can no longer happen, by using the CPU's addressable PA
> > > range instead. As it is guaranteed that no hotpluggable memory will
> > > appear that falls outside of that range, we can safely put this PA
> > > range sized window anywhere in the linear region.
> > > 
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Steven Price <steven.price@arm.com>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Link: https://lore.kernel.org/r/20201014081857.3288-1-ardb@kernel.org
> > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > > ---
> > >   arch/arm64/mm/init.c | 13 ++++++++-----
> > >   1 file changed, 8 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > > index cbcac03c0e0d..a6034645d6f7 100644
> > > --- a/arch/arm64/mm/init.c
> > > +++ b/arch/arm64/mm/init.c
> > > @@ -392,15 +392,18 @@ void __init arm64_memblock_init(void)
> > >   	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
> > >   		extern u16 memstart_offset_seed;
> > > -		u64 range = linear_region_size -
> > > -			    (memblock_end_of_DRAM() - memblock_start_of_DRAM());
> > > +		u64 mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
> > > +		int parange = cpuid_feature_extract_unsigned_field(
> > > +					mmfr0, ID_AA64MMFR0_PARANGE_SHIFT);
> > > +		s64 range = linear_region_size -
> > > +			    BIT(id_aa64mmfr0_parange_to_phys_shift(parange));
> > >   		/*
> > >   		 * If the size of the linear region exceeds, by a sufficient
> > > -		 * margin, the size of the region that the available physical
> > > -		 * memory spans, randomize the linear region as well.
> > > +		 * margin, the size of the region that the physical memory can
> > > +		 * span, randomize the linear region as well.
> > >   		 */
> > > -		if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
> > > +		if (memstart_offset_seed > 0 && range >= (s64)ARM64_MEMSTART_ALIGN) {
> > >   			range /= ARM64_MEMSTART_ALIGN;
> > >   			memstart_addr -= ARM64_MEMSTART_ALIGN *
> > >   					 ((range * memstart_offset_seed) >> 16);
> > > -- 
> > > 2.43.0
> > > 
> > > 
> > 
> > You are not providing any information as to WHY this is needed in stable
> > kernels at all.  It just looks like an unsolicted backport with no
> > changes from upstream, yet no hint as to any bug it fixes.
> 
> See the response in the other thread.
> 
> > 
> > And you all really have hotpluggable memory on systems that are running
> > th is old kernel?  Why are they not using newer kernels if they need
> > this?  Surely lots of other bugs they need are resolved there, right?
> 
> Believe it or not, but memory hotplug works really well for us, in a
> somewhat limited configuration on the 5.4 kernel whereby we simply plug
> memory, and never unplug it thereafter, but still, we have not had to carry
> hotplug related patches other than this one.
> 
> Trying to be a good citizen here: one of my colleague has identified an
> upstream fix that works, that we got tested, cherry picked cleanly into both
> 5.4 and 5.10, so it's not even like there was any fuzz.
> 
> I was sort of hoping that giving my history of regularly testing stable
> kernels for the past years, as well as submitting a fair amount of targeted
> bug fixes to the stable branches that there would be some level of trust
> here.

Of course your history matters here, I'm not trying to disuade that at
all.  All I am saying is "this touches core arm64 code, so I would like
an arm64 maintainer to at least glance at it to say it's ok to do this."

And it looks like it now has happened, and it is good that I asked :)

This is all normal, and good, I'm not singling you out here at all.  We
push back on backports all the time when we don't understand why they
are being asked for and ask for a second review.  You want us to do this
in order to keep these trees working well.

thanks,

greg k-h

