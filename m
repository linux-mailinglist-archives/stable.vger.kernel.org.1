Return-Path: <stable+bounces-56195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D41C91D5BE
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 03:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7E59B20BEE
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 01:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA2D4C69;
	Mon,  1 Jul 2024 01:22:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3460443D;
	Mon,  1 Jul 2024 01:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719796965; cv=none; b=WA0QPz+zHqYtMSwTCSlr7VixK7cFe3KD1tuk2VV2WuXXr2jOzM/a60krECceVIGyPIX96IPNI8ZpIMY3iXd88tPzwefofgWkXSwq5LAR2lYHhqDIIC08fXQSE9ARkQqc0in6ii2yohpsz5s0CIYWOcVWs15kflsJm78C7BPh8SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719796965; c=relaxed/simple;
	bh=BbvI6az2RXEWoTEPgaHKUUzEWgjQ1JB1owm69hYFGrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFT36I2RihJzVABwbhod0sLesoplo8A99nFmJrqp6FFfaWaLT/JSQTwBxKdNv3g5ujASr1PD/MCflw3uCs+kodaAWCgEcp+yP2KYZeDa/mlkocFIIVrszosutxe7EKEeVxJbR1QIUJ2+RfMMhqmvgVQ+jvNM02CUk5DQX4DbDwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WC7Z62Kzqz4f3jsP;
	Mon,  1 Jul 2024 09:22:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 67CBB1A058E;
	Mon,  1 Jul 2024 09:22:33 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgCnD4XVBIJmbvFMAw--.37232S3;
	Mon, 01 Jul 2024 09:22:31 +0800 (CST)
Message-ID: <3b0a2464-115f-b588-ca14-bbd74d7eb761@huaweicloud.com>
Date: Mon, 1 Jul 2024 09:22:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Patch "md: Fix overflow in is_mddev_idle" has been added to the
 6.9-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
 Jens Axboe <axboe@kernel.dk>, "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <20240630022346.2608108-1-sashal@kernel.org>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <20240630022346.2608108-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCnD4XVBIJmbvFMAw--.37232S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy5Ww13GF13Ww13Xry5Jwb_yoWrWry5pF
	WkJFyYkrW8Xr48uwnrA3yUCa4Fg34xt39xKrWIk34xXF12g3Z3WFs7WFyYq3WkurW8uFW2
	q3WqgFZ0yaykXrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l
	5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67
	AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07Al
	zVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUFf
	HjUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/


在 2024/6/30 10:23, Sasha Levin 写道:
> This is a note to let you know that I've just added the patch titled
> 
>      md: Fix overflow in is_mddev_idle
> 
> to the 6.9-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       md-fix-overflow-in-is_mddev_idle.patch
> and it can be found in the queue-6.9 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 

This patch is reverted by 504fbcffea649cad69111e7597081dd8adc3b395. It
should not be added to the stable tree.

> 
> commit 4a45a13010724614f33c9096cee4a1ee19955aa0
> Author: Li Nan <linan122@huawei.com>
> Date:   Wed Jan 17 11:19:45 2024 +0800
> 
>      md: Fix overflow in is_mddev_idle
>      
>      [ Upstream commit 3f9f231236ce7e48780d8a4f1f8cb9fae2df1e4e ]
>      
>      UBSAN reports this problem:
>      
>        UBSAN: Undefined behaviour in drivers/md/md.c:8175:15
>        signed integer overflow:
>        -2147483291 - 2072033152 cannot be represented in type 'int'
>        Call trace:
>         dump_backtrace+0x0/0x310
>         show_stack+0x28/0x38
>         dump_stack+0xec/0x15c
>         ubsan_epilogue+0x18/0x84
>         handle_overflow+0x14c/0x19c
>         __ubsan_handle_sub_overflow+0x34/0x44
>         is_mddev_idle+0x338/0x3d8
>         md_do_sync+0x1bb8/0x1cf8
>         md_thread+0x220/0x288
>         kthread+0x1d8/0x1e0
>         ret_from_fork+0x10/0x18
>      
>      'curr_events' will overflow when stat accum or 'sync_io' is greater than
>      INT_MAX.
>      
>      Fix it by changing sync_io, last_events and curr_events to 64bit.
>      
>      Signed-off-by: Li Nan <linan122@huawei.com>
>      Reviewed-by: Yu Kuai <yukuai3@huawei.com>
>      Link: https://lore.kernel.org/r/20240117031946.2324519-2-linan666@huaweicloud.com
>      Signed-off-by: Song Liu <song@kernel.org>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index e575e74aabf5e..c88b50a4be82f 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8576,14 +8576,15 @@ static int is_mddev_idle(struct mddev *mddev, int init)
>   {
>   	struct md_rdev *rdev;
>   	int idle;
> -	int curr_events;
> +	long long curr_events;
>   
>   	idle = 1;
>   	rcu_read_lock();
>   	rdev_for_each_rcu(rdev, mddev) {
>   		struct gendisk *disk = rdev->bdev->bd_disk;
> -		curr_events = (int)part_stat_read_accum(disk->part0, sectors) -
> -			      atomic_read(&disk->sync_io);
> +		curr_events =
> +			(long long)part_stat_read_accum(disk->part0, sectors) -
> +			atomic64_read(&disk->sync_io);
>   		/* sync IO will cause sync_io to increase before the disk_stats
>   		 * as sync_io is counted when a request starts, and
>   		 * disk_stats is counted when it completes.
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 097d9dbd69b83..d0db98c0d33be 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -51,7 +51,7 @@ struct md_rdev {
>   
>   	sector_t sectors;		/* Device size (in 512bytes sectors) */
>   	struct mddev *mddev;		/* RAID array if running */
> -	int last_events;		/* IO event timestamp */
> +	long long last_events;		/* IO event timestamp */
>   
>   	/*
>   	 * If meta_bdev is non-NULL, it means that a separate device is
> @@ -621,7 +621,7 @@ extern void mddev_unlock(struct mddev *mddev);
>   
>   static inline void md_sync_acct(struct block_device *bdev, unsigned long nr_sectors)
>   {
> -	atomic_add(nr_sectors, &bdev->bd_disk->sync_io);
> +	atomic64_add(nr_sectors, &bdev->bd_disk->sync_io);
>   }
>   
>   static inline void md_sync_acct_bio(struct bio *bio, unsigned long nr_sectors)
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 00e62b81a7363..a28cccd15f753 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -174,7 +174,7 @@ struct gendisk {
>   	struct list_head slave_bdevs;
>   #endif
>   	struct timer_rand_state *random;
> -	atomic_t sync_io;		/* RAID */
> +	atomic64_t sync_io;		/* RAID */
>   	struct disk_events *ev;
>   
>   #ifdef CONFIG_BLK_DEV_ZONED
> .

-- 
Thanks,
Nan


