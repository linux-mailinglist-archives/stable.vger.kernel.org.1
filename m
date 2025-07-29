Return-Path: <stable+bounces-165083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE17EB14F8A
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 16:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328085455D8
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 14:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2381D1F560D;
	Tue, 29 Jul 2025 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f0M8jh1E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D584E1E9B2D
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800594; cv=none; b=rfm+Q+7ZVW4/EIQwcAbGvFSzGyh+EoYc+FP0QioPVmVLoHI3W0qaR8G0VrqPqJ+WZ6liXdb3QtJuUCPM73YIckI3iNPqroB7WpPUncbLGKqmfeW3jGyXMBYp0hYIaj9OpLKR5VqxKB/2o/3gDFXMqq64KrYb6Zq8mIu01B09ITU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800594; c=relaxed/simple;
	bh=8WHu65Du/5RAZ7vIpLgroUB1ihWHIGMcCMvNDR1D48w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQ2xZE831LW9ZNcgEIdTE1PPPyYU9+rnQCt5a/UPPfxNVQkFHreNZBafKW7HWT1K3wfsddynAGCmWRSYQ6Ili4gIOaRjWFgFPQCTRET5tOK5FAEXLXMI9UYWQ9fzhw1mBOEGTL97TFfv+7rNzvHEwRYsRMLmMtv+O7Ym4o/IvUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f0M8jh1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A41C4CEEF;
	Tue, 29 Jul 2025 14:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753800594;
	bh=8WHu65Du/5RAZ7vIpLgroUB1ihWHIGMcCMvNDR1D48w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f0M8jh1E567Dzc3VA74jPcIWNmhbrWXFrtgIR+481l4ITDFj3cWe2icTVpA176/Lk
	 UxRnG1qinStkhCVNNpHX89TXWi14XyKBQKvWfXD//W1GQONi1zFZYJTGsbu+LAxBz5
	 sYm3dQftOPHbWiU0MEKRivX361+bsOcsDozaG1vk=
Date: Tue, 29 Jul 2025 16:49:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jakub Acs <acsjakub@amazon.de>
Cc: stable@vger.kernel.org, Liu Shixin <liushixin2@huawei.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	David Hildenbrand <david@redhat.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Mattew Wilcox <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nanyong Sun <sunnanyong@huawei.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH 6.12.y] mm: khugepaged: fix call
 hpage_collapse_scan_file() for anonymous vma
Message-ID: <2025072932-scorer-manhood-b6fc@gregkh>
References: <20250729090347.17922-1-acsjakub@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729090347.17922-1-acsjakub@amazon.de>

On Tue, Jul 29, 2025 at 09:03:47AM +0000, Jakub Acs wrote:
> From: Liu Shixin <liushixin2@huawei.com>
> 
> commit f1897f2f08b28ae59476d8b73374b08f856973af upstream.
> 
> syzkaller reported such a BUG_ON():
> 
>  ------------[ cut here ]------------
>  kernel BUG at mm/khugepaged.c:1835!
>  Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>  ...
>  CPU: 6 UID: 0 PID: 8009 Comm: syz.15.106 Kdump: loaded Tainted: G        W          6.13.0-rc6 #22
>  Tainted: [W]=WARN
>  Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>  pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : collapse_file+0xa44/0x1400
>  lr : collapse_file+0x88/0x1400
>  sp : ffff80008afe3a60
>  ...
>  Call trace:
>   collapse_file+0xa44/0x1400 (P)
>   hpage_collapse_scan_file+0x278/0x400
>   madvise_collapse+0x1bc/0x678
>   madvise_vma_behavior+0x32c/0x448
>   madvise_walk_vmas.constprop.0+0xbc/0x140
>   do_madvise.part.0+0xdc/0x2c8
>   __arm64_sys_madvise+0x68/0x88
>   invoke_syscall+0x50/0x120
>   el0_svc_common.constprop.0+0xc8/0xf0
>   do_el0_svc+0x24/0x38
>   el0_svc+0x34/0x128
>   el0t_64_sync_handler+0xc8/0xd0
>   el0t_64_sync+0x190/0x198
> 
> This indicates that the pgoff is unaligned.  After analysis, I confirm the
> vma is mapped to /dev/zero.  Such a vma certainly has vm_file, but it is
> set to anonymous by mmap_zero().  So even if it's mmapped by 2m-unaligned,
> it can pass the check in thp_vma_allowable_order() as it is an
> anonymous-mmap, but then be collapsed as a file-mmap.
> 
> It seems the problem has existed for a long time, but actually, since we
> have khugepaged_max_ptes_none check before, we will skip collapse it as it
> is /dev/zero and so has no present page.  But commit d8ea7cc8547c limit
> the check for only khugepaged, so the BUG_ON() can be triggered by
> madvise_collapse().
> 
> Add vma_is_anonymous() check to make such vma be processed by
> hpage_collapse_scan_pmd().
> 
> Link: https://lkml.kernel.org/r/20250111034511.2223353-1-liushixin2@huawei.com
> Fixes: d8ea7cc8547c ("mm/khugepaged: add flag to predicate khugepaged-only behavior")
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Reviewed-by: Yang Shi <yang@os.amperecomputing.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Mattew Wilcox <willy@infradead.org>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Nanyong Sun <sunnanyong@huawei.com>
> Cc: Qi Zheng <zhengqi.arch@bytedance.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> [acsjakub: backport, clean apply]
> Cc: Jakub Acs <acsjakub@amazon.de>

You need to sign off on patches you forward on.  Please fix that up and
resend all of these.

thanks,

greg -h

