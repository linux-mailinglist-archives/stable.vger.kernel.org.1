Return-Path: <stable+bounces-114087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 392DEA2A903
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 14:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484D51887EAD
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 13:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00D722E3EC;
	Thu,  6 Feb 2025 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="reHjMAq+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C1322DFB3;
	Thu,  6 Feb 2025 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847131; cv=none; b=L241c31lRAVcodkrqj6GaTSBrhA/sI3PweoNPBKeNUe5kZgihxYZWqeTOfABOJ6rldUgO52wM8V+0Iga5b+pRngPJp7GtjNpE4uQKOQXEJdYBxyiLbUk0kmyAVzeDh5W/pz2IqI158EwwN3E5gOgzccbwSIZzVrBkaqNRIPPIAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847131; c=relaxed/simple;
	bh=rE1sy+FfaAGMIzwM8EZBoJ3Dv8Fmfq/jdRSMzL/N0zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLK+cF0u9qX33vg9xtrB/mUcEH1iIcuzGACyYc0fGX2pk5GkYZqmJhyhkPmuJNEsHtYoFL4ZReO3l6iwwqw795hqsgHuspk91EKFdqzSRI3L7WZYKLkTQ4KJ3NHooeHkLTvvdrlzYACF+qxl+9IJKM5WXs2SjeARb7/6WC/jYnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=reHjMAq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423A4C4CEDD;
	Thu,  6 Feb 2025 13:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738847131;
	bh=rE1sy+FfaAGMIzwM8EZBoJ3Dv8Fmfq/jdRSMzL/N0zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=reHjMAq+muONPXIODduR0Z1IFIXihk/zEBurSpK6NU3cj6eHgP8XSkMWe8cgq16nn
	 2Eq9+Msb4OXBJeQBkgf+VIOZvprx3ykRrLqbhaEO5ZCa3VBDfm9H3ln+I8jlviwYml
	 L1q4qEZ5g4wo754Htix+d5qrmMaDXkxnW/DLpg3/Q0nhE9lpD1KWqjngA2k6+JghHR
	 kT1Tf6v2RRSWQjphLkxr2B6m5IpfUeKhG/wy+SOzOlXYIv8pfQGOt4jMgWxx5qM3ps
	 9H7D98c322tzHKBc32/i4H11zTyWs0Kj6tcQrED0+JvYrlRK71DoP05bz/dxEEqesn
	 Bz58iDr4nW08A==
Date: Thu, 6 Feb 2025 13:05:26 +0000
From: Will Deacon <will@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Handle .ARM.attributes section in linker
 scripts
Message-ID: <20250206130526.GB3204@willie-the-truck>
References: <20250204-arm64-handle-arm-attributes-in-linker-script-v2-1-d684097f5554@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204-arm64-handle-arm-attributes-in-linker-script-v2-1-d684097f5554@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Nathan,

On Tue, Feb 04, 2025 at 10:48:55AM -0700, Nathan Chancellor wrote:
> A recent LLVM commit [1] started generating an .ARM.attributes section
> similar to the one that exists for 32-bit, which results in orphan
> section warnings (or errors if CONFIG_WERROR is enabled) from the linker
> because it is not handled in the arm64 linker scripts.
> 
>   ld.lld: error: arch/arm64/kernel/vdso/vgettimeofday.o:(.ARM.attributes) is being placed in '.ARM.attributes'
>   ld.lld: error: arch/arm64/kernel/vdso/vgetrandom.o:(.ARM.attributes) is being placed in '.ARM.attributes'
> 
>   ld.lld: error: vmlinux.a(lib/vsprintf.o):(.ARM.attributes) is being placed in '.ARM.attributes'
>   ld.lld: error: vmlinux.a(lib/win_minmax.o):(.ARM.attributes) is being placed in '.ARM.attributes'
>   ld.lld: error: vmlinux.a(lib/xarray.o):(.ARM.attributes) is being placed in '.ARM.attributes'
> 
> Discard the new sections in the necessary linker scripts to resolve the
> warnings, as the kernel and vDSO do not need to retain it, similar to
> the .note.gnu.property section.
> 
> Cc: stable@vger.kernel.org
> Fixes: b3e5d80d0c48 ("arm64/build: Warn on orphan section placement")
> Link: https://github.com/llvm/llvm-project/commit/ee99c4d4845db66c4daa2373352133f4b237c942 [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Changes in v2:
> - Discard the section instead of adding it to the final artifacts to
>   mirror the .note.gnu.property section handling (Will).

Thanks for the v2. Just a minor nit:

> - Link to v1: https://lore.kernel.org/r/20250124-arm64-handle-arm-attributes-in-linker-script-v1-1-74135b6cf349@kernel.org
> ---
>  arch/arm64/kernel/vdso/vdso.lds.S | 1 +
>  arch/arm64/kernel/vmlinux.lds.S   | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
> index 4ec32e86a8da..8095fef66209 100644
> --- a/arch/arm64/kernel/vdso/vdso.lds.S
> +++ b/arch/arm64/kernel/vdso/vdso.lds.S
> @@ -80,6 +80,7 @@ SECTIONS
>  		*(.data .data.* .gnu.linkonce.d.* .sdata*)
>  		*(.bss .sbss .dynbss .dynsbss)
>  		*(.eh_frame .eh_frame_hdr)
> +		*(.ARM.attributes)
>  	}

Can we chuck this in the earlier /DISCARD/ section along with
.note.gnu.property? i.e.


diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index 4ec32e86a8da..47ad6944f9f0 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -41,6 +41,7 @@ SECTIONS
         */
        /DISCARD/       : {
                *(.note.GNU-stack .note.gnu.property)
+               *(.ARM.attributes)
        }
        .note           : { *(.note.*) }                :text   :note


Will

