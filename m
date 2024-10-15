Return-Path: <stable+bounces-86355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4943399EF75
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 16:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D9B282A76
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EAE1B21A3;
	Tue, 15 Oct 2024 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7t+VJe6"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BDA1FC7CF
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729002254; cv=none; b=fg11TULEZenQBYKVdewn4cggR9Fkepe6/ATvP+pvx2y5X5Rs5CoW1AkCzWSam5X8SgGIN/uXAIoKKXBh9H0n86jV1EcX38RKFhKiLyeXcRD5wF50ShHMAvjazg3toH7VSIWJJFGWiU/4yLVl9KHpOKGpxnhRsqzFPpDUacQ/Fa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729002254; c=relaxed/simple;
	bh=oATTuToY1x3h9znQPx851OCX9zyzrrY9t7chtcMOBHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lq7ufHVh5vSdvIcimfZ+H46t8yE3tjBcX2FgvaCKd+U+hoO1J37IBm/DA6EXiYvQbv4VUSHE9VT3QRxlYH5wl14GR+9oTlHA94ulpDRvj36bTH+p3zPclAG0oItJNWHTMQfXhBBz4uIykPJ2+yOgvMA6AtU85YvSs/uJbI2wEYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7t+VJe6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729002251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nUJ5+CiRrnpWtm4sKZq+yWA3zpfyYa1SXfkj0///Dbc=;
	b=L7t+VJe6vnqFhbAW0G3un27t86t4caLMrHM4taG6vewCMQhiyPqACLolslmDDWnaEw/BVI
	9fSYR1GL4xBVS6JTVPOQBmT7/ChCSoGZUa9mBFpjfeoDf/ECCRICAJGVhAj5xPJ965cHQf
	5X1c0fLz0U5z7ckUR8hrpXEn5m1baVM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-U6ADMcxhMA6GuzO40UYZzQ-1; Tue, 15 Oct 2024 10:24:10 -0400
X-MC-Unique: U6ADMcxhMA6GuzO40UYZzQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4311a383111so26218185e9.3
        for <stable@vger.kernel.org>; Tue, 15 Oct 2024 07:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729002249; x=1729607049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nUJ5+CiRrnpWtm4sKZq+yWA3zpfyYa1SXfkj0///Dbc=;
        b=kBa96rCV0nqnjEcJybZO4b+kbF6Qkr1M1ZrKOuSib62QBH54RGBntanqrZSkR4txwq
         3vSqe2LhaR2LIV8ONBZ8dKUjyt+AEeuwJ6moSI3nfa5Fho/GszLXiwAMKDjlmvmCiEGs
         PCLoJo2OJcw2Si1jHJzBKB7Q77K/GVVf7lwCj+PD1x+spLH4/GegKMa+vX5NH26znFcq
         MiOYhmF41bg7qHa+gcExNMi8T43qjsBfJmFWXJtBcAP8SXIY8vKjKq+ZxO9XP0mMq5CM
         CgRblrI+nOVzRS9YSjMNbT13jXzmeywc64CvvDKDK9XXidUFZnlykyiF0T5ZNKIFLuYQ
         7bZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1RH88Ek6vuT1hTcy5koJbBF0CzfqpRndaswZoRL/96+k2P0unO1UgTOAws8nNTTUuMDEpBd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRujGMU0nfrtyu8E0ZUihQP3CTWBMPu3qJFxS2j66fAhF3cNla
	T+qqWmyh/eSkZwM8N7YdWTru9SZRMUNzGI806wuukHwVVXc1ZolgHH8zhCTMvhk6xMmfFbUltdP
	sbL/AM9/eLZcOT1cMoo/hZWkVPG0F80nPCiHni+M0YUoPc50s8puwGw==
X-Received: by 2002:adf:fcd1:0:b0:37d:51a2:accd with SMTP id ffacd0b85a97d-37d5fd4603bmr8648767f8f.0.1729002248853;
        Tue, 15 Oct 2024 07:24:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4EEQaQ3xbpfloGtENYpctq+DBQXMCCt84rnsOIZpOXOfe9CHjTUEgevqIN7obrCLmcRZqGA==
X-Received: by 2002:adf:fcd1:0:b0:37d:51a2:accd with SMTP id ffacd0b85a97d-37d5fd4603bmr8648738f8f.0.1729002248299;
        Tue, 15 Oct 2024 07:24:08 -0700 (PDT)
