Return-Path: <stable+bounces-98931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B36A79E66FC
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 06:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676341885256
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 05:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1F0194A49;
	Fri,  6 Dec 2024 05:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CjW/LJLp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1743B8F66;
	Fri,  6 Dec 2024 05:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733464069; cv=none; b=RvOdezWdxlVhyyUb11qCKSY8o6ZxNtZTAzb9oslbvw/qMlAqqtS8MHnQIepHEpwKi4RKR/5uTaeNQUgAKrNzZps+ImXWFSZPDl5r1zYTRx7JiqY/XuiceE5BDibR7ymGCXN/NaKILDG5BLfeSWrmVZUEYBCskbOYobGP34J7MWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733464069; c=relaxed/simple;
	bh=Yv6W3mwoErdRg5doMTEF5/q7n5yd6TWPpsEIGNe4PvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iY429XEwAK+agyhnKFGeZ7p21eIAFfqjDhd15bl5gOpgSKYpNCN59QF6DPBxyyUWoPaQRLdifoNWnj5RZynkSbWz336wgn/epafY1PmtVocTXF1HoTYKBLYsfMKpne86W4gj6+7Xzad5d4OmK3XtZTmJlpfVCsO/qL3TV6a1PIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CjW/LJLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405B9C4CED1;
	Fri,  6 Dec 2024 05:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733464068;
	bh=Yv6W3mwoErdRg5doMTEF5/q7n5yd6TWPpsEIGNe4PvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CjW/LJLp5k0L2ZijUmIT3Ctvk1OMPtAtjqSoMZZ/uD+1qSQCbBduqznlaLVdShWcn
	 JkxtkGrPTVqomKyF/dE92PVdYovT2V1qA1LqAVGTDc5armBXjareWaDa+XXPg/B6BQ
	 l2TkeXM7Au6VYYiui7g8deGE36kHsdSEel2qVjhw=
Date: Fri, 6 Dec 2024 06:47:45 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Genes Lists <lists@sapience.com>
Cc: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Linux 6.12.2
Message-ID: <2024120628-repressed-unveiled-1085@gregkh>
References: <2024120529-strained-unbraided-b958@gregkh>
 <bad6ec6fc4e8d43198c0873f2e92d324dc1343eb.camel@sapience.com>
 <01a7263b-3739-582e-aade-6d9d9495500d@applied-asynchrony.com>
 <136fbb7aedc6e3750f8361309609ddf4283cd91d.camel@sapience.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <136fbb7aedc6e3750f8361309609ddf4283cd91d.camel@sapience.com>

On Thu, Dec 05, 2024 at 06:24:36PM -0500, Genes Lists wrote:
> On Fri, 2024-12-06 at 00:07 +0100, Holger Hoffstätte wrote:
> > > 6.12.1 works fine but 6.12.2 generates lots of errors during
> ...
> > 
> > 
> > As Linus has indicated in:
> > https://lore.kernel.org/stable/CAHk-
> > =whGd0dfaJNiWSR60HH5iwxqhUZPDWgHCQd446gH2Wu0yQ@mail.gmail.com/
> > 
> > the problem is the missing commit b23decf8ac91 ("sched: Initialize
> > idle tasks
> > only once"). Applying that on top of 6.12.2 fixes the problem.
> > 
> > We just encountered this issue in Gentoo as well when releasing a new
> > kernel
> > and adding that patch has resolved the issue.
> > 
> > > Thought it best to share before I start to work on bisect....
> 
> > No need to, just add b23decf8ac91 :)
> > 
> > cheers
> > Holger
> > 
> Excellent - missed that completely. 
> I will stop bisecting now, thank you so much.

Sorry about this, I'll go push out a new kernel with this fix in it now.

greg k-h

