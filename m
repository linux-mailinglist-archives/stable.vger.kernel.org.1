Return-Path: <stable+bounces-206349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7995ED0412F
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6352C34FF27F
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335192DC337;
	Thu,  8 Jan 2026 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MTbavVW2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD49E3D6F1F
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767878597; cv=none; b=cqRhfvNxksrOI6YqHdMvnEbEecGZduajiCQ7o3x9DOQBgdmlebTVTES2cf/tMpCHnM6dP4lohoO+mW1FD0NTn5hctRNDoMZ6NOXxqvu2KHSV/SfNZfDVX3c+HbAQcSTm206dp8uALyHogu1Nvb8TfwwaxnLC4NIJc6lA5pxuvX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767878597; c=relaxed/simple;
	bh=0VVniBlVCpxELfrqm260TmcO8/C54jNjx76bmADaXbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDz2cdBc6GSUvKaqLYfjzOPASFDWsA0CeXREGvdrjovakRFQ6F0acOdmWeqzSSqRqanuIFNF5Q4tuOD8tD/rCCB6SOi53gReJDnruavVM4LaJQb20PQ+JdIsZ8HzZPORkGEBxXFZfMz2UMadJ7HzOKLH2jdbeqld/EFpoml0yS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MTbavVW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44BEC16AAE;
	Thu,  8 Jan 2026 13:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767878595;
	bh=0VVniBlVCpxELfrqm260TmcO8/C54jNjx76bmADaXbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MTbavVW20xnV68QxOYyEZeePV1E6OZub7Wf2YzL0drdqApjMX+boz7H7Wiqw2Xc/Q
	 DptBmvtLuwqDPHWtcnq1vzoNKcSgArYSx6x6KDCvLFTmqzyAfPxIW6ZsFd+hi2jBNn
	 YJPO9c+TggokLhmUUSmN/y1+OHjnVzRWJDivOP7w=
Date: Thu, 8 Jan 2026 14:23:12 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Sasha Levin <sashal@kernel.org>, Thorsten Glaser <tg@mirbsd.de>,
	Helge Deller <deller@kernel.org>, Junjie Cao <junjie.cao@intel.com>,
	Gianluca Renzi <gianlucarenzi@eurek.it>,
	=?iso-8859-1?Q?Camale=F3n?= <noelamac@gmail.com>,
	William Burrow <wbkernel@gmail.com>, 1123750@bugs.debian.org,
	Salvatore Bonaccorso <carnil@debian.org>,
	stable <stable@vger.kernel.org>
Subject: Re: [5.10] regression: virtual consoles 2-12 unusable
Message-ID: <2026010803-gem-puzzle-640d@gregkh>
References: <aUeSb_SicXsVpmHn@eldamar.lan>
 <176626831842.2137.9290349746475307418.reportbug@x61p.mirbsd.org>
 <Pine.BSM.4.64L.2512211617050.3154@herc.mirbsd.org>
 <aU68arLtS1_wZiMj@eldamar.lan>
 <176626831842.2137.9290349746475307418.reportbug@x61p.mirbsd.org>
 <CAN2UaigCW-BZTifuo-ADCw=uDq85A_KwOHcceyaXDnVo8OQZiQ@mail.gmail.com>
 <c5a27a57597c78553bf121d09a1b45ed86dc02a8.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5a27a57597c78553bf121d09a1b45ed86dc02a8.camel@decadent.org.uk>

On Fri, Jan 02, 2026 at 05:26:22PM +0100, Ben Hutchings wrote:
> Hello stable maintainers,
> 
> Several Debian users reported a regression after updating to kernel
> version 5.10.247.
> 
> Commit f0982400648a ("fbdev: Add bounds checking in bit_putcs to fix
> vmalloc-out-of-bounds"), a backport of upstream commit 3637d34b35b2,
> depends on vc_data::vc_font.charcount being initialised correctly.
> 
> However, before commit a1ac250a82a5 ("fbcon: Avoid using FNTCHARCNT()
> and hard-coded built-in font charcount") in 5.11, this member was set
> to 256 for VTs initially created with a built-in font and 0 for VTs
> initially created with a user font.
> 
> Since Debian normally sets a user font before creating VTs 2 and up,
> those additional VTs became unusable.  VT 1 also doesn't work correctly
> if the user font has > 256 characters, and the bounds check is
> ineffective if it has < 256 characters.
> 
> This can be fixed by backporting the following commits from 5.11:
> 
> 7a089ec7d77f console: Delete unused con_font_copy() callback implementations
> 259a252c1f4e console: Delete dummy con_font_set() and con_font_default() callback implementations
> 4ee573086bd8 Fonts: Add charcount field to font_desc
> 4497364e5f61 parisc/sticore: Avoid hard-coding built-in font charcount
> a1ac250a82a5 fbcon: Avoid using FNTCHARCNT() and hard-coded built-in font charcount
> 
> These all apply without fuzz and builds cleanly for x86_64 and parisc64.
> 
> I tested on x86_64 that:
> 
> - VT 2 works again
> - bit_putcs_aligned() is setting charcnt = 256
> - After loading a font with 512 characters, bit_putcs_aligned() sets
>   charcnt = 512 and is able to display characters at positions >= 256

All now queued up, thanks!

greg k-h

