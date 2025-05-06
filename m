Return-Path: <stable+bounces-141769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F35EAABED2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 11:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF2F1C076F5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 09:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB9F27A126;
	Tue,  6 May 2025 09:09:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E827427A476;
	Tue,  6 May 2025 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522573; cv=none; b=gqCYawwZ/7YW7EEDFm+O1yANoKZNbNZgGzde16riEU0X1f6x/tCDmykXh+peJhaNOEkygCO3iMxrmFwlQgR2+p375fZ4tf+ONOO3gAYsJtyG2oMMVdNnmPLon4nJKnFE6E3tw/QFaybKQYpHckNfhHsregQYsiR5mssyT0agqdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522573; c=relaxed/simple;
	bh=3S+K8XIeC71C6TtT8cddTivigWUywntRwYzAEJ4uX6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m536iworMdMf1v8V6Ekd9OQSXeMlTnlVp7gAIQ8CAJRK7ypF1EqkrKa7XmQpvEFZy284I1mBIhStIrJ+OABwDT/ilAhmMmbEODRwnsJKBfA995ze3AsLspkRk7RbcPAQ8yTIPLJtlFLdl9n/jxkn4t0XCbC2FquoTmBoNmdSFBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C68C4CEF1;
	Tue,  6 May 2025 09:09:29 +0000 (UTC)
Date: Tue, 6 May 2025 10:09:27 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: will@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com, broonie@kernel.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	shameerali.kolothum.thodi@huawei.com, james.morse@arm.com,
	hardevsinh.palaniya@siliconsignals.io, ardb@kernel.org,
	ryan.roberts@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/cpufeature: annotate arm64_use_ng_mappings with
 ro_after_init to prevent wrong idmap generation
Message-ID: <aBnRx4do8Ly0llZ8@arm.com>
References: <20250502180412.3774883-1-yeoreum.yun@arm.com>
 <174626735218.2189871.10298017577558632540.b4-ty@arm.com>
 <aBYkGJmfWDZHBEzp@arm.com>
 <aBZ7P3/dUfSjB0oV@e129823.arm.com>
 <aBkL-zUpbg7_gCEp@arm.com>
 <aBnDqvY5c6a3qQ4H@e129823.arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBnDqvY5c6a3qQ4H@e129823.arm.com>

On Tue, May 06, 2025 at 09:09:14AM +0100, Yeoreum Yun wrote:
> > On Sat, May 03, 2025 at 09:23:27PM +0100, Yeoreum Yun wrote:
> > > Hi Catalin,
> > >
> > > > On Sat, May 03, 2025 at 11:16:12AM +0100, Catalin Marinas wrote:
> > > > > On Fri, 02 May 2025 19:04:12 +0100, Yeoreum Yun wrote:
> > > > > > create_init_idmap() could be called before .bss section initialization
> > > > > > which is done in early_map_kernel().
> > > > > > Therefore, data/test_prot could be set incorrectly by PTE_MAYBE_NG macro.
> > > > > >
> > > > > > PTE_MAYBE_NG macro set NG bit according to value of "arm64_use_ng_mappings".
> > > > > > and this variable places in .bss section.
> > > > > >
> > > > > > [...]
> > > > >
> > > > > Applied to arm64 (for-next/fixes), with some slight tweaking of the
> > > > > comment, thanks!
> > > > >
> > > > > [1/1] arm64/cpufeature: annotate arm64_use_ng_mappings with ro_after_init to prevent wrong idmap generation
> > > > >       https://git.kernel.org/arm64/c/12657bcd1835
> > > >
> > > > I'm going to drop this for now. The kernel compiled with a clang 19.1.5
> > > > version I have around (Debian sid) fails to boot, gets stuck early on:
> > > >
> > > > $ clang --version
> > > > Debian clang version 19.1.5 (1)
> > > > Target: aarch64-unknown-linux-gnu
> > > > Thread model: posix
> > > > InstalledDir: /usr/lib/llvm-19/bin
> > > >
> > > > I didn't have time to investigate, disassemble etc. I'll have a look
> > > > next week.
> > >
> > > Just for your information.
> > > When I see the debian package, clang 19.1.5-1 doesn't supply anymore:
> > >  - https://ftp.debian.org/debian/pool/main/l/llvm-toolchain-19/
> > >
> > > and the default version for sid is below:
> > >
> > > $ clang-19 --version
> > > Debian clang version 19.1.7 (3)
> > > Target: aarch64-unknown-linux-gnu
> > > Thread model: posix
> > > InstalledDir: /usr/lib/llvm-19/bin
> > >
> > > When I tested with above version with arm64-linux's for-next/fixes
> > > including this patch. it works well.
> >
> > It doesn't seem to be toolchain related. It fails with gcc as well from
> > Debian stable but you'd need some older CPU (even if emulated, e.g.
> > qemu). It fails with Cortex-A72 (guest on Raspberry Pi 4) but not
> > Neoverse-N2. Also changing the annotation from __ro_after_init to
> > __read_mostly also works.
> 
> Thanks to let me know. But still I've failed to reproduce this
> on Cortex-a72 and any older cpu on qeum.
> If you don't mind, would you share your Kconfig?

Just defconfig with gcc (Debian 12.2.0-14) 12.2.0. It fails for me with
"qemu -bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd -cpu cortex-a53" (I
have qemu 9.1.1 around, I don't think that's relevant).

-- 
Catalin

