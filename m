Return-Path: <stable+bounces-83624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B01899B9E6
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9D98B20F18
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD14C145A07;
	Sun, 13 Oct 2024 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TBNZmHIy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A0F1EB2E;
	Sun, 13 Oct 2024 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728831895; cv=none; b=WNm2LLF7UZW9IeHKyPOvxOAOz83R19MLlwccXiTx7m7bcuYosMv+1BxPerE0XidPk1G7P8Hc09B8poW++spHUVPvT0kEWQQPonWErD/TN8waZ1ggFJCCbcjYkfLPRkGoN05WFNiXn9NaBpcCaoko+XSkhoRKLxos/xXXgOB5Q2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728831895; c=relaxed/simple;
	bh=ddk/noDLdA2S444fvZDMYial4Y2ZWe8fOBxoub40f7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZACpTLFJuY2X6YhopP9PZEHebN9w8hrpUGqT0PdntuSWv1XanypTfdEJshvcFIKiEvXyOfRHjgQdn5gkLBuQLvwjWBCVhevhosjFROwSQ3614Dhz7eMXIJaxOV+1NDQoOE5L57wLV6zLEwKhzz3rKMbxZt5uGAsHvyDaIahZ5+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TBNZmHIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E4FC4CEC7;
	Sun, 13 Oct 2024 15:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728831895;
	bh=ddk/noDLdA2S444fvZDMYial4Y2ZWe8fOBxoub40f7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TBNZmHIyzqqUYk3NhSPY8/pFGqYlQQd1M+a/p0jDP2Mztfut82lNqp7CR8mLICJ0q
	 GEwOi1HfAXdPfxM70IHXWol4ImfUDazgTWTGKDlXyBQkT8dJaxsdE+z5TBzywtnAO2
	 bnETPHV4cE/sGbi5SfUZN13MS8MSWgBhzUYFI7XU=
Date: Sun, 13 Oct 2024 17:04:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, Rodolfo Giometti <giometti@enneenne.com>,
	George Spelvin <linux@horizon.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] pps: Remove embedded cdev to fix a use-after-free
Message-ID: <2024101350-jinx-haggler-5aca@gregkh>
References: <ZuMvmbf6Ru_pxhWn@mozart.vkv.me>
 <8072cd54b02eaebf16739f07e6307271534e21c7.1726119983.git.calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8072cd54b02eaebf16739f07e6307271534e21c7.1726119983.git.calvin@wbinvd.org>

On Fri, Sep 13, 2024 at 05:24:29PM -0700, Calvin Owens wrote:
> On a board running ntpd and gpsd, I'm seeing a consistent use-after-free
> in sys_exit() from gpsd when rebooting:
> 
>     pps pps1: removed
>     ------------[ cut here ]------------
>     kobject: '(null)' (00000000db4bec24): is not initialized, yet kobject_put() is being called.

Something is wrong with the reference counting here...

>     WARNING: CPU: 2 PID: 440 at lib/kobject.c:734 kobject_put+0x120/0x150
>     CPU: 2 UID: 299 PID: 440 Comm: gpsd Not tainted 6.11.0-rc6-00308-gb31c44928842 #1
>     Hardware name: Raspberry Pi 4 Model B Rev 1.1 (DT)
>     pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>     pc : kobject_put+0x120/0x150
>     lr : kobject_put+0x120/0x150
>     sp : ffffffc0803d3ae0
>     x29: ffffffc0803d3ae0 x28: ffffff8042dc9738 x27: 0000000000000001
>     x26: 0000000000000000 x25: ffffff8042dc9040 x24: ffffff8042dc9440
>     x23: ffffff80402a4620 x22: ffffff8042ef4bd0 x21: ffffff80405cb600
>     x20: 000000000008001b x19: ffffff8040b3b6e0 x18: 0000000000000000
>     x17: 0000000000000000 x16: 0000000000000000 x15: 696e6920746f6e20
>     x14: 7369203a29343263 x13: 205d303434542020 x12: 0000000000000000
>     x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
>     x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
>     x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
>     x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
>     Call trace:
>      kobject_put+0x120/0x150
>      cdev_put+0x20/0x3c
>      __fput+0x2c4/0x2d8
>      ____fput+0x1c/0x38
>      task_work_run+0x70/0xfc
>      do_exit+0x2a0/0x924
>      do_group_exit+0x34/0x90
>      get_signal+0x7fc/0x8c0
>      do_signal+0x128/0x13b4
>      do_notify_resume+0xdc/0x160
>      el0_svc+0xd4/0xf8
>      el0t_64_sync_handler+0x140/0x14c
>      el0t_64_sync+0x190/0x194
>     ---[ end trace 0000000000000000 ]---
> 
> ...followed by more symptoms of corruption, with similar stacks:
> 
>     refcount_t: underflow; use-after-free.
>     kernel BUG at lib/list_debug.c:62!
>     Kernel panic - not syncing: Oops - BUG: Fatal exception
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

You remove it, but now the structure has no reference counting at all,
so you should make it a real "struct device" not just containing a
pointer to one.

> But now that pps_idr defines userspace visibility instead of cdev_add(),
> we need to be sure the pps->dev kobject refcount can't reach zero while
> userspace can still find it again. So, the idr_remove() call moves to
> pps_unregister_cdev(), and pps_idr now holds a reference to the pps->dev
> kobject.

An idr shouldn't be doing the reference counting here, the struct device
should be doing it, right?


> 
>     pps_core: source serial1 got cdev (251:1)
>     <...>
>     pps pps1: removed
>     pps_core: unregistering pps1
>     pps_core: deallocating pps1
> 
> Fixes: d953e0e837e6 ("pps: Fix a use-after free bug when unregistering a source.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
> Changes in v2:
> - Don't move pr_debug() from pps_device_destruct() to pps_unregister_cdev()
> - Actually add stable@vger.kernel.org to CC
> ---
>  drivers/pps/pps.c          | 83 ++++++++++++++++++++------------------
>  include/linux/pps_kernel.h |  1 -
>  2 files changed, 44 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> index 5d19baae6a38..6980ab17f314 100644
> --- a/drivers/pps/pps.c
> +++ b/drivers/pps/pps.c
> @@ -25,7 +25,7 @@
>   * Local variables
>   */
>  
> -static dev_t pps_devt;
> +static int pps_major;
>  static struct class *pps_class;
>  
>  static DEFINE_MUTEX(pps_idr_lock);
> @@ -296,19 +296,35 @@ static long pps_cdev_compat_ioctl(struct file *file,
>  #define pps_cdev_compat_ioctl	NULL
>  #endif
>  
> +static struct pps_device *pps_idr_get(unsigned long id)
> +{
> +	struct pps_device *pps;
> +
> +	mutex_lock(&pps_idr_lock);
> +	pps = idr_find(&pps_idr, id);
> +	if (pps)
> +		kobject_get(&pps->dev->kobj);

A driver should never call "raw" kobject calls, this alone makes this
not ok :(

Please move the structure to be embedded in and then it should be
simpler.

thanks,

greg k-h

