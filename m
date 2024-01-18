Return-Path: <stable+bounces-11879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBD5831687
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 11:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20F2D1F24249
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 10:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D55620339;
	Thu, 18 Jan 2024 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BweA1x00"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41DD1DFC8
	for <stable@vger.kernel.org>; Thu, 18 Jan 2024 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705572995; cv=none; b=alFfm514JjP2HZ54n6yK6QvG+2NuDWZI3LS6nqCdFKGUHWzRzZd7rSTjuXmlNvJ/Sp7yOlDVUv4gXBBvJ0PoA1dhGoTrku+RqRWD2cfug86YDEQcaXpCEWjKKnO8l0umKd2HHexXAG5IxM6vYLFAMgMAJvoN9e9ZN6lgqgBvBeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705572995; c=relaxed/simple;
	bh=JMbYM00ktv6N3fMPqoMMx6o808pPwvTODFKljmaBcEU=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=Bj05CLIGPm69H/+vlzVpPKU5Sea7GYdBnudWHbZ+wF5qJFW9sr4NuAm5HeKvNAZulhjfjkt5Y+0134gSmVkNYD/Vm9sJHW5H9xZK9lnd/JmDQ9VDjgcrB7IKMFouO4+RPJDAeEnhWLKfFh+CI2MDb2biTxUHqItu3M4T4l1mWuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BweA1x00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24747C433F1;
	Thu, 18 Jan 2024 10:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705572994;
	bh=JMbYM00ktv6N3fMPqoMMx6o808pPwvTODFKljmaBcEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BweA1x002vL10adzB9oGUI6jXdiHopouRWLjoTW3rQ24TZPDD+LD5KZhl9pDBb9Xi
	 x/Z2tbfG3ke4KNsm5Te20bUeiLL0NEtWkXPHA8/2VFNZjDMqlSOQec3C6rvqtL6SY0
	 3i/2KLm3F+Se8BGJAVhUTR1peAthVc8r0n9GLm2Q=
Date: Thu, 18 Jan 2024 11:16:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, kernelci-results@groups.io,
	bot@kernelci.org, stable@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: kernelci/kernelci.org bisection:
 baseline-nfs.bootrr.deferred-probe-empty on at91sam9g20ek
Message-ID: <2024011816-overstate-move-4df8@gregkh>
References: <65a6ca18.170a0220.9f7f3.fa9a@mx.google.com>
 <845b3053-d47b-4717-9665-79b120da133b@sirena.org.uk>
 <2024011716-undocked-external-9eae@gregkh>
 <82cda3d4-2e46-4690-8317-855ca80fd013@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82cda3d4-2e46-4690-8317-855ca80fd013@sirena.org.uk>

On Wed, Jan 17, 2024 at 01:52:59PM +0000, Mark Brown wrote:
> On Wed, Jan 17, 2024 at 06:55:09AM +0100, Greg Kroah-Hartman wrote:
> 
> > This is also in the following kernel releases:
> > 	4.19.240 5.4.191 5.10.113
> > do they also have issues?  Does 6.1 and newer work properly?
> 
> Current kernels work well, I've not had reports generated for the older
> kernels but it's possible they may be forthcoming (the bisection does
> tend to send issues slowly sometimes).
> 
> > And wow, this is old, nice to see it reported, but for a commit that
> > landed in April, 2022?  Does that mean that no one uses this hardware?
> 
> I suspect it's just me, it's in my test lab.  I don't routinely test
> stable (just let KernelCI use it to test stable).
> 
> > I'll be glad to revert, but should I also revert for 4.19.y and 5.4.y
> > and 5.10.y?
> 
> I'd be tempted to, though it's possible it's some other related issue so
> it might be safest to hold off until there's an explicit report.  Up to
> you.

I'll just drop it from 5.15.y for now, thanks!

greg k-h

