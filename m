Return-Path: <stable+bounces-50273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F4E905557
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 16:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B751F218EB
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985D517E909;
	Wed, 12 Jun 2024 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cmlb3HNl"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5FC169ACA
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203160; cv=none; b=LElPghw6IA83xRd78ZeTRb8CcW6vAjEMbDUoeNK0Nx9gVBPu8pdRiEBAdqCip3HlaDQNTx8VQx93qxXP/M1H1QJxxgwEE0SfLO+BOGe8DeawgKbPFpo2MRZRP41OM49ZpfWuOVM7D2pg/TvYfR0CtlqXUPxosFBuYze2jJzTTds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203160; c=relaxed/simple;
	bh=i9IcLpvdPTEFYtAgzzQOgTqJFakEsArrZKgyZDUxQCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tA/vNK8smi6VlZA9smhmBCdfh4u9AhDslNsQ2jlzFYBekm4EJwrFruzPfGDxyvN4fQ2LS5kg6K0L4gsCvpVovMO3tup5XVThfdPMFks9o4uU3zXO98tES5vlZT1hmWQOCpnAjdo7Kg+RxFARSQ7BfOJVu3YYr0G/S5mEbPDDUCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cmlb3HNl; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3941D412FD
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 14:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718203155;
	bh=FEe6guxSJnnwT9a3JS62YLFRpxebVQ0z7KAUJq4BiQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=cmlb3HNlcng6yPk40Ah+gANW/h9l/whP4Kfj9FWW2l6n0lAs8Dlq+htkZAH7jn6Gk
	 +qCp2R+9dcFFff4+EIYdPYPLwc67iezTElhrM9BK7gGLDU4F5O+16Nt8bZaEscQld1
	 IkAjs//XFKbDSOTxQyTeKSUKWLKNsRV7qxt91bIXkJnV2PbqDurNZteMV/z/BxA9Wq
	 tAEdhQx/3GiFOs0cqp4Mm4uXPbjaW0OjCI2u4g6Rn/kQnqtvRmmYDbE7oN8L+OB/o5
	 seV7a//n4ni2UkU0wcSq941D0+QTxR/dOYFI95kHBypzyjve71nclU4izw3hQjMuo3
	 NJZz+lzXAiBCw==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-421292df2adso44797165e9.3
        for <stable@vger.kernel.org>; Wed, 12 Jun 2024 07:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718203154; x=1718807954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FEe6guxSJnnwT9a3JS62YLFRpxebVQ0z7KAUJq4BiQ0=;
        b=ke57Bg0nzYlN/Xikt0J2zm9+f3SKH0AUKp2fe04VWK9cUWmj7VeVWvku/XXK7iI81U
         ul8wMsQmCgi9Jn8XXUXydTdbE7eT474dCReu1vXDHFNNSY6+6MT353QOrJLvqGo2RUA/
         305z0GVkJqTgdtK3OZgaO9umKeo+9LBw5YvgprNkIixnO1uxV44Kw3BB1bZOXk5fFeyE
         PjL3zQy7aFBX+Eo2MQoxC5AX1cCrUbjIfDINKiKRcg/+suhOG50AabNo9gIYgOy0p60B
         cjqi0fNAwpgWQthvQucDVA+NUqONbeg3vcbf08jsIrFsjDVj8CsHV1WwBqBTrv0eCcyx
         kENw==
X-Forwarded-Encrypted: i=1; AJvYcCVeQpdcFg8mfbWKrzUHsNv6LUrAXhXdbEAuynRMQg9XQmRnZkksHlQM6NJkZzJGkuadaE08/qDoBA5ZkcaQ+G7yHahOg1Nh
X-Gm-Message-State: AOJu0YwI5tFuEubudqczDSMfd8FUQci/XOzMs8zYRgcr/Pzd19m3mQeO
	5JedG5wkzKBjeIAk4UXlcf/YyYrVLWwCnO7+v3EYN5iDf+d/jw0hGZ1Y3ELIge9ZLgVm00zGaR4
	Sbz+eeiy0kQUt4Ah9X9aRZb67UlAmlCXBawoz0xt2ZAuP++Xm4GY0kbJPtbtnAucjeTbzYw==
