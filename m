Return-Path: <stable+bounces-40546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 624238ADB01
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 02:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A4B1C20B7A
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 00:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBE528E2;
	Tue, 23 Apr 2024 00:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pT/nm5iQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B62C23B1;
	Tue, 23 Apr 2024 00:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830461; cv=none; b=JFEoDSXJRSaKQmfe9anBUFHJG0Nu0IGX5zOAPgLObE6Bsetu+HeW80EmJeHxxulk7yiNvFCEoy1rqrieR8Go6I8ngGSVfKd+sR85WClrHFyELQeLX/BHpjRzPPw5Yl+yvNt8/wSVwxrw7CPxoND2ReRYCDBzCVvjz8NPX2Ker6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830461; c=relaxed/simple;
	bh=ug7gjQbUFGjX6WE/w3oqS5QlblPAmsfItnDjXp3JKfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tG0WwpqTbKsb3V4FJgVRYG/EIE90w2hCYALn5N8mRw9U4lTxBmFuGgyRlt6+qiRuL+IUdGIoM8ry2lY1g0ouX3vWsW9yurtFDMIbxQZUXRvKDYyXGfn/yOEncS1w+UpVHCwI6tbIHowO8HssmbAzvlNxBOe4j4pCDnHa12fOX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pT/nm5iQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CFCC113CC;
	Tue, 23 Apr 2024 00:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830460;
	bh=ug7gjQbUFGjX6WE/w3oqS5QlblPAmsfItnDjXp3JKfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pT/nm5iQnFIkwFO12U/z5DCq3ecaDjibXn4I8xc09PzarzzxkRpEdyvKGRvZO3elF
	 0NidLlSMxw/s34c1nCxNxD9RD3pF1dI1YPp1XkJJLFYCS2X5liFWn3Nt1sqlzzehW4
	 TLQKkcE7I3OPNymlzfiJAAQL+aZmcrV7c4WFYPB93J7eIDvhn+nKFeDA91flEn6xiZ
	 IIUnnZsOWYHiptWCVa2OrBBJAHp6bz6sJkZaMVp5+hR8O3uFzIFTkmW10QK3kryHOQ
	 p7KshDoGMUyHZ1oqwkbC4o83t+Fwo+PxpByNFtb3vAL/Ge863P4g8JdDSfgp4rlP04
	 UyXRGgFo0OASQ==
Date: Mon, 22 Apr 2024 17:00:58 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: Patch "configs/hardening: Fix disabling UBSAN configurations"
 has been added to the 6.8-stable tree
Message-ID: <20240423000058.GA3055980@dev-arch.thelio-3990X>
References: <20240421171119.1444407-1-sashal@kernel.org>
 <20240422185433.GA10996@dev-arch.thelio-3990X>
 <Zibu1T0d8IEuf0UQ@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zibu1T0d8IEuf0UQ@sashalap>

On Mon, Apr 22, 2024 at 07:12:21PM -0400, Sasha Levin wrote:
> On Mon, Apr 22, 2024 at 11:54:33AM -0700, Nathan Chancellor wrote:
> > On Sun, Apr 21, 2024 at 01:11:19PM -0400, Sasha Levin wrote:
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     configs/hardening: Fix disabling UBSAN configurations
> > > 
> > > to the 6.8-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > 
> > > The filename of the patch is:
> > >      configs-hardening-fix-disabling-ubsan-configurations.patch
> > > and it can be found in the queue-6.8 subdirectory.
> > > 
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > > 
> > > 
> > > 
> > > commit a54fba0bb1f52707b423c908e153d6429d08db58
> > > Author: Nathan Chancellor <nathan@kernel.org>
> > > Date:   Thu Apr 11 11:11:06 2024 -0700
> > > 
> > >     configs/hardening: Fix disabling UBSAN configurations
> > > 
> > >     [ Upstream commit e048d668f2969cf2b76e0fa21882a1b3bb323eca ]
> > 
> > While I think backporting this makes sense, I don't know that
> > backporting 918327e9b7ff ("ubsan: Remove CONFIG_UBSAN_SANITIZE_ALL") to
> > resolve the conflict with 6.8 is entirely necessary (or beneficial, I
> > don't know how Kees feels about it though). I've attached a version that
> > applies cleanly to 6.8, in case it is desirable.
> 
> I usually wouldn't do it, but 918327e9b7ff ("ubsan: Remove
> CONFIG_UBSAN_SANITIZE_ALL") indicated that it's mostly a noop rather
> than a change in behavior for existing config files.

It is a change in behavior for architectures that did not select
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL because CONFIG_UBSAN_SANITIZE_ALL
depends on that (for example, LoongArch). That change actually helped
expose an issue in LoongArch's LLVM backend because UBSAN was now
getting enabled on files in allmodconfig, which is good, but that shows
the change is not risk free. However, given that it makes CONFIG_UBSAN
perhaps work more expectedly (which could be considered a fix on its
own), we can probably keep this as is and just back out of it if it is
too disruptive to people.

Cheers,
Nathan

