Return-Path: <stable+bounces-15760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6FF83B6C8
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 02:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B35C7B245B8
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 01:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77CB1388;
	Thu, 25 Jan 2024 01:40:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE3C136F
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 01:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706146842; cv=none; b=U5/iGcZ2WFcXtOaB/oMqMsSCxyY049VuaUe45UrI4dsOfk/5TaSqaNi+1UDHFmauLqnWE7xqRPNRfnrUiA9LQud0GWx7OwX687ZRjcYfkDYF4eTo2Q9ve6CkIYw3JMYF+A09QghAoj5ytKxjH8GltfB+la60CoIL49S1uIP7on0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706146842; c=relaxed/simple;
	bh=ol3K7AWv5xNwCGkbp4vFJyKtV7igWG7PEBAWdKRWAx8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ACi/CQwQRq56bpBNenOkrXkkg/EMb3siKg4Zk6LhQ2Wb3OSifFVu5qSi/k59tx+iUI3W3MIW9yUPab47JsQUvo2vyPBJquxCwX5pdVUE8abqROqTQTs+ksm7OozmHmfb28IUumw0A16ENORGkjDhQowBX3QSny/9I53XsDTI4Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TL3R25Gcmz1xm42;
	Thu, 25 Jan 2024 09:39:42 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id CF0CD1407F7;
	Thu, 25 Jan 2024 09:40:20 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 09:40:11 +0800
Subject: Re: [PATCH v2 01/15] ubifs: Set page uptodate in the correct place
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Richard Weinberger
	<richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <stable@vger.kernel.org>
References: <20240124175302.1750912-1-willy@infradead.org>
 <20240124175302.1750912-2-willy@infradead.org>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <f523e709-aebb-eb9a-8a2e-a5229f331062@huawei.com>
Date: Thu, 25 Jan 2024 09:40:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240124175302.1750912-2-willy@infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/1/25 1:52, Matthew Wilcox (Oracle) Ð´µÀ:
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
>   fs/ubifs/file.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

Just one nit below.

> 
> diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
> index 5029eb3390a5..d0694b83dd02 100644
> --- a/fs/ubifs/file.c
> +++ b/fs/ubifs/file.c
> @@ -261,9 +261,6 @@ static int write_begin_slow(struct address_space *mapping,
>   				return err;
>   			}
>   		}
> -
> -		SetPageUptodate(page);
> -		ClearPageError(page);
>   	}
>   
>   	if (PagePrivate(page))
> @@ -463,9 +460,6 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
>   				return err;
>   			}
>   		}
> -
> -		SetPageUptodate(page);
> -		ClearPageError(page);
>   	}
>   
>   	err = allocate_budget(c, page, ui, appending);
> @@ -475,10 +469,8 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
>   		 * If we skipped reading the page because we were going to
>   		 * write all of it, then it is not up to date.

It would be better to update above comments. For example, "If we skipped 
reading the page because we were going to write all of it, then 
PageChecked flag should be removed."

>   		 */
> -		if (skipped_read) {
> +		if (skipped_read)
>   			ClearPageChecked(page);
> -			ClearPageUptodate(page);
> -		}
>   		/*
>   		 * Budgeting failed which means it would have to force
>   		 * write-back but didn't, because we set the @fast flag in the
> @@ -569,6 +561,9 @@ static int ubifs_write_end(struct file *file, struct address_space *mapping,
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


