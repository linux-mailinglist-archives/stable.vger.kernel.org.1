Return-Path: <stable+bounces-267578-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id waF5KnNHOGqkagcAu9opvQ
	(envelope-from <stable+bounces-267578-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 22:20:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F99D6AB8AA
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 22:20:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=armlinux.org.uk header.s=pandora-2019 header.b=UwDjcfsH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267578-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-267578-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=armlinux.org.uk (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B42230022C7
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 20:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA58274641;
	Sun, 21 Jun 2026 20:19:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F251DC1AB;
	Sun, 21 Jun 2026 20:19:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782073197; cv=none; b=k24/w3v0rYf/m4LhiHYRmB0SmjY3pL/4NM3ApZoGezAhJnXKEVfuMWPVyjRLu6fI5DcxZAAFaeUQ804zGpiw4fjvoe475OXBE/5dvJ38HhwqBM3k04IDAZk/TdjpUJHg1jcm8lOrrOrfoRqQMxkSGAHTPxycgeYwu+qW37LBniU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782073197; c=relaxed/simple;
	bh=OxDQya4sv56ck8l8gGXwh400pbujH0EtDBc9DFMZUEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHgyWYoqrLorZ+NSN3y1F6ZzFiweUnYMXDhEZZOavnjZvJOQ1GpkAHWGtd2tHUbRl3pqruJ9p3fYhCPCiB3VbA69VGwyCcc4KkEvhNWFWJff6oUlIjf3cHxB6Ivgp8ZW6TEdVSn9i55Pmk+rX3wKoIJUqX3Ua9ZZ3bd3y6+a7L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UwDjcfsH; arc=none smtp.client-ip=78.32.30.218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=56VzwGPLml2RMJZUA6A+wMBtbfbyi8m/QYimvD9XNGo=; b=UwDjcfsH5FfLDuQ+4T9XZuPX9c
	w6+gfZCT7wqrSyfgSMjIwT8gSsJEVUoPUZjXblyJ85tKj3uPgMUvPCxkuvfcij8+wt4em0dlkLGly
	o1hrCjhDj/nbWEnjyAwuJ4X8srMviD/F8FxVu5O35B6qUoGL/E9WhHy2HSFbiXUsNlWQq7x8Jzubw
	184HBgVEsr5QxOjCAxg4Rveq33V2vyfvxiXDE2dd9BLxvceduJXa9cBk+4n8nV8A4OdaFBjdnCVI3
	XTrPRgHN/6dvEXzSfOJxzKBc8x9ielydeFeesIOnLfSwCkgp9/MkcMnVFdPaS4c/L9mx+y6ww6vbs
	VCSSyDiQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45102)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wbOdu-000000004ZR-0fbx;
	Sun, 21 Jun 2026 21:19:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wbOds-000000006Zt-2lFL;
	Sun, 21 Jun 2026 21:19:44 +0100
Date: Sun, 21 Jun 2026 21:19:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: slipher <slipher@protonmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>
Subject: Re: [REGRESSION] 32-bit ARM's BKPT instruction no longer works
Message-ID: <ajhHYKyvL9nCUvG5@shell.armlinux.org.uk>
References: <kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=@protonmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=@protonmail.com>
Sender: "Russell King,,," <linux@armlinux.org.uk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:slipher@protonmail.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:regressions@lists.linux.dev,m:linus.walleij@linaro.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267578-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[linux@armlinux.org.uk,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,armlinux.org.uk:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,shell.armlinux.org.uk:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F99D6AB8AA

On Sun, Jun 21, 2026 at 07:15:27PM +0000, slipher wrote:
> Consider the C program for 32-bit ARM architectures:
> 
> int main() {
> 	__asm__ __volatile__ ("BKPT");
> 	return 0;
> }
> 
> 
> Expected behavior is that this raises SIGTRAP. Since Linux 6.10 this no
> longer happens; instead execution perpetually resumes at the same
> instruction, using 100% of CPU. It does not matter whether GDB is
> attached. I have tested with an armv7l CPU, but I imagine any other
> variants with the BKPT instruction would be equally affected.

Looking at the code, I doubt this has ever cleanly raised SIGTRAP (can
you check whether it does in kernels without c3f89986fde please?)

What I suspect instead is you get an "Unhandled ... abort" instead
and the program forcefully killed as hw_breakpoint_pending() would
have ARM_DSCR_MOE(dscr) == 3, and the switch() would set ret = 1.
That triggers the fault handlers in arch/arm/mm/fault.c to
complain bitterly, and forced a SIGTRAP to the program to kill it
off. No resumption from an unhandled trap is expected.

BKPT was added in later versions of the architecture. In order for
32-bit ARM to have functional breakpoints with older versions of the
architecture, we had to invent our own breakpoint instruction using
what was available in the reference manuals of the time - and this
needed to be maintained in a forwards compatible manner. Sadly, Arm
Ltd were late to the party.

The ARM mode breakpoint instructions that were chosen were 0xe7f001f0
and 0xde01 for Thumb. These cause a SIGTRAP with a TRAP_BRKPT code.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

