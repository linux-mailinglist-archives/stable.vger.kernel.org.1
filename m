Return-Path: <stable+bounces-118450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D3EA3DCD3
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 15:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6B816CD75
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 14:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4253B1FC7E8;
	Thu, 20 Feb 2025 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PAMEuPln"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F413E1FBCBC
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061613; cv=none; b=DY+z55pwKPXsvBdptZ+6UVQyq+VnlTo4MRZ8ZnbPzgClaFqw8c2FUmFvzMhSFSoT7jpn/sV06OPsA70O18EZmCHanWceghX331Af2gwGaqJRod0CaPkKuyZGsqPhF1dI7UtQejLAzQbu4jCuYVR1HNCUjNFsVJs74hUZrQqU9yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061613; c=relaxed/simple;
	bh=hcjIYmHFhauSoYa58xAPLCIw9wFMJzas7TkykTzZxKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnAhrB/ZPrXQQMJ0LkwYdb33+Jq2F0GJDt3QtG/5vBUpPYo9Be9ezGEmMn02cniZvIx0wXBM026A9gDVzQOSCCaTKk20SH8WraesjC0hca0Auwbs2gMJb18I/Ip/DJ/2X8jdG00qw3YzzDJ8iCkmxUdsC5vTuFFqMryEC+h39fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PAMEuPln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13402C4CED1;
	Thu, 20 Feb 2025 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740061612;
	bh=hcjIYmHFhauSoYa58xAPLCIw9wFMJzas7TkykTzZxKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PAMEuPln2i+dgVjjFYcoFIxj8MCYbEpuUOKw9SAWgmUlpRRks5PMTHoBKizmnOfO/
	 2ylA1jdFuFyNFjKJpJG8zKRK+4z7helQW9F41gt8RqWSKhJ/zfL666OK8XTEAakwH9
	 c0qBXccLzcjhUR25b4GODZNzWGYxqNzJ6wVGLy3M=
Date: Thu, 20 Feb 2025 15:26:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Guillaume Morin <guillaume@morinfr.org>
Cc: Tomas Glozar <tglozar@redhat.com>, stable@vger.kernel.org,
	bristot@kernel.org, lgoncalv@redhat.com
Subject: Re: 6.6.78: timerlat_{hist,top} fail to build
Message-ID: <2025022021-xerox-resolved-74ca@gregkh>
References: <Z7XtY3GRlRcKCAzs@bender.morinfr.org>
 <CAP4=nvQ2cZhJbuvCryW7aTm4FcLSGLyDnhZX1wHNLxo1b3q2Lg@mail.gmail.com>
 <Z7c2Mc0DYKQ-L9Yg@bender.morinfr.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7c2Mc0DYKQ-L9Yg@bender.morinfr.org>

On Thu, Feb 20, 2025 at 03:03:29PM +0100, Guillaume Morin wrote:
> On 19 Feb 16:03, Tomas Glozar wrote:
> >
> > Hello,
> > 
> > st 19. 2. 2025 v 15:48 odesílatel Guillaume Morin
> > <guillaume@morinfr.org> napsal:
> > >
> > > Hello,
> > >
> > > The following patches prevent Linux 6.6.78+ rtla to build:
> > >
> > > - "rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads" (stable
> > > commit 41955b6c268154f81e34f9b61cf8156eec0730c0)
> > > - "rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads" (stable
> > > commit 83b74901bdc9b58739193b8ee6989254391b6ba7)
> > >
> > > Both were added to Linux 6.6.78 based on the Fixes tag in the upstream
> > > commits.
> > >
> > > These patches prevent 6.6.78 rta to build with a similar error (missing
> > > kernel_workload in the params struct)
> > > src/timerlat_top.c:687:52: error: ‘struct timerlat_top_params’ has no member named ‘kernel_workload’
> > >
> > 
> > I did not realize that, sorry!
> > 
> > > These patches appear to depend on "rtla/timerlat: Make user-space
> > > threads the default" commit fb9e90a67ee9a42779a8ea296a4cf7734258b27d
> > > which is not present in 6.6.
> > >
> > > I am not sure if it's better to revert them or pick up
> > > fb9e90a67ee9a42779a8ea296a4cf7734258b27d in 6.6. Tomas, what do you
> > > think?
> > >
> > 
> > We don't want to pick up fb9e90a67ee9a42779a8ea296a4cf7734258b27d
> > (rtla/timerlat: Make user-space threads the default) to stable, since
> > it changes the default behavior as well as output of rtla.
> > 
> > The patches can be fixed by by substituting params->kernel_workload
> > for !params->user_hist (!params->user_top) for the version of the
> > files that is present in 6.6-stable (6.1-stable is not affected, since
> > it doesn't have user workload mode at all).
> > 
> > I'm not sure what the correct procedure would be. One way I can think
> > of is reverting the patch as broken, and me sending an alternate
> > version of the patch for 6.6-stable containing the change above. That
> > would be the cleanest way in my opinion (as compared to sending the
> > fixup directly).
> 
> Either way would work for me. Not sure what Greg prefers however

I prefer to take whatever is upstream, and if that doesn't work, and
these were applied incorrectly, we can just revert them.

thanks,

greg k-h

