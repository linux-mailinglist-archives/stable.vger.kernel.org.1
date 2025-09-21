Return-Path: <stable+bounces-180826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAF4B8E16C
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 19:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738DC1893E4A
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 17:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A6B202987;
	Sun, 21 Sep 2025 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n4QMmSbY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854563FB1B
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758474950; cv=none; b=Scb3QZUx47eE9RSvgy+OAL+9SttbF/QzLYd+P5V5mGxRKKGBlXdYI/xIuys0fZhAU94WCefnrSkKXG2518P5ej/mqDylLrUBc+hODu/DYvDIpZnaWGNrRLP7W9G70F+KS5JZXWusSUBUgmlwcFYGBCsTDLV0NLRyDcG/H2N6w6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758474950; c=relaxed/simple;
	bh=lU/kWUAyJ2/usW1ZBG27EbyCVSJJgAa1FHQmX4Z1lOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdgDobN9Pe4077GGokeg9Hvx332J+kRce8rOPGMu/htmb2Fz1O+xfzQzPneQ4vebFnJXCaqSQjQZ67NZljgUzflb8vAWc+n4XmFIeWMdFPdplO8D8vdxY0aJ2WrEgiqYoGD4SuZOv/uWI1txbdLaCt1xq6PAUoWTYZRaNqCZQTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n4QMmSbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44BCC4CEE7;
	Sun, 21 Sep 2025 17:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758474950;
	bh=lU/kWUAyJ2/usW1ZBG27EbyCVSJJgAa1FHQmX4Z1lOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n4QMmSbYRQBQ8WyOcXXLBC93P2QnybWAZJ/k+MPvwS37W2my27I01nvVqCMtpgrpk
	 dhtPGs6ZlyKlYeH+FvlMCP+nn3ze8/sWTM6wnqVLHL4Cr5luZBNw0YQrJDHBv2q58m
	 JuOlqCCkgNXMSs+uk8z9/saD7MAb+AE5dHrAYyxc=
Date: Sun, 21 Sep 2025 19:15:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Naveen N Rao <naveen@kernel.org>
Subject: Re: [PATCH 6.6.y] x86/cpu/amd: Always try detect_extended_topology()
 on AMD processors
Message-ID: <2025092105-pager-plethora-13be@gregkh>
References: <2025091431-craftily-size-46c6@gregkh>
 <20250915051825.1793-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915051825.1793-1-kprateek.nayak@amd.com>

On Mon, Sep 15, 2025 at 05:18:25AM +0000, K Prateek Nayak wrote:
> commit cba4262a19afae21665ee242b3404bcede5a94d7 upstream.
> 
> Support for parsing the topology on AMD/Hygon processors using CPUID leaf 0xb
> was added in
> 
>   3986a0a805e6 ("x86/CPU/AMD: Derive CPU topology from CPUID function 0xB when available").
> 
> In an effort to keep all the topology parsing bits in one place, this commit
> also introduced a pseudo dependency on the TOPOEXT feature to parse the CPUID
> leaf 0xb.
> 
> The TOPOEXT feature (CPUID 0x80000001 ECX[22]) advertises the support for
> Cache Properties leaf 0x8000001d and the CPUID leaf 0x8000001e EAX for
> "Extended APIC ID" however support for 0xb was introduced alongside the x2APIC
> support not only on AMD [1], but also historically on x86 [2].
> 
> The support for the 0xb leaf is expected to be confirmed by ensuring
> 
>   leaf <= max supported cpuid_level
> 
> and then parsing the level 0 of the leaf to confirm EBX[15:0]
> (LogProcAtThisLevel) is non-zero as stated in the definition of
> "CPUID_Fn0000000B_EAX_x00 [Extended Topology Enumeration]
> (Core::X86::Cpuid::ExtTopEnumEax0)" in Processor Programming Reference (PPR)
> for AMD Family 19h Model 01h Rev B1 Vol1 [3] Sec. 2.1.15.1 "CPUID Instruction
> Functions".
> 
> This has not been a problem on baremetal platforms since support for TOPOEXT
> (Fam 0x15 and later) predates the support for CPUID leaf 0xb (Fam 0x17[Zen2]
> and later), however, for AMD guests on QEMU, the "x2apic" feature can be
> enabled independent of the "topoext" feature where QEMU expects topology and
> the initial APICID to be parsed using the CPUID leaf 0xb (especially when
> number of cores > 255) which is populated independent of the "topoext" feature
> flag.
> 
> Unconditionally call detect_extended_topology() on AMD processors to first
> parse the topology using the extended topology leaf 0xb before using the
> TOPOEXT leaf (0x8000001e).
> 
> Parsing of "DIE_TYPE" in detect_extended_topology() is specific to CPUID
> leaf 0x1f which is only supported on Intel platforms. Continue using the
> TOPOEXT leaf (0x8000001e) to derive the "cpu_die_id" on AMD platforms.
> 
>   [ prateek: Adapted the fix from the original commit to stable kernel
>     which doesn't contain the x86 topology rewrite, renamed
>     cpu_parse_topology_ext() with the erstwhile
>     detect_extended_topology() function in commit message, dropped
>     references to extended topology leaf 0x80000026 which the stable
>     kernels aren't aware of, make a note of "cpu_die_id" parsing
>     nuances in detect_extended_topology() and why AMD processors should
>     still rely on TOPOEXT leaf for "cpu_die_id". ]

That's a lot of changes.  Why not just use a newer kernel for this new
hardware?  Why backport this in such a different way?  That is going to
cause other changes in the future to be harder to backport in the
future.

What's driving the requirement to run new hardware on old kernels?

thanks,

greg k-h

