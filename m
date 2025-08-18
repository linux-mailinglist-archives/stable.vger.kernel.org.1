Return-Path: <stable+bounces-169902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF38B29600
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 03:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0B24E71AC
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 01:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC36D222564;
	Mon, 18 Aug 2025 01:03:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F6521ADCB;
	Mon, 18 Aug 2025 01:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755479028; cv=none; b=U063KWzwQuYU/4Jj0T+eQR/jCT6onGm/yBM+3LA6sPEsEUaZBhDRh/zu7OP6LSwF9f9drOZZt+d1epoSva3Qw6bZyC/M0M4Lr5N3z9121+ClL31PV6qkUPOprkmKXLz9A7FkSPqZwVzCtF49d/8HE+t5Cst3FzYcIxtMgMSosAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755479028; c=relaxed/simple;
	bh=nSnSVf6QpXs+sD99cd4hGE3BAcqpoBVHZAChzt1OAZY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ikR0rp4sjDxCmSbrcBmcoPY0iEFaDAFMNP0ddFOkVTb2aqm29I3L+e0abLrtE85ohJUb4sueJ+3tHzGd1oIz5Y/Z5sQ60bZdDKEyKmPlJEY7MTVMW3SmxrXcD+kJPgpXlhTPkBgTVXG5W1d5OOQNUXmr24dvzQ9ke/lQzBOlSPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c4vc01Sv4zYQtLv;
	Mon, 18 Aug 2025 09:03:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C3F8F1A0359;
	Mon, 18 Aug 2025 09:03:42 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgD3chPre6Jo27kyEA--.13594S3;
	Mon, 18 Aug 2025 09:03:40 +0800 (CST)
Subject: Re: Patch "md: call del_gendisk in control path" has been added to
 the 6.6-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org, xni@redhat.com
Cc: Song Liu <song@kernel.org>, "yukuai (C)" <yukuai3@huawei.com>
References: <20250817141818.2370452-1-sashal@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7748b907-8279-c222-d4e4-b94c3216408b@huaweicloud.com>
Date: Mon, 18 Aug 2025 09:03:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250817141818.2370452-1-sashal@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3chPre6Jo27kyEA--.13594S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GrWrGw18ZrWxur47Gr18uFg_yoWxKw43p3
	yxtFWakrWDJFWftrW7J3Wkua45Zwn7GFWkKryfGa40va4aqrnrWF15WrWqvryDGas3ur4a
	qa18WFs5J340qFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwz
	uWDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/17 22:18, Sasha Levin Ð´µÀ:
> This is a note to let you know that I've just added the patch titled
> 
>      md: call del_gendisk in control path
> 
> to the 6.6-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       md-call-del_gendisk-in-control-path.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
This patch should be be backported to any stable kernel, this change
will break user tools mdadm:

https://lore.kernel.org/all/f654db67-a5a5-114b-09b8-00db303daab7@redhat.com/

Thanks,
Kuai

