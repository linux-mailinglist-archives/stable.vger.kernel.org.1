Return-Path: <stable+bounces-43463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2BA8C02A5
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 19:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FDB71F23598
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 17:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07C310A11;
	Wed,  8 May 2024 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="ddtdl6os"
X-Original-To: stable@vger.kernel.org
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DCA79F6
	for <stable@vger.kernel.org>; Wed,  8 May 2024 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188169; cv=none; b=j5W9TQEElseJIKxzYk0jRg24GkzQjsnXes6DHkaHosI/1iuEfUNKZXqEhQkxCkD+9QgrAZdhbhpAxfmKs8DYVCC8QxfFn7jwlGcwbXGUledKjDzsbXx12YJVcmv0HTX3weqInK6fIgkyL+bEsTyCOhKLfv4+Zuxpp3xtysSN5w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188169; c=relaxed/simple;
	bh=5g3YO49XlIUU24NL8KitPYP5DAPbN/hPKLwuTE+S3Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPzVZmIi7o9t13U3h1t6WCrCWSFOfIPwjjomr4wB7I7MWcMieYo7EbP3McVDZoQ1SqJ90p8nFXhEExPHiUvsUZ+bJgn7jrvLkrs2hjxn6Ws9ij54Awl7qzXOvnWIb0A5UHQ8O1nJ//6efP5kCZv09gVCeurlo0OlwewQJ0CWmQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=ddtdl6os; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4C71F44D;
	Wed,  8 May 2024 17:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1715188167;
	bh=5g3YO49XlIUU24NL8KitPYP5DAPbN/hPKLwuTE+S3Cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ddtdl6ospSXvtTRte3hv6TX5JmmBWr92GMfKClc96062/2LKtCloTfxRb8qv2L2w1
	 vvCqdroa5CNp6ljaXtuNhGSwj2xhy2DgD3tpK/1CIghOYXyqS9AN1AfVrcRiEe8pYB
	 vKk+7lmxhvq2lnOlMV6nqb1+zTioj7wYR+lqt97M=
Date: Wed, 8 May 2024 17:09:27 +0000
From: Eric Wong <e@80x24.org>
To: Konstantin Ryabitsev <mricon@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, tools@linux.kernel.org,
	stable@vger.kernel.org, meta@public-inbox.org, sashal@kernel.org,
	gregkh@linuxfoundation.org, krzk@kernel.org
Subject: Re: filtering stable patches in lore queries
Message-ID: <20240508170927.M233061@dcvr>
References: <ZixGx_sTyDmdUlaV@zx2c4.com>
 <20240427071921.M438650@dcvr>
 <20240429-antique-hyena-of-glee-d9e4ac@lemur>
 <20240508113314.M238016@dcvr>
 <20240508-optimal-peach-bustard-a49160@meerkat>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240508-optimal-peach-bustard-a49160@meerkat>

Konstantin Ryabitsev <mricon@kernel.org> wrote:
> On Wed, May 08, 2024 at 11:33:14AM GMT, Eric Wong wrote:
> > https://public-inbox.org/meta/20240508110957.3108196-1-e@80x24.org/

> > Yeah, though there's 3 ways of indexing strings, currently :x
> > I've decided to keep some options open and support boolean_term,
> > text, and phrase for now.
> 
> What's the difference between "text" and "phrase"?

text is like indexlevel=medium (case-insensitive and sortable
by relevance), while phrase is like indexlevel=full so
adds positions to allow searching phrases via "double quotesk

(also documented in the proposed public-inbox-config.pod change,
not sure how clear it was for non-Xapian-internals-aware
folks...)

> > boolean_term is the cheapest and probably best for exactly
> > matching labels/enums and such.
> 
> So, this is for "X-Ignore-Me: Yes" type of headers?

Yes.  Though I just remembered it's case-sensitive (same
treatment as Message-ID with "m:"), so I guess that needs to be
documented.

