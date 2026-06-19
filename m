Return-Path: <stable+bounces-267458-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R4D6BdfWNWr45AYAu9opvQ
	(envelope-from <stable+bounces-267458-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 01:55:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6536A80F9
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 01:55:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MFSFWYrM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267458-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267458-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEA6D300D46C
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 23:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565043655FC;
	Fri, 19 Jun 2026 23:54:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CEF19D092;
	Fri, 19 Jun 2026 23:54:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781913295; cv=none; b=afIdoAz/yuAhUq1DHxtmTHiwhgoL/P5WkxSKJSh2nZK3WcE2VeagMVNCpXPo0VFlUQRe/T5IHkA12uDxAm+7gLG1KCigiZOgtCipWi/BVnFkW5eSvVcalkdFnKy/2kjQbbBLOiwnTF8+5plF3nDIyrFxF0pKPIy4G8hk4xNobNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781913295; c=relaxed/simple;
	bh=4uDAlJGIuj1sxAgSiHnZekE5owd/QoOV8Dk33leZ13Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+TblBg3dtQjAhl+JHFhZndGgVntqh4WyEgbOxJDTqY0bGa50eXp9jlfxiC9zJMoe6GkZVCv5qAbsEEj8d0d9kaULSGehRT66KKBfEQzqfRFOsD+K2hPSj4OpBrmr6fT7daGkLXL5m/YBvsT7Q6vhateHqt0MRbHklbYkffYSgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFSFWYrM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6ED1F000E9;
	Fri, 19 Jun 2026 23:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781913293;
	bh=T2U6mD5Mi888Hcm8xp1sqPPOMOUnXskbr2jM/AcqYN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MFSFWYrMI30DpGUYSviB3mF0oMxLpUDKjrBft2OtFxA5uWy0f01420l8cek0mMKZm
	 SPBoIfC1iKg02qhAv6VtWy2neMROUeTEPxOE3SLlr/WZ/N7wgLVl910xr3NObOx+Ub
	 8vT92jPm0m5RzKdtlZM++nW7awockcRqxBZlg4s03nT1z3hwSSje+94MrTRPc6yDAV
	 xutiuMxLRaImQGCgxbm0wP5QbIsg2dcQAapoHOGx2j8FYUuGxtQwgYEzT/AnVSKtme
	 uhaMtdDBzVia1xtMuLlxV5mfVa/ZLQ3XAZTTOnxcYeBjYqLv/5Ixk1+duLPC0tHkeR
	 pKwQXvtH2vAKw==
Date: Fri, 19 Jun 2026 16:54:53 -0700
From: Kees Cook <kees@kernel.org>
To: guoren@kernel.org
Cc: arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
	peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
	heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
	falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
	atishp@atishpatra.org, mark.rutland@arm.com, bjorn@kernel.org,
	palmer@dabbelt.com, bjorn@rivosinc.com, daniel.thompson@linaro.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, stable@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: entry: Fixup do_trap_break from kernel side
Message-ID: <202606191652.38297DE51@keescook>
References: <20230702025708.784106-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230702025708.784106-1-guoren@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267458-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kees@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:guoren@kernel.org,m:arnd@arndb.de,m:palmer@rivosinc.com,m:tglx@linutronix.de,m:peterz@infradead.org,m:luto@kernel.org,m:conor.dooley@microchip.com,m:heiko@sntech.de,m:jszhang@kernel.org,m:lazyparser@gmail.com,m:falcon@tinylab.org,m:chenhuacai@kernel.org,m:apatel@ventanamicro.com,m:atishp@atishpatra.org,m:mark.rutland@arm.com,m:bjorn@kernel.org,m:palmer@dabbelt.com,m:bjorn@rivosinc.com,m:daniel.thompson@linaro.org,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:stable@vger.kernel.org,m:guoren@linux.alibaba.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,rivosinc.com,linutronix.de,infradead.org,kernel.org,microchip.com,sntech.de,gmail.com,tinylab.org,ventanamicro.com,atishpatra.org,arm.com,dabbelt.com,linaro.org,vger.kernel.org,lists.infradead.org,linux.alibaba.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E6536A80F9

*thread encromancy*

On Sat, Jul 01, 2023 at 10:57:07PM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The irqentry_nmi_enter/exit would force the current context into in_interrupt.
> That would trigger the kernel to dead panic, but the kdb still needs "ebreak" to
> debug the kernel.
> 
> Move irqentry_nmi_enter/exit to exception_enter/exit could correct handle_break
> of the kernel side.
> 
> Before the fixup:
> $echo BUG > /sys/kernel/debug/provoke-crash/DIRECT
>   lkdtm: Performing direct entry BUG
>   ------------[ cut here ]------------
>   kernel BUG at drivers/misc/lkdtm/bugs.c:78!
> [...]
>   Kernel panic - not syncing: Aiee, killing interrupt handler!

This appears to still be unfixed. What's the blocker? The solutions in
this thread seem to work...

I'd like to be exercising an Oops path via KUnit (for KCFI), and riscv
just instantly falls over instead of thread-killing on the exception.

Thanks!

-Kees

-- 
Kees Cook

