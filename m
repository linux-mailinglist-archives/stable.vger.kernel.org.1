Return-Path: <stable+bounces-215978-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEOrALP4jWnz9wAAu9opvQ
	(envelope-from <stable+bounces-215978-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 16:58:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8AF12F26A
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 16:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CF523043D5D
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 15:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E151E3033C1;
	Thu, 12 Feb 2026 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OZZsWmXg"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26C71D5147;
	Thu, 12 Feb 2026 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770911918; cv=none; b=THGit/+T2Reg/9pR+B+B88L2wAnLwvUhW5AqZNHlm1RbWgb/OouiyzWSu9euMvIVevkErHAu2JJZ0XMcydK3kujzk9B5WC78ELEMNHGRwZdQhlJGXZpEvNLoiCiLNcfNfjBeOnz+l5C9lo5c91z/S4RRZ3aJxGDoCq0RlpR1Oh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770911918; c=relaxed/simple;
	bh=G0lzjGkLz7KOv67ffxg4ifcAGjXZMix2D+1CjjIoXUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/JMab5HIFeiw0nPbhCV6IzMZUelkpVtPlezQCu3vaWkXj56XBVOjaQP30xtZVALSp4xM1tMGiUXshsjoK9OKopZIpt43LBpbrOT26K4pOcXmjg73xDVDjTLOTf3n6kQwqv7nTNRHUmR2VDCTnrZoPvq3JJl5u/rCYBNvYb0Lqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OZZsWmXg; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7388540E036A;
	Thu, 12 Feb 2026 15:58:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VyusCkIHNxxu; Thu, 12 Feb 2026 15:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1770911905; bh=UCczMiNTbCNSmwaGGd2wqfRBgSMvWHnpvLD5Txq7LSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZZsWmXgvJMcWZ1Z81uPq0CZ1rOZbbSQPR4d766psC1qMBNpyPenHx93UlyPs22BV
	 4DFtPum4khDz1HwNMdzugmI0dOzQ67uUtdcFRGtmZR15mrsE5YDykS8BoO6PcK3Zku
	 9sft9HnZ8hWsrgCxSEc5t3L9xd+ULot8UzPJyC/TvD8yk0SsWwxErjb0U23MR0pJSU
	 0DGtXZArEr+RlDJg8ed+6mJdEGt2ixB0Zt5IJ5XaSozdwZTtR7sGjHGagR6c/dl47S
	 CLr3dTIwupqhad3Npzw3ZfLmgaUbL274zogR66eoZIBA401hxg4oh77jG3x4Pe97za
	 m6Y8xlOEJKVa9nV6mrX/NzSyfJR528miVQoz18tufh58aB/khxzF8qU3kxymh1OBHK
	 I1baWCSPirkkz9CZoADBGgvGY9kFe3qUYRS0kFQpsAp+mV49ONnTe8oS4ostD1Y73j
	 TjIVicig1xXci2c1zPtz74X6ObrNkX9ne5Qyd1Q2PQXVa1XQu1NEJclqxEukh3rl1B
	 LVkaINWrMmlRMGBsDQyU7OhlsZWzXDRqkJy9RPHZz+rsqgiVuX0SHyxye5k6UJpMuJ
	 PT+nz1aSGjF4YFjCkBIYEUas+TTRmyAA7jxqfWczd65+NH8cuniBoGNGXuX8pnF9Vw
	 GSCshJfLK6oMEdS0AQoqj0o0=
Received: from zn.tnic (pd95306e3.dip0.t-ipconnect.de [217.83.6.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 0D5A140E0365;
	Thu, 12 Feb 2026 15:58:14 +0000 (UTC)
Date: Thu, 12 Feb 2026 16:58:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, pawel.chmielewski@linux.intel.com,
	Farrah Chen <farrah.chen@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] x86/cpu: Clear feature bits disabled at
 compile-time
Message-ID: <20260212155808.GDaY34kOTrEYHLdoyK@fat_crate.local>
References: <cover.1770908783.git.m.wieczorretman@pm.me>
 <32fbbfc16974cfed11e7d2651bce836ba9ceaccc.1770908783.git.m.wieczorretman@pm.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32fbbfc16974cfed11e7d2651bce836ba9ceaccc.1770908783.git.m.wieczorretman@pm.me>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215978-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[alien8.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,alien8.de:dkim]
X-Rspamd-Queue-Id: 6B8AF12F26A
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 03:34:38PM +0000, Maciej Wieczor-Retman wrote:
> From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> 
> If some config options are disabled during compile time, they still are
> enumerated in macros that use the x86_capability bitmask - cpu_has() or
> this_cpu_has().
> 
> The features are also visible in /proc/cpuinfo even though they are not
> enabled - which is contrary to what the documentation states about the
> file. Examples of such feature flags are lam, fred, sgx, ibrs_enhanced,
> split_lock_detect, user_shstk, avx_vnni and enqcmd.

I'm still unclear as to when did we break this? Did it ever work as
documented?

I wanna say yes, I've seen this turning off a feature removes it from
/proc/cpuinfo but I don't remember any details...

> Through the cpufeaturemasks.awk script add a DISABLED_MASK_INITIALIZER
> macro that creates an initializer list filled with DISABLED_MASKx
> bitmasks.
> 
> At the same time add a REQUIRED_MASK_INITIALIZER that can be used for a
> sanity check of whether all the required feature bits are set at the end
> of cpu identification.
> 
> Initialize the cpu_caps_cleared array with the autogenerated disabled
> bitmask. apply_forced_caps() will clear the corresponding bits in
> boot_cpu_data.x86_capability[] and other secondary cpus'
> cpu_data.x86_capability[]. Thus features disabled at compile time won't
> show up in /proc/cpuinfo.

Can you please stop explaining the diff? I can read the diff. Put in the
commit message non-obvious text which is important. Not what you're doing.

Check all your commit messages pls.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

