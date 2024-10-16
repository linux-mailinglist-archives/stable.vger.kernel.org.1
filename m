Return-Path: <stable+bounces-86478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766889A07CE
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 12:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38AE4286E76
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875F82071F9;
	Wed, 16 Oct 2024 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="izftSFn+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3679D1CACDB;
	Wed, 16 Oct 2024 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075889; cv=none; b=ccQf2srg7zLvsOZHcT/Pws3/0C4pdEypg2tAz/2uClrr3PQwx9zejFBsRMGLmM6ej7WYGLFmyX6ZgKW2keleqlCOkyDIwjrjott/RpNUmo6FVuVSh8kgHZxHzJVUmDZwtjtYBkZT8ndLVJ/v1U7OEGRsWOyEH9rDPgKkEjDf9E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075889; c=relaxed/simple;
	bh=LMM7TuS5hAf1w8ZzZUH0GziAYhZkQvCa7eayiPmWRx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I79PCITOWDd5UPiCwRovK/qqxNxW2c+QVs96y2FzYRdWf123oWFUYnPOiNAgFlswf7yN3TRYd+2eRgNlO7ouK0mf6xEWGsQJ4gx1BSHP8FpbRgJAmp1ZF2BzQCXtBmLgXBJw2GVDwDSKilAk9qJEl6Ds5a3brEMJ3UsXxZPiaao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=izftSFn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274CDC4CEC5;
	Wed, 16 Oct 2024 10:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729075888;
	bh=LMM7TuS5hAf1w8ZzZUH0GziAYhZkQvCa7eayiPmWRx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=izftSFn+DzJ0u7ZAB59+401gzH3muVUYFWXej5WX+zcWVFEmk6sljhutT6vWFT/yH
	 mURlO3+LonYgltU/xL1LYIeHDcC9qXTc/RJW7PaHkPbq9gGGmQfONErihYvLtEmczx
	 Y6ztULXRiUfUUvb2hK/t7xKazYn443ndL06lZ+zU=
Date: Wed, 16 Oct 2024 12:51:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH RESEND] vdpa: solidrun: Fix UB bug with devres
Message-ID: <2024101627-tacking-foothill-cdf9@gregkh>
References: <20241016072553.8891-2-pstanner@redhat.com>
 <Zw-CqayFcWzOwci_@smile.fi.intel.com>
 <17b0528bb7e7c31a89913b0d53cc174ba0c26ea4.camel@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17b0528bb7e7c31a89913b0d53cc174ba0c26ea4.camel@redhat.com>

On Wed, Oct 16, 2024 at 11:22:48AM +0200, Philipp Stanner wrote:
> On Wed, 2024-10-16 at 12:08 +0300, Andy Shevchenko wrote:
> > On Wed, Oct 16, 2024 at 09:25:54AM +0200, Philipp Stanner wrote:
> > > In psnet_open_pf_bar() and snet_open_vf_bar() a string later passed
> > > to
> > > pcim_iomap_regions() is placed on the stack. Neither
> > > pcim_iomap_regions() nor the functions it calls copy that string.
> > > 
> > > Should the string later ever be used, this, consequently, causes
> > > undefined behavior since the stack frame will by then have
> > > disappeared.
> > > 
> > > Fix the bug by allocating the strings on the heap through
> > > devm_kasprintf().
> > 
> > > ---
> > 
> > I haven't found the reason for resending. Can you elaborate here?
> 
> Impatience ;p
> 
> This is not a v2.
> 
> I mean, it's a bug, easy to fix and merge [and it's blocking my other
> PCI work, *cough*]. Should contributors wait longer than 8 days until
> resending in your opinion?

2 weeks is normally the expected response time, but each subsystem might
have other time limites, the documentation should show those that do.

While you wait, take the time to review other pending patches for that
maintainer, that will ensure that your patches move to the top as they
will be the only ones remaining.

thanks,

greg k-h

