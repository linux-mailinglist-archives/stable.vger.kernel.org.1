Return-Path: <stable+bounces-109431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F21A15BB8
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 08:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D21C1685C6
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 07:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC370146A69;
	Sat, 18 Jan 2025 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dr45kfLf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7DF39FD9;
	Sat, 18 Jan 2025 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737184808; cv=none; b=JyMftu0szlXAJfX9n+dvreROz8r/SJ+J0UIuFgjxFvW5BFPdhuHD5reOlzdj5ZZzDA3TesoFkNc4lS9Jotqu5BEGOL9MtAug9zyMwVaXZ3hLfLMvWMFRP35QnGvFomrKvScKv6z5W/nBcYFLkoHjpnK0nPTTxzW/D/YACxsOo5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737184808; c=relaxed/simple;
	bh=w9rtuAFz66KV3IfzSPvQ6gtFPJg6HGWMlRljuhnoCmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OF1PjdpLRMDzCG2TIgNubdLmAhUgW6tCog5v/dnDCTNibqkZ/r55tHw5SuPr9jqy5JYlmJvCozM6yQ3AtuGufB5Fxjv0+VNoSL1xQLDqD8Joos5WowuwZzrTENNi7fC3HBtXz945VwW0p7omf3qpjGeldrDzZBxHsqAdnEJMLf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dr45kfLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84389C4CED1;
	Sat, 18 Jan 2025 07:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737184807;
	bh=w9rtuAFz66KV3IfzSPvQ6gtFPJg6HGWMlRljuhnoCmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dr45kfLfrW2sk0zlMC8p0DbOOcTdHbchSNRjK1zudmtzCZGZ1Wpvy2q5M97U/pbGn
	 I5yv/wezOIAifegppWPaGt32BuzItRPzid+CWRw4T6uwzgfxS/Ek1VEPrAxRPS3/ON
	 yJXuBsxunMXLEYgSVX0E6E2GFNMb50dqX+LQ87NI=
Date: Sat, 18 Jan 2025 08:20:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ron Economos <re@w6rz.net>
Cc: Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: 6.1.125 build fail was -- Re: [PATCH 6.1 00/92] 6.1.125-rc1
 review
Message-ID: <2025011851-decidable-managing-eb8b@gregkh>
References: <20250115103547.522503305@linuxfoundation.org>
 <Z4evJUkzHauW+zOU@duo.ucw.cz>
 <Z4e+u8gj6BV37WdM@duo.ucw.cz>
 <2025011725-underdog-heftiness-49df@gregkh>
 <Z4rIlESGC6mwi8HP@duo.ucw.cz>
 <133dbfa0-4a37-4ae0-bb95-1a35f668ec11@w6rz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <133dbfa0-4a37-4ae0-bb95-1a35f668ec11@w6rz.net>

On Fri, Jan 17, 2025 at 10:37:03PM -0800, Ron Economos wrote:
> On 1/17/25 13:16, Pavel Machek wrote:
> > Hi!
> > 
> > > > > Still building, but we already have failures on risc-v.
> > > > > 
> > > > > drivers/usb/core/port.c: In function 'usb_port_shutdown':
> > > > > 2912
> > > > > drivers/usb/core/port.c:417:26: error: 'struct usb_device' has no member named 'port_is_suspended'
> > > > > 2913
> > > > >    417 |         if (udev && !udev->port_is_suspended) {
> > > > > 2914
> > > > >        |                          ^~
> > > > > 2915
> > > > > make[4]: *** [scripts/Makefile.build:250: drivers/usb/core/port.o] Error 1
> > > > > 2916
> > > > > make[4]: *** Waiting for unfinished jobs....
> > > > > 2917
> > > > >    CC      drivers/gpu/drm/radeon/radeon_test.o
> > > > And there's similar failure on x86:
> > > > 
> > > > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1626266073
> > > Thanks for testing and letting me know,
> > Ok, so it seems _this_ failure is fixed... but there's new one. Build
> > failure on risc-v.
> > 
> >    LD      .tmp_vmlinux.kallsyms1
> > 2941
> > riscv64-linux-gnu-ld: drivers/usb/host/xhci-pci.o: in function `xhci_pci_resume':
> > 2942
> > xhci-pci.c:(.text+0xd8c): undefined reference to `xhci_resume'
> > 2943
> > riscv64-linux-gnu-ld: xhci-pci.c:(.text+0xe1a): undefined reference to `xhci_suspend'
> > 2944
> > make[1]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
> > 2945
> > make: *** [Makefile:1250: vmlinux] Error 2
> > 
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/8883180471
> > 
> > (I have also 2 runtime failures, I'm retrying those jobs.
> > 
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1630005263
> > 
> > ). I partly reconsructed To:.
> > 
> > Best regards,
> > 
> > 								Pavel
> 
> Seeing the build failure on RISC-V here also. The fixup patch was a little
> too aggressive. I tried just removing the #ifdef CONFIG_PM around
> "port_is_suspended" in include/linux/usb.h and it builds okay.

Can you send a fix-up patch for this that works for you?

thanks,

greg k-h

