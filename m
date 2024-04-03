Return-Path: <stable+bounces-35688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92188896B42
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 12:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33B31C25CF6
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 10:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C36135407;
	Wed,  3 Apr 2024 10:01:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344EA135405
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138476; cv=none; b=NqgBq5JNZ9fRNyGThAOca3I6STdBdT2335ni7FPbJtHMGhfcxF+x6EnS1d7jvTthaveM1xc2gcNAqygN+XOdRjcymeVWwUzgFnHzN8sL+CEvhED3e9BqtOVZg+27JIN1WrrCvnLsRnkMnMhG6VaN20fIRxf9x5ywMdFM4ysVXLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138476; c=relaxed/simple;
	bh=oMAe0qjT6Z7scPW140l5JNmweTYODvrDCntAy+dNQRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VeFN0K8bfd7MQPdgxgOquNTafQyAX04fAXyNjVBwLL4QtEsirQ3VQU2stJye9th0gSlk/fC28imGvpNVUN3LbJHIdPpItWbcU8hziQ37KEHMXCJW7UcksGur+GAX5+KuFOitcJL0QUS3w/p4QggbV7FOTiGER014i1aWw64xSjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V8gDN48J0zXkWk;
	Wed,  3 Apr 2024 17:58:12 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 334AE140F81;
	Wed,  3 Apr 2024 18:01:10 +0800 (CST)
Received: from [10.174.178.156] (10.174.178.156) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 18:01:09 +0800
Message-ID: <9225ff85-1635-da6a-66df-faf957691f35@huawei.com>
Date: Wed, 3 Apr 2024 18:01:08 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/vkms: call drm_atomic_helper_shutdown before
 drm_dev_put()
To: Greg KH <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <airlied@linux.ie>,
	<dri-devel@lists.freedesktop.org>, <xuqiang36@huawei.com>
References: <20240321070752.81405-1-guomengqi3@huawei.com>
 <2024032130-dripping-possum-7528@gregkh>
 <747ff93d-1d05-aabb-0fa2-5a7810f41c85@huawei.com>
 <2024032954-backroom-partition-4647@gregkh>
From: "guomengqi (A)" <guomengqi3@huawei.com>
In-Reply-To: <2024032954-backroom-partition-4647@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)


