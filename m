Return-Path: <stable+bounces-180701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5F8B8B2BA
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 22:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C409D17A18B
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 20:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A0A226D02;
	Fri, 19 Sep 2025 20:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KDO1mvFt"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A565D5C96
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758312474; cv=none; b=FIy2XUYgSyefg4t61nT3e1nUZUNjcW7cjMOQt852V7ONGnLHAdl1OkK7gAO4JBxxO9+ZbmYugMbPCoqnD/847qs3mo9qlX29+HSVyjPgU6IteGUZPE0bNSsbdpEEI8/agCsZFk4Rm/x7Lxvi4Tf89tGSVYKBaQpxqn72EZOE8dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758312474; c=relaxed/simple;
	bh=eQjmGnTJtmrKS9Hdr/GbCM4ZRCEZHusvDQMJJFXcgxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvF5G3qmd4Q+RXGSo+CUuGKkZAE9a5krucp2WpTcarxwuGnWPjMXWjhR0OuT2M3kUxREaVsHogleHP0WCgEYw5koCw2DhK1Fj1Sv0zB1D9HUNVpj7EIxdEStWGO7a/zJF7KfTJIneL5Zc1RQ5nTY+mJun3v8tQLlEE2lz59BFoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KDO1mvFt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DCD2240E01AC;
	Fri, 19 Sep 2025 20:07:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0hcxTfL3TvAh; Fri, 19 Sep 2025 20:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758312459; bh=39k++MWCxtgVipuZBpMqLNFIwWColgmOpUmv1+b8nZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KDO1mvFt9x/TPhEelVhSTmEFR4TOqsP402gdHEbtjDGhtGjRfmeVEjwG2EtoN4onv
	 TLq7OT+2CUL/sJIttxNr+Vvcu6aoMHE544iZpgTwuIsCBjdGG0U7qEgzbb2iWZ+7xR
	 OhX0lgMYeFEB1UAoIRwALs6xHg+RoWQlgD6mOkn5Guyn58bMKK5g6Sf4BBD5EP60NM
	 5uQ570Mmqm29xrZCHo4BCoiOKufhTkxWSU0GsIppLwvG7wFNgyz+B4KHKtp/C5QqCk
	 segW8N9dhFF6CVJ+0I81BdM4GT3Ce2gzpULMuj+2vKiXS1g0ExqivWm2s+mnq+yP+q
	 4g4kCEZ2t/6yIcOFYOqwMhNEUK9fB78jMF6XXYyrPb5hXK0pvA4Yre8t3FoMX4+rMz
	 6+s/n+6Kuu83hL1xRra8xgVYiBOtMnraeS9Be1JGh9hzvo25ks+cM1Ys1L27p6X0Ra
	 U+xHcRzeCj8P4WAp2Mt177bjnUGQ+CN3ezyuXtaNFy+doSIM8q/3cbFOA4L/9v0o1F
	 wstW1L6Pio2tq1MHm20Qv7Y5xYKxEkdkuIo7b/0rXobPzSEmNYJw6iVAnRoSC73Zt+
	 1Yxx0os3xLncub9zoUnyBEGhVjipAnI9FAU5epRKwg5BrbUxlZQBIzk4dh4MAxKiTW
	 RJtb2ICKgYsYDLJTSLYbI2Mk=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 18D3340E019F;
	Fri, 19 Sep 2025 20:07:32 +0000 (UTC)
Date: Fri, 19 Sep 2025 22:07:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org,
	ankur.a.arora@oracle.com, boris.ostrovsky@oracle.com,
	darren.kenny@oracle.com, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 6.12.y 2/3] x86/bugs: KVM: Add support for SRSO_MSR_FIX
Message-ID: <20250919200725.GGaM23_fjYFpBjDfU8@fat_crate.local>
References: <20250919173300.2508056-1-harshit.m.mogalapalli@oracle.com>
 <20250919173300.2508056-3-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919173300.2508056-3-harshit.m.mogalapalli@oracle.com>

On Fri, Sep 19, 2025 at 10:32:59AM -0700, Harshit Mogalapalli wrote:
> From: Borislav Petkov <bp@alien8.de>
> 
> [ Upstream commit 8442df2b49ed9bcd67833ad4f091d15ac91efd00 ]
> 
> Add support for
> 
>   CPUID Fn8000_0021_EAX[31] (SRSO_MSR_FIX). If this bit is 1, it
>   indicates that software may use MSR BP_CFG[BpSpecReduce] to mitigate
>   SRSO.
> 
> Enable BpSpecReduce to mitigate SRSO across guest/host boundaries.
> 
> Switch back to enabling the bit when virtualization is enabled and to
> clear the bit when virtualization is disabled because using a MSR slot
> would clear the bit when the guest is exited and any training the guest
> has done, would potentially influence the host kernel when execution
> enters the kernel and hasn't VMRUN the guest yet.
> 
> More detail on the public thread in Link below.
> 
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/20241202120416.6054-1-bp@kernel.org
> (cherry picked from commit 8442df2b49ed9bcd67833ad4f091d15ac91efd00)

This and the next patch doesn't need those "cherry picked from" - that's what
the "Upstream commit... " tag is for.

But Greg will zap that when applying.

Other than that, LGTM.

Thx for doing that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

