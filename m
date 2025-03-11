Return-Path: <stable+bounces-124064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC0CA5CC9E
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 18:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0920189EFE4
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 17:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A831EDA3C;
	Tue, 11 Mar 2025 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IjQQwbbx"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8093111A8;
	Tue, 11 Mar 2025 17:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715220; cv=none; b=lkcRNtwuMO7PU0e9XdKz/brcFXPhgyNLoj16vpX5obIgQcXlnhMtlrDh4bfdTmA5cldJngDbE4MhROCbtjzCihaMW9t0au9O/KRHS7Zt0y+TrGHF5L0a3XthTdwtchosE+zvfnMwdKUDexthqnRiFI4Nfe6nvTjcJ6vL5gFtAB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715220; c=relaxed/simple;
	bh=nwhWEGzoioVXQi3pcbBlfOFcFxaPTcq0t/BPzrgTP2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brCkzF0THPGB/U49mJxbp9Wi6OSWrPRusGS81FLxpl5ZSXmbPO/0J+XiOAXWC/iGqQI65YhXYk6Xo191cM0OnvYy0XayIlSXk/jPvUHTRsaNC46CnXbTnkeBKx4IOTG/n7EOl+KtaQYhUIAJhNzf8rMe/moxhGebZZXaS5Xmpd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IjQQwbbx; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2336C40E0202;
	Tue, 11 Mar 2025 17:46:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 39_9nZ-X5WDN; Tue, 11 Mar 2025 17:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741715207; bh=Bl+D5XXLoZoFwC3dCvraUavAmTgnsUaFJpUWZH1nq3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IjQQwbbx9+24eu2UN+Hn3aBDS4i9gO18Vp0gXH1DNEBP1/aav8evh4VgxBA/1YuaO
	 SDCoLXTkwITxXZYDyjpdB6qfKle739gAypZbdGSTAbtxuEKFWDKLp6kmrXrW74nLsF
	 7Yf5A2YAQNsqIDoSUe/6tTT+Itf7shSgKcZDwQyTWb27Tq48Sq80l3Kv4ZbkK0nwIF
	 RgV1IjXyxG02TM3zQ5d2u9eXVZEfO8XJ978DWnc5yD8DDhs2BkiVlZJzO/O7s6ug7x
	 z4ZE+dBN2qMq6+XpFoICLThZkNqJAAS8mFZgWQ4KvHm76PpJ51c5AzuJkt83xBBf6d
	 Lr4HsvmALsbACIQyufSyfhDVH+qoG7Xt76VJlskNgdJ4SjbQcp5uuD3Ec7B9oAE1TL
	 EP7sqHDWHY4/ARirLWSYJIIFGN1hrDeU9mCg2sZwT6Hgengn0OC9HfnDjoVv4kdmwO
	 6fFRrRxfE0gl3+VhlHY932QHOgphqK+QigcSJdy4I+05LwzDa8isvM4V+KHzmZgioM
	 TGqZfTpwk65EVhOSIZH829zes+EuTjOhmunUuBnv7JfMU59CDINk+Z5x4lN9zAyVK+
	 5mgwid+OVigqUG3UyH7hiR8/M4LNyEBolOse/fW6+QzEfvneT2u1WCswmUx5JN+qin
	 nu1hYfP8gG7qa8P4GNv2byPQ=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0CD7E40E01A5;
	Tue, 11 Mar 2025 17:46:33 +0000 (UTC)
Date: Tue, 11 Mar 2025 18:46:26 +0100
From: Borislav Petkov <bp@alien8.de>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Brian Gerst <brgerst@gmail.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org,
	Fangrui Song <i@maskray.me>, Nathan Chancellor <nathan@kernel.org>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/stackprotector: fix build failure with
 CONFIG_STACKPROTECTOR=n
Message-ID: <20250311174626.GHZ9B28rDrfWKJthsN@fat_crate.local>
References: <CAMj1kXGo5yv56VvNMvYBohxgyoyDtZhr4d4kjRdGTDQchHW0Gw@mail.gmail.com>
 <CAMzpN2iUi_q_CfDa53H8MEV_zkb8NRtXtQPvOwDrEks58=3uAg@mail.gmail.com>
 <CAMj1kXF8PZq4660mzNYcT=QmWywB1gOOfZGzZhi1sQxQacUX=g@mail.gmail.com>
 <20250310214402.GBZ89dIo_NLF4zOSKh@fat_crate.local>
 <CAMj1kXEK0Kgx-C8sOvWJ9rkmC0ioWDEb+tpM9BTeWVwOWyGNog@mail.gmail.com>
 <20250311102326.GAZ9APHqe5aSQ1m5ND@fat_crate.local>
 <CAMj1kXHTLz4onmR5iyowptRE38RCK4jNT3BoURBkq2FoDOMTxQ@mail.gmail.com>
 <20250311112112.GEZ9AcqM2ceIQVUA0N@fat_crate.local>
 <20250311131356.GGZ9A3FNOxp32eGAgV@fat_crate.local>
 <20250311143724.GE3493@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250311143724.GE3493@redhat.com>

On Tue, Mar 11, 2025 at 03:37:25PM +0100, Oleg Nesterov wrote:
> sorry for the off-topic noise, but what about the
> 
> 	[PATCH] x86/stackprotector: fix build failure with CONFIG_STACKPROTECTOR=n
> 	https://lore.kernel.org/all/20241206123207.GA2091@redhat.com/
> 
> fix for the older binutils? It was acked by Ard.
> 
> Should I resend it?

Can you pls explain how you trigger this?

I just did a 

# CONFIG_STACKPROTECTOR is not set

build here and it was fine.

So there's something else I'm missing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

