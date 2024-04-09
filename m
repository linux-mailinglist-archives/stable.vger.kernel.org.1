Return-Path: <stable+bounces-37833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EB089D072
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 04:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CA7283E84
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 02:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860D353E3B;
	Tue,  9 Apr 2024 02:38:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2DC54645
	for <stable@vger.kernel.org>; Tue,  9 Apr 2024 02:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712630320; cv=none; b=PQd3OD02mDUUQYnKC8emXR+p8qVJcpKGWkhXQTmA4Vlw7CNV5IY+wJ8sMymS6xDFaAFBqsuhB+DXuq6jnNvpigxlkbYhziOzJVstOn5ysp1M/Ny0eW4Cr1wIBdXG5qcAfq+31kEEDfKrxqvpw4LJ1NyuwApuoRKRCJmHGkpxATw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712630320; c=relaxed/simple;
	bh=XcOczAv797AnYlQ64hiIoG8I6LV6xUEmLXFbf4nS6wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XCXTGEcBsxwJ2vIeYfllbOHswcqN639ByIaLmzCfZUZfQ7tzXFk/BtNSeYt1WVTJTFeNDU/H+rDNnB959Tr5pq5s0+zUY+rIEzu5YHBXKPXRQnlQoMN2/OMYGlA/ZiC+YRfVW0COOcFpdqYcTBK9tqOc51FbJlpLuPe2gzhoA3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VD97G3C6pztS5S;
	Tue,  9 Apr 2024 10:35:54 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 23CA4140124;
	Tue,  9 Apr 2024 10:38:36 +0800 (CST)
Received: from [10.174.178.156] (10.174.178.156) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 10:38:35 +0800
Message-ID: <a29f435b-424e-4f9f-36cb-3faf22c4b0b3@huawei.com>
Date: Tue, 9 Apr 2024 10:38:34 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 4.19.y] drm/vkms: call drm_atomic_helper_shutdown before
 drm_dev_put()
To: Greg KH <greg@kroah.com>
CC: <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
	<stable@vger.kernel.org>, <xuqiang36@huawei.com>,
	<zhangchangzhong@huawei.com>
References: <20240403094716.80313-1-guomengqi3@huawei.com>
 <2024040549-pushover-applied-4948@gregkh>
From: "guomengqi (A)" <guomengqi3@huawei.com>
In-Reply-To: <2024040549-pushover-applied-4948@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)


在 2024/4/5 17:30, Greg KH 写道:
> On Wed, Apr 03, 2024 at 05:47:16PM +0800, Guo Mengqi wrote:
>> commit 73a82b22963d ("drm/atomic: Fix potential use-after-free
>> in nonblocking commits") introduced drm_dev_get/put() to
>> drm_atomic_helper_shutdown(). And this cause problem in vkms driver exit
>> process.
>>
>> vkms_exit()
>>    drm_dev_put()
>>      vkms_release()
>>        drm_atomic_helper_shutdown()
>>          drm_dev_get()
>>          drm_dev_put()
>>            vkms_release()    ------ null pointer access
>>
>> Using 4.19 stable x86 image on qemu, below stacktrace can be triggered by
>> load and unload vkms.ko.
>>
>> root:~ # insmod vkms.ko
>> [  142.135449] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
>> [  142.138713] [drm] Driver supports precise vblank timestamp query.
>> [  142.142390] [drm] Initialized vkms 1.0.0 20180514 for virtual device on minor 0
>> root:~ # rmmod vkms.ko
>> [  144.093710] BUG: unable to handle kernel NULL pointer dereference at 00000000000000a0
>> [  144.097491] PGD 800000023624e067 P4D 800000023624e067 PUD 22ab59067 PMD 0
>> [  144.100802] Oops: 0000 [#1] SMP PTI
>> [  144.102502] CPU: 0 PID: 3615 Comm: rmmod Not tainted 4.19.310 #1
>> [  144.104452] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>> [  144.107238] RIP: 0010:device_del+0x34/0x3a0
>> ...
>> [  144.131323] Call Trace:
>> [  144.131962]  ? __die+0x7d/0xc0
>> [  144.132711]  ? no_context+0x152/0x3b0
>> [  144.133605]  ? wake_up_q+0x70/0x70
>> [  144.134436]  ? __do_page_fault+0x342/0x4b0
>> [  144.135445]  ? __switch_to_asm+0x41/0x70
>> [  144.136416]  ? __switch_to_asm+0x35/0x70
>> [  144.137366]  ? page_fault+0x1e/0x30
>> [  144.138214]  ? __drm_atomic_state_free+0x51/0x60
>> [  144.139331]  ? device_del+0x34/0x3a0
>> [  144.140197]  platform_device_del.part.14+0x19/0x70
>> [  144.141348]  platform_device_unregister+0xe/0x20
>> [  144.142458]  vkms_release+0x10/0x30 [vkms]
>> [  144.143449]  __drm_atomic_helper_disable_all.constprop.31+0x13b/0x150
>> [  144.144980]  drm_atomic_helper_shutdown+0x4b/0x90
>> [  144.146102]  vkms_release+0x18/0x30 [vkms]
>> [  144.147107]  vkms_exit+0x29/0x8ec [vkms]
>> [  144.148053]  __x64_sys_delete_module+0x155/0x220
>> [  144.149168]  do_syscall_64+0x43/0x100
>> [  144.150056]  entry_SYSCALL_64_after_hwframe+0x5c/0xc1
>>
>> It seems that the proper unload sequence is:
>> 	drm_atomic_helper_shutdown();
>> 	drm_dev_put();
>>
>> Just put drm_atomic_helper_shutdown() before drm_dev_put()
>> should solve the problem.
>>
>> Note that vkms exit code is refactored by 53d77aaa3f76 ("drm/vkms: Use
>> devm_drm_dev_alloc") in tags/v5.10-rc1.
>>
>> So this bug only exists on 4.19 and 5.4.
> Do we also need this for 5.4?  If so, can you send a version for that
> tree with the correct Fixes: information, and I will be glad to queue
> both of these up.

I sent a patch to 5.4.y too. Please check it at 
https://lore.kernel.org/all/20240409022647.1821-1-guomengqi3@huawei.com/T/#u

Thanks,

Mengqi

> thanks,
>
> greg k-h
> .

