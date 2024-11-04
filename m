Return-Path: <stable+bounces-89721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 738BA9BBAA4
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 17:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35CC1C227CE
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 16:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86A31C2DAE;
	Mon,  4 Nov 2024 16:55:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168831369B6;
	Mon,  4 Nov 2024 16:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.160.28.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739301; cv=none; b=ZGrvn/HMwNLE7QXEJEnUKzvEMhUGq/xc8k8K4xlFTGwFKJAIurccld7Kv/2asP5OYAe4xERv7NXF7ZLyprIK5JrzbGAwwV7bxw12lsGT3DxlzXWPuBnLeiyCjDWt3L8zp8PLQ4U4xiYM8sjgtoPcskxK5RdFytuOLDzfKDsdH+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739301; c=relaxed/simple;
	bh=mABaa3vW6dCeP4mFUxmlF4lPXp0GY4zZWRcQ64jP/2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NnAhcx7zc2GblhnQdEM945sTLULoTB6PbsFWhfPiNdWPP94IQrYTslfDBmpZpmSUU2/1pE/kgk414NoLcAgnW2darIa10bzxTs7J9zDDUFGyxEaBGJS14ArpG8y15FX2WxUxskixYY8k+cZtvGmrwEwjeEgFYK8CTaGV3CIUaJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com; spf=pass smtp.mailfrom=cambridgegreys.com; arc=none smtp.client-ip=217.160.28.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cambridgegreys.com
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1t80Ln-00Dwhk-QZ; Mon, 04 Nov 2024 16:54:47 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1t80Ll-00C1Sz-0H;
	Mon, 04 Nov 2024 16:54:47 +0000
Message-ID: <a764ef90-ca34-443b-978b-3af20dc76015@cambridgegreys.com>
Date: Mon, 4 Nov 2024 16:54:44 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] um: ubd: Do not use drvdata in release
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at,
 johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241104163203.435515-1-tiwei.btw@antgroup.com>
 <20241104163203.435515-3-tiwei.btw@antgroup.com>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20241104163203.435515-3-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett



On 04/11/2024 16:32, Tiwei Bie wrote:
> The drvdata is not available in release. Let's just use container_of()
> to get the ubd instance. Otherwise, removing a ubd device will result
> in a crash:
> 
> RIP: 0033:blk_mq_free_tag_set+0x1f/0xba
> RSP: 00000000e2083bf0  EFLAGS: 00010246
> RAX: 000000006021463a RBX: 0000000000000348 RCX: 0000000062604d00
> RDX: 0000000004208060 RSI: 00000000605241a0 RDI: 0000000000000348
> RBP: 00000000e2083c10 R08: 0000000062414010 R09: 00000000601603f7
> R10: 000000000000133a R11: 000000006038c4bd R12: 0000000000000000
> R13: 0000000060213a5c R14: 0000000062405d20 R15: 00000000604f7aa0
> Kernel panic - not syncing: Segfault with no mm
> CPU: 0 PID: 17 Comm: kworker/0:1 Not tainted 6.8.0-rc3-00107-gba3f67c11638 #1
> Workqueue: events mc_work_proc
> Stack:
>   00000000 604f7ef0 62c5d000 62405d20
>   e2083c30 6002c776 6002c755 600e47ff
>   e2083c60 6025ffe3 04208060 603d36e0
> Call Trace:
>   [<6002c776>] ubd_device_release+0x21/0x55
>   [<6002c755>] ? ubd_device_release+0x0/0x55
>   [<600e47ff>] ? kfree+0x0/0x100
>   [<6025ffe3>] device_release+0x70/0xba
>   [<60381d6a>] kobject_put+0xb5/0xe2
>   [<6026027b>] put_device+0x19/0x1c
>   [<6026a036>] platform_device_put+0x26/0x29
>   [<6026ac5a>] platform_device_unregister+0x2c/0x2e
>   [<6002c52e>] ubd_remove+0xb8/0xd6
>   [<6002bb74>] ? mconsole_reply+0x0/0x50
>   [<6002b926>] mconsole_remove+0x160/0x1cc
>   [<6002bbbc>] ? mconsole_reply+0x48/0x50
>   [<6003379c>] ? um_set_signals+0x3b/0x43
>   [<60061c55>] ? update_min_vruntime+0x14/0x70
>   [<6006251f>] ? dequeue_task_fair+0x164/0x235
>   [<600620aa>] ? update_cfs_group+0x0/0x40
>   [<603a0e77>] ? __schedule+0x0/0x3ed
>   [<60033761>] ? um_set_signals+0x0/0x43
>   [<6002af6a>] mc_work_proc+0x77/0x91
>   [<600520b4>] process_scheduled_works+0x1af/0x2c3
>   [<6004ede3>] ? assign_work+0x0/0x58
>   [<600527a1>] worker_thread+0x2f7/0x37a
>   [<6004ee3b>] ? set_pf_worker+0x0/0x64
>   [<6005765d>] ? arch_local_irq_save+0x0/0x2d
>   [<60058e07>] ? kthread_exit+0x0/0x3a
>   [<600524aa>] ? worker_thread+0x0/0x37a
>   [<60058f9f>] kthread+0x130/0x135
>   [<6002068e>] new_thread_handler+0x85/0xb6
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> ---
>   arch/um/drivers/ubd_kern.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index f19173da64d8..66c1a8835e36 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -779,7 +779,7 @@ static int ubd_open_dev(struct ubd *ubd_dev)
>   
>   static void ubd_device_release(struct device *dev)
>   {
> -	struct ubd *ubd_dev = dev_get_drvdata(dev);
> +	struct ubd *ubd_dev = container_of(dev, struct ubd, pdev.dev);
>   
>   	blk_mq_free_tag_set(&ubd_dev->tag_set);
>   	*ubd_dev = ((struct ubd) DEFAULT_UBD);

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

