Return-Path: <stable+bounces-43462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C45B8C0272
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 19:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5F41C21FF6
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 17:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8563ADDD9;
	Wed,  8 May 2024 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdPge6OZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8AFD534;
	Wed,  8 May 2024 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187662; cv=none; b=PGybt5Miw8UtpqzFLJrnxQ/Vv4b8gHCVSJu3kubs60x9SWvexnLlaBcrVrKcJ0Q+WAAozCEQu9Ih0caH8BCmj87ZMvw6StfEfSXTF18MTs96KyCAlzmFwJHmW4xl9TwyHHzWzmpUCAVw+DQc0TMI1vH5OXCtksNA6qGPP2h5uxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187662; c=relaxed/simple;
	bh=yIcIect25By+5l9xSTVJF8N1/7X96wDUI0owYNYZGRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qb49hK6KmVX7zTbXKiM1fJiBJtu+e5yuQ5AGJ0WmQYEWSsZb9uGXI3rxqnHcNey0jvlgWkI3NXwSc8sSYb/3NngEeV810I/GrolrqVNK+mtF9y54cMiH4vukd5y1C80KbJjyvRERoB6bPxIZegMR3KHM9CHBTrDfvwV10UT7Vak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdPge6OZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B29C113CC;
	Wed,  8 May 2024 17:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715187661;
	bh=yIcIect25By+5l9xSTVJF8N1/7X96wDUI0owYNYZGRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdPge6OZAXT6FYQ9UmtY/IHpEqmhPZEidxOKZhfh6qBXq+3WyJ1jb/rtWi1pG6rR/
	 Lh3ozTfg2qfvGm1PdJkk/LmuavlEcFvl4tIjA0WZqYIUnNUhdxc5t616hp7GtpkVEt
	 PCQxUIsQcEttmccFJtpq0d24P/89VluAAkAgc4mnoXEDBkYp+WVh8A+GflhjbUJQWt
	 r/wLEuHBZQDCOVjP4AX6uukWS8Hdcufe5X/Wle52m5s54br1A4uibyP79ynEu/o55W
	 i61v9VqOogjRP6EbtERJTZ4oveCD5tTPD7QL9wDOAcP/Y8c+6mJ188xHpmECEKmtNA
	 rlvwFul2blOTg==
Date: Wed, 8 May 2024 13:01:00 -0400
From: Konstantin Ryabitsev <mricon@kernel.org>
To: Eric Wong <e@80x24.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, tools@linux.kernel.org, 
	stable@vger.kernel.org, meta@public-inbox.org, sashal@kernel.org, 
	gregkh@linuxfoundation.org, krzk@kernel.org
Subject: Re: filtering stable patches in lore queries
Message-ID: <20240508-optimal-peach-bustard-a49160@meerkat>
References: <ZixGx_sTyDmdUlaV@zx2c4.com>
 <20240427071921.M438650@dcvr>
 <20240429-antique-hyena-of-glee-d9e4ac@lemur>
 <20240508113314.M238016@dcvr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240508113314.M238016@dcvr>

On Wed, May 08, 2024 at 11:33:14AM GMT, Eric Wong wrote:
> > I'm whole-heartedly for this! This ties nicely to my b4 work where I'd 
> > like to be able to identify code-review trailers sent for a specific 
> > patch, even if that patch itself is not on lore. For example, this could 
> > be a patch that is part of a pull-request on a git forge, but we'd still 
> > like to be able to collect and find code-review trailers for it when a 
> > maintainer applies it.
> 
> OK, a more configurable version is available on a per-inbox basis:
> 
> https://public-inbox.org/meta/20240508110957.3108196-1-e@80x24.org/
> 
> But that's a PITA to configure with hundreds of inboxes and
> doesn't have extindex support, yet.
> 
> I made it share logic with the old altid code; so I'll also be
> getting altid into extindex since ISTR users wanting to be able
> to lookup gmane stuff via extindex.

Great, thanks for doing this. I'll wait until this has extindex support,
because I really need to be able to look across all inboxes.

> Yeah, though there's 3 ways of indexing strings, currently :x
> I've decided to keep some options open and support boolean_term,
> text, and phrase for now.

What's the difference between "text" and "phrase"?

> boolean_term is the cheapest and probably best for exactly
> matching labels/enums and such.

So, this is for "X-Ignore-Me: Yes" type of headers?

-K

