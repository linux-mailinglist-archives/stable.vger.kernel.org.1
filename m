Return-Path: <stable+bounces-55025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71F391510E
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83AD828796F
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 14:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5D419CCE1;
	Mon, 24 Jun 2024 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xl7xeT22"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10F719B59D
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240745; cv=none; b=OMZ5RU8irAPlZuTDz9unlNBg+ia8SNsdbKT6zk1aJyxdbYogDLOZQZc6w6d8wQPPM8BYs5ssOl0XGVUtIWAWr0EaQcCd8KBkP5Mb2ZwpXgTGJGnD46MrVUXuXoX9cN38llebw97rsB6BTVfYu8zGTTfon1MikISVVRgxub/K8Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240745; c=relaxed/simple;
	bh=PUtwU3qeRrjU6LGPkhJdHaW/LhvCar+FH30FmhPyfpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSOFLnX/MWJKmQzqgGaBTDCnmyNAoO9OXFbx/dE8K5W40Yl8WEnpM555EFQSqmjR9K2fFx+cDcG8GQim24b/vIBsf8Cuv1qRKnCCCs1bYQpyzRn81nQNJBwh1rCRpZDD/sp31RV2yFS6nxGtbUsI0/4Xc6GbKf7T/OQ/3S6io1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xl7xeT22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B64EC2BBFC;
	Mon, 24 Jun 2024 14:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719240745;
	bh=PUtwU3qeRrjU6LGPkhJdHaW/LhvCar+FH30FmhPyfpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xl7xeT229ey9TMtCp5/MFRmPUcUrys1VrshSfvnjepDi3WcTt43axiYOk1HuDQAnw
	 CJ69svXd0EA98npRhA5AHfLo69MegW5udUBxAhPIDkriuuPbE6FYEzt9AE3eqaPhp/
	 H9PBCNxTa1khWp9rECy1zU9CEVwDxMYKvQsd2fmg=
Date: Mon, 24 Jun 2024 16:52:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] kbuild: Remove support for Clang's ThinLTO caching
Message-ID: <2024062404-breeze-huddle-cd8c@gregkh>
References: <2024061340-troubling-automated-9989@gregkh>
 <20240613183322.1088226-1-nathan@kernel.org>
 <2024061937-footpad-altitude-1462@gregkh>
 <20240619142339.GA1832103@thelio-3990X>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240619142339.GA1832103@thelio-3990X>

