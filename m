Return-Path: <stable+bounces-139173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9559FAA4D93
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 15:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71FB1886537
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 13:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDBF25CC74;
	Wed, 30 Apr 2025 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Iso/t97O"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5639825B1CB;
	Wed, 30 Apr 2025 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746019948; cv=none; b=T7tseMAUbS326HmAAEDgxqtBOezGVaRSHmzC4RXvHIjG7GXKPAhXMd9YcxGUJxoWrKJgL3j3JvUWIe/foPLIW8SaXljCcIpGCNFBd/GTAXWQJ0uGWUcI8BxvECRb5rkhZKDBqBEb6eaIYUCycDCLl7eLMEeFnqGiu1uVmYrWxfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746019948; c=relaxed/simple;
	bh=XUP5kolmodj9omk+HB/pgaCL4rTsETkVye5Zg2LD1nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xz8ymWeifYJ015mbrcca7A1zmFPSZV0+PtHNSiXae7qsx12MKKoeFEBTr4CrQMh/Gx3Cfwzges52ixiAjvlvVK+l/UNBqCLC9iFEkKyGvo1AG8e9h1go46l1Lxy0dSJzmr6ZUXsZyNeZ5H8qDFbKawYULn9oxWxMNzyzM655iwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Iso/t97O; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1791B40E0214;
	Wed, 30 Apr 2025 13:32:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lVgQPf0OlpAX; Wed, 30 Apr 2025 13:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746019940; bh=A1CXwSD/7j6NwMGG4ZTzid19BC6+JXchxfFkihst34w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iso/t97O4sCD8JcHCssOB0D0XRGWmX32iIraGerTh5NEBTbcs9T0GbdMp/U7DtPcO
	 cAf0Q5p4itQrHWSEfAWlGXf50qMHkYQxHStiweP0v472YuXJAEXBFPXCNT6rtmBf8d
	 Oj9dm1uCyFPyUCSxKMhaUPjvyld6xQojCDXT5NYpP2keKQB+Gk3N8LgMi8/sRQXWrw
	 euoxensXE7TpEjb7FxHADeGlv9IHRIPcZBp4r/iOBDyj86+SVt400ZH9kI71J484yf
	 tblDIS7SROL9YHhmxlwwcMZROkkqOZhEtFuSv5ytd/nLyvv8aMg6EwoMGF60tn6aGw
	 YZCtAHnP5br9OgoMBczGWjs+qYwS4Iz/XgwN62PWvy7PvJmr9NDm/GKg8n7f+idGLT
	 7S37pJGf0ZGQH0XA1N2M+Z3GqNHo8+CPFIXHtZPqzjfI9U0SdZKtVEdkS4BMES6Vb0
	 Mn2YuggWaaagSV8ZyizN/BN5p35zSatsYlVe77GX/3EWxUTZ6ZuCb21x2X6ubP4fBa
	 3kntCATbaCrCJIfuIPm3fg+1ALzbW7gQ6bGLIVH8aQUjtP8suWlu62bcpvgNFBtZbM
	 X85uW67/bgi6YSTa70xhyqFwXmmUuFg7fp+KymNW8QcEwBWrk/XIdC/YmH2Ewa6jCt
	 fsbxkEmKrqDzcNil5LeUHB4M=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1EA7740E016E;
	Wed, 30 Apr 2025 13:32:05 +0000 (UTC)
Date: Wed, 30 Apr 2025 15:31:59 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com,
	michael.roth@amd.com, nikunj@amd.com, seanjc@google.com,
	ardb@kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v2] x86/sev: Fix making shared pages private during kdump
Message-ID: <20250430133159.GEaBImTw8E1cqU3k5C@fat_crate.local>
References: <20250428192657.76072-1-Ashish.Kalra@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250428192657.76072-1-Ashish.Kalra@amd.com>

On Mon, Apr 28, 2025 at 07:26:57PM +0000, Ashish Kalra wrote:
> There is a bug in this additional check for GHCB page contained

You don't write in the commit message that there is a bug - you explain what
the bug is.

> within a huge page which causes any shared page just below the
> per-cpu GHCB getting skipped from being transitioned back to private
> before kdump preparation which subsequently causes a 0x404 #VC
> exception when this shared page is accessed later while dumping guest
> memory during vmcore generation via kdump.

And you explain that *not* in a single, never-ending sentence but in simpler,
smaller, more palatable sentences. Imagine you're trying to explain this to
your colleagues who are not in your head.

I've been staring at the diff and trying to reverse-engineer what you're
trying to tell me in the commit message and I have an idea but I'm not sure.
And when I'm not sure, it often means the commit message needs more work.

So try again pls.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

