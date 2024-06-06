Return-Path: <stable+bounces-49902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC4D8FEF52
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D591C2214E
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C511CBE9D;
	Thu,  6 Jun 2024 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2GMYCgyd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40131A254F;
	Thu,  6 Jun 2024 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683768; cv=none; b=dT8no/Ca7KFqB8ep1aPD8ZJdpHuB9MHout3p+72nBOTo9+CkM0sc17BjV94mWoCO93ZsRKMBZa5e9WVYde6+dLgk9uySw/NTx9f8o5PBMOOoEUJXzqk0QEXSYimrXtPVIK9u8z2Xj2OpyM1CUDnpprlF9ExAWE/V9Ymy5qGPGZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683768; c=relaxed/simple;
	bh=1HNFiy1jpw/EjA2f0IjPfo/V03/2GnQ7OxSIg1zvXGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rk3pn90d52bIwwdSWXygosegBu94Guz10/Rx6fj+sRXshVz28D5IZOq0EPCUWQhFRe1uViHcsADOCL5SRercWF4KPYXx8HW8FA8eryFDzWkcpAosR0fofAKfxSNol6U6rSqDFLpcy9dK4J8oz1AT90xj7uLWXyaDHvOGKT8J+NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2GMYCgyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA0EC32781;
	Thu,  6 Jun 2024 14:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683767;
	bh=1HNFiy1jpw/EjA2f0IjPfo/V03/2GnQ7OxSIg1zvXGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2GMYCgydJt4fBk0IgH4GLTOro5Hy+2EzGcmuP6j9wHW7x9w+193mzt80JzlsTrMUV
	 OJGVyAEV7zwoX5ZFTwwy0D7Qf73xXnxXlmEYkq+I7g6lDMQdk+VbrC6eJMkfiiENh7
	 OSt/OKebHO8S+zdjnsNPcSROoQhxRiMTBTNVHXlI=
Date: Thu, 6 Jun 2024 16:07:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: Patch "arm64: fpsimd: Bring cond_yield asm macro in line with
 new rules" has been added to the 6.6-stable tree
Message-ID: <2024060607-lapped-crunching-4816@gregkh>
References: <20240605231152.3112791-1-sashal@kernel.org>
 <CAMj1kXHrpZzJvvi+4RaMVV5_tsEU62_EC-7MboHBbR1hTMgTcg@mail.gmail.com>
 <2024060619-drank-unheard-bd84@gregkh>
 <CAMj1kXGFZZT8XQaUdfH1FOaSzU+jp-_cBZa=i180Wx+Tm_3Snw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGFZZT8XQaUdfH1FOaSzU+jp-_cBZa=i180Wx+Tm_3Snw@mail.gmail.com>

On Thu, Jun 06, 2024 at 03:16:55PM +0200, Ard Biesheuvel wrote:
> On Thu, 6 Jun 2024 at 15:14, Greg KH <greg@kroah.com> wrote:
> >
> > On Thu, Jun 06, 2024 at 02:42:09PM +0200, Ard Biesheuvel wrote:
> > > On Thu, 6 Jun 2024 at 01:11, Sasha Levin <sashal@kernel.org> wrote:
> > > >
> > > > This is a note to let you know that I've just added the patch titled
> > > >
> > > >     arm64: fpsimd: Bring cond_yield asm macro in line with new rules
> > > >
> > > > to the 6.6-stable tree which can be found at:
> > > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > >
> > > > The filename of the patch is:
> > > >      arm64-fpsimd-bring-cond_yield-asm-macro-in-line-with.patch
> > > > and it can be found in the queue-6.6 subdirectory.
> > > >
> > > > If you, or anyone else, feels it should not be added to the stable tree,
> > > > please let <stable@vger.kernel.org> know about it.
> > > >
> > >
> > > NAK
> > >
> > > None of these changes belong in v6.6 - please drop all of them.
> > >
> >
> > Ah, I see why, it was to get e92bee9f861b ("arm64/fpsimd: Avoid
> > erroneous elide of user state reload") to apply properly.  I'll drop
> > that as well, can you provide a backported version instead?
> >
> 
> No, I cannot, given that it fixes something that wasn't broken in v6.6
> to begin with.

Ah, yeah, odd.  Sasha, why did your scripts pick this up?

greg k-h

