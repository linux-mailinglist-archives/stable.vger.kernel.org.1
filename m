Return-Path: <stable+bounces-3611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC7D80075C
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 10:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57251F20F50
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 09:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56521DA4D;
	Fri,  1 Dec 2023 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kRgA1lB/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA061BDC4;
	Fri,  1 Dec 2023 09:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBF5C433C7;
	Fri,  1 Dec 2023 09:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701423857;
	bh=/HU7YYYGlZOsppIXzdMtY/s2vvadGzpqVvlRTqQ1tNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kRgA1lB/6Lju+B52wsCua6IXa1rYnyzl++bAVlQqFX00OSzp/bLNu/zmaDzi98rWL
	 7zQq9+389a1W/UOEBznahHlZk/D//5GXVRqOsxKHYGDgIajs9ElL7A69baYPFKt3Q5
	 uDnOGD736Fdmf6hYIzKjRZRfVSzqJ9+RkNXmnUu0=
Date: Fri, 1 Dec 2023 09:44:15 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Francis Laniel <flaniel@linux.microsoft.com>
Cc: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 5.15 00/69] 5.15.141-rc1 review
Message-ID: <2023120155-mascot-scope-7bc6@gregkh>
References: <20231130162133.035359406@linuxfoundation.org>
 <CAEUSe78tYPTFuauB7cxZzvAeMhzB_25Q8DqLUfF7Nro9WsUhNw@mail.gmail.com>
 <2023120134-sabotage-handset-0b0d@gregkh>
 <4879383.31r3eYUQgx@pwmachine>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4879383.31r3eYUQgx@pwmachine>

