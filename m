Return-Path: <stable+bounces-35540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6117C894AEE
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 07:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCEFB283A18
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 05:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CBF18050;
	Tue,  2 Apr 2024 05:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q0rT5yX4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819EB323D
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 05:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712036712; cv=none; b=tAU13ep2X6HNzYxsz/j/mmFIBaLVMTebPd7t01NgJ0NbUz5eElbmH0yCslRcQZ+M3Aqtuc+kLTE9nlHMpF3VnBpbJpS9djDiby5E5u0j/vj313mZFBa/6fhewPp3FVa9g0lGxvrJi/qi8HH092/+Hv80wL9WMwBv5GAGw+ki46U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712036712; c=relaxed/simple;
	bh=XyvL3YfexGCf40Z4b7HNBUbFqtksITvuq8OJnDzp5oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KopEWJ6cwRCIWKycdB0ij0b3loA03Y6/1b4f964Ng/YGOUikMEcE9nye9NAkcTI4NDWT0pKTLSowtFuReq9zNXcNq+QFgjxyRZQwSFHRPdq9s4/1ONCRhdlE2MGfR1C7rCfEiql8LpqvNAA/S792Dd5R86/gEV52zj6F8IBtsXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q0rT5yX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23ABC433F1;
	Tue,  2 Apr 2024 05:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712036712;
	bh=XyvL3YfexGCf40Z4b7HNBUbFqtksITvuq8OJnDzp5oA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q0rT5yX4T8xT9ixL96BRSHx1iwaPgK+QGeyqsfHe9LA75xkW6Jh0+k07K3PjSWu3g
	 qHP1rMmJsUhIJE1dPHin8YV9VrqH1Sb1AZQCUV8fCww8Oqez9vK5C4qvRwUcEJxGan
	 YLFNmTOUmpsPtp8FKcoIpMNbc45pI0ZKdFi1oj2A=
Date: Tue, 2 Apr 2024 07:45:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Nguyen, Max" <hphyperxdev@gmail.com>
Cc: stable@vger.kernel.org, Chris Toledanes <chris.toledanes@hp.com>,
	Carl Ng <carl.ng@hp.com>, Max Nguyen <maxwell.nguyen@hp.com>
Subject: Re: [PATCH 1/2] Add additional HyperX IDs to xpad.c on LTS v4.19 to
 v6.1
Message-ID: <2024040230-undivided-illusion-3930@gregkh>
References: <20240315215918.38652-1-hphyperxdev@gmail.com>
 <2024031724-flakily-urchin-eed6@gregkh>
 <fb216446-26d5-4d73-a5f8-faf1ba689c3c@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb216446-26d5-4d73-a5f8-faf1ba689c3c@gmail.com>

On Mon, Apr 01, 2024 at 02:52:24PM -0700, Nguyen, Max wrote:
> 
> On 3/17/2024 12:07 PM, Greg KH wrote:
> > On Fri, Mar 15, 2024 at 02:59:19PM -0700, Max Nguyen wrote:
> > > Add additional HyperX Ids to xpad_device and xpad_table
> > > 
> > > Add to LTS versions 4.19, 5.4, 5.10, 5.15, 6.1
> > > 
> > > Suggested-by: Chris Toledanes <chris.toledanes@hp.com>
> > > Reviewed-by: Carl Ng <carl.ng@hp.com>
> > > Signed-off-by: Max Nguyen <maxwell.nguyen@hp.com>
> > > ---
> > >   drivers/input/joystick/xpad.c | 10 ++++++++--
> > >   1 file changed, 8 insertions(+), 2 deletions(-)
> > <formletter>
> > 
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> > 
> > </formletter>
> 
> Hi Greg,
> Thanks for your help so far.  I am committed to figuring this out so thank you again your patience.  I had a couple questions to confirm before I resubmit.
> 
> I had done option 1 to include in stable when I submitted to mainline.  I saw that my patch was picked up in the latest stable.  Will it be eventually picked up by the older LTS versions?

Depends, did it apply to older LTS versions?  If not, then no.

> I need to add the upstream commit ID to my patches.  I intended to go with option 3 since there is some deviation in my patch from the upstream.  Am I just missing the upstream commit ID and deviation explanation for my patch?

That is a start, yes.  Try it and see!

thanks,

greg k-h

