Return-Path: <stable+bounces-123210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB59A5C222
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 14:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509CB3B1D93
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 13:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9232146A68;
	Tue, 11 Mar 2025 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="j1KKI1xt"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258272F852;
	Tue, 11 Mar 2025 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741698864; cv=none; b=boMc8zlqTphxym/y9m872/jQqbXt2XSjZAkmeix6VTOhXSjvLczdxVZykyjxGhi1kFwY+pud6PNrD/0/bw+ZNPZqDLIlNzkM20Yatbtm/aojOYi4MMlvlFFWR6THOmfdi0vfKUsUpiFMuSsML5DKaY3rjfOPKo8hM9FkwM0kVVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741698864; c=relaxed/simple;
	bh=BQhfhUseX2V5jOLDq+Btn1RgTFexdcL1iRxgHTbENu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dR3ROsiglmLUg2zZFU+v0e9fDkxZrE9hSzcjEZyz+GNqDMt1uJk9ydny3BQJXcc2uxGx2jrU6QBHcHZok00qcAqlH/9VLEtyuEK9s8GDfwYMY8zwWDuw4xxp+T+WjR7/jDf7pntMBObuGcMnGjKz7Y7mHjmUtUMH4QqJOB0/vX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=j1KKI1xt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C595440E0217;
	Tue, 11 Mar 2025 13:14:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ojfAd7syJE-p; Tue, 11 Mar 2025 13:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741698855; bh=W+a1kySbYasmLefuZgIGtPN2vooFA0YmQ9WzL7MYfbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j1KKI1xtIUbq42L0uhB/iHHl3YYD9CzV7pmFwiaScE00EgYVuLYjbBBVolOeDCrAx
	 xqjEpOS9ifhrtIt3gSmpsoelwSf0na4KBtQZS5N15ilgRQexaDCvM84Gfz39mn09k2
	 y6sN26WQxY5gA4O8E0UkH+9FH8EQcI914csBYLsHM+4FPwkkm6i096vB8/0HqrmGQz
	 PelkFSguactTL5YMY8UlK3um7TNy7uPrkzR3by7uNk4cz+Un/WhYTtGIDlmLulFwg/
	 Ky/GFJIxd4Tm0tL/fjH0e0U5sQSoytYIJ+S75mhLegprR3+Hs9AEb2Fc3SnEsWJfkg
	 ByQrf9rdDSGuAo+DKy5XWkOt9jPYibzTMwkSwPpSjAYCSfDBZ+lRUB3KSYjUWRDscd
	 s+ZuGlJ0gIwcuWQsBL71ZDw4GDGBqHpGbB2Cscm0kWTI/Aw9L/i0jv4uCX5y++0reR
	 CWfTSEXgIAmzeLuV4woHgWn6PLRUebRo1T0Nqr+XAKqEW3JhVtG69tizzWhSRGroDf
	 nS8TMwJXPSZsKdDPqhtwhtfx4vZzrkUnYoBJ5JzrEw8N9SkfLekbaTMbn7ZZOhjinR
	 xxHlBpRXJa8wdLPZY1nODbeJS4JPSzxYCdtHbrYk76zCyyLqy88E3AiQfCPYiPT+gc
	 sDz6N2NW+UwDbpiUKdNxFfV4=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A0A7940E01A5;
	Tue, 11 Mar 2025 13:14:02 +0000 (UTC)
Date: Tue, 11 Mar 2025 14:13:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org,
	Fangrui Song <i@maskray.me>, Nathan Chancellor <nathan@kernel.org>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/stackprotector: fix build failure with
 CONFIG_STACKPROTECTOR=n
Message-ID: <20250311131356.GGZ9A3FNOxp32eGAgV@fat_crate.local>
References: <CAMj1kXGKCJfBVqgsqjX1bA_SY=503Z-tJV893y5JAwoVs0BUfw@mail.gmail.com>
 <20241206142152.GB31748@redhat.com>
 <CAMj1kXGo5yv56VvNMvYBohxgyoyDtZhr4d4kjRdGTDQchHW0Gw@mail.gmail.com>
 <CAMzpN2iUi_q_CfDa53H8MEV_zkb8NRtXtQPvOwDrEks58=3uAg@mail.gmail.com>
 <CAMj1kXF8PZq4660mzNYcT=QmWywB1gOOfZGzZhi1sQxQacUX=g@mail.gmail.com>
 <20250310214402.GBZ89dIo_NLF4zOSKh@fat_crate.local>
 <CAMj1kXEK0Kgx-C8sOvWJ9rkmC0ioWDEb+tpM9BTeWVwOWyGNog@mail.gmail.com>
 <20250311102326.GAZ9APHqe5aSQ1m5ND@fat_crate.local>
 <CAMj1kXHTLz4onmR5iyowptRE38RCK4jNT3BoURBkq2FoDOMTxQ@mail.gmail.com>
 <20250311112112.GEZ9AcqM2ceIQVUA0N@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250311112112.GEZ9AcqM2ceIQVUA0N@fat_crate.local>

On Tue, Mar 11, 2025 at 12:21:12PM +0100, Borislav Petkov wrote:
> Yap, that fixes the build:

Lemme run randbuilds with that one, see what else breaks with it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

