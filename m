Return-Path: <stable+bounces-120003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A896AA4A8EF
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 06:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30CD4189A965
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 05:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ABB1B85F8;
	Sat,  1 Mar 2025 05:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yZynGDlY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C7528E7;
	Sat,  1 Mar 2025 05:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740807137; cv=none; b=VFmpIwJo5I2qr3QBFsgcT+/6w5m71lTMwWtVujoN+g7sbx6ZSaVLq2OtJH+juMbNh1lVjy8DIOo9wplQ7hGbDnMfNAwPmXKdDXblR7If8B2fIZ2WcV65jV6I6lVZk4ccQJ+78ydek8wu+fUyBFdLYj8lV7Njl5ctY4rkISfOyJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740807137; c=relaxed/simple;
	bh=hPXdQ/hFIPpJkdJk70/Oo9SCb0ot1PV7JSm65Zo7Cqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPHAcNfrtgbXkhsLaOh4GXH3stFpev8fSUoqvLwgSSm+qP5Rd0jYMmN+GjZhmZQaVTIUJn9iM7yfW5buXKYsuMeqLBkkVuAnjiYnjnKQc9Y54yrVl12ePmzwZ9yHfMfpFjauiMLYI0qz49/hVE1wcJ5XbZuMTVuct9bIuP0vkcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yZynGDlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322F8C4CEDD;
	Sat,  1 Mar 2025 05:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740807136;
	bh=hPXdQ/hFIPpJkdJk70/Oo9SCb0ot1PV7JSm65Zo7Cqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yZynGDlYwSbyoqFxsYZl1iByokf6rG0lkNQ74A4dx6zWUHiE8rkNPKdaqpLCM49Bn
	 Uzrt/PWQSzWLM/oTxXcz3PcYxelzJVyoeGwpXCciRubcatryZJoBOlZTenvMi71GVA
	 2W0TdbFnLPo/0syo4YdyI4XV80EkIo0CIlMPU25o=
Date: Fri, 28 Feb 2025 20:19:47 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Cc: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
	Radoslav =?iso-8859-1?Q?Bod=F3?= <radoslav.bodo@igalileo.cz>,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [6.1.y] Regression from b1e6e80a1b42 ("xen/swiotlb: add
 alignment check for dma buffers") when booting with Xen and mpt3sas_cm0
 _scsih_probe failures
Message-ID: <2025022853-undivided-scribing-70dd@gregkh>
References: <Z6d-l2nCO1mB4_wx@eldamar.lan>
 <fd650c88-9888-46bc-a448-9c1ddcf2b066@oracle.com>
 <Z6ukbNnyQVdw4kh0@eldamar.lan>
 <716f186d-924a-4f2c-828a-2080729abfe9@oracle.com>
 <6d7ed6bf-f8ad-438a-a368-724055b4f04c@suse.com>
 <2025021548-amiss-duffel-9dcf@gregkh>
 <74e74dde-0703-4709-96b8-e1615d40f19c@suse.com>
 <2025021533-grime-luminous-d598@gregkh>
 <e01c39ad-6f5e-449a-b24a-db3b7984030e@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e01c39ad-6f5e-449a-b24a-db3b7984030e@oracle.com>

On Fri, Feb 28, 2025 at 01:50:12PM +0530, Harshvardhan Jha wrote:
> 
> On 15/02/25 8:25 PM, Greg KH wrote:
> > On Sat, Feb 15, 2025 at 02:39:46PM +0100, Jürgen Groß wrote:
> >> On 15.02.25 13:34, Greg KH wrote:
> >>> On Sat, Feb 15, 2025 at 12:47:57PM +0100, Jürgen Groß wrote:
> >>>> On 12.02.25 16:12, Harshit Mogalapalli wrote:
> >>>>> Hi Salvatore,
> >>>>>
> >>>>> On 12/02/25 00:56, Salvatore Bonaccorso wrote:
> >>>>>> Hi Harshit,
> >>>>>>
> >>>>>> On Sun, Feb 09, 2025 at 01:45:38AM +0530, Harshit Mogalapalli wrote:
> >>>>>>> Hi Salvatore,
> >>>>>>>
> >>>>>>> On 08/02/25 21:26, Salvatore Bonaccorso wrote:
> >>>>>>>> Hi Juergen, hi all,
> >>>>>>>>
> >>>>>>>> Radoslav Bodó reported in Debian an issue after updating our kernel
> >>>>>>>> from 6.1.112 to 6.1.115. His report in full is at:
> >>>>>>>>
> >>>>>>>> https://bugs.debian.org/1088159
> >>>>>>>>
> >>>>>>> Note:
> >>>>>>> We have seen this on 5.4.y kernel: More details here:
> >>>>>>> https://lore.kernel.org/all/9dd91f6e-1c66-4961-994e-dbda87d69dad@oracle.com/
> >>>>>> Thanks for the pointer, so looking at that thread I suspect the three
> >>>>>> referenced bugs in Debian are in the end all releated. We have one as
> >>>>>> well relating to the megasas_sas driver, this one for the mpt3sas
> >>>>>> driver and one for the i40e driver).
> >>>>>>
> >>>>>> AFAICS, there is not yet a patch which has landed upstream which I can
> >>>>>> redirect to a affected user to test?
> >>>>>>
> >>>>> Konrad pointed me at this thread: https://lore.kernel.org/
> >>>>> all/20250211120432.29493-1-jgross@suse.com/
> >>>>>
> >>>>> This has some fixes, but not landed upstream yet.
> >>>> Patches are upstream now. In case you still experience any problems, please
> >>>> speak up.
> >>> What specific commits should be backported here?
> >> Those are:
> >>
> >> e93ec87286bd1fd30b7389e7a387cfb259f297e3
> >> 85fcb57c983f423180ba6ec5d0034242da05cc54
> > Ugh, neither of them were marked for stable inclusion, why not?  Anyway,
> > I'll go queue them up after this round of kernels is released hopefully
> > tomorrow, but next time, please follow the stable kernel rules if you
> > know you want a patch included in a tree.
> 
> 
> Hi,
> 
> I see these patches in 6.12 now and upon manually checking these patches
> cleanly apply till 6.6 kernel so I guess they will be eventually back
> ported till there?

They are already in the following released kernels:
	6.1.129 6.6.79 6.12.16 6.13.4 6.14-rc3

and the first one is in the stable queues for 5.15, 5.10, and 5.4.  The
second one is not because as you mention:

> 6.1 and older kernels have conflicts while cherry
> picking these commits which makes it harder to verify them as the test
> machine I have runs on a much older kernel(5.4) unfortunately. If it
> could be at least be brought back till 5.15, testing this would become
> much easier.

The commit does not apply cleanly there.  If you need/want it there,
please provide a working and tested backport.

thanks,

greg k-h

