Return-Path: <stable+bounces-121531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93827A5783F
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 05:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8FB6174094
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 04:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB82158DD4;
	Sat,  8 Mar 2025 04:13:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9202CAB;
	Sat,  8 Mar 2025 04:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741407198; cv=none; b=iqU1WB/wg2rJAhnaxBoqesxBOtOJgCkP6JR+g1CXtljH5yDzsbhl/k7ToATYFUGBw8Im3tdvODzpdShaDNszAFtjMm4BGtM0Eq6IYR3yvS4g0U0TumX5WjdpxJyC2paeWYWLKXTW3FxnVBICr2P6O43Qa3Ww3lCyn2RbRKKbyZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741407198; c=relaxed/simple;
	bh=KvHtJtunMdjsrRjaHFm5thphwaG9HpwBQQwmM+IiVpc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=vBtoL9lZYWaCn5hotGy0TtUSJC1SepZzWkiGC+dSln3vFgRPYKxq0vWH/xPL7poKWYpdD9eHR90v2CtuzVayOZUksFV2SKpCFwt5YRas5+AH854jXoZK4ygxXr3+frihKYWPWGkOOFOyTLGPlAFFm+N5JchoSvo41WkVGzlhN7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Z8qQt25Ghz1dyhD;
	Sat,  8 Mar 2025 12:08:54 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 0229A1A0188;
	Sat,  8 Mar 2025 12:13:11 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 8 Mar 2025 12:13:10 +0800
Subject: Re: [PATCH] jffs2: check that raw node were preallocated before
 writing summary
To: Artem Sadovnikov <a.sadovnikov@ispras.ru>, <linux-mtd@lists.infradead.org>
CC: David Woodhouse <dwmw2@infradead.org>, Richard Weinberger
	<richard@nod.at>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <stable@vger.kernel.org>
References: <20250307163409.13491-2-a.sadovnikov@ispras.ru>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <6d0b7143-8e36-6bb7-16c1-817ef3287e10@huawei.com>
Date: Sat, 8 Mar 2025 12:13:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250307163409.13491-2-a.sadovnikov@ispras.ru>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2025/3/8 0:34, Artem Sadovnikov Ð´µÀ:
> Syzkaller detected a kernel bug in jffs2_link_node_ref, caused by fault
> injection in jffs2_prealloc_raw_node_refs. jffs2_sum_write_sumnode doesn't
> check return value of jffs2_prealloc_raw_node_refs and simply lets any
> error propagate into jffs2_sum_write_data, which eventually calls
> jffs2_link_node_ref in order to link the summary to an expectedly allocated
> node.
> 
> kernel BUG at fs/jffs2/nodelist.c:592!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 1 PID: 31277 Comm: syz-executor.7 Not tainted 6.1.128-syzkaller-00139-ge10f83ca10a1 #0
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> RIP: 0010:jffs2_link_node_ref+0x570/0x690 fs/jffs2/nodelist.c:592
> Call Trace:
>   <TASK>
>   jffs2_sum_write_data fs/jffs2/summary.c:841 [inline]
>   jffs2_sum_write_sumnode+0xd1a/0x1da0 fs/jffs2/summary.c:874
>   jffs2_do_reserve_space+0xa18/0xd60 fs/jffs2/nodemgmt.c:388
>   jffs2_reserve_space+0x55f/0xaa0 fs/jffs2/nodemgmt.c:197
>   jffs2_write_inode_range+0x246/0xb50 fs/jffs2/write.c:362
>   jffs2_write_end+0x726/0x15d0 fs/jffs2/file.c:301
>   generic_perform_write+0x314/0x5d0 mm/filemap.c:3856
>   __generic_file_write_iter+0x2ae/0x4d0 mm/filemap.c:3973
>   generic_file_write_iter+0xe3/0x350 mm/filemap.c:4005
>   call_write_iter include/linux/fs.h:2265 [inline]
>   do_iter_readv_writev+0x20f/0x3c0 fs/read_write.c:735
>   do_iter_write+0x186/0x710 fs/read_write.c:861
>   vfs_iter_write+0x70/0xa0 fs/read_write.c:902
>   iter_file_splice_write+0x73b/0xc90 fs/splice.c:685
>   do_splice_from fs/splice.c:763 [inline]
>   direct_splice_actor+0x10c/0x170 fs/splice.c:950
>   splice_direct_to_actor+0x337/0xa10 fs/splice.c:896
>   do_splice_direct+0x1a9/0x280 fs/splice.c:1002
>   do_sendfile+0xb13/0x12c0 fs/read_write.c:1255
>   __do_sys_sendfile64 fs/read_write.c:1323 [inline]
>   __se_sys_sendfile64 fs/read_write.c:1309 [inline]
>   __x64_sys_sendfile64+0x1cf/0x210 fs/read_write.c:1309
>   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>   do_syscall_64+0x35/0x80 arch/x86/entry/common.c:81
>   entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> 
> Fix this issue by checking return value of jffs2_prealloc_raw_node_refs
> before calling jffs2_sum_write_data.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Cc: stable@vger.kernel.org
> Fixes: 2f785402f39b ("[JFFS2] Reduce visibility of raw_node_ref to upper layers of JFFS2 code.")
> Signed-off-by: Artem Sadovnikov <a.sadovnikov@ispras.ru>
> ---
>   fs/jffs2/summary.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/jffs2/summary.c b/fs/jffs2/summary.c
> index 4fe64519870f1..d83372d3e1a07 100644
> --- a/fs/jffs2/summary.c
> +++ b/fs/jffs2/summary.c
> @@ -858,7 +858,10 @@ int jffs2_sum_write_sumnode(struct jffs2_sb_info *c)
>   	spin_unlock(&c->erase_completion_lock);
>   
>   	jeb = c->nextblock;
> -	jffs2_prealloc_raw_node_refs(c, jeb, 1);
> +	ret = jffs2_prealloc_raw_node_refs(c, jeb, 1);
> +
> +	if (ret)
> +		goto out;
>   
>   	if (!c->summary->sum_num || !c->summary->sum_list_head) {
>   		JFFS2_WARNING("Empty summary info!!!\n");
> @@ -872,6 +875,8 @@ int jffs2_sum_write_sumnode(struct jffs2_sb_info *c)
>   	datasize += padsize;
>   
>   	ret = jffs2_sum_write_data(c, jeb, infosize, datasize, padsize);
> +
> +out:
>   	spin_lock(&c->erase_completion_lock);
>   	return ret;
>   }
> 


