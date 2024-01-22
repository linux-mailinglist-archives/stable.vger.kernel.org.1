Return-Path: <stable+bounces-12706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A5C836E03
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 18:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2B61F23C4A
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 17:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FE73C693;
	Mon, 22 Jan 2024 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ooq4tuHe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC762482D0
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943104; cv=none; b=ffsdL7EvBNLY1Nx5hkoHPhwbw+Mi/5hfvbYwjmWY6s0AXEqmI9/MOBJIS+g2OHkGf7AsyPE9pRi3IdI0i93nVYqBhDBnJe4rHZMWXoH3imx32pNVc2A1TP7DGZO4MpwZUK3D5s0OTPS+6VrK1vN/c1ynaY8ckRy4TZ1lkNd0z/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943104; c=relaxed/simple;
	bh=gcbcJqzmSRkZvR0q2df+ImBQFZJMXaAkucZROAJ38k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqsZ0aJ6e88LmUZaWjzFqQNfkFQmCttNQfINu3QhFgd+73LjqamaYuDK9cTYO+NUhOqPvFcSVl8bJzcpwcT5ysf8Obruo0Y6Q0wP9NczTu51pcHLxRl7oQjPxadzINsOHu1/QDQpeAojJDpEKRHkQUyjMW7Nc7uDmiz/zO3dwFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ooq4tuHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D91C433C7;
	Mon, 22 Jan 2024 17:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705943104;
	bh=gcbcJqzmSRkZvR0q2df+ImBQFZJMXaAkucZROAJ38k0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ooq4tuHeC9AvGkeBkrr3IkfJtyEw83G1q3SNkMFjtoJI4VcCORCP0M9bNXuupRucC
	 hvImplKTqqpr4zGX40jnnM/fN9h8s4qNRgj5EjBDoD4UAOt99eCTpsNM4MFap9GJ4+
	 17zQZ6YcjA+golf6XJjOO+rIHHDWl08O5pQnqH2g=
Date: Mon, 22 Jan 2024 09:05:00 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: stable@vger.kernel.org, Liam Howlett <liam.howlett@oracle.com>,
	Minchan Kim <minchan@kernel.org>, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH 5.10.y v2] binder: fix use-after-free in shinker's
 callback
Message-ID: <2024012246-clumsy-agreeing-6032@gregkh>
References: <20240118215119.1040432-1-cmllamas@google.com>
 <20240122165603.2107402-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122165603.2107402-1-cmllamas@google.com>

On Mon, Jan 22, 2024 at 04:56:02PM +0000, Carlos Llamas wrote:
> commit 3f489c2067c5824528212b0fc18b28d51332d906 upstream.
> 
> The mmap read lock is used during the shrinker's callback, which means
> that using alloc->vma pointer isn't safe as it can race with munmap().
> As of commit dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in
> munmap") the mmap lock is downgraded after the vma has been isolated.
> 
> I was able to reproduce this issue by manually adding some delays and
> triggering page reclaiming through the shrinker's debug sysfs. The
> following KASAN report confirms the UAF:
> 
>   ==================================================================
>   BUG: KASAN: slab-use-after-free in zap_page_range_single+0x470/0x4b8
>   Read of size 8 at addr ffff356ed50e50f0 by task bash/478
> 
>   CPU: 1 PID: 478 Comm: bash Not tainted 6.6.0-rc5-00055-g1c8b86a3799f-dirty #70
>   Hardware name: linux,dummy-virt (DT)
>   Call trace:
>    zap_page_range_single+0x470/0x4b8
>    binder_alloc_free_page+0x608/0xadc
>    __list_lru_walk_one+0x130/0x3b0
>    list_lru_walk_node+0xc4/0x22c
>    binder_shrink_scan+0x108/0x1dc
>    shrinker_debugfs_scan_write+0x2b4/0x500
>    full_proxy_write+0xd4/0x140
>    vfs_write+0x1ac/0x758
>    ksys_write+0xf0/0x1dc
>    __arm64_sys_write+0x6c/0x9c
> 
>   Allocated by task 492:
>    kmem_cache_alloc+0x130/0x368
>    vm_area_alloc+0x2c/0x190
>    mmap_region+0x258/0x18bc
>    do_mmap+0x694/0xa60
>    vm_mmap_pgoff+0x170/0x29c
>    ksys_mmap_pgoff+0x290/0x3a0
>    __arm64_sys_mmap+0xcc/0x144
> 
>   Freed by task 491:
>    kmem_cache_free+0x17c/0x3c8
>    vm_area_free_rcu_cb+0x74/0x98
>    rcu_core+0xa38/0x26d4
>    rcu_core_si+0x10/0x1c
>    __do_softirq+0x2fc/0xd24
> 
>   Last potentially related work creation:
>    __call_rcu_common.constprop.0+0x6c/0xba0
>    call_rcu+0x10/0x1c
>    vm_area_free+0x18/0x24
>    remove_vma+0xe4/0x118
>    do_vmi_align_munmap.isra.0+0x718/0xb5c
>    do_vmi_munmap+0xdc/0x1fc
>    __vm_munmap+0x10c/0x278
>    __arm64_sys_munmap+0x58/0x7c
> 
> Fix this issue by performing instead a vma_lookup() which will fail to
> find the vma that was isolated before the mmap lock downgrade. Note that
> this option has better performance than upgrading to a mmap write lock
> which would increase contention. Plus, mmap_write_trylock() has been
> recently removed anyway.
> 
> Fixes: dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in munmap")
> Cc: stable@vger.kernel.org
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> Link: https://lore.kernel.org/r/20231201172212.1813387-3-cmllamas@google.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [cmllamas: use find_vma() instead of vma_lookup() as commit ce6d42f2e4a2
>  is missing in v5.10. This only works because we check the vma against
>  our cached alloc->vma pointer.]
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
> 
> Notes:
>     v2: remove leftover cherry-pick line from commit log

Not an issue, I normally strip those out :)

Both now queued up, thanks.

greg k-h

