Return-Path: <stable+bounces-116532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C595FA37BED
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 08:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0C31881E9E
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 07:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D37E18E368;
	Mon, 17 Feb 2025 07:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="phsBZCK3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9445C28F3;
	Mon, 17 Feb 2025 07:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739776711; cv=none; b=tSuJlH4CtzMU8ypWecE3vYtjxL1pXfdhA7jLNmwl5si/tcRvZojPNklHi9LWWfeLQfDN5iyxf0qHSIk0uHoQ/3HWuqNoZA1kCp/is+2X1Tq29OmEFkuTlxW/1QFUJQ3uOQbTxo+i10pGDw9F2Hq4ardrUMMqiubSJ/G5JirRyvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739776711; c=relaxed/simple;
	bh=sh5FIjgP0OebQNM9ApSdqVVcR4R/4BcLAMHqsAmbXjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCdpr5B4SBn4la1lY4DiTkFs1Nlrjwu9KTGHk8Tw/JNCgG2xv5AvKCgc/3nrUYvjhQydh+bspmmXQkaJUO4Pjo252npoTCuY/4s9XlIgVvpaeHIycYm0PVx5EQro5PWy6HuXxwe3CD1hZs/2TtKComu1gEklBo4pn3vW5NxnKeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=phsBZCK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76766C4CED1;
	Mon, 17 Feb 2025 07:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739776711;
	bh=sh5FIjgP0OebQNM9ApSdqVVcR4R/4BcLAMHqsAmbXjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=phsBZCK3kYS/czvkzJdRE+CsqYrVv8oiZjpnd6fQ1uvcWLEFLIbvnXrZtnvUrfmiY
	 2xzTg8iwdWpHlbL9zdewMu8CHGaY18QWxXVid8SxYJ3lY6TyFwz0ucl8y8lhZEyTX6
	 ruPk/T/3Xi1zMqtcI2/JqqA9IanMKxX8klLKSVeA=
Date: Mon, 17 Feb 2025 08:17:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
Cc: mathias.nyman@intel.com, WeitaoWang-oc@zhaoxin.com,
	Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	h10.kim@samsung.com, eomji.oh@samsung.com, alim.akhtar@samsung.com,
	thiagu.r@samsung.com, muhammed.ali@samsung.com,
	pritam.sutar@samsung.com, cpgs@samsung.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: xhci: Fix unassigned variable 'bcdUSB' in
 xhci_create_usb3x_bos_desc()
Message-ID: <2025021701-cofounder-flock-2165@gregkh>
References: <20250213042130.858-1-selvarasu.g@samsung.com>
 <CGME20250213042240epcas5p3c1ac4f97ebf36054abdccc962329273d@epcas5p3.samsung.com>
 <158453976.61739422383216.JavaMail.epsvc@epcpadp2new>
 <2025021402-cruelty-dumpster-57cc@gregkh>
 <1997287019.61739775783590.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1997287019.61739775783590.JavaMail.epsvc@epcpadp2new>

On Mon, Feb 17, 2025 at 12:19:51PM +0530, Selvarasu Ganesan wrote:
> 
> On 2/14/2025 1:35 PM, Greg KH wrote:
> > On Thu, Feb 13, 2025 at 09:51:26AM +0530, Selvarasu Ganesan wrote:
> >> Fix the following smatch error:
> >> drivers/usb/host/xhci-hub.c:71 xhci_create_usb3x_bos_desc() error: unassigned variable 'bcdUSB'
> > That really doesn't say what is happening here at all.  Please provide a
> > lot more information as the response from a tool could, or could not, be
> > a real issue, how are we supposed to know?
> >
> > And "unassigned" really isn't the bug that is being fixed here, please
> > describe it better.
> >
> > Same for patch 2 of the series.
> >
> > Also, your 0/2 email was not threaded with these patches, something odd
> > happened in your email setup, you might want to look into that.
> >
> > thanks,
> >
> > greg k-h
> >
> 
> Hi Greg,
> 
> I understand your concern about whether the response from the tool could 
> be a real issue or not. However, please check the provided code, I 
> believe there is an issue worth considering.

I am not disagreeing that this is a real issue that should be fixed (but
confused as to why the normal compilers are not catching this, which
implies that maybe it never can actually be hit).

So please fix up your changelog text and I will be glad to review it.

thanks,

greg k-h

