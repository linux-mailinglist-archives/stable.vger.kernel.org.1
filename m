Return-Path: <stable+bounces-172784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3912B33705
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 09:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A1F3AEF4E
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 07:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9044B2877D0;
	Mon, 25 Aug 2025 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CdGNsNWB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254E528750C;
	Mon, 25 Aug 2025 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756105220; cv=none; b=g4Gh400jKRhbddp6co24PN7PCBzLgZXlhdHLPPXSzibbGw2eiuNVvzwEPBQCZOyfgLgx4XrurqgK9s7p0YhiaGFjuahmccTd0JW6B4Rtdse2OU/eRDAScAqwkv+BAChgSvKbs9USuiWhSCXDKCjEELujcFxuNe7R+LfEy4bchnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756105220; c=relaxed/simple;
	bh=x49B5c6Khl0SgwCgszGNzX2jHZA4AGTLJBlK44cAA8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cH3RyMrtp2nECY7fvzmnf0mWy0vJyI8C3tDQeNKRuMSZ5YtN9pYqNcokEUaqbVn9RAyvE+h1kQCrBJil5afrLEuV9oB93EAMNkD8NJriegnmwJ+vdif8vu4KWTTLq9OqV+iqBTu6cDDT92TbGvX+c9+MUS4XRoQBrx9Xmy+jRqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CdGNsNWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EACEC4CEED;
	Mon, 25 Aug 2025 07:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756105219;
	bh=x49B5c6Khl0SgwCgszGNzX2jHZA4AGTLJBlK44cAA8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CdGNsNWBS3w69aGvE352IarGzmGMbPrDjZ/ywVobpOHnfF2/mrH5JJb1oZ5sk7Xog
	 WCXTK51PMHLZrQOyLV8ZoSA14U7gQIctGeWnO6crIdiorcGvJNf9rAulFw4nd5uVzq
	 lPD506SafO1H/NoNu0ixPv7tZheZPxlKuiuqjZjI=
Date: Mon, 25 Aug 2025 09:00:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kyle Sanderson <kyle.leet@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
	jslaby@suse.cz
Subject: Re: [REGRESSION] - BROKEN NETWORKING Re: Linux 6.16.3
Message-ID: <2025082529-reporter-frays-73a5@gregkh>
References: <2025082354-halogen-retaliate-a8ba@gregkh>
 <cfd4d3bd-cd0e-45dc-af9b-b478a56f8942@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfd4d3bd-cd0e-45dc-af9b-b478a56f8942@gmail.com>

On Sun, Aug 24, 2025 at 11:31:01AM -0700, Kyle Sanderson wrote:
> On 8/23/2025 7:51 AM, Greg Kroah-Hartman wrote:
> > I'm announcing the release of the 6.16.3 kernel.
> > 
> > All users of the 6.16 kernel series that use the ext4 filesystem should
> > upgrade.
> > 
> > The updated 6.16.y git tree can be found at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.16.y
> > and can be browsed at the normal kernel.org git web browser:
> > 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi Greg,
> 
> Thanks for maintaining these as always. For the first time in a long time, I
> booted the latest stable (6.15.x -> 6.16.3) and somehow lost my networking.
> It looks like there is a patch from Intel (reported by AMD) that did not
> make it into stable 6.16.
> 
> e67a0bc3ed4fd8ee1697cb6d937e2b294ec13b5e - ixgbe
> https://lore.kernel.org/all/94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org/
> - i40e

Any specific reason why this hasn't been asked to be backported to
stable trees if it fixes an issue?   Please cc: the developers involved
so that they know to let us pick it up.

thanks,

greg k-h

