Return-Path: <stable+bounces-120364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83708A4EA99
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 19:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7762A189F559
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470BC2D4F85;
	Tue,  4 Mar 2025 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aROuv1HU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D0F29CB55;
	Tue,  4 Mar 2025 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110053; cv=none; b=WxGvqLd5GYWaZvtMUCq9YsurmtrJnMcWL8SbuAU27ik/uxT5uR4B2O2cQkKuK0mNJgY3J61BPrbPfbhD8GzYjv8HfNnkA62AOOII4blS3qRQfrXwLRRiPUBZolp2O3ysGt8AGKDCrS4lDG12LVJ7W80ZbMhMorlJKSXfKC5wFB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110053; c=relaxed/simple;
	bh=/NdOoVcaQwRcaojuFsyNQkKjvvlLy1YPhSe6JCsHM5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuBVFO0oLtB6PQdISXlmfoOdwUS9vUCuV6P3C4fOFLhYvW6IJpkhX6akJPFGWaSG+I4CUu2D0O/q5g0K0KBzI34cdBUNeZvXUgI0/z2k0LM4B4AiKIHokggm20/nC2ly3pCUdAAmSiaW62Cw+5fpOTW1arNdYSqEZY+zSd2oeoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aROuv1HU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05A3C4CEE5;
	Tue,  4 Mar 2025 17:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741110052;
	bh=/NdOoVcaQwRcaojuFsyNQkKjvvlLy1YPhSe6JCsHM5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aROuv1HUuEigfDVuGL8hN1KePq1SAeotCXexKrm73/XLntiR9ahi0O6NSLSGR+ozW
	 LJYDhigQ5rk8Uh8uhZX8BDigoGvnQsN5n9bSP8VfR8RRI6phQrDu3id+3/LhLGqGM4
	 KQMkuywKkqmekD6I3ZxUfJ94tXa5XZWivmX96I64=
Date: Tue, 4 Mar 2025 18:40:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, ardb@kernel.org
Subject: Re: Regression for PXE boot from patch "Remove the 'bugger off'
 message" in stable 6.6.18
Message-ID: <2025030429-battalion-lyricism-c62c@gregkh>
References: <202503041549.35913.ulrich.gemkow@ikr.uni-stuttgart.de>
 <2025030459-singer-compactor-9c91@gregkh>
 <202503041759.32756.ulrich.gemkow@ikr.uni-stuttgart.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503041759.32756.ulrich.gemkow@ikr.uni-stuttgart.de>

On Tue, Mar 04, 2025 at 05:59:32PM +0100, Ulrich Gemkow wrote:
> Hallo,
> 
> On Tuesday 04 March 2025, Greg KH wrote:
> > On Tue, Mar 04, 2025 at 03:49:35PM +0100, Ulrich Gemkow wrote:
> > > Hello,
> > > 
> > > starting with stable kernel 6.6.18 we have problems with PXE booting.
> > > A bisect shows that the following patch is guilty:
> > > 
> > >   From 768171d7ebbce005210e1cf8456f043304805c15 Mon Sep 17 00:00:00 2001
> > >   From: Ard Biesheuvel <ardb@kernel.org>
> > >   Date: Tue, 12 Sep 2023 09:00:55 +0000
> > >   Subject: x86/boot: Remove the 'bugger off' message
> > > 
> > >   Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > >   Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > >   Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> > >   Link: https://lore.kernel.org/r/20230912090051.4014114-21-ardb@google.com
> > > 
> > > With this patch applied PXE starts, requests the kernel and the initrd.
> > > Without showing anything on the console, the boot process stops.
> > > It seems, that the kernel crashes very early.
> > > 
> > > With stable kernel 6.6.17 PXE boot works without problems.
> > > 
> > > Reverting this single patch (which is part of a larger set of
> > > patches) solved the problem for us, PXE boot is working again.
> > > 
> > > We use the packages syslinux-efi and syslinux-common from Debian 12.
> > > The used boot files are /efi64/syslinux.efi and /ldlinux.e64.
> > > 
> > > Our config-File (for 6.6.80) is attached.
> > > 
> > > Regarding the patch description, we really do not boot with a floppy :-)
> > > 
> > > Any help would be greatly appreciated, I have a bit of a bad feeling
> > > about simply reverting a patch at such a deep level in the kernel.
> > 
> > Does newer kernels than 6.7.y work properly?  What about the latest
> > 6.12.y release?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Thanks for looking into this!
> 
> The latest 6.12.y kernel has the same problem, it also needs reverting
> the mentioned patch. I did not test Kernels in between but I am happy
> to do so, when this gives a hint.
> 
> Thanks again and best regards

Great, then this is an issue in Linus's tree and should be fixed there
first.

thansk,

greg k-h

