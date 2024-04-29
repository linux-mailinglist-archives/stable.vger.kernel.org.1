Return-Path: <stable+bounces-41739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 454CA8B5B38
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 16:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5EB281A5F
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 14:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67387CF0F;
	Mon, 29 Apr 2024 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwlUZcgO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7447C0BF;
	Mon, 29 Apr 2024 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714400847; cv=none; b=YyVBFU/Lm9+fj5C1IPQJR+VjKsFZ4LOnfPN6Y9HoP5pSa3RBoM+Wv7Rt2aA+cY38NOal9ZdGwFg77KbnJ2Utg682bUbChT/c5bxtVvPdGU1KDoMInL5NnIwg5dvN64DRcJ86UJINiDSmdl2CAc/Jz+MBqy4tJN8V1Edrdp1oWHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714400847; c=relaxed/simple;
	bh=t+icPM1sViMXtjUYUUlsZstD0bTk4xGQr1Fsw27gD20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Toka8bWWMunv8Y7cYL/lTiYFqI9vV9q5ibFYvX3ZiHJNPr2u36BN86NnM4hfXrIT8Pf8G03ADuPgBm2UgRzcX0hsj5BbQW1w6GokHq54x2ODUn/wxyEBja+FsS1fw38ME6dba11kzUCz8KGFz1gjeRAJQjMtgxZozaNTc5KtdVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwlUZcgO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE55C116B1;
	Mon, 29 Apr 2024 14:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714400847;
	bh=t+icPM1sViMXtjUYUUlsZstD0bTk4xGQr1Fsw27gD20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fwlUZcgOJafqKoDUStWy6NyQjkn1Tn3Zv4wDee+56gQKt+bCaElW9zY9mnc1FnCmT
	 remALkUXOHf9cLA3+4AlLJh2UFq5BXCPjsr4aZr9gLTRbqzrIFlwyTwm87/b26JZbp
	 AJCSvJsd8gztJupSP1huosGmCMCojWQzTCDOYr24T3ZvhkmFdADWOUJbzDnYvWZoPc
	 WdhFk7DiDqVeAPCnBJRjPrMdI4268s8SrkksYJaGSJKjmjzr6h9TxyPDmwjEXVSxDj
	 1bPWodjsTr0uiP12F+Su1l49VygXoXl9jE0CiEfZ6qxbNvyyKt2pDFKxAAaZIHQ1Wc
	 +MAlosxJVo/iw==
Date: Mon, 29 Apr 2024 10:27:25 -0400
From: Konstantin Ryabitsev <mricon@kernel.org>
To: Eric Wong <e@80x24.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, tools@linux.kernel.org, 
	stable@vger.kernel.org, meta@public-inbox.org, sashal@kernel.org, 
	gregkh@linuxfoundation.org, krzk@kernel.org
Subject: Re: filtering stable patches in lore queries
Message-ID: <20240429-antique-hyena-of-glee-d9e4ac@lemur>
References: <ZixGx_sTyDmdUlaV@zx2c4.com>
 <20240427071921.M438650@dcvr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240427071921.M438650@dcvr>

On Sat, Apr 27, 2024 at 07:19:21AM GMT, Eric Wong wrote:
> Correct, public-inbox currently won't index every header due to
> cost, false positives, and otherwise lack of usefulness (general
> gibberish from DKIM sigs, various UUIDs, etc).
> 
> So it doesn't currently know about "X-stable:"
> 
> I started working on making headers indexing configurable last
> year, but didn't hear a response from the person that
> potentially was interested:
> 
> https://public-inbox.org/meta/20231120032132.M610564@dcvr/
> 
> Right now, indexing new headers + validations can be maintained
> as a Perl module in the public-inbox codebase.
> 
> For lore, it'd make sense to be able to configure a bunch (or
> all) inboxes at once instead of the per-inbox configuration in
> my proposed RFC.
> 
> At minimum, one would have to know:
> 
> 1) the mail header name (e.g. `X-stable')
> 2) the search prefix to use (e.g. `xstable:') # can't use dash `-' AFAIK
> 3) the type of header value (phrase, string, sortable numeric, etc...)

I'm whole-heartedly for this! This ties nicely to my b4 work where I'd 
like to be able to identify code-review trailers sent for a specific 
patch, even if that patch itself is not on lore. For example, this could 
be a patch that is part of a pull-request on a git forge, but we'd still 
like to be able to collect and find code-review trailers for it when a 
maintainer applies it.

Currently, I am using the following approach:

| Reviewed-by: Some Developer <some.dev@example.org>
| ---
| for-patch-id: abcd...1234

Then I can query 'nq:"for-patch-id: abcd...1234"', but this is probably 
much more heavy than if I could provide this in a custom header:

| X-For-Patch-ID: abcd...1234

and query for "xforpatchid:abcd...1234"

> I'm trying to avoid supporting sortable numeric values for this,
> since supporting them will problems if columns get repurposed
> with admins changing their minds.   A full reindex would fix it,
> but those are crazy expensive.

I'm perfectly fine with it only being a string, honestly.

> 
> So probably just supporting strings and/or phrases to start...
> 
> Validation to prevent poisoning by malicious/broken senders can
> be useful in some cases (and the reason the RFC was a per use
> case Perl module).  That said, I'm not sure if much validation
> is necessary for X-stable: headers or if just any text is fine.

I'd let the consumer clients worry about it.

-K

