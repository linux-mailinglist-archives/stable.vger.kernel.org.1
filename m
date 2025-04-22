Return-Path: <stable+bounces-135126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 771A0A96C48
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 15:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B6D17ADF9
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 13:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7FE27CCC8;
	Tue, 22 Apr 2025 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bIs5bTuJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A28814BFA2;
	Tue, 22 Apr 2025 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745327789; cv=none; b=DRNmUO9Ulo+7wHRNZvrT2LdVE1lsKb+EP6GsWP63gSHmfc46wyrDc5BUot5LLM3HS1wkOZ9tISBDFahHESTk4vrNmBglMsOG/TwVFx7ho3eQ4rYUa6ON5aFY9SlJ6Cw8SByh3FMkmaT37n/gTi7GEhx2EdBqXaOqPwKBHvy7RaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745327789; c=relaxed/simple;
	bh=6tmGmklnwN8vx0n4rAj1N5XTQGSDE0iGYL1o4MkaNLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+OGm97HqI4JeYOjzpZ/lxSa2V1EoM+M+iiKoACSatqE1+qznwBVM/rpbaAjepOPzZD438Zzo/yiTTVLZXHrfzYnSFqBHUU2qTn1L5eLCbXQf7zJpLImZzw3PXZ+oJtYcy3aqLuTzPodByZnJ5hd8nl0dTIPCMXAcozE+3WjYhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bIs5bTuJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786EAC4CEEC;
	Tue, 22 Apr 2025 13:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745327789;
	bh=6tmGmklnwN8vx0n4rAj1N5XTQGSDE0iGYL1o4MkaNLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bIs5bTuJvCfBmMKpxZc5Tm7AdYWPFbFzUlulT0XmxotWEMOM0WZlwAB2jVTywkcE6
	 oz01+0jHJ4Zi7TwAU225as4iIeuOMdhPaROhk1ewBAgQNGHLy6R1a1Gx3Qumz7I/8m
	 7yQ1ZTtjaXx88GTEWOv7M8flVGNribf+XGC7oyk4=
Date: Tue, 22 Apr 2025 15:16:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Ryo Takakura <ryotkkr98@gmail.com>, alex@ghiti.fr,
	aou@eecs.berkeley.edu, bigeasy@linutronix.de,
	conor.dooley@microchip.com, jirislaby@kernel.org,
	john.ogness@linutronix.de, palmer@dabbelt.com,
	paul.walmsley@sifive.com, pmladek@suse.com,
	samuel.holland@sifive.com, u.kleine-koenig@baylibre.com,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] serial: sifive: lock port in startup()/shutdown()
 callbacks
Message-ID: <2025042252-geology-causation-a455@gregkh>
References: <20250405043833.397020-1-ryotkkr98@gmail.com>
 <20250405044338.397237-1-ryotkkr98@gmail.com>
 <2025040553-video-declared-7d54@gregkh>
 <397723b7-9f04-4cb1-b718-2396ea9d1b91@suse.cz>
 <2025042202-compare-entrap-0089@gregkh>
 <a7cf9864-6810-43d8-a7f6-f71cc1ee081c@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7cf9864-6810-43d8-a7f6-f71cc1ee081c@suse.cz>

On Tue, Apr 22, 2025 at 03:07:54PM +0200, Vlastimil Babka wrote:
> On 4/22/25 12:50, Greg KH wrote:
> > On Tue, Apr 22, 2025 at 12:20:42PM +0200, Vlastimil Babka wrote:
> >> 
> >> I admit it's surprising to see such a request as AFAIK it's normally done to
> >> mix stable fixes and new features in the same series (especially when the
> >> patches depend on each other), and ordering the fixes first and marking only
> >> them as stable should be sufficient. We do that all the time in -mm. I
> >> thought that stable works with stable marked commits primarily, not series?
> > 
> > Yes, but when picking which "branch" to apply a series to, what would
> > you do if you have some "fix some bugs, then add some new features" in a
> > single patch series?  The one to go to -final or the one for the next
> > -rc1?
> 
> As a maintainer I could split it myself.

You must not have that many patches to review, remember, some of us get
a few more than others ;)

> > I see a lot of bugfixes delayed until -rc1 because of this issue, and
> > it's really not a good idea at all.
> 
> In my experience, most of the time these fixes are created because a dev:
> 
> - works on the code to implement the feature part
> - while working at the code, spots an existing bug
> - the bug can be old (Fixes: commit a number of releases ago)
> - wants to be helpful so isolates the fix separately as an early patch of
> the series and marks stable because the bug can be serious enough in theory
> - at the same time there are no known reports of the bug being hit in the wild
> 
> In that case I don't see the urgency to fix it ASAP (unless it's e.g.
> something obviously dangerously exploitable) so it might not be such a bad
> idea just to put everything towards next rc1.

Yes, but then look at the huge number of "bugfixes" that land in -rc1.
Is that ok or not?  I don't know...

> This very thread seems to be a good example of the above. I see the later
> version added a
> Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
> which is a v5.2 commit.

Agreed, but delaying a known-fix for weeks/months feels bad to me.

thanks,

greg k-h

