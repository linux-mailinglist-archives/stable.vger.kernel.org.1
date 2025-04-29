Return-Path: <stable+bounces-137021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2B1AA07F3
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B4707ABEB8
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42752BE11A;
	Tue, 29 Apr 2025 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPvyRRpz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F2A1FE478
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921066; cv=none; b=jxgb7qCHtoVaeKKhb2PSVwTzYmHvOq0+yUJK0213FwV69T7uy4IOkK93zPk/dniLY0vvT84lVii9E5M0yseiL22WXSctJjWxS7fZW8vJiCi+TuutaYWtAD5e581RMwXqcyf7SdEO7jyLrlyiyh8G5ss1u98+cDSA13B9i7gjMmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921066; c=relaxed/simple;
	bh=jjAKSI1rn8lbtuJTwm3tMuqSVxkRAFzEf+lqXoG/y6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8YikfFDILtv+tTpQOuTRmVxhRDqaPqrBnP8hwDwoVMHoWEuOGQKO6GshWA0THuXqqDlJmXyvPsXvh3HJ3VpSE+AA9iy4BXz9wfOHzNuB+5kNIupFcY5A4iSCBw6Ya2Gaesr3ZfSRtPTheuHq2lxrMF4Kt7Qn7HQRKA2cDYYBWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPvyRRpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D70C4CEE3;
	Tue, 29 Apr 2025 10:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745921066;
	bh=jjAKSI1rn8lbtuJTwm3tMuqSVxkRAFzEf+lqXoG/y6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GPvyRRpzAWdUCJ4kYawJl0Z3jimpFVuT0TwEyZNLRkgODCd30CCCn+u6StNeB8lHi
	 aBxAbBa2mTfjvUNaAvDDgRDtXARQkhSp7LFYsX8tz39mRReTlLBHjhcYNVs6W2nDZK
	 EM8qQLawp976w/dXecSvrxioRlnoA5mmVbpA3al7qW3djhtGa/8kThrTAIGsSLRdHT
	 j2uWXurbIuD2J6tDxruHTPFIhFrqvjlY6/USCbmeRzkSLLIlwrP7EoBZWwj4UOB04Y
	 jP3UYXDd93vbkDZ/i8k5WJo6l5bdE7+JgWFXIYrQZZRkSF9v6jsYKJkQrrValQokjE
	 mDgcnJ5mDiqrg==
Date: Tue, 29 Apr 2025 12:04:21 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, stable@vger.kernel.org, 
	Sasha Levin <sashal@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH 6.12.y 2/5] net: dsa: mv88e6xxx: fix atu_move_port_mask
 for 6341 family
Message-ID: <u7il6f5si3q3ensohdyrbkdnb4rfkxyr6eysxo6aw24jopddwk@y3otol2rphke>
References: <20250428075813.530-1-kabel@kernel.org>
 <20250428075813.530-2-kabel@kernel.org>
 <2025042936-quit-scoff-4ca7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025042936-quit-scoff-4ca7@gregkh>

On Tue, Apr 29, 2025 at 09:34:21AM +0200, Greg KH wrote:
> On Mon, Apr 28, 2025 at 09:58:10AM +0200, Marek Behún wrote:
> > [ Upstream commit 4ae01ec007716986e1a20f1285eb013cbf188830 ]
> > 
> > The atu_move_port_mask for 6341 family (Topaz) is 0xf, not 0x1f. The
> > PortVec field is 8 bits wide, not 11 as in 6390 family. Fix this.
> > 
> > Fixes: e606ca36bbf2 ("net: dsa: mv88e6xxx: rework ATU Remove")
> > Signed-off-by: Marek Behún <kabel@kernel.org>
> 
> Sorry, but you seem to have lost all of the original signed-off-by and
> other metadata on this commit (and all the other backports).
> 
> Can you resend them with that information added back please?  Then we'll
> be glad to queue these up.

OK!

