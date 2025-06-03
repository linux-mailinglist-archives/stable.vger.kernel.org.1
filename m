Return-Path: <stable+bounces-150721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3898ACC972
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 16:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E5216DA10
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 14:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBA8149DE8;
	Tue,  3 Jun 2025 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B2Q4TXOy"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4326617548;
	Tue,  3 Jun 2025 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748961946; cv=none; b=I8b4aQHCFAKWT/hPJxeravpd8SbsMjIsRH/rcPFwmDsdccc1ilxrJ0oLj2RuwYbv7mlIIBZWgQPPVa+zoMN1Q6pWjyZnvUEbTFt3lyWTCw1iEuofnw3Byp0/i20KtPzMXxIALHcfFRb78s0Y9+IkwIiPmxfy670yyKvFl3SC7v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748961946; c=relaxed/simple;
	bh=1JlJAe26MY/anRgV34GXGi0rchvwwjIwcaRpaEnV650=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzOBLLjeZEGJM0XYdfMIVJet7juDewGpCun/9T47NN/1tqeFZ14RmphZjIAsaIX6mFHfVGkrPPSoIU6xh+XWgXTvvgz12Lcg9EtA2OC49cQNLF5CUhTt8by0V+dx07RFF8D7v4bL0+SNFJrhoZqG6J1niOOnSWJ+yN1KSNEeI0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B2Q4TXOy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bQLRtN52BcH7vSLS4OtHTfDBVdq45tUVXlkPEHMtslk=; b=B2Q4TXOy9vY4zvv1Fmm4MPvELq
	VPaMNcvlHTj+x/Cz9kM4aP/rNhJTvUSvO7qGGlaUga2j2fvhf64AOMZNoTBIucZjEyvNV3tpMNMPn
	Gn/QYkzgDbenLHWDxk23Whk2cC3qywcdhgXTgmeZLQQhzFi1LHjNVmKPS/1rCNpipTkQxJhMsjJZ7
	DG4iVYXdth4GkWdNkU6KeCg74q1vHhqCmpW3pTMJaSFDX5AkEdSunpqaNOTMVVTe51RjxYo8Fxhlv
	hGCor/8e7mywZAFKoRAjT/dFiFbe+AQY1NqS0tlaRjt036RcQuckWKx2hj8M4gVJHmHPcdOfufmme
	O26wT2FA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMStY-000000027xy-2S0J;
	Tue, 03 Jun 2025 14:45:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EF3CF300780; Tue,  3 Jun 2025 16:45:39 +0200 (CEST)
Date: Tue, 3 Jun 2025 16:45:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	=?utf-8?B?Su+/vXJnZW4=?= Gro <jgross@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>, Xin Li <xin@zytor.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH 4/5] x86/its: explicitly manage permissions for ITS pages
Message-ID: <20250603144539.GD38114@noisy.programming.kicks-ass.net>
References: <20250603111446.2609381-1-rppt@kernel.org>
 <20250603111446.2609381-5-rppt@kernel.org>
 <20250603135845.GA38114@noisy.programming.kicks-ass.net>
 <aD8IeQLZUDvgoQZm@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD8IeQLZUDvgoQZm@kernel.org>

On Tue, Jun 03, 2025 at 05:36:41PM +0300, Mike Rapoport wrote:

> >  static void its_pages_protect(struct its_array *pages)
> >  {
> > +	if (!IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
> > +		return;
> > +
> 
> But modules generally use STRICT_MODULE_RWX.

Oh, I can't read anymore :-( I'll undo that one.

