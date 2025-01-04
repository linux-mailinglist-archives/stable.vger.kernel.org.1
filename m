Return-Path: <stable+bounces-106746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9484CA01333
	for <lists+stable@lfdr.de>; Sat,  4 Jan 2025 09:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE141640FB
	for <lists+stable@lfdr.de>; Sat,  4 Jan 2025 08:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556C414B965;
	Sat,  4 Jan 2025 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rSLzimBa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45712594A0;
	Sat,  4 Jan 2025 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735977987; cv=none; b=ZUWz1GjA2wkHdNzJupzwmzwXRHezgV/0iAgAPM8oa3MoiauHPsIIf+yDSrPktOVG5fIxzjlGmJ9xHxw4cgA4vaEUIbFfOVIxkrFkZK2aEjbDbIFplRkD+fbO3S8bqTyK834gFJvGNgN+9lFSoq0F0QVmCa3QPumCq55GPr1L49o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735977987; c=relaxed/simple;
	bh=kcpsvzeZDmwSZ3Qw6kInJRKMtb4qajqjvAyoEAvI894=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHKLFw2DBT7F5MF9YRxa94YqXG4Iu7R8xV1Mwo2Rqcmi7HAlslOPiF2B9I09svJtkJib7U98owPKcJoaB4Sq0ez29dxGzZb4Jed8drrePX11SExwAkPfkhvVgYDcMXuqzx94ys3sxfWCLcCAcPv7NcohMLMLy65QCt3TuWdIyZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rSLzimBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6967C4CED1;
	Sat,  4 Jan 2025 08:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735977986;
	bh=kcpsvzeZDmwSZ3Qw6kInJRKMtb4qajqjvAyoEAvI894=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rSLzimBaVSCddzRt2tQgXWTQVLgagzz1BcjFZUG9lrsXLAlG3sij4tDlAIaUSqqBu
	 kiVnumL5ZhXpQci1+iru4AwO20uTk8bVBvUprb5VQGFt2ObTl7HH7SfSj2WgyMoeXQ
	 eO2qO7Zcx6hztOkdjAd8LHXzYK5ug55mOgHaEFA8=
Date: Sat, 4 Jan 2025 09:05:37 +0100
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
Message-ID: <2025010457-runaround-wriggly-d117@gregkh>
References: <20250103004519.474274-1-sashal@kernel.org>
 <CADrjBPo_oiqboE4jAemR_2AjxJtSgMLpS8_ShWcX8wJLB4rszg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrjBPo_oiqboE4jAemR_2AjxJtSgMLpS8_ShWcX8wJLB4rszg@mail.gmail.com>

On Fri, Jan 03, 2025 at 04:46:54PM +0000, Peter Griffin wrote:
> Hi Sasha,
> 
> + cc stable@vger.kernel.org
> 
> On Fri, 3 Jan 2025 at 00:45, Sasha Levin <sashal@kernel.org> wrote:
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     watchdog: s3c2410_wdt: use exynos_get_pmu_regmap_by_phandle() for PMU regs
> >
> > to the 6.6-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      watchdog-s3c2410_wdt-use-exynos_get_pmu_regmap_by_ph.patch
> > and it can be found in the queue-6.6 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> It doesn't make sense (to me at least) to add this patch and then also
> add the revert of it to v6.6 stable tree, as it becomes a no-op. The
> only reason I can think of is it somehow helps with your automated
> tooling?

This is exactly the reason.

> Additionally the hardware (Pixel 6 & gs101 SoC ) which these patches
> and APIs were added for wasn't merged until v6.8. The revert is also
> only applicable if the kernel has the corresponding enhancements made
> to syscon driver to register custom regmaps. See 769cb63166d9 ("mfd:
> syscon: Add of_syscon_register_regmap() API")

Ok, then we should just drop both, I can do that if you want me to.

thanks,

greg k-h

