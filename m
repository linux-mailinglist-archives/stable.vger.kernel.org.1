Return-Path: <stable+bounces-267970-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vN5TKe+oOmrKCwgAu9opvQ
	(envelope-from <stable+bounces-267970-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 17:40:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 578696B8603
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 17:40:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=armlinux.org.uk header.s=pandora-2019 header.b=AD3aDmyJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267970-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-267970-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=armlinux.org.uk (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59CE6303E669
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 15:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF7B2EEE7C;
	Tue, 23 Jun 2026 15:38:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532F42E2DFB;
	Tue, 23 Jun 2026 15:38:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229126; cv=none; b=TeO0a9WmaXUGeX0kwAM+lykLSuhQSUoWaiQ67XQbsUqehBygrc0CP8diqI/ifgvqIo+FaXufINTJ6TeK8v0NqKFxFelua9+y0PwBnmcEynlYiya9pQy7I1aTFBHmRuGslLa0LqKZVCy7iS6SktvEc9Z04H9dqdgkTnOTzkF4Nh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229126; c=relaxed/simple;
	bh=DlpC8iX9i2ChGTTTisRm8lz+5j3ZuPlZnjNXuGq91ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYayRFCwI3G56Wsd1GDj60Scz4i48Jhs0fxXH0nLcrJQId5Lgte3Rx1rNv4/oRX4TIdJs9ooOGDNxD2+4MDicTM0S46M9Yuqs2ImRUYWSgm/2BFEVyUOh8mjOaQ+LIyaxDHcSl96fig9F4PvMS/FwgHV0etlSmsD5CShA17MFg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AD3aDmyJ; arc=none smtp.client-ip=78.32.30.218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tahpwPBsIqkK2DZXP8CbqTvt8ELiLk3+QbKeYnv5Rw0=; b=AD3aDmyJQtwixoR95Xhyg0WCc9
	9fboEQpzfsnSSfjiRXif78aiTQrsDaww8+Q4LG/LJMNueJCAAFI6dZqANp7mmWeFCoK4A3arszi8L
	oOvfKOArleat0APyUrZWh3nRSgx6vzhLkkfC1QXxWf5xBFwnforLgEg7HWMTEjGzqenLpaBFUDZzV
	sO/MjO8hBqS0Wm3EzgY4keURCWUyNg3J87az3a6vcQona/V+8B2zl/Xs94OuNRZ2aTkQwkbZ7ntY2
	rO2au2j365TWeLohb8WvndDgP5a8b7cj6sraKH3jcIt0Bl7y6FVrsj5byA8+/hFBAOA6y8Di+AyQI
	/18RaMGw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44252)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wc3Cz-000000006zt-2r9l;
	Tue, 23 Jun 2026 16:38:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wc3Cy-0000000005w-1Acs;
	Tue, 23 Jun 2026 16:38:40 +0100
Date: Tue, 23 Jun 2026 16:38:40 +0100
From: Russell King <linux@armlinux.org.uk>
To: Linus Walleij <linusw@kernel.org>
Cc: slipher <slipher@protonmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] 32-bit ARM's BKPT instruction no longer works
Message-ID: <ajqogLBBgupJuD8A@shell.armlinux.org.uk>
References: <kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=@protonmail.com>
 <ajhHYKyvL9nCUvG5@shell.armlinux.org.uk>
 <zbEOoL4_phCCh7td7DwqQtyhleFJ_G3yRBc8AFjT5hwIwcRipRMsjtIVJgLi3t5vJk5QsuKjY9c8I91nuVSYk4-xlzrAqigMWIE0iNMc9PM=@protonmail.com>
 <ajhof3cRtiN0Hk7k@shell.armlinux.org.uk>
 <ajhyyq_SscBAOFFY@shell.armlinux.org.uk>
 <DUmi3WqfISs6WPqSP0CfEAYosyWQN5F7owhotvDcuyyv7WFoloOeHyoatIx6TKimecbF_OFncDikItB-0ubyO5doBOvsIhEKMQsT2wHyeuE=@protonmail.com>
 <ajpWaTW9uXWqX1OA@shell.armlinux.org.uk>
 <CAD++jL=C0mnn-PCqZB4zg7y1=u-W4mEOt+NR3OQFzpdwSR-9Og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jL=C0mnn-PCqZB4zg7y1=u-W4mEOt+NR3OQFzpdwSR-9Og@mail.gmail.com>
Sender: "Russell King,,," <linux@armlinux.org.uk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267970-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:slipher@protonmail.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:regressions@lists.linux.dev,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[linux@armlinux.org.uk,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[protonmail.com,vger.kernel.org,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,llvm.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 578696B8603

On Tue, Jun 23, 2026 at 03:35:05PM +0200, Linus Walleij wrote:
> On Tue, Jun 23, 2026 at 11:48 AM Russell King <linux@armlinux.org.uk> wrote:
> 
> > Let me also be clear: I expect Linus W to fix this
> 
> I'll try!
> 
> I guess the offending commit is:
> commit c3f89986fde7bb9ccc86a901bf28e1f7d69fc3b3
> "ARM: 9391/2: hw_breakpoint: Handle CFI breakpoints"
> 
> > I suspect that the CFI fault code was a decision by compiler authors,
> > but I can't say because I don't have a setup that generates the code
> > for CFI.
> 
> Yep, the LLVM implementers chose breakpoint code 0x03:
> I think it comes from here:
> https://llvm.org/doxygen/ARMAsmPrinter_8cpp_source.html
> Line 1536-37:
> unsigned AddrIndex = TRI->getEncodingValue(AddrReg);
> unsigned ESR = 0x8000 | (31 << 5) | (AddrIndex & 31);

Presumably it's actually line 1618:

  EmitToStreamer(*OutStreamer, MCInstBuilder(ARM::UDF).addImm(ESR));

and if ARM::UDF happens to be BKPT rather than the UDF instruction
(maybe this is configurable? Can you check what this is and whether
it is?)

If LLVM is also using the BKPT instruction, then we have a compiler
binary interface vs userspace program using BKPT issue...

Given the "no regressions" rule, this means we can't ever support the
LLVM CFI BKPT usage unless LLVM changes... and that creates a
regression for the compiler people, because they have to care about
more than just the Linux kernel and one userspace program.

I don't see a clean solution to this, other than saying "No!" to
LLVM people and backing out your change.

Maybe our nameless regressionreporter can find out which BKPT
instruction(s) is/are actually being used (it takes an immediate
value.)

This makes me want the old days of Acorn Computers back, because
*they* were sensible when it comes to instruction sets and fields
such as the immediate in SWI/SVC - they had the foresight to state
that the immediate would be broken up into fields which included an
OS identifier, effectively separating the numberspace so that
different OS etc avoid clashing with that instruction. Linux had
a time when it supported running Acorn RISC OS programs natively
as a result of that in the days of OABI. Seems to me the computer
industry just goes backwards. :/

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

