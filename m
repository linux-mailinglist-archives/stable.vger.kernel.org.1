Return-Path: <stable+bounces-124133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E40A5D975
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 10:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB801189A754
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 09:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F4A23A9A3;
	Wed, 12 Mar 2025 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="d96hELNH"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80126230277;
	Wed, 12 Mar 2025 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741771744; cv=none; b=sGfObdhkq9B09E3EbYojMCzb/sH/KjFsAEaHRnn26LbZMTnjNMjsmH/cFTJvCLfeCP8P6wR9pX7PQVIS2JOCd1e9JFaj3pw6mJH6OyBLYs81+gxVEkNC+0zMs+Wdf457fQn/Ud+CAesBfPddES1/KytShfqAtn6W+mnCy4XpaUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741771744; c=relaxed/simple;
	bh=QGGV/YWbx/zVlrxU7PHHUEBg8dtLN6tC6kKxzib5JEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WY24DYwsGMZbVP7ugZDnVThy0ZQNZqQLojuR6jiyR1Tv8zjfDRIVRWgn8O8os4LhZ7znZ8zI7sTn11sl36xlOdKnbkwrosHJ403U4YBflNMYeIWImn9ZQkvVbZ834h++2+0O4bqbVSZ9dKQZY25KHRNsVJrYWmoR9adXN64w42M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=d96hELNH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 60C3740E021F;
	Wed, 12 Mar 2025 09:29:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jIkBTKvswBUR; Wed, 12 Mar 2025 09:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741771735; bh=FBk2izR1CtgXu19+zXVbtRHMC1wmpKFb/kf0ihaVwYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d96hELNH/h1r8H8NXuJbfD3CoK/YeB14Sqnkrqz9cLbMzWqVvFj4B3VNkyg1v8vOL
	 DM8GLODmgBJtNDsiVZs7sqxuTolK5icOsNzNCZEjgd/0hX0fj8j15Ga23PruSgHncz
	 30UqHXFMctjCaT7Rm8V9SI1JpmbRkc2C/blWaye8Qch2MfjL6kjRzXZARNFjRymdzS
	 sGd4CMd5sblDIjw48SvIoialetDUVUhtB3t/stB04cz8DU/qzY9EAt5vGJEK/lRK/t
	 WwgBmFWutCwkUs35Ghq5Rw2e6FkfnRumdGnrDpYBa1SNdADK9Cr9WAbMeJhO76K7qF
	 He8uO38dSUeKFo7p8T6mMvf5b+gjnOZmg/WbLOMihozcyxacpZodyNqRLIUKsW/ht0
	 ijKYe4P+AooVo4QDgzyzjipIj61H1jJAMBnwA459eUrDhLK9TH4/9VwiunLkUV1kVK
	 vrduPLYkiiQVcyrfX34O6Ld5mRnKWl40OkAwsjqaLTDFKPecPggebNqZhkngJFDE1h
	 42tgTATFoXhhw1yrLColE5XdVXGDCgIw3MuHyhDviKQuJxmVabwLzs18/JD6iV4m7l
	 pYy1edslY6fkyu+fP+iCy4VmWZBl6VygE0Uq6Gb0I17pPEnSqAdPKEwWEmHe7y4lC1
	 yVnMONgorYrxHf1ikLtINdc8=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 249C840E0219;
	Wed, 12 Mar 2025 09:28:42 +0000 (UTC)
Date: Wed, 12 Mar 2025 10:28:33 +0100
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
Message-ID: <20250312092833.GAZ9FTwUz_avVwL6CT@fat_crate.local>
References: <20241206142152.GB31748@redhat.com>
 <CAMj1kXGo5yv56VvNMvYBohxgyoyDtZhr4d4kjRdGTDQchHW0Gw@mail.gmail.com>
 <CAMzpN2iUi_q_CfDa53H8MEV_zkb8NRtXtQPvOwDrEks58=3uAg@mail.gmail.com>
 <CAMj1kXF8PZq4660mzNYcT=QmWywB1gOOfZGzZhi1sQxQacUX=g@mail.gmail.com>
 <20250310214402.GBZ89dIo_NLF4zOSKh@fat_crate.local>
 <CAMj1kXEK0Kgx-C8sOvWJ9rkmC0ioWDEb+tpM9BTeWVwOWyGNog@mail.gmail.com>
 <20250311102326.GAZ9APHqe5aSQ1m5ND@fat_crate.local>
 <CAMj1kXHTLz4onmR5iyowptRE38RCK4jNT3BoURBkq2FoDOMTxQ@mail.gmail.com>
 <20250311112112.GEZ9AcqM2ceIQVUA0N@fat_crate.local>
 <20250311131356.GGZ9A3FNOxp32eGAgV@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250311131356.GGZ9A3FNOxp32eGAgV@fat_crate.local>

On Tue, Mar 11, 2025 at 02:13:56PM +0100, Borislav Petkov wrote:
> On Tue, Mar 11, 2025 at 12:21:12PM +0100, Borislav Petkov wrote:
> > Yap, that fixes the build:
> 
> Lemme run randbuilds with that one, see what else breaks with it.

Yeah, looks good.

Pls send a proper patch.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

