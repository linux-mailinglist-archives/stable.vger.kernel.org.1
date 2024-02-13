Return-Path: <stable+bounces-19726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1D78532D4
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 15:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125EE1F22B44
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 14:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA5557330;
	Tue, 13 Feb 2024 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RHB7c8cY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E6957866
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833926; cv=none; b=WZglU+RwEI8oap6h2PFsqywCsInh8WU7hvJCfHZT2I1Vl+3EX0WRL7lC1BVS6+CqTnmpo2U0HxhTqarBMZNRogmT2/Gyk5qsmT9S/+5gcIJGtEm2dlbFPYUv33RO+OdtJPn7egIIYJ2Mln9RovVS7NpGZoi4WLwh8oTKwwNYbFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833926; c=relaxed/simple;
	bh=jf3wVUdQqMFf5WMp1toa6ZOp8OLgH6bQTxHge/35lRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBNZMLSDUX/awAlHwlUyXAaR12It/GSVJljH9ZkI0eYlosoRjlwpUy9KTclW7uO7hUqbHAdaAz/2hiFlkrMUlI/usi/3v/MKwUHogB9ZD1RcTvZeDuF0IuU5lG4sYGD2RWSOc4BZP0rpcEI95Rna77FHjJXX9/PQUy49G3LiRo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RHB7c8cY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27E8C433F1;
	Tue, 13 Feb 2024 14:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707833926;
	bh=jf3wVUdQqMFf5WMp1toa6ZOp8OLgH6bQTxHge/35lRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RHB7c8cYfxwHXXf6hacpY7r5LH6h1a42p13MebwDiSjDZAQi7qFLt9Lf24pR9Ta0n
	 3VtTVkZ5D3eqFZTHWnGXA2Ttq59NXdQrhNXGrRjzbCIKS1BwFIFBPAN30SlV80/1r0
	 psyADuAxHR8L/5IS+esbgeceNC1oJnWz5qukDaF0=
Date: Tue, 13 Feb 2024 15:18:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?Q?Micha=C5=82?= Pecio <michal.pecio@gmail.com>
Cc: mathias.nyman@linux.intel.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] xhci: handle isoc Babble and Buffer
 Overrun events properly" failed to apply to 5.10-stable tree
Message-ID: <2024021322-snitch-pauper-fd9c@gregkh>
References: <2024021308-hardness-undercook-6840@gregkh>
 <20240213143921.25a6f291@foxbook>
 <2024021351-overstay-crisply-f6af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024021351-overstay-crisply-f6af@gregkh>

On Tue, Feb 13, 2024 at 03:17:36PM +0100, Greg KH wrote:
> On Tue, Feb 13, 2024 at 02:39:21PM +0100, Michał Pecio wrote:
> > Hi,
> > 
> > > The patch below does not apply to the 5.10-stable tree.
> > > [...]
> > > From 7c4650ded49e5b88929ecbbb631efb8b0838e811 Mon Sep 17 00:00:00 2001
> > > From: Michal Pecio <michal.pecio@gmail.com>
> > > Date: Thu, 25 Jan 2024 17:27:37 +0200
> > > Subject: [PATCH] xhci: handle isoc Babble and Buffer Overrun events
> > 
> > This patch depends on its parent 5372c65e1311 ("xhci: process isoc TD
> > properly when there was a transaction error mid TD.").
> > 
> > The parent commit appears to be missing from your 5.10 and earlier
> > queues for some reason, hence the breakage.
> 
> That parent commit would not apply to those older kernels (and I had no
> hint that it should go there.)  I've backported it to 5.10.y ok, but 5.4
> and 4.19 were harder.  So if you want both of these in those older
> kernels, please provide working backports and I'll be glad to queue them
> up.

Nope, my 5.10.y backport failed too, so will need working versions for
that tree as well.

thanks,

greg k-h

