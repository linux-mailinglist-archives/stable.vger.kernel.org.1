Return-Path: <stable+bounces-12345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AC3835B88
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 08:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1387D1C21377
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 07:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CB2F4F9;
	Mon, 22 Jan 2024 07:22:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D812FBE1
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 07:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705908177; cv=none; b=j5cIkp1z0euARyC/iYdalbbiRxSvQo/1VS8rBw/WmWJyfpXSSH4nIwz1jcZI4ayu6Su6I2+0+9s+3EYEVu1zxAw0vM5B9BwzRr7vBr9c/R2rVZR29UVQ+Zki8eT6yGiXp33NALix2JWIk1ebCHzfr8fkKDTyvM0gbtETcoNDhGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705908177; c=relaxed/simple;
	bh=VJsVyFcJ/xA3VDPwk3Ru5P6pSSjID/o3H/MawHoibD4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ougVGdkw9FaHlt25EFUDRPmHPpX+KmEwpD/XZvAKA7VYb0Wpbf5XmgfY4I2x1ebrYTpUsLEg1Fn4YbK6oYqERFtYTvAXWHOhtMelfy9kH9O+Ljc6xVmDj7n6+to51hYLfy9mFwVfQzOykYj5JX6wdaCxZbzLnWISFE1iDkm/mXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TJM963ctRz1Q895;
	Mon, 22 Jan 2024 15:21:46 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 61B11140499;
	Mon, 22 Jan 2024 15:22:46 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 15:22:45 +0800
Subject: Re: [PATCH 01/15] ubifs: Set page uptodate in the correct place
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Richard Weinberger
	<richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <stable@vger.kernel.org>
References: <20240120230824.2619716-1-willy@infradead.org>
 <20240120230824.2619716-2-willy@infradead.org>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <5ad7b6ed-664b-7426-c557-1495711a6100@huawei.com>
Date: Mon, 22 Jan 2024 15:22:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240120230824.2619716-2-willy@infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/1/21 7:08, Matthew Wilcox (Oracle) Ð´µÀ:
> Page cache reads are lockless, so setting the freshly allocated page
> uptodate before we've overwritten it with the data it's supposed to have
> in it will allow a simultaneous reader to see old data.  Move the call
> to SetPageUptodate into ubifs_write_end(), which is after we copied the
> new data into the page.
> 
> Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/ubifs/file.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
> index 5029eb3390a5..40a9b03ef821 100644
> --- a/fs/ubifs/file.c
> +++ b/fs/ubifs/file.c
> @@ -463,9 +463,6 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
>   				return err;
>   			}
>   		}
> -
> -		SetPageUptodate(page);
> -		ClearPageError(page);
>   	}

This solution looks good to me, and I think 'SetPageUptodate' should be 
removed from write_begin_slow(slow path) too.

>   
>   	err = allocate_budget(c, page, ui, appending);
> @@ -569,6 +566,9 @@ static int ubifs_write_end(struct file *file, struct address_space *mapping,
>   		goto out;
>   	}
>   
> +	if (len == PAGE_SIZE)
> +		SetPageUptodate(page);
> +
>   	if (!PagePrivate(page)) {
>   		attach_page_private(page, (void *)1);
>   		atomic_long_inc(&c->dirty_pg_cnt);
> 


