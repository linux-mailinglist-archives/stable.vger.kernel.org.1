Return-Path: <stable+bounces-91708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B219BF547
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 19:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD923B248E5
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 18:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8738205E3C;
	Wed,  6 Nov 2024 18:31:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE33E36D
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730917919; cv=none; b=l7YCVbnfoonge5ehIGDIbUiyGvovDVSys5s+20iWQ3jo0qAcFq6SYXjGbP6G3xzZtpJa2GsYiiUcoLrfzQhjMh9h3xCyfMZ+wWB32Zui6WoSiPydOh4tUAZynWFw3kKdatfx1IrnibaVW+vJrbCgaglPJdWllLIK3fbSI3uU0bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730917919; c=relaxed/simple;
	bh=3UKvbNKM++MFOTeqBmPjKQZJQ3wWqu7GOsv8HpfD4xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyLS6YsyFFfJMlvAFIb29dKw6h3gK4FXLGIgF7X1egedh0kQ7ThBb7V56yWUuy42mjZkz6pi3impvijU4alXj7i1FYjGlQ29y4JXj794bkDu5P9625KLBHuvD5b8ADWmiWtKpOjadxXQt9FzxBIcHlqbd+6jFaCRAe7ZVR7Eba8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 4A6ITW0E024009;
	Wed, 6 Nov 2024 12:29:32 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 4A6ITVEL024004;
	Wed, 6 Nov 2024 12:29:31 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 6 Nov 2024 12:29:31 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        llvm@lists.linux.dev, patches@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/vdso: Drop -mstack-protector-guard flags in 32-bit files with clang
Message-ID: <20241106182931.GI29862@gate.crashing.org>
References: <20241030-powerpc-vdso-drop-stackp-flags-clang-v1-1-d95e7376d29c@kernel.org> <884cf694-09c7-4082-a6b1-6de987025bf8@csgroup.eu> <20241106133752.GG29862@gate.crashing.org> <20241106152114.GA2738371@thelio-3990X>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106152114.GA2738371@thelio-3990X>
User-Agent: Mutt/1.4.2.3i

Hi!

On Wed, Nov 06, 2024 at 08:21:14AM -0700, Nathan Chancellor wrote:
> > (r2 is the default for -m32, r13 is the default for -m64, it appears
> > that clang does not implement this option at all, it simply checks if
> > you set the default, and explodes if not).
> 
> Not sure that I would say it has not been implemented correctly, more
> that it has not been implemented in the same manner as GCC. Keith chose
> not to open up support for arbitrary registers to keep the
> implementation of this option in LLVM simple:

LLVM claims to be compatible to GCC.  It is not.  This is a bug.  As it
is, LLVM can not be used to compile the PowerPC kernel.

These flags (-mstack-protector-guard-{reg,offset}=) are there
*specifically* so that the user can choose to use something different
from the default.  I added this (back in 2017) because the kernel needed
it.  Some other GCC ports (aarch64, arm, riscv, x86) have followed suit
since then, btw.


Segher

