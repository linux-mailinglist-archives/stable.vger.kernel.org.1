Return-Path: <stable+bounces-50269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370319054BC
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 16:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF7F1F223C9
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AAC17D899;
	Wed, 12 Jun 2024 14:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WeqUIjZv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB4F171E70;
	Wed, 12 Jun 2024 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201204; cv=none; b=VUkhazlIMG+39VF4HEUqQFoi4VsD+cuu9QPQlowoaWU5VB4N79MBFRAvnZktUBbe/ffUI/dYWMCKPnV4F3BR1SZ1DlqSV0LibFlRaxCH47zJa1ZEX9aOGqgS/X3Q7nHMsdKlj9lTRnxgtWOr0WiBa90n5pY0WJQTLc1clQLvIkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201204; c=relaxed/simple;
	bh=CerbTB43y+NbZ6dPhUOLfvcFiSZfdyz50H8ve2ccENU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuMIxAx09D1L/NWqeqLPuWCE8SbxzPe37zrmL2ZXNofvZBeDLhC5ljrShOw80WIWCCkc+KrtByhjXNlxN1e6y8E4rBzRSIB8nzsc8wksq48ZFOxvz202inmVpKlaoMHfd8yibFePAmJ0mo63UGN6oW5vyw3jMMymwopkWIq15r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WeqUIjZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20B1C116B1;
	Wed, 12 Jun 2024 14:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718201204;
	bh=CerbTB43y+NbZ6dPhUOLfvcFiSZfdyz50H8ve2ccENU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WeqUIjZvPCYi/qfU2Clw7rt0cuTzI1uvs7+rPdmJQ6X9EIHkRVAH4O/io9coOw9hZ
	 owc2kO1HredrOSzZ5xwlWeGcUvo0URfcVwE43DFiucPpjHnYgvnWgXf1uY/q98gMCL
	 WlD98k6Pfq4IDVSx/y5KrAA08AvmqqGfhqNwUQUU=
Date: Wed, 12 Jun 2024 16:06:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] bnx2x: Fix multiple UBSAN array-index-out-of-bounds
Message-ID: <2024061221-backtrack-tricky-6be3@gregkh>
References: <20240612135657.153658-1-ghadi.rahme@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612135657.153658-1-ghadi.rahme@canonical.com>

