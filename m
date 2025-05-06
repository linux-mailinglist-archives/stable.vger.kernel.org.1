Return-Path: <stable+bounces-141794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6CAAAC1B7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 12:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6E7466287
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 10:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78F2277817;
	Tue,  6 May 2025 10:49:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7300926F44A;
	Tue,  6 May 2025 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746528562; cv=none; b=ajHkNxKKYMoQUeoI1z6hLCcuBVFWlE5HJVts6A+281a4UC2Ypq6vyNX3i5ctDha8PTzamIdlrS1ELdVYVOKsoRvEdCMPhWXLTfaXUPfthA6YzVA+0DUFRDRDgyjlG6/O7qu5ZM0pb1PkqGgmyfl1JyP0mtPV+I7vZ7Um8Qk0OHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746528562; c=relaxed/simple;
	bh=i/2SmmVnlcXxdTtT1qlh2r7XsSzfJAJlqxFG5dCELWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9d0Wr748LuFrOpn9hcsH8eFmwcpcn+Dix2ElKf3Lkz1UYTtqt0c0+lJ2MrxsTvfAypWnQcqPyY6T6GGAkEs0Jo5tgEusSn4t7KZgSN/8k+PCS4ZKjJ1/JJuYlXgvw1bMIjiPRkfC0Va0ejWagxyrWEEOJOoRqzsPAsSUlnjiJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06F1C4CEE4;
	Tue,  6 May 2025 10:49:18 +0000 (UTC)
Date: Tue, 6 May 2025 11:49:16 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com, broonie@kernel.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	shameerali.kolothum.thodi@huawei.com, james.morse@arm.com,
	hardevsinh.palaniya@siliconsignals.io, ardb@kernel.org,
	ryan.roberts@arm.com, Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/cpufeature: annotate arm64_use_ng_mappings with
 ro_after_init to prevent wrong idmap generation
Message-ID: <aBnpLP1b4Wl3krg8@arm.com>
References: <20250502180412.3774883-1-yeoreum.yun@arm.com>
 <174626735218.2189871.10298017577558632540.b4-ty@arm.com>
 <aBYkGJmfWDZHBEzp@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBYkGJmfWDZHBEzp@arm.com>

On Sat, May 03, 2025 at 03:11:36PM +0100, Catalin Marinas wrote:
> On Sat, May 03, 2025 at 11:16:12AM +0100, Catalin Marinas wrote:
> > On Fri, 02 May 2025 19:04:12 +0100, Yeoreum Yun wrote:
> > > create_init_idmap() could be called before .bss section initialization
> > > which is done in early_map_kernel().
> > > Therefore, data/test_prot could be set incorrectly by PTE_MAYBE_NG macro.
> > > 
> > > PTE_MAYBE_NG macro set NG bit according to value of "arm64_use_ng_mappings".
> > > and this variable places in .bss section.
> > > 
> > > [...]
> > 
> > Applied to arm64 (for-next/fixes), with some slight tweaking of the
> > comment, thanks!
> > 
> > [1/1] arm64/cpufeature: annotate arm64_use_ng_mappings with ro_after_init to prevent wrong idmap generation
> >       https://git.kernel.org/arm64/c/12657bcd1835
> 
> I'm going to drop this for now. The kernel compiled with a clang 19.1.5
> version I have around (Debian sid) fails to boot, gets stuck early on:
> 
> $ clang --version
> Debian clang version 19.1.5 (1)
> Target: aarch64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /usr/lib/llvm-19/bin

I reinstated the patch with __read_mostly and some rewriting of the
commit message (I left out the gcc code generation, it's just luck that
we have not hit it before). That's the new commit on the arm64
for-next/fixes branch:

[1/1] arm64: cpufeature: Move arm64_use_ng_mappings to the .data section to prevent wrong idmap generation
      https://git.kernel.org/arm64/c/363cd2b81cfd

I kept the original tested-by from Nathan, I reckon the patch still
works ;).

Thanks.

-- 
Catalin

