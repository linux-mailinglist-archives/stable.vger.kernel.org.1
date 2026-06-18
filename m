Return-Path: <stable+bounces-267189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aaamC3AzNGpGRQYAu9opvQ
	(envelope-from <stable+bounces-267189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 20:05:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2CA6A20B7
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 20:05:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=alien8.de header.s=alien8 header.b=dZLG6IsM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267189-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267189-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=alien8.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE2013026F3C
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 18:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B982349B15;
	Thu, 18 Jun 2026 18:04:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECE730C153;
	Thu, 18 Jun 2026 18:04:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781805880; cv=none; b=pAI5ps3uacGs/Q1l/3N5a/Qadx02tg1SorT3qMzMrzQAFgM9HlLAPgepobR+fl50/CrZDVHTKO4GSuaos01A7YbzG501bKvMuylo0EVFyp53UX4VpkmzK0Q55awlif2k+BQjUsTUgF1bJCwqccLjshyobGIQZxj1koz4My3v78Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781805880; c=relaxed/simple;
	bh=asCV6mVhebAcBsI5pY4zkhMKlH/JTNoOa0j/1ksyxAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnGwNuVXX/2QzdU3vec9sGzXWJn5c/NQLUIFxPz+Toc4PBR/6NlsDAV1Uk0Zwo6jfV4XAP2fgWG1SsuORcvxT4NF1aIFJDBdw8Z+qW9B6L5oay48ZTgLdoPQF5pSSz+bh6O4Nh7Nt4W7Rz9665DpM8jJHSt8JHL+OAFjEYupzcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dZLG6IsM; arc=none smtp.client-ip=65.109.113.108
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1772A40E0287;
	Thu, 18 Jun 2026 18:04:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rxPkhMsuqx-S; Thu, 18 Jun 2026 18:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1781805866; bh=XnQv5D2k5IknNPuOXROYfjWGZPaMBnb2oHQx2S+36T8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dZLG6IsMrs8iHNd21ABngU5M8iqwxLksYqIj4khXh7hqnEdIfV3gvZP7dfVXsuZdS
	 zHcr6X0P72DrJNaidNAe96Xdd0Bk+//smzfBHu37U4FN7IlMRVtIq/52ZDJ31QcEV8
	 BpCtDNy1vQ5VEYPwpFq1RFRM+iTV6XPaLmq89/FS9eW2GEmBITNa3iv4WuhZ3IT1yM
	 lGdjykcAFE2a1ZW2iGin5V0BshySq+HqAsggpWK3ma+66ch0RzjMTEsnfkna6fUGDt
	 4K9OZYKRQKoCasE2FoRqBgBrRN09pAK4XSy0eGF7XBxLCEDqzQCW6Rk6pd828rDhYH
	 s/O1ZHQvIq+2A42t6W+u9iwUCG7PaW5Xh/nFMBI3D8ur1i1oZCWaaxCmKqEKSbQcep
	 +lRNcoONARf/bqaZkxA3dhPP/imeSfeSnVaWUzxCeEnCngJhBUZEU6edOcr4VL8jVj
	 nY4nOfgA9n6HkU4XHbJtNw8qBO8SyC1tWntT/pijiXfBJZcMcP7iDp9m4Mmyu/42gL
	 8Zm9qOA+aEzJ7AVs3Ak6ZBrtzjL9temV2WXjSJL1lW/NAVHT99JJxPNxBwYWApt3RK
	 dnHwAIbD0gXnANzukueBb7mWsCRZXnltRUGKiqVssi7OKLcaCDphKQ85U1Wr3m1fPf
	 fvaSmm28Y0j/8PrA4/TPmyLg=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 85DF040E01D8;
	Thu, 18 Jun 2026 18:04:15 +0000 (UTC)
Date: Thu, 18 Jun 2026 11:04:12 -0700
From: Borislav Petkov <bp@alien8.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Chao Fan <fanc.fnst@cn.fujitsu.com>, stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: Reject truncated acpi_rsdp= values
Message-ID: <20260618180412.GBajQzHB3Rj0SrS1Eo@fat_crate.local>
References: <20260617130417.36651-4-thorsten.blum@linux.dev>
 <20260618045400.GCajN56AKctO0qB-sF@fat_crate.local>
 <ajQI0mJwobsGHj6F@linux.dev>
 <20260618163856.GAajQfIDh0s31VINiS@fat_crate.local>
 <ajQx7dBWRuRFuKwE@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ajQx7dBWRuRFuKwE@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267189-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thorsten.blum@linux.dev,m:tglx@kernel.org,m:mingo@redhat.com,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:fanc.fnst@cn.fujitsu.com,m:stable@vger.kernel.org,m:bp@suse.de,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[alien8.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bp@alien8.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C2CA6A20B7

On Thu, Jun 18, 2026 at 07:59:09PM +0200, Thorsten Blum wrote:
> On Thu, Jun 18, 2026 at 09:38:56AM -0700, Borislav Petkov wrote:
> > On Thu, Jun 18, 2026 at 05:03:46PM +0200, Thorsten Blum wrote:
> > > get_cmdline_acpi_rsdp() can truncate it into a different, parseable
> > > address and use that instead.
> > 
> > How?
> 
> The buffer has 19 bytes to hold the "0x" prefix, 16 hex digits, and the
> NUL terminator.
> 
> cmdline_find_option() copies only bufsize - 1 bytes, but returns the
> full argument length. So for example:
> 
> 	acpi_rsdp=0x0123456789abcdefx
> 
> gets copied as:
> 
> 	0x0123456789abcdef
> 
> which boot_kstrtoul() parses successfully. The user supplied an invalid
> value, but we silently use the truncated prefix as the RSDP address.

My question stands:

"Or are we protecting people from shooting themselves in foot now too?"

Especially users who should know what they're doing...

IOW, how far are we going to "protect" here?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

