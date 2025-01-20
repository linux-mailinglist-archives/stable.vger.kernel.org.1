Return-Path: <stable+bounces-109537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C3CA16DF4
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 15:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECA227A063C
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 14:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFC11E3760;
	Mon, 20 Jan 2025 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2MLcyzMY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B400A1E32BB;
	Mon, 20 Jan 2025 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737381587; cv=none; b=SF10fUd/r+/81w6nLfSvB5ETyDt5MndsSY1v4KBo9DpjeaKlAHC0xKt78b9FGTKltfJUUfmM2Uh93jmr84Tcp5K7/3SHNjDNi/gatEnFpBN/yBpE4ojS7lmO7QOSYQGwUkeyBiEiytJl2OUnfcfTAWWApvinZnFFX3QOiZgvY/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737381587; c=relaxed/simple;
	bh=a6/AeNn2g3zqwiTDXTEbJ7QC16P6u39284X4lAoEtog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyU5ohAW4buChMVKB+YUK5MxSfxD1YsKfiTK8XAyixoomTtdr8QZRiswSjaHRt2E+QHirM+YWMsHzmfPm6Da9DAywer8kP9k9WuiwaPvlNSPhvxnECVF0bRry0YhSf/giLFGdyh1ucA2yuHpAlA9JckVjALH7b37Tgt9UU2Vo8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2MLcyzMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A087EC4CEDD;
	Mon, 20 Jan 2025 13:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737381587;
	bh=a6/AeNn2g3zqwiTDXTEbJ7QC16P6u39284X4lAoEtog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2MLcyzMYI9JONm6c1Gur2116gUNJAsgCEiKKY84RpZP6gkBZb11gm9p9UXYtX/s7c
	 P9HCGU5kwWBjRYSrlmEIAQaMiccLo16sVEch//3ABkEC8U/Km4QE3aNgrTb1KVxLeJ
	 xSfZLdVjtGpqPO+/0HhTEgNcSppIjvAsQ3LAPrxU=
Date: Mon, 20 Jan 2025 14:59:44 +0100
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
Message-ID: <2025012002-tactics-murky-aaab@gregkh>
References: <20250109165419.1623683-1-florian.fainelli@broadcom.com>
 <20250109165419.1623683-2-florian.fainelli@broadcom.com>
 <62786457-d4a1-4861-8bec-7e478626f4db@broadcom.com>
 <2025011247-enable-freezing-ffa2@gregkh>
 <27bbea11-61fa-4f41-8b39-8508f2d2e385@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27bbea11-61fa-4f41-8b39-8508f2d2e385@broadcom.com>

On Mon, Jan 13, 2025 at 07:44:50AM -0800, Florian Fainelli wrote:
> 
> 
> On 1/12/2025 3:54 AM, Greg KH wrote:
> > On Thu, Jan 09, 2025 at 09:01:13AM -0800, Florian Fainelli wrote:
> > > On 1/9/25 08:54, Florian Fainelli wrote:
> > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > > 
> > > > commit 97d6786e0669daa5c2f2d07a057f574e849dfd3e upstream
> > > > 
> > > > As a hardening measure, we currently randomize the placement of
> > > > physical memory inside the linear region when KASLR is in effect.
> > > > Since the random offset at which to place the available physical
> > > > memory inside the linear region is chosen early at boot, it is
> > > > based on the memblock description of memory, which does not cover
> > > > hotplug memory. The consequence of this is that the randomization
> > > > offset may be chosen such that any hotplugged memory located above
> > > > memblock_end_of_DRAM() that appears later is pushed off the end of
> > > > the linear region, where it cannot be accessed.
> > > > 
> > > > So let's limit this randomization of the linear region to ensure
> > > > that this can no longer happen, by using the CPU's addressable PA
> > > > range instead. As it is guaranteed that no hotpluggable memory will
> > > > appear that falls outside of that range, we can safely put this PA
> > > > range sized window anywhere in the linear region.
> > > > 
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > Cc: Steven Price <steven.price@arm.com>
> > > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > > Link: https://lore.kernel.org/r/20201014081857.3288-1-ardb@kernel.org
> > > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > > Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > > 
> > > Forgot to update the patch subject, but this one is for 5.10.
> > 
> > You also forgot to tell us _why_ this is needed :(
> 
> This is explained in the second part of the first paragraph:
> 
> The consequence of this is that the randomization offset may be chosen such
> that any hotplugged memory located above memblock_end_of_DRAM() that appears
> later is pushed off the end of the linear region, where it cannot be
> accessed.
> 
> We use both memory hotplug and KASLR on our systems and that's how we
> eventually found out about the bug.

And you still have 5.10.y ARM64 systems that need this?  Why not move to
a newer kernel version already?

Anyway, I need an ack from the ARM64 maintainers that this is ok to
apply here before I can take it.

thanks,

greg k-h

