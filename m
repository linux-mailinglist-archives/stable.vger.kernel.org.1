Return-Path: <stable+bounces-41542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8089D8B44E6
	for <lists+stable@lfdr.de>; Sat, 27 Apr 2024 09:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3E81C21198
	for <lists+stable@lfdr.de>; Sat, 27 Apr 2024 07:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5998842062;
	Sat, 27 Apr 2024 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="fKlouLy1"
X-Original-To: stable@vger.kernel.org
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FFE4086A
	for <stable@vger.kernel.org>; Sat, 27 Apr 2024 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714203148; cv=none; b=gg/j3OkyJXWGZmfMiJ6eARoDuEewyAPgCK47JLGGws6B357ncZ0Pwgfp11lQtZ4pfS42aB9ekVCesCwPTgLjnYRLy4mT3IAAVTOoA6b4SWdDWyGx8QcAmlF9zQVTx9N0p1EBJXW3gi6d8Bil9kW/NlDLLShVl6Bud6OkNp6Yxus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714203148; c=relaxed/simple;
	bh=5vU1T0UVEyOf/68S0xDggngugoHOxNHI/tP/+jNzglE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwS/9TTobLaDZebVSaVAd9z58UZ6D2+BtaBYy7WVnVVb1c96lxfCqF4iOXI2C3dQbobMhKl3glK4lEaZ0dIvZnoefyvwIu7BTDg3a6Qt/qJNP+bWg+43tAgQF/RcOlGpZ5LsXcIEOZ5HKwK04rQ8BJmndbCwEmiUR2atBu1uLuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=fKlouLy1; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EE621F44D;
	Sat, 27 Apr 2024 07:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1714202809;
	bh=5vU1T0UVEyOf/68S0xDggngugoHOxNHI/tP/+jNzglE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKlouLy1Yl4l8K3dMvQtecBNIzKiAWU7s9Pmqy3EsUS4s9DSXZZ22+vvo0SZIFmbe
	 1WB8LxjiVPiZat6i4aCCOQ4V3hI+UWs6ZiB8Fw+c0jdeWhXpOXEFFdjlDtXJr5CNS4
	 W29KaEgQF1B9RK6LardBup0IX7XxCwr4ShDQLNwQ=
Date: Sat, 27 Apr 2024 07:19:21 +0000
From: Eric Wong <e@80x24.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: tools@linux.kernel.org, stable@vger.kernel.org, meta@public-inbox.org,
	sashal@kernel.org, gregkh@linuxfoundation.org, mricon@kernel.org,
	krzk@kernel.org
Subject: Re: filtering stable patches in lore queries
Message-ID: <20240427071921.M438650@dcvr>
References: <ZixGx_sTyDmdUlaV@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZixGx_sTyDmdUlaV@zx2c4.com>

"Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> Hi,
> 
> Greg and Sasha add the "X-stable: review" to their patch bombs, with the
> intention that people will be able to filter these out should they
> desire to do so. For example, I usually want all threads that match code
> I care about, but I don't regularly want to see thousand-patch stable
> series. So this header is helpful.
> 
> However, I'm not able to formulate a query for lore (to pass to `lei q`)
> that will match on negating it. The idea would be to exclude the thread
> if the parent has this header. It looks like public inbox might only
> index on some headers, but can't generically search all? I'm not sure
> how it works, but queries only seem to half way work when searching for
> that header.

Correct, public-inbox currently won't index every header due to
cost, false positives, and otherwise lack of usefulness (general
gibberish from DKIM sigs, various UUIDs, etc).

So it doesn't currently know about "X-stable:"

I started working on making headers indexing configurable last
year, but didn't hear a response from the person that
potentially was interested:

https://public-inbox.org/meta/20231120032132.M610564@dcvr/

Right now, indexing new headers + validations can be maintained
as a Perl module in the public-inbox codebase.

For lore, it'd make sense to be able to configure a bunch (or
all) inboxes at once instead of the per-inbox configuration in
my proposed RFC.

At minimum, one would have to know:

1) the mail header name (e.g. `X-stable')
2) the search prefix to use (e.g. `xstable:') # can't use dash `-' AFAIK
3) the type of header value (phrase, string, sortable numeric, etc...)

I'm trying to avoid supporting sortable numeric values for this,
since supporting them will problems if columns get repurposed
with admins changing their minds.   A full reindex would fix it,
but those are crazy expensive.

So probably just supporting strings and/or phrases to start...

Validation to prevent poisoning by malicious/broken senders can
be useful in some cases (and the reason the RFC was a per use
case Perl module).  That said, I'm not sure if much validation
is necessary for X-stable: headers or if just any text is fine.