> 
> commit fa738623105e2dd4865274dc8525856feaec3ae9
> Author: Xiao Ni <xni@redhat.com>
> Date:   Wed Jun 11 15:31:06 2025 +0800
> 
>      md: call del_gendisk in control path
>      
>      [ Upstream commit 9e59d609763f70a992a8f3808dabcce60f14eb5c ]
>      
>      Now del_gendisk and put_disk are called asynchronously in workqueue work.
>      The asynchronous way has a problem that the device node can still exist
>      after mdadm --stop command returns in a short window. So udev rule can
>      open this device node and create the struct mddev in kernel again. So put
>      del_gendisk in control path and still leave put_disk in md_kobj_release
>      to avoid uaf of gendisk.
>      
>      Function del_gendisk can't be called with reconfig_mutex. If it's called
>      with reconfig mutex, a deadlock can happen. del_gendisk waits all sysfs
>      files access to finish and sysfs file access waits reconfig mutex. So
>      put del_gendisk after releasing reconfig mutex.
>      
>      But there is still a window that sysfs can be accessed between mddev_unlock
>      and del_gendisk. So some actions (add disk, change level, .e.g) can happen
>      which lead unexpected results. MD_DELETED is used to resolve this problem.
>      MD_DELETED is set before releasing reconfig mutex and it should be checked
>      for these sysfs access which need reconfig mutex. For sysfs access which
>      don't need reconfig mutex, del_gendisk will wait them to finish.
>      
>      But it doesn't need to do this in function mddev_lock_nointr. There are
>      ten places that call it.
>      * Five of them are in dm raid which we don't need to care. MD_DELETED is
>      only used for md raid.
>      * stop_sync_thread, md_do_sync and md_start_sync are related sync request,
>      and it needs to wait sync thread to finish before stopping an array.
>      * md_ioctl: md_open is called before md_ioctl, so ->openers is added. It
>      will fail to stop the array. So it doesn't need to check MD_DELETED here
>      * md_set_readonly:
>      It needs to call mddev_set_closing_and_sync_blockdev when setting readonly
>      or read_auto. So it will fail to stop the array too because MD_CLOSING is
>      already set.
>      
>      Reviewed-by: Yu Kuai <yukuai3@huawei.com>
>      Signed-off-by: Xiao Ni <xni@redhat.com>
>      Link: https://lore.kernel.org/linux-raid/20250611073108.25463-2-xni@redhat.com
>      Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index b086cbf24086..8e3939c0d2ed 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -639,9 +639,6 @@ static void __mddev_put(struct mddev *mddev)
>   	    mddev->ctime || mddev->hold_active)
>   		return;
>   
> -	/* Array is not configured at all, and not held active, so destroy it */
> -	set_bit(MD_DELETED, &mddev->flags);
> -
>   	/*
>   	 * Call queue_work inside the spinlock so that flush_workqueue() after
>   	 * mddev_find will succeed in waiting for the work to be done.
> @@ -837,6 +834,16 @@ void mddev_unlock(struct mddev *mddev)
>   		kobject_del(&rdev->kobj);
>   		export_rdev(rdev, mddev);
>   	}
> +
> +	/* Call del_gendisk after release reconfig_mutex to avoid
> +	 * deadlock (e.g. call del_gendisk under the lock and an
> +	 * access to sysfs files waits the lock)
> +	 * And MD_DELETED is only used for md raid which is set in
> +	 * do_md_stop. dm raid only uses md_stop to stop. So dm raid
> +	 * doesn't need to check MD_DELETED when getting reconfig lock
> +	 */
> +	if (test_bit(MD_DELETED, &mddev->flags))
> +		del_gendisk(mddev->gendisk);
>   }
>   EXPORT_SYMBOL_GPL(mddev_unlock);
>   
> @@ -5616,19 +5623,30 @@ md_attr_store(struct kobject *kobj, struct attribute *attr,
>   	struct md_sysfs_entry *entry = container_of(attr, struct md_sysfs_entry, attr);
>   	struct mddev *mddev = container_of(kobj, struct mddev, kobj);
>   	ssize_t rv;
> +	struct kernfs_node *kn = NULL;
>   
>   	if (!entry->store)
>   		return -EIO;
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EACCES;
> +
> +	if (entry->store == array_state_store && cmd_match(page, "clear"))
> +		kn = sysfs_break_active_protection(kobj, attr);
> +
>   	spin_lock(&all_mddevs_lock);
>   	if (!mddev_get(mddev)) {
>   		spin_unlock(&all_mddevs_lock);
> +		if (kn)
> +			sysfs_unbreak_active_protection(kn);
>   		return -EBUSY;
>   	}
>   	spin_unlock(&all_mddevs_lock);
>   	rv = entry->store(mddev, page, length);
>   	mddev_put(mddev);
> +
> +	if (kn)
> +		sysfs_unbreak_active_protection(kn);
> +
>   	return rv;
>   }
>   
> @@ -5636,12 +5654,6 @@ static void md_kobj_release(struct kobject *ko)
>   {
>   	struct mddev *mddev = container_of(ko, struct mddev, kobj);
>   
> -	if (mddev->sysfs_state)
> -		sysfs_put(mddev->sysfs_state);
> -	if (mddev->sysfs_level)
> -		sysfs_put(mddev->sysfs_level);
> -
> -	del_gendisk(mddev->gendisk);
>   	put_disk(mddev->gendisk);
>   }
>   
> @@ -6531,8 +6543,9 @@ static int do_md_stop(struct mddev *mddev, int mode,
>   		mddev->bitmap_info.offset = 0;
>   
>   		export_array(mddev);
> -
>   		md_clean(mddev);
> +		set_bit(MD_DELETED, &mddev->flags);
> +
>   		if (mddev->hold_active == UNTIL_STOP)
>   			mddev->hold_active = 0;
>   	}
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 46995558d3bd..0a7c9122db50 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -589,11 +589,26 @@ static inline bool is_md_suspended(struct mddev *mddev)
>   
>   static inline int __must_check mddev_lock(struct mddev *mddev)
>   {
> -	return mutex_lock_interruptible(&mddev->reconfig_mutex);
> +	int ret;
> +
> +	ret = mutex_lock_interruptible(&mddev->reconfig_mutex);
> +
> +	/* MD_DELETED is set in do_md_stop with reconfig_mutex.
> +	 * So check it here.
> +	 */
> +	if (!ret && test_bit(MD_DELETED, &mddev->flags)) {
> +		ret = -ENODEV;
> +		mutex_unlock(&mddev->reconfig_mutex);
> +	}
> +
> +	return ret;
>   }
>   
>   /* Sometimes we need to take the lock in a situation where
>    * failure due to interrupts is not acceptable.
> + * It doesn't need to check MD_DELETED here, the owner which
> + * holds the lock here can't be stopped. And all paths can't
> + * call this function after do_md_stop.
>    */
>   static inline void mddev_lock_nointr(struct mddev *mddev)
>   {
> @@ -602,7 +617,14 @@ static inline void mddev_lock_nointr(struct mddev *mddev)
>   
>   static inline int mddev_trylock(struct mddev *mddev)
>   {
> -	return mutex_trylock(&mddev->reconfig_mutex);
> +	int ret;
> +
> +	ret = mutex_trylock(&mddev->reconfig_mutex);
> +	if (!ret && test_bit(MD_DELETED, &mddev->flags)) {
> +		ret = -ENODEV;
> +		mutex_unlock(&mddev->reconfig_mutex);
> +	}
> +	return ret;
>   }
>   extern void mddev_unlock(struct mddev *mddev);
>   
> .
> 


