Return-Path: <stable+bounces-154751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DF3AE0054
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 10:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C404D176481
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 08:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4F1239E96;
	Thu, 19 Jun 2025 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H4uSQQb5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9EA20A5EC
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750322874; cv=none; b=dG4vl1/x9z4YwWnIgoufBrRJQWrNJWszTcsKrPMUInGEX10oaIf0SyQFzWnJ8zk3UPL2dycuqKNdV/hk42m+Tft2YFv0bi2jZsHawSTEop1FX/9fk18aES60DVk/430wnv69ixoC4j8772WUaWiD7pl5tv3KgNxa6mXcdlLrQxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750322874; c=relaxed/simple;
	bh=F4kewX6KrjRl8k8mghEhlKeYa6pL1Q44VFmqUwTHy+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXclItx9Ssp+R3AGIeld3/bAmRuWLiLwD4CisWIhVCzPGJihap3g7otfUx25gjfXAysTxn68F4GF25FrIshb2Ubz9T0Aigj3wOp+ggrxCgUKBF/c3oFnqh5LQt91tyShbyI0tWO2hHCkEB2WRcNEeSbuBmo/SiG+ZfJI9bGnUDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H4uSQQb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55869C4CEEA;
	Thu, 19 Jun 2025 08:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750322873;
	bh=F4kewX6KrjRl8k8mghEhlKeYa6pL1Q44VFmqUwTHy+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H4uSQQb5JbWSV+gCT7ifqH7Cc+hEcmgmu+6t0MRRBiFA6n1Bf21ORB+tEzG5Ee5ou
	 Xt66yHzgQYAxSWnOBEU/WNYQbILVsjRrTNSbMjGmYOjXK1rJqYRMe9r2eqPz/czdxB
	 r5xOliN4WgRSSVbpdilSE77uroOHi1fdx+Tmlgy0=
Date: Thu, 19 Jun 2025 10:47:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc: Laura Nao <laura.nao@collabora.com>, stable@vger.kernel.org,
	Uday M Bhat <uday.m.bhat@intel.com>
Subject: Re: 5.10 kernel series fails to build on newer toolchain: FAILED
 unresolved symbol filp_close
Message-ID: <2025061926-imminent-fade-30d1@gregkh>
References: <34d5cd2e-1a9e-4898-8528-9e8c2e32b2a4@manjaro.org>
 <20250320112806.332385-1-laura.nao@collabora.com>
 <0e228177-991c-4637-9f06-267f5d4c0382@manjaro.org>
 <2025040121-strongbox-sculptor-15a1@gregkh>
 <722c3acd-6735-4882-a4b1-ed5c75fd4339@manjaro.org>
 <2025060532-cadmium-shaking-833e@gregkh>
 <1faa145a-65eb-4650-a5a1-6e9f9989b73f@manjaro.org>
 <2025061742-underhand-defeat-eb33@gregkh>
 <4c1dcc23-fcbb-4777-8e76-a1da74ac9790@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c1dcc23-fcbb-4777-8e76-a1da74ac9790@manjaro.org>

On Thu, Jun 19, 2025 at 10:34:52AM +0200, Philip Müller wrote:
> On 6/17/25 16:05, Greg KH wrote:
> > Also for the newer kernels, this was only backported to 6.6.y, so
> > anything older than that should need this, right?
> 
> Well, yes. The patches I applied on my end are attached.
> 
> -- 
> Best, Philip

> Commit b3bee1e7c3f2b1b77182302c7b2131c804175870 x86/boot: Compile boot code with -std=gnu11 too
> fixed a build failure when compiling with GCC 15. The same change is required for linux-5.4.292.

Something went wrong with the whitespace here :(

> 
> Signed-off-by: Chris Clayton <chris2553@googlemail.com>
> Modified-by: Philip Mueller <philm@manjaro.org>

You lost the original authorship and signed-off-by lines :(

> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b3bee1e7c3f2b1b77182302c7b2131c804175870

This isn't needed either.

Can you try again?

thanks,

greg k-h

