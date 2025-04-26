Return-Path: <stable+bounces-136764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D609EA9DB5F
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 16:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B5A4A1905
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 14:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5C725C6E3;
	Sat, 26 Apr 2025 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jf8Sg8l2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA61417E4;
	Sat, 26 Apr 2025 14:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745676671; cv=none; b=lQtHvV/2d6jxOYltOiXNZNctOoO8s+bsPoerSmcBfuOUMBKvD5M3N5PaDIk7+8tz9ut3hMGHqxtCNtATXePC9EyN1kWLyWz3PZawRh2OHE/96xm89KAgwN2gOW/hPkRLrGVBTJ86wWBfR3BGpy5r5PT8u2RETj/MbIN/OV++svA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745676671; c=relaxed/simple;
	bh=hPaHH5Nn9zoq+DRNbpXcA8UPukYnAOHl14A3iSnAnBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBjm6P3dnQu3nPLKrHPvIKS/L7NCH3hCpvGj/LEQOUq3TyrJQN2ETyV/9yumuo1DdZpsk1McgDLpebB7h34zswBhNwql7OlpQ7IHn/NPSU7V+pLusKD5AIvWh9bG1eR+WKPzpiYAM4T9pJqcDFnWSUusHYFX/Uk/65O7BJ4lAd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jf8Sg8l2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EF6C4CEE2;
	Sat, 26 Apr 2025 14:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745676671;
	bh=hPaHH5Nn9zoq+DRNbpXcA8UPukYnAOHl14A3iSnAnBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jf8Sg8l2aZq7eKqe/QH/7zpXkXKhbuTX0cRQk6A/cWJlW+SKDZV5TitypE6VJn9ku
	 9OC4mC4jfUJMZwEa/+xPTpoxmn0+5ybL+OpkJGV5+btCrLBliRmQOuo+plGHdh2zjs
	 RhdnTRNg2w1l8ZoIjmgNNqshyNRmnK39KnqEw8B/YKHSV5QH4wfbHIDjtXbOGd3JyR
	 x0b5dqZ+j9Ulg0vPjfE3PUjFsfXDX5DA9jI/WUgt8EP7dTi91jrSCnCM4Jvg+doaEK
	 GCOolwHKpJzm/5gk6Sh99xS+EZipGGnsLOCY1vuOiY4Wkwm/7dUcl7uOJAFIvNzUDM
	 z0pz/SsCxj7nQ==
Date: Sat, 26 Apr 2025 10:11:07 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Patch "lib/Kconfig.ubsan: Remove 'default UBSAN' from
 UBSAN_INTEGER_WRAP" has been added to the 6.14-stable tree
Message-ID: <20250426141107.GA3689756@ax162>
References: <20250426132510.808646-1-sashal@kernel.org>
 <71399E4C-AAD6-4ACF-8256-8866394F3895@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71399E4C-AAD6-4ACF-8256-8866394F3895@kernel.org>

On Sat, Apr 26, 2025 at 06:33:24AM -0700, Kees Cook wrote:
> 
> 
> On April 26, 2025 6:25:09 AM PDT, Sasha Levin <sashal@kernel.org> wrote:
> >This is a note to let you know that I've just added the patch titled
> >
> >    lib/Kconfig.ubsan: Remove 'default UBSAN' from UBSAN_INTEGER_WRAP
> >
> >to the 6.14-stable tree which can be found at:
> >    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> >The filename of the patch is:
> >     lib-kconfig.ubsan-remove-default-ubsan-from-ubsan_in.patch
> >and it can be found in the queue-6.14 subdirectory.
> >
> >If you, or anyone else, feels it should not be added to the stable tree,
> >please let <stable@vger.kernel.org> know about it.
> 
> Please drop this; it's fixing the other patch that should not be backported. :)

This one is still technically needed but I already sent a manual
backport for this...

https://lore.kernel.org/stable/20250423172241.1135309-2-nathan@kernel.org/
https://lore.kernel.org/stable/20250423172504.1334237-2-nathan@kernel.org/

Sasha, it is a little insulting to me to have my manual backports
ignored while you pull in extra unnecessary changes to make them apply
cleanly, especially since I sent them straight to you. I already spent
the effort to account for the conflict, which was not big or nasty
enough to justify pulling in the upstream solution, especially when it
is still not ready for prime time, hence this change...

Cheers,
Nathan

