Return-Path: <stable+bounces-67741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5883A9528CB
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 07:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2991C21C7E
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 05:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6EF57CBA;
	Thu, 15 Aug 2024 05:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hAphGNRb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F7457CA7
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 05:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723698669; cv=none; b=MQ2hp+sqkZpriBz28DkZynBAJ+mL2tXis9Se01ALyGQjHZpV0ro5/1rF4/KY5HLZrPoWpUPx14hNbrmWkD0bBaADFCpeHnYhNDWxk1Ol82ElTLnPF9VQw7ZeXN/QXeE3maPRPTV6cWRG7biTXrYodG7upmC/oXuNeWvGdZKsVfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723698669; c=relaxed/simple;
	bh=eXONwdpy7zzCQlj0SYE4BBEVndYt1VYhJpLfvIZUXhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqnZOnv7dvEoCYvGHpAQvN8I4IvSHB/wJYpdO/ELSKxZ7NUkiXwwePPMTZPM8W/HiNkn7WgJP0UAKowxTXLJ6VEcE4GKKoNxQk/l8Fc3xgkuIV7uzkcdkWVjguF16L1jKE6nIT4c1HbbKxHasmr7qlGOkwx8ZbN7hEwdYUbPn2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hAphGNRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225C9C4AF0A;
	Thu, 15 Aug 2024 05:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723698668;
	bh=eXONwdpy7zzCQlj0SYE4BBEVndYt1VYhJpLfvIZUXhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hAphGNRb2iwEUXBFO3UO550HW1JykHH9HxbgUW10wf6+djZafQEelqjG5aCs06xd5
	 NncjHXjJkKpSwgNKqXLGwWuM/RQZx9/tzNmEeDyKv9xDyWbhLM5sY9lUyXWhjKRgbp
	 wnzIEU7ddY6eCRsSsOQI9ovGNCcW1VuFu151Nu6A=
Date: Thu, 15 Aug 2024 07:11:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: AMD drm patch workflow is broken for stable trees
Message-ID: <2024081558-filtrate-stuffed-db5b@gregkh>
References: <2024081247-until-audacious-6383@gregkh>
 <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
 <CADnq5_MXBZ_WykSMv-GtHZv60aNzvLFVBOvze09o6da3-4-dTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_MXBZ_WykSMv-GtHZv60aNzvLFVBOvze09o6da3-4-dTQ@mail.gmail.com>

On Wed, Aug 14, 2024 at 05:30:08PM -0400, Alex Deucher wrote:
> On Wed, Aug 14, 2024 at 4:55 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
> >
> > On 2024-08-12 11:00, Greg KH wrote:
> > > Hi all,
> > >
> > > As some of you have noticed, there's a TON of failure messages being
> > > sent out for AMD gpu driver commits that are tagged for stable
> > > backports.  In short, you all are doing something really wrong with how
> > > you are tagging these.
> > Hi Greg,
> >
> > I got notifications about one KFD patch failing to apply on six branches
> > (6.10, 6.6, 6.1, 5.15, 5.10 and 5.4). The funny thing is, that you
> > already applied this patch on two branches back in May. The emails had a
> > suspicious looking date in the header (Sep 17, 2001). I wonder if there
> > was some date glitch that caused a whole bunch of patches to be re-sent
> > to stable somehow:
> 
> I think the crux of the problem is that sometimes patches go into
> -next with stable tags and they end getting taken into -fixes as well
> so after the merge window they end up getting picked up for stable
> again.  Going forward, if they land in -next, I'll cherry-pick -x the
> changes into -fixes so there is better traceability.

Please do so, and also work to not have duplicate commits like this in
different branches.  Git can handle merges quite well, please use it.

If this shows up again in the next -rc1 merge window without any
changes, I'll have to just blackhole all amd drm patches going forward
until you all tell me you have fixed your development process.

thanks,

greg k-h

