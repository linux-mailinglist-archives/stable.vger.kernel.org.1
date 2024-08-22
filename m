Return-Path: <stable+bounces-69870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F186A95AFD6
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 10:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21AF31C22DD0
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 08:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B5315C159;
	Thu, 22 Aug 2024 08:04:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DE5502BE;
	Thu, 22 Aug 2024 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313859; cv=none; b=s6hJ+goRCFoBjcN2DpEIJro6EosKqxgNgADKtMOlAe9X0m5jQWeymIpXAS1iTYXhsk8CH498IxVMVLFGbtXij++tUMrHKpOCnmTwb6a1o8izYlWx8Rl5kYy1GIZuz4a20qtxuFGwYc9vi+ERCxdAr6Wv/EIybYnzqZ4aW/XkTL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313859; c=relaxed/simple;
	bh=/QiX92N+7MCO8lsvLXs58KSrXmYLTbD3m/Hg4SHlSC0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=STk7D0svBECcPq2w0hCwCVd1+jteWgDqUmk4l4zeGHVRsUETPFmegR60SCoid3y/sWiwmLy30tgnqLfMvZAS1ROayQvf5SwZrXWiXUHLk+iuk3wjLwbiHA0LdLBcnbMNsqj/I/U9eAIVIm8xa1HkT4/wMB7L+iZAiBSxfpGDlSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WqFzZ0rT0z1xvlv;
	Thu, 22 Aug 2024 16:02:18 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AF97140447;
	Thu, 22 Aug 2024 16:04:13 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 22 Aug 2024 16:04:11 +0800
Subject: Re: [PATCH] codetag: debug: mark codetags for pages which
 transitioned from being poison to unpoison as empty
To: Hao Ge <hao.ge@linux.dev>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Hao Ge
	<gehao@kylinos.cn>, <stable@vger.kernel.org>, <nao.horiguchi@gmail.com>,
	<akpm@linux-foundation.org>, <surenb@google.com>,
	<pasha.tatashin@soleen.com>, <david@redhat.com>, <kent.overstreet@linux.dev>
References: <20240822025800.13380-1-hao.ge@linux.dev>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e360598c-cb58-cf9d-9247-430b8df9b3b7@huawei.com>
Date: Thu, 22 Aug 2024 16:04:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240822025800.13380-1-hao.ge@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/8/22 10:58, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
> 

Thanks for your patch.

> The PG_hwpoison page will be caught and isolated on the entrance to
> the free buddy page pool. so,when we clear this flag and return it
> to the buddy system,mark codetags for pages as empty.
> 

Is below scene cause the problem?

1. Pages are allocated. pgalloc_tag_add() will be called when prep_new_page().

2. Pages are hwpoisoned. memory_failure() will set PG_hwpoison flag and pgalloc_tag_sub()
will be called when pages are caught and isolated on the entrance to buddy.

3. unpoison_memory cleared flags and sent the pages to buddy. pgalloc_tag_sub() will be
called again in free_pages_prepare().

So there is a imbalance that pgalloc_tag_add() is called once and pgalloc_tag_sub() is called twice?

If so, let's think about more complicated scene:

1. Same as above.

2. Pages are hwpoisoned. But memory_failure() fails to handle it. So PG_hwpoison flag is set
but pgalloc_tag_sub() is not called (pages are not sent to buddy).

3. unpoison_memory cleared flags and calls clear_page_tag_ref() without calling pgalloc_tag_sub()
first. Will this cause problem?

Though this should be really rare...

Thanks.
.

