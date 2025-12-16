Return-Path: <stable+bounces-202704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4D1CC3273
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68B1030194FC
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D293446A8;
	Tue, 16 Dec 2025 13:22:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B30930F53E;
	Tue, 16 Dec 2025 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765891356; cv=none; b=MPHlJefX8kYzoFSnU0aoRpZelOAtzbQyRld5lAVuVAk1VPF+jdPLv9sI8HjtE2k3t4ZSASGzOPfKqWIH4MvVktA+NJNELz2K94fnarPeDGRZB6VRhHGmUceJNwRhuijAbEQBqC8Xt+fdbIpSIhEIMJtSBQPvxJ2OJOUATxUz3f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765891356; c=relaxed/simple;
	bh=wH/aVn9+Q8vThXFEdH0M7Vymv0LhRJTDyb/XPKoFDLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxQOczlaIOm7bHLmqdouQeyu02OL6BKQggexDlmyttphO0rBkCj9yKd3zajujRoKCybx/64yQKsAPS8fLTAehqBibAOrVv/7OsY//dkpTFi8Kbdi6NYYeI6ZpY1DI6e3pkO/Hgql2kAzNTMUd4mZgLAz+5U5VCEyBsjoky5wxac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Tue, 16 Dec 2025 14:22:19 +0100
From: Brett A C Sheffield <bacs@librecast.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.17 000/507] 6.17.13-rc1 review
Message-ID: <aUFdC-43_t-Efvyw@karahi.gladserv.com>
References: <20251216111345.522190956@linuxfoundation.org>
 <aUFMIK_av7G3aKui@auntie>
 <2025121634-lurk-angular-5d99@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025121634-lurk-angular-5d99@gregkh>

On 2025-12-16 13:17, Greg Kroah-Hartman wrote:
> On Tue, Dec 16, 2025 at 12:10:08PM +0000, Brett A C Sheffield wrote:
> > On 2025-12-16 12:07, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 6.17.13 release.
> > > There are 507 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Thu, 18 Dec 2025 11:12:22 +0000.
> > > Anything received after that time might be too late.
> > 
> > git has 6.17.13-rc2 not rc1 ?
> 
> Yes, -rc2 is now out, I forgot to drop a patch for -rc1.

Ah - the rc2 email hadn't hit the list when I last looked. Thanks.

Brett