X-Received: by 2002:a05:600c:1c15:b0:422:aca:f887 with SMTP id 5b1f17b1804b1-422866bd5eamr20690715e9.28.1718203154446;
        Wed, 12 Jun 2024 07:39:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdL/7OvAsGlhcbwK+IpumP04nMCsrOcDC8zofvEaqHGmMh2xbshX6Y1t+cBoaN0md82ocDsQ==
X-Received: by 2002:a05:600c:1c15:b0:422:aca:f887 with SMTP id 5b1f17b1804b1-422866bd5eamr20690495e9.28.1718203154012;
        Wed, 12 Jun 2024 07:39:14 -0700 (PDT)
Received: from [192.168.1.126] ([213.204.117.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f22d980e6sm9084853f8f.4.2024.06.12.07.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 07:39:13 -0700 (PDT)
Message-ID: <ea4f2bb4-27a2-43ae-9ddc-a43db8b94594@canonical.com>
Date: Wed, 12 Jun 2024 17:39:11 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bnx2x: Fix multiple UBSAN array-index-out-of-bounds
To: Greg KH <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
References: <20240612135657.153658-1-ghadi.rahme@canonical.com>
 <2024061221-backtrack-tricky-6be3@gregkh>
Content-Language: en-US
From: Ghadi Rahme <ghadi.rahme@canonical.com>
In-Reply-To: <2024061221-backtrack-tricky-6be3@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Apologies, I accidentally sent an older version of the patch before
checkpatch was ran and noticed it right after sending it. I will re-upload
the proper version as soon as I am able to.

On 12/06/2024 17:06, Greg KH wrote:
> On Wed, Jun 12, 2024 at 04:56:57PM +0300, Ghadi Elie Rahme wrote:
>> Fix UBSAN warnings that occur when using a system with 32 physical
>> cpu cores or more, or when the user defines a number of ethernet
>> queues greater than or equal to FP_SB_MAX_E1x.
>>
>> The value of the maximum number of Ethernet queues should be limited
>> to FP_SB_MAX_E1x in case FCOE is disabled or to [FP_SB_MAX_E1x-1] if
>> enabled to avoid out of bounds reads and writes.
>>
>> Stack trace:
>>
>> UBSAN: array-index-out-of-bounds in /home/kernel/COD/linux/drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.c:1529:11
>> index 20 is out of range for type 'stats_query_entry [19]'
>> CPU: 12 PID: 858 Comm: systemd-network Not tainted 6.9.0-060900rc7-generic #202405052133
>> Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 10/21/2019
>> Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x76/0xa0
>>   dump_stack+0x10/0x20
>>   __ubsan_handle_out_of_bounds+0xcb/0x110
>>   bnx2x_prep_fw_stats_req+0x2e1/0x310 [bnx2x]
>>   bnx2x_stats_init+0x156/0x320 [bnx2x]
>>   bnx2x_post_irq_nic_init+0x81/0x1a0 [bnx2x]
>>   bnx2x_nic_load+0x8e8/0x19e0 [bnx2x]
>>   bnx2x_open+0x16b/0x290 [bnx2x]
>>   __dev_open+0x10e/0x1d0
>>   __dev_change_flags+0x1bb/0x240
>>   ? sock_def_readable+0x52/0xf0
>>   dev_change_flags+0x27/0x80
>>   do_setlink+0xab7/0xe50
>>   ? rtnl_getlink+0x3c7/0x470
>>   ? __nla_validate_parse+0x49/0x1d0
>>   rtnl_setlink+0x12f/0x1f0
>>   ? security_capable+0x47/0x80
>>   rtnetlink_rcv_msg+0x170/0x440
>>   ? ep_done_scan+0xe4/0x100
>>   ? __pfx_rtnetlink_rcv_msg+0x10/0x10
>>   netlink_rcv_skb+0x5d/0x110
>>   rtnetlink_rcv+0x15/0x30
>>   netlink_unicast+0x243/0x380
>>   netlink_sendmsg+0x213/0x460
>>   __sys_sendto+0x21e/0x230
>>   __x64_sys_sendto+0x24/0x40
>>   x64_sys_call+0x1c33/0x25c0
>>   do_syscall_64+0x7e/0x180
>>   ? __task_pid_nr_ns+0x6c/0xc0
>>   ? syscall_exit_to_user_mode+0x81/0x270
>>   ? do_syscall_64+0x8b/0x180
>>   ? do_syscall_64+0x8b/0x180
>>   ? __task_pid_nr_ns+0x6c/0xc0
>>   ? syscall_exit_to_user_mode+0x81/0x270
>>   ? do_syscall_64+0x8b/0x180
>>   ? do_syscall_64+0x8b/0x180
>>   ? exc_page_fault+0x93/0x1b0
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> RIP: 0033:0x736223927a0a
>> Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
>> RSP: 002b:00007ffc0bb2ada8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
>> RAX: ffffffffffffffda RBX: 0000583df50f9c78 RCX: 0000736223927a0a
>> RDX: 0000000000000020 RSI: 0000583df50ee510 RDI: 0000000000000003
>> RBP: 0000583df50d4940 R08: 00007ffc0bb2adb0 R09: 0000000000000080
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000583df5103ae0
>> R13: 000000000000035a R14: 0000583df50f9c30 R15: 0000583ddddddf00
>> </TASK>
>> ---[ end trace ]---
>> ------------[ cut here ]------------
>> UBSAN: array-index-out-of-bounds in /home/kernel/COD/linux/drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.c:1546:11
>> index 28 is out of range for type 'stats_query_entry [19]'
>> CPU: 12 PID: 858 Comm: systemd-network Not tainted 6.9.0-060900rc7-generic #202405052133
>> Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 10/21/2019
>> Call Trace:
>> <TASK>
>> dump_stack_lvl+0x76/0xa0
>> dump_stack+0x10/0x20
>> __ubsan_handle_out_of_bounds+0xcb/0x110
>> bnx2x_prep_fw_stats_req+0x2fd/0x310 [bnx2x]
>> bnx2x_stats_init+0x156/0x320 [bnx2x]
>> bnx2x_post_irq_nic_init+0x81/0x1a0 [bnx2x]
>> bnx2x_nic_load+0x8e8/0x19e0 [bnx2x]
>> bnx2x_open+0x16b/0x290 [bnx2x]
>> __dev_open+0x10e/0x1d0
>> __dev_change_flags+0x1bb/0x240
>> ? sock_def_readable+0x52/0xf0
>> dev_change_flags+0x27/0x80
>> do_setlink+0xab7/0xe50
>> ? rtnl_getlink+0x3c7/0x470
>> ? __nla_validate_parse+0x49/0x1d0
>> rtnl_setlink+0x12f/0x1f0
>> ? security_capable+0x47/0x80
>> rtnetlink_rcv_msg+0x170/0x440
>> ? ep_done_scan+0xe4/0x100
>> ? __pfx_rtnetlink_rcv_msg+0x10/0x10
>> netlink_rcv_skb+0x5d/0x110
>> rtnetlink_rcv+0x15/0x30
>> netlink_unicast+0x243/0x380
>> netlink_sendmsg+0x213/0x460
>> __sys_sendto+0x21e/0x230
>> __x64_sys_sendto+0x24/0x40
>> x64_sys_call+0x1c33/0x25c0
>> do_syscall_64+0x7e/0x180
>> ? __task_pid_nr_ns+0x6c/0xc0
>> ? syscall_exit_to_user_mode+0x81/0x270
>> ? do_syscall_64+0x8b/0x180
>> ? do_syscall_64+0x8b/0x180
>> ? __task_pid_nr_ns+0x6c/0xc0
>> ? syscall_exit_to_user_mode+0x81/0x270
>> ? do_syscall_64+0x8b/0x180
>> ? do_syscall_64+0x8b/0x180
>> ? exc_page_fault+0x93/0x1b0
>> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> RIP: 0033:0x736223927a0a
>> Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
>> RSP: 002b:00007ffc0bb2ada8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
>> RAX: ffffffffffffffda RBX: 0000583df50f9c78 RCX: 0000736223927a0a
>> RDX: 0000000000000020 RSI: 0000583df50ee510 RDI: 0000000000000003
>> RBP: 0000583df50d4940 R08: 00007ffc0bb2adb0 R09: 0000000000000080
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000583df5103ae0
>> R13: 000000000000035a R14: 0000583df50f9c30 R15: 0000583ddddddf00
>>   </TASK>
>> ---[ end trace ]---
>> bnx2x 0000:04:00.1: 32.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x8 link)
>> bnx2x 0000:04:00.1 eno50: renamed from eth0
>> ------------[ cut here ]------------
>> UBSAN: array-index-out-of-bounds in /home/kernel/COD/linux/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c:1895:8
>> index 29 is out of range for type 'stats_query_entry [19]'
>> CPU: 13 PID: 163 Comm: kworker/u96:1 Not tainted 6.9.0-060900rc7-generic #202405052133
>> Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 10/21/2019
>> Workqueue: bnx2x bnx2x_sp_task [bnx2x]
>> Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x76/0xa0
>>   dump_stack+0x10/0x20
>>   __ubsan_handle_out_of_bounds+0xcb/0x110
>>   bnx2x_iov_adjust_stats_req+0x3c4/0x3d0 [bnx2x]
>>   bnx2x_storm_stats_post.part.0+0x4a/0x330 [bnx2x]
>>   ? bnx2x_hw_stats_post+0x231/0x250 [bnx2x]
>>   bnx2x_stats_start+0x44/0x70 [bnx2x]
>>   bnx2x_stats_handle+0x149/0x350 [bnx2x]
>>   bnx2x_attn_int_asserted+0x998/0x9b0 [bnx2x]
>>   bnx2x_sp_task+0x491/0x5c0 [bnx2x]
>>   process_one_work+0x18d/0x3f0
>>   worker_thread+0x304/0x440
>>   ? __pfx_worker_thread+0x10/0x10
>>   kthread+0xe4/0x110
>>   ? __pfx_kthread+0x10/0x10
>>   ret_from_fork+0x47/0x70
>>   ? __pfx_kthread+0x10/0x10
>>   ret_from_fork_asm+0x1a/0x30
>>   </TASK>
>> ---[ end trace ]---
>>
>> Fixes: 7d0445d66a76 ("bnx2x: clamp num_queues to prevent passing a negative value")
>> Signed-off-by: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
>> ---
>>   drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
>> index a8e07e51418f..837617b99089 100644
>> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
>> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
>> @@ -66,7 +66,12 @@ static int bnx2x_calc_num_queues(struct bnx2x *bp)
>>   	if (is_kdump_kernel())
>>   		nq = 1;
>>   
>> -	nq = clamp(nq, 1, BNX2X_MAX_QUEUES(bp));
>> +	int max_nq = FP_SB_MAX_E1x - 1;
>> +
>> +	if(NO_FCOE(bp))
>> +		max_nq = FP_SB_MAX_E1x;
>> +
>> +	nq = clamp(nq, 1, max_nq);
>>   	return nq;
>>   }
>>   
>> -- 
>> 2.43.0
>>
>>
> Did you not run checkpatch on this?
>
> Also:
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> </formletter>

