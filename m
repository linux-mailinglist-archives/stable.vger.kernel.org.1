Return-Path: <stable+bounces-146063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE0DAC08E4
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 11:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1CEC1BA6D8D
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 09:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBAE264610;
	Thu, 22 May 2025 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YcjqL/9K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008CF2367D9
	for <stable@vger.kernel.org>; Thu, 22 May 2025 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747906849; cv=none; b=CmLyvtkCfTFCnw05RqrEVPoUgSkx6pk1nmEUOh5+1aaGgf/gIAPn/qWTuHRYoJI45kMmxwLjqbEXE59tKszXxJzLEiKuWv3cY3e+Lx5raIsydYeHkpOgD7CzHwHh0yOahywhx80Tu+oIDLPEVNru6CC8y7X64nXRCuWJn5tGbTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747906849; c=relaxed/simple;
	bh=HVELKFbM+FHznoH3Za0x4/fGeEl/tTfop4Eu+/oof/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U95j6HR2RLxwSJpTP3V9a35aOVwExF2bzwdo7bt1osOrMoEpvYpnrPl8KkAB4iEzWtLuRxNUSZnO1rVZdUH2IuhCr5oxekTLYkSlCxG0toxZobxbc8YdDGFvWBMs8qDdo+meu+7c7H4my/eTiDqw4JjAj6ZvYDYmC3p+Oh+drRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YcjqL/9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC63C4CEE4;
	Thu, 22 May 2025 09:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747906848;
	bh=HVELKFbM+FHznoH3Za0x4/fGeEl/tTfop4Eu+/oof/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcjqL/9KR7XZTrQBrYisZfYt0gpfNs6V5Z9HhOZQHRCJIP8Jp2kBgk97cvLfwW7jk
	 GzJIMPtbjUcmwIa0hiMUJni8F1TR6X9xomMwDBQjrjU66lxYTh97WDl/etCCsebJ9o
	 UDzJUk5u6ojsFmc97KgJja2UJpSWkkuixcBYvgGU=
Date: Thu, 22 May 2025 11:40:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: He Zhe <zhe.he@windriver.com>
Cc: Feng Liu <Feng.Liu3@windriver.com>, adobriyan@gmail.com,
	kees@kernel.org, sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y/5.15.y] ELF: fix kernel.randomize_va_space double
 read
Message-ID: <2025052221-exemplify-avoid-3122@gregkh>
References: <20250509061415.435740-1-Feng.Liu3@windriver.com>
 <2025052021-freebee-clever-8fef@gregkh>
 <fc8f61c6-eb98-4102-bf81-a924df303efb@windriver.com>
 <2025052230-okay-announcer-3746@gregkh>
 <39787154-1013-40c2-9627-da8b8bbf8de2@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39787154-1013-40c2-9627-da8b8bbf8de2@windriver.com>

On Thu, May 22, 2025 at 05:26:33PM +0800, He Zhe wrote:
> 
> 
> On 2025/5/22 16:36, Greg KH wrote:
> > On Thu, May 22, 2025 at 03:40:16PM +0800, He Zhe wrote:
> >>
> >> On 2025/5/20 19:25, Greg KH wrote:
> >>> On Fri, May 09, 2025 at 02:14:15PM +0800, Feng Liu wrote:
> >>>> From: Alexey Dobriyan <adobriyan@gmail.com>
> >>>>
> >>>> [ Upstream commit 2a97388a807b6ab5538aa8f8537b2463c6988bd2 ]
> >>>>
> >>>> ELF loader uses "randomize_va_space" twice. It is sysctl and can change
> >>>> at any moment, so 2 loads could see 2 different values in theory with
> >>>> unpredictable consequences.
> >>>>
> >>>> Issue exactly one load for consistent value across one exec.
> >>>>
> >>>> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> >>>> Link: https://lore.kernel.org/r/3329905c-7eb8-400a-8f0a-d87cff979b5b@p183
> >>>> Signed-off-by: Kees Cook <kees@kernel.org>
> >>>> Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
> >>>> Signed-off-by: He Zhe <Zhe.He@windriver.com>
> >>>> ---
> >>>> Verified the build test.
> >>> No you did not!  This breaks the build.
> >>>
> >>> This is really really annoying as it breaks the workflow on our side
> >>> when you submit code that does not work at all.
> >>>
> >>> Please go and retest all of the outstanding commits that you all have
> >>> submitted and fix them up and resend them.  I'm dropping all of the rest
> >>> of them from my pending queue as this shows a total lack of testing
> >>> happening which implies that I can't trust any of these at all.
> >>>
> >>> And I want you all to prove that you have actually tested the code, not
> >>> just this bland "Verified the build test" which is a _very_ low bar,
> >>> that is not even happening here at all :(
> >> Sorry for any inconvenience.
> >>
> >> We did do some build test on Ubuntu22.04 with the default GCC 11.4.0 and
> >> defconfig on an x86_64 machine against the latest linux-stable before sending
> >> the patch out. And we just redid the build test and caught below warning that
> >> we missed before:
> > That is a very old version of gcc, and why are you using ubuntu when
> > this all should be tested on your version of Linux as that's what you
> > are backporting these patches for, right?  Shouldn't you be doing this
> > work for the portions of the kernel that you are actually using so that
> > you can properly test this stuff?
> 
> Yes, we tested on our own version too, but also have to test build with the tree we're submitting
> the patch to. So we use ubuntu22.04 for the building machine, not the one we want to replace the
> kernel with.

But this wasn't built, or tested, on your target system.  Otherwise your
own internal CI would have caught this before even considering it for
submission to us.

> >> ../fs/binfmt_elf.c: In function ‘load_elf_binary’:
> >> ../fs/binfmt_elf.c:1011:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
> >>  1011 |         const int snapshot_randomize_va_space = READ_ONCE(randomize_va_space);
> >>       |   
> > Do you think adding a new warning is ok?
> 
> Of course not, we just missed this one.

It was not "just this one" that caused me to get frustrated and delete
all of your patches from the review queue.

Go off and rework your process for all of this please, otherwise I will
have to continue to just ignore these patch submissions from this
email domain.

greg k-h

