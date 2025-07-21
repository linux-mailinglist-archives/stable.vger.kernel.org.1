Return-Path: <stable+bounces-163589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B47B0C58E
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77AD1692F8
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8A32D0C7E;
	Mon, 21 Jul 2025 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yrC53uRK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9BC28314A;
	Mon, 21 Jul 2025 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753105964; cv=none; b=ge/jYbf8Q4ZnreJ2bu3ys3hTvflxHxPIJuSrktAg4WiPIhm1uBcALlqqGB1ahixLFygnYkaivRPPaTont3vev74RNgXJQmR65fesMqx3DSRCqa5u0XbOmgeoWAtTNV0ny4WZ0ad6u01Y1nys6Y5ARCqWtLp9RtohktK4Rs7ADjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753105964; c=relaxed/simple;
	bh=EuqaPMdPaZqGoMyWwYB78LCRAGY1L8tUf8gvsSR9TiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKDFt+OawVI2AgJ2s717t9jwOKZhSy2CeG6lnLDWGs+IB471nREIjNLjXWJi85gF2DZManm/q3Vc5N5DAxoFTdOZiUHeTzvY7PqZ4lwxUQU+InYzDMgQLQVtQu5Ecq89iVDMc9r0Is6oRxGU5/YynES/e0xPj4ZDWZ7BVWDn3Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yrC53uRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A53BC4CEF9;
	Mon, 21 Jul 2025 13:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753105963;
	bh=EuqaPMdPaZqGoMyWwYB78LCRAGY1L8tUf8gvsSR9TiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yrC53uRKq6pEQ2TXSqY+Fnhc9mEJdnR/OpoqGaKXOqaliVDMDzvMX9/9er7EysoPf
	 Uk2uZKjknfANID6/3qkO+QesqADSTTY1npBjSlRk0stUH/F03UpPOBC7qzs1D//iLO
	 beIOZtsqa9iGumcvSJzWVjKxx4lS7aQxBSNRlYCk=
Date: Mon, 21 Jul 2025 15:52:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: Patch "drm/nouveau: check ioctl command codes better" has been
 added to the 6.15-stable tree
Message-ID: <2025072129-severity-defame-164e@gregkh>
References: <20250721124923.811224-1-sashal@kernel.org>
 <b32c7957-6827-45a5-860b-f28baedd9f60@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b32c7957-6827-45a5-860b-f28baedd9f60@app.fastmail.com>

On Mon, Jul 21, 2025 at 03:14:50PM +0200, Arnd Bergmann wrote:
> On Mon, Jul 21, 2025, at 14:49, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> >
> >     drm/nouveau: check ioctl command codes better
> >
> > to the 6.15-stable tree which can be found at:
> >     
> > http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      drm-nouveau-check-ioctl-command-codes-better.patch
> > and it can be found in the queue-6.15 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> I got a regression report for this patch today, please don't backport
> it yet.

Dropped from both queues, thanks.

greg k-h

