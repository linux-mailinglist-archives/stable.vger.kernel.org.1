Return-Path: <stable+bounces-67742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 639739528CD
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 07:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973211C2117D
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 05:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA32457CA7;
	Thu, 15 Aug 2024 05:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WWXz1qEY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689FF58ABC
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 05:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723698765; cv=none; b=WQpRNZIrKGWB8Xk+Dx4c3LLAN2lM1K9Q/XCLrd8HDUBoLi7wLWlto1976hXkpMhaTOAyl+OBsUIihgJU+ktUrHORvQ8moL+Gj3+m+it7MfgqDm/9EDVT31sGOqaGUftVpVw4D+TVD6vcVDoFpI0/CWfdDy5YSycoJnust1llCNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723698765; c=relaxed/simple;
	bh=Nhs4LP/qOha9uBz5IKXTxoESOcgX8PVTbALyHYj31N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJJ5MCerqw+Z26OsYfBTA0gleDYmNsySBCJBKSscQJWlJ9kUZ7FeWAD82rBm/j0YkHF9MfyaptiltP5oyBVxvCe3BOJHpWJTWQYc4LbKaTB9Ih7gynY2r1A3zCMlDOe+KzUhaNx7AUic7tAPJpMa0dgKMuaI4pYQawM5Z+sxUxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WWXz1qEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F46C4AF0A;
	Thu, 15 Aug 2024 05:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723698764;
	bh=Nhs4LP/qOha9uBz5IKXTxoESOcgX8PVTbALyHYj31N8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWXz1qEYUgsDIfcOzUses/8TFIE43Yb2x3KTlsB2rBaVb8fSCEfa++IoVb0cPIzv/
	 pyZsdjwt//xvZvWX1hrjPe946GN4FuA0qEbGhRPo3iaBe0eSqaO8cQ9MK+3Iq3AGDW
	 +QRkcGBSSGD8qGTik94R6a5kOw6JQHSl+Pt8X1Hg=
Date: Thu, 15 Aug 2024 07:12:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: AMD drm patch workflow is broken for stable trees
Message-ID: <2024081527-step-resort-2984@gregkh>
References: <2024081247-until-audacious-6383@gregkh>
 <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>

On Wed, Aug 14, 2024 at 04:39:29PM -0400, Felix Kuehling wrote:
> On 2024-08-12 11:00, Greg KH wrote:
> > Hi all,
> > 
> > As some of you have noticed, there's a TON of failure messages being
> > sent out for AMD gpu driver commits that are tagged for stable
> > backports.  In short, you all are doing something really wrong with how
> > you are tagging these.
> Hi Greg,
> 
> I got notifications about one KFD patch failing to apply on six branches
> (6.10, 6.6, 6.1, 5.15, 5.10 and 5.4). The funny thing is, that you already
> applied this patch on two branches back in May. The emails had a suspicious
> looking date in the header (Sep 17, 2001). I wonder if there was some date
> glitch that caused a whole bunch of patches to be re-sent to stable somehow:
> 
>    ------------------ original commit in Linus's tree
>    ------------------ From 24e82654e98e96cece5d8b919c522054456eeec6 Mon
>    Sep 17 00:00:00 2001 From: Alex Deucher
>    <alexander.deucher@amd.com>Date: Sun, 14 Apr 2024 13:06:39 -0400

That's the real date, ignore the 2001 thing, that's from git.


>    Subject: [PATCH] drm/amdkfd: don't allow mapping the MMIO HDP page
>    with large pages ...
> 
> On 6.1 and 6.6, the patch was already applied by you in May:
> 
>    $ git log --pretty=fuller stable/linux-6.6.y --grep "drm/amdkfd: don't allow mapping the MMIO HDP page with large pages"
>    commit 4b4cff994a27ebf7bd3fb9a798a1cdfa8d01b724
>    Author:     Alex Deucher <alexander.deucher@amd.com>
>    AuthorDate: Sun Apr 14 13:06:39 2024 -0400
>    Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>    CommitDate: Fri May 17 12:02:34 2024 +0200
> 
>         drm/amdkfd: don't allow mapping the MMIO HDP page with large pages
>    ...
> 
> On 6.10 it was already upstream.

Then why did we have it in the tree again with different commit ids?
That's the issue here, and the major confusion as there is no way for us
to determine if this is a commit that has been in the tree already or if
it's just a normal failure.

> On 5.4-5.15 it doesn't apply because of conflicts. I can resolve those and
> send the fixed patches out for you.

If it is needed in those branches, please do so.

thanks,

greg k-h

