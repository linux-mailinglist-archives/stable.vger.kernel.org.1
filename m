Return-Path: <stable+bounces-183658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88994BC7651
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 07:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6273E189CB01
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 05:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D84C157487;
	Thu,  9 Oct 2025 05:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MLYUAy1q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245A71426C;
	Thu,  9 Oct 2025 05:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759986050; cv=none; b=SGbDz58x3HDqY/V+JyDxqQtL9vJS1qWM50hAFVXg+okZRGIVMOIuJaOAHFsvc0m0IFAUOFIXHVmKaZdYLvzf8imGGUrceUwfNRVjLT6uk2x0iS2FCMDdq9xj+zG/Qybkcbl9gQnZNGcTSI8gst2blS0MyAKI5/pnoq2a2nOibqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759986050; c=relaxed/simple;
	bh=uM3x9ifdbeSCRTPz6Z1yuQ6p99Wfh//1kqt2rykLfTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3vNJHgf/l9ilr4sz1ews1OApG0A2klqefHoWKTJK5Uu0YIGfKGjqgIROITiYKk712Kg5pNjkJp98/qvUduOYbM3XDSF97/FbB8D93SlhzGW/VidB5Yqb4d+HWiVmF8aH58I92k75eoUSMkywctItTRrkd9+nAP3sS1ITnBFYwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MLYUAy1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1356BC4CEE7;
	Thu,  9 Oct 2025 05:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759986049;
	bh=uM3x9ifdbeSCRTPz6Z1yuQ6p99Wfh//1kqt2rykLfTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MLYUAy1qaDvimbkU8zp/wLU5+DeClg5nTcZ+dJQcbewZIbyH7eD+j+QJ6sfzO3jdW
	 GYU1uhhcUcd+ehiqxvcabuPlWVrEh3zundBsH3ox0zlllO/i6IRb/RBXsTUEwBORvk
	 sUiaddxl1xt9jrTMnqoAW88X1nYVBUQZzcUB4AYA=
Date: Thu, 9 Oct 2025 07:00:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: stable@vger.kernel.org, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guo Ren <guoren@kernel.org>, Charlie Jenkins <charlie@rivosinc.com>,
	Yangyu Chen <cyy@cyyself.name>, Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>, Inochi Amaoto <inochiama@gmail.com>,
	Yao Zi <ziyao@disroot.org>, Palmer Dabbelt <palmer@rivosinc.com>,
	Meng Zhuo <mengzhuo@iscas.ac.cn>
Subject: Re: [PATCH 6.6.y 0/2] riscv: mm: Backport of mmap hint address fixes
Message-ID: <2025100920-riverbank-congress-c7ee@gregkh>
References: <20251008-riscv-mmap-addr-space-6-6-v1-0-9f47574a520f@iscas.ac.cn>
 <2025100812-raven-goes-4fd8@gregkh>
 <187fe5a3-99b9-49b6-be49-3d4f6f1fb16b@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <187fe5a3-99b9-49b6-be49-3d4f6f1fb16b@iscas.ac.cn>

