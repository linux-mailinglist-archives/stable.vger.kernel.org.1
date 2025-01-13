Return-Path: <stable+bounces-108532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4274A0C2D4
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 21:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148081889006
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 20:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8351C3038;
	Mon, 13 Jan 2025 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jDwj56jI"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2131D4601;
	Mon, 13 Jan 2025 20:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736801785; cv=none; b=e1HlLQSf8J6HEwegufDBdancJcnnm+hI48hXCW+lYsB9pV/jDMaaodirHaoedYi2d10+sz6SpV1SmioirytUKP44grhIHaxjqmSjPqrFoLO86AQzJ61XdF2amVxEbXv5jgnFVupryavu46b57p48OwTtpeSS6Uygey0y3OqYOkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736801785; c=relaxed/simple;
	bh=mMKGkrM3J2V+ph2mnG4zUs5WkED7vPW02vzF0H7czqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDF+Zt/UVj8+5VGZDirwbLYnWtR18/X+DIi54sbavGW1pzSRTExLfI3zvRer0MjZVteRxea6X/gsiPKwLU2ADVVNM8tzdxX9KZQSBZ/Gp3M27tuTw1d15rLXPwNFJdUFta7l/bQp7WALE9+vO/JEgyb5MQwFqqO29BEcl3BuSP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jDwj56jI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1194540E016C;
	Mon, 13 Jan 2025 20:56:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aEH-oHTBFUf8; Mon, 13 Jan 2025 20:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1736801777; bh=F7I2roNCv0cA2xwHwq/SdVFKPAdjkOPbUq+jG56LmT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jDwj56jIxyiwybo2fHKx30mPor7XD1jCyqIXo+pqTQJES3SShMGbYwv2jrmMqVKfg
	 F8wTtPcJpmgKDDAlnVZMSa5mcWl00K5w6XLio0AzgwETz1MhN+wCiH7FSIyi29tf5Y
	 LCE5H8V9K2NkBgDYzuTeoSndempNPu5H7oSYqPQA7IIG8g60IGeSHyCPvHXnUbEiDn
	 1DqGGQyRtHFMp7uJ3J+OuGag43VavVJtQEjXo0o6oTQCmDlKh6qzBvpVfckL6QP7CR
	 FD+Bio9azT6wLrpOc4GuXvqNQPY+vB6CqbUvKtAoMvX5HbhccclqGBafmzHdv7nwQ4
	 jSqTOUx9E1He3TBkVAh6pInUoU+665M/VPUJQp0S3mqqscBovzC4RhJbL1bUqZfqhu
	 zAsHC6uqWOxqppfPM+lGZvhf+If4AXPkyOjGOaaxe6zZ5su3U99iZXrbIJsrLvT67A
	 gXJ8ImkuLGf+YE5LrBeT1VuvdmmOmMwqGWTV2vS9WivObqUn3Z0a6o5PuAPjB0pJhS
	 ro50FLf6ILwTUJBLl697/ZFOfrB/ckunEM3A1no8NIUqVT4ruGSF0CQ58Oz0v9Mshx
	 t2EdNFrrYSiUvRsQ6de9JsSvAcyKhs0TAxb2vJFcBGwXNdpq1FN+pyjKsUKq0HLE86
	 VCsoJI9zvHpY/2ZJOzJqdM5A=
Received: from zn.tnic (p200300Ea971F9328329c23Fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9328:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6C3F340E021A;
	Mon, 13 Jan 2025 20:55:47 +0000 (UTC)
Date: Mon, 13 Jan 2025 21:55:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Chan <ericchancf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kai Huang <kai.huang@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Russell King <linux@armlinux.org.uk>,
	Samuel Holland <samuel.holland@sifive.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, stable@vger.kernel.org,
	Ashish Kalra <ashish.kalra@amd.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCHv3 2/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as
 encrypted by default
Message-ID: <20250113205539.GIZ4V9y8qq-45uVEcV@fat_crate.local>
References: <20250113131459.2008123-1-kirill.shutemov@linux.intel.com>
 <20250113131459.2008123-3-kirill.shutemov@linux.intel.com>
 <1532becb-f2be-4458-5d34-77070f2c5e2d@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1532becb-f2be-4458-5d34-77070f2c5e2d@amd.com>

On Mon, Jan 13, 2025 at 02:47:56PM -0600, Tom Lendacky wrote:
> This patch causes my bare-metal system to crash during boot when using
> mem_encrypt=on:
> 
> [    2.392934] efi: memattr: Entry type should be RuntimeServiceCode/Data
> [    2.393731] efi: memattr: ! 0x214c42f01f1162a-0xee70ac7bd1a9c629 [type=2028324321|attr=0x6590648fa4209879]
> [    2.394733] BUG: unable to handle page fault for address: ffffc900b4669017

A wild guess: looks like it tries to map EFI memory encrypted now...

Anyway, lemme zap. Those will have to go through the full motions of testing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

