Return-Path: <stable+bounces-114140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCC9A2AE3A
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44253A6AD2
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 16:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E7A232360;
	Thu,  6 Feb 2025 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4uA8B2s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0C123537E;
	Thu,  6 Feb 2025 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738860882; cv=none; b=pUCU2vf4K68EKcZqLlkO1J9ddpSga8FzuOGxhFrLVguKG5gm4kuFkWTAY8P4pQley6fYO+OLY8bjWWAQ1+o3iTq3X7KjhuZHnoZKxJEwKcpEOBu7cqkOyXTNa5w8YGFSATb26Y90GFbJeDR2TZlbbcj+TJELgSJqEkeP41bOydE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738860882; c=relaxed/simple;
	bh=PsZQ/79SdnZPsMKJdNhXcP5V1qKRUZBQqLW7woOhAqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlkVOshFvxXl8XIqlxLc7mLGqqhnFrq1uCQezbd0rR9EJa/kHESLDl340GXPQ6bhSFIcoJjP3CRXS8re0QK1jQxe8vKoMHsD0/WiU5YgPhBknt1qF2pSsbRjcsl067WKKfapUlvRWsP3AMYDYotFg7FJ2hpFWDIGLNPkxjtXWbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4uA8B2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89006C4CEDF;
	Thu,  6 Feb 2025 16:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738860881;
	bh=PsZQ/79SdnZPsMKJdNhXcP5V1qKRUZBQqLW7woOhAqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j4uA8B2s4R+u2Mcao02pmJN/jScM9pY9gXpm09oKZOdD796l6Xske3ij0fx5I4Gkv
	 K6JH237xMMGRqd48bLH06K74ejTHUkN5VAT4jtpvYy34z32TJctrtirqtNZjqEd2eu
	 vSSSXGk9w4V2GjB6i4FrPbYiLsxN/S32NxpZDUXsNpL5pVxM0CWmfJyviQoYTqirTI
	 TIYOeUBhfur4T9N5qR3EnsPvd+KNGz7n2Ec2Abx7TzdK5H4Grj293tiT6YjY4rezEA
	 +8vs03WpNPRsxGOdPUYvTJWSrMEeDhSW7KU2PwJVVCTgK0aUywTekvMtoPy6ltm2dO
	 OPoJd0ZoFmF0g==
Date: Thu, 6 Feb 2025 09:54:37 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Handle .ARM.attributes section in linker
 scripts
Message-ID: <20250206165437.GD180182@ax162>
References: <20250204-arm64-handle-arm-attributes-in-linker-script-v2-1-d684097f5554@kernel.org>
 <20250206130526.GB3204@willie-the-truck>
 <20250206135715.GA180182@ax162>
 <20250206152246.GA3468@willie-the-truck>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206152246.GA3468@willie-the-truck>

On Thu, Feb 06, 2025 at 03:22:47PM +0000, Will Deacon wrote:
> On Thu, Feb 06, 2025 at 06:57:15AM -0700, Nathan Chancellor wrote:
> > Hi Will,
> > 
> > On Thu, Feb 06, 2025 at 01:05:26PM +0000, Will Deacon wrote:
> > > On Tue, Feb 04, 2025 at 10:48:55AM -0700, Nathan Chancellor wrote:
> > > > A recent LLVM commit [1] started generating an .ARM.attributes section
> > > > similar to the one that exists for 32-bit, which results in orphan
> > > > section warnings (or errors if CONFIG_WERROR is enabled) from the linker
> > > > because it is not handled in the arm64 linker scripts.
> > > > 
> > > >   ld.lld: error: arch/arm64/kernel/vdso/vgettimeofday.o:(.ARM.attributes) is being placed in '.ARM.attributes'
> > > >   ld.lld: error: arch/arm64/kernel/vdso/vgetrandom.o:(.ARM.attributes) is being placed in '.ARM.attributes'
> > > > 
> > > >   ld.lld: error: vmlinux.a(lib/vsprintf.o):(.ARM.attributes) is being placed in '.ARM.attributes'
> > > >   ld.lld: error: vmlinux.a(lib/win_minmax.o):(.ARM.attributes) is being placed in '.ARM.attributes'
> > > >   ld.lld: error: vmlinux.a(lib/xarray.o):(.ARM.attributes) is being placed in '.ARM.attributes'
> > > > 
> > > > Discard the new sections in the necessary linker scripts to resolve the
> > > > warnings, as the kernel and vDSO do not need to retain it, similar to
> > > > the .note.gnu.property section.
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: b3e5d80d0c48 ("arm64/build: Warn on orphan section placement")
> > > > Link: https://github.com/llvm/llvm-project/commit/ee99c4d4845db66c4daa2373352133f4b237c942 [1]
> > > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > > ---
> > > > Changes in v2:
> > > > - Discard the section instead of adding it to the final artifacts to
> > > >   mirror the .note.gnu.property section handling (Will).
> > > 
> > > Thanks for the v2. Just a minor nit:
> > > 
> > > > - Link to v1: https://lore.kernel.org/r/20250124-arm64-handle-arm-attributes-in-linker-script-v1-1-74135b6cf349@kernel.org
> > > > ---
> > > >  arch/arm64/kernel/vdso/vdso.lds.S | 1 +
> > > >  arch/arm64/kernel/vmlinux.lds.S   | 1 +
> > > >  2 files changed, 2 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
> > > > index 4ec32e86a8da..8095fef66209 100644
> > > > --- a/arch/arm64/kernel/vdso/vdso.lds.S
> > > > +++ b/arch/arm64/kernel/vdso/vdso.lds.S
> > > > @@ -80,6 +80,7 @@ SECTIONS
> > > >  		*(.data .data.* .gnu.linkonce.d.* .sdata*)
> > > >  		*(.bss .sbss .dynbss .dynsbss)
> > > >  		*(.eh_frame .eh_frame_hdr)
> > > > +		*(.ARM.attributes)
> > > >  	}
> > > 
> > > Can we chuck this in the earlier /DISCARD/ section along with
> > > .note.gnu.property? i.e.
> > 
> > Sure, I don't see why not. Do you want the comment above it updated to
> > mention this section or should I leave it as is?
> 
> If you can think of something useful to add to the comment, don't let me
> stop you!

Eh, I could not come up with much so I will leave it as is. v3 incoming
shortly.

Cheers,
Nathan

