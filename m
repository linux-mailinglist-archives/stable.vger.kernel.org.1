Return-Path: <stable+bounces-127509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03200A7A2A2
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 14:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00CA8173730
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 12:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CCF24CEFE;
	Thu,  3 Apr 2025 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrHLCxiA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B311924CEF8;
	Thu,  3 Apr 2025 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743682511; cv=none; b=LLOPwiXvEKtPCVyCyJ1NgY21VVV3CHg3MEEP+MF9s2AcAFUa519uRsYzhVmXuZwzMXvOmnVcV9vlOEMHnDT4yO2UCYdWsTATDzaYNe4aue1w5RkUtsmUP1cXvhfvMp8R71xEE8Zmwg5MgEVXDZDJOA9iA2+Cp6oytdZsVt6TkHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743682511; c=relaxed/simple;
	bh=23ExgsOKUXblOVPYfpCtRZ12RIlo+qDHaQOvltMZl7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+0iJVZWlm8Mhmp5+MjucFl8g5EZ9rt2jAbddzjPfcoFkKXFirmORxWfaCQM3WKyGnBvVbN0DCHP5Zm8EHvrJ1pKxNIm7/kqx89gRM8AbxG/WQMp+NjrJrHk+cbdVBjfJN5sKl98LJvoMSpxX2jzXjwnQQj/uZq0LwpIjBEMMuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrHLCxiA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF9BC4CEE3;
	Thu,  3 Apr 2025 12:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743682511;
	bh=23ExgsOKUXblOVPYfpCtRZ12RIlo+qDHaQOvltMZl7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LrHLCxiAwjQCI0ybe94JIwngEW+zI94NC/ou43BS0+cv+8SmSw4+7Ex8qnriCsSku
	 3tXw7kLy9E0S3Dd1atnFuePV7eHzS0kjqX8wBYDgxZZFrKIcaN7fDXBZrrOwY0CWjb
	 HfH1Esos/2/L3zWHSbx3cQ92OBvNoOx3lBXUlDLeNLFdaEde9m2+ZwUgU4fHFGT91z
	 dyihYLM+npFPyVNOTej23OmRHzrazGv19wVrbD6a8ThyAh5hFr/CBdrcCeH4c6vE0S
	 SRjackvg7LqFuTHEYe3vyZwV3LAZHW7e3nVYmUSYar9hlBTivGH1RaToVJwDKHfboX
	 TWIPJpyYezOCQ==
Date: Thu, 3 Apr 2025 17:41:02 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, 
	Kirill Shutemov <kirill.shutemov@linux.intel.com>, dave.hansen@linux.intel.com, x86@kernel.org, 
	Vishal Annapurve <vannapurve@google.com>, Nikolay Borisov <nik.borisov@suse.com>, stable@vger.kernel.org, 
	linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/ioremap: Maintain consistent IORES_MAP_ENCRYPTED for
 BIOS data
Message-ID: <qkhrxoonvpmp7udbvak4qq6uujjkskzec2kezzfooonndaroxq@5bkl6ly6xslv>
References: <174346288005.2166708.14425674491111625620.stgit@dwillia2-xfh.jf.intel.com>
 <z7h6sepvvrqvmpiccqubganhshcbzzrbvda7dntzufqywei4gz@6clsg5lbvamd>
 <00931e12-4e6a-9ec4-309c-372aaee333b9@amd.com>
 <7cgiqaoeosg3vekjkcm5iorn5djdqbqv3evijgho6tvonzhe2t@jzn56u4ad7v3>
 <67edade5e3e6d_1a6d929450@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67edade5e3e6d_1a6d929450@dwillia2-xfh.jf.intel.com.notmuch>

On Wed, Apr 02, 2025 at 02:36:37PM -0700, Dan Williams wrote:
> Naveen N Rao wrote:
> > On Tue, Apr 01, 2025 at 10:07:18AM -0500, Tom Lendacky wrote:
> > > On 4/1/25 02:57, Kirill Shutemov wrote:
> > > > On Mon, Mar 31, 2025 at 04:14:40PM -0700, Dan Williams wrote:
> > > >> Nikolay reports [1] that accessing BIOS data (first 1MB of the physical
> > > >> address space) via /dev/mem results in an SEPT violation.
> > > >>
> > > >> The cause is ioremap() (via xlate_dev_mem_ptr()) establishing an
> > > >> unencrypted mapping where the kernel had established an encrypted
> > > >> mapping previously.
> > > >>
> > > >> Teach __ioremap_check_other() that this address space shall always be
> > > >> mapped as encrypted as historically it is memory resident data, not MMIO
> > > >> with side-effects.
> > > > 
> > > > I am not sure if all AMD platforms would survive that.
> > > > 
> > > > Tom?
> > > 
> > > I haven't tested this, yet, but with SME the BIOS is not encrypted, so
> > > that would need an unencrypted mapping.
> > > 
> > > Could you qualify your mapping with a TDX check? Or can you do something
> > > in the /dev/mem support to map appropriately?
> > > 
> > > I'm adding @Naveen since he is preparing a patch to prevent /dev/mem
> > > from accessing ROM areas under SNP as those can trigger #VC for a page
> > > that is mapped encrypted but has not been validated. He's looking at
> > > possibly adding something to x86_platform_ops that can be overridden.
> > > The application would get a bad return code vs an exception.
> > 
> > The thought with x86_platform_ops was that TDX may want to differ and 
> > setup separate ranges to deny access to. For SEV-SNP, we primarily want 
> > to disallow the video ROM range at this point. Something like the below.
> > 
> > If this is not something TDX wants, then we should be able to add a 
> > check for SNP in devmem_is_allowed() directly without the 
> > x86_platform_ops.
> 
> So I think there are 2 problems is a range consistently mapped by early
> init code + various ioremap callers, and for encrypted mappings is there
> potential unvalidated access that needs to be prevented outright.
> 
> The theoretical use case I have in mind is that userspace PCI drivers
> have no real reason to be blocked in a confidential VM. Most of the
> validation work to transition MMIO from shared to private is driven by
> userspace anyway so it is unfortunate that after the end of that
> conversion devmem and PCI-sysfs still block mappings.
> 
> However, there is no need to do pre-enabling for a theoretical use case.
> So I am ok if devmem_is_allowed() globally says no for TVMs and then see
> who screams with a practical problem that causes.

That makes sense. I have posted that patch with some changes:
https://lore.kernel.org/all/20250403120228.2344377-1-naveen@kernel.org/T/#u

It should be trivial to add a change for Intel to block the first 1MB 
for TVMs.


Thanks,
Naveen


