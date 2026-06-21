Return-Path: <stable+bounces-267580-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TK/CI11dOGoObgcAu9opvQ
	(envelope-from <stable+bounces-267580-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 23:53:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E33A86ABA9F
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 23:53:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=protonmail.com header.s=protonmail3 header.b=ou1ZxcEW;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267580-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267580-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=protonmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4135300914B
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 21:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4A27081A;
	Sun, 21 Jun 2026 21:53:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31028199949
	for <stable@vger.kernel.org>; Sun, 21 Jun 2026 21:53:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078811; cv=none; b=SAtn030op+SMA8q+3TaSlLspIb9PdQIcAWkv1uGHXRaSh12eoUI0LuS1aEuBHnL6XIJhQD11h3F0SW1Kxuxyse8KgwAAfjS6It4oxKMWh0Mx+NbsuS9SkZ+QVLMsFb6TkfDW/iNgUKhbENgjZqIb76g+QuARk9Kq7mcs8eZNAGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078811; c=relaxed/simple;
	bh=J4aUq+F1WFMlW/D/6ft0V6jKSSupR/BLhO/k5fLS0xg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKNRrLTA2ouUGuuQ4wodZQvd8aVMj/NWxqEeZMIr/M1LyPg22mMJYS9Yrr5K13HnR65WLLyaTX1TcauTNwb2ifAUHJKmVMbqit/dVe525/jFd4us76ZbkXgAFXqeRdvWVp/3uxUv5AP2ZEN/jryIctWaByKdofwTv/NyuvtWtks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=ou1ZxcEW; arc=none smtp.client-ip=79.135.106.119
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1782078801; x=1782338001;
	bh=m87NiDcicjBl1RdAxIJiXY5TTTaKMhW9IomUuRdZcMs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ou1ZxcEWfycmjbZ9Zgr0bSE/jU8xpqnrshxAp5xpSN2zIrZSQ0Bm5rew6tfu96d7g
	 LMsskOLB+9ggzXT2zpkBF8ys0E4imr0UhuC6UUMgMrCrEROY0ZrYMzUzTO+ak24hqS
	 O774sQPYjv2vS1C06w4Sc7ArjgPPUyEy0iBYga0f5vytrnrPw/bP+zj91Iv6qljIRX
	 8inQw0y0vS16qN31JBFZXPzuEUoftp6XczJkM1D5eKKCt+eOm7jM/pWVNVo+JZ235S
	 6gV478BVaxgKtXLQcEUpQlc9/ttDf2uiComgj9V433LSHJ7r/0ep/k6o9oPVOzpAa7
	 JWFjGYYVdBHzw==
Date: Sun, 21 Jun 2026 21:53:17 +0000
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
From: slipher <slipher@protonmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] 32-bit ARM's BKPT instruction no longer works
Message-ID: <zbEOoL4_phCCh7td7DwqQtyhleFJ_G3yRBc8AFjT5hwIwcRipRMsjtIVJgLi3t5vJk5QsuKjY9c8I91nuVSYk4-xlzrAqigMWIE0iNMc9PM=@protonmail.com>
In-Reply-To: <ajhHYKyvL9nCUvG5@shell.armlinux.org.uk>
References: <kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=@protonmail.com> <ajhHYKyvL9nCUvG5@shell.armlinux.org.uk>
Feedback-ID: 10906495:user:proton
X-Pm-Message-ID: cd29de95e1cf57bc5f6c870c1af70a39c6a6b03f
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-267580-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[slipher@protonmail.com,stable@vger.kernel.org];
	FREEMAIL_FROM(0.00)[protonmail.com];
	FORGED_RECIPIENTS(0.00)[m:linux@armlinux.org.uk,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:regressions@lists.linux.dev,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slipher@protonmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[protonmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,protonmail.com:dkim,protonmail.com:mid,protonmail.com:from_mime,armlinux.org.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E33A86ABA9F


On Sunday, June 21st, 2026 at 3:19 PM, Russell King (Oracle) <linux@armlinu=
x.org.uk> wrote:

> On Sun, Jun 21, 2026 at 07:15:27PM +0000, slipher wrote:
> > Consider the C program for 32-bit ARM architectures:
> >
> > int main() {
> > =09__asm__ __volatile__ ("BKPT");
> > =09return 0;
> > }
> >
> >
> > Expected behavior is that this raises SIGTRAP. Since Linux 6.10 this no
> > longer happens; instead execution perpetually resumes at the same
> > instruction, using 100% of CPU. It does not matter whether GDB is
> > attached. I have tested with an armv7l CPU, but I imagine any other
> > variants with the BKPT instruction would be equally affected.
>=20
> Looking at the code, I doubt this has ever cleanly raised SIGTRAP (can
> you check whether it does in kernels without c3f89986fde please?)
>=20
> What I suspect instead is you get an "Unhandled ... abort" instead
> and the program forcefully killed as hw_breakpoint_pending() would
> have ARM_DSCR_MOE(dscr) =3D=3D 3, and the switch() would set ret =3D 1.
> That triggers the fault handlers in arch/arm/mm/fault.c to
> complain bitterly, and forced a SIGTRAP to the program to kill it
> off. No resumption from an unhandled trap is expected.

I have tested with a 6.6 kernel. All of that is correct, as detailed in
the aforementioned blog post, except the last sentence. The switch does
set ret =3D 1, thereby passing on the exception. The kernel complains,
with such lines in dmesg output:

[ 1547.164526] Unhandled prefetch abort: breakpoint debug exception (0x222)=
 at 0x0001051c

Indeed, it is not clean or efficient; the blog
(https://www.jwhitham.org/2015/04/the-mystery-of-fifteen-millisecond.html)
even has a proposed patch to improve the performance when raising
SIGTRAP. However, it is possible to catch the signal, and even resume
with something like this:


#include <ucontext.h>
#include <signal.h>
#include <stdio.h>

void handl(int a, siginfo_t *b, void *uc) {
        puts("caught SIGTRAP");
        ((ucontext_t*)uc)->uc_mcontext.arm_pc +=3D 4;
}

int main() {
        struct sigaction s;
        s.sa_flags =3D SA_SIGINFO;
        s.sa_sigaction =3D handl;
        sigemptyset(&s.sa_mask);
        sigaction(SIGTRAP, &s, 0);
        puts("start");
        __asm__ __volatile__("BKPT");
        puts("resumed");
        return 0;
}

Re-testing, I realized there is a huge caveat: SIGTRAP is *not* raised
when running under a debugger! If GDB is attached, either of the C
programs above will repeatedly resume at the faulting instruction on
Linux 6.6, just as they will with the latest kernels. So the regression
only affects the perhaps-obscure case of using BKPT without any
intention of attaching a debugger, unless that worked in even-earlier
versions of Linux.



