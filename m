Return-Path: <stable+bounces-54638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3927790F052
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 16:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B7728187C
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3633915E81;
	Wed, 19 Jun 2024 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4BFccYm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8A514A82
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807021; cv=none; b=KlKvHJmy5u4rLm5G4xQPVSe4Emfygcpywup1vXGHPNhKpe2ld7A1F0cs6/sWozzkLcNgdb8khJWTmLdgB/rSmCPjBa2mji/w1JItDtq8wPI8YfWw5icVpL+fyrEuiz+qu4AAJp7C1MkTsjDdZQhy4/PqStmhdlsXb/mOc3hMtyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807021; c=relaxed/simple;
	bh=E3CTTqhTne2YlNf6LRAW9Y7fzpkSc7Sj09P8H1Htm/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruzgHOGCJt2Buw/NwM7BheHlsLoTdjLMtZR0QNCTI/oPGPsjnXIjk4KX3LHmFf0b+10P2/IlbPqtJldTWeyAKsBE8lG2CJ17jZTxAfZywAyTzKeYrQbRgGgQbmzFkYNKzv6+GxMoIdk8qNMl+EgE9Mr67f/N1ZzWNBmHjNWOzF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4BFccYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9C0C2BBFC;
	Wed, 19 Jun 2024 14:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718807020;
	bh=E3CTTqhTne2YlNf6LRAW9Y7fzpkSc7Sj09P8H1Htm/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k4BFccYm2njTLxvK+9lUIGmfYFIKc+8TexwaWHjKKBclahabrqa5ICAlMbQTc5nah
	 44MtX0nV4oNblOV8mF7xcjcbc/iX0jZaLDNcXBzcIxIm8xOHCCwMqeHsbW0jFqSwmB
	 ZK+223zzrT2fTjM7O0XTEqGg/mkkVHXqGKp+eNJGjnIh97qtWz2aIpOrt7DDbODBdY
	 vuft3JVitTozFTfwDAbOr/1Mh8qf9MlVbmGoVvLSdQxEszrBEXUukkVDgutc7MKbwc
	 5UADia0ZHiGhtOezErZjXI1nqWGyjhY0F9SrTO1Gj3GWRnLOzVMmp3tMM+pteh3szm
	 ercy23GrSWNCw==
Date: Wed, 19 Jun 2024 07:23:39 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] kbuild: Remove support for Clang's ThinLTO caching
Message-ID: <20240619142339.GA1832103@thelio-3990X>
References: <2024061340-troubling-automated-9989@gregkh>
 <20240613183322.1088226-1-nathan@kernel.org>
 <2024061937-footpad-altitude-1462@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024061937-footpad-altitude-1462@gregkh>

