Return-Path: <stable+bounces-78598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F9498CDC4
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 09:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C481C20A5C
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 07:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4D17DA83;
	Wed,  2 Oct 2024 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LFZnvP1L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34BB2F2D
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727854283; cv=none; b=mv5fjwwiz+Jc+VP4/KpoUfmk23g6P05uCzKXLhVlU2Ezclj5K0pnw+3wG5+HIlm2UI3PBNf3r+VegOVRCuSNMv3pHxCI6rnVIRuXlHAlvWpbgp4Kjri1VPCvihCAm/PBwt9FtNqGPk7/ydCA8QrCjf2cvEZH2aE7z6S2cqqjOM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727854283; c=relaxed/simple;
	bh=LLo/u73eSQ5NEPjxc1SsqK+/Dqq/Cx0WDlIpX2DkYWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJbZHzeAqQaW+kodfi1CxhKzrQo4FtcBVvNiQn2L63wKk4UlyUucRtFu1VpNnwS8D99QfRZYSoPXrA6HVNIVKnZivNtkHAdCBZ26E2vqKkAKlhf+FKfLKHrclOsEWij39P3rQP4PtJDc5rsS52NEszNaaIU9yUfjrYQzCuUEk3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LFZnvP1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C43AC4CECE;
	Wed,  2 Oct 2024 07:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727854282;
	bh=LLo/u73eSQ5NEPjxc1SsqK+/Dqq/Cx0WDlIpX2DkYWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LFZnvP1LYRLbBXT7e94jcRUAvW4moZmpxwVW2zdTi0i0DoDnyqh+rMbRfVNLkvGgl
	 19+PBgA8HolNvjHQqj+YU38JCLHkAPl0khGSejQllxBDNUt6VfZ3zKPcrMf6zCXQSv
	 5lKi3totIdknIXRywrwp6qSmHKs1tmInR+aILEQ4=
Date: Wed, 2 Oct 2024 09:31:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>
Subject: Re: patches sent up to 6.13-rc1 that shouldn't be backported
Message-ID: <2024100205-abacus-favorably-339e@gregkh>
References: <CAHmME9rtJ1YZGjYkWR10Wc24bVoJ4yZ-uQn0eTWjpfKxngBvvA@mail.gmail.com>
 <2024100107-womb-share-931a@gregkh>
 <ZvvjyyO00fL_JL4q@zx2c4.com>
 <2024100120-unlucky-sample-091b@gregkh>
 <ZvwOuERpwrkG5KPN@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvwOuERpwrkG5KPN@zx2c4.com>

On Tue, Oct 01, 2024 at 05:01:12PM +0200, Jason A. Donenfeld wrote:
> On Tue, Oct 01, 2024 at 02:13:14PM +0200, Greg Kroah-Hartman wrote:
> > Ok, I'll try to rework the other dependant patches to see if we can get
> > that fix in somehow without this change.  But why not take this, what is
> > it hurting?
> 
> I just don't see the need to backport *any* patches from my tree that
> don't have an explicit Cc: stable@ marker on them. I'm pretty careful
> about adding those, and when I forget, I send them manually onward to
> stable@. If there's some judgement that a certain patch needs to be
> backported that I didn't mark, that sounds like something to
> deliberately raise, rather than a heap of emails that this patch and
> that patch have been added willy-nilly.
> 
> The reason I care about this is that I generally care about stable and
> consistency of rationale and such, and so if you *do* want to backport
> some stuff, I am going to spend time checking and verifying and being
> careful. I don't want to do that work if it's just the consequence of a
> random script and not somebody's technical decision.
> 

I've now dropped all of your patches from the stable queues.

thanks,

greg k-h

