Return-Path: <stable+bounces-35951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D75898BAB
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 17:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B4B5B22740
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 15:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95991129A7E;
	Thu,  4 Apr 2024 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bPuMzCjp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547AE1D531
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246240; cv=none; b=qD+vjomuaWhLD+GIVgXgTfVbko30vZZArya4lWQtSyvZWXco5GujvaIA1+aHlyhNCigueTRsf5Q3U+s+4UCqqFrEQME2M6qyA50ovfF88DKqeCfEYZkHQ0+7AsegM69OntBdXUQmf1PpeZLPKr19Z7YPTZ53EbKqjFgffoJ2qMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246240; c=relaxed/simple;
	bh=2ttHn8xude/WPreacceneDXtCs17/hvNpTuijvZT1Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lxj353cLuWFP1b0BfL0MbdtHCof4jTLuOgFMxNY6IfZ8eTCHUMVHiBU6XhQXJZlPHUmHHVxqukfeEgA2Z51tCRA8/B9H3CAzVgqvD669Tl1H1g0UnskCMOlJoobXTKg8InVIIFxYpt1pI3TpbocWTVcUjJu5akp3EIpQCh11wKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bPuMzCjp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507AFC433C7;
	Thu,  4 Apr 2024 15:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712246239;
	bh=2ttHn8xude/WPreacceneDXtCs17/hvNpTuijvZT1Ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bPuMzCjpUAYjAerFx7CkzAZ8kETr3nSN9VTWTapH+T7wkIx6DINr7GSbZWFHo2bvC
	 NgwyM09xVhFGl6RYGcUxM/+L0npkonUM/4GBcXN6jDXCa7DOTbhCkWPel6Nj7AwPB3
	 YFEspmRyMA1jzI3ApuszxfC9Nnvo4KHMSREYrB68=
Date: Thu, 4 Apr 2024 17:57:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wolfgang Walter <linux@stwm.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org
Subject: Re: stable v6.6.24 regression: boot fails: bisected to "x86/mpparse:
 Register APIC address only once"
Message-ID: <2024040445-promotion-lumpiness-c6c8@gregkh>
References: <23da7f59519df267035b204622d32770@stwm.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23da7f59519df267035b204622d32770@stwm.de>

On Thu, Apr 04, 2024 at 02:07:11PM +0200, Wolfgang Walter wrote:
> Hello,
> 
> after upgrading to v6.6.24 from v6.6.23 some old boxes (i686; Intel Celeron
> M) stop to boot:
> 
> They hang after:
> 
> Decompressing Linux... Parsing ELF... No relocation needed... done.
> Booting the kernel (entry_offset: 0x00000000).
> 
> After some minutes they reboot.
> 
> I bisected this down to
> 
> commit bebb5af001dc6cb4f505bb21c4d5e2efbdc112e2
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Fri Mar 22 19:56:39 2024 +0100
> 
>     x86/mpparse: Register APIC address only once
> 
>     [ Upstream commit f2208aa12c27bfada3c15c550c03ca81d42dcac2 ]
> 
>     The APIC address is registered twice. First during the early detection
> and
>     afterwards when actually scanning the table for APIC IDs. The APIC and
>     topology core warn about the second attempt.
> 
>     Restrict it to the early detection call.
> 
>     Fixes: 81287ad65da5 ("x86/apic: Sanitize APIC address setup")
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>     Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>     Tested-by: Guenter Roeck <linux@roeck-us.net>
>     Link: https://lore.kernel.org/r/20240322185305.297774848@linutronix.de
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> 
> Reverting this commit in v6.6.24 solves the problem.

Is this also an issue in 6.9-rc1 or newer or 6.8.3 or newer?

thanks,

greg k-h

