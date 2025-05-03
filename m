Return-Path: <stable+bounces-139531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 144E4AA7FD5
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 12:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFEF61B6378C
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 10:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069331DB92C;
	Sat,  3 May 2025 10:06:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E641D5ADC;
	Sat,  3 May 2025 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746266770; cv=none; b=sNkNu+DT1CwN5uSSzrW9VrATEoknIT37i4dmFCcU58Hm0Iv+KP3Mog2DFKisu+N/6LCtvispnpkRxUrV6wDJbhJtiP3ZzK6Au++VogQ85AmMqRZQfVEOI0vGqdZmI0ASzFr91roQzVAE0ldSycsyBiMQBRgjkn714nZNwG39IyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746266770; c=relaxed/simple;
	bh=7/cQZqkxkHiOalA49M4Elh0cibV7uEPqheQC1nTN8Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhrMxqD6CPEkWpg8Ne9AHA/CwOC5Ss7RtsBbH6msHeAGoqw8fb9cJVrsHAnXK0uaig6dfVMh5jNRmD0082PW+N4vM+G59ez5Uth6KqMDboF98t5eiewUZSsbMmbTScJVRvWSZQlYsBzkjQ/+edtbl+ys2XHew8Niss0g3hcfD88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046B7C4CEE3;
	Sat,  3 May 2025 10:06:05 +0000 (UTC)
Date: Sat, 3 May 2025 11:06:03 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, will@kernel.org, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, broonie@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, frederic@kernel.org, joey.gouly@arm.com,
	james.morse@arm.com, hardevsinh.palaniya@siliconsignals.io,
	shameerali.kolothum.thodi@huawei.com, ryan.roberts@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] arm64/cpufeature: annotate arm64_use_ng_mappings with
 ro_after_init to prevent wrong idmap generation
Message-ID: <aBXqi4XpCsN3otHe@arm.com>
References: <20250502145755.3751405-1-yeoreum.yun@arm.com>
 <CAMj1kXEoYcS6YPU0mBdvijDRK6ZVB7mPYZsCVpz7sYotabrxtQ@mail.gmail.com>
 <aBUHlGvZuI2O0bbs@arm.com>
 <aBULdGn+klwp8CEu@e129823.arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBULdGn+klwp8CEu@e129823.arm.com>

On Fri, May 02, 2025 at 07:14:12PM +0100, Yeoreum Yun wrote:
> > On Fri, May 02, 2025 at 06:41:33PM +0200, Ard Biesheuvel wrote:
> > > Making arm64_use_ng_mappings __ro_after_init seems like a useful
> > > change by itself, so I am not objecting to that. But we don't solve it
> > > more fundamentally, please at least add a big fat comment why it is
> > > important that the variable remains there.
> >
> > Maybe something like the section reference checker we use for __init -
> > verify that the early C code does not refer anything in the BSS section.
> 
> Maybe but it would be better to be checked at compile time (I don't
> know it's possible) otherwise, early C code writer should check
> mandatroy by calling is_kernel_bss_data() (not exist) for data it refers.

This would be compile time (or rather final link time). See
scripts/mod/modpost.c (the sectioncheck[] array) on how we check if, for
example, a .text section references a .init one. We could move the whole
pi code to its own section (e.g. .init.nommu.*) and add modpost checks
for references to the bss or other sections.

-- 
Catalin

