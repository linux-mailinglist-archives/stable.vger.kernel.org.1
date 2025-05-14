Return-Path: <stable+bounces-144339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A387BAB6567
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 10:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8178D3B8C72
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 08:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CE320B81D;
	Wed, 14 May 2025 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YDVFVU7v"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A8821ABCF;
	Wed, 14 May 2025 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747210307; cv=none; b=O8e4WugGIKky+hRFtbfaTM2grmUnagf5sCtEVH1Eqhfxp2wZvY6btgjBFm+lEDzVs3sKm07LUAXkiVcpmJsMy3ZXZ688x8RfEe9jhTiDXRZ7vepC/M1Tek0bz/GrPI5QaczcR+QAzyd/a0yYbEtsjQv+Orvqoh2HKEnTOAqMuBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747210307; c=relaxed/simple;
	bh=HNBqAM7JXRbvo2se9y6yfdhZRKG3Llrhnh2jkIvkrjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGrwr37Gd2CQq8IpaH5ih94vmrEN675yfmTrGkOQyfYPBfmSi5rnYZxWuhFWU7Uzy2RyU41d2n6PEw+0iFB1StaO1TgSBRmw7b2w8o4nY+6AYnMQ8urf/xI9EIJ9oQVq/2h1qQRNX2IOHoCfRtVHxYN5OhnSfDNY2PpNcZ8+0ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YDVFVU7v; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AC53040E0258;
	Wed, 14 May 2025 08:11:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id veJ6WnyXLA6A; Wed, 14 May 2025 08:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747210295; bh=pM6qHR2IMAysyGbXGPcwspD06t/7gB1GJ/HkT8pOlr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDVFVU7vR/w2vT+Gk6MTJLZIDE3jY+xj7DRo0iZQclnvbc0I5dm7aRegiGlyCDczw
	 kYT6i2kHQ1wWXdDarTXZQUICMcgK5fH8cOw89U8yLTRit9uszw3Za9D8rSR6NvqU3g
	 Wbg8NoskvgE3jZJHJqKBIkN3WJvtr9515ZhQeta3k+MO1arNhI0UerTlWBiG10/RWI
	 rIUGLXcOQO8kDbPX6j8lkdLluR5wJ9y32u0fmsWBlgmQmT+rSa5DaT9NZh8yDfoUaY
	 JKuu9zDaFwQvQe0cP8zitudZgX03F4OPm3i1SzS1Uj2hc1DhK3jFyIY/no1R03QxIE
	 PVZNg5mtq+Sy7weyxtkSX1dw8Llw8k+WlMPMN1RXVJ64rVc4kNkA0j7MpPzpJjU2i+
	 xVHboiAEMyRRQJyEhwzrhSh4haXcK/JX1/4lrnG6mqsPTbBBBrJnIlw2EiyTcmf0pt
	 1CTw+hkIV6WjXk8mApe25yTbXSGu3TUt+rER6Ve9Hok8qUC1FZwkcsHG6FwNkzc0ZD
	 rLv4UJH3DCwIjGjFaVTDsTVM8h+0hmgce+psDHfSWjxhyw6P3QJKLyE9sqjQ7eYON0
	 fwNr+A5Bpe7wXHGnEFXaT8fdZmdtZVcA3sY3zXrhhN+X2AniansJv7BSM5Alc0eF00
	 2TcTDEw9Xgs8jzXC50p/adRA=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF2CD40E01ED;
	Wed, 14 May 2025 08:11:26 +0000 (UTC)
Date: Wed, 14 May 2025 10:11:20 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Ashish Kalra <ashish.kalra@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Srikanth Aithal <sraithal@amd.com>, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/sev: Do not touch VMSA pages during SNP
 guest memory kdump
Message-ID: <20250514081120.GAaCRQKOVcm4dgqp59@fat_crate.local>
References: <20250428214151.155464-1-Ashish.Kalra@amd.com>
 <174715966762.406.12942579862694214802.tip-bot2@tip-bot2>
 <aCREWka5uQndvTN_@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCREWka5uQndvTN_@gmail.com>

On Wed, May 14, 2025 at 09:20:58AM +0200, Ingo Molnar wrote:
> Boris, please don't rush these SEV patches without proper review first! ;-)

You didn't read the R-by and SOB tags at the beginning?

Feel free to propose fixes, Tom and I will review them and even test them for
you!

But ontop of those: those are fixes and the "issues" you've pointed out are to
existing code which this patch only moves.

I would usually say "Thx" here but not this time.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

