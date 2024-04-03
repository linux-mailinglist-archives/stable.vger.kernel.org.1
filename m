Return-Path: <stable+bounces-35693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368AC896D89
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 13:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DBB3B2974A
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 10:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6991474AD;
	Wed,  3 Apr 2024 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="V7gW5bCh"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEDE146D4A
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 10:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141811; cv=none; b=Ff0haM/pYnkl/HDDvSMqhcPFz7TcHWjb2uf0T+vFZoQgQAuiptkgwoBvRTLS7rP3I4Y/jIbFIECqODa8+vaukIUIHopbGE0Cs71Azj+sLK8QlSgFL2D5sUJQzYPS0DTpRQqodHYPZMEBfXr4JKz5WpRMpUvAM0glbELAnIMzxUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141811; c=relaxed/simple;
	bh=IzyxmYpxJiefHdUuTxGqw5lb6JR+rr8T8JrdAAVCpJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOr0HIr0ZzhpEGso+2+a/gxyjY957uA4qanCik8mjE+F/jYBd6MmRdKhAxfpNQXMy/Xmf8KLvzNzn5kSYLQ8UduP1hk/fEeidwz84tWjqvkkdkHJDwduH01mlJ1u1AatuJsOC99v51beTUVrkZGRGSijS+BZ+G8ZYuah8By2u28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=V7gW5bCh; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7501740E0192;
	Wed,  3 Apr 2024 10:56:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gUsu1fBF3A5S; Wed,  3 Apr 2024 10:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712141802; bh=gDhGT/roqgY+ZWO5RVqu8GhlE3m93bBGZ6a++8W2GJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V7gW5bChhD1U1BcVFYIwoOPYgSspcPfcgPU5AQ/pduxbuc0+SnS9BXnOwkfNZzwAz
	 rNEYpmPJUQz9kvtRK7lPdspWFGcgk5ZMPOEC6dV8IUXyG4a1FaAVKNEvPFfEbiSKpF
	 eRKS/BMpOoC1Yy5LJhwpZA84ndf/4iGTGnmUDGg2fCfwWVmCGTlMv+znf5wV9ONHNy
	 kfB74AK2T+puIxJWz5qCQkDiM2ki3dxE0mhXXV4TADHeiToowIVxRheSGrSJDPgoiX
	 OrV6qKeMXFwFRAEiypXXRmUzLpBDh4CSSyLUagfeSBrI5Uw/YDWaFCcT/cQ26TxEKT
	 QO746RS3qoT1QEWLqZldnoXWQokQN7aXR7PQWB0aoMUsVOCr9HThBMNvI7qHIK9vvG
	 t1LdwRmgQ/r0mebYKPMVJLGtyDNVa52OoshB9VgkZoCKKCJ/56Bds7RvVnD94U/yeV
	 XlfQuZYnZCBRsFfMxppi/TdOF9VxaPxyfH5MUyEw8llu6Fpu3frqMfEqNAoV2bJeHl
	 QdLRLW+Ad/Y6M+APvfCCW86/vc0lC/SwDcEjRAsQC01XuMJ354P5MLzcmkOCCMoQjH
	 PQgAjlShf+jvkS7iCOHve8LS6Df/mppFLG8OmOOebQIbq745rVsxWnuBuCGm4mRnKG
	 3RcbXukuCNRLCR3CuZz8fRaA=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D4E6B40E00F4;
	Wed,  3 Apr 2024 10:56:37 +0000 (UTC)
Date: Wed, 3 Apr 2024 12:56:31 +0200
From: Borislav Petkov <bp@alien8.de>
To: gregkh@linuxfoundation.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/bugs: Fix the SRSO mitigation on
 Zen3/4" failed to apply to 6.6-stable tree
Message-ID: <20240403105631.GBZg0130wgJdljfjzE@fat_crate.local>
References: <2024033029-roast-pajamas-3c55@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="y2Tk2QjCOtk6P4rg"
Content-Disposition: inline
In-Reply-To: <2024033029-roast-pajamas-3c55@gregkh>


--y2Tk2QjCOtk6P4rg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Sat, Mar 30, 2024 at 10:46:29AM +0100, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

A bit more involved, took a couple of Josh's cleanup patches too. See
attached.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

--y2Tk2QjCOtk6P4rg
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="6.6.tar.bz2"
Content-Transfer-Encoding: base64

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
0nzgkAn/J8aIf+LuSKcKEgrDX2VA

--y2Tk2QjCOtk6P4rg--

