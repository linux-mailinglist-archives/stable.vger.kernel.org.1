Return-Path: <stable+bounces-83410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8A79999C0
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 03:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533C31F23609
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 01:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0474BEAF1;
	Fri, 11 Oct 2024 01:44:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDB710A1F;
	Fri, 11 Oct 2024 01:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728611089; cv=none; b=OSIiNACDW2SuskW3V2RavMprohwpJxzd7uDtVy0PdyyWGHMBdIZW1+Wr/C47qe2utVW9fVO/j7jWO0JXQjuyMI1Z6YeU2mwT/HZNOxbXV+4ajLV3WmyR80i94y6xBk6haVaBvuON/78pkiSOf6Blq7DI4gkJWN+B6vgPJx1xD0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728611089; c=relaxed/simple;
	bh=1IHF78Qg/Jqh5g7EOdkp0OXt20OXNcmPpSjGhPNYfsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pTLgm3a/4bbijInvPxoAgf3wEY4xbFDLco/Cr91VQTcCKgJp/fJgrSn/FwMcf/KjkSXswECEjdZZkYwSdWyBAtNP45woQQ/ASKZzJ+u+HFIrBsZ7tMlI6s8Racl/3D7rbu6zUHwn9zZOE27W/R73BXZRr5arAC8dGZQviJS+Xe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XPqCX0k7Xz1j9g5;
	Fri, 11 Oct 2024 09:43:36 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id 43C5A140123;
	Fri, 11 Oct 2024 09:44:43 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpeml100021.china.huawei.com
 (7.185.36.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Oct
 2024 09:44:42 +0800
Message-ID: <886a1275-814d-4be9-9339-5118c7dc2819@huawei.com>
Date: Fri, 11 Oct 2024 09:44:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "Revert "mm/filemap: avoid buffered read/write race to read
 inconsistent data"" has been added to the 6.6-stable tree
To: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Yang Erkun
	<yangerkun@huawei.com>
References: <20241011001701.1645057-1-sashal@kernel.org>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20241011001701.1645057-1-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml100021.china.huawei.com (7.185.36.148)

On 2024/10/11 8:17, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>
>      Revert "mm/filemap: avoid buffered read/write race to read inconsistent data"
>
> to the 6.6-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>       revert-mm-filemap-avoid-buffered-read-write-race-to-.patch
> and it can be found in the queue-6.6 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
Hi Sasha,

The current patch is a cleanup after adding
smp_load_acquire/store_release() to i_size_read/write().

In my opinion stable versions continue to use smp_rmb just fine,
no need to backport the current patch to stable.

In addition, the current patch belongs to a patch set:

  https://lore.kernel.org/all/20240124142857.4146716-1-libaokun1@huawei.com/

If the current patch does need to be backported to stable, then the
entire patch set needs to be backported or problems will be introduced.

All the patches in the patch set are listed below:

  d8f899d13d72 ("fs: make the i_size_read/write helpers be 
smp_load_acquire/store_release()")
  4b944f8ef996 ("Revert "mm/filemap: avoid buffered read/write race to 
read inconsistent data"")
  ad72872eb3ae ("asm-generic: remove extra type checking in 
acquire/release for non-SMP case")

Thanks,
Baokun
>
> commit d87bcb0965636a9b665231560ce147d06a7a18d8
> Author: Baokun Li <libaokun1@huawei.com>
> Date:   Wed Jan 24 22:28:56 2024 +0800
>
>      Revert "mm/filemap: avoid buffered read/write race to read inconsistent data"
>      
>      [ Upstream commit 4b944f8ef99641d5af287c7d9df91d20ef5d3e88 ]
>      
>      This reverts commit e2c27b803bb6 ("mm/filemap: avoid buffered read/write
>      race to read inconsistent data"). After making the i_size_read/write
>      helpers be smp_load_acquire/store_release(), it is already guaranteed that
>      changes to page contents are visible before we see increased inode size,
>      so the extra smp_rmb() in filemap_read() can be removed.
>      
>      Signed-off-by: Baokun Li <libaokun1@huawei.com>
>      Link: https://lore.kernel.org/r/20240124142857.4146716-3-libaokun1@huawei.com
>      Signed-off-by: Christian Brauner <brauner@kernel.org>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index e6c112f3a211f..cd028f3be6026 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2694,15 +2694,6 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>   			goto put_folios;
>   		end_offset = min_t(loff_t, isize, iocb->ki_pos + iter->count);
>   
> -		/*
> -		 * Pairs with a barrier in
> -		 * block_write_end()->mark_buffer_dirty() or other page
> -		 * dirtying routines like iomap_write_end() to ensure
> -		 * changes to page contents are visible before we see
> -		 * increased inode size.
> -		 */
> -		smp_rmb();
> -
>   		/*
>   		 * Once we start copying data, we don't want to be touching any
>   		 * cachelines that might be contended:



