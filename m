Return-Path: <stable+bounces-272479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AgYRAs87TWq9xAEAu9opvQ
	(envelope-from <stable+bounces-272479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 19:47:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0F371E666
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 19:47:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nOMe5IQz;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272479-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272479-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27A0E3051D17
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 17:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF4E43B6D6;
	Tue,  7 Jul 2026 17:45:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7905843B6C7;
	Tue,  7 Jul 2026 17:45:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446320; cv=none; b=uaLjyuxok/E2DcXIpezSxeu6ieiXJbHZUCguJPqCFLXhA9aOFAjmBPNUfRkcWpGpE1L8psSMKuKXp46WnizHPZ6n5G0OfCpshVVLKD7FX8eWPvyukCsWFzXXhq6P/Zdg+BP5M5ATNVI3ALmCKUvGncluRqJwK9lxu4SQhS7SK40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446320; c=relaxed/simple;
	bh=5yUOIZ0ethZqCmfc85wQas6meqcD1uvnoYMkHTIN744=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Byg0GMabzqBl2r/afnWhRGl0rZ2IpyjA8Ny8x1nnagkzrQhfKAgcKlmtp7LKyL4q0se03JJtGW555qYn89q7fAZJpKh2SempW6kTC1uT0g8zGTwViWAwteoojOQs9AwTdNejeofq/btllJq7neQOGexhOV8fjP2jPytlfxO6obQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOMe5IQz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E241F000E9;
	Tue,  7 Jul 2026 17:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783446319;
	bh=ArZcjnqxXY4lFXsA7ciAkqOLPQkDIBG41FVldd2FM9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nOMe5IQzEGa5vA5o14v7lBTr4l+/MkALdb30ZUydO6V/RZb/g2c4WEIMq4hO4ptZz
	 BaqlwELwS5BFZJnDFxW3tU7BXZ9jgiPb/PiAbl1RHIL+ntYfiQV7on0xvieDJ8VOBv
	 qTKY9I/WtmujKcaaI3BuHSBDGi7JjQiDfYq/lBMvT121Bmjxe2utEwFszGoqJqTlin
	 jd7RfgVc0L+Koz+z9Ri6E3D76BIM6IeEJQ8g8YPIebJx49XFLqpe3krgSXkOd5cv/A
	 CWPoQqaGZVd9bOiDYTLUUdeBABY6rYF1DgD6lTSC1NBQNlck/kw8X3V0IdzTN9YFAE
	 neO4Bl08JEUow==
Date: Tue, 7 Jul 2026 10:45:13 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor.dooley@microchip.com>,
	Wende Tan <twd2.me@gmail.com>, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>, kernel test robot <lkp@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] riscv: vdso: Do not use LTO for the vDSO
Message-ID: <20260707174513.GA1256227@ax162>
References: <20260701-riscv-vdso-lto-v1-0-89db0cd82077@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701-riscv-vdso-lto-v1-0-89db0cd82077@linutronix.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-272479-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ax162:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D0F371E666

On Wed, Jul 01, 2026 at 11:21:21AM +0200, Thomas Weiﬂschuh wrote:
> With LTO enabled the compiler assumes that the vDSO functions are not
> used and optimizes them away completely.
> 
> Disable LTO for the vDSO, as these functions are hand-optimized anyways.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
> Thomas Weiﬂschuh (2):
>       riscv: vdso: Do not use LTO for the vDSO
>       riscv: vdso: Simplify cflags remove logic

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

-- 
Cheers,
Nathan

