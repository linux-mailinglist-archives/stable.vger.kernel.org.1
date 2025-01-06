Return-Path: <stable+bounces-106780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 816CDA01F22
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 07:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66400162F19
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 06:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216531D5140;
	Mon,  6 Jan 2025 06:12:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783F818E373;
	Mon,  6 Jan 2025 06:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736143959; cv=none; b=uhqL1NRIE2GQjAF8jKInU2asxurEhPBubmzGLuGNaSJ5Gm+y3b4a6rgoCxMHJZyuU+1ipOffzIyheSjY5ZumgjyLjCdvDmhE7jyHCsTPkR60uDRiWwSfpeM5ICgLPy/hOKz+hJG4gFCCPm5YIAy3tb+Xhm+EBeJPNtz1lISDvBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736143959; c=relaxed/simple;
	bh=e6Ak4qiCnKRc2WX5YQdF9LD/btZ+poT99yq8H/yeEcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Nu1oypBVgy0MmhE4mJJFZCA8Cmnj4dMetdkrww4IEDrFYgts3VZYz8367b4YHSzi94a5HurXWlj6//FsurZ2h9P1a/zDfRenMQUkNvFGEgArkhIS/IUSlN6dgq+fKOwvQDEDr4EUSiYnD4LJV0PiFGIIZCscXvRKTbQ8VuJ2EHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4YRP123LY5zRkxQ;
	Mon,  6 Jan 2025 14:10:14 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CFC31401F1;
	Mon,  6 Jan 2025 14:12:27 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 6 Jan 2025 14:12:26 +0800
Message-ID: <026f56f6-f299-4cd8-b430-042755cb0141@huawei.com>
Date: Mon, 6 Jan 2025 14:12:25 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hugetlb: fix NULL pointer dereference in
 trace_hugetlbfs_alloc_inode
To: Muchun Song <songmuchun@bytedance.com>, <muchun.song@linux.dev>,
	<brauner@kernel.org>, <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Cheung Wall <zzqq0103.hey@gmail.com>
References: <20250106033118.4640-1-songmuchun@bytedance.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250106033118.4640-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemo500009.china.huawei.com (7.202.194.199)



On 2025/1/6 11:31, Muchun Song wrote:
> hugetlb_file_setup() will pass a NULL @dir to hugetlbfs_get_inode(), so
> we will access a NULL pointer for @dir. Fix it and set __entry->dr to
> 0 if @dir is NULL. Because ->i_ino cannot be 0 (see get_next_ino()),
> there is no confusing if user sees a 0 inode number.
> 

Thanks for fixing!

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

> Fixes: 318580ad7f28 ("hugetlbfs: support tracepoint")
> Cc: stable@vger.kernel.org
> Reported-by: Cheung Wall <zzqq0103.hey@gmail.com>
> Closes: https://lore.kernel.org/linux-mm/02858D60-43C1-4863-A84F-3C76A8AF1F15@linux.dev/T/#
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   include/trace/events/hugetlbfs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/hugetlbfs.h b/include/trace/events/hugetlbfs.h
> index 8331c904a9ba8..59605dfaeeb43 100644
> --- a/include/trace/events/hugetlbfs.h
> +++ b/include/trace/events/hugetlbfs.h
> @@ -23,7 +23,7 @@ TRACE_EVENT(hugetlbfs_alloc_inode,
>   	TP_fast_assign(
>   		__entry->dev		= inode->i_sb->s_dev;
>   		__entry->ino		= inode->i_ino;
> -		__entry->dir		= dir->i_ino;
> +		__entry->dir		= dir ? dir->i_ino : 0;
>   		__entry->mode		= mode;
>   	),
>   

