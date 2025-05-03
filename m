Return-Path: <stable+bounces-139539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F021AAA80FF
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 16:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026D3189F62D
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 14:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF341E0DEB;
	Sat,  3 May 2025 14:11:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAE6279355;
	Sat,  3 May 2025 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746281502; cv=none; b=ShVqAF91FrieBcULQt/tMqm9dWBZA/mThjXKatjxYgLc+rHWWhzhSEPZUuLiJxPEoaGQXeOU8FerzeC5SC+owPnFIbWPlMS7GhK9Nz9Ac0LZwEZGQSW9SIEk8THxyHFBYrOHpSIF6IPZFUMzLUO6kIMOCrm2K9Ji69jnSEBNTEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746281502; c=relaxed/simple;
	bh=A1hVtL34fbY4wijPNoFNgAasOkpNfTbewe2S8PQvtDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNaopU//l/PU26H3c17K2zyV3BXLTWrbV0e1manYk0a9WRQup4RJGQLm5xN8RGsMtaXEV9dIMTtcQu4FMgV0JHqvgoMD0MFj7Z7PCSBZNXXMQA4tg7e3U1e0Sxn44pZU97WX9AwuycAc69ajhzJYyhuHtLs9ForKjKDT3lddLc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FD2C4CEE3;
	Sat,  3 May 2025 14:11:38 +0000 (UTC)
Date: Sat, 3 May 2025 15:11:36 +0100
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
Message-ID: <aBYkGJmfWDZHBEzp@arm.com>
References: <20250502180412.3774883-1-yeoreum.yun@arm.com>
 <174626735218.2189871.10298017577558632540.b4-ty@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174626735218.2189871.10298017577558632540.b4-ty@arm.com>

On Sat, May 03, 2025 at 11:16:12AM +0100, Catalin Marinas wrote:
> On Fri, 02 May 2025 19:04:12 +0100, Yeoreum Yun wrote:
> > create_init_idmap() could be called before .bss section initialization
> > which is done in early_map_kernel().
> > Therefore, data/test_prot could be set incorrectly by PTE_MAYBE_NG macro.
> > 
> > PTE_MAYBE_NG macro set NG bit according to value of "arm64_use_ng_mappings".
> > and this variable places in .bss section.
> > 
> > [...]
> 
> Applied to arm64 (for-next/fixes), with some slight tweaking of the
> comment, thanks!
> 
> [1/1] arm64/cpufeature: annotate arm64_use_ng_mappings with ro_after_init to prevent wrong idmap generation
>       https://git.kernel.org/arm64/c/12657bcd1835

I'm going to drop this for now. The kernel compiled with a clang 19.1.5
version I have around (Debian sid) fails to boot, gets stuck early on:

$ clang --version
Debian clang version 19.1.5 (1)
Target: aarch64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/lib/llvm-19/bin

I didn't have time to investigate, disassemble etc. I'll have a look
next week.

-- 
Catalin

