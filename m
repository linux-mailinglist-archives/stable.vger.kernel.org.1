Return-Path: <stable+bounces-45574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C8D8CC348
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 16:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9914BB21D83
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 14:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CDE1CF8D;
	Wed, 22 May 2024 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="cBINWo57"
X-Original-To: stable@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECC01BDD0;
	Wed, 22 May 2024 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388545; cv=none; b=hmPgY9pQTcr4+MoCe49XuE26Z/oH5sc/7B6C3N2bZn1UnH699AXsZ5HR4p/g5zyHjjKM9prcATkA/EuUx+KH0JGmLK2Oyt6OH9Ql+2AMoBpahjJ95JSnd1FCIIv8925XYeGTMph5DJ+/A6wX4lEFM7TryeMAo1t4j8NXyZPLD8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388545; c=relaxed/simple;
	bh=i4rasA2acN66D6Z+ulCdlX0xWV7X3xQAZp4uOXv0umI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EC8m0sgeTSizKS0QMAJNdvkx32xLuDEUBzAOVDKaMq9YTn4/2KDzBHACpQw5ZP8i2HLHrl7xGaxVDt7SzimsRKvZ2HPreUEksduVEW5zScQsW3aUcs/jF8GXDy7fP+ZgmBmaSPd0Ep5bU6kXXXLPkobIJmbptacOl93Z+6kLTTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=cBINWo57; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=ZNmiJed3LQ9K2TAQzrIkg8tVC5riieBoVY7FS58SXFo=; b=cBINWo57ruofAmBa2/cgxzV4Nh
	BzfV0kxDMZI4si3mDluTmX8HhOs7QwGqOwRMUoVSNv9OjcKO6Lg54mV9TvR3IhPCtn6AdbvkibI4a
	LtKjxpyOGEW9R65efq9U7manVdmBr1Phdo5vlWBu0iEKOuouli+MqdSNkvqlgmNUfKhSwNG88GvUm
	h3z5gmearYVp/GXhD6xrhKf7WI2qKWnaRwJqkRZFMwFFmYdqV+OKqM6nE6IBD2DMPTeGf/6Ec6CK4
	TunDQk87MaBXT8mCDFWzYssoOoFxSGM9dfz8bDKHt2WWCq9L0Ub0NXPa11oZqHsJK1IbjzW8sLBVd
	K74NV7XL3/Tki5kGnVZFJfbkavm+QwihTIZq2VAQPtNlXRykc2SVDO7dT/sCM0H7kz5XZkzXtRoSF
	iUK9FTiDQYTHNGPZOrrDmSm6xhnjWWZKi8qg1Sw1nNpRThALJIW2/uUCrn/5AATx/yVS78JYcKRtR
	Km5a20H3vBih284cusO0zpHuaMK9ihU5sBzfM9dSfuH5owR8cHn4kvuuPHWeE8lCQ7WIrR+tcvget
	v/WgrqlIugyowjZqsohLMsZKXEb1/UfoC93usUCnghyy/SjNNi7CjYvMkHZEXzVD1bHQVr4Bk9k4O
	r8ea0Y0XjK/tCuL+iKfDcqoYqFPF9qFT/25NazoLc=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, Greg Kurz <groug@kaod.org>,
 Jianyong Wu <jianyong.wu@arm.com>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: stable@vger.kernel.org, Eric Van Hensbergen <ericvh@gmail.com>,
 v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: add missing locking around taking dentry fid list
Date: Wed, 22 May 2024 16:35:19 +0200
Message-ID: <1738699.kjPCCGL2iY@silver>
In-Reply-To: <20240521122947.1080227-1-asmadeus@codewreck.org>
References: <20240521122947.1080227-1-asmadeus@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, May 21, 2024 2:29:46 PM CEST Dominique Martinet wrote:
> Fix a use-after-free on dentry's d_fsdata fid list when a thread
> lookups a fid through dentry while another thread unlinks it:

I guess that's "looks up". :)

> UAF thread:
> refcount_t: addition on 0; use-after-free.
>  p9_fid_get linux/./include/net/9p/client.h:262
>  v9fs_fid_find+0x236/0x280 linux/fs/9p/fid.c:129
>  v9fs_fid_lookup_with_uid linux/fs/9p/fid.c:181
>  v9fs_fid_lookup+0xbf/0xc20 linux/fs/9p/fid.c:314
>  v9fs_vfs_getattr_dotl+0xf9/0x360 linux/fs/9p/vfs_inode_dotl.c:400
>  vfs_statx+0xdd/0x4d0 linux/fs/stat.c:248
> 
> Freed by:
>  p9_client_clunk+0xb0/0xe0 linux/net/9p/client.c:1456

That line number looks weird.

>  p9_fid_put linux/./include/net/9p/client.h:278
>  v9fs_dentry_release+0xb5/0x140 linux/fs/9p/vfs_dentry.c:55
>  v9fs_remove+0x38f/0x620 linux/fs/9p/vfs_inode.c:518
>  vfs_unlink+0x29a/0x810 linux/fs/namei.c:4335
> 
> The problem is that d_fsdata was not accessed under d_lock, because
> d_release() normally is only called once the dentry is otherwise no
> longer accessible but since we also call it explicitly in v9fs_remove
> that lock is required:
> move the hlist out of the dentry under lock then unref its fids once
> they are no longer accessible.
> 
> Fixes: 154372e67d40 ("fs/9p: fix create-unlink-getattr idiom")
> Cc: stable@vger.kernel.org
> Reported-by: Meysam Firouzi
> Reported-by: Amirmohammad Eftekhar
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
>  fs/9p/vfs_dentry.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
> index f16f73581634..01338d4c2d9e 100644
> --- a/fs/9p/vfs_dentry.c
> +++ b/fs/9p/vfs_dentry.c
> @@ -48,12 +48,17 @@ static int v9fs_cached_dentry_delete(const struct dentry *dentry)
>  static void v9fs_dentry_release(struct dentry *dentry)
>  {
>  	struct hlist_node *p, *n;
> +	struct hlist_head head;
>  
>  	p9_debug(P9_DEBUG_VFS, " dentry: %pd (%p)\n",
>  		 dentry, dentry);
> -	hlist_for_each_safe(p, n, (struct hlist_head *)&dentry->d_fsdata)
> +
> +	spin_lock(&dentry->d_lock);
> +	hlist_move_list((struct hlist_head *)&dentry->d_fsdata, &head);
> +	spin_unlock(&dentry->d_lock);
> +
> +	hlist_for_each_safe(p, n, &head)
>  		p9_fid_put(hlist_entry(p, struct p9_fid, dlist));
> -	dentry->d_fsdata = NULL;
>  }

I'm not sure if that works out. So you are moving the list from dentry to a
local variable. But if you look at v9fs_fid_find() [fs/9p/fid.c#123] it reads
dentry->d_fsdata (twice) and holds it as local variable before taking a
lock. So the lock in v9fs_fid_find() should happen earlier, no?

>  
>  static int v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
> 