On Wed, Jun 19, 2024 at 12:51:55PM +0200, Greg KH wrote:
> On Thu, Jun 13, 2024 at 11:33:22AM -0700, Nathan Chancellor wrote:
> > commit aba091547ef6159d52471f42a3ef531b7b660ed8 upstream.
> > 
> > There is an issue in clang's ThinLTO caching (enabled for the kernel via
> > '--thinlto-cache-dir') with .incbin, which the kernel occasionally uses
> > to include data within the kernel, such as the .config file for
> > /proc/config.gz. For example, when changing the .config and rebuilding
> > vmlinux, the copy of .config in vmlinux does not match the copy of
> > .config in the build folder:
> > 
> >   $ echo 'CONFIG_LTO_NONE=n
> >   CONFIG_LTO_CLANG_THIN=y
> >   CONFIG_IKCONFIG=y
> >   CONFIG_HEADERS_INSTALL=y' >kernel/configs/repro.config
> > 
> >   $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 clean defconfig repro.config vmlinux
> >   ...
> > 
> >   $ grep CONFIG_HEADERS_INSTALL .config
> >   CONFIG_HEADERS_INSTALL=y
> > 
> >   $ scripts/extract-ikconfig vmlinux | grep CONFIG_HEADERS_INSTALL
> >   CONFIG_HEADERS_INSTALL=y
> > 
> >   $ scripts/config -d HEADERS_INSTALL
> > 
> >   $ make -kj"$(nproc)" ARCH=x86_64 LLVM=1 vmlinux
> >   ...
> >     UPD     kernel/config_data
> >     GZIP    kernel/config_data.gz
> >     CC      kernel/configs.o
> >   ...
> >     LD      vmlinux
> >   ...
> > 
> >   $ grep CONFIG_HEADERS_INSTALL .config
> >   # CONFIG_HEADERS_INSTALL is not set
> > 
> >   $ scripts/extract-ikconfig vmlinux | grep CONFIG_HEADERS_INSTALL
> >   CONFIG_HEADERS_INSTALL=y
> > 
> > Without '--thinlto-cache-dir' or when using full LTO, this issue does
> > not occur.
> > 
> > Benchmarking incremental builds on a few different machines with and
> > without the cache shows a 20% increase in incremental build time without
> > the cache when measured by touching init/main.c and running 'make all'.
> > 
> > ARCH=arm64 defconfig + CONFIG_LTO_CLANG_THIN=y on an arm64 host:
> > 
> >   Benchmark 1: With ThinLTO cache
> >     Time (mean ± σ):     56.347 s ±  0.163 s    [User: 83.768 s, System: 24.661 s]
> >     Range (min … max):   56.109 s … 56.594 s    10 runs
> > 
> >   Benchmark 2: Without ThinLTO cache
> >     Time (mean ± σ):     67.740 s ±  0.479 s    [User: 718.458 s, System: 31.797 s]
> >     Range (min … max):   67.059 s … 68.556 s    10 runs
> > 
> >   Summary
> >     With ThinLTO cache ran
> >       1.20 ± 0.01 times faster than Without ThinLTO cache
> > 
> > ARCH=x86_64 defconfig + CONFIG_LTO_CLANG_THIN=y on an x86_64 host:
> > 
> >   Benchmark 1: With ThinLTO cache
> >     Time (mean ± σ):     85.772 s ±  0.252 s    [User: 91.505 s, System: 8.408 s]
> >     Range (min … max):   85.447 s … 86.244 s    10 runs
> > 
> >   Benchmark 2: Without ThinLTO cache
> >     Time (mean ± σ):     103.833 s ±  0.288 s    [User: 232.058 s, System: 8.569 s]
> >     Range (min … max):   103.286 s … 104.124 s    10 runs
> > 
> >   Summary
> >     With ThinLTO cache ran
> >       1.21 ± 0.00 times faster than Without ThinLTO cache
> > 
> > While it is unfortunate to take this performance improvement off the
> > table, correctness is more important. If/when this is fixed in LLVM, it
> > can potentially be brought back in a conditional manner. Alternatively,
> > a developer can just disable LTO if doing incremental compiles quickly
> > is important, as a full compile cycle can still take over a minute even
> > with the cache and it is unlikely that LTO will result in functional
> > differences for a kernel change.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: dc5723b02e52 ("kbuild: add support for Clang LTO")
> > Reported-by: Yifan Hong <elsk@google.com>
> > Closes: https://github.com/ClangBuiltLinux/linux/issues/2021
> > Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Closes: https://lore.kernel.org/r/20220327115526.cc4b0ff55fc53c97683c3e4d@kernel.org/
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > [nathan: Address conflict in Makefile]
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  Makefile | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> This applied to 5.15.y, not 6.1.y :(
> 
> Can you rebase and resend a fix for 6.1.y?

I don't understand how that is possible, this was generated directly on
top of 6.1.93 (as evidenced by the base commit) and there were no
changes to Makefile in 6.1.94. It still applies cleanly for me?

  $ curl -LSs https://lore.kernel.org/all/20240613183322.1088226-1-nathan@kernel.org/raw | patch -p1
  patching file Makefile

Cheers,
Nathan

