Return-Path: <stable+bounces-83317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E31998242
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 11:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212701F21E64
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 09:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0571A00F0;
	Thu, 10 Oct 2024 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yBwzCiGI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11EE187859
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552690; cv=none; b=tB73dfxPu4i1upXry0YqKbbfXZu+R8gL0En0KHs48GIFAqLnhZJMLiy7RP3xH8HDaFjt8hYDRYi16oBdLHpVBrEegrjX8K5LXPte6FONuqM/zB4sN35suRrWpfccT7GC82xO7kbWbZ4Uv9xAHdrZiP/DgKkyWz+WkTovX8qrOe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552690; c=relaxed/simple;
	bh=yzIkBaEycLm4qfbH6illfkLucUiWP+uxrF7nKoFA+bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKjJdVdihK9lc5eOAho+2rh+BOpJEpfdnbhdeajFLBzmqYvyisXgJhCR10RaOe/G0SNLMOyy4XB8MonkDY6FH57c6iTJ54keirCLWyMFN3TDNK7F1ZCVnA3FtcrsWEs8oCQcb/NmEGKds3vaSi0syMhsq+WS16tWEWiync3VegI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yBwzCiGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB855C4CEC5;
	Thu, 10 Oct 2024 09:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728552690;
	bh=yzIkBaEycLm4qfbH6illfkLucUiWP+uxrF7nKoFA+bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yBwzCiGIjAYkU+5wdwQ2vy6CF/scO/aMVBa3v99oATyqhEUGWbOmem3d69QaP3ckV
	 EqIXu8BWFxGuTcZf4u6EdEuwzv2wOcDEPS9Lr73JNfNnOCsePGA8IEz12cA2BfvHm2
	 gfTKvr/cg/q9+DsuB6iyYzYqeZRL0TLganpA+SUY=
Date: Thu, 10 Oct 2024 11:31:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jinpu Wang <jinpu.wang@ionos.com>
Cc: stable <stable@vger.kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	baolu.lu@linux.intel.com, jroedel@suse.de,
	Sasha Levin <sashal@kernel.org>, x86@kernel.org
Subject: Re: [regression]Boot Hang on Kernel 6.1.83+ with Dell PowerEdge R770
 and Intel Xeon 6710E
Message-ID: <2024101000-duplex-justify-97e6@gregkh>
References: <CAMGffE=dPofoPD_+giBnAC66-+=RqRmO2uBmC88-Ph1RgGN=0Q@mail.gmail.com>
 <2024101006-scanner-unboxed-0190@gregkh>
 <CAMGffE=HvMU4Syy7ATEevKQ+izAvndmpQ8-F9HN_WM+3PKwWyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGffE=HvMU4Syy7ATEevKQ+izAvndmpQ8-F9HN_WM+3PKwWyw@mail.gmail.com>

On Thu, Oct 10, 2024 at 11:13:42AM +0200, Jinpu Wang wrote:
> Hi Greg,
> 
> On Thu, Oct 10, 2024 at 11:07 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Oct 10, 2024 at 09:31:37AM +0200, Jinpu Wang wrote:
> > > Hello all,
> > >
> > > We are experiencing a boot hang issue when booting kernel version
> > > 6.1.83+ on a Dell Inc. PowerEdge R770 equipped with an Intel Xeon
> > > 6710E processor. After extensive testing and use of `git bisect`, we
> > > have traced the issue to commit:
> > >
> > > `586e19c88a0c ("iommu/vt-d: Retrieve IOMMU perfmon capability information")`
> > >
> > > This commit appears to be part of a larger patchset, which can be found here:
> > > [Patchset on lore.kernel.org](https://lore.kernel.org/lkml/7c4b3e4e-1c5d-04f1-1891-84f686c94736@linux.intel.com/T/)
> > >
> > > We attempted to boot with the `intel_iommu=off` option, but the system
> > > hangs in the same manner. However, the system boots successfully after
> > > disabling `CONFIG_INTEL_IOMMU_PERF_EVENTS`.
> >
> > Is there any error messages?  Does the latest 6.6.y tree work properly?
> > If so, why not just use that, no new hardware should be using older
> > kernel trees anyway :)
> No error, just hang, I've removed "quiet" and added "debug".
> Yes, the latest 6.6.y tree works for this, but there are other
> problems/dependency we have to solve.

Ok, that implies that we need to add some other patch to 6.1.y, OR we
can revert it from 6.1.y.  Let me know what you think is the better
thing to do.

thanks,

greg k-h