On Thu, Oct 09, 2025 at 12:19:46PM +0800, Vivian Wang wrote:
> 
> On 10/8/25 18:20, Greg KH wrote:
> > On Wed, Oct 08, 2025 at 03:50:15PM +0800, Vivian Wang wrote:
> >> Backport of the two riscv mmap patches from master. In effect, these two
> >> patches removes arch_get_mmap_{base,end} for riscv.
> > Why is this needed?  What bug does this fix?
> 
> The behavior of mmap hint address in current 6.6.y is broken when > 39
> bits of virtual address is available (i.e. Sv48 or Sv57, having 48 and
> 57 bits of VA available, respectively). The man-pages mmap(2) page
> states, for the hint address [1]:
> 
>        If addr is NULL, then the kernel chooses the (page-aligned)
>        address at which to create the mapping; this is the most portable
>        method of creating a new mapping.  If addr is not NULL, then the
>        kernel takes it as a hint about where to place the mapping; on
>        Linux, the kernel will pick a nearby page boundary (but always
>        above or equal to the value specified by
>        /proc/sys/vm/mmap_min_addr) and attempt to create the mapping
>        there.  If another mapping already exists there, the kernel picks
>        a new address that may or may not depend on the hint.  The address
>        of the new mapping is returned as the result of the call.
> 
> Therefore, if a userspace program specifies a large hint address of e.g.
> 1<<50, and both the kernel and the hardware supports it, it should be
> used even if MAP_FIXED is not specified. This is also the behavior
> implemented in x86_64, arm64, and, on a recent enough (> 6.10) kernel,
> riscv64.
> 
> However, current 6.6.y for riscv64 implements a bizarre behavior, where
> the hint address is treated as an upper bound instead. Therefore,
> passing 1<<50 would actually return a VA in 48-bit space.
> 
> To reproduce, call mmap with arguments like:
> 
>        mmap(hint, 4096, PROT_READ, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
> 
> Comparison:
> 
>         hint = 0x4000000000000 i.e. 1 << 50
> 
>                     6.6.106             6.6.106 + patch
>             sv48    0x7fff90223000      0x7fff93b4e000
>             sv57    0x7fffb7d49000      0x4000000000000
> 
> When the hint is not used, the exact address is of course random, which
> is expected. However, since the address 1<<50 is supported under Sv57,
> it should be usable by mmap, but with current 6.6.y behavior it is not
> used, and some other address from 48-bit space used instead.
> 
> There's not yet real riscv64 hardware with Sv57, but an analogous
> problem arises on Sv48 with an address like 1<<40.

As this issue has been fixed for many years now, why is it just showing
up now?  Shouldn't you be using 6.12.y for new hardware?

> One real userspace program that runs into this is the Go programming
> language runtime with TSAN enabled. Excerpt from a test log [2], which
> was run on an Eswin EIC7700x, which supports Sv48:
> 
> fatal error: too many address space collisions for -race mode
> runtime stack:
> runtime.throw({0x257eaa?, 0x4000000?})
>     /home/swarming/.swarming/w/ir/x/w/goroot/src/runtime/panic.go:1246 +0x38 fp=0x7ffff84af758 sp=0x7ffff84af730 pc=0xc9310
> runtime.(*mheap).sysAlloc(0x3e3c20, 0x81cc8?, 0x3f3e28, 0x3f3e50)
>     /home/swarming/.swarming/w/ir/x/w/goroot/src/runtime/malloc.go:799 +0x56c fp=0x7ffff84af7f8 sp=0x7ffff84af758 pc=0x67944
> runtime.(*mheap).grow(0x3e3c20, 0x7fffb69fee00?)
>     /home/swarming/.swarming/w/ir/x/w/goroot/src/runtime/mheap.go:1568 +0x9c fp=0x7ffff84af870 sp=0x7ffff84af7f8 pc=0x824c4
> runtime.(*mheap).allocSpan(0x3e3c20, 0x1, 0x0, 0x10)
> [...]
> FAIL    runtime/race    0.285s
> 
> With TSAN enabled, the Go runtime allocates a lot of virtual address
> space. As the message suggests, if the return value of mmap is not equal
> to a non-zero hint, the runtime assumes that mmap is failing to allocate
> the address because some other mapping is already there (in other words,
> it assumes the man-pages documented behavior), and unmaps it and tries a
> different address, until it tries too many times and gives up. This
> means Go with TSAN fails to initialize on Sv48 and current 6.6.y.
> 
> (cc Meng Zhuo, in case of any questions about the Go runtime here.)
> 
> Patch 1 here addresses the above issue, but introduced regressions (see
> replies in "Link"). Patch 2 addresses those regressions.

Ok, that makes a bit more sense, but again, why is this just showing up
now?  What changed to cause this to be noticed at and needed to be fixed
at this moment in time and not before?

thanks,

greg k-h

