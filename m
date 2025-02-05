Return-Path: <stable+bounces-112261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 175A5A28155
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 02:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F7F18872A7
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 01:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C62422A4E1;
	Wed,  5 Feb 2025 01:29:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596F82288FA;
	Wed,  5 Feb 2025 01:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718979; cv=none; b=LO4fr9Zak83Cq0p9QSOEwL/DdS13zC705yYZlsNnZWkQBrbBKdATMECHcjLhMJ8RMY3+bAvqoSy46VBwUpACS30Yf5wLW1YTMcJPqLU6YAkLH/WbDBUwymLcyTdl0aRSZcg4UTpyLjtSumkZRAuNbWxFKlCLSnNX6LXnDpMmuyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718979; c=relaxed/simple;
	bh=ZqodqJDbBDIYmaw9Q6eFA3nI/NS8YHrRBYnlxn7FyCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MqlTmrO6zdBK/YFXb8LLs1D6fuIVmfGzarvlGXwdEFhZwZmrHxlIGvgk28Lw8TU7QZt4lqgHb9q/aQFFP/FFo9vhzHqzoo3ls/t9eV8SQ3eay5ALRmQ+KWZNxhs103k5bMPqKCTqOolImywk6nTHWkN8rmQQS8IID1BfQTjHqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ynhvx28Bnz1W54x;
	Wed,  5 Feb 2025 09:09:17 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id B7E451802D0;
	Wed,  5 Feb 2025 09:13:34 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Feb 2025 09:13:34 +0800
Message-ID: <e71dbfcd-317e-43b0-8e67-2a7ea3510281@huawei.com>
Date: Wed, 5 Feb 2025 09:13:33 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "hostfs: convert hostfs to use the new mount API" has been
 added to the 6.6-stable tree
To: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>
CC: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
References: <20250203162734.2179532-1-sashal@kernel.org>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250203162734.2179532-1-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemo500009.china.huawei.com (7.202.194.199)



On 2025/2/4 0:27, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>      hostfs: convert hostfs to use the new mount API
> 
> to the 6.6-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 

Hi Sasha,

