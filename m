Return-Path: <stable+bounces-141783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB2AAAC108
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 12:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35CDA4A859F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 10:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20F327703C;
	Tue,  6 May 2025 10:12:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8BA27585E;
	Tue,  6 May 2025 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746526377; cv=none; b=Ylq6ta5Xp06UVPxKmdN4sJ0o00jLM84p6PkpIybBAbSp/sE4nhaJK7XBFwMxVAExPBL8QeHX0qrGh5XiUh1oiPRX6Ksxi84Ar+X9hTXTHiRD2UoopKi0KE510oWp0MM9rzsQPRXceLKsXoWV/SJDqjNEcr8xPJRfejdKaMG6XK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746526377; c=relaxed/simple;
	bh=Ngr7JnvUFx8dNX6/o6M3TBbzJOOYusnzmhNr5ZlMzrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l36z5zKCrn6MMrBNHrD4FWVYm0KacCBZG7VCZnqBIJIqLE7AiczVf+KRzRKv0TD5+SMRcqBOu2GMJrLOOWewy+dAJ8Sya/+5XV9mZnSbF98X69WVnsPmG38VFuGiZzkuMS9ezKGd2YIhsPQe9Dyj0l09LBDndCuXsFK5NUrYbkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC39FC4CEE4;
	Tue,  6 May 2025 10:12:52 +0000 (UTC)
Date: Tue, 6 May 2025 11:12:50 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, will@kernel.org, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, broonie@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com,
	shameerali.kolothum.thodi@huawei.com, james.morse@arm.com,
	hardevsinh.palaniya@siliconsignals.io, ardb@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/cpufeature: annotate arm64_use_ng_mappings with
 ro_after_init to prevent wrong idmap generation
Message-ID: <aBngorZeIASsJEvY@arm.com>
References: <20250502180412.3774883-1-yeoreum.yun@arm.com>
 <174626735218.2189871.10298017577558632540.b4-ty@arm.com>
 <aBYkGJmfWDZHBEzp@arm.com>
 <aBZ7P3/dUfSjB0oV@e129823.arm.com>
 <aBkL-zUpbg7_gCEp@arm.com>
 <aBnDqvY5c6a3qQ4H@e129823.arm.com>
 <fbfded61-cfe2-4416-9098-ef39ef3e2b62@arm.com>
 <aBnOJS6TZxlZiYQ/@e129823.arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBnOJS6TZxlZiYQ/@e129823.arm.com>

On Tue, May 06, 2025 at 09:53:57AM +0100, Yeoreum Yun wrote:
> > >>>> On Sat, May 03, 2025 at 11:16:12AM +0100, Catalin Marinas wrote:
> > >>>>> On Fri, 02 May 2025 19:04:12 +0100, Yeoreum Yun wrote:
> > >>>>>> create_init_idmap() could be called before .bss section initialization
> > >>>>>> which is done in early_map_kernel().
> > >>>>>> Therefore, data/test_prot could be set incorrectly by PTE_MAYBE_NG macro.
> > >>>>>>
> > >>>>>> PTE_MAYBE_NG macro set NG bit according to value of "arm64_use_ng_mappings".
> > >>>>>> and this variable places in .bss section.
> > >>>>>>
> > >>>>>> [...]
> > >>>>>
> > >>>>> Applied to arm64 (for-next/fixes), with some slight tweaking of the
> > >>>>> comment, thanks!
> > >>>>>
> > >>>>> [1/1] arm64/cpufeature: annotate arm64_use_ng_mappings with ro_after_init to prevent wrong idmap generation
> > >>>>>       https://git.kernel.org/arm64/c/12657bcd1835
> > >>>>
> > >>>> I'm going to drop this for now. The kernel compiled with a clang 19.1.5
> > >>>> version I have around (Debian sid) fails to boot, gets stuck early on:
[...]
> Personally, I don't believe this because the create_init_idmap()
> maps the the .rodata section with PAGE_KERNEL pgprot
> from __initdata_begin to _end.
> 
> and at the mark_readonly() the pgprot is changed to PAGE_KERNEL_RO
> But, arm64_use_ng_mappings is accessed with write before mark_readonly()
> only via smp_cpus_done().
> 
> JFYI here is map information:
> 
> // mark_readlonly() changes to ro perm below ranges:
> ffff800081b30000 g       .rodata	0000000000000000 __start_rodata
> ffff800082560000 g       .rodata.text	0000000000000000 __init_begin
> 
> // create_init_idmap() maps below range with PAGE_KERNEL.
> ffff8000826d0000 g       .altinstructions	0000000000000000 __initdata_begin
> ffff800082eb0000 g       .bss	0000000000000000 _end
> 
> ffff8000824596d0 g     O .rodata	0000000000000001 arm64_use_ng_mappings

So arm64_use_ng_mappings is mapped as read-only since .rodata is before
__initdata_begin.

-- 
Catalin

