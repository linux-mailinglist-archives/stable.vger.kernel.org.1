Return-Path: <stable+bounces-108326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96601A0A8D0
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 12:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1051672A0
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 11:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082981AF0BA;
	Sun, 12 Jan 2025 11:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X10MBEIy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B471AA1C0;
	Sun, 12 Jan 2025 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736682846; cv=none; b=WHsK4NGBW7bF62yLw9UhN4Jbtr4s8zoSEtjby1p3ZkyDk9zF2J2+N4ZGMH7pn6rvEnn+DkmFPsjiQhzl59O23lqfGuBiks/ZV6mZtZVEg2yFim2Iv5aQSBK6j9GI8bMaJqEVH4SdglzJQNxSAdjNI+8AGjuUGfSKNWEQp7Tj6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736682846; c=relaxed/simple;
	bh=k9CUYWfksPToLLELTTvrBkhNkzM6VlpA7t8yoRYCU6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTwU8KmVwHV4ZlaivnfZO9AZp27MD0/5+LmnHwZ41UEJprZXzIlJuShnn0kODHd1oda+87qI0I76kwlomxh0GOx7Y0KsuSAcPpLTF1Q1rRDJI0tVEiCPE2rn2KH/+VfA5QAtzT35V5VXFjIPPnG6ocls/keLmRYOkjhb5Ov8t/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X10MBEIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13B8C4CEDF;
	Sun, 12 Jan 2025 11:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736682846;
	bh=k9CUYWfksPToLLELTTvrBkhNkzM6VlpA7t8yoRYCU6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X10MBEIyhoPuClKxHrwevxo6PbuR0AuZt/CWbNasgn/OF+CGu716enYtbB1AadHPR
	 n84wL4ThACtPdQNsMH66UqqS1WWRpKesoaiiGZ78N9i0TYoml3H5NveXSJaDH+d8xp
	 dBeRJKE/iI38ZeNfWZZ07y6F+PxZgiQUdgrlMMI0=
Date: Sun, 12 Jan 2025 12:54:03 +0100
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
Message-ID: <2025011247-enable-freezing-ffa2@gregkh>
References: <20250109165419.1623683-1-florian.fainelli@broadcom.com>
 <20250109165419.1623683-2-florian.fainelli@broadcom.com>
 <62786457-d4a1-4861-8bec-7e478626f4db@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62786457-d4a1-4861-8bec-7e478626f4db@broadcom.com>

On Thu, Jan 09, 2025 at 09:01:13AM -0800, Florian Fainelli wrote:
> On 1/9/25 08:54, Florian Fainelli wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> > 
> > commit 97d6786e0669daa5c2f2d07a057f574e849dfd3e upstream
> > 
> > As a hardening measure, we currently randomize the placement of
> > physical memory inside the linear region when KASLR is in effect.
> > Since the random offset at which to place the available physical
> > memory inside the linear region is chosen early at boot, it is
> > based on the memblock description of memory, which does not cover
> > hotplug memory. The consequence of this is that the randomization
> > offset may be chosen such that any hotplugged memory located above
> > memblock_end_of_DRAM() that appears later is pushed off the end of
> > the linear region, where it cannot be accessed.
> > 
> > So let's limit this randomization of the linear region to ensure
> > that this can no longer happen, by using the CPU's addressable PA
> > range instead. As it is guaranteed that no hotpluggable memory will
> > appear that falls outside of that range, we can safely put this PA
> > range sized window anywhere in the linear region.
> > 
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Steven Price <steven.price@arm.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Link: https://lore.kernel.org/r/20201014081857.3288-1-ardb@kernel.org
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> Forgot to update the patch subject, but this one is for 5.10.

You also forgot to tell us _why_ this is needed :(

thanks,

greg k-h

