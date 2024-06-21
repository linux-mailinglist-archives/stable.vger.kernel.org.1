Return-Path: <stable+bounces-54824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30498912754
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 16:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616D31C21C3B
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 14:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16831171C4;
	Fri, 21 Jun 2024 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VyhcXhKo"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333114436;
	Fri, 21 Jun 2024 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718979328; cv=none; b=Q4Ee3y4HlP0dE8CxwYdwh9KEOPU+/zSM4UZW+scdHp3v+2wLUU6rsDkQpbh8phSgKVjs8r6JEzjPgBl+ppaf5AqJhUDPzyUbEApSTVuMFewEu6/rjtCPaDfknOvWzI176uXpWa5uR9AYdpXwO2rmlf/+Ufst/bVX7xSWU+aEpqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718979328; c=relaxed/simple;
	bh=lH0/t+ml+INBeWHwJdLxNzlPbiYU5xMmjdEio4kBo0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8LAl18EQX4lUusCQZrrf4C7xyamMsAZrO0S4unNxSpfVsdn5HZfS0ha2+fhaB6vLzF9HRC89VMrx7q0SDJ2D9tvZFEWGvZvcV7Z+xGdlYfre4QQCVfTlVspVbQkHjQ5OK2PiKE3GnG7vygPPE0ZaJSdQ+IxeYWx2Uo5KY8kgh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VyhcXhKo reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0F11040E01D6;
	Fri, 21 Jun 2024 14:15:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zoB-Ig_cLcFC; Fri, 21 Jun 2024 14:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718979318; bh=ioaKtrBeVYQDpXDvfJADjpTmqP4lEMPOByzUjGeiIWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VyhcXhKoGvHHco/G0/jq/7xvmP0k00qchQkLMk0IgSTDlc6EDQHD2s5Ddhjw0hOr2
	 iHFD+SjDNW8jv7D8o+T6qTtDB6O4uRL7HHjGZ7ECTsRjcZmnxxf6iyPhRCW4P1fz+U
	 cesQpYOfQKOVAj6s4gAnFShz750i2zQynQE6ycacPigYReJI7xGlPmH51FgOAqqGAo
	 FRa357RXHkL94ptoeuXw+UIYk+p1IkkuH5kI30qlYYtVPebrIGMPIbd5rdRUKP/pLL
	 SaXyevCA7mposC5krUXkRkUAw9VtE66W3ohwq0jVDqKAP/ZEomPGHB/N6xZPhlKWFS
	 rKIJgADxXZAvHee4kiIFck1SsbULKGgg47bwyOXxSQZ56TjE7nTYiWAMCk+gmYS48f
	 e1r0xNJFp1mubwpX9D14m+b2Uj94oV7ti24fLbOapBmxDEcYf+21cxxLGhkj8/d4Gk
	 AAjYwlSEQSh8fKcsbzAti3U96HRMYcSMxNvYdkXZ9j1OC9fAovqq1YD9cA0zSkSET+
	 7xYJmlUJtfxOdsd/BDIZ1ntPxFF9zoJRmJh+R6eDcsoOgnWblTBq6GiP+hmJtqmYIG
	 YLfityhjshV/IApehs+vzB/PpVr5r1rUf2o1/T61nnKLNnZXZK5nvDHcIJN++egM9B
	 G0CQqcVnHm1Sq+o181HZqYM4=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B9E5E40E01A5;
	Fri, 21 Jun 2024 14:15:08 +0000 (UTC)
Date: Fri, 21 Jun 2024 16:15:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] x86/of: Return consistent error type from
 x86_of_pci_irq_enable()
Message-ID: <20240621141507.GHZnWK6-r6XEH2a9CR@fat_crate.local>
References: <20240527125538.13620-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240527125538.13620-1-ilpo.jarvinen@linux.intel.com>
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 03:55:35PM +0300, Ilpo J=C3=A4rvinen wrote:
> x86_of_pci_irq_enable() returns PCIBIOS_* code received from
> pci_read_config_byte() directly and also -EINVAL which are not
> compatible error types. x86_of_pci_irq_enable() is used as
> (*pcibios_enable_irq) function which should not return PCIBIOS_* codes.
>=20
> Convert the PCIBIOS_* return code from pci_read_config_byte() into
> normal errno using pcibios_err_to_errno().
>=20
> Fixes: 96e0a0797eba ("x86: dtb: Add support for PCI devices backed by d=
tb nodes")
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: stable@vger.kernel.org

Any particular reason why this is CC:stable?

I'd say unless you're fixing a specific failure, this should go the norma=
l
route to 6.11...

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

