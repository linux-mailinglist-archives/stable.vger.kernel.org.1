Return-Path: <stable+bounces-76190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9D3979CA3
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 10:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8B11F22D77
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 08:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A24F13B584;
	Mon, 16 Sep 2024 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="mdNvCgJp"
X-Original-To: stable@vger.kernel.org
Received: from smtpcmd03116.aruba.it (smtpcmd03116.aruba.it [62.149.158.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6BD13AA5F
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726474765; cv=none; b=IbZfCikOK81thzbiULoXsV4DebLfm+TGyc2GFB+KVpkzAs46YmE6mK73n6qQLv1Yy/hdfxgrubo3EAolBIAhnePVwsKREY59EjpmQntDZiFNCfvFO92yfMcA6sMLjLtfQRaAowPkvNeDd5h6JURTilnVM77Dbr/phhzkhP5IoyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726474765; c=relaxed/simple;
	bh=zPER2DFSHvBQwzcjfVJE4mnEo9K7DmY5BCXlq+o6vGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpMEL0Wrj269nD0TkpeFXa2HAxaCgEzVxfKzdc5k24OXRlgki9AC1woM6PNlM5PkEDjcS81HF3b8dXsRa0ZO5APqZC+t1fAq9s42Zt6KbnCjluiPZDQ9j+Z0L8qWX36tkMSAX8cW85OH4hDHtCd3F0YqmPCjrC00iIQmq1K5148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=mdNvCgJp; arc=none smtp.client-ip=62.149.158.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.57] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id q6u3sJFccwiwkq6u3sxGKb; Mon, 16 Sep 2024 10:16:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1726474572; bh=zPER2DFSHvBQwzcjfVJE4mnEo9K7DmY5BCXlq+o6vGY=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=mdNvCgJpRvi1VrUEUUC0WsvWhYEb1MiMJ4baZlUQw1VewkZdnuOYeDBJ96ytbavSd
	 29Eh9LlfDVCg10k+LH9EdShZFLL6LOMW8OttAn9pBxP51zK6g6AqvR4FcfGc6X1BX+
	 NOqSvMXMHkIjThDSPnbUleW697pcCyhakpC+NyRJYut8eMOAw6IHg/HCwVxWCkBH+B
	 aM9KAB3+O4XCX3Xh9fwa+DQka+OUXTxSr/DqNoT68lmYHgdQDW/SpRaaN/EpyBiyuL
	 d8gp+xpSbAF0SzDO2GReS/92GtYOd8o0SGiz4HBRLqsIff7j8d3kVYfIIt2OCMdF0L
	 B2g7/hvhLi+hg==
Message-ID: <fc5fe55c-422d-4e63-a5bd-8b6b2d3e6c62@enneenne.com>
Date: Mon, 16 Sep 2024 10:16:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pps: Remove embedded cdev to fix a use-after-free
To: Calvin Owens <calvin@wbinvd.org>, linux-kernel@vger.kernel.org
Cc: George Spelvin <linux@horizon.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
References: <ZuMvmbf6Ru_pxhWn@mozart.vkv.me>
 <8072cd54b02eaebf16739f07e6307271534e21c7.1726119983.git.calvin@wbinvd.org>
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <8072cd54b02eaebf16739f07e6307271534e21c7.1726119983.git.calvin@wbinvd.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIizyv5xYKUvmxytyvfyFC556iQhAsrbq3g4mNMWKCJKZR4e8tSRkEYLAws/qXgVl1D/tMr6rp0mBDIn8Fi7dN2y4yrGf783GAMC+TIyu5M+rYyZsBZe
 u6PJcOx7zIZkTtl8Pyxf4TS9QsEYdprZ3HX0mT6rKwjCp80zQA83Djv8cSU4BB+wFqzq3cuIJdA+OAfTCRsRRCZk52yequyGTzS463cIZc4m2KPVICXFMg9c
 nNyDRJWzZ5jbUIxLBcS05Hmw9l1PEkNmw9wG+RyBuEuVYRqtq7ahgUllr34U2CLDmmg28DlbOQjusID2BPgQ+ZQuQXwFAPDiMinv2+GeiNwOX5sR/Q5oxIW9
 lnBqrz5HL1UeXLf0Pcp9aJ8lzle4qw==

On 14/09/24 02:24, Calvin Owens wrote:
> On a board running ntpd and gpsd, I'm seeing a consistent use-after-free
> in sys_exit() from gpsd when rebooting:
> 
>      pps pps1: removed
>      ------------[ cut here ]------------
>      kobject: '(null)' (00000000db4bec24): is not initialized, yet kobject_put() is being called.
>      WARNING: CPU: 2 PID: 440 at lib/kobject.c:734 kobject_put+0x120/0x150
>      CPU: 2 UID: 299 PID: 440 Comm: gpsd Not tainted 6.11.0-rc6-00308-gb31c44928842 #1
>      Hardware name: Raspberry Pi 4 Model B Rev 1.1 (DT)
>      pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>      pc : kobject_put+0x120/0x150
>      lr : kobject_put+0x120/0x150
>      sp : ffffffc0803d3ae0
>      x29: ffffffc0803d3ae0 x28: ffffff8042dc9738 x27: 0000000000000001
>      x26: 0000000000000000 x25: ffffff8042dc9040 x24: ffffff8042dc9440
>      x23: ffffff80402a4620 x22: ffffff8042ef4bd0 x21: ffffff80405cb600
>      x20: 000000000008001b x19: ffffff8040b3b6e0 x18: 0000000000000000
>      x17: 0000000000000000 x16: 0000000000000000 x15: 696e6920746f6e20
>      x14: 7369203a29343263 x13: 205d303434542020 x12: 0000000000000000
>      x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
>      x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
>      x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
>      x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
>      Call trace:
>       kobject_put+0x120/0x150
>       cdev_put+0x20/0x3c
>       __fput+0x2c4/0x2d8
>       ____fput+0x1c/0x38
>       task_work_run+0x70/0xfc
>       do_exit+0x2a0/0x924
>       do_group_exit+0x34/0x90
>       get_signal+0x7fc/0x8c0
>       do_signal+0x128/0x13b4
>       do_notify_resume+0xdc/0x160
>       el0_svc+0xd4/0xf8
>       el0t_64_sync_handler+0x140/0x14c
>       el0t_64_sync+0x190/0x194
>      ---[ end trace 0000000000000000 ]---
> 
> ...followed by more symptoms of corruption, with similar stacks:
> 
>      refcount_t: underflow; use-after-free.
>      kernel BUG at lib/list_debug.c:62!
>      Kernel panic - not syncing: Oops - BUG: Fatal exception
> 
> This happens because pps_device_destruct() frees the pps_device with the
> embedded cdev immediately after calling cdev_del(), but, as the comment
> above cdev_del() notes, fops for previously opened cdevs are still
> callable even after cdev_del() returns. I think this bug has always
> been there: I can't explain why it suddenly started happening every time
> I reboot this particular board.
> 
> In commit d953e0e837e6 ("pps: Fix a use-after free bug when
> unregistering a source."), George Spelvin suggested removing the
> embedded cdev. That seems like the simplest way to fix this, so I've
> implemented his suggestion, with pps_idr becoming the source of truth
> for which minor corresponds to which device.
> 
> But now that pps_idr defines userspace visibility instead of cdev_add(),
> we need to be sure the pps->dev kobject refcount can't reach zero while
> userspace can still find it again. So, the idr_remove() call moves to
> pps_unregister_cdev(), and pps_idr now holds a reference to the pps->dev
> kobject.
> 
>      pps_core: source serial1 got cdev (251:1)
>      <...>
>      pps pps1: removed
>      pps_core: unregistering pps1
>      pps_core: deallocating pps1
> 
> Fixes: d953e0e837e6 ("pps: Fix a use-after free bug when unregistering a source.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
> Changes in v2:
> - Don't move pr_debug() from pps_device_destruct() to pps_unregister_cdev()
> - Actually add stable@vger.kernel.org to CC
> ---
>   drivers/pps/pps.c          | 83 ++++++++++++++++++++------------------
>   include/linux/pps_kernel.h |  1 -
>   2 files changed, 44 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> index 5d19baae6a38..6980ab17f314 100644
> --- a/drivers/pps/pps.c
> +++ b/drivers/pps/pps.c
> @@ -25,7 +25,7 @@
>    * Local variables
>    */
>   
> -static dev_t pps_devt;
> +static int pps_major;
>   static struct class *pps_class;
>   
>   static DEFINE_MUTEX(pps_idr_lock);
> @@ -296,19 +296,35 @@ static long pps_cdev_compat_ioctl(struct file *file,
>   #define pps_cdev_compat_ioctl	NULL
>   #endif
>   
> +static struct pps_device *pps_idr_get(unsigned long id)
> +{
> +	struct pps_device *pps;
> +
> +	mutex_lock(&pps_idr_lock);
> +	pps = idr_find(&pps_idr, id);
> +	if (pps)
> +		kobject_get(&pps->dev->kobj);
> +
> +	mutex_unlock(&pps_idr_lock);
> +	return pps;
> +}
> +
>   static int pps_cdev_open(struct inode *inode, struct file *file)
>   {
> -	struct pps_device *pps = container_of(inode->i_cdev,
> -						struct pps_device, cdev);
> +	struct pps_device *pps = pps_idr_get(iminor(inode));
> +
> +	if (!pps)
> +		return -ENODEV;
> +
>   	file->private_data = pps;
> -	kobject_get(&pps->dev->kobj);
>   	return 0;
>   }
>   
>   static int pps_cdev_release(struct inode *inode, struct file *file)
>   {
> -	struct pps_device *pps = container_of(inode->i_cdev,
> -						struct pps_device, cdev);
> +	struct pps_device *pps = file->private_data;
> +
> +	WARN_ON(pps->id != iminor(inode));
>   	kobject_put(&pps->dev->kobj);
>   	return 0;
>   }
> @@ -332,14 +348,7 @@ static void pps_device_destruct(struct device *dev)
>   {
>   	struct pps_device *pps = dev_get_drvdata(dev);
>   
> -	cdev_del(&pps->cdev);
> -
> -	/* Now we can release the ID for re-use */
>   	pr_debug("deallocating pps%d\n", pps->id);
> -	mutex_lock(&pps_idr_lock);
> -	idr_remove(&pps_idr, pps->id);
> -	mutex_unlock(&pps_idr_lock);
> -
>   	kfree(dev);
>   	kfree(pps);
>   }
> @@ -364,39 +373,26 @@ int pps_register_cdev(struct pps_device *pps)
>   		goto out_unlock;
>   	}
>   	pps->id = err;
> -	mutex_unlock(&pps_idr_lock);
>   
> -	devt = MKDEV(MAJOR(pps_devt), pps->id);
> -
> -	cdev_init(&pps->cdev, &pps_cdev_fops);
> -	pps->cdev.owner = pps->info.owner;
> -
> -	err = cdev_add(&pps->cdev, devt, 1);
> -	if (err) {
> -		pr_err("%s: failed to add char device %d:%d\n",
> -				pps->info.name, MAJOR(pps_devt), pps->id);
> -		goto free_idr;
> -	}
> +	devt = MKDEV(pps_major, pps->id);
>   	pps->dev = device_create(pps_class, pps->info.dev, devt, pps,
>   							"pps%d", pps->id);
>   	if (IS_ERR(pps->dev)) {
>   		err = PTR_ERR(pps->dev);
> -		goto del_cdev;
> +		goto free_idr;
>   	}
>   
>   	/* Override the release function with our own */
>   	pps->dev->release = pps_device_destruct;
>   
> -	pr_debug("source %s got cdev (%d:%d)\n", pps->info.name,
> -			MAJOR(pps_devt), pps->id);
> +	pr_debug("source %s got cdev (%d:%d)\n", pps->info.name, pps_major,
> +		 pps->id);
>   
> +	kobject_get(&pps->dev->kobj);
> +	mutex_unlock(&pps_idr_lock);
>   	return 0;
>   
> -del_cdev:
> -	cdev_del(&pps->cdev);
> -
>   free_idr:
> -	mutex_lock(&pps_idr_lock);
>   	idr_remove(&pps_idr, pps->id);
>   out_unlock:
>   	mutex_unlock(&pps_idr_lock);
> @@ -408,6 +404,12 @@ void pps_unregister_cdev(struct pps_device *pps)
>   	pr_debug("unregistering pps%d\n", pps->id);
>   	pps->lookup_cookie = NULL;
>   	device_destroy(pps_class, pps->dev->devt);
> +
> +	/* Now we can release the ID for re-use */
> +	mutex_lock(&pps_idr_lock);
> +	idr_remove(&pps_idr, pps->id);
> +	kobject_put(&pps->dev->kobj);
> +	mutex_unlock(&pps_idr_lock);
>   }
>   
>   /*
> @@ -427,6 +429,11 @@ void pps_unregister_cdev(struct pps_device *pps)
>    * so that it will not be used again, even if the pps device cannot
>    * be removed from the idr due to pending references holding the minor
>    * number in use.
> + *
> + * Since pps_idr holds a reference to the kobject, the returned
> + * pps_device is guaranteed to be valid until pps_unregister_cdev() is
> + * called on it. But after calling pps_unregister_cdev(), it may be
> + * freed at any time.
>    */
>   struct pps_device *pps_lookup_dev(void const *cookie)
>   {
> @@ -449,13 +456,11 @@ EXPORT_SYMBOL(pps_lookup_dev);
>   static void __exit pps_exit(void)
>   {
>   	class_destroy(pps_class);
> -	unregister_chrdev_region(pps_devt, PPS_MAX_SOURCES);
> +	__unregister_chrdev(pps_major, 0, PPS_MAX_SOURCES, "pps");
>   }
>   
>   static int __init pps_init(void)
>   {
> -	int err;
> -
>   	pps_class = class_create("pps");
>   	if (IS_ERR(pps_class)) {
>   		pr_err("failed to allocate class\n");
> @@ -463,8 +468,9 @@ static int __init pps_init(void)
>   	}
>   	pps_class->dev_groups = pps_groups;
>   
> -	err = alloc_chrdev_region(&pps_devt, 0, PPS_MAX_SOURCES, "pps");
> -	if (err < 0) {
> +	pps_major = __register_chrdev(0, 0, PPS_MAX_SOURCES, "pps",
> +				      &pps_cdev_fops);
> +	if (pps_major < 0) {
>   		pr_err("failed to allocate char device region\n");
>   		goto remove_class;
>   	}
> @@ -477,8 +483,7 @@ static int __init pps_init(void)
>   
>   remove_class:
>   	class_destroy(pps_class);
> -
> -	return err;
> +	return pps_major;
>   }
>   
>   subsys_initcall(pps_init);
> diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
> index 78c8ac4951b5..8ee312788118 100644
> --- a/include/linux/pps_kernel.h
> +++ b/include/linux/pps_kernel.h
> @@ -56,7 +56,6 @@ struct pps_device {
>   
>   	unsigned int id;			/* PPS source unique ID */
>   	void const *lookup_cookie;		/* For pps_lookup_dev() only */
> -	struct cdev cdev;
>   	struct device *dev;
>   	struct fasync_struct *async_queue;	/* fasync method */
>   	spinlock_t lock;

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


