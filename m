Return-Path: <stable+bounces-111208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351BDA22418
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1E747A085E
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882611E0DCC;
	Wed, 29 Jan 2025 18:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sq68vWiz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB2A18FDC5;
	Wed, 29 Jan 2025 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176087; cv=none; b=o2GdABd7zoavPtqvmeVTIc3/5Ysr2Zi81QScv6jhv3c6dSz4I2dQzvEsualIWKJJbceYKjUNa5JjAfSSFA65Qdtue7QzDsmZwf3/1a1cEdFBnb6nTRY3Ha74cSGPvug/2TWOmcspi8Rq3dG/sAktHXCU2eRUIc01h5WaxotIcUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176087; c=relaxed/simple;
	bh=5hxn5iZljywfObaDAbFoAUgvQSBwEmGyxtCxix3eKfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N46xFQUNFBnGE88ZUPBgEiyIWag+jXN0BOdlHzHwet2Niq+rDw1+A8N3Woc07mfBAVvXKCISA/5R2RrI5lYG9O9e7LICAjKL6UlGRJdLxxNXWxFrGTrxtQYlFnILLupyPduxV2VIFGNLoVMCQJ2+AXj65KZLPyavcexOOM+vU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sq68vWiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190DAC4CED1;
	Wed, 29 Jan 2025 18:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738176086;
	bh=5hxn5iZljywfObaDAbFoAUgvQSBwEmGyxtCxix3eKfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sq68vWizLTz/E46jd+nKqx5TgguHufQfdToMDUIa08iDq26xuxq0VWMVmuXm/1Oh1
	 lQttb3h4Aevmwbimu7VfbaRixwg74sivlPkJrcNAuOEcSOpE8QEbEZnjgQ4nrI5jy/
	 8ISGmfS3+UaFNmk+zjMurYBn+8DXwTmlfcmSm8dypdjkltRTZ2fsNXIZdfiZW2vmix
	 uR+0S+2MAc+rg3Jfq02FFlBKGzmLInwwrigNDHQzORV1QxSWl2qTk9cqo1FCgX/eZH
	 53hCCsu26YSSTkJzq4uDA7BYnO0kxqc0mk/kIdb2frFH2KlEgc/DYCbvjUKVt6ZgiP
	 ODTH0QjMjPd4g==
Date: Thu, 30 Jan 2025 00:11:22 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Jan =?utf-8?B?xIxlcm3DoWs=?= <sairon@sairon.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>,
	Michael Zimmermann <sigmaepsilon92@gmail.com>,
	Chukun Pan <amadeus@jmu.edu.cn>, regressions@lists.linux.dev
Subject: Re: [REGRESSION] USB 3 and PCIe broken on rk356x due to missing phy
 reset
Message-ID: <Z5p2Ugfegw5ty0GU@vaman>
References: <20241230154211.711515682@linuxfoundation.org>
 <91993fed-6398-4362-8c62-87beb9ade32b@sairon.cz>
 <2025012925-stammer-certify-68db@gregkh>
 <5040940.GXAFRqVoOG@diego>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5040940.GXAFRqVoOG@diego>

On 29-01-25, 14:55, Heiko Stübner wrote:
> Hi Greg,
> 
> Am Mittwoch, 29. Januar 2025, 14:36:07 CET schrieb Greg Kroah-Hartman:
> > On Wed, Jan 29, 2025 at 02:27:05PM +0100, Jan Čermák wrote:
> > > Hi Greg, everyone,
> > > 
> > > unfortunately, this patch introduced a regression on rk356x boards, as the
> > > current DTS is missing the reset names. This was pointed out in 6.12 series
> > > by Chukun Pan [1], it applies here as well. Real world examples of breakages
> > > are M.2 NVMe on ODROID-M1S [2] and USB 3 ports on ODROID-M1 [3]. This patch
> > > shouldn't have been applied without the device tree change or extra fallback
> > > code, as suggested in the discussion for Chukun's original commits [4].
> > > Version 6.6.74 is still affected by the bug.
> > > 
> > > Regards,
> > > Jan
> > > 
> > > [1]
> > > https://lore.kernel.org/stable/20241231021010.17792-1-amadeus@jmu.edu.cn/
> > > [2] https://github.com/home-assistant/operating-system/issues/3837
> > > [3] https://github.com/home-assistant/operating-system/issues/3841
> > > [4] https://lore.kernel.org/all/20250103033016.79544-1-amadeus@jmu.edu.cn/
> > > 
> > > #regzbot introduced: v6.6.68..v6.6.69
> > 
> > So where should it be reverted from, 6.6.y and 6.12.y?  Or should a
> > different specific commit be backported instead?
> 
> Alternatively, ways forward would be:
> 
> - 6.13 contains the devicetree change, the failing phy-patch
>   requires:
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8b9c12757f919157752646faf3821abf2b7d2a64
> 
> - there is a pending fix to the phy driver that acts as a fallback for
>   old DTs, waiting for phy maintainers coming back from winter-break
>   https://lore.kernel.org/all/20250106100001.1344418-2-amadeus@jmu.edu.cn/

Okay, I will pick and add it in fixes and push up

-- 
~Vinod

