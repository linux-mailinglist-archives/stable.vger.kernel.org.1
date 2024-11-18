Return-Path: <stable+bounces-93763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC8E9D08C8
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 06:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B82B1B21A2C
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 05:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D24C13C9D9;
	Mon, 18 Nov 2024 05:22:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F058613A863;
	Mon, 18 Nov 2024 05:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731907347; cv=none; b=NhDRQ/70z2RlJKGl3V/+43uhaU4nPp2wULn+R1V9My0GUKgaofHpuIKE8Eb8CBscz9chsLZ9dJHnzn5Nxkl8KxHmlH/TYHexUwcV6kuLvhiImVwBcbS48Zw9izA4N5Zg7Zh6l+di1yaJtRPuL0j5G10/IaBfM7zZS6ODO1hJqB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731907347; c=relaxed/simple;
	bh=X2+RyZ7bRyBKT6+ECQvgdWgRsQgvRDABRjJMBskmZs8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=shuGFJ210N9cjArAt5gWkMV0cNPlIjUp3PeP86fhLIB9S2A3HbqirfrCKQ32UqgzWoqgganRWq+ehtl1faqHOedTabo1ZL50wdbH5hInsMsIgFpAR5BW0vlOy+T1iCBqcNllV0s3wiI9rhjfXe34i5UwDktG5E1NN1qNlRSo2iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XsGD063cWz2GZky;
	Mon, 18 Nov 2024 13:20:16 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id F00B5140135;
	Mon, 18 Nov 2024 13:22:12 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Nov 2024 13:22:11 +0800
Subject: Re: [PATCH 1/2] jffs2: initialize filesystem-private inode info in
 ->alloc_inode callback
To: Fedor Pchelkin <pchelkin@ispras.ru>, Richard Weinberger <richard@nod.at>
CC: David Woodhouse <dwmw2@infradead.org>, Wang Yong <wang.yong12@zte.com.cn>,
	Lu Zhongjun <lu.zhongjun@zte.com.cn>, Yang Tao <yang.tao172@zte.com.cn>, Al
 Viro <viro@zeniv.linux.org.uk>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<stable@vger.kernel.org>
References: <20241117184412.366672-1-pchelkin@ispras.ru>
 <20241117184412.366672-2-pchelkin@ispras.ru>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <c68152b5-e91a-2296-21fd-c6a80a406958@huawei.com>
Date: Mon, 18 Nov 2024 13:22:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241117184412.366672-2-pchelkin@ispras.ru>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2024/11/18 2:44, Fedor Pchelkin Ð´µÀ:
> The symlink body (->target) should be freed at the same time as the inode
> itself per commit 4fdcfab5b553 ("jffs2: fix use-after-free on symlink
> traversal"). It is a filesystem-specific field but there exist several
> error paths during generic inode allocation when ->free_inode(), namely
> jffs2_free_inode(), is called with still uninitialized private info.
> 
> The calltrace looks like:
>   alloc_inode
>    inode_init_always // fails
>     i_callback
>      free_inode
>      jffs2_free_inode // touches uninit ->target field
> 
> Commit af9a8730ddb6 ("jffs2: Fix potential illegal address access in
> jffs2_free_inode") approached the observed problem but fixed it only
> partially. Our local Syzkaller instance is still hitting these kinds of
> failures.
> 
> The thing is that jffs2_i_init_once(), where the initialization of
> f->target has been moved, is called once per slab allocation so it won't
> be called for the object structure possibly retrieved later from the slab
> cache for reuse.
> 
> The practice followed by many other filesystems is to initialize
> filesystem-private inode contents in the corresponding ->alloc_inode()
> callbacks. This also allows to drop initialization from jffs2_iget() and
> jffs2_new_inode() as ->alloc_inode() is called in those places.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: 4fdcfab5b553 ("jffs2: fix use-after-free on symlink traversal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>   fs/jffs2/fs.c    | 2 --
>   fs/jffs2/super.c | 3 ++-
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
> index d175cccb7c55..85c4b273918f 100644
> --- a/fs/jffs2/fs.c
> +++ b/fs/jffs2/fs.c
> @@ -271,7 +271,6 @@ struct inode *jffs2_iget(struct super_block *sb, unsigned long ino)
>   	f = JFFS2_INODE_INFO(inode);
>   	c = JFFS2_SB_INFO(inode->i_sb);
>   
> -	jffs2_init_inode_info(f);
>   	mutex_lock(&f->sem);
>   
>   	ret = jffs2_do_read_inode(c, f, inode->i_ino, &latest_node);
> @@ -439,7 +438,6 @@ struct inode *jffs2_new_inode (struct inode *dir_i, umode_t mode, struct jffs2_r
>   		return ERR_PTR(-ENOMEM);
>   
>   	f = JFFS2_INODE_INFO(inode);
> -	jffs2_init_inode_info(f);
>   	mutex_lock(&f->sem);
>   
>   	memset(ri, 0, sizeof(*ri));
> diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
> index 4545f885c41e..b56ff63357f3 100644
> --- a/fs/jffs2/super.c
> +++ b/fs/jffs2/super.c
> @@ -42,6 +42,8 @@ static struct inode *jffs2_alloc_inode(struct super_block *sb)
>   	f = alloc_inode_sb(sb, jffs2_inode_cachep, GFP_KERNEL);
>   	if (!f)
>   		return NULL;
> +
> +	jffs2_init_inode_info(f);
>   	return &f->vfs_inode;
>   }
>   
> @@ -58,7 +60,6 @@ static void jffs2_i_init_once(void *foo)
>   	struct jffs2_inode_info *f = foo;
>   
>   	mutex_init(&f->sem);
> -	f->target = NULL;
>   	inode_init_once(&f->vfs_inode);
>   }
>   
> 


