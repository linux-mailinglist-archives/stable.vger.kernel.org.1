Return-Path: <stable+bounces-112202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88E1A278F1
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 18:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A894C1886D57
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 17:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5316A2144CA;
	Tue,  4 Feb 2025 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DrYC0Bjr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11D514A0B5;
	Tue,  4 Feb 2025 17:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691340; cv=none; b=rKaLWBGLqEJ5fVXMchGyFtyHmkdCrLjO+S0U3DGGD4m/B0HfrK9fcCYHFusqIYj/5wXsas3jFlpk8I468qWbGKqBO+EnjMJ6+PPBXnI5VtgaFuDo7814Oba9AMZyzpzgd/nWcyqsHjIeWJn3hgTKPvvncKz5AMLJ57U4nM8C3/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691340; c=relaxed/simple;
	bh=g/VxoRUH8k3IUvvUXWEGGfr2JN9RqBgB3dkZXEdAEls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIQtqcVkNA4/frwkVtEv294CVLCh2L3zkAln+a1jzNXJE0ntMOXZCODURENQ54Vi3jXCCczOTCw4oZ6Gj8krBqJJoEAjL2fAQEp5+mchCw/9DMt77j1j3fSLLE2AqkQ6DYfx1FAqHU4O+3ChhMhrzKNd9StiFElC/ISObe0XFb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DrYC0Bjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5203C4CEDF;
	Tue,  4 Feb 2025 17:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738691339;
	bh=g/VxoRUH8k3IUvvUXWEGGfr2JN9RqBgB3dkZXEdAEls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DrYC0BjrDRE+LzBnW3DUmJyuSvY8wGR78hFCHYpfe7o31p4nE9Z8dcSrp9VjldDkh
	 LAROwvS3BO6lrlTPt6qXmD0MyYyuGjQc/M2ONsckOnTDfpO6UlhKnpPYLLD4CbCdKY
	 8VPQ/M+9rAZkxv6WLlzCQhOPELk3jHNo/mZF5Xqg=
Date: Tue, 4 Feb 2025 18:48:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	sui.jingfeng@linux.dev,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: Patch "drm/etnaviv: Drop the offset in page manipulation" has
 been added to the 6.12-stable tree
Message-ID: <2025020448-relay-properly-48f2@gregkh>
References: <20250202043355.1913248-1-sashal@kernel.org>
 <d8b6c3b4eda513277f19640c8f792c6d70b03f06.camel@pengutronix.de>
 <2025020354-helpless-tiring-9fc5@gregkh>
 <8e8bc70b7d55054738dec6628e184943f78d3c6c.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e8bc70b7d55054738dec6628e184943f78d3c6c.camel@pengutronix.de>

On Mon, Feb 03, 2025 at 10:38:57AM +0100, Lucas Stach wrote:
> Am Montag, dem 03.02.2025 um 10:29 +0100 schrieb Greg KH:
> > On Mon, Feb 03, 2025 at 09:59:56AM +0100, Lucas Stach wrote:
> > > Hi Sasha,
> > > 
> > > Am Samstag, dem 01.02.2025 um 23:33 -0500 schrieb Sasha Levin:
> > > > This is a note to let you know that I've just added the patch titled
> > > > 
> > > >     drm/etnaviv: Drop the offset in page manipulation
> > > > 
> > > > to the 6.12-stable tree which can be found at:
> > > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > > 
> > > > The filename of the patch is:
> > > >      drm-etnaviv-drop-the-offset-in-page-manipulation.patch
> > > > and it can be found in the queue-6.12 subdirectory.
> > > > 
> > > > If you, or anyone else, feels it should not be added to the stable tree,
> > > > please let <stable@vger.kernel.org> know about it.
> > > > 
> > > please drop this patch and all its dependencies from all stable queues.
> > > 
> > > While the code makes certain assumptions that are corrected in this
> > > patch, those assumptions are always true in all use-cases today. I
> > > don't see a reason to introduce this kind of churn to the stable trees
> > > to fix a theoretical issue.
> > 
> > Maybe in the future, for "theoretical issues", please don't put a
> > "Fixes:" tag on them?
> 
> Agreed. This tag slipped through when I applied this patch, I'll be
> more careful next time.

Ok, all now dropped, thanks.

greg k-h