On Fri, Dec 01, 2023 at 10:35:33AM +0100, Francis Laniel wrote:
> Hi!
> 
> Le vendredi 1 d�cembre 2023, 09:21:33 CET Greg Kroah-Hartman a �crit :
> > On Thu, Nov 30, 2023 at 12:11:31PM -0600, Daniel D�az wrote:
> > > Hello!
> > > 
> > > On Thu, 30 Nov 2023 at 11:44, Guenter Roeck <linux@roeck-us.net> wrote:
> > > > On 11/30/23 09:21, Daniel D�az wrote:
> > > > > Hello!
> > > > > 
> > > > > Lots of failures everywhere:
> > > > > * clang-17-lkftconfig                 arm64
> > > > > * clang-17-lkftconfig                 arm64
> > > > > * clang-17-lkftconfig                 arm64
> > > > > * clang-lkftconfig                    arm64
> > > > > * clang-lkftconfig                    arm
> > > > > * clang-lkftconfig                    i386
> > > > > * clang-lkftconfig                    x86_64
> > > > > * gcc-12-lkftconfig                   arm64
> > > > > * gcc-12-lkftconfig                   arm
> > > > > * gcc-12-lkftconfig                   i386
> > > > > * gcc-12-lkftconfig                   x86_64
> > > > > * gcc-12-lkftconfig-64k_page_size     arm64
> > > > > * gcc-12-lkftconfig-64k_page_size     arm64
> > > > > * gcc-12-lkftconfig-armv8_features    arm64
> > > > > * gcc-12-lkftconfig-debug             arm64
> > > > > * gcc-12-lkftconfig-debug             arm64
> > > > > * gcc-12-lkftconfig-debug             arm
> > > > > * gcc-12-lkftconfig-debug             i386
> > > > > * gcc-12-lkftconfig-debug             x86_64
> > > > > * gcc-12-lkftconfig-debug-kmemleak    arm64
> > > > > * gcc-12-lkftconfig-debug-kmemleak    arm
> > > > > * gcc-12-lkftconfig-debug-kmemleak    i386
> > > > > * gcc-12-lkftconfig-debug-kmemleak    x86_64
> > > > > * gcc-12-lkftconfig-devicetree        arm64
> > > > > * gcc-12-lkftconfig-kasan             arm64
> > > > > * gcc-12-lkftconfig-kasan             arm64
> > > > > * gcc-12-lkftconfig-kasan             x86_64
> > > > > * gcc-12-lkftconfig-kselftest         arm64
> > > > > * gcc-12-lkftconfig-kselftest-kernel  arm64
> > > > > * gcc-12-lkftconfig-kselftest-kernel  arm
> > > > > * gcc-12-lkftconfig-kselftest-kernel  i386
> > > > > * gcc-12-lkftconfig-kunit             arm64
> > > > > * gcc-12-lkftconfig-kunit             arm64
> > > > > * gcc-12-lkftconfig-kunit             arm
> > > > > * gcc-12-lkftconfig-kunit             i386
> > > > > * gcc-12-lkftconfig-kunit             x86_64
> > > > > * gcc-12-lkftconfig-libgpiod          arm64
> > > > > * gcc-12-lkftconfig-libgpiod          arm
> > > > > * gcc-12-lkftconfig-libgpiod          i386
> > > > > * gcc-12-lkftconfig-libgpiod          x86_64
> > > > > * gcc-12-lkftconfig-perf              arm64
> > > > > * gcc-12-lkftconfig-perf-kernel       arm64
> > > > > * gcc-12-lkftconfig-perf-kernel       arm
> > > > > * gcc-12-lkftconfig-perf-kernel       i386
> > > > > * gcc-12-lkftconfig-perf-kernel       x86_64
> > > > > * gcc-12-lkftconfig-rcutorture        arm64
> > > > > * gcc-12-lkftconfig-rcutorture        arm64
> > > > > * gcc-12-lkftconfig-rcutorture        arm
> > > > > * gcc-12-lkftconfig-rcutorture        i386
> > > > > * gcc-12-lkftconfig-rcutorture        x86_64
> > > > > 
> > > > > It's essentially this:
> > > > > 
> > > > > -----8<-----
> > > > > 
> > > > >    make --silent --keep-going --jobs=8
> > > > > 
> > > > > O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=x86_64 SRCARCH=x86
> > > > > CROSS_COMPILE=x86_64-linux-gnu- 'CC=sccache x86_64-linux-gnu-gcc'
> > > > > 'HOSTCC=sccache gcc'
> > > > > 
> > > > >    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x51:
> > > > > unreachable instruction
> > > > > 
> > > > >    x86_64-linux-gnu-ld: kernel/trace/trace_kprobe.o: in function
> > > > > 
> > > > > `__trace_kprobe_create':
> > > > >    trace_kprobe.c:(.text+0x2f39): undefined reference to
> > > > > 
> > > > > `kallsyms_on_each_symbol'
> > > > > 
> > > > >    x86_64-linux-gnu-ld: kernel/trace/trace_kprobe.o: in function
> > > > > 
> > > > > `create_local_trace_kprobe':
> > > > >    trace_kprobe.c:(.text+0x384b): undefined reference to
> > > > > 
> > > > > `kallsyms_on_each_symbol'
> > > > > 
> > > > >    make[1]: *** [/builds/linux/Makefile:1227: vmlinux] Error 1
> > > > >    make[1]: Target '__all' not remade because of errors.
> > > > >    make: *** [Makefile:226: __sub-make] Error 2
> > > > >    make: Target '__all' not remade because of errors.
> > > > > 
> > > > > ----->8-----
> > > > > 
> > > > > It only affects 5.15. Bisection in progress.
> > > > 
> > > > I guess it will point to
> > > > 
> > > > >> Francis Laniel <flaniel@linux.microsoft.com>
> > > > >> 
> > > > >>      tracing/kprobes: Return EADDRNOTAVAIL when func matches several
> > > > >>      symbols
> > > 
> > > It sure did!:
> > >   commit 7b4375c36a4c0e1b4b97ccbcdd427db5a460e04f
> > >   Author: Francis Laniel <flaniel@linux.microsoft.com>
> > >   Date:   Fri Oct 20 13:42:49 2023 +0300
> > >   
> > >       tracing/kprobes: Return EADDRNOTAVAIL when func matches several
> > >       symbols
> > >       
> > >       commit b022f0c7e404887a7c5229788fc99eff9f9a80d5 upstream.
> > > 
> > > Reverting that commit made the build pass again.
> > 
> > {sigh}
> > 
> > Francis, I think this is the second or third time this has happened with
> > the attempt to get this patch merged.  I'm going to go drop it from all
> > of the pending stable queues again, and please, if you wish to have it
> > applied in the future, I am going to have to see some proof it was
> > actually tested on the architectures that it keeps breaking.
> 
> Sorry for the disagreement, for this one, I had to add the CONFIG_LIVEPATCH to 
> then be able to call kallsyms_on_each_symbol(), as on 5.15, this function is 
> within a ifdef guard [1].
> 
> I suppose you do not want to add CONFIG_LIVEPATCH to default config, so I will 
> try to find a way for this specific kernel!

It doesn't matter about any "default config", you can not break the
build of any config.

> Did you get problems only for 5.15 kernel? Or others too?

I don't know, but for obvious reasons if it is not working in 5.15.y, we
can't take it in older kernels as that would be a regression when people
move to a newer one.

> In the second case, can you please link me the problems and I will polish 
> everything.

Please take some time with a cross-compiler on the above listed
architectures and configurations to verify your changes do not break
anything again.

thanks,

greg k-h