Received: from [192.168.88.248] (146-241-22-245.dyn.eolo.it. [146.241.22.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6c63c2sm19413035e9.47.2024.10.15.07.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 07:24:07 -0700 (PDT)
Message-ID: <9f49bc32-a694-4d5a-8451-27708baefbe9@redhat.com>
Date: Tue, 15 Oct 2024 16:24:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] mptcp: pm: fix UaF read in
 mptcp_pm_nl_rm_addr_or_subflow
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, syzbot+3c8b7a8e7df6a2a226ca@syzkaller.appspotmail.com
References: <20241015-net-mptcp-uaf-pm-rm-v1-1-c4ee5d987a64@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241015-net-mptcp-uaf-pm-rm-v1-1-c4ee5d987a64@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 10:38, Matthieu Baerts (NGI0) wrote:
> Syzkaller reported this splat:
> 
>    ==================================================================
>    BUG: KASAN: slab-use-after-free in mptcp_pm_nl_rm_addr_or_subflow+0xb44/0xcc0 net/mptcp/pm_netlink.c:881
>    Read of size 4 at addr ffff8880569ac858 by task syz.1.2799/14662
> 
>    CPU: 0 UID: 0 PID: 14662 Comm: syz.1.2799 Not tainted 6.12.0-rc2-syzkaller-00307-g36c254515dc6 #0
>    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>    Call Trace:
>     <TASK>
>     __dump_stack lib/dump_stack.c:94 [inline]
>     dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>     print_address_description mm/kasan/report.c:377 [inline]
>     print_report+0xc3/0x620 mm/kasan/report.c:488
>     kasan_report+0xd9/0x110 mm/kasan/report.c:601
>     mptcp_pm_nl_rm_addr_or_subflow+0xb44/0xcc0 net/mptcp/pm_netlink.c:881
>     mptcp_pm_nl_rm_subflow_received net/mptcp/pm_netlink.c:914 [inline]
>     mptcp_nl_remove_id_zero_address+0x305/0x4a0 net/mptcp/pm_netlink.c:1572
>     mptcp_pm_nl_del_addr_doit+0x5c9/0x770 net/mptcp/pm_netlink.c:1603
>     genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
>     genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>     genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
>     netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2551
>     genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>     netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>     netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
>     netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
>     sock_sendmsg_nosec net/socket.c:729 [inline]
>     __sock_sendmsg net/socket.c:744 [inline]
>     ____sys_sendmsg+0x9ae/0xb40 net/socket.c:2607
>     ___sys_sendmsg+0x135/0x1e0 net/socket.c:2661
>     __sys_sendmsg+0x117/0x1f0 net/socket.c:2690
>     do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>     __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
>     do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>     entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>    RIP: 0023:0xf7fe4579
>    Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
>    RSP: 002b:00000000f574556c EFLAGS: 00000296 ORIG_RAX: 0000000000000172
>    RAX: ffffffffffffffda RBX: 000000000000000b RCX: 0000000020000140
>    RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>    RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>    R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
>    R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>     </TASK>
> 
>    Allocated by task 5387:
>     kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>     kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>     poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>     __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
>     kmalloc_noprof include/linux/slab.h:878 [inline]
>     kzalloc_noprof include/linux/slab.h:1014 [inline]
>     subflow_create_ctx+0x87/0x2a0 net/mptcp/subflow.c:1803
>     subflow_ulp_init+0xc3/0x4d0 net/mptcp/subflow.c:1956
>     __tcp_set_ulp net/ipv4/tcp_ulp.c:146 [inline]
>     tcp_set_ulp+0x326/0x7f0 net/ipv4/tcp_ulp.c:167
>     mptcp_subflow_create_socket+0x4ae/0x10a0 net/mptcp/subflow.c:1764
>     __mptcp_subflow_connect+0x3cc/0x1490 net/mptcp/subflow.c:1592
>     mptcp_pm_create_subflow_or_signal_addr+0xbda/0x23a0 net/mptcp/pm_netlink.c:642
>     mptcp_pm_nl_fully_established net/mptcp/pm_netlink.c:650 [inline]
>     mptcp_pm_nl_work+0x3a1/0x4f0 net/mptcp/pm_netlink.c:943
>     mptcp_worker+0x15a/0x1240 net/mptcp/protocol.c:2777
>     process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
>     process_scheduled_works kernel/workqueue.c:3310 [inline]
>     worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
>     kthread+0x2c1/0x3a0 kernel/kthread.c:389
>     ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>     ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
>    Freed by task 113:
>     kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>     kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>     kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
>     poison_slab_object mm/kasan/common.c:247 [inline]
>     __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
>     kasan_slab_free include/linux/kasan.h:230 [inline]
>     slab_free_hook mm/slub.c:2342 [inline]
>     slab_free mm/slub.c:4579 [inline]
>     kfree+0x14f/0x4b0 mm/slub.c:4727
>     kvfree+0x47/0x50 mm/util.c:701
>     kvfree_rcu_list+0xf5/0x2c0 kernel/rcu/tree.c:3423
>     kvfree_rcu_drain_ready kernel/rcu/tree.c:3563 [inline]
>     kfree_rcu_monitor+0x503/0x8b0 kernel/rcu/tree.c:3632
>     kfree_rcu_shrink_scan+0x245/0x3a0 kernel/rcu/tree.c:3966
>     do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
>     shrink_slab+0x32b/0x12a0 mm/shrinker.c:662
>     shrink_one+0x47e/0x7b0 mm/vmscan.c:4818
>     shrink_many mm/vmscan.c:4879 [inline]
>     lru_gen_shrink_node mm/vmscan.c:4957 [inline]
>     shrink_node+0x2452/0x39d0 mm/vmscan.c:5937
>     kswapd_shrink_node mm/vmscan.c:6765 [inline]
>     balance_pgdat+0xc19/0x18f0 mm/vmscan.c:6957
>     kswapd+0x5ea/0xbf0 mm/vmscan.c:7226
>     kthread+0x2c1/0x3a0 kernel/kthread.c:389
>     ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>     ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
>    Last potentially related work creation:
>     kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>     __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
>     kvfree_call_rcu+0x74/0xbe0 kernel/rcu/tree.c:3810
>     subflow_ulp_release+0x2ae/0x350 net/mptcp/subflow.c:2009
>     tcp_cleanup_ulp+0x7c/0x130 net/ipv4/tcp_ulp.c:124
>     tcp_v4_destroy_sock+0x1c5/0x6a0 net/ipv4/tcp_ipv4.c:2541
>     inet_csk_destroy_sock+0x1a3/0x440 net/ipv4/inet_connection_sock.c:1293
>     tcp_done+0x252/0x350 net/ipv4/tcp.c:4870
>     tcp_rcv_state_process+0x379b/0x4f30 net/ipv4/tcp_input.c:6933
>     tcp_v4_do_rcv+0x1ad/0xa90 net/ipv4/tcp_ipv4.c:1938
>     sk_backlog_rcv include/net/sock.h:1115 [inline]
>     __release_sock+0x31b/0x400 net/core/sock.c:3072
>     __tcp_close+0x4f3/0xff0 net/ipv4/tcp.c:3142
>     __mptcp_close_ssk+0x331/0x14d0 net/mptcp/protocol.c:2489
>     mptcp_close_ssk net/mptcp/protocol.c:2543 [inline]
>     mptcp_close_ssk+0x150/0x220 net/mptcp/protocol.c:2526
>     mptcp_pm_nl_rm_addr_or_subflow+0x2be/0xcc0 net/mptcp/pm_netlink.c:878
>     mptcp_pm_nl_rm_subflow_received net/mptcp/pm_netlink.c:914 [inline]
>     mptcp_nl_remove_id_zero_address+0x305/0x4a0 net/mptcp/pm_netlink.c:1572
>     mptcp_pm_nl_del_addr_doit+0x5c9/0x770 net/mptcp/pm_netlink.c:1603
>     genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
>     genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>     genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
>     netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2551
>     genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>     netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>     netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
>     netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
>     sock_sendmsg_nosec net/socket.c:729 [inline]
>     __sock_sendmsg net/socket.c:744 [inline]
>     ____sys_sendmsg+0x9ae/0xb40 net/socket.c:2607
>     ___sys_sendmsg+0x135/0x1e0 net/socket.c:2661
>     __sys_sendmsg+0x117/0x1f0 net/socket.c:2690
>     do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>     __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
>     do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>     entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> 
>    The buggy address belongs to the object at ffff8880569ac800
>     which belongs to the cache kmalloc-512 of size 512
>    The buggy address is located 88 bytes inside of
>     freed 512-byte region [ffff8880569ac800, ffff8880569aca00)
> 
>    The buggy address belongs to the physical page:
>    page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x569ac
>    head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>    flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
>    page_type: f5(slab)
>    raw: 04fff00000000040 ffff88801ac42c80 dead000000000100 dead000000000122
>    raw: 0000000000000000 0000000080100010 00000001f5000000 0000000000000000
>    head: 04fff00000000040 ffff88801ac42c80 dead000000000100 dead000000000122
>    head: 0000000000000000 0000000080100010 00000001f5000000 0000000000000000
>    head: 04fff00000000002 ffffea00015a6b01 ffffffffffffffff 0000000000000000
>    head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
>    page dumped because: kasan: bad access detected
>    page_owner tracks the page as allocated
>    page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 10238, tgid 10238 (kworker/u32:6), ts 597403252405, free_ts 597177952947
>     set_page_owner include/linux/page_owner.h:32 [inline]
>     post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
>     prep_new_page mm/page_alloc.c:1545 [inline]
>     get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
>     __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
>     alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
>     alloc_slab_page mm/slub.c:2412 [inline]
>     allocate_slab mm/slub.c:2578 [inline]
>     new_slab+0x2ba/0x3f0 mm/slub.c:2631
>     ___slab_alloc+0xd1d/0x16f0 mm/slub.c:3818
>     __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
>     __slab_alloc_node mm/slub.c:3961 [inline]
>     slab_alloc_node mm/slub.c:4122 [inline]
>     __kmalloc_cache_noprof+0x2c5/0x310 mm/slub.c:4290
>     kmalloc_noprof include/linux/slab.h:878 [inline]
>     kzalloc_noprof include/linux/slab.h:1014 [inline]
>     mld_add_delrec net/ipv6/mcast.c:743 [inline]
>     igmp6_leave_group net/ipv6/mcast.c:2625 [inline]
>     igmp6_group_dropped+0x4ab/0xe40 net/ipv6/mcast.c:723
>     __ipv6_dev_mc_dec+0x281/0x360 net/ipv6/mcast.c:979
>     addrconf_leave_solict net/ipv6/addrconf.c:2253 [inline]
>     __ipv6_ifa_notify+0x3f6/0xc30 net/ipv6/addrconf.c:6283
>     addrconf_ifdown.isra.0+0xef9/0x1a20 net/ipv6/addrconf.c:3982
>     addrconf_notify+0x220/0x19c0 net/ipv6/addrconf.c:3781
>     notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
>     call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1996
>     call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
>     call_netdevice_notifiers net/core/dev.c:2048 [inline]
>     dev_close_many+0x333/0x6a0 net/core/dev.c:1589
>    page last free pid 13136 tgid 13136 stack trace:
>     reset_page_owner include/linux/page_owner.h:25 [inline]
>     free_pages_prepare mm/page_alloc.c:1108 [inline]
>     free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
>     stack_depot_save_flags+0x2da/0x900 lib/stackdepot.c:666
>     kasan_save_stack+0x42/0x60 mm/kasan/common.c:48
>     kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>     unpoison_slab_object mm/kasan/common.c:319 [inline]
>     __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:345
>     kasan_slab_alloc include/linux/kasan.h:247 [inline]
>     slab_post_alloc_hook mm/slub.c:4085 [inline]
>     slab_alloc_node mm/slub.c:4134 [inline]
>     kmem_cache_alloc_noprof+0x121/0x2f0 mm/slub.c:4141
>     skb_clone+0x190/0x3f0 net/core/skbuff.c:2084
>     do_one_broadcast net/netlink/af_netlink.c:1462 [inline]
>     netlink_broadcast_filtered+0xb11/0xef0 net/netlink/af_netlink.c:1540
>     netlink_broadcast+0x39/0x50 net/netlink/af_netlink.c:1564
>     uevent_net_broadcast_untagged lib/kobject_uevent.c:331 [inline]
>     kobject_uevent_net_broadcast lib/kobject_uevent.c:410 [inline]
>     kobject_uevent_env+0xacd/0x1670 lib/kobject_uevent.c:608
>     device_del+0x623/0x9f0 drivers/base/core.c:3882
>     snd_card_disconnect.part.0+0x58a/0x7c0 sound/core/init.c:546
>     snd_card_disconnect+0x1f/0x30 sound/core/init.c:495
>     snd_usx2y_disconnect+0xe9/0x1f0 sound/usb/usx2y/usbusx2y.c:417
>     usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
>     device_remove drivers/base/dd.c:569 [inline]
>     device_remove+0x122/0x170 drivers/base/dd.c:561
> 
> That's because 'subflow' is used just after 'mptcp_close_ssk(subflow)',
> which will initiate the release of its memory. Even if it is very likely
> the release and the re-utilisation will be done later on, it is of
> course better to avoid any issues and read the content of 'subflow'
> before closing it.
> 
> Fixes: 1c1f72137598 ("mptcp: pm: only decrement add_addr_accepted for MPJ req")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+3c8b7a8e7df6a2a226ca@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/670d7337.050a0220.4cbc0.004f.GAE@google.com
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>   net/mptcp/pm_netlink.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index f6f0a38a0750f82bc909f02a75beec980d951f1f..4dd61284afc5f7f70708827056fb4530c8879502 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -873,12 +873,12 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
>   				 i, rm_id, id, remote_id, msk->mpc_endpoint_id);
>   			spin_unlock_bh(&msk->pm.lock);
>   			mptcp_subflow_shutdown(sk, ssk, how);
> +			removed |= subflow->request_join;
>   
>   			/* the following takes care of updating the subflows counter */
>   			mptcp_close_ssk(sk, ssk, subflow);
>   			spin_lock_bh(&msk->pm.lock);
>   
> -			removed |= subflow->request_join;
>   			if (rm_type == MPTCP_MIB_RMSUBFLOW)
>   				__MPTCP_INC_STATS(sock_net(sk), rm_type);
>   		}
> 

Acked-by: Paolo Abeni <pabeni@redhat.com>


