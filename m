Return-Path: <stable+bounces-83154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E67ED9960F8
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 09:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E3828A846
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 07:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7681D17B4FC;
	Wed,  9 Oct 2024 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tgUDUALd"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629D917C7A3;
	Wed,  9 Oct 2024 07:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728459285; cv=none; b=mzfLizazPt4uKo4jbI5iM5pGAXEnilhu8PIGkfsL7i/JbHL/jorfNvhifbN5928jAQ48fdmaNgpVftohLva2DV6jJsOCiBwuDAb6TFf1mZ9juh3CNC+G4+pK7Bo8j7UJLjyE2ViNN6HJaG35mN3CGBpoQCG2BjvlcyaCgFlQ4qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728459285; c=relaxed/simple;
	bh=4qzKaeRJ6mGMLOGC4y7BNXaP1H+T9+YTulGXrHRfB6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BawVXwmsFXL+Kwogy1ctPf56OX/xXlK5lXLB8/yIw9KeY3PF4xBxOnkpysBT3bqCJilMXC+qvFPTKIJx5JvBi8nvDwFxjdiy0bTFi6FDQ9JwF64CUjI7Z0uute1joziDed1+gRKXGiOeagAqEmXOHLohAlW8f8dqDyWSgTVQj+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tgUDUALd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uXaLsoyM8cEUeBx0eKvAyp5EYahXL72x2w5bugdgiCo=; b=tgUDUALd9DdrU+ZAbwnSd9wpuP
	kgDkGal7jD3croQjABdWmEGsmsaA169h18gso9UzMtHgngSL51Q91ca0DwTWLqoYWf0U7I1RosQs5
	ykfyec55tLKX6E1ZVvJQ0oTa2lc53zpi1XlOvYq/kWWMjh58wiec8kabEvvEIO64Wr853LUImSoqA
	aDdmR4h+9J80CoDSpJWNctacGpK0JYZNVHsk5LwoXly7bOkdCI2utm8X6NnJ2pWsW+I3/HkGjDojD
	sxmVtLDBqnCPom+Xm4AZUBvS8QpDMJ2M9t58zhqcT+Kdq9Xpe9gBgxtXuPk5g1bmePBR7snIzMqyi
	E2O/eQOg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syRDR-00000004HVd-1V7U;
	Wed, 09 Oct 2024 07:34:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6864F3004AF; Wed,  9 Oct 2024 09:34:37 +0200 (CEST)
Date: Wed, 9 Oct 2024 09:34:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, 5.10+@tip-bot2.tec.linutronix.de,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/bugs: Use code segment selector for VERW
 operand
Message-ID: <20241009073437.GG17263@noisy.programming.kicks-ass.net>
References: <172842753652.1442.15253433006014560776.tip-bot2@tip-bot2>
 <20241009061102.GBZwYediMceBEfSEFo@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009061102.GBZwYediMceBEfSEFo@fat_crate.local>

On Wed, Oct 09, 2024 at 08:11:02AM +0200, Borislav Petkov wrote:
> On Tue, Oct 08, 2024 at 10:45:36PM -0000, tip-bot2 for Pawan Gupta wrote:
> >  .macro CLEAR_CPU_BUFFERS
> > -	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
> > +#ifdef CONFIG_X86_64
> > +	ALTERNATIVE "", "verw mds_verw_sel(%rip)", X86_FEATURE_CLEAR_CPU_BUF
> > +#else
> > +	/*
> > +	 * In 32bit mode, the memory operand must be a %cs reference. The data
> > +	 * segments may not be usable (vm86 mode), and the stack segment may not
> > +	 * be flat (ESPFIX32).
> > +	 */
> > +	ALTERNATIVE "", "verw %cs:mds_verw_sel", X86_FEATURE_CLEAR_CPU_BUF
> > +#endif
> 
> So why didn't we ifdef the "verw mds_verw_sel(%rip)" and "verw
> %cs:mds_verw_sel" macro argument instead of adding more bigger ugly ifdeffery?

You need ifdeffery either way around, either directly like this or for
that macro. This is simple and straight forward.

