Return-Path: <stable+bounces-86591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2F19A1F9F
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 12:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E18BB21B78
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 10:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B4B1DA618;
	Thu, 17 Oct 2024 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLQCcGFy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890031D935A;
	Thu, 17 Oct 2024 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729160428; cv=none; b=hLALI2B4V/NieSTNp1tPCmINUMgsa3/Wal3hm16V8ombUDvdT9ec4zdt/fTFU3hcZ3CLfqvHgTEIIydHaiSZ6Qk5JGsaF35HK66zM2uNTkItXPARt608oeK/eIj4ZC5CjxKDhX1la2ygtwyPRcd32pHdvH1luTxK9GwujI4zIDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729160428; c=relaxed/simple;
	bh=ndP+iB2hmNRCPOi06NCrya9V0ZRJHgRycSPwBDTjQas=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nn2LXvFhZ6Vs4QNSs2upQgQHPP7v9tKmrcmA+ppuklQnp3GmPTDOPq7qN2Khk6kmsislWrDtblVhPdbHJu+u9AHINbhFa5nyblUSYssK4GiR58Dmf5jG1h6kfN0xv+zs6lk+cUywceUTt92yH5NnV8jmtqdNQKqMqJ9Z7WH6qwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLQCcGFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FFBC4CEC3;
	Thu, 17 Oct 2024 10:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729160426;
	bh=ndP+iB2hmNRCPOi06NCrya9V0ZRJHgRycSPwBDTjQas=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vLQCcGFylaz/L4zohdXOi/zPUjYY3gjwCpPLi5d5x26q/Fgsw1800u8wBTPNNFIwj
	 2qNi3DzWQZsqgYESY5w9G+gm2fQT7cdHNYbdK0aEhRb4iULaj4m01Hpjdh9s8RvqZ/
	 6qRQ4I6TZzWIQQi6Q4pMTZpKeexHT6sV1LqTs/1+yzaWWg/ZydiCByqxhMyIWRbZWI
	 zh081GcdQ6zuDgt7IfMbc5mL+U7WRdlY+qeNSpxv+7RuqpXruMRMbuyyEkdcTIph3X
	 sFlcLGWZm/X9kRPuesFIYzAz6wbpSIJ7TOjwJ++1LoHcBrEhDA678wKR6SYZv3Vwk9
	 VVyeVh9MZiirA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE24F3805CC0;
	Thu, 17 Oct 2024 10:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mptcp: pm: fix UaF read in
 mptcp_pm_nl_rm_addr_or_subflow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172916043148.2424677.15397767732397939566.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 10:20:31 +0000
References: <20241015-net-mptcp-uaf-pm-rm-v1-1-c4ee5d987a64@kernel.org>
In-Reply-To: <20241015-net-mptcp-uaf-pm-rm-v1-1-c4ee5d987a64@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+3c8b7a8e7df6a2a226ca@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Oct 2024 10:38:47 +0200 you wrote:
> Syzkaller reported this splat:
> 
>   ==================================================================
>   BUG: KASAN: slab-use-after-free in mptcp_pm_nl_rm_addr_or_subflow+0xb44/0xcc0 net/mptcp/pm_netlink.c:881
>   Read of size 4 at addr ffff8880569ac858 by task syz.1.2799/14662
> 
>   CPU: 0 UID: 0 PID: 14662 Comm: syz.1.2799 Not tainted 6.12.0-rc2-syzkaller-00307-g36c254515dc6 #0
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>   Call Trace:
>    <TASK>
>    __dump_stack lib/dump_stack.c:94 [inline]
>    dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>    print_address_description mm/kasan/report.c:377 [inline]
>    print_report+0xc3/0x620 mm/kasan/report.c:488
>    kasan_report+0xd9/0x110 mm/kasan/report.c:601
>    mptcp_pm_nl_rm_addr_or_subflow+0xb44/0xcc0 net/mptcp/pm_netlink.c:881
>    mptcp_pm_nl_rm_subflow_received net/mptcp/pm_netlink.c:914 [inline]
>    mptcp_nl_remove_id_zero_address+0x305/0x4a0 net/mptcp/pm_netlink.c:1572
>    mptcp_pm_nl_del_addr_doit+0x5c9/0x770 net/mptcp/pm_netlink.c:1603
>    genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
>    genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>    genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
>    netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2551
>    genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>    netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>    netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
>    netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
>    sock_sendmsg_nosec net/socket.c:729 [inline]
>    __sock_sendmsg net/socket.c:744 [inline]
>    ____sys_sendmsg+0x9ae/0xb40 net/socket.c:2607
>    ___sys_sendmsg+0x135/0x1e0 net/socket.c:2661
>    __sys_sendmsg+0x117/0x1f0 net/socket.c:2690
>    do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>    __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
>    do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>    entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>   RIP: 0023:0xf7fe4579
>   Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
>   RSP: 002b:00000000f574556c EFLAGS: 00000296 ORIG_RAX: 0000000000000172
>   RAX: ffffffffffffffda RBX: 000000000000000b RCX: 0000000020000140
>   RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>   RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>   R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
>   R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>    </TASK>
> 
> [...]

Here is the summary with links:
  - [net] mptcp: pm: fix UaF read in mptcp_pm_nl_rm_addr_or_subflow
    https://git.kernel.org/netdev/net/c/7decd1f5904a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



