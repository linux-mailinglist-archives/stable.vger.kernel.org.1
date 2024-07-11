Return-Path: <stable+bounces-59073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3563F92E304
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 11:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AC71C20A3B
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 09:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29CA156225;
	Thu, 11 Jul 2024 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XK1ebZAh"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360FC155CAC;
	Thu, 11 Jul 2024 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720688619; cv=none; b=PWwO2Wh+fCtylwmW2PiWwO5wmM7+Zjxer4uRnGNRE9aUChudL3EYqs3XN4TGlUpNvkjfrpFDOofwRBOhKmWmlZ3AXxIHIzlI4DBjAAB1T9JWhH304mZ0fyKivBLwMk5vrMwATBNHOQ5jz6kNOz9MruhaYfuc/fk0CiqO+tfRoFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720688619; c=relaxed/simple;
	bh=jeEDe/8MtEbbTRbq+x6Zlhlnsoct6hDMzlKssrUGljo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhE55IDkbV5wjz5n+Y44LEXDRpxdIvR8pn9kMi08fYOEwy9Eoolgpeppyj74Sq81unPSa0uCkW/UGEP2e3rVtEUl35qn3D1wFaHm31vZS0sPoky9lT0v/eHRQCb5mCudT2hJP8qnJRZ+FHAwP8LsmalvJSSMWVwEZ2iR2/ZpFYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XK1ebZAh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yn/4uYOR0MzDP1hMwQP15burd4Chzf+nAfXSwrvjRPg=; b=XK1ebZAh+HCjYp1oViuJiR//xj
	Sd95oMuFovK/BkncM6YHrnbELaDeDW6WInd4ap1UC0fG1gRQV4M1iY2SMbb+07mOcUCZ4bm68yUvj
	+xwWLq25xqF+Qlk7yopNKUegn01WvPZpEHdMLqoAjMm/L5IQ/JuzP7GcTpOBsrxJikVG2yMb/70iq
	LLKKUfBwEHSg6txyuLGzpCvE2pkR+ErEvNj1mnGMNoL+4c1YNEecK5YSgcXn7z47ZfsKoIbrQZoci
	5SzX2y1hYu9oFib9H37c+8vQwmf3/+9bhzHhCJ4ekIUOwcpyiRV2k3nW//vGZOeqg7y36FtEwntxM
	F+K4u+vA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRpi6-0000000AnX0-2uqm;
	Thu, 11 Jul 2024 09:03:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2C92530050D; Thu, 11 Jul 2024 11:03:30 +0200 (CEST)
Date: Thu, 11 Jul 2024 11:03:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	Jari Ruusu <jariruusu@protonmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v4] x86/entry_32: Use stack segment selector for VERW
 operand
Message-ID: <20240711090329.GI4587@noisy.programming.kicks-ass.net>
References: <20240710-fix-dosemu-vm86-v4-1-aa6464e1de6f@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710-fix-dosemu-vm86-v4-1-aa6464e1de6f@linux.intel.com>

On Wed, Jul 10, 2024 at 12:06:47PM -0700, Pawan Gupta wrote:
> +/*
> + * Safer version of CLEAR_CPU_BUFFERS that uses %ss to reference VERW operand
> + * mds_verw_sel. This ensures VERW will not #GP for an arbitrary user %ds.
> + */
> +.macro CLEAR_CPU_BUFFERS_SAFE
> +	ALTERNATIVE "jmp .Lskip_verw\@", "", X86_FEATURE_CLEAR_CPU_BUF
> +	verw	%ss:_ASM_RIP(mds_verw_sel)
> +.Lskip_verw\@:
> +.endm

I know this is somewhat of a common pattern, but I think it is silly in
this case. Since we already have the ALTERNATIVE() why not NOP the one
VERW instruction instead?

That is,

	ALTERNATIVE("", "verw %ss:_ASM_RIP(mds_verw_sel)", X86_FEATURE_CLEAR_CPU_BUF)

and call it a day?

