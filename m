Return-Path: <stable+bounces-114120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A69A2AC5F
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 16:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D70164C15
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 15:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968D11EDA19;
	Thu,  6 Feb 2025 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtJx5H6u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDF723642A;
	Thu,  6 Feb 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738855374; cv=none; b=J42IFMXH8L/raWKQZGzjk44bTm0bHxhGUUMBuu5ZBDMGwVLqmtbeiofji9LX0yAOcUn1pyT/AM212FM+4vUBRWLY23h59bfph7mhx62txzAMkhOcHGDwnYSVzcfFUdmiEDQeTF2Wx8FU7MwxtxJtTtGgmUilslQrNz+EReAwiiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738855374; c=relaxed/simple;
	bh=FrLHXacAKu7E8PIh7mv5/7UyuK0ZoDb/ggVEpXUiGJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsKJqLXz5dY2hc8TAXFzpWx9A02J1K3u/3Jx5MQlna4G5AQre8pRKcaA6/OAIDBDTGnZmT42tkENd5ab/h+Xdk64bedNXXoYyIKkRkJt3lEEsSa1cDO5fDMDHEk5iqeFiRrAMGm4V1NcSCXHqpkWrtELvYuj2OWXGXCT7ndIWRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtJx5H6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CB8C4CEDD;
	Thu,  6 Feb 2025 15:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738855371;
	bh=FrLHXacAKu7E8PIh7mv5/7UyuK0ZoDb/ggVEpXUiGJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GtJx5H6uD4arsQxYHReeieGtNLb5HEPaP+XikrDzrkEIEkr5tFKHPffQXcFzGR4wc
	 8RpS2oaekOqsSGsbQi906lQjVUomwO5uAB0h8gx72/aFNZ34DL9/Bvj7uB1u9NRN4d
	 oKxW/VFr56qRdgy+5FlwxFr7JnLgLwrFVX2TM8v3M3G4muu5uJXDly6tN/B4EVM6Nz
	 CK5gQCkbnEzr9KtIaHF/keibaJMTkX5azZZEiC6/xuTeh6fIrroFwX69zD8JF/I7mR
	 qE5diBGxt4zDD43aNOb2VpZUZO/+LJggzzk1T2TJjrkhbMGg7zwBYGY/zrY/6bCcKP
	 sXSlKD5XSKFLg==
Date: Thu, 6 Feb 2025 15:22:47 +0000
From: Will Deacon <will@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Handle .ARM.attributes section in linker
 scripts
Message-ID: <20250206152246.GA3468@willie-the-truck>
References: <20250204-arm64-handle-arm-attributes-in-linker-script-v2-1-d684097f5554@kernel.org>
 <20250206130526.GB3204@willie-the-truck>
 <20250206135715.GA180182@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206135715.GA180182@ax162>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 06, 2025 at 06:57:15AM -0700, Nathan Chancellor wrote:
> Hi Will,
> 
> On Thu, Feb 06, 2025 at 01:05:26PM +0000, Will Deacon wrote:
> > On Tue, Feb 04, 2025 at 10:48:55AM -0700, Nathan Chancellor wrote:
> > > A recent LLVM commit [1] started generating an .ARM.attributes section
> > > similar to the one that exists for 32-bit, which results in orphan
> > > section warnings (or errors if CONFIG_WERROR is enabled) from the linker
> > > because it is not handled in the arm64 linker scripts.
> > > 
> > >   ld.lld: error: arch/arm64/kernel/vdso/vgettimeofday.o:(.ARM.attributes) is being placed in '.ARM.attributes'
> > >   ld.lld: error: arch/arm64/kernel/vdso/vgetrandom.o:(.ARM.attributes) is being placed in '.ARM.attributes'
> > > 
> > >   ld.lld: error: vmlinux.a(lib/vsprintf.o):(.ARM.attributes) is being placed in '.ARM.attributes'
> > >   ld.lld: error: vmlinux.a(lib/win_minmax.o):(.ARM.attributes) is being placed in '.ARM.attributes'
> > >   ld.lld: error: vmlinux.a(lib/xarray.o):(.ARM.attributes) is being placed in '.ARM.attributes'
> > > 
> > > Discard the new sections in the necessary linker scripts to resolve the
> > > warnings, as the kernel and vDSO do not need to retain it, similar to
> > > the .note.gnu.property section.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: b3e5d80d0c48 ("arm64/build: Warn on orphan section placement")
> > > Link: https://github.com/llvm/llvm-project/commit/ee99c4d4845db66c4daa2373352133f4b237c942 [1]
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > ---
> > > Changes in v2:
> > > - Discard the section instead of adding it to the final artifacts to
> > >   mirror the .note.gnu.property section handling (Will).
> > 
> > Thanks for the v2. Just a minor nit:
> > 
> > > - Link to v1: https://lore.kernel.org/r/20250124-arm64-handle-arm-attributes-in-linker-script-v1-1-74135b6cf349@kernel.org
> > > ---
> > >  arch/arm64/kernel/vdso/vdso.lds.S | 1 +
> > >  arch/arm64/kernel/vmlinux.lds.S   | 1 +
> > >  2 files changed, 2 insertions(+)
> > > 
> > > diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
> > > index 4ec32e86a8da..8095fef66209 100644
> > > --- a/arch/arm64/kernel/vdso/vdso.lds.S
> > > +++ b/arch/arm64/kernel/vdso/vdso.lds.S
> > > @@ -80,6 +80,7 @@ SECTIONS
> > >  		*(.data .data.* .gnu.linkonce.d.* .sdata*)
> > >  		*(.bss .sbss .dynbss .dynsbss)
> > >  		*(.eh_frame .eh_frame_hdr)
> > > +		*(.ARM.attributes)
> > >  	}
> > 
> > Can we chuck this in the earlier /DISCARD/ section along with
> > .note.gnu.property? i.e.
> 
> Sure, I don't see why not. Do you want the comment above it updated to
> mention this section or should I leave it as is?

If you can think of something useful to add to the comment, don't let me
stop you!

Will

