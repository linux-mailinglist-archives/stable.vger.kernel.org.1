Return-Path: <stable+bounces-165619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A779B16B60
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 06:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C32546E24
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 04:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDFC23B614;
	Thu, 31 Jul 2025 04:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vb/1BM7l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5931E51D
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 04:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753937927; cv=none; b=YQt7We+zIm81wkcsCY71YUhM/2DoKp9TPFvy3VCvCMuhukN6KPl+20zRwXQvXsb+DI8ZYiQplQHv4ARY3RTkezT5wRaoxzOqcPrdlvaBrAYIN70cqQWYMbFNEFFgaPnW2+4FOPjBpCwjVf604tK18Ht0XY5eKh675vPDTghGzdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753937927; c=relaxed/simple;
	bh=r3T/5Kd5fbFZoK4QysxNkvRGaWz6p0BQm7QV/F2hHUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBIHpLnXdrbfyh1LppL3+DDWfI/A9I/MOxX9TumTK8M8wDzv4zPjI8oapjV5qYcqvctmwBoj8qeUPRshnmzmZTPGjYie0LJ+bYjcvFE2LuKFTa5AbF0uaG6zCzDCzd2W77hfM6JHcsnwUdO3VSDybh0eVdzCgByxTBgOgV95bao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vb/1BM7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD54C4CEEF;
	Thu, 31 Jul 2025 04:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753937924;
	bh=r3T/5Kd5fbFZoK4QysxNkvRGaWz6p0BQm7QV/F2hHUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vb/1BM7lRyi9yAz3qsR9dPpmS6T2JBKO+bFH1KyADiM9nOTXA9RNvGPIl5WuR+N5U
	 sIaHPExPs0PgXNlXHZKNEyKB49KzNj3WcyO/D0RSfkefl/vBNtoibcAYSLeiEdSqg7
	 mWe5DnKPCwijC5q28UCBc5sWSVN5Wbu9F3cRKIR8=
Date: Thu, 31 Jul 2025 06:58:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Isaac Manjarres <isaacmanjarres@google.com>, aliceryhl@google.com,
	surenb@google.com, stable@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 5.10.y 0/4] Backport series: "permit write-sealed memfd
 read-only shared mappings"
Message-ID: <2025073103-unheated-outbid-11a2@gregkh>
References: <20250730015406.32569-1-isaacmanjarres@google.com>
 <c99af418-946d-40c4-9594-36943d8c72bf@lucifer.local>
 <aIpVKpqXmfuITxf-@google.com>
 <d8bfc16a-466d-43b9-9021-91f6b65a3a81@lucifer.local>
 <aIqb-bDjsXppmyPN@google.com>
 <538efa9f-d3e5-41ab-ac82-5b7b799df706@lucifer.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <538efa9f-d3e5-41ab-ac82-5b7b799df706@lucifer.local>

On Thu, Jul 31, 2025 at 05:40:29AM +0100, Lorenzo Stoakes wrote:
> On Wed, Jul 30, 2025 at 03:26:01PM -0700, Isaac Manjarres wrote:
> > On Wed, Jul 30, 2025 at 08:34:02PM +0100, Lorenzo Stoakes wrote:
> > > > >
> > > > > Having said that, I'm not against you doing this, just wondering about
> > > > > that.
> > > > >
> > > > > Also - what kind of testing have you do on these series?
> > > > I did the following tests:
> > > >
> > > > 1. I have a unit test that tries to map write-sealed memfds as
> > > > read-only and shared. I verified that this works for each kernel version
> > > > that this series is being applied to.
> > > >
> > > > 2. Android devices do use memfds as well, so I did try these patches out
> > > > on a device running each kernel version, and tried boot testing, using
> > > > several apps/games. I was looking for functional failures in these
> > > > scenarios but didn't encounter any.
> > > >
> > > > Do you have any other recommendations of what I should test?
> > >
> > > No, that sounds good to me! Thank you for taking the time to implement and
> > > carefully check this :)
> > >
> > > In this case I have no objections to these backports!
> > >
> > > Cheers, Lorenzo
> >
> > Thanks Lorenzo! Just to confirm, is there anything required from my
> > end for these patches or they'll get reviewed and merged over time?
> 
> No, these should all be good to go, Greg + Sasha handle the stable kernels
> and should percolate through their process (I see Sasha's scripts have been
> firing off already :)

Yeah, give us a week or so to catch up with all of the recently
submitted changes, the merge window, AND finally, a vacation for the
stable maintainers....

thanks,

greg k-h

