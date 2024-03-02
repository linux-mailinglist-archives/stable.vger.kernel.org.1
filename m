Return-Path: <stable+bounces-25767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8105A86EF10
	for <lists+stable@lfdr.de>; Sat,  2 Mar 2024 08:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9F2285FC0
	for <lists+stable@lfdr.de>; Sat,  2 Mar 2024 07:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AA911720;
	Sat,  2 Mar 2024 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vDFoaSIZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BCBF514;
	Sat,  2 Mar 2024 07:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709363694; cv=none; b=Q63GyJ5JM8s5fdKGlvrk1WqVlPBxXNTeS6yg11jFsaQpxTmn8ODGtj55rCSXDdGXOq+29U/FjkXhZ7mrr8f92wL1hArY3aZ018k6/VPhcE3zIsj6mkyd3WnRD/dtCEucz1sMVRuTNlgAUh7+2a1drCwL5P1j0PDNfWeVFtLVKJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709363694; c=relaxed/simple;
	bh=vFkpvM0g5EOnQLmxSX0lgm6nc5JPRL6Z+CveFrHCpCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLjxvrbtVrWd26R5H5OMb8o0MyhHfxpFHvMoRfhI2ULyLB9IVg5MxD9i+1ayNMONVtb4kbVu5wef1aXW7JL+KfuwQSGTE6BRj1CItOKqxxID4lUMf1raDM7WxfNVg3r+Rx2UbgE5lO9qUwZ4mMUF4gfDdB4FGadoN66szSeFyhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vDFoaSIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2982CC433C7;
	Sat,  2 Mar 2024 07:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709363693;
	bh=vFkpvM0g5EOnQLmxSX0lgm6nc5JPRL6Z+CveFrHCpCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vDFoaSIZG0ldzdMqErhMs/Us8QduILpmVRnA+9jhiZtksxpNkcmjAbyivevQ6q9oF
	 ppkFVXP4U8+iir8IvgqHOnbGY2mL6in4g9uwBD7anzo9/yvuHcs3R2wphFvlAIDft3
	 JYWHapFWLRq5dUE8LqaSisP2dio7j88LGD7O2P/k=
Date: Sat, 2 Mar 2024 08:14:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Chris Yokum <linux-usb@mail.totalphase.com>, stable@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: 6.5.0 broke XHCI URB submissions for count >512
Message-ID: <2024030246-wife-detoxify-08c0@gregkh>
References: <949223224.833962.1709339266739.JavaMail.zimbra@totalphase.com>
 <50f3ca53-40e3-41f2-8f7a-7ad07c681eea@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50f3ca53-40e3-41f2-8f7a-7ad07c681eea@leemhuis.info>

On Sat, Mar 02, 2024 at 07:53:12AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> [adding the people involved in developing and applying the culprit to
> the list of recipients]
> 
> Hi! Thx for the report.
> 
> On 02.03.24 01:27, Chris Yokum wrote:
> > We have found a regression bug, where more than 512 URBs cannot be
> > reliably submitted to XHCI. URBs beyond that return 0x00 instead of
> > valid data in the buffer.

You mean 512 outstanding URBS that are not completed?  What in-kernel
driver does this?

> > Our software works reliably on kernel versions through 6.4.x and fails
> > on versions 6.5, 6.6, 6.7, and 6.8.0-rc6. This was discovered when
> > Ubuntu recently updated their latest kernel package to version 6.5.
> > 
> > The issue is limited to the XHCI driver and appears to be isolated to
> > this specific commit:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb?h=v6.5&id=f5af638f0609af889f15c700c60b93c06cc76675 <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb?h=v6.5&id=f5af638f0609af889f15c700c60b93c06cc76675>
> 
> FWIW, that's f5af638f0609af ("xhci: Fix transfer ring expansion size
> calculation") [v6.5-rc1] from Mathias.
> 
> > Attached is a test program that demonstrates the problem. We used a few
> > different USB-to-Serial adapters with no driver installed as a
> > convenient way to reproduce. We check the TRB debug information before
> > and after to verify the actual number of allocated TRBs.

Ah, so this is just through usbfs?

> > With some adapters on unaffected kernels, the TRB map gets expanded
> > correctly. This directly corresponds to correct functional behavior. On
> > affected kernels, the TRB ring does not expand, and our functional tests
> > also will fail.
> > 
> > We don't know exactly why this happens. Some adapters do work correctly,
> > so there seems to also be some subtle problem that was being masked by
> > the liberal expansion of the TRB ring in older kernels. We also saw on
> > one system that the TRB expansion did work correctly with one particular
> > adapter. However, on all systems at least two adapters did exhibit the
> > problem and fail.

Any chance you can provide the 'lspci' output for the controllers that
work and those that do not?

thanks,

greg k-h

