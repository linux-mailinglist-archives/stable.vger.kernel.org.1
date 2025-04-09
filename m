Return-Path: <stable+bounces-131919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC82A822A2
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 12:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B344A863B
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 10:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32A025DB17;
	Wed,  9 Apr 2025 10:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mzcYAHgI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697752566F3;
	Wed,  9 Apr 2025 10:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744195617; cv=none; b=gvgILeVZaUGNJwuUI40JVDMfSvUHoHpc7XGrb+sKlyncqjPxoY00T8zlPC5VJV1ZjezfSJplJ6T7fX1H53JmduYVJrnON2+/SXzYj5952rEnYImL/zSvca4Hpi6hWSiaXmS9ZdvBvxHNZi+sJo3IaTL4OjHcIBm32F97Es/O24k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744195617; c=relaxed/simple;
	bh=IOcIpFE6jTQjeFrOWgbckjiDdf9pdeuZRXCDxYjN5eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2nHNRB6rg9IUa9jUW58Ud1x46Uz44EUTww6DyA9PfvuZ10YFdB8NZotJufqyPHsOK8JqJ6WbV6IRSZNa3f53+zNT31rtyyxN3cFqnrGm08gAYl/wiJX0VHKl5gUIpSSx+PMEA4mcqVlRDWMRDq5NrDgiyjX7aobXgBdO6WCVhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mzcYAHgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54656C4CEE7;
	Wed,  9 Apr 2025 10:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744195616;
	bh=IOcIpFE6jTQjeFrOWgbckjiDdf9pdeuZRXCDxYjN5eA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mzcYAHgIthAWVKOkYgOqgl96brwdu2acWnmnzdXnhZdo0K4y8rWbVuifob9+YLlfF
	 7fti74uImyojXfkkb5XpEK2bUShTsJ38kSzOKIZjtoTdVmcWa73/+gWAuEsiJJrN5O
	 5pXijL32f8Q+oCoUFfgnz6DTNLPwMw5NN/f8fTNQ=
Date: Wed, 9 Apr 2025 12:45:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Florian Fainelli <f.fainelli@gmail.com>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	Justin Forbes <jforbes@redhat.com>,
	Dmitry Vyukov <dvyukov@google.com>, namhyung@kernel.org,
	irogers@google.com, acme@kernel.org, ak@linux.intel.com
Subject: Re: [PATCH 6.14 000/728] 6.14.2-rc3 review
Message-ID: <2025040902-shimmer-anchor-0019@gregkh>
References: <20250408195232.204375459@linuxfoundation.org>
 <929581ef-cc54-4619-8f4d-0e0f3369a38c@gmail.com>
 <1de4a315-1855-4eba-9bfe-d61018be5705@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1de4a315-1855-4eba-9bfe-d61018be5705@leemhuis.info>

On Wed, Apr 09, 2025 at 09:09:02AM +0200, Thorsten Leemhuis wrote:
> On 09.04.25 01:05, Florian Fainelli wrote:
> > On 4/8/25 12:55, Greg Kroah-Hartman wrote:
> >> This is the start of the stable review cycle for the 6.14.2 release.
> >> There are 728 patches in this series, all will be posted as a response
> >> to this one.  If anyone has any issues with these being applied, please
> >> let me know.
> > 
> > perf fails to build with:
> > 
> > util/hist.c: In function '__hists__add_entry':
> > util/hist.c:745:37: error: 'struct addr_location' has no member named
> > 'parallelism'
> >   745 |                 .parallelism    = al->parallelism,
> >       |                                     ^~
> > make[6]: *** [/local/users/fainelli/buildroot/output/arm64/build/linux-
> > custom/tools/build/Makefile.build:86: /local/users/fainelli/buildroot/
> > output/arm64/build/linux-custom/tools/perf/util/hist.o] Error 1
> 
> Same here. From a quick look and test-compile it seems that the patch
> "perf report: Add parallelism sort key" that is included in this rc
> depends on f13bc61b2e3795 ("perf report: Add machine parallelism").
> 
> The former is 2/7 of a series, where the latter is 1/7 (
> https://lore.kernel.org/all/0f8c1b8eb12619029e31b3d5c0346f4616a5aeda.1739437531.git.dvyukov@google.com/
> )

Thanks, now dropped, and I've verified that this fixes the build issue.
I'll do a new -rc round in a bit.

thanks for testing!

greg k-h

