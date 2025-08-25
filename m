Return-Path: <stable+bounces-172796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A0AB337D0
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 09:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F53200708
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 07:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDF6288C2C;
	Mon, 25 Aug 2025 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yfdPozZf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9DA13790B;
	Mon, 25 Aug 2025 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756107039; cv=none; b=S+JC3fUluNI07qH7TLoJeAcKcnOWYd1ndn1yO1kc3eb8znjVhtDJInip4KgBIa7gh7ybSDUEQtIAOlh9Fr+e9nZ48bfRK3MFrt53OH1jsufkHrwOohv1it/+fpYqrt2ffn6//SeJa8jFxSrMoFfBmHydNeCJ+CL79Rxyaru3egs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756107039; c=relaxed/simple;
	bh=3Yk6qbW5qXsffUYfd08JYjQsxUKrUp0TBAnBrPKx4Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzryNDMmH/sIVD6yE3YZkWhQVeOrjZ6o9EvnAFxbJFgnqV4ZiZvF2tQocZas9wSIWuEAgISp6+UILIPgzOMwhcVIpI033WxjTC8mA6noS77DWXha5/rcwiHFW/f73ZvdJBeMF3WJX/cAJutnzzSSQuKqmsLgJfmvVd1bc1u1ppQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yfdPozZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5A7C4CEED;
	Mon, 25 Aug 2025 07:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756107039;
	bh=3Yk6qbW5qXsffUYfd08JYjQsxUKrUp0TBAnBrPKx4Fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yfdPozZfwAiD5eV1PEDrLBYRXq5+f7r54Os6/FOp5UJDn1tvJDEknOPyZ8siICZyU
	 j07m7Njo8YRz2MnYfvSjXZM5S+BGvY2c1hc5akMUE6R4ffw6++O4F4layzMpx1UU3N
	 xlGih0K7pKFJhK4FtDfA/HsfT1b6GtiqMRFOk10U=
Date: Mon, 25 Aug 2025 09:30:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kyle Sanderson <kyle.leet@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
	jslaby@suse.cz
Subject: Re: [REGRESSION] - BROKEN NETWORKING Re: Linux 6.16.3
Message-ID: <2025082506-steersman-twentieth-0c79@gregkh>
References: <2025082354-halogen-retaliate-a8ba@gregkh>
 <cfd4d3bd-cd0e-45dc-af9b-b478a56f8942@gmail.com>
 <2025082529-reporter-frays-73a5@gregkh>
 <2025082553-overripe-sanction-bc82@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025082553-overripe-sanction-bc82@gregkh>

On Mon, Aug 25, 2025 at 09:29:05AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Aug 25, 2025 at 09:00:14AM +0200, Greg Kroah-Hartman wrote:
> > On Sun, Aug 24, 2025 at 11:31:01AM -0700, Kyle Sanderson wrote:
> > > On 8/23/2025 7:51 AM, Greg Kroah-Hartman wrote:
> > > > I'm announcing the release of the 6.16.3 kernel.
> > > > 
> > > > All users of the 6.16 kernel series that use the ext4 filesystem should
> > > > upgrade.
> > > > 
> > > > The updated 6.16.y git tree can be found at:
> > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.16.y
> > > > and can be browsed at the normal kernel.org git web browser:
> > > > 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > Hi Greg,
> > > 
> > > Thanks for maintaining these as always. For the first time in a long time, I
> > > booted the latest stable (6.15.x -> 6.16.3) and somehow lost my networking.
> > > It looks like there is a patch from Intel (reported by AMD) that did not
> > > make it into stable 6.16.
> > > 
> > > e67a0bc3ed4fd8ee1697cb6d937e2b294ec13b5e - ixgbe
> > > https://lore.kernel.org/all/94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org/
> > > - i40e
> > 
> > Any specific reason why this hasn't been asked to be backported to
> > stable trees if it fixes an issue?   Please cc: the developers involved
> > so that they know to let us pick it up.
> 
> I've picked it up now, simple enough.

Oops, nope, it needed other work.  And someone has already sent this for
inclusion, I'll take their backports:
	https://lore.kernel.org/r/20597f81c1439569e34d026542365aef1cedfb00.1756088250.git.calvin@wbinvd.org

