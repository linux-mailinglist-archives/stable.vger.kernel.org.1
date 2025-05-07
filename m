Return-Path: <stable+bounces-142016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EF8AADBB0
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2960F3AE7DA
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ADB1F4CB0;
	Wed,  7 May 2025 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WDFvwGaf"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61D472603;
	Wed,  7 May 2025 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746610974; cv=none; b=q5n93/9+BNsFesdm6QMuGThJkEek5oIIjxvScpCxxx3EaHGpBHjkOHGdCBOlE4LFTkVPlC2i+o9FNrDcvXJVOFB9K3RfRzDZC0n/GuRsgtHNh6fpvvDxtI8FhlWrSVAnFSd57rt88GDvbuQIZ3vz7O3TofU8BhcYEmB7yOOaog4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746610974; c=relaxed/simple;
	bh=TJv2DgdDgD0zQ/WdFPHqdVqlx/9+4rM5yIjbLQPR+NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MP+lTQitnv04WQcMnXdYMfjM7SGFlI+qHI5tFjpmXJMyN5NtXIcS1SiBP8qKKMZgtgn+AIzSAN1+4qJx7/cJ14fX/TS59BLTxw7ltnwzZlDuEOcyEtlKJ2K2FrxNCbA0EDus4TlaJlrROpd854dzX5WVyobiY0YmxQ9d7qx5TWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WDFvwGaf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A428540E01ED;
	Wed,  7 May 2025 09:42:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OinWf2BSwkrW; Wed,  7 May 2025 09:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746610964; bh=vd1kP3jlGsAa1/WrA5dgigKmpDxOwjsZqjH8zD+YFvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDFvwGafN0Th8/qo/ihTfnszbhzQn+wT+ZETp0X/to5cQgR5nTIWt3xbKH1ftbVY7
	 cjy4PIitedWGDjA+fpImZowNHBiAcZ5QESmMuGasQTbPrCYQ7BDwEvUYzJaiyPyl4g
	 seCRlLQpzl3EZQYZon1kJzaBG9fblD1p1RFYtGDSfHAuPW8sVXe8WSHEFTSpCrC65u
	 jZKd48dPU++3SQsJzncG2COECZKOUA10eP5o3426AKotV8+z8TzBWkdeFtPR3N/tGP
	 NtslWCBAg4GdIRYLn6dep7YW/SCd3/XBqTbWQ3NLpwt+ICdYWatpB6A/bJvspohFgl
	 mD/xi6345sUpwiifTPR1ac+4gyt9qNu16X2yv2a7zy/Ebp/dZVZdgsOVkMVGyuP4SR
	 zO1n5BedP28ExBCYusE2GdfmkuhwROkeKU+D3lQjfiqK1rVy2cDo4oZ2HjeQMVbPVJ
	 pJazDmB3rvbUhOG6QyLslDAHLAbbI89MgvuDJFnjRan3ESUKPdlgdt87Kic4lDQSUu
	 9E1WeyP7e0C+L3giR7kGKS7dx81KBqKgMofunNSn2J24hDzMPgxQl3HvGdlVrymepa
	 Utc/IQUlMu+LwLcLaA61bPRMqTNqRWzJ/wjtieS6+7J+MP/w7Gw7/knBaFUQNj0jwx
	 cpF1CZ0yZpi8cbil45Yd2WUs=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B9BA040E0238;
	Wed,  7 May 2025 09:42:28 +0000 (UTC)
Date: Wed, 7 May 2025 11:42:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com,
	michael.roth@amd.com, nikunj@amd.com, seanjc@google.com,
	ardb@kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v5] x86/sev: Fix making shared pages private during kdump
Message-ID: <20250507094211.GAaBsq8zEJMAuffwmh@fat_crate.local>
References: <20250506183529.289549-1-Ashish.Kalra@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250506183529.289549-1-Ashish.Kalra@amd.com>

On Tue, May 06, 2025 at 06:35:29PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> When the shared pages are being made private during kdump preparation
> there are additional checks to handle shared GHCB pages.
> 
> These additional checks include handling the case of GHCB page being
> contained within a huge page.
> 
> The check for handling the case of GHCB contained within a huge
> page incorrectly skips a page just below the GHCB page from being
> transitioned back to private during kdump preparation.
> 
> This skipped page causes a 0x404 #VC exception when it is accessed
> later while dumping guest memory during vmcore generation via kdump.
> 
> Correct the range to be checked for GHCB contained in a huge page.
> Also ensure that the skipped huge page containing the GHCB page is
> transitioned back to private by applying the correct address mask
> later when changing GHCBs to private at end of kdump preparation.
> 
> Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/coco/sev/core.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Ok, I've pushed both patches here:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-urgent-sev

Please have those who are affected by the issues test and report back.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