If this, the fix : ef9ca17ca458 ("hostfs: fix the host directory parse 
when mounting.") also should be added. It fixes the mounting bug when 
pass the host directory.

Thanks,
Hongbo

> The filename of the patch is:
>       hostfs-convert-hostfs-to-use-the-new-mount-api.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 6f2433956e6ade80d59bd673d4062ec2c1bacc3e
> Author: Hongbo Li <lihongbo22@huawei.com>
> Date:   Thu May 30 20:01:11 2024 +0800
> 
>      hostfs: convert hostfs to use the new mount API
>      
>      [ Upstream commit cd140ce9f611a5e9d2a5989a282b75e55c71dab3 ]
>      
>      Convert the hostfs filesystem to the new internal mount API as the old
>      one will be obsoleted and removed.  This allows greater flexibility in
>      communication of mount parameters between userspace, the VFS and the
>      filesystem.
>      
>      See Documentation/filesystems/mount_api.txt for more information.
>      
>      Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>      Link: https://lore.kernel.org/r/20240530120111.3794664-1-lihongbo22@huawei.com
>      Signed-off-by: Christian Brauner <brauner@kernel.org>
>      Stable-dep-of: 60a600243244 ("hostfs: fix string handling in __dentry_name()")
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index ff201753fd181..1fb8eacb9817f 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -16,11 +16,16 @@
>   #include <linux/seq_file.h>
>   #include <linux/writeback.h>
>   #include <linux/mount.h>
> +#include <linux/fs_context.h>
>   #include <linux/namei.h>
>   #include "hostfs.h"
>   #include <init.h>
>   #include <kern.h>
>   
> +struct hostfs_fs_info {
> +	char *host_root_path;
> +};
> +
>   struct hostfs_inode_info {
>   	int fd;
>   	fmode_t mode;
> @@ -90,8 +95,10 @@ static char *__dentry_name(struct dentry *dentry, char *name)
>   	char *p = dentry_path_raw(dentry, name, PATH_MAX);
>   	char *root;
>   	size_t len;
> +	struct hostfs_fs_info *fsi;
>   
> -	root = dentry->d_sb->s_fs_info;
> +	fsi = dentry->d_sb->s_fs_info;
> +	root = fsi->host_root_path;
>   	len = strlen(root);
>   	if (IS_ERR(p)) {
>   		__putname(name);
> @@ -196,8 +203,10 @@ static int hostfs_statfs(struct dentry *dentry, struct kstatfs *sf)
>   	long long f_bavail;
>   	long long f_files;
>   	long long f_ffree;
> +	struct hostfs_fs_info *fsi;
>   
> -	err = do_statfs(dentry->d_sb->s_fs_info,
> +	fsi = dentry->d_sb->s_fs_info;
> +	err = do_statfs(fsi->host_root_path,
>   			&sf->f_bsize, &f_blocks, &f_bfree, &f_bavail, &f_files,
>   			&f_ffree, &sf->f_fsid, sizeof(sf->f_fsid),
>   			&sf->f_namelen);
> @@ -245,7 +254,11 @@ static void hostfs_free_inode(struct inode *inode)
>   
>   static int hostfs_show_options(struct seq_file *seq, struct dentry *root)
>   {
> -	const char *root_path = root->d_sb->s_fs_info;
> +	struct hostfs_fs_info *fsi;
> +	const char *root_path;
> +
> +	fsi = root->d_sb->s_fs_info;
> +	root_path = fsi->host_root_path;
>   	size_t offset = strlen(root_ino) + 1;
>   
>   	if (strlen(root_path) > offset)
> @@ -924,10 +937,11 @@ static const struct inode_operations hostfs_link_iops = {
>   	.get_link	= hostfs_get_link,
>   };
>   
> -static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
> +static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
>   {
> +	struct hostfs_fs_info *fsi = sb->s_fs_info;
>   	struct inode *root_inode;
> -	char *host_root_path, *req_root = d;
> +	char *host_root = fc->source;
>   	int err;
>   
>   	sb->s_blocksize = 1024;
> @@ -941,15 +955,15 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
>   		return err;
>   
>   	/* NULL is printed as '(null)' by printf(): avoid that. */
> -	if (req_root == NULL)
> -		req_root = "";
> +	if (fc->source == NULL)
> +		host_root = "";
>   
> -	sb->s_fs_info = host_root_path =
> -		kasprintf(GFP_KERNEL, "%s/%s", root_ino, req_root);
> -	if (host_root_path == NULL)
> +	fsi->host_root_path =
> +		kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
> +	if (fsi->host_root_path == NULL)
>   		return -ENOMEM;
>   
> -	root_inode = hostfs_iget(sb, host_root_path);
> +	root_inode = hostfs_iget(sb, fsi->host_root_path);
>   	if (IS_ERR(root_inode))
>   		return PTR_ERR(root_inode);
>   
> @@ -957,7 +971,7 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
>   		char *name;
>   
>   		iput(root_inode);
> -		name = follow_link(host_root_path);
> +		name = follow_link(fsi->host_root_path);
>   		if (IS_ERR(name))
>   			return PTR_ERR(name);
>   
> @@ -974,11 +988,38 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
>   	return 0;
>   }
>   
> -static struct dentry *hostfs_read_sb(struct file_system_type *type,
> -			  int flags, const char *dev_name,
> -			  void *data)
> +static int hostfs_fc_get_tree(struct fs_context *fc)
>   {
> -	return mount_nodev(type, flags, data, hostfs_fill_sb_common);
> +	return get_tree_nodev(fc, hostfs_fill_super);
> +}
> +
> +static void hostfs_fc_free(struct fs_context *fc)
> +{
> +	struct hostfs_fs_info *fsi = fc->s_fs_info;
> +
> +	if (!fsi)
> +		return;
> +
> +	kfree(fsi->host_root_path);
> +	kfree(fsi);
> +}
> +
> +static const struct fs_context_operations hostfs_context_ops = {
> +	.get_tree	= hostfs_fc_get_tree,
> +	.free		= hostfs_fc_free,
> +};
> +
> +static int hostfs_init_fs_context(struct fs_context *fc)
> +{
> +	struct hostfs_fs_info *fsi;
> +
> +	fsi = kzalloc(sizeof(*fsi), GFP_KERNEL);
> +	if (!fsi)
> +		return -ENOMEM;
> +
> +	fc->s_fs_info = fsi;
> +	fc->ops = &hostfs_context_ops;
> +	return 0;
>   }
>   
>   static void hostfs_kill_sb(struct super_block *s)
> @@ -988,11 +1029,11 @@ static void hostfs_kill_sb(struct super_block *s)
>   }
>   
>   static struct file_system_type hostfs_type = {
> -	.owner 		= THIS_MODULE,
> -	.name 		= "hostfs",
> -	.mount	 	= hostfs_read_sb,
> -	.kill_sb	= hostfs_kill_sb,
> -	.fs_flags 	= 0,
> +	.owner			= THIS_MODULE,
> +	.name			= "hostfs",
> +	.init_fs_context	= hostfs_init_fs_context,
> +	.kill_sb		= hostfs_kill_sb,
> +	.fs_flags		= 0,
>   };
>   MODULE_ALIAS_FS("hostfs");
>   

