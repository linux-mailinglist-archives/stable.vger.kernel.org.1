Return-Path: <stable+bounces-86516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6032C9A0DA7
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 17:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3841F23F43
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 15:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAC620E03C;
	Wed, 16 Oct 2024 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PDbirnB/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED07354F95;
	Wed, 16 Oct 2024 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091321; cv=none; b=VwZEGxr+vZcwxJ40S/80yOAmb3bgdgylcqa8BnL69r2w4K4lq5BcfILlJ3gBkEa8+yctFsNw/PtuNxDcDkQoufQ2j8QM/dL5B3x54sR/iJ+/31Sy0HuFEs7VHza/rm40viYp/HDRg7iUPqhNhIdYWvvqv2A79rU4pRC+Ojx8xjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091321; c=relaxed/simple;
	bh=c+h6z8KA0p7DWiCCHGOMlbBC8IvDrobXyQkIgXT35QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpjSlka5Pf008BdZweSegBN//xJM6bdOQJFAggS3vofyon+dwOtrkX9ZsdtuTM0M/96TaAyCvGpmsdEbdy0JsGqIANXBwp/+y/AQVr5dqQlpdRjDJiF9QQewmYvM9+1eRggWfF849ZMOw26fwvRggghb6/SIwGlrxP713ApSiFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PDbirnB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E364FC4CECF;
	Wed, 16 Oct 2024 15:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729091320;
	bh=c+h6z8KA0p7DWiCCHGOMlbBC8IvDrobXyQkIgXT35QU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDbirnB/qsGzmQaEBfBNtZCxM+MSA+4l8kMTCa1cfgZDcOPSmnRdvHU1YoYchNImt
	 Gt75j5v1TAN+89zvxJUbfIcliiqFAdBjDtSX2n2+B8KOfZosRdH2sbUSU2cROxldS0
	 Zj6Jvjv0rYWtzHMa+CHTUPZ5bUV+TKG3ASm3Z3Iw=
Date: Wed, 16 Oct 2024 17:08:37 +0200
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
Message-ID: <2024101617-magazine-buckle-975d@gregkh>
References: <20241016072553.8891-2-pstanner@redhat.com>
 <Zw-CqayFcWzOwci_@smile.fi.intel.com>
 <17b0528bb7e7c31a89913b0d53cc174ba0c26ea4.camel@redhat.com>
 <2024101627-tacking-foothill-cdf9@gregkh>
 <482d0c45ea2121484a85ed9be6a1863b6d39ac1e.camel@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <482d0c45ea2121484a85ed9be6a1863b6d39ac1e.camel@redhat.com>

On Wed, Oct 16, 2024 at 01:16:32PM +0200, Philipp Stanner wrote:
> On Wed, 2024-10-16 at 12:51 +0200, Greg KH wrote:
> > On Wed, Oct 16, 2024 at 11:22:48AM +0200, Philipp Stanner wrote:
> > > On Wed, 2024-10-16 at 12:08 +0300, Andy Shevchenko wrote:
> > > > On Wed, Oct 16, 2024 at 09:25:54AM +0200, Philipp Stanner wrote:
> > > > > In psnet_open_pf_bar() and snet_open_vf_bar() a string later
> > > > > passed
> > > > > to
> > > > > pcim_iomap_regions() is placed on the stack. Neither
> > > > > pcim_iomap_regions() nor the functions it calls copy that
> > > > > string.
> > > > > 
> > > > > Should the string later ever be used, this, consequently,
> > > > > causes
> > > > > undefined behavior since the stack frame will by then have
> > > > > disappeared.
> > > > > 
> > > > > Fix the bug by allocating the strings on the heap through
> > > > > devm_kasprintf().
> > > > 
> > > > > ---
> > > > 
> > > > I haven't found the reason for resending. Can you elaborate here?
> > > 
> > > Impatience ;p
> > > 
> > > This is not a v2.
> > > 
> > > I mean, it's a bug, easy to fix and merge [and it's blocking my
> > > other
> > > PCI work, *cough*]. Should contributors wait longer than 8 days
> > > until
> > > resending in your opinion?
> > 
> > 2 weeks is normally the expected response time, but each subsystem
> > might
> > have other time limites, the documentation should show those that do.
> 
> Where do we document that?

Documentation/process/maintainer-*

> Regarding resend intervals, the official guide line is contradictory:
> "You should receive comments within a few weeks (typically 2-3)" <->
> "Wait for a minimum of one week before resubmitting or pinging
> reviewers" <--> "It’s also ok to resend the patch or the patch series
> after a couple of weeks"
> 
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#don-t-get-discouraged-or-impatient
> 
> 
> We could make the docu more consistent and specify 2 weeks as the
> minimum time.

Trying to tell other people what they are required to do, when you don't
pay them, is going to be a bit difficult :)

Just leave it as-is, and again, take the time to do reviews for the
maintainers you are trying to get patches accepted for.  That's the
simplest way to make forward progress faster.

good luck!

greg k-h

