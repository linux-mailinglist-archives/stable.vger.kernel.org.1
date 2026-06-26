Return-Path: <stable+bounces-268897-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d+XyEO15PmoSGwkAu9opvQ
	(envelope-from <stable+bounces-268897-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:09:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CD26CD4C1
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:09:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=armlinux.org.uk header.s=pandora-2019 header.b=SBRqpOjG;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268897-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268897-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=armlinux.org.uk (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDC51302A9D2
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AE4380FFD;
	Fri, 26 Jun 2026 13:08:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C9630D3FA;
	Fri, 26 Jun 2026 13:08:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479324; cv=none; b=nfI/k2Ura5gBtiPR3oq+1gUNZlwC7ChhKnHwfa1V9z7Ny2INMIY4Nz55jVCAO9d3sDBjmbizA5ZU1iQJxTSXh1rrUvomXOqW7T+pde80INFuPQcBVYT9n5om+6bCVJLEb5ckNexqPTWjvLK7Xb0wHIPyTYRHGi1UfdLoNsFyfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479324; c=relaxed/simple;
	bh=gDj52wxZ4uC4CaHinFybUuvJuwDuZHQLoOiWV9brfBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaGNTlo7JeiTAdPqr0/eRrzbwpW1ze2vOpBtUn/FItVc5oa9qJ6dQyYIZIwGHMGYCNZJpBfQ4pPeCtTXowSTryeCk30CqHMKHy2E2vk8rLfMOUKnSc6QaG/eE7mjpd17rhEjDVPNMXLml16CK7lhpPz0QzPPSu18NbisdrQVPeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SBRqpOjG; arc=none smtp.client-ip=78.32.30.218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mb6Z5eduZFzeHCfJHZBrJCC/nld2sOZY2BP3IyMytT4=; b=SBRqpOjG33sqoJkhoOX82R+Jhk
	EatUMwoWPGzS+FScSvCbgSBv+OuFX4WmfFlwvmUH0s7OYWWeyEkNMdRvSbiI72Uv/YiQQ9MQtNdju
	lIY8PzOeB2vvCRpwe1xbbN42vB10zzx79gNCH+HUpLqnN7r0FH40YSEkzJqwARigkhs2J6LCXJaes
	pSpeTCKfY47IIDkqAlyiYwBlTBlWDxypmuL0NefOfW8r6Qf3DeIrSZQhJ2bQo9cDA1Av/IsAlK8Qr
	GotGRAY1zHXopujvHcdfKNUsbrY8I+e3a5cKA/MoC3PXJMdO7oxVB9i3H5twN8W7ISWFY8KtSU3bC
	60Jq0FTw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48874)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wd6IM-000000002Gh-0IRb;
	Fri, 26 Jun 2026 14:08:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wd6IJ-0000000033S-2COL;
	Fri, 26 Jun 2026 14:08:31 +0100
Date: Fri, 26 Jun 2026 14:08:31 +0100
From: Russell King <linux@armlinux.org.uk>
To: Linus Walleij <linusw@kernel.org>
Cc: slipher <slipher@protonmail.com>, Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>
Subject: Re: [REGRESSION] 32-bit ARM's BKPT instruction no longer works
Message-ID: <aj55z9_pk7G7vOha@shell.armlinux.org.uk>
References: <kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=@protonmail.com>
 <CAD++jL=YJGFf+9o8KV+OO_61EL+_z3b7P+eLK=6=r+GOuJiWAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jL=YJGFf+9o8KV+OO_61EL+_z3b7P+eLK=6=r+GOuJiWAg@mail.gmail.com>
Sender: "Russell King,,," <linux@armlinux.org.uk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268897-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[protonmail.com,kernel.org,google.com,vger.kernel.org,lists.linux.dev,linaro.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:slipher@protonmail.com,m:nathan@kernel.org,m:kees@kernel.org,m:samitolvanen@google.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:regressions@lists.linux.dev,m:linus.walleij@linaro.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[linux@armlinux.org.uk,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,arm.com:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,protonmail.com:email,jwhitham.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7CD26CD4C1

On Fri, Jun 26, 2026 at 02:53:56PM +0200, Linus Walleij wrote:
> [Adding Nathan and Kees so we can figure out how best to deal with this]
> 
> On Sun, Jun 21, 2026 at 9:15 PM slipher <slipher@protonmail.com> wrote:
> 
> > Consider the C program for 32-bit ARM architectures:
> >
> >
> > int main() {
> >         __asm__ __volatile__ ("BKPT");
> >         return 0;
> > }
> >
> > Expected behavior is that this raises SIGTRAP. Since Linux 6.10 this no
> > longer happens; instead execution perpetually resumes at the same
> > instruction, using 100% of CPU. It does not matter whether GDB is
> > attached. I have tested with an armv7l CPU, but I imagine any other
> > variants with the BKPT instruction would be equally affected.
> >
> > I believe the culprit to be commit
> > c3f89986fde7bb9ccc86a901bf28e1f7d69fc3b3 "ARM: 9391/2: hw_breakpoint:
> > Handle CFI breakpoints".  The commit defines the method-of-entry code 3
> > as "ARM_ENTRY_CFI_BREAKPOINT", but this is the code used for any BKPT
> > instruction - see
> > https://developer.arm.com/documentation/ddi0379/a/Debug-Register-Reference/Control-and-status-registers/Debug-Status-and-Control-Register--DSCR-?lang=en
> > "Method of Debug Entry (MOE), bits [5:2]". If the CFI option is disabled
> > in the kernel config,  hw_breakpoint_pending() returns 0 indicating the
> > breakpoint was handled, but takes no action. So breakpoints cannot be
> > used by user-space code, regardless of how CONFIG_CFI is set. The blog
> > post
> > https://www.jwhitham.org/2015/04/the-mystery-of-fifteen-millisecond.html
> > gives a nice overview of the control flow in older, working kernels.
> 
> Does simply reverting the patch solve the issue?
> 
> > The following Systemtap script can be used to demonstrate that the
> > ARM_ENTRY_CFI_BREAKPOINT path is used, when running the above C program.
> 
> Yeah it's definitely that one causing it.
> 
> I sent the naive solution to it, and before anyone point it out: no it does
> not allow custom breakpoints to be mixed with kernel CFI, but it
> probably makes legacy systems work on newer kernels since they
> probably don't select CFI.
> https://lore.kernel.org/linux-arm-kernel/20260626-arm32-cfi-bug-v1-1-a467b5050c0b@kernel.org/T/#u
> 
> I understand that this is not solving everything.
> 
> If it is under all circumstances unacceptable to be able to construct
> a userspace which will change the user-facing behaviour of BKPT,
> I think we need to revert CFI breakpoint handling, back put the patch,
> disable CFI on ARM and wait for the compiler(s) to start behaving
> differently on ARM.
> 
> CFI folks: any ideas on what we could do instead of BKPT
> when we hit a CFI snag? Any ideas from other architectures?

This is the root of why BKPT should *not* be used.

The compiler people say "oh we can use BKPT to indicate a program
error."

The hardware debugger guys say "I'm using BKPT for my implementation
of debugging" which takes it away from software usages.

Then someone comes along and says "we can use BKPT in our program
for XYZ and ignore that the kernel complains... oh the kernel
complains, that has bad performance but let's 'fix' the kernel so
it behaves how we want it to".

The problem here is that BKPT is being overloaded to have multiple
different purposes by different people. This *can't* work, and the
only answer to it is... no one should use it.

That doesn't mean we don't fix the regression. That means that we
should *never* introduce any new uses of this instruction in
compilers, kernel, etc.

As I've already pointed out, if PERF_EVENTS is disabled, then the
kernel won't even deliver a SIGTRAP on BKPT, but instead a SIGBUS.
That's not a regression, even though this userspace program will
break - that's the *original* behaviour prior to hw_breakpoint.c
being added. So, this userspace program is fragile and broken by
using BKPT.

What's more is that, as I've already pointed out, if someone were to
report a regression that their userspace program breaks because BKPT
now raises a SIGTRAP rather than SIGBUS, we would have to fix that
regression, which would then break this program.

Aren't regressions wonderful!

So I think safest is that everyone just moves away from BKPT.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

