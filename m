Return-Path: <stable+bounces-89720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D089BBAA1
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 17:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8CEF1F2243A
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 16:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24721C232D;
	Mon,  4 Nov 2024 16:54:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA111C07EA;
	Mon,  4 Nov 2024 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.160.28.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739283; cv=none; b=tc4fvTeI2h97+rHMUXmUZ0bexAxTKYIJDyy6NruYTwZH1P/scWVFAt90kXwXuu4kKsaQxpukHkU34JJddMOqRkQssFPbXRopz+xrZjoIid/AzzCh6I3JqDeUAyRI5OdaYzNbvHPzc8OB9Qkj0f7LpQG6QeDHDkM9krvvdNpir9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739283; c=relaxed/simple;
	bh=xsxDHFnbfImmtC2rlnjfXAj+o2HkYwfXIviVbt9W8xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Plfm7Anq+FokeoetrF5e2k6eT5L5yF+AFRhRSBweYr0YsTBEuNhQ2Pf7UZC6lqkwuktchJj051h/9j0trJKlcgpVazcjr4SlxUkkVzUgsW66EAqYhYoOGysXWy04v14Gb+E4tUdQSH2poHe2AFMbi8VIrFK2bY7+5jwsV2BThLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com; spf=pass smtp.mailfrom=cambridgegreys.com; arc=none smtp.client-ip=217.160.28.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cambridgegreys.com
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1t80LU-00Dwha-O1; Mon, 04 Nov 2024 16:54:28 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1t80LR-00C1Rg-2Z;
	Mon, 04 Nov 2024 16:54:28 +0000
Message-ID: <54288e93-c389-444c-afe4-bd099523bfab@cambridgegreys.com>
Date: Mon, 4 Nov 2024 16:54:25 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] um: net: Do not use drvdata in release
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at,
 johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241104163203.435515-1-tiwei.btw@antgroup.com>
 <20241104163203.435515-4-tiwei.btw@antgroup.com>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20241104163203.435515-4-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett



On 04/11/2024 16:32, Tiwei Bie wrote:
> The drvdata is not available in release. Let's just use container_of()
> to get the uml_net instance. Otherwise, removing a network device will
> result in a crash:
> 
> RIP: 0033:net_device_release+0x10/0x6f
> RSP: 00000000e20c7c40  EFLAGS: 00010206
> RAX: 000000006002e4e7 RBX: 00000000600f1baf RCX: 00000000624074e0
> RDX: 0000000062778000 RSI: 0000000060551c80 RDI: 00000000627af028
> RBP: 00000000e20c7c50 R08: 00000000603ad594 R09: 00000000e20c7b70
> R10: 000000000000135a R11: 00000000603ad422 R12: 0000000000000000
> R13: 0000000062c7af00 R14: 0000000062406d60 R15: 00000000627700b6
> Kernel panic - not syncing: Segfault with no mm
> CPU: 0 UID: 0 PID: 29 Comm: kworker/0:2 Not tainted 6.12.0-rc6-g59b723cd2adb #1
> Workqueue: events mc_work_proc
> Stack:
>   627af028 62c7af00 e20c7c80 60276fcd
>   62778000 603f5820 627af028 00000000
>   e20c7cb0 603a2bcd 627af000 62770010
> Call Trace:
>   [<60276fcd>] device_release+0x70/0xba
>   [<603a2bcd>] kobject_put+0xba/0xe7
>   [<60277265>] put_device+0x19/0x1c
>   [<60281266>] platform_device_put+0x26/0x29
>   [<60281e5f>] platform_device_unregister+0x2c/0x2e
>   [<6002ec9c>] net_remove+0x63/0x69
>   [<60031316>] ? mconsole_reply+0x0/0x50
>   [<600310c8>] mconsole_remove+0x160/0x1cc
>   [<60087d40>] ? __remove_hrtimer+0x38/0x74
>   [<60087ff8>] ? hrtimer_try_to_cancel+0x8c/0x98
>   [<6006b3cf>] ? dl_server_stop+0x3f/0x48
>   [<6006b390>] ? dl_server_stop+0x0/0x48
>   [<600672e8>] ? dequeue_entities+0x327/0x390
>   [<60038fa6>] ? um_set_signals+0x0/0x43
>   [<6003070c>] mc_work_proc+0x77/0x91
>   [<60057664>] process_scheduled_works+0x1b3/0x2dd
>   [<60055f32>] ? assign_work+0x0/0x58
>   [<60057f0a>] worker_thread+0x1e9/0x293
>   [<6005406f>] ? set_pf_worker+0x0/0x64
>   [<6005d65d>] ? arch_local_irq_save+0x0/0x2d
>   [<6005d748>] ? kthread_exit+0x0/0x3a
>   [<60057d21>] ? worker_thread+0x0/0x293
>   [<6005dbf1>] kthread+0x126/0x12b
>   [<600219c5>] new_thread_handler+0x85/0xb6
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> ---
>   arch/um/drivers/net_kern.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
> index 77c4afb8ab90..75d04fb4994a 100644
> --- a/arch/um/drivers/net_kern.c
> +++ b/arch/um/drivers/net_kern.c
> @@ -336,7 +336,7 @@ static struct platform_driver uml_net_driver = {
>   
>   static void net_device_release(struct device *dev)
>   {
> -	struct uml_net *device = dev_get_drvdata(dev);
> +	struct uml_net *device = container_of(dev, struct uml_net, pdev.dev);
>   	struct net_device *netdev = device->dev;
>   	struct uml_net_private *lp = netdev_priv(netdev);
>   
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

