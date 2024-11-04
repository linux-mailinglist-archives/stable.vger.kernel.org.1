Return-Path: <stable+bounces-89758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216E49BC01B
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 22:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E192828B8
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 21:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BA01C304A;
	Mon,  4 Nov 2024 21:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twwhuzn5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDA219BBA;
	Mon,  4 Nov 2024 21:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755949; cv=none; b=kn9sWEzbaQFJlvJ4tJMI6oZuMKqHElXUgnxKkpFx+ihwroONJGv97j6DENiVA0YM/qKETSbP0qxZRRd0khy2xXfxkqomd1loLOHSyhRTOVagZuFjNPLbHjuhqgtVmhKruM/jQXiJXCHg50Gv+oSgIeMLeSlrOBWnBr0jyJRsH+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755949; c=relaxed/simple;
	bh=CaSTjw7VNvlfbt9T9gHr6/MklZUOZLnkk9iGT2oFZ/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzNHOp33ccGI8UhT4V2Ra7XhhA6RhVhitqubFROS7g4qHzBdXXVve5tQmWC5cFyfJDBKK+MrD10yyQW6E8BJ4zfZGaJmPmrxnBbL+nynBFf6UrrxmZMP2qKVh/+TFjlzRBjq4smCu0Xlo23TO5yXUIHo40QBRXwoBmpWdwjWGAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twwhuzn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AC7C4CECE;
	Mon,  4 Nov 2024 21:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730755948;
	bh=CaSTjw7VNvlfbt9T9gHr6/MklZUOZLnkk9iGT2oFZ/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=twwhuzn5BrsZwg+6BbEdbLr9N8OJAW8FsBiOV4strufGFZQHdzJIF4VvR+dMdXGwT
	 dqz7T+cwthLwstzQp864guC1Qti9lqurImzFpEFZtDdPCNHNFKp2Y7kwgoN5kz+0Z3
	 d6qHkinr4Q9fgOBVY5ugxDt9eEadLQTMf3lYvdDwNc3adk7VxQhab1ac5a3QmaCm50
	 I4SbIoRap6S5m2SIzsFnLv49m5HJ6QE7vzWhZ4pD6gg5OGTD5n8hHi+yqz4BTuPvoT
	 Mc1QhVyQhsyVuuUJqZg5Jy+JXAwSzqwlhbd2mbS2FGacJV208Uj1j3kzNbVTwcqbwr
	 0iMslghptqeyQ==
Date: Mon, 4 Nov 2024 13:32:25 -0800
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Koichiro Den <koichiro.den@gmail.com>, cl@linux.com, penberg@kernel.org,
	rientjes@google.com, iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org, roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: fix warning caused by duplicate kmem_cache
 creation in kmem_buckets_create
Message-ID: <202411041330.7A0F716E5@keescook>
References: <20241104150837.2756047-1-koichiro.den@gmail.com>
 <9e6fd342-ef7f-4648-afa3-bf704c87bf8f@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e6fd342-ef7f-4648-afa3-bf704c87bf8f@suse.cz>

