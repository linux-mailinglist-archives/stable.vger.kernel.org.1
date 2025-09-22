Return-Path: <stable+bounces-180944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00DEB91112
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 14:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F2616B337
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 12:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329592F0C50;
	Mon, 22 Sep 2025 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="auqXFbyZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C462823E32D
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758542923; cv=none; b=YOMpDyWzfEPYTac/kCrcmYrzZKU2dVN0RPMnL4qqF2zDkB7En4CqyeDSXO8GpvmSnqwUjSoR8EXf3yhlR87h8iniDF7y/01F6/qdu/oZzbhqXz8EpGvGyiZ0M3E4Ou8rnS4mtBNHJHYGYANqk2RnIH9OoSevyg+D5VcoqNc8ke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758542923; c=relaxed/simple;
	bh=wrcZ3/91ymNiun9mweuuCT67E9YXfxXGCO2YOHlNKvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVCRHYyxyy44+DAj/oboaIYITOq7KNWBLscv11CuDIbzW0ZW1LjlbukkmPDmMej6qBFKrGPuhxeMyaM3An82odx3/SQdd7qYS6rAnCVzMXe87vE5tG2Wp11+hz9bWdH8QubYZna2v2wBEhJRTJEtgginvFMN5MaO92Gkau1TsEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=auqXFbyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7101BC4CEF0;
	Mon, 22 Sep 2025 12:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758542923;
	bh=wrcZ3/91ymNiun9mweuuCT67E9YXfxXGCO2YOHlNKvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=auqXFbyZeRGUov9mzy14HBDkiOqTIRjfehyKgjMn6cqT5t50E+/tAx4i6PA64SQ/k
	 ub0WRz5qonHAx48NkX8iXnCABGCFALFZW+wk3SZIZLppWill8TbEykyJntZfsCSTd2
	 55pVOx+KF/PA2LhEnffR+kB3alD9PeVsB28YWFIU=
Date: Mon, 22 Sep 2025 14:08:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Naveen N Rao <naveen@kernel.org>
Subject: Re: [PATCH 6.6.y] x86/cpu/amd: Always try detect_extended_topology()
 on AMD processors
Message-ID: <2025092251-depravity-encircle-9daa@gregkh>
References: <2025091431-craftily-size-46c6@gregkh>
 <20250915051825.1793-1-kprateek.nayak@amd.com>
 <2025092105-pager-plethora-13be@gregkh>
 <32ad856f-1078-4133-b2f7-89c5eb2d271d@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32ad856f-1078-4133-b2f7-89c5eb2d271d@amd.com>

On Mon, Sep 22, 2025 at 12:00:08PM +0530, K Prateek Nayak wrote:
> Hello Greg,
> 
> On 9/21/2025 10:45 PM, Greg KH wrote:
> > On Mon, Sep 15, 2025 at 05:18:25AM +0000, K Prateek Nayak wrote:
> >> commit cba4262a19afae21665ee242b3404bcede5a94d7 upstream.
> 
> [..snip..]
> 
> >>
> >>   [ prateek: Adapted the fix from the original commit to stable kernel
> >>     which doesn't contain the x86 topology rewrite, renamed
> >>     cpu_parse_topology_ext() with the erstwhile
> >>     detect_extended_topology() function in commit message, dropped
> >>     references to extended topology leaf 0x80000026 which the stable
> >>     kernels aren't aware of, make a note of "cpu_die_id" parsing
> >>     nuances in detect_extended_topology() and why AMD processors should
> >>     still rely on TOPOEXT leaf for "cpu_die_id". ]
> > 
> > That's a lot of changes.  Why not just use a newer kernel for this new
> > hardware?  Why backport this in such a different way?
> 
> We are mostly solving problems of virtualization with this one for
> now.
> 
> QEMU can create a guest with more than 256vCPUs and tell the guest that
> each CPU is an individual core leading to weird handling of the
> CPUID 0x8000001e leaf when CoreId > 255
> https://github.com/qemu/qemu/commit/35ac5dfbcaa4b.
> 
> QEMU expects the guest to discover the topology using 0xb leaf which,
> the PPR says, is not dependent on the TOPOEXT feature.

Great, so these are new guests, use a new kernel!  :)

> > That is going to
> > cause other changes in the future to be harder to backport in the
> > future.
> 
> Thomas thinks this fix should be backported
> (https://lore.kernel.org/all/87o6rirrvc.ffs@tglx/) and for any future
> conflicts in this area, I'll be more than happy to help out resolve
> them.

Ok, if you get the maintainers to sign off on the change, I'll be glad
to take the patch.

thanks,

greg k-h

