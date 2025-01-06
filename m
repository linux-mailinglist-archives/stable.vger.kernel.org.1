Return-Path: <stable+bounces-106848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC431A026AC
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 14:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC95163EA2
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 13:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F741DD88D;
	Mon,  6 Jan 2025 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iZdOz3T2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C19B1DC9B8;
	Mon,  6 Jan 2025 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736170524; cv=none; b=Tu7xkB+8UwqcxHcpxldrtGOKiiguLqhf9Wqz3wxJGrxEMnMstkEEsvZo0AGBsQiRgcNvHn5rCU1yBz9LvDXAnseYWK4+S0AMJ2BAdFpBmK6FP11jdQ5bSzpkN9SpRlRWBxUXXl/2tqtfgSd3ETEpp9xh9ZPwarTfh4iHxqgWKIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736170524; c=relaxed/simple;
	bh=WfAa6RkLltye8zbU8FTcjrWX8onKgsXfr8uBA+RRqns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPOGcsieuN530pQgcjnKqygO0IFkp0ImYWbn9+hhIsvgebE1P0nceB3JxX2is3FVquOqQQjJKMdIc1/2QAf//VB4XGRSdRwCBhNcJqieHXJwAZWHEt0zRdXj5H1ss5G9LsacB6ClV4zpOhrv47sui4nXpRuym//SlByCbOaelws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iZdOz3T2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF15EC4CEDD;
	Mon,  6 Jan 2025 13:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736170523;
	bh=WfAa6RkLltye8zbU8FTcjrWX8onKgsXfr8uBA+RRqns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZdOz3T24S+adsHPSCysO37tB4Do9A1J0b1v1q6NwKC3WIAvxJflAKAMGQsTQ41hk
	 SSs88ASBxIhZbRXbVtjqB5ggIhZAXu8bUPfov8FQNYaJiXyHT4me5njBVXN0shOOLP
	 ydvpIQW8Qw17GQJ5eFfZGaM7ytS9Kav+EvQJEDCg=
Date: Mon, 6 Jan 2025 14:35:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: Patch "watchdog: s3c2410_wdt: use
 exynos_get_pmu_regmap_by_phandle() for PMU regs" has been added to the
 6.6-stable tree
Message-ID: <2025010616-exemplary-had-8699@gregkh>
References: <20250103004519.474274-1-sashal@kernel.org>
 <CADrjBPo_oiqboE4jAemR_2AjxJtSgMLpS8_ShWcX8wJLB4rszg@mail.gmail.com>
 <2025010457-runaround-wriggly-d117@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025010457-runaround-wriggly-d117@gregkh>

On Sat, Jan 04, 2025 at 09:05:37AM +0100, Greg KH wrote:
> On Fri, Jan 03, 2025 at 04:46:54PM +0000, Peter Griffin wrote:
> > Hi Sasha,
> > 
> > + cc stable@vger.kernel.org
> > 
> > On Fri, 3 Jan 2025 at 00:45, Sasha Levin <sashal@kernel.org> wrote:
> > >
> > > This is a note to let you know that I've just added the patch titled
> > >
> > >     watchdog: s3c2410_wdt: use exynos_get_pmu_regmap_by_phandle() for PMU regs
> > >
> > > to the 6.6-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > >
> > > The filename of the patch is:
> > >      watchdog-s3c2410_wdt-use-exynos_get_pmu_regmap_by_ph.patch
> > > and it can be found in the queue-6.6 subdirectory.
> > >
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > 
> > It doesn't make sense (to me at least) to add this patch and then also
> > add the revert of it to v6.6 stable tree, as it becomes a no-op. The
> > only reason I can think of is it somehow helps with your automated
> > tooling?
> 
> This is exactly the reason.
> 
> > Additionally the hardware (Pixel 6 & gs101 SoC ) which these patches
> > and APIs were added for wasn't merged until v6.8. The revert is also
> > only applicable if the kernel has the corresponding enhancements made
> > to syscon driver to register custom regmaps. See 769cb63166d9 ("mfd:
> > syscon: Add of_syscon_register_regmap() API")
> 
> Ok, then we should just drop both, I can do that if you want me to.

Now dropped.

