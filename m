Return-Path: <stable+bounces-158848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ED8AECE55
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 17:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96ED71894999
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 15:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0D7129E6E;
	Sun, 29 Jun 2025 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Umk0vxa4"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F9543151;
	Sun, 29 Jun 2025 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751211245; cv=none; b=LH60pG1RY9HrWChcdQxPFGkoo6kUWfLq3WLXBwsDwQqhBXiGjPWe6m+u2qerUUsQlIM9Ofxj21vqRgg2rQXMnAnWwuz/dxpi5BmDC/T7sFV7XDNlDM22YvEYH1uyuEklqrqW/OwiJRSaWvW4ZgTdYaCcQGHMCoQt062NYVFyn+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751211245; c=relaxed/simple;
	bh=x/PSazvyH4MrU/zvRTM2YdHsVtdW9G9hnWye/x7q5Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z851CQ8EI8nAe/1XKktFz5ggmCephaGa+JwR2y3WVaeYVSKiSigTwmfLtMscZwV5OKUTnZZpNaWa2GCymlc9iCG+sbw+YTEwhGbfx6X3hLSIj8W+5DrMkBdaHb2ql+Y2KcnPAbmB8kPZSc7QQxYuEwH7/6L+a0r4eWE70pLSFqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Umk0vxa4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A881640E00DD;
	Sun, 29 Jun 2025 15:33:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vOlxV8vLETgp; Sun, 29 Jun 2025 15:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1751211228; bh=AmLQdFum+cJ7WmHgyisd/mH9zOhwi3o3NwpzZjuDWQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Umk0vxa4hCWdhRkfyOILT1hTrZW8bQ7H9/BmmzeEhSjHTnkXJYTYO8yme/jHhNnvu
	 rhIojLgxEBeKE1x4But70/vYwMkxq9AV2bzSioUx5Sh9iJiimatpL/qg7eA5xXWL/t
	 SiWZQ8HlEGqQv7NMxF6MGf043jdP1KwTuvK5Oi3INSCAWoBqgAQknUFz/DsjtNognj
	 XcPbuBdjhVLCx2eNt9zpF7uT46Tixayj9z3Hek8u3Df62CsqOzK4jLwqKZMU+CHVM9
	 oYV2blqZIVoYJiw3nwcLV/fcueidqAWZIY/obgDb+o9E99HeS1HmSvpHJ6/YNeS91Z
	 zCwQf0AicaE9M+jPalE4ovgmS6WdNXbeK6ULwBF8NaIXfyNOHJ5xOngjR7Y8qc9Org
	 dLTVhADbl/EFkTJ26xPUgSTOn45E2rRGte1jeJ2E5eB9sfAmA7exBHlaf/vvvbPKc9
	 ymbnbN9fT06JwALQxsC3VbbRmFkKt6d+BhPwKCRap1i1ef6VRcWprlkA8EUzw9w199
	 AQT+HU6SdrjArJvLUfz5hI4jdKjZLRxw2yX0FkaD9IVBBYTF4Y4z47mHHUyK+sCYpm
	 rvmKWults0oPDuJJ8YK4sXlKivgdWZQxHwuS26VMlwb7It3zUrHY1Xay8/9wkf/5MF
	 r0Au4JitcWcRY/0Kr/j2HOHA=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6D80240E00DA;
	Sun, 29 Jun 2025 15:33:45 +0000 (UTC)
Date: Sun, 29 Jun 2025 17:33:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dennis Clarke <dclarke@blastwave.org>, stable <stable@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: arch/x86/Makefile REALMODE_CFLAGS needs -std=gnu11 with recent
 GCC versions
Message-ID: <20250629153337.GAaGFc0eLXFRDhpksX@fat_crate.local>
References: <e4742cae-9ef5-4d30-8c88-65f69e2178cd@blastwave.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4742cae-9ef5-4d30-8c88-65f69e2178cd@blastwave.org>

+ stable folks.

On Sun, Jun 29, 2025 at 11:15:13AM -0400, Dennis Clarke wrote:
> 
> Code fix for due to https://bugzilla.kernel.org/show_bug.cgi?id=220294
> 
> The summary is that recent GCC versions ( 15.1.0 today ) will assume C23
> spec compliance and get upset with ye old A20 address line code bits.
> 
> This problem exists previous to the 6.12.35 release tarballs and is
> fixed with commit b3bee1e7c3f2b1b77182302c7b2131c804175870 applied.
> 
> The newer GCC revisions will be quite popular soon enough and this may
> bite people when that happens.

I don't know what the rules are for building 6.1-stable with gcc-15 but if
they do that, then 6.1 will need to pick up the abovementioned commit:

  b3bee1e7c3f2 ("x86/boot: Compile boot code with -std=gnu11 too")

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

