Return-Path: <stable+bounces-110294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F624A1A7A8
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 17:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D211663E1
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 16:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E1212FF69;
	Thu, 23 Jan 2025 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WBKtP1WE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FE3328B6;
	Thu, 23 Jan 2025 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737648917; cv=none; b=HcIDaip2ExcPs7yuDXIxBnGr9HrYtiF4h8umlySciPhb9zBZ4ZsAOOl7LPQOuCGITNUxdPiPWXK1jzRCHx5cw/M8Wyijlkf2jxPxKSC7T65Cg5Nf0Amz3ooXgjxUhss3VIJBoC9akdc+bZnXqX7v55CCnPxstv7+BUvCzIt0s0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737648917; c=relaxed/simple;
	bh=ZheSQ6XWBAYsdapP+EdWrfuUmk64oRaRoPYP7mOvu00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mk6D9GPtTECe9vxP+hUqxPbJW+q5qFpa+j/LlgRZk+xSNJWA7RTn1/PLQYyCzAi7Mx7ahYPzrKT8gCcHbNJ5D8uxjMfhL0x8n7XswwqlbdDxX0Ix7d0Yh4olGFN/fG1Yq+JYgRydrsb//H7/OTGWBNYsef4yyRI1TNETXD+ol6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WBKtP1WE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF85C4CED3;
	Thu, 23 Jan 2025 16:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737648914;
	bh=ZheSQ6XWBAYsdapP+EdWrfuUmk64oRaRoPYP7mOvu00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WBKtP1WEAmj6fGypbDot8JLoDo1Leq64kQlnHKoACLAhcKztxpxksIP0jTIJGQ6Ks
	 fMBPfbXZ+ARgqqlukTRzJ0tG0jyF8dqHs8o58XbMBZFL1rZ7l83D+CFul4cPPsBMyg
	 EyH0XAEGfkuEsSeSRU2MZHJqD0TQwcmCtYFxWFY8=
Date: Thu, 23 Jan 2025 17:15:11 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ron Economos <re@w6rz.net>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 5.15 000/127] 5.15.177-rc2 review
Message-ID: <2025012303-shawl-citric-9f5f@gregkh>
References: <20250122073830.779239943@linuxfoundation.org>
 <010553d5-4504-40d9-a358-8404f57ebe9a@w6rz.net>
 <2025012347-storm-dance-adfc@gregkh>
 <65b96357-3c6c-469a-b738-e0576edb958d@w6rz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65b96357-3c6c-469a-b738-e0576edb958d@w6rz.net>

On Thu, Jan 23, 2025 at 06:19:34AM -0800, Ron Economos wrote:
> On 1/23/25 06:11, Greg Kroah-Hartman wrote:
> > On Wed, Jan 22, 2025 at 05:20:54AM -0800, Ron Economos wrote:
> > > On 1/22/25 00:03, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 5.15.177 release.
> > > > There are 127 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Fri, 24 Jan 2025 07:38:04 +0000.
> > > > Anything received after that time might be too late.
> > > > 
> > > > The whole patch series can be found in one patch at:
> > > > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.177-rc2.gz
> > > > or in the git tree and branch at:
> > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > > > and the diffstat can be found below.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > The build fails with:
> > > 
> > > drivers/usb/core/port.c: In function 'usb_port_shutdown':
> > > drivers/usb/core/port.c:299:26: error: 'struct usb_device' has no member
> > > named 'port_is_suspended'
> > >    299 |         if (udev && !udev->port_is_suspended) {
> > >        |                          ^~
> > > make[3]: *** [scripts/Makefile.build:289: drivers/usb/core/port.o] Error 1
> > > make[2]: *** [scripts/Makefile.build:552: drivers/usb/core] Error 2
> > > make[1]: *** [scripts/Makefile.build:552: drivers/usb] Error 2
> > > 
> > > Same issue as with 6.1.125-rc1 last week. Needs the fixup patch in 6.1.126.
> > Ah, ick.  It's hard for me to build with CONFIG_PM disabled here for
> > some reason.  I'll go queue up my fix for this from 6.1, and then your
> > fix for my fix :)
> > 
> > thanks,
> > 
> > greg k-h
> 
> Just FYI, I tested the fixes and it builds okay. I did:
> 
> git cherry-pick 9734fd7a27772016b1f6e31a03258338a219d7d6
> 
> git cherry-pick f6247d3e3f2d34842d3dcec8fe7a792db969c423

Thanks, I've now done that!

greg k-h

