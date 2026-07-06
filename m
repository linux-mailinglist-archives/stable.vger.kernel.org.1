Return-Path: <stable+bounces-272319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sbQ0L+oXTGoegQEAu9opvQ
	(envelope-from <stable+bounces-272319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 23:02:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C0071595C
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 23:02:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="KlhEw/ct";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272319-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272319-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D100C301C100
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 21:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C13E43786D;
	Mon,  6 Jul 2026 21:02:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760CD436BDA;
	Mon,  6 Jul 2026 21:02:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371727; cv=none; b=cfFYaYMQGVK57AlFUfJVX7BvMXPYnWsYcVacANEp5SjDiaquwFmG5XpTVuStG9Dbs0XLW34hmrwPIZJXyxoRx5YGHN/WWyDbYAunx/OtYAl8cyZqzJVj/fmVIASZ9fh45XG+Z9idP2ZkA7pJeIHTho9Z12lwNGgiKi09Fxcb39I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371727; c=relaxed/simple;
	bh=zk7mFt6QqW9hGPmSzBqV0ibKlPwQhw4uSyD+gkUD65Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXDlkPJlbNvntU5WC+0PoHkRGlj5UzQYS9FcNSGv57dkDNUfH4oCGgOuXTWX5baEj4uliXjwtoPLXAl5UYvG6a9MyuW1IBvZrfCJATzpjEa0MTYztSSf7Q3I0B1YAH/oJMDWMEjASjGsbr4iV/sBBNuw0kK/LE/5fzeu0oVQ5MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlhEw/ct; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FDC1F000E9;
	Mon,  6 Jul 2026 21:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783371723;
	bh=YH94RBJ5oQWvPJxqF2lGknMcip56J1cYwGtMmIQc6zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KlhEw/ctTtp3dv24zUaovOm+XpVqLihb5HsRRIpxaYCPrPgxi/MeJcHlUOLnQe3CP
	 kH36SRATV/zWbKeZn/q0YDpQHTeMsmxbBAFnwNXhiI3ijOydR/4tttbtasf+P+zM+B
	 re6lokUPzapg9CeGQ064v2EU9YCLMPu3XEb5MQserHK6avQki7PRuLY3qsT1/zK+O6
	 ZMvi6i1HNLPIPmkMdQjTQPhSZBrvSdreOGuukGqHGwrmDtxvetav8Il5D7BZ1buXbg
	 3Zfr5LyjXsLDC7GLcB5XnH7s9JSarGEuErPA11b4FEWcy51V1fyCfmYDOANVmd7ZhQ
	 24gdMzeeMFU1w==
Date: Mon, 6 Jul 2026 14:01:58 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor.dooley@microchip.com>,
	Wende Tan <twd2.me@gmail.com>, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>, kernel test robot <lkp@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: vdso: Do not use LTO for the vDSO
Message-ID: <20260706210158.GA73349@ax162>
References: <20260701-riscv-vdso-lto-v1-0-89db0cd82077@linutronix.de>
 <20260701-riscv-vdso-lto-v1-1-89db0cd82077@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701-riscv-vdso-lto-v1-1-89db0cd82077@linutronix.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:thomas.weissschuh@linutronix.de,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:conor.dooley@microchip.com,m:twd2.me@gmail.com,m:palmer@rivosinc.com,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:namcao@linutronix.de,m:lkp@intel.com,m:stable@vger.kernel.org,m:twd2me@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272319-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,microchip.com,gmail.com,rivosinc.com,lists.infradead.org,vger.kernel.org,linutronix.de,intel.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,linutronix.de:email,ax162:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30C0071595C

On Wed, Jul 01, 2026 at 11:21:22AM +0200, Thomas Weiﬂschuh wrote:
> With LTO enabled the compiler assumes that the vDSO functions are not
> used and optimizes them away completely. Currently this happens to
> __vdso_clock_getres(), __vdso_clock_gettime(), __vdso_getrandom(),
> __vdso_gettimeofday() and __vdso_riscv_hwprobe().
> 
> Disable LTO for the vDSO, as these functions are hand-optimized anyways.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202606301855.WvkSC4kD-lkp@intel.com/

While this change seems correct, is this really the fix for that report?
It seems like that error happens in clang but I would expect this sort
of issue to only appear once LTO has run through ld.lld?

> Fixes: 021d23428bdb ("RISC-V: build: Allow LTO to be selected")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/riscv/kernel/vdso/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index a842dc034571..43ee881f6c6f 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -69,9 +69,9 @@ CPPFLAGS_$(vdso_lds) += -DHAS_VGETTIMEOFDAY
>  endif
>  
>  # Disable -pg to prevent insert call site
> -CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
> -CFLAGS_REMOVE_getrandom.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
> -CFLAGS_REMOVE_hwprobe.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
> +CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_LTO)
> +CFLAGS_REMOVE_getrandom.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_LTO)
> +CFLAGS_REMOVE_hwprobe.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_LTO)
>  
>  # Force dependency
>  $(obj)/$(vdso_o): $(obj)/$(vdso_so)
> 
> -- 
> 2.55.0
> 

-- 
Cheers,
Nathan