在 2024/3/29 17:57, Greg KH 写道:
> On Thu, Mar 21, 2024 at 03:55:37PM +0800, guomengqi (A) wrote:
>> 在 2024/3/21 15:39, Greg KH 写道:
>>> On Thu, Mar 21, 2024 at 03:07:52PM +0800, Guo Mengqi wrote:
>>>> commit 73a82b22963d ("drm/atomic: Fix potential use-after-free
>>>> in nonblocking commits") introduced drm_dev_get/put() to
>>>> drm_atomic_helper_shutdown(). And this cause problem in vkms driver exit
>>>> process.
>>>>
>>>> vkms_exit()
>>>>     drm_dev_put()
>>>>       vkms_release()
>>>>         drm_atomic_helper_shutdown()
>>>>           drm_dev_get()
>>>>           drm_dev_put()
>>>>             vkms_release()    ------ null pointer access
>>>>
>>>> Using 4.19 stable x86 image on qemu, below stacktrace can be triggered by
>>>> load and unload vkms.ko.
>>>>
>>>> root:~ # insmod vkms.ko
>>>> [  142.135449] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
>>>> [  142.138713] [drm] Driver supports precise vblank timestamp query.
>>>> [  142.142390] [drm] Initialized vkms 1.0.0 20180514 for virtual device on minor 0
>>>> root:~ # rmmod vkms.ko
>>>> [  144.093710] BUG: unable to handle kernel NULL pointer dereference at 00000000000000a0
>>>> [  144.097491] PGD 800000023624e067 P4D 800000023624e067 PUD 22ab59067 PMD 0
>>>> [  144.100802] Oops: 0000 [#1] SMP PTI
>>>> [  144.102502] CPU: 0 PID: 3615 Comm: rmmod Not tainted 4.19.310 #1
>>>> [  144.104452] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>>>> [  144.107238] RIP: 0010:device_del+0x34/0x3a0
>>>> ...
>>>> [  144.131323] Call Trace:
>>>> [  144.131962]  ? __die+0x7d/0xc0
>>>> [  144.132711]  ? no_context+0x152/0x3b0
>>>> [  144.133605]  ? wake_up_q+0x70/0x70
>>>> [  144.134436]  ? __do_page_fault+0x342/0x4b0
>>>> [  144.135445]  ? __switch_to_asm+0x41/0x70
>>>> [  144.136416]  ? __switch_to_asm+0x35/0x70
>>>> [  144.137366]  ? page_fault+0x1e/0x30
>>>> [  144.138214]  ? __drm_atomic_state_free+0x51/0x60
>>>> [  144.139331]  ? device_del+0x34/0x3a0
>>>> [  144.140197]  platform_device_del.part.14+0x19/0x70
>>>> [  144.141348]  platform_device_unregister+0xe/0x20
>>>> [  144.142458]  vkms_release+0x10/0x30 [vkms]
>>>> [  144.143449]  __drm_atomic_helper_disable_all.constprop.31+0x13b/0x150
>>>> [  144.144980]  drm_atomic_helper_shutdown+0x4b/0x90
>>>> [  144.146102]  vkms_release+0x18/0x30 [vkms]
>>>> [  144.147107]  vkms_exit+0x29/0x8ec [vkms]
>>>> [  144.148053]  __x64_sys_delete_module+0x155/0x220
>>>> [  144.149168]  do_syscall_64+0x43/0x100
>>>> [  144.150056]  entry_SYSCALL_64_after_hwframe+0x5c/0xc1
>>>>
>>>> It seems that the proper unload sequence is:
>>>> 	drm_atomic_helper_shutdown();
>>>> 	drm_dev_put();
>>>>
>>>> Just put drm_atomic_helper_shutdown() before drm_dev_put()
>>>> should solve the problem.
>>>>
>>>> Fixes: 73a82b22963d ("drm/atomic: Fix potential use-after-free in nonblocking commits")
>>>> Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>
>>>> ---
>>>>    drivers/gpu/drm/vkms/vkms_drv.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
>>>> index b1201c18d3eb..d32e08f17427 100644
>>>> --- a/drivers/gpu/drm/vkms/vkms_drv.c
>>>> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
>>>> @@ -39,7 +39,6 @@ static void vkms_release(struct drm_device *dev)
>>>>    	struct vkms_device *vkms = container_of(dev, struct vkms_device, drm);
>>>>    	platform_device_unregister(vkms->platform);
>>>> -	drm_atomic_helper_shutdown(&vkms->drm);
>>>>    	drm_mode_config_cleanup(&vkms->drm);
>>>>    	drm_dev_fini(&vkms->drm);
>>>>    }
>>>> @@ -137,6 +136,7 @@ static void __exit vkms_exit(void)
>>>>    	}
>>>>    	drm_dev_unregister(&vkms_device->drm);
>>>> +	drm_atomic_helper_shutdown(&vkms_device->drm);
>>>>    	drm_dev_put(&vkms_device->drm);
>>>>    	kfree(vkms_device);
>>>> -- 
>>>> 2.17.1
>>>>
>>>>
>>> What is the commit id of this change in Linus's tree?
>> Hi,
>>
>> Do you mean this patch? I only send it to stable tree, mainline does not
>> have this bug.
>>
>> vkms exit code is refactored by 53d77aaa3f76 ("drm/vkms: Use
>> devm_drm_dev_alloc") in tags/v5.10-rc1.
>>
>> So this bug only exists on 4.19 and 5.4.
> Then you need to really really really document that in the changelog,
> and say what kernel tree(s) you want it applied to, AND get the review
> of the maintainers of the subsystem/driver you are wanting this applied
> to.
>
> Please fix up and resend.

Hi Greg,

I resent a new one and put that information both in title and commit 
log. Thanks for your reminder!

> thanks,
>
> greg k-h
> .

