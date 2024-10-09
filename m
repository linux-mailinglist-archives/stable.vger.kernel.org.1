Return-Path: <stable+bounces-83145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FB6995F7B
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 08:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD781C220B9
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 06:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7768915885E;
	Wed,  9 Oct 2024 06:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="P3rgBjT9"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3F936D;
	Wed,  9 Oct 2024 06:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454288; cv=none; b=K/TF/HHArMOZjvlY+br0AakXMYAZw7u5EDXj18/AYf5kzpei/6b+JU2keovWOhFgKqmVWzp30Z5O4xNfMLnaoRWx40YDHN13rh6t+8AWGYO34cw7Fa75bsDSwasomEcjGi+hm7f9rHs+VX0bWSvkJpFbQqQHF/EGak2roKjP1BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454288; c=relaxed/simple;
	bh=IwNYGEjSRprLLWrgfeF9psb8bwhoUuY4fiHwPthxkVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJE80q4PwkR+rTEcuQWGh5zwCgwcNgJqkdc+Q6u1Cqphwflg/dN9mF9qr8oqNJIWuHZ+mqQ1jhqcstsaVVuNHBSEIbrsbouDvlRD5EPLBEq5ZPEbzIbaTNUbfH2xgAoCtEK19U5lx6z+fCgsrY4diIvc+mfJOAGHGqDTbs8MC6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=P3rgBjT9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8172940E0191;
	Wed,  9 Oct 2024 06:11:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pinXfuKkQPDS; Wed,  9 Oct 2024 06:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1728454279; bh=mte4q73hd97cfC/NKQCV7JLzWpmDLpTUP99N/916jIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P3rgBjT9ToVYKwlsDMVXWlxim/L1EFJUYboVY0uXAFBGJBGGUiHhzmgQWvAOyCjHB
	 selONYgMcpEI+xSCGzeOpHK3e/HjCW5NBx9s0Dc6OpqvRILIr1N8uKr60NnXfx5a+4
	 I01znC19tpfPvD7uRuzHV3RA2a3zScw25raZ+9OavTA2uoilFIZ4XTq/8f94QxZbl3
	 3u6nK+Y+IP04i76YNmS7PrSWkQ+38B9OLGlrmYCc85IjZCttEYYehSNeETxlGvnnJj
	 V1kZho+PLdZFsaioKIXyt2Sd6fg9Dtj1uOCYif6fqYnV1gySbBO1chINgl+d6qh4bR
	 0tmRA47rI/MujI/6HWrVGO0r1z3jFpOD6P3VsOxkn9MIASbVcKIkokdcvsCJ4HyABM
	 5wEB+TqWTXJo2lyt7Y2pxrJgKZeLneIaMHwU8cBNxbq7BZ3SRXr74J63Ix4EpAT4pv
	 bco0G1Ng7er6Yz4N+c1CkA26LOkwXUewe80jd4sLWJ/F/gXrK61UGfmktSHkhTPEi1
	 +8cv1FyaxOHAD4zhROfMUbRd7JElrfH3wcBYBfDr4NbOgmrTqsZPa4jLvBLE2Gockr
	 0icZwiDJTDJnlPEX/jfp+0QJKnn/jBEmF7kIPSWVEkeRCZ6HWgu9ZD91N3VieSYla2
	 AY1CFtKGygXIOLttyecXKt9I=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3E61740E0163;
	Wed,  9 Oct 2024 06:11:08 +0000 (UTC)
Date: Wed, 9 Oct 2024 08:11:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Robert Gill <rtgill82@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, 5.10+@tip-bot2.tec.linutronix.de,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/bugs: Use code segment selector for VERW
 operand
Message-ID: <20241009061102.GBZwYediMceBEfSEFo@fat_crate.local>
References: <172842753652.1442.15253433006014560776.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <172842753652.1442.15253433006014560776.tip-bot2@tip-bot2>

On Tue, Oct 08, 2024 at 10:45:36PM -0000, tip-bot2 for Pawan Gupta wrote:
>  .macro CLEAR_CPU_BUFFERS
> -	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
> +#ifdef CONFIG_X86_64
> +	ALTERNATIVE "", "verw mds_verw_sel(%rip)", X86_FEATURE_CLEAR_CPU_BUF
> +#else
> +	/*
> +	 * In 32bit mode, the memory operand must be a %cs reference. The data
> +	 * segments may not be usable (vm86 mode), and the stack segment may not
> +	 * be flat (ESPFIX32).
> +	 */
> +	ALTERNATIVE "", "verw %cs:mds_verw_sel", X86_FEATURE_CLEAR_CPU_BUF
> +#endif

So why didn't we ifdef the "verw mds_verw_sel(%rip)" and "verw
%cs:mds_verw_sel" macro argument instead of adding more bigger ugly ifdeffery?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