> It was detected by [1] and the following WARN occurred:
> 
> [  113.930443][ T3282] ------------[ cut here ]------------
> [  113.931105][ T3282] alloc_tag was not set
> [  113.931576][ T3282] WARNING: CPU: 2 PID: 3282 at ./include/linux/alloc_tag.h:130 pgalloc_tag_sub.part.66+0x154/0x164
> [  113.932866][ T3282] Modules linked in: hwpoison_inject fuse ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ebtable_broute ip6table_nat ip6table_man4
> [  113.941638][ T3282] CPU: 2 UID: 0 PID: 3282 Comm: madvise11 Kdump: loaded Tainted: G        W          6.11.0-rc4-dirty #18
> [  113.943003][ T3282] Tainted: [W]=WARN
> [  113.943453][ T3282] Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
> [  113.944378][ T3282] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  113.945319][ T3282] pc : pgalloc_tag_sub.part.66+0x154/0x164
> [  113.946016][ T3282] lr : pgalloc_tag_sub.part.66+0x154/0x164
> [  113.946706][ T3282] sp : ffff800087093a10
> [  113.947197][ T3282] x29: ffff800087093a10 x28: ffff0000d7a9d400 x27: ffff80008249f0a0
> [  113.948165][ T3282] x26: 0000000000000000 x25: ffff80008249f2b0 x24: 0000000000000000
> [  113.949134][ T3282] x23: 0000000000000001 x22: 0000000000000001 x21: 0000000000000000
> [  113.950597][ T3282] x20: ffff0000c08fcad8 x19: ffff80008251e000 x18: ffffffffffffffff
> [  113.952207][ T3282] x17: 0000000000000000 x16: 0000000000000000 x15: ffff800081746210
> [  113.953161][ T3282] x14: 0000000000000000 x13: 205d323832335420 x12: 5b5d353031313339
> [  113.954120][ T3282] x11: ffff800087093500 x10: 000000000000005d x9 : 00000000ffffffd0
> [  113.955078][ T3282] x8 : 7f7f7f7f7f7f7f7f x7 : ffff80008236ba90 x6 : c0000000ffff7fff
> [  113.956036][ T3282] x5 : ffff000b34bf4dc8 x4 : ffff8000820aba90 x3 : 0000000000000001
> [  113.956994][ T3282] x2 : ffff800ab320f000 x1 : 841d1e35ac932e00 x0 : 0000000000000000
> [  113.957962][ T3282] Call trace:
> [  113.958350][ T3282]  pgalloc_tag_sub.part.66+0x154/0x164
> [  113.959000][ T3282]  pgalloc_tag_sub+0x14/0x1c
> [  113.959539][ T3282]  free_unref_page+0xf4/0x4b8
> [  113.960096][ T3282]  __folio_put+0xd4/0x120
> [  113.960614][ T3282]  folio_put+0x24/0x50
> [  113.961103][ T3282]  unpoison_memory+0x4f0/0x5b0
> [  113.961678][ T3282]  hwpoison_unpoison+0x30/0x48 [hwpoison_inject]
> [  113.962436][ T3282]  simple_attr_write_xsigned.isra.34+0xec/0x1cc
> [  113.963183][ T3282]  simple_attr_write+0x38/0x48
> [  113.963750][ T3282]  debugfs_attr_write+0x54/0x80
> [  113.964330][ T3282]  full_proxy_write+0x68/0x98
> [  113.964880][ T3282]  vfs_write+0xdc/0x4d0
> [  113.965372][ T3282]  ksys_write+0x78/0x100
> [  113.965875][ T3282]  __arm64_sys_write+0x24/0x30
> [  113.966440][ T3282]  invoke_syscall+0x7c/0x104
> [  113.966984][ T3282]  el0_svc_common.constprop.1+0x88/0x104
> [  113.967652][ T3282]  do_el0_svc+0x2c/0x38
> [  113.968893][ T3282]  el0_svc+0x3c/0x1b8
> [  113.969379][ T3282]  el0t_64_sync_handler+0x98/0xbc
> [  113.969980][ T3282]  el0t_64_sync+0x19c/0x1a0
> [  113.970511][ T3282] ---[ end trace 0000000000000000 ]---
> 
> Link [1]: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/madvise/madvise11.c
> 
> Fixes: a8fc28dad6d5 ("alloc_tag: introduce clear_page_tag_ref() helper function")
> Cc: stable@vger.kernel.org # v6.10
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
>  mm/memory-failure.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 7066fc84f351..570388c41532 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2623,6 +2623,12 @@ int unpoison_memory(unsigned long pfn)
>  
>  		folio_put(folio);
>  		if (TestClearPageHWPoison(p)) {
> +			/* the PG_hwpoison page will be caught and isolated
> +			 * on the entrance to the free buddy page pool.
> +			 * so,when we clear this flag and return it to the buddy system,
> +			 * clear it's codetag
> +			 */
> +			clear_page_tag_ref(p);
>  			folio_put(folio);
>  			ret = 0;
>  		}
> 


