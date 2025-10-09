Return-Path: <stable+bounces-183702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2C0BC94E3
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 15:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441713AE708
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 13:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB133A1DB;
	Thu,  9 Oct 2025 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dk5Ibfxv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E345B22339;
	Thu,  9 Oct 2025 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760016681; cv=none; b=X8fUWDzwGuMpX2vsKX9PDO9AIrk8LAPwS1kqnE6FiqpP38O0TmBsAM5hkApZJYw6jCjbTOrbmmKQK3rXPf8G1fPg8EZK95h9/9HAXuLYLojwpC6MBAG0AmElnSEeQ18FCQodr1yMyGh6HlfitWM363jKBrwWkfyVcjvY4Mpbinw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760016681; c=relaxed/simple;
	bh=0IFvkQnMAy8Uc538u+cckdX0F9rDkpNjw/fh01Zt8cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wd0WwX4KN0ob8qy3SGs7wykif8RsD3vZGx5xc10Mr8IdNsfnJ9a1LhGXkldHARTUxf9aDfWd46fCMo0W9jtC6QZJolYYfNeJzUz/b+P87FhFmwJxY7qtFBc0ATOXTkaWqevhePEFIONNVHnC48JHM6ceBuxTqVmnEJ2wb07/BcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dk5Ibfxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2BFC4CEF8;
	Thu,  9 Oct 2025 13:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760016680;
	bh=0IFvkQnMAy8Uc538u+cckdX0F9rDkpNjw/fh01Zt8cQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dk5IbfxvMT7GhrRDbmHiSxM69xDcMSZxr5UkSf42vP3DoEHjiBN/eKM9RXAY1+ecg
	 FaV8VlAeUUiWUkhAcG7zMcIN3Vf/PGNALp/UapmU/jZgkcYMKod4dWaqoO9OneAVnL
	 X+NZdIvMFf/RjrN5k/+f4SikQ11rbcAx9ySt6Aio=
Date: Thu, 9 Oct 2025 15:31:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Inochi Amaoto <inochiama@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Meng Zhuo <mengzhuo@iscas.ac.cn>, Yangyu Chen <cyy@cyyself.name>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Guo Ren <guoren@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org, Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH 6.6.y 0/2] riscv: mm: Backport of mmap hint address fixes
Message-ID: <2025100931-carefully-exerciser-5d26@gregkh>
References: <20251008-riscv-mmap-addr-space-6-6-v1-0-9f47574a520f@iscas.ac.cn>
 <2025100812-raven-goes-4fd8@gregkh>
 <187fe5a3-99b9-49b6-be49-3d4f6f1fb16b@iscas.ac.cn>
 <2025100920-riverbank-congress-c7ee@gregkh>
 <87d603ce-578d-46a7-87b1-54befccc6fad@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d603ce-578d-46a7-87b1-54befccc6fad@iscas.ac.cn>

On Thu, Oct 09, 2025 at 01:50:11PM +0800, Vivian Wang wrote:
> 
> On 10/9/25 13:00, Greg KH wrote:
> > On Thu, Oct 09, 2025 at 12:19:46PM +0800, Vivian Wang wrote:
> >> [...]
> > Ok, that makes a bit more sense, but again, why is this just showing up
> > now?  What changed to cause this to be noticed at and needed to be fixed
> > at this moment in time and not before?
> 
> As of why this came quite late in the lifetime of the 6.6.y branch, I
> believe it's a combination of two factors.
> 
> Firstly, actual Sv48-capable RISC-V hardware came fairly late. Milk-V
> Megrez (with Eswin EIC7700X), on which the Go TSAN thing ran, was
> shipped only early this year. The DC ROMA II laptop (EIC7702X) and
> Framework mainboard with the same SoC has not even shipped yet, or maybe
> only shipped to developers - I'm not so certain. Most other RISC-V
> machines only have Sv39.
> 
> Secondly, there is interest among some Chinese software vendors to ship
> Linux distros based on a 6.6.y LTS kernel. The "RISC-V Common Kernel"
> (RVCK) project [1], with support from openEuler and various HW vendors,
> maintains backports on top of a 6.6.y kernel. "RockOS" [2] is a distro
> maintained by PLCT Lab, ISCAS, for EIC770{0,2}X-based boards, and it has
> a 6.6.y kernel branch. Both have cherry-picked the mmap patches for now.
> 
> We operate with the understanding that the official stable kernel will
> not be accepting new major features and drivers, but fixes do belong in
> stable, and at least from the perspective of PLCT Lab we generally try
> to send patches instead of hoarding them. Hence, the earlier backport
> request and this backport series.
> 
> I hope this explanation is acceptable.

Thanks for the detailed explaination.  I've queued these up now.

But wow, shipping new products on a 2 year old kernel feels very risky
to me, but hey, what do I know?  :)

> PS: This 6.6 kernel thing isn't just a RISC-V thing, by the way. KylinOS
> V11 has shipped in August with a 6.6 kernel. Deepin and UOS will be
> shipping with 6.6, with UOS "25" shipping maybe late this year or early
> 2026.

That too is crazy.  They should know better.

Just to give a bit of context for this, for the latest 6.6.y release,
6.6.110, there are currently over 300 documented unfixed CVE items in
that branch.  Feels rough to be doing a new release based on that...

good luck!

greg k-h

