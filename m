Return-Path: <stable+bounces-161870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7EAB04585
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 18:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D328C173E8D
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 16:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C26725F96B;
	Mon, 14 Jul 2025 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cgwJOvwH"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5CF2494D8
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510806; cv=none; b=nq90sjFbhaq5orenm+UN6ogbUbtGkFDcMkRaMF1SqLp7iGqR3HZygNDbr870XjX0HYTHtDeV7J1NwAApolKsntGSxp11y3Gaxe7MBJW73yPQpnJfDovBGgp9AHo6Mnk80YdtHTX+UBUBJR8PtrPOncaO/8v+ZS2Gw+9L0H4FLgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510806; c=relaxed/simple;
	bh=2mABgtiqbdDUO8VPQlrEbhhG3/K8du8Lb8d2qIsRbq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ms82b4IF7/kcPuIXllx8spZ4dMskY2j6FUL9+P04GoBJXLK+vrhvyGBeHnRpjkA635BTimWEpuh6MnqVghp0mbP3jvJ1xmWsa5YJ2Fl8tOdHOj2ydLv7jt0wYn+0qH9DT65p+YBZrayvueJI6dIT0PwE+clAS8viMGChnfJh044=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cgwJOvwH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8E94840E0213;
	Mon, 14 Jul 2025 16:33:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id e1FeYFmjJidV; Mon, 14 Jul 2025 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752510799; bh=N1zwmld0xEX49as0VVWdEzQKP5r4tvQBDxgGk3RVbTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cgwJOvwHglPX5H6qxMLpnMQMLl3o0UG8aPwOldwpARCwnOsI3XIDm1KNKFi5eBi6d
	 CrUfgxh7TPNUtk2x3oYOHTYnDxA2stRMWZYU5w79KvCdn9YjBd2uEsu6q50O35CgvW
	 j0uCzbpEmjM/7osqYQgqPn1RhIZ3Komu+xveVD6DSzN7e9MGJclqCC9bea+Er4M13+
	 wZDCSEq1ibgZ1Cp7mFXzsWTjo4usu7lCUsp+DCDgXklElovviKmqk8J41R/pECuPdP
	 Nt9yevT3EfrSgSaAmHyuMuMEmYIeVSS9Xi77xvgvgw6ngjkiLsp6K0agr0C1HbL/ed
	 TnYAxdOV9hNjHUXfK5NNf3JUj1H1cNJUpCv28RcfWqTFFTobi7CibLI+ovOIwEbGFD
	 kkFjKdqCn7mpC4FjZ9s8ysYpycEENWYH6MTXodfz3v+J81xv/kZLobkNeIg2Aj5VYr
	 J+kKne217a63srkZ608HxyNLIjw7Ix/wEFIU/ZpUx8rFyjw0Q+oGHS2YJMw265Rw0O
	 Gnu33e2j3JiXTVVnGj2XfYNS/L9EFzd4I/A2fR69jfCBFVP8nwkSmtrsDsmQ/xLlFU
	 jt7YtiCOvBmBuCjofk2VUHUqFEOL/0KdvWW1agrYntUZnjytgFS+uuVdgpgbGIm/Cp
	 wCrnfWrnV7krY+WNRCdrqItg=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5A5F440E00DA;
	Mon, 14 Jul 2025 16:33:17 +0000 (UTC)
Date: Mon, 14 Jul 2025 18:33:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15-stable] x86/CPU/AMD: Properly check the TSA microcode
Message-ID: <20250714163312.GMaHUxSKZjDdU61FB_@fat_crate.local>
References: <20250711194558.GLaHFp9kw1s5dSmBUa@fat_crate.local>
 <20250712211157-88bc729ab524b77b@stable.kernel.org>
 <20250713161032.GCaHPaeCpf5Y0_WBiq@fat_crate.local>
 <aHRiYX_T-I--jgaT@lappy>
 <20250714102819.GEaHTbw207UYtxKnL7@fat_crate.local>
 <aHUwk83588ey0hUO@lappy>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aHUwk83588ey0hUO@lappy>

On Mon, Jul 14, 2025 at 12:30:11PM -0400, Sasha Levin wrote:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=821ca5c7308ff85cef8028124dd0755d0eeced0c

LOOL.

I might have another one though but I'll stick to the protocol.

:-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

