Return-Path: <stable+bounces-146054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FC5AC073F
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 10:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3591176C80
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 08:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3305EEA6;
	Thu, 22 May 2025 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w7N7bSC/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CB21AB531
	for <stable@vger.kernel.org>; Thu, 22 May 2025 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903019; cv=none; b=fuA+c62lf7PzwH+jOqMozULsvKh/fYdU+B1AklZZ7/Jliwp6hKslLxVh2HmSkDHfaqSgr+dwYjDqOmrdVez42BRiNWoAwHBiGZeL79GgH8K9wj/URrtLDurBxcp12n1jN878vVjkImXWg2K08xYEuGa97ng97Ojti+d99Y5YaSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903019; c=relaxed/simple;
	bh=An+dEAtLMaFGZNb8W8IbNOIsto8UV0PUE0ai0DTqzfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDAyC01szri9ni+gW3qPIXju2OQHNY7F6PT7tPthUv9IsWBoViraEFFFWIqUJoVU+xE0/al09wT7E7QALVa5zN0qKjnHfxlKrM0Da9FR0Doc/uLan4RctDPm5yQPXqi+kusQf1Jb1eJlLcj7wk03cq6lS2QvMsEsxXiMQ/DWFx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w7N7bSC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E5DC4CEE4;
	Thu, 22 May 2025 08:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747903019;
	bh=An+dEAtLMaFGZNb8W8IbNOIsto8UV0PUE0ai0DTqzfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w7N7bSC/eJYB/r/NCU2LHHUX5Qr/JeaEew/qEI5UukhUh605+JsuXlADb/W2kkKq1
	 rE2DmQl8aL/d2CxQp+du+Zo9sx4LWTG3xQGFXRzDiYzo9kCAg4Ut1WnDyMbTrXGIO5
	 Cn2N2EZJTCRvFkCyOJWca6hFCEYwMOAnEdIyfxkE=
Date: Thu, 22 May 2025 10:36:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: He Zhe <zhe.he@windriver.com>
Cc: Feng Liu <Feng.Liu3@windriver.com>, adobriyan@gmail.com,
	kees@kernel.org, sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y/5.15.y] ELF: fix kernel.randomize_va_space double
 read
Message-ID: <2025052230-okay-announcer-3746@gregkh>
References: <20250509061415.435740-1-Feng.Liu3@windriver.com>
 <2025052021-freebee-clever-8fef@gregkh>
 <fc8f61c6-eb98-4102-bf81-a924df303efb@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc8f61c6-eb98-4102-bf81-a924df303efb@windriver.com>

On Thu, May 22, 2025 at 03:40:16PM +0800, He Zhe wrote:
> 
> 
> On 2025/5/20 19:25, Greg KH wrote:
> > On Fri, May 09, 2025 at 02:14:15PM +0800, Feng Liu wrote:
> >> From: Alexey Dobriyan <adobriyan@gmail.com>
> >>
> >> [ Upstream commit 2a97388a807b6ab5538aa8f8537b2463c6988bd2 ]
> >>
> >> ELF loader uses "randomize_va_space" twice. It is sysctl and can change
> >> at any moment, so 2 loads could see 2 different values in theory with
> >> unpredictable consequences.
> >>
> >> Issue exactly one load for consistent value across one exec.
> >>
> >> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> >> Link: https://lore.kernel.org/r/3329905c-7eb8-400a-8f0a-d87cff979b5b@p183
> >> Signed-off-by: Kees Cook <kees@kernel.org>
> >> Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
> >> Signed-off-by: He Zhe <Zhe.He@windriver.com>
> >> ---
> >> Verified the build test.
> > No you did not!  This breaks the build.
> >
> > This is really really annoying as it breaks the workflow on our side
> > when you submit code that does not work at all.
> >
> > Please go and retest all of the outstanding commits that you all have
> > submitted and fix them up and resend them.  I'm dropping all of the rest
> > of them from my pending queue as this shows a total lack of testing
> > happening which implies that I can't trust any of these at all.
> >
> > And I want you all to prove that you have actually tested the code, not
> > just this bland "Verified the build test" which is a _very_ low bar,
> > that is not even happening here at all :(
> 
> Sorry for any inconvenience.
> 
> We did do some build test on Ubuntu22.04 with the default GCC 11.4.0 and
> defconfig on an x86_64 machine against the latest linux-stable before sending
> the patch out. And we just redid the build test and caught below warning that
> we missed before:

That is a very old version of gcc, and why are you using ubuntu when
this all should be tested on your version of Linux as that's what you
are backporting these patches for, right?  Shouldn't you be doing this
work for the portions of the kernel that you are actually using so that
you can properly test this stuff?

> ../fs/binfmt_elf.c: In function ‘load_elf_binary’:
> ../fs/binfmt_elf.c:1011:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>  1011 |         const int snapshot_randomize_va_space = READ_ONCE(randomize_va_space);
>       |   

Do you think adding a new warning is ok?

> Just to be clear, is this the issue that breaks the build from your side?

I don't remember, given that it was many hundreds of patches ago.  But
probably.  Try it yourself and see!

> We just used the default config and didn't manually enable -WERROR which is
> disabled by default for 5.10 and 5.15. After searching around we feel that
> we should have enabled it as suggested by
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b9080ba4a6ec56447f263082825a4fddb873316b
> even for 5.10 and 5.15, so that such case wouldn't go unnoticed.

Default configs for x86 are very limited, please do better testing.

greg k-h