On Mon, Nov 04, 2024 at 04:40:12PM +0100, Vlastimil Babka wrote:
> On 11/4/24 16:08, Koichiro Den wrote:
> > Commit b035f5a6d852 ("mm: slab: reduce the kmalloc() minimum alignment
> > if DMA bouncing possible") reduced ARCH_KMALLOC_MINALIGN to 8 on arm64.
> > However, with KASAN_HW_TAGS enabled, arch_slab_minalign() becomes 16.
> > This causes kmalloc_caches[*][8] to be aliased to kmalloc_caches[*][16],
> > resulting in kmem_buckets_create() attempting to create a kmem_cache for
> > size 16 twice. This duplication triggers warnings on boot:
> > 
> > [    2.325108] ------------[ cut here ]------------
> > [    2.325135] kmem_cache of name 'memdup_user-16' already exists
> > [    2.325783] WARNING: CPU: 0 PID: 1 at mm/slab_common.c:107 __kmem_cache_create_args+0xb8/0x3b0
> > [    2.327957] Modules linked in:
> > [    2.328550] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc5mm-unstable-arm64+ #12
> > [    2.328683] Hardware name: QEMU QEMU Virtual Machine, BIOS 2024.02-2 03/11/2024
> > [    2.328790] pstate: 61000009 (nZCv daif -PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> > [    2.328911] pc : __kmem_cache_create_args+0xb8/0x3b0
> > [    2.328930] lr : __kmem_cache_create_args+0xb8/0x3b0
> > [    2.328942] sp : ffff800083d6fc50
> > [    2.328961] x29: ffff800083d6fc50 x28: f2ff0000c1674410 x27: ffff8000820b0598
> > [    2.329061] x26: 000000007fffffff x25: 0000000000000010 x24: 0000000000002000
> > [    2.329101] x23: ffff800083d6fce8 x22: ffff8000832222e8 x21: ffff800083222388
> > [    2.329118] x20: f2ff0000c1674410 x19: f5ff0000c16364c0 x18: ffff800083d80030
> > [    2.329135] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > [    2.329152] x14: 0000000000000000 x13: 0a73747369786520 x12: 79646165726c6120
> > [    2.329169] x11: 656820747563205b x10: 2d2d2d2d2d2d2d2d x9 : 0000000000000000
> > [    2.329194] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> > [    2.329210] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> > [    2.329226] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> > [    2.329291] Call trace:
> > [    2.329407]  __kmem_cache_create_args+0xb8/0x3b0
> > [    2.329499]  kmem_buckets_create+0xfc/0x320
> > [    2.329526]  init_user_buckets+0x34/0x78
> > [    2.329540]  do_one_initcall+0x64/0x3c8
> > [    2.329550]  kernel_init_freeable+0x26c/0x578
> > [    2.329562]  kernel_init+0x3c/0x258
> > [    2.329574]  ret_from_fork+0x10/0x20
> > [    2.329698] ---[ end trace 0000000000000000 ]---
> > 
> > [    2.403704] ------------[ cut here ]------------
> > [    2.404716] kmem_cache of name 'msg_msg-16' already exists
> > [    2.404801] WARNING: CPU: 2 PID: 1 at mm/slab_common.c:107 __kmem_cache_create_args+0xb8/0x3b0
> > [    2.404842] Modules linked in:
> > [    2.404971] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.12.0-rc5mm-unstable-arm64+ #12
> > [    2.405026] Tainted: [W]=WARN
> > [    2.405043] Hardware name: QEMU QEMU Virtual Machine, BIOS 2024.02-2 03/11/2024
> > [    2.405057] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    2.405079] pc : __kmem_cache_create_args+0xb8/0x3b0
> > [    2.405100] lr : __kmem_cache_create_args+0xb8/0x3b0
> > [    2.405111] sp : ffff800083d6fc50
> > [    2.405115] x29: ffff800083d6fc50 x28: fbff0000c1674410 x27: ffff8000820b0598
> > [    2.405135] x26: 000000000000ffd0 x25: 0000000000000010 x24: 0000000000006000
> > [    2.405153] x23: ffff800083d6fce8 x22: ffff8000832222e8 x21: ffff800083222388
> > [    2.405169] x20: fbff0000c1674410 x19: fdff0000c163d6c0 x18: ffff800083d80030
> > [    2.405185] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > [    2.405201] x14: 0000000000000000 x13: 0a73747369786520 x12: 79646165726c6120
> > [    2.405217] x11: 656820747563205b x10: 2d2d2d2d2d2d2d2d x9 : 0000000000000000
> > [    2.405233] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> > [    2.405248] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> > [    2.405271] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> > [    2.405287] Call trace:
> > [    2.405293]  __kmem_cache_create_args+0xb8/0x3b0
> > [    2.405305]  kmem_buckets_create+0xfc/0x320
> > [    2.405315]  init_msg_buckets+0x34/0x78
> > [    2.405326]  do_one_initcall+0x64/0x3c8
> > [    2.405337]  kernel_init_freeable+0x26c/0x578
> > [    2.405348]  kernel_init+0x3c/0x258
> > [    2.405360]  ret_from_fork+0x10/0x20
> > [    2.405370] ---[ end trace 0000000000000000 ]---
> > 
> > To address this, alias kmem_cache for sizes smaller than min alignment
> > to the aligned sized kmem_cache, as done with the default system kmalloc
> > bucket.
> > 
> > Cc: <stable@vger.kernel.org> # 6.11.x
> > Fixes: b32801d1255b ("mm/slab: Introduce kmem_buckets_create() and family")
> > Signed-off-by: Koichiro Den <koichiro.den@gmail.com>
> > ---
> 
> Thanks for catching this.
> Wonder if we could make this a lot simpler in kmem_buckets_create() by
> starting with the current:
> 
> size = kmalloc_caches[KMALLOC_NORMAL][idx]->object_size;
> 
> and adding:
> 
> aligned_idx = __kmalloc_index(size, false);
> 
> now the rest of the loop iteration would work with aligned_idx and if it
> differs from idx, we assign the cache pointer also to idx, etc.
> 
> This should avoid duplicating the alignment calculation as we just extract
> from kmalloc_caches[] the result of what new_kmalloc_cache() already did?

Yeah, I was thinking similar stuff -- the aligned stuff is the alias for
the actual stuff.

I like the bitmask for tracking the aliases. :)

-- 
Kees Cook