On Wed, Jun 12, 2024 at 04:56:57PM +0300, Ghadi Elie Rahme wrote:
> Fix UBSAN warnings that occur when using a system with 32 physical
> cpu cores or more, or when the user defines a number of ethernet
> queues greater than or equal to FP_SB_MAX_E1x.
> 
> The value of the maximum number of Ethernet queues should be limited
> to FP_SB_MAX_E1x in case FCOE is disabled or to [FP_SB_MAX_E1x-1] if
> enabled to avoid out of bounds reads and writes.
> 
> Stack trace:
> 
> UBSAN: array-index-out-of-bounds in /home/kernel/COD/linux/drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.c:1529:11
> index 20 is out of range for type 'stats_query_entry [19]'
> CPU: 12 PID: 858 Comm: systemd-network Not tainted 6.9.0-060900rc7-generic #202405052133
> Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 10/21/2019
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x76/0xa0
>  dump_stack+0x10/0x20
>  __ubsan_handle_out_of_bounds+0xcb/0x110
>  bnx2x_prep_fw_stats_req+0x2e1/0x310 [bnx2x]
>  bnx2x_stats_init+0x156/0x320 [bnx2x]
>  bnx2x_post_irq_nic_init+0x81/0x1a0 [bnx2x]
>  bnx2x_nic_load+0x8e8/0x19e0 [bnx2x]
>  bnx2x_open+0x16b/0x290 [bnx2x]
>  __dev_open+0x10e/0x1d0
>  __dev_change_flags+0x1bb/0x240
>  ? sock_def_readable+0x52/0xf0
>  dev_change_flags+0x27/0x80
>  do_setlink+0xab7/0xe50
>  ? rtnl_getlink+0x3c7/0x470
>  ? __nla_validate_parse+0x49/0x1d0
>  rtnl_setlink+0x12f/0x1f0
>  ? security_capable+0x47/0x80
>  rtnetlink_rcv_msg+0x170/0x440
>  ? ep_done_scan+0xe4/0x100
>  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
>  netlink_rcv_skb+0x5d/0x110
>  rtnetlink_rcv+0x15/0x30
>  netlink_unicast+0x243/0x380
>  netlink_sendmsg+0x213/0x460
>  __sys_sendto+0x21e/0x230
>  __x64_sys_sendto+0x24/0x40
>  x64_sys_call+0x1c33/0x25c0
>  do_syscall_64+0x7e/0x180
>  ? __task_pid_nr_ns+0x6c/0xc0
>  ? syscall_exit_to_user_mode+0x81/0x270
>  ? do_syscall_64+0x8b/0x180
>  ? do_syscall_64+0x8b/0x180
>  ? __task_pid_nr_ns+0x6c/0xc0
>  ? syscall_exit_to_user_mode+0x81/0x270
>  ? do_syscall_64+0x8b/0x180
>  ? do_syscall_64+0x8b/0x180
>  ? exc_page_fault+0x93/0x1b0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x736223927a0a
> Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
> RSP: 002b:00007ffc0bb2ada8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 0000583df50f9c78 RCX: 0000736223927a0a
> RDX: 0000000000000020 RSI: 0000583df50ee510 RDI: 0000000000000003
> RBP: 0000583df50d4940 R08: 00007ffc0bb2adb0 R09: 0000000000000080
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000583df5103ae0
> R13: 000000000000035a R14: 0000583df50f9c30 R15: 0000583ddddddf00
> </TASK>
> ---[ end trace ]---
> ------------[ cut here ]------------
> UBSAN: array-index-out-of-bounds in /home/kernel/COD/linux/drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.c:1546:11
> index 28 is out of range for type 'stats_query_entry [19]'
> CPU: 12 PID: 858 Comm: systemd-network Not tainted 6.9.0-060900rc7-generic #202405052133
> Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 10/21/2019
> Call Trace:
> <TASK>
> dump_stack_lvl+0x76/0xa0
> dump_stack+0x10/0x20
> __ubsan_handle_out_of_bounds+0xcb/0x110
> bnx2x_prep_fw_stats_req+0x2fd/0x310 [bnx2x]
> bnx2x_stats_init+0x156/0x320 [bnx2x]
> bnx2x_post_irq_nic_init+0x81/0x1a0 [bnx2x]
> bnx2x_nic_load+0x8e8/0x19e0 [bnx2x]
> bnx2x_open+0x16b/0x290 [bnx2x]
> __dev_open+0x10e/0x1d0
> __dev_change_flags+0x1bb/0x240
> ? sock_def_readable+0x52/0xf0
> dev_change_flags+0x27/0x80
> do_setlink+0xab7/0xe50
> ? rtnl_getlink+0x3c7/0x470
> ? __nla_validate_parse+0x49/0x1d0
> rtnl_setlink+0x12f/0x1f0
> ? security_capable+0x47/0x80
> rtnetlink_rcv_msg+0x170/0x440
> ? ep_done_scan+0xe4/0x100
> ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> netlink_rcv_skb+0x5d/0x110
> rtnetlink_rcv+0x15/0x30
> netlink_unicast+0x243/0x380
> netlink_sendmsg+0x213/0x460
> __sys_sendto+0x21e/0x230
> __x64_sys_sendto+0x24/0x40
> x64_sys_call+0x1c33/0x25c0
> do_syscall_64+0x7e/0x180
> ? __task_pid_nr_ns+0x6c/0xc0
> ? syscall_exit_to_user_mode+0x81/0x270
> ? do_syscall_64+0x8b/0x180
> ? do_syscall_64+0x8b/0x180
> ? __task_pid_nr_ns+0x6c/0xc0
> ? syscall_exit_to_user_mode+0x81/0x270
> ? do_syscall_64+0x8b/0x180
> ? do_syscall_64+0x8b/0x180
> ? exc_page_fault+0x93/0x1b0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x736223927a0a
> Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
> RSP: 002b:00007ffc0bb2ada8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 0000583df50f9c78 RCX: 0000736223927a0a
> RDX: 0000000000000020 RSI: 0000583df50ee510 RDI: 0000000000000003
> RBP: 0000583df50d4940 R08: 00007ffc0bb2adb0 R09: 0000000000000080
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000583df5103ae0
> R13: 000000000000035a R14: 0000583df50f9c30 R15: 0000583ddddddf00
>  </TASK>
> ---[ end trace ]---
> bnx2x 0000:04:00.1: 32.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x8 link)
> bnx2x 0000:04:00.1 eno50: renamed from eth0
> ------------[ cut here ]------------
> UBSAN: array-index-out-of-bounds in /home/kernel/COD/linux/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c:1895:8
> index 29 is out of range for type 'stats_query_entry [19]'
> CPU: 13 PID: 163 Comm: kworker/u96:1 Not tainted 6.9.0-060900rc7-generic #202405052133
> Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 10/21/2019
> Workqueue: bnx2x bnx2x_sp_task [bnx2x]
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x76/0xa0
>  dump_stack+0x10/0x20
>  __ubsan_handle_out_of_bounds+0xcb/0x110
>  bnx2x_iov_adjust_stats_req+0x3c4/0x3d0 [bnx2x]
>  bnx2x_storm_stats_post.part.0+0x4a/0x330 [bnx2x]
>  ? bnx2x_hw_stats_post+0x231/0x250 [bnx2x]
>  bnx2x_stats_start+0x44/0x70 [bnx2x]
>  bnx2x_stats_handle+0x149/0x350 [bnx2x]
>  bnx2x_attn_int_asserted+0x998/0x9b0 [bnx2x]
>  bnx2x_sp_task+0x491/0x5c0 [bnx2x]
>  process_one_work+0x18d/0x3f0
>  worker_thread+0x304/0x440
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0xe4/0x110
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x47/0x70
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> ---[ end trace ]---
> 
> Fixes: 7d0445d66a76 ("bnx2x: clamp num_queues to prevent passing a negative value")
> Signed-off-by: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
> ---
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
> index a8e07e51418f..837617b99089 100644
> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
> @@ -66,7 +66,12 @@ static int bnx2x_calc_num_queues(struct bnx2x *bp)
>  	if (is_kdump_kernel())
>  		nq = 1;
>  
> -	nq = clamp(nq, 1, BNX2X_MAX_QUEUES(bp));
> +	int max_nq = FP_SB_MAX_E1x - 1;
> +
> +	if(NO_FCOE(bp))
> +		max_nq = FP_SB_MAX_E1x;
> +
> +	nq = clamp(nq, 1, max_nq);
>  	return nq;
>  }
>  
> -- 
> 2.43.0
> 
> 

Did you not run checkpatch on this?

Also:

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

