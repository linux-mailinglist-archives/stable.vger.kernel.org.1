Return-Path: <stable+bounces-20372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B90C8585A5
	for <lists+stable@lfdr.de>; Fri, 16 Feb 2024 19:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325B61F24919
	for <lists+stable@lfdr.de>; Fri, 16 Feb 2024 18:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F39146903;
	Fri, 16 Feb 2024 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ufyLG+tf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364E214601E
	for <stable@vger.kernel.org>; Fri, 16 Feb 2024 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109117; cv=none; b=CA3tnrg1WuALv13Pc5P7UHH9erhQFxX/KqcC1MTA/Em+tl3s75XgVme3lJUCkRG2gQdvrxZLsn6IiVqn87wI3BYC600pl8UPULA0pfYr4fa4DTGDix79Nbkpkm7YDRxHsJ/HwwqgjuF8Z2XXfy7eoDWCEDuwqsVWNkobzPvLc/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109117; c=relaxed/simple;
	bh=0UmTrer8blnAQJjl+i50j56Sk8TO2/bEua0oaDGRuqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKFTEKh1bckzRHmSAG84AEo497JV8RES0efZdwN8wJNbgJ5+/QtOViguCGmrhklU6W9EhTpTu2+9kUbvOH/OM653+JTrpYQqHJGkquq25k1CGSRl2T/GCPiZixKoNvWjyq0S6VLEtRXiGmpz15OMv+va8W/8JJ5yCMa4NiMcbsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ufyLG+tf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4C4C433F1;
	Fri, 16 Feb 2024 18:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708109116;
	bh=0UmTrer8blnAQJjl+i50j56Sk8TO2/bEua0oaDGRuqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ufyLG+tfGM18zHTcN1PL+/l3RIVRoPlZTdjr3Dj2QcHodxfNQiij1i8lvX+vwpjIt
	 hSIbPtHu8v3bnZNOUgHRn/DS5XKbFT9Vkvj8z7keGZiEXugBuS61LUjgi7Fr5x23eb
	 ayntmhsXSfDL0tb2Pyuss6SYnVWf/y5TjvS1aTJo=
Date: Fri, 16 Feb 2024 19:45:13 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable <stable@vger.kernel.org>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: Please put the gcc "asm goto" bug workaround into stable
Message-ID: <2024021623-puma-sympathy-1a4a@gregkh>
References: <CAHk-=wgcbbNw-dJu_=9xT3KR-xRgPYG7yLeUwqLkCKoRamx5Ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgcbbNw-dJu_=9xT3KR-xRgPYG7yLeUwqLkCKoRamx5Ug@mail.gmail.com>

On Fri, Feb 16, 2024 at 07:57:01AM -0800, Linus Torvalds wrote:
> I didn't think to mark these for stable in the commits, but they
> definitely should go into the stable queue, since it's a known
> mis-compilation of the kvm nested guest code with gcc-11 otherwise.
> 
> The bug technically affects other gcc versions too, but apparently not
> so that we'd actually notice.
> 
> It's two commits:
> 
>   4356e9f841f7 ("work around gcc bugs with 'asm goto' with outputs")
>   68fb3ca0e408 ("update workarounds for gcc "asm goto" issue")
> 
> where the first one works around the problem, and the second one
> ("update") just ends up pinpointing exactly which gcc versions are
> affected so that future gcc releases won't get the unnecessary
> workaround.
> 
> Technically only the first one really needs to go into stable. The
> second one is more of a judgement call - do you want to match
> upstream, and do you care about the (very slight) code generation
> improvement with updated gcc versions?

I've queued both up for 6.6.y and 6.7.y and they took a bit of
hand-holding to get merged.  I gave up at 6.1.y and if anyone wants them
there, I'll gladly take a working backport, but I'm not going to attempt
it.

thanks,

greg k-h

