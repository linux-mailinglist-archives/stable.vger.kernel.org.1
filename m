Return-Path: <stable+bounces-106134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4963E9FCA57
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 11:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD304162F79
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 10:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C27C1D515B;
	Thu, 26 Dec 2024 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cU/aj9B4"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65751D4605
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735209942; cv=none; b=KUv7VQcwVEY6lR3sdC2IbQBUMDWPaT1Ft7et3mEg5IFO//IxaIi+UM6RnTXViFGpetrANTLUjELp77fQxc1TUPxnq+VrfVzjAJz19BRCEc0NRkCeMY7cOhLLaGfG2x8deP48zcwLE8SC7Cg8Y/jqZdEAx3oxhEkecZjH2dmCGoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735209942; c=relaxed/simple;
	bh=gwc8i0j1/7O9YiAE8S2mKPx/3LBUJgGeNzXcKo+yud4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=APRxCwbivk2y5+KD7QlPybXlazOdXsXisvr0ZdHmwzWrPNP8rp1VnwOGcIB/0zHrdSaXcOvszGjJZMpqoM0DXIpidN4sQVMPENQSd1JSkmsm5xBaHY46F2zjXmw8IAXXvKIiySF2Nxj0Y3XWSR57hznraX4uMWfxfr9LFNcVU5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cU/aj9B4; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=zLwjyiStgNWLBog5wfNfYBSj5QcqwsBpCUQgQjlS2K4=;
	b=cU/aj9B4Lwbsc6DC8kbYsIyFtvRY2V4cPIQ6Lvt9E8R311keAAm8uBaVoCJ4oZ
	OQVQkwQVjIi6jhyVX6UTjHoM/zCmB/tiN8Kp+6fIWNTGaJPiK906azjv/1HmZN9N
	/8oZ2kF0gaawox3krvnIVyiuKS9AZwWcyOZ9t+Rd9gBHU=
Received: from [192.168.3.47] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3377OM21nNfpCBw--.58420S2;
	Thu, 26 Dec 2024 18:45:35 +0800 (CST)
Message-ID: <575d14c5-6759-438b-8729-c137c26e900c@163.com>
Date: Thu, 26 Dec 2024 18:45:32 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4.y] epoll: Add synchronous wakeup support for
 ep_poll_callback
To: stable@vger.kernel.org
References: <2024122326-viscous-dreaded-d15d@gregkh>
 <20241226083553.1283297-1-jetlan9@163.com>
Content-Language: en-US
From: "Lan, Wenshan" <jetlan9@163.com>
In-Reply-To: <20241226083553.1283297-1-jetlan9@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3377OM21nNfpCBw--.58420S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZryDWryDXF4DtFyfuFyUZFb_yoW5GFykpF
	45WFnYqFWrXrWUK3ykXr47uF9ruws5GwnxCrWDu3WUArW7Kw1FyryIyFnxZFs2vrZYk3y3
	AanxZrn3uw4UJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziY0PDUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/1tbiDwPByGdtKNf9QAAAsN


On 12/26/2024 4:35 PM, Wenshan Lan wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> From: Xuewen Yan <xuewen.yan@unisoc.com>
>
> Now, the epoll only use wake_up() interface to wake up task.
> However, sometimes, there are epoll users which want to use
> the synchronous wakeup flag to hint the scheduler, such as
> Android binder driver.
> So add a wake_up_sync() define, and use the wake_up_sync()
> when the sync is true in ep_poll_callback().
>
> Co-developed-by: Jing Xia <jing.xia@unisoc.com>
> Signed-off-by: Jing Xia <jing.xia@unisoc.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Link: https://lore.kernel.org/r/20240426080548.8203-1-xuewen.yan@unisoc.com
> Tested-by: Brian Geffon <bgeffon@google.com>
> Reviewed-by: Brian Geffon <bgeffon@google.com>
> Reported-by: Benoit Lize <lizeb@google.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> (cherry picked from commit 900bbaae67e980945dec74d36f8afe0de7556d5a)
> [ Redefine wake_up_sync(x) as __wake_up_sync(x, TASK_NORMAL, 1) to
>    make it work on 5.4.y ]
> Signed-off-by: Wenshan Lan <jetlan9@163.com>
> ---
>   fs/eventpoll.c       | 5 ++++-
>   include/linux/wait.h | 1 +
>   2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 8c0e94183186..569bfff280e4 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1273,7 +1273,10 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
>                                  break;
>                          }
>                  }
> -               wake_up(&ep->wq);
> +               if (sync)
> +                       wake_up_sync(&ep->wq);
> +               else
> +                       wake_up(&ep->wq);
>          }
>          if (waitqueue_active(&ep->poll_wait))
>                  pwake++;
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index 03bff85e365f..5b65f720261a 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -213,6 +213,7 @@ void __wake_up_pollfree(struct wait_queue_head *wq_head);
>   #define wake_up_all(x)                 __wake_up(x, TASK_NORMAL, 0, NULL)
>   #define wake_up_locked(x)              __wake_up_locked((x), TASK_NORMAL, 1)
>   #define wake_up_all_locked(x)          __wake_up_locked((x), TASK_NORMAL, 0)
> +#define wake_up_sync(x)                        __wake_up_sync(x, TASK_NORMAL, 1)
>
>   #define wake_up_interruptible(x)       __wake_up(x, TASK_INTERRUPTIBLE, 1, NULL)
>   #define wake_up_interruptible_nr(x, nr)        __wake_up(x, TASK_INTERRUPTIBLE, nr, NULL)
> --
> 2.43.0

Please ignore this patch for I forgot to CC the related persons. Thanks.

B.R.

Wenshan

>


