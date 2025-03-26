Return-Path: <stable+bounces-126669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E77B3A70F35
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 03:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3CB1891DA2
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 02:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C90C14A614;
	Wed, 26 Mar 2025 02:50:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2162B9CF;
	Wed, 26 Mar 2025 02:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742957428; cv=none; b=na1LXDICELAPv/wBBn66mh77bKEwRyTs643Zhvfbg7nzTtxfXd2gMWOMIlXvYvHINq64LbBYZldwcxh/IUhX6PgLv1yrOCIp35dP83g6S1xNYZmw1fc19BkGusuRb3OyecTdDzrP6ebLBAzHjrJNtFnOrxW8BREiiOANiX7j8ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742957428; c=relaxed/simple;
	bh=P4cNx8UpvXvFeQzrapJXpJI7nVJOk6s+ylMENBO5nPg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=f8UUqsA/72tCfEsUlHhkK8rkEDFcJzyuwvYgqaCtr3rCCto+fmGNQHnzzwUFMK1jh7C2YCJe8xwApk146QRXtxHoEScB5vRVUlYQHgYy1SodsOI43X0vofabaoIqtm7LTIVLDLOCM8AzwzQyZWhnTpg+5ntne8qCVURgYQYa54Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZMrqP3w07z13LCv;
	Wed, 26 Mar 2025 10:49:53 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id D90901800FD;
	Wed, 26 Mar 2025 10:50:15 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 26 Mar 2025 10:50:15 +0800
Subject: Re: [PATCH] jffs2: check jffs2_prealloc_raw_node_refs() result in few
 other places
To: Fedor Pchelkin <pchelkin@ispras.ru>, Richard Weinberger <richard@nod.at>
CC: David Woodhouse <dwmw2@infradead.org>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<stable@vger.kernel.org>
References: <20250325163215.287311-1-pchelkin@ispras.ru>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <742d0485-66ec-94b3-4e97-481ffc33383e@huawei.com>
Date: Wed, 26 Mar 2025 10:50:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250325163215.287311-1-pchelkin@ispras.ru>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2025/3/26 0:32, Fedor Pchelkin Ð´µÀ:
> Fuzzing hit another invalid pointer dereference due to the lack of
> checking whether jffs2_prealloc_raw_node_refs() completed successfully.
> Subsequent logic implies that the node refs have been allocated.
> 
> Handle that. The code is ready for propagating the error upwards.
> 
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 1 PID: 5835 Comm: syz-executor145 Not tainted 5.10.234-syzkaller #0
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> RIP: 0010:jffs2_link_node_ref+0xac/0x690 fs/jffs2/nodelist.c:600
> Call Trace:
>   jffs2_mark_erased_block fs/jffs2/erase.c:460 [inline]
>   jffs2_erase_pending_blocks+0x688/0x1860 fs/jffs2/erase.c:118
>   jffs2_garbage_collect_pass+0x638/0x1a00 fs/jffs2/gc.c:253
>   jffs2_reserve_space+0x3f4/0xad0 fs/jffs2/nodemgmt.c:167
>   jffs2_write_inode_range+0x246/0xb50 fs/jffs2/write.c:362
>   jffs2_write_end+0x712/0x1110 fs/jffs2/file.c:302
>   generic_perform_write+0x2c2/0x500 mm/filemap.c:3347
>   __generic_file_write_iter+0x252/0x610 mm/filemap.c:3465
>   generic_file_write_iter+0xdb/0x230 mm/filemap.c:3497
>   call_write_iter include/linux/fs.h:2039 [inline]
>   do_iter_readv_writev+0x46d/0x750 fs/read_write.c:740
>   do_iter_write+0x18c/0x710 fs/read_write.c:866
>   vfs_writev+0x1db/0x6a0 fs/read_write.c:939
>   do_pwritev fs/read_write.c:1036 [inline]
>   __do_sys_pwritev fs/read_write.c:1083 [inline]
>   __se_sys_pwritev fs/read_write.c:1078 [inline]
>   __x64_sys_pwritev+0x235/0x310 fs/read_write.c:1078
>   do_syscall_64+0x30/0x40 arch/x86/entry/common.c:46
>   entry_SYSCALL_64_after_hwframe+0x67/0xd1
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: 2f785402f39b ("[JFFS2] Reduce visibility of raw_node_ref to upper layers of JFFS2 code.")
> Fixes: f560928baa60 ("[JFFS2] Allocate node_ref for wasted space when skipping to page boundary")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
> 
> Similar to https://lore.kernel.org/linux-mtd/20250307163409.13491-2-a.sadovnikov@ispras.ru/
> but touches two remaining places.
> 
>   fs/jffs2/erase.c | 4 +++-
>   fs/jffs2/scan.c  | 4 +++-
>   2 files changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/fs/jffs2/erase.c b/fs/jffs2/erase.c
> index ef3a1e1b6cb0..fda9f4d6093f 100644
> --- a/fs/jffs2/erase.c
> +++ b/fs/jffs2/erase.c
> @@ -425,7 +425,9 @@ static void jffs2_mark_erased_block(struct jffs2_sb_info *c, struct jffs2_eraseb
>   			.totlen =	cpu_to_je32(c->cleanmarker_size)
>   		};
>   
> -		jffs2_prealloc_raw_node_refs(c, jeb, 1);
> +		ret = jffs2_prealloc_raw_node_refs(c, jeb, 1);
> +		if (ret)
> +			goto filebad;
>   
>   		marker.hdr_crc = cpu_to_je32(crc32(0, &marker, sizeof(struct jffs2_unknown_node)-4));
>   
> diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
> index 29671e33a171..62879c218d4b 100644
> --- a/fs/jffs2/scan.c
> +++ b/fs/jffs2/scan.c
> @@ -256,7 +256,9 @@ int jffs2_scan_medium(struct jffs2_sb_info *c)
>   
>   		jffs2_dbg(1, "%s(): Skipping %d bytes in nextblock to ensure page alignment\n",
>   			  __func__, skip);
> -		jffs2_prealloc_raw_node_refs(c, c->nextblock, 1);
> +		ret = jffs2_prealloc_raw_node_refs(c, c->nextblock, 1);
> +		if (ret)
> +			goto out;
>   		jffs2_scan_dirty_space(c, c->nextblock, skip);
>   	}
>   #endif
> 


