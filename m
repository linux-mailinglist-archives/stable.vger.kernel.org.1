Return-Path: <stable+bounces-76752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD4297C879
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 13:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08191F263BC
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 11:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E140F19AD7D;
	Thu, 19 Sep 2024 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HdFpUA5f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86646194083;
	Thu, 19 Sep 2024 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726744771; cv=none; b=MfkWeSwOPXfEk/eW2jGSSPjHgDUYnEtNCm6EA9tPVwgOm2vQO7EW36t9iTurEAX4PHpLXoQRCexN6kfi1z+r1cz/BKSkmoKfDfoRfiNRqjXSPeNYmhbsRgtqXSOPXX0KngqjSXyO7hpcYjqI1DUkdizUJ6JmNbc4Hsx/AITc9JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726744771; c=relaxed/simple;
	bh=jYG/+bOihbZ56Cfv+boYkIkhcJCD3pB8io/W06rCRq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRecYbzZyjAL627oxATAS8iuwzV1bOfDaLcauGMFPMPATtfw1CzBLXnjjtLYvbemSPa5fAxG0GBs/o4mvtJ4a0iKkV7DozCQ8qB6o0y+6DxnFWhLhC3OAC2EX60UbDyIxVpMNJIR8VbQMIq2w0LcAxJP+617cGf5tEyZL7Kft9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HdFpUA5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752BFC4CECD;
	Thu, 19 Sep 2024 11:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726744771;
	bh=jYG/+bOihbZ56Cfv+boYkIkhcJCD3pB8io/W06rCRq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HdFpUA5fFXnr0uduODX0yzlyu6InN/ClAbTrmPJYhVKEPBwTii5XzveqLWRwVqkJv
	 FgQaB7sFpuuns3YAJcol5rRIQoFZYJRNePncII5exa4MoIR38T19hMWy0niOxPSezk
	 gX/gwwL09NCOjLzxBKzvVGZlsyBjw1eJ1DcF7ElM=
Date: Thu, 19 Sep 2024 13:19:27 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "regressions@leemhuis.info" <regressions@leemhuis.info>,
	"Neri, Ricardo" <ricardo.neri@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"Gupta, Pawan Kumar" <pawan.kumar.gupta@intel.com>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>,
	"thomas.lindroth@gmail.com" <thomas.lindroth@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [STABLE REGRESSION] Possible missing backport of x86_match_cpu()
 change in v6.1.96
Message-ID: <2024091900-unimpeded-catalyst-b09f@gregkh>
References: <eb709d67-2a8d-412f-905d-f3777d897bfa@gmail.com>
 <a79fa3cc-73ef-4546-b110-1f448480e3e6@leemhuis.info>
 <2024081217-putt-conform-4b53@gregkh>
 <05ced22b5b68e338795c8937abb8141d9fa188e6.camel@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05ced22b5b68e338795c8937abb8141d9fa188e6.camel@intel.com>

On Wed, Sep 18, 2024 at 06:54:33AM +0000, Zhang, Rui wrote:
> On Mon, 2024-08-12 at 14:11 +0200, Greg KH wrote:
> > On Wed, Aug 07, 2024 at 10:15:23AM +0200, Thorsten Leemhuis wrote:
> > > [CCing the x86 folks, Greg, and the regressions list]
> > > 
> > > Hi, Thorsten here, the Linux kernel's regression tracker.
> > > 
> > > On 30.07.24 18:41, Thomas Lindroth wrote:
> > > > I upgraded from kernel 6.1.94 to 6.1.99 on one of my machines and
> > > > noticed that
> > > > the dmesg line "Incomplete global flushes, disabling PCID" had
> > > > disappeared from
> > > > the log.
> > > 
> > > Thomas, thx for the report. FWIW, mainline developers like the x86
> > > folks
> > > or Tony are free to focus on mainline and leave stable/longterm
> > > series
> > > to other people -- some nevertheless help out regularly or
> > > occasionally.
> > > So with a bit of luck this mail will make one of them care enough
> > > to
> > > provide a 6.1 version of what you afaics called the "existing fix"
> > > in
> > > mainline (2eda374e883ad2 ("x86/mm: Switch to new Intel CPU model
> > > defines") [v6.10-rc1]) that seems to be missing in 6.1.y. But if
> > > not I
> > > suspect it might be up to you to prepare and submit a 6.1.y variant
> > > of
> > > that fix, as you seem to care and are able to test the patch.
> > 
> > Needs to go to 6.6.y first, right?  But even then, it does not apply
> > to
> > 6.1.y cleanly, so someone needs to send a backported (and tested)
> > series
> > to us at stable@vger.kernel.org and we will be glad to queue them up
> > then.
> > 
> > thanks,
> > 
> > greg k-h
> 
> There are three commits involved.
> 
> commit A:
>    4db64279bc2b (""x86/cpu: Switch to new Intel CPU model defines"") 
>    This commit replaces
>       X86_MATCH_INTEL_FAM6_MODEL(ANY, 1),             /* SNC */
>    with
>       X86_MATCH_VFM(INTEL_ANY,         1),    /* SNC */
>    This is a functional change because the family info is replaced with
> 0. And this exposes a x86_match_cpu() problem that it breaks when the
> vendor/family/model/stepping/feature fields are all zeros.
> 
> commit B:
>    93022482b294 ("x86/cpu: Fix x86_match_cpu() to match just
> X86_VENDOR_INTEL")
>    It addresses the x86_match_cpu() problem by introducing a valid flag
> and set the flag in the Intel CPU model defines.
>    This fixes commit A, but it actually breaks the x86_cpu_id
> structures that are constructed without using the Intel CPU model
> defines, like arch/x86/mm/init.c.
> 
> commit C:
>    2eda374e883a ("x86/mm: Switch to new Intel CPU model defines")
>    arch/x86/mm/init.c: broke by commit B but fixed by using the new
> Intel CPU model defines
> 
> In 6.1.99,
> commit A is missing
> commit B is there
> commit C is missing
> 
> In 6.6.50,
> commit A is missing
> commit B is there
> commit C is missing
> 
> Now we can fix the problem in stable kernel, by converting
> arch/x86/mm/init.c to use the CPU model defines (even the old style
> ones). But before that, I'm wondering if we need to backport commit B
> in 6.1 and 6.6 stable kernel because only commit A can expose this
> problem.

If so, can you submit the needed backports for us to apply?  That's the
easiest way for us to take them, thanks.

greg k-h

