Return-Path: <stable+bounces-196893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA701C84DAB
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 12:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32AAB4E8CBA
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 11:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E576231985B;
	Tue, 25 Nov 2025 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kc/lCIjA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F383316915
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764071914; cv=none; b=DXTLceZDQcJndT5Y2XhDo4VoFVsZomTbt2s+GWsujM9U4RVrrVKi3sgBJpJjadtvb6hbS8RT53aRdukCb7DddQ2cFHcqZYnyCmXv2JYprfYYnm9D0xKYGHOh4mFfpzKOC0WiPb/8nn3DB0GFgqO7lG453bb9pFE77rzHDFHUPEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764071914; c=relaxed/simple;
	bh=FLmPTedDCUFAaq/4C15Pj5i/0Ic03NuUOmY47LDTeRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9KF71WxvN92QPy0O/5Nru+egAvf+bRu7EizFyK5tERXQGGw0hxp3Dpa/6FZn1aguxVHu2NM4r/wTlS1FgOTixrfQ9gqHYre6PrAoh+mZKpPXfb63mV154ImFEtO3a3TVfVN2cI4/XmG+9wc6viqv7WUTsfxuYCS3gfu5FSF1UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kc/lCIjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D1AC116B1;
	Tue, 25 Nov 2025 11:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764071913;
	bh=FLmPTedDCUFAaq/4C15Pj5i/0Ic03NuUOmY47LDTeRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kc/lCIjA5AUZ6RI768yXHxp+J9bm8pCWmbJeoZKbPr2ifBJzgh/H+5WUyrB+hk60B
	 aKT5gujUF7VFfdZrBbdizV1JQr+0X824otui7DfVd9/O2BsdzhEBDhDqh2xCDMSKCr
	 xqWg7ieIUoO0+rC4TWkN15Wv45nfjctv/QAptiM0=
Date: Tue, 25 Nov 2025 12:58:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, stable@vger.kernel.org,
	linus.walleij@linaro.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] Revert "gpio: swnode: don't use the swnode's name as the
 key for GPIO lookup"
Message-ID: <2025112505-unlovable-crease-cfe2@gregkh>
References: <20251125102924.3612459-1-ckeepax@opensource.cirrus.com>
 <CAMRc=MfoycdnEFXU3yDUp4eJwDfkChNhXDQ-aoyoBcLxw_tmpQ@mail.gmail.com>
 <2025112531-glance-majorette-40b0@gregkh>
 <aSWXcml8rkX99MEy@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSWXcml8rkX99MEy@opensource.cirrus.com>

On Tue, Nov 25, 2025 at 11:48:02AM +0000, Charles Keepax wrote:
> On Tue, Nov 25, 2025 at 12:43:16PM +0100, Greg KH wrote:
> > On Tue, Nov 25, 2025 at 11:31:56AM +0100, Bartosz Golaszewski wrote:
> > > On Tue, Nov 25, 2025 at 11:29 AM Charles Keepax
> > > <ckeepax@opensource.cirrus.com> wrote:
> > > >
> > > > This reverts commit 25decf0469d4c91d90aa2e28d996aed276bfc622.
> > > >
> > > > This software node change doesn't actually fix any current issues
> > > > with the kernel, it is an improvement to the lookup process rather
> > > > than fixing a live bug. It also causes a couple of regressions with
> > > > shipping laptops, which relied on the label based lookup.
> > > >
> > > > There is a fix for the regressions in mainline, the first 5 patches
> > > > of [1]. However, those patches are fairly substantial changes and
> > > > given the patch causing the regression doesn't actually fix a bug
> > > > it seems better to just revert it in stable.
> > > >
> > > > CC: stable@vger.kernel.org # 6.12, 6.17
> > > > Link: https://lore.kernel.org/linux-sound/20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org/ [1]
> > > > Closes: https://github.com/thesofproject/linux/issues/5599
> > > > Closes: https://github.com/thesofproject/linux/issues/5603
> > > > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > > ---
> > > >
> > > > I wasn't exactly sure of the proceedure for reverting a patch that was
> > > > cherry-picked to stable, so apologies if I have made any mistakes here
> > > > but happy to update if necessary.
> > > >
> > > 
> > > Yes, I'd like to stress the fact that this MUST NOT be reverted in
> > > mainline, only in v6.12 and v6.17 stable branches.
> > 
> > But why?  Why not take the upstream changes instead?  We would much
> > rather do that as it reduces the divergance.  5 patches is trivial for
> > us to take.
> 
> My thinking was that they are a bit invasive for backports, as
> noted in the commit message. But if that is the preferred option
> I can do a series with those instead?

I'd prefer to take what is upstream, it's simpler over the long term to
do so.

thanks,

greg k-h

