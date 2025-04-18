Return-Path: <stable+bounces-134589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5753A93765
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 14:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15353466DB7
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 12:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B232749FD;
	Fri, 18 Apr 2025 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hT1FhWO0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951A9111AD;
	Fri, 18 Apr 2025 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744980462; cv=none; b=lUpeuWwX0XOE1M4isZeGs8PFqyZYuREo9k3sY+EcGPYt3ejCFtWHNpTHksCQE8xP+wHJ4Xxdfl8kAZ5nkKCaTX+vALTAHZ68ZF9Z2Pj+fsHTSYDmFWds8X1hkuAdHUpxtde9gW4o2kc2X1QuRA8cjJ6OQHk9uoJU4e49TWTyzmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744980462; c=relaxed/simple;
	bh=AKYSGSUPyGIy8xIEhLwCfNdUR+vWKRQk1g6IgWAJC00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxpOprGDG/dUfPhRhMMFx28sgh3DXMCccz0griIdsfQQ7HyHdFFHASDVqdBUQNLWPhuVpxKGhD4GsGCo3gq8GyOKiJC/deX/1J1/AepMXv4dMNGgPEbYHmDWBU6ox27e0KpuE0SWsAd81azJaZZCFww7irm5qCLslbiMmgGOwDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hT1FhWO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64554C4CEE2;
	Fri, 18 Apr 2025 12:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744980462;
	bh=AKYSGSUPyGIy8xIEhLwCfNdUR+vWKRQk1g6IgWAJC00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hT1FhWO0M9WV4ZUPGM27RWRcxXZ3smE4KawuKuuP656odzxEs8QznRVffmfzmZqUW
	 Fp/gOl7WkSUt+fFdMBH1j/nmL9aDgPiYt/PE5LfR6jeKpMFb3LWCRuPdZP3FZW+RCc
	 VxJb3481+2mj2vkKAg/PQY37/1K0X/rKjbT1rrDQ=
Date: Fri, 18 Apr 2025 14:47:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>, stable <stable@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Sandipan Das <sandipan.das@amd.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/cpu/amd: Fix workaround for erratum 1054
Message-ID: <2025041819-harsh-outreach-dd6d@gregkh>
References: <174495817953.31282.5641497960291856424.tip-bot2@tip-bot2>
 <20250418104013.GAaAIsDW2skB12L-nm@renoirsky.local>
 <aAJBgCjGpvyI43E3@gmail.com>
 <20250418123713.GCaAJHedTC_JWN__Td@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418123713.GCaAJHedTC_JWN__Td@fat_crate.local>

On Fri, Apr 18, 2025 at 02:37:13PM +0200, Borislav Petkov wrote:
> On Fri, Apr 18, 2025 at 02:11:44PM +0200, Ingo Molnar wrote:
> > No, it doesn't really 'need' a stable tag, it has a Fixes tag already, 
> > which gets processed by the -stable team.

NOOOOOO!!!!

> Last time I asked Greg, he said they scan for those tags but it doesn't hurt
> to Cc stable as it helps.
> 
> Greg?

Fixes: is a "best effort if we get around to it because a maintainer
forgot to put an actual cc: stable tag on it".

As the documentation has stated, since the start of the stable kernel
tree work, use a cc: stable tag if you want it to go to a stable tree.
Fixes came years later and we are forced to dig through them
occasionally because people forget.  But you do NOT get a FAILED email
if the commit does not apply to a stable tree, and sometimes we just
ignore them entirely if we are busy with other stuff.

So please ALWAYS use cc: stable@ on patches you know you want to be
applied to stable trees.  Use the Fixes: tag to tell us how far back to
backport them.  That's it.  Use both.

thanks,

greg k-h

