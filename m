Return-Path: <stable+bounces-111099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A92A219C9
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 10:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8373A5234
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 09:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CB21A0714;
	Wed, 29 Jan 2025 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uZMFdC3N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186A019D072;
	Wed, 29 Jan 2025 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738142331; cv=none; b=TUWBP5b7LsjFLR0jEELprZ1DitJSVNtEeI9s6U5Dy8K8VJf/6qS+WQT8NuIiyAGIY7OPXNESlBxTZfzEoyvjd7bNRwZs/ZvLRQW8zVoTwX+wqcIctNcFDGlOQna4aOUJfhWjpwt4Bq/X0gEkt1T/jjZBB475vLDfAPYyoN1exBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738142331; c=relaxed/simple;
	bh=ylFtjY1uRHckE3DQwK4zxg8tdjAce036+ERZbbMF4J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUEl3YA9wkwmoBhYTjBoYCeI2Gg1uqNMcFGPed+wnRZCuHU323KJkEINWdXqGOdxCuiOg1lZCxmybag9HOJQDIqpxxQN7HNJShrYkzUyF9oQBEWoRbNL7XdOnf7r93rEsFRub7CH7LDObvq8XLzRMCMgN513E6uppZoVyQI1ykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uZMFdC3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B290AC4CED3;
	Wed, 29 Jan 2025 09:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738142330;
	bh=ylFtjY1uRHckE3DQwK4zxg8tdjAce036+ERZbbMF4J4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uZMFdC3NATWPzu7IsHqeuI3zzskdWYMru1c96EzX4lVTILNUfHTGiHCLF359awXN5
	 CTOppbak81D0JHK1EwjkxM099l/SaTYZCGqVl8+/YpbrezzoAHO6I2fYvYadAJ3BD1
	 DLemGS7GZTcHkXcJ9eIiWgzdLpLuQSodCd2STRlk=
Date: Wed, 29 Jan 2025 10:17:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Will Deacon <will@kernel.org>, Steven Price <steven.price@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Baruch Siach <baruch@tkos.co.il>, Petr Tesarik <ptesarik@suse.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: mm: account for hotplug memory when randomizing
 the linear region
Message-ID: <2025012938-abreast-explain-f5f7@gregkh>
References: <20250109165419.1623683-1-florian.fainelli@broadcom.com>
 <20250109165419.1623683-2-florian.fainelli@broadcom.com>
 <62786457-d4a1-4861-8bec-7e478626f4db@broadcom.com>
 <2025011247-enable-freezing-ffa2@gregkh>
 <27bbea11-61fa-4f41-8b39-8508f2d2e385@broadcom.com>
 <2025012002-tactics-murky-aaab@gregkh>
 <41550c7f-1313-41b4-aa2e-cb4809ad68c2@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41550c7f-1313-41b4-aa2e-cb4809ad68c2@broadcom.com>

On Mon, Jan 20, 2025 at 08:33:12AM -0800, Florian Fainelli wrote:
> 
> 
> On 1/20/2025 5:59 AM, Greg KH wrote:
> > On Mon, Jan 13, 2025 at 07:44:50AM -0800, Florian Fainelli wrote:
> > > 
> > > 
> > > On 1/12/2025 3:54 AM, Greg KH wrote:
> > > > On Thu, Jan 09, 2025 at 09:01:13AM -0800, Florian Fainelli wrote:
> > > > > On 1/9/25 08:54, Florian Fainelli wrote:
> > > > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > > > > 
> > > > > > commit 97d6786e0669daa5c2f2d07a057f574e849dfd3e upstream
> > > > > > 
> > > > > > As a hardening measure, we currently randomize the placement of
> > > > > > physical memory inside the linear region when KASLR is in effect.
> > > > > > Since the random offset at which to place the available physical
> > > > > > memory inside the linear region is chosen early at boot, it is
> > > > > > based on the memblock description of memory, which does not cover
> > > > > > hotplug memory. The consequence of this is that the randomization
> > > > > > offset may be chosen such that any hotplugged memory located above
> > > > > > memblock_end_of_DRAM() that appears later is pushed off the end of
> > > > > > the linear region, where it cannot be accessed.
> > > > > > 
> > > > > > So let's limit this randomization of the linear region to ensure
> > > > > > that this can no longer happen, by using the CPU's addressable PA
> > > > > > range instead. As it is guaranteed that no hotpluggable memory will
> > > > > > appear that falls outside of that range, we can safely put this PA
> > > > > > range sized window anywhere in the linear region.
> > > > > > 
> > > > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > > > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > > > > > Cc: Will Deacon <will@kernel.org>
> > > > > > Cc: Steven Price <steven.price@arm.com>
> > > > > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > > > > Link: https://lore.kernel.org/r/20201014081857.3288-1-ardb@kernel.org
> > > > > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > > > > Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > > > > 
> > > > > Forgot to update the patch subject, but this one is for 5.10.
> > > > 
> > > > You also forgot to tell us _why_ this is needed :(
> > > 
> > > This is explained in the second part of the first paragraph:
> > > 
> > > The consequence of this is that the randomization offset may be chosen such
> > > that any hotplugged memory located above memblock_end_of_DRAM() that appears
> > > later is pushed off the end of the linear region, where it cannot be
> > > accessed.
> > > 
> > > We use both memory hotplug and KASLR on our systems and that's how we
> > > eventually found out about the bug.
> > 
> > And you still have 5.10.y ARM64 systems that need this?  Why not move to
> > a newer kernel version already?
> 
> We still have ARM64 systems running 5.4 that need this, and the same bug
> applies to 5.10 that we used to support but dropped in favor of 5.15/6.1.
> Those are the kernel versions used by Android, and Android TV in particular,
> so it's kind of the way it goes for us.
> 
> > 
> > Anyway, I need an ack from the ARM64 maintainers that this is ok to
> > apply here before I can take it.
> 
> Just out of curiosity, the change is pretty innocuous and simple to review,
> why the extra scrutiny needed here?

Why shouldn't the maintainers review a proposed backport patch for core
kernel code that affects everyone who uses that arch?

thanks,

greg k-h

