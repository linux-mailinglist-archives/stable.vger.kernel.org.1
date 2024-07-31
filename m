Return-Path: <stable+bounces-64747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C77942BC6
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 12:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E671C21365
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 10:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319F01A71FA;
	Wed, 31 Jul 2024 10:16:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF328801;
	Wed, 31 Jul 2024 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420982; cv=none; b=SEV6+mZKJr/t3Q52nPAY/JjlCV47lwmZwmnPb1DS3nreT5dUlL0i8NridA6vbVTh0r+ifFN0/agoiWtFqEEkUIX6cVIUKlYNOClInrzLqh7/mk1oID9tLGmgUQ1xcwVsK5ts9tmYYapbqO+047Afgm5wX17pYCvyxBjKqeMDybA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420982; c=relaxed/simple;
	bh=f63JFiTCszeHxLkMWbyoDf07plGaFJuYndHwtLyb5V4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BFZxjp+UmQ4MoeFl/sf+rrRboDboG0yLlQbdS/ZCgCWYWoMOJSLngeDFUa/+kRGkCZJhYEkGt2LXSZF0KS5QseI5XbuoRUsb0u4asdqEH7AiuOcirsBtRPFnEBkkZAu29puYbIb15ML5dTuhd9H1nXQ+bK41G4arXTC8LoIXqx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WYny96f4qzgYkn;
	Wed, 31 Jul 2024 18:14:25 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D1FD18009B;
	Wed, 31 Jul 2024 18:16:16 +0800 (CST)
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 18:16:16 +0800
Message-ID: <9b6398a6-a1a3-dcee-7e80-9b805ce794f7@huawei.com>
Date: Wed, 31 Jul 2024 18:15:19 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [Regression] 6.11.0-rc1: BUG: using smp_processor_id() in
 preemptible when suspend the system
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, David Wang <00107082@163.com>
CC: <linux-kernel@vger.kernel.org>, <linux-tip-commits@vger.kernel.org>,
	<stable@vger.kernel.org>, <x86@kernel.org>
References: <20240730142557.4619-1-00107082@163.com> <87ikwm7waq.ffs@tglx>
From: Yu Liao <liaoyu15@huawei.com>
In-Reply-To: <87ikwm7waq.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500003.china.huawei.com (7.185.36.200)

On 2024/7/30 23:07, Thomas Gleixner wrote:
> On Tue, Jul 30 2024 at 22:25, David Wang wrote:
>> When I suspend my system, via `systemctl suspend`, kernel BUG shows up in log:
>>
>>  kernel: [ 1734.412974] smpboot: CPU 2 is now offline
>>  kernel: [ 1734.414952] BUG: using smp_processor_id() in preemptible [00000000] code: systemd-sleep/4619
>>  kernel: [ 1734.414957] caller is hotplug_cpu__broadcast_tick_pull+0x1c/0xc0
> 
> The below should fix that.
> 
> Thanks,
> 
>         tglx
> ---
> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -1141,7 +1141,6 @@ void tick_broadcast_switch_to_oneshot(vo
>  #ifdef CONFIG_HOTPLUG_CPU
>  void hotplug_cpu__broadcast_tick_pull(int deadcpu)
>  {
> -	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
>  	struct clock_event_device *bc;
>  	unsigned long flags;
>  
> @@ -1167,6 +1166,8 @@ void hotplug_cpu__broadcast_tick_pull(in
>  		 * device to avoid the starvation.
>  		 */
>  		if (tick_check_broadcast_expired()) {
> +			struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
> +
>  			cpumask_clear_cpu(smp_processor_id(), tick_broadcast_force_mask);
>  			tick_program_event(td->evtdev->next_event, 1);
>  		}
> 

Sorry for causing this issue. I have tested the patch on an x86 machine, this
patch can fix the issue.

Tested-by: Yu Liao <liaoyu15@huawei.com>


