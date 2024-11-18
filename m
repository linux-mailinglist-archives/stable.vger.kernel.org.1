Return-Path: <stable+bounces-93764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739719D08CD
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 06:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF61281CA0
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 05:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD92D13C8FF;
	Mon, 18 Nov 2024 05:24:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CAE13A863;
	Mon, 18 Nov 2024 05:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731907497; cv=none; b=CH0xKGYzoh8j6qElCW7qxzdOmHGNKLlF0Tua+kt1/H0kTIEfItGi5C1pW6Gm7piMzwnnRil1O3m8OvChq2lH0IgKq2A77ruNXzRVPli/pyoWSb07KM+nSo/M4tSRBvJzDk3PRC0fT6i7A98Z6xJ03gz429HECwyslnGM1IQoYWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731907497; c=relaxed/simple;
	bh=ckvDb3fapY7BF3jRYQuWCEPO5x9k7IjKePH5akN4J7A=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=D2gkOvO37iw9y+6ooqUe3rQ7UakVsNKS+ghwAJypMdJjQxcMqBnc6lVaMecLRDLugq1/oa7AUcNOd+yXarR1Qtf3THUbpHbnjJpU/cXLWX4aOlgGingc0tQJ31f9M6JylHdqGCxgig/qeZQaL/KeU8iYZsqD8ErVHGGYl6dXDps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XsGG353sgz92Gv;
	Mon, 18 Nov 2024 13:22:03 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 0EDD41401E0;
	Mon, 18 Nov 2024 13:24:46 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Nov 2024 13:24:44 +0800
Subject: Re: [PATCH 2/2] jffs2: initialize inocache earlier
To: Fedor Pchelkin <pchelkin@ispras.ru>, Richard Weinberger <richard@nod.at>
CC: David Woodhouse <dwmw2@infradead.org>, Wang Yong <wang.yong12@zte.com.cn>,
	Lu Zhongjun <lu.zhongjun@zte.com.cn>, Yang Tao <yang.tao172@zte.com.cn>, Al
 Viro <viro@zeniv.linux.org.uk>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<stable@vger.kernel.org>
References: <20241117184412.366672-1-pchelkin@ispras.ru>
 <20241117184412.366672-3-pchelkin@ispras.ru>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <b4865aaf-8253-b44e-55fe-d1fab1f5f092@huawei.com>
Date: Mon, 18 Nov 2024 13:24:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241117184412.366672-3-pchelkin@ispras.ru>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2024/11/18 2:44, Fedor Pchelkin Ð´µÀ:
> Inside jffs2_new_inode() there is a small gap when jffs2_init_acl_pre() or
> jffs2_do_new_inode() may fail e.g. due to a memory allocation error while
> uninit inocache field is touched upon subsequent inode eviction.
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
> CPU: 0 PID: 10592 Comm: syz-executor.1 Not tainted 5.10.209-syzkaller #0
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> RIP: 0010:jffs2_xattr_delete_inode+0x35/0x130 fs/jffs2/xattr.c:602
> Call Trace:
>   jffs2_do_clear_inode+0x4c/0x570 fs/jffs2/readinode.c:1418
>   evict+0x281/0x6b0 fs/inode.c:577
>   iput_final fs/inode.c:1697 [inline]
>   iput.part.0+0x4df/0x6d0 fs/inode.c:1723
>   iput+0x58/0x80 fs/inode.c:1713
>   jffs2_new_inode+0xb12/0xdb0 fs/jffs2/fs.c:469
>   jffs2_create+0x90/0x400 fs/jffs2/dir.c:177
>   lookup_open.isra.0+0xead/0x1260 fs/namei.c:3169
>   open_last_lookups fs/namei.c:3239 [inline]
>   path_openat+0x96c/0x2670 fs/namei.c:3428
>   do_filp_open+0x1a4/0x3f0 fs/namei.c:3458
>   do_sys_openat2+0x171/0x420 fs/open.c:1186
>   do_sys_open fs/open.c:1202 [inline]
>   __do_sys_openat fs/open.c:1218 [inline]
>   __se_sys_openat fs/open.c:1213 [inline]
>   __x64_sys_openat+0x13c/0x1f0 fs/open.c:1213
>   do_syscall_64+0x30/0x40 arch/x86/entry/common.c:46
> 
> Initialize the inocache pointer to a NULL value while preparing an inode
> in jffs2_init_inode_info(). jffs2_xattr_delete_inode() will handle it
> later just fine.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>   fs/jffs2/os-linux.h | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
> index 86ab014a349c..39b6565f10c9 100644
> --- a/fs/jffs2/os-linux.h
> +++ b/fs/jffs2/os-linux.h
> @@ -55,6 +55,7 @@ static inline void jffs2_init_inode_info(struct jffs2_inode_info *f)
>   	f->metadata = NULL;
>   	f->dents = NULL;
>   	f->target = NULL;
> +	f->inocache = NULL;
>   	f->flags = 0;
>   	f->usercompr = 0;
>   }
> 


