Return-Path: <stable+bounces-176591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E427B39A96
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 12:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFBD016C3B6
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 10:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D1B30C616;
	Thu, 28 Aug 2025 10:46:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2780830CD97;
	Thu, 28 Aug 2025 10:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378016; cv=none; b=afUxUzHuOXRLB3UBMoTZypwELrX1cbcMDnfGE3KtlgR1YyyuTGDbljtT8rJm6TXoC5oNEaoiBV/vbSUywGszzZBsCqGtRoWSY1gHr4Cl091Ht1wHCl0J7Lru59dUl8/9kosxPh/MmynChQBekClBMeqRIjaoRPXFMQ998f16Q4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378016; c=relaxed/simple;
	bh=Qt3ur/feN79Jra+e2eSs6lpI2aCEF1KdyFPdBG0Sj/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0dj58G4tOgJkcvAcoHijQpqiXCZHs8kGuDbpovj7wy8qsKn/lGwTJHa4NEqWKlRSXXLYIQl5jwn9JtEiIxV18JNxGy2GAe4GhFKx8v6n2UdghFWm/mRTKX19D/eh7bxwRL9SGQOUrrmk2gdYziY1dD+KVLf2ck32eJ1uk5Jsa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Thu, 28 Aug 2025 10:46:42 +0000
From: Brett A C Sheffield <bacs@librecast.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, netdev@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	oscmaes92@gmail.com, kuba@kernel.org
Subject: Re: [REGRESSION][BISECTED][PATCH] net: ipv4: fix regression in
 broadcast routes
Message-ID: <aLAzki2ObTlTfSZd@auntie>
References: <202508281637.f1c00f73-lkp@intel.com>
 <7090d5ae-c598-4db5-a051-b31720a27746@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7090d5ae-c598-4db5-a051-b31720a27746@redhat.com>

On 2025-08-28 12:35, Paolo Abeni wrote:
> On 8/28/25 10:17 AM, kernel test robot wrote:
> > commit: a1b445e1dcd6ee9682d77347faf3545b53354d71 ("[REGRESSION][BISECTED][PATCH] net: ipv4: fix regression in broadcast routes")
> > url: https://github.com/intel-lab-lkp/linux/commits/Brett-A-C-Sheffield/net-ipv4-fix-regression-in-broadcast-routes/20250825-181407
> > patch link: https://lore.kernel.org/all/20250822165231.4353-4-bacs@librecast.net/
> > patch subject: [REGRESSION][BISECTED][PATCH] net: ipv4: fix regression in broadcast routes
> > 
> > in testcase: trinity
> > version: trinity-x86_64-ba2360ed-1_20241228
> > with following parameters:
> > 
> > 	runtime: 300s
> > 	group: group-04
> > 	nr_groups: 5
> > 
> > 
> > 
> > config: x86_64-randconfig-104-20250826
> > compiler: clang-20
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> Since I just merged v3 of the mentioned patch and I'm wrapping the PR
> for Linus, the above scared me more than a bit.
> 
> AFAICS the issue reported here is the  unconditional 'fi' dereference
> spotted and fixed during code review, so no real problem after all.

Correct. Jakub spotted the error, it was fixed in a v2 5 days ago, and has since
been superceded by Oscar's patch, so nothing to worry about.

Is there a way to indicate to bots not to check superceded patches. In this case
I'd have though my v2 would have been a signal? Is there something else I should
have done?

Brett
-- 