On Wed, Jun 19, 2024 at 07:23:39AM -0700, Nathan Chancellor wrote:
> On Wed, Jun 19, 2024 at 12:51:55PM +0200, Greg KH wrote:
> > On Thu, Jun 13, 2024 at 11:33:22AM -0700, Nathan Chancellor wrote:
> > > commit aba091547ef6159d52471f42a3ef531b7b660ed8 upstream.
> > > 
> > > There is an issue in clang's ThinLTO caching (enabled for the kernel via
> > > '--thinlto-cache-dir') with .incbin, which the kernel occasionally uses
> > > to include data within the kernel, such as the .config file for
> > > /proc/config.gz. For example, when changing the .config and rebuilding
> > > vmlinux, the copy of .config in vmlinux does not match the copy of
> > > .config in the build folder:
> > > 
> > >   $ echo 'CONFIG_LTO_NONE=n
> > >   CONFIG_LTO_CLANG_THIN=y
> > >   CONFIG_IKCONFIG=y
> > >   CONFIG_HEADERS_INSTALL=y' >kernel/configs/repro.config
> > > 
> > >   $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 clean defconfig repro.config vmlinux
> > >   ...
> > > 
> > >   $ grep CONFIG_HEADERS_INSTALL .config
> > >   CONFIG_HEADERS_INSTALL=y
> > > 
> > >   $ scripts/extract-ikconfig vmlinux | grep CONFIG_HEADERS_INSTALL
> > >   CONFIG_HEADERS_INSTALL=y
> > > 
> > >   $ scripts/config -d HEADERS_INSTALL
> > > 
> > >   $ make -kj"$(nproc)" ARCH=x86_64 LLVM=1 vmlinux
> > >   ...
> > >     UPD     kernel/config_data
> > >     GZIP    kernel/config_data.gz
> > >     CC      kernel/configs.o
> > >   ...
> > >     LD      vmlinux
> > >   ...
> > > 
> > >   $ grep CONFIG_HEADERS_INSTALL .config
> > >   # CONFIG_HEADERS_INSTALL is not set
> > > 
> > >   $ scripts/extract-ikconfig vmlinux | grep CONFIG_HEADERS_INSTALL
> > >   CONFIG_HEADERS_INSTALL=y
> > > 
> > > Without '--thinlto-cache-dir' or when using full LTO, this issue does
> > > not occur.
> > > 
> > > Benchmarking incremental builds on a few different machines with and
> > > without the cache shows a 20% increase in incremental build time without
> > > the cache when measured by touching init/main.c and running 'make all'.
> > > 
> > > ARCH=arm64 defconfig + CONFIG_LTO_CLANG_THIN=y on an arm64 host:
> > > 
> > >   Benchmark 1: With ThinLTO cache
> > >     Time (mean ± σ):     56.347 s ±  0.163 s    [User: 83.768 s, System: 24.661 s]
> > >     Range (min … max):   56.109 s … 56.594 s    10 runs
> > > 
> > >   Benchmark 2: Without ThinLTO cache
> > >     Time (mean ± σ):     67.740 s ±  0.479 s    [User: 718.458 s, System: 31.797 s]
> > >     Range (min … max):   67.059 s … 68.556 s    10 runs
> > > 
> > >   Summary
> > >     With ThinLTO cache ran
> > >       1.20 ± 0.01 times faster than Without ThinLTO cache
> > > 
> > > ARCH=x86_64 defconfig + CONFIG_LTO_CLANG_THIN=y on an x86_64 host:
> > > 
> > >   Benchmark 1: With ThinLTO cache
> > >     Time (mean ± σ):     85.772 s ±  0.252 s    [User: 91.505 s, System: 8.408 s]
> > >     Range (min … max):   85.447 s … 86.244 s    10 runs
> > > 
> > >   Benchmark 2: Without ThinLTO cache
> > >     Time (mean ± σ):     103.833 s ±  0.288 s    [User: 232.058 s, System: 8.569 s]
> > >     Range (min … max):   103.286 s … 104.124 s    10 runs
> > > 
> > >   Summary
> > >     With ThinLTO cache ran
> > >       1.21 ± 0.00 times faster than Without ThinLTO cache
> > > 
> > > While it is unfortunate to take this performance improvement off the
> > > table, correctness is more important. If/when this is fixed in LLVM, it
> > > can potentially be brought back in a conditional manner. Alternatively,
> > > a developer can just disable LTO if doing incremental compiles quickly
> > > is important, as a full compile cycle can still take over a minute even
> > > with the cache and it is unlikely that LTO will result in functional
> > > differences for a kernel change.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: dc5723b02e52 ("kbuild: add support for Clang LTO")
> > > Reported-by: Yifan Hong <elsk@google.com>
> > > Closes: https://github.com/ClangBuiltLinux/linux/issues/2021
> > > Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > Closes: https://lore.kernel.org/r/20220327115526.cc4b0ff55fc53c97683c3e4d@kernel.org/
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > [nathan: Address conflict in Makefile]
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > ---
> > >  Makefile | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > This applied to 5.15.y, not 6.1.y :(
> > 
> > Can you rebase and resend a fix for 6.1.y?
> 
> I don't understand how that is possible, this was generated directly on
> top of 6.1.93 (as evidenced by the base commit) and there were no
> changes to Makefile in 6.1.94. It still applies cleanly for me?
> 
>   $ curl -LSs https://lore.kernel.org/all/20240613183322.1088226-1-nathan@kernel.org/raw | patch -p1
>   patching file Makefile
> 

Very odd, I just tried it again and it worked, must have been a problem
on my side, sorry for the noise.

greg k-h

