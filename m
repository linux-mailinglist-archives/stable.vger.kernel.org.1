Return-Path: <stable+bounces-116632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B678FA39002
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 01:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33F377A19CF
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 00:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE4312E7E;
	Tue, 18 Feb 2025 00:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOd7vDmm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72094EEC3;
	Tue, 18 Feb 2025 00:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739839203; cv=none; b=t7Jq8qaBvlvdEovYVgrpcqWKwogBY9GLeslZS6Dkjh9xP6fJOF5dJvayKHf3JRoQmTfR1aFWYIWJPLFRVJZ+i6dEuCIC6f/lW8smlQZia0U+ro5Gkdla/PqMibTPxbKa70JZ7bZ0BUVXoV2WeV5x3BCfWA2ROug64h2fdCpSg/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739839203; c=relaxed/simple;
	bh=V1WexgkaHOBQikIRrkTSn+Mq8VWyzkcWlkPtjI+FmYo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a0nZbAHjaoIJDIL/zUcohFqxgJ4XCy5X7J1NVoijGYqEYvLuVE0JQx3KC72LwrNyMohiaX6gqXgc1QiiOMw9ooznrC2fgckNFJ3s1uh5i1idu1dLAITmKgDnpxCjJ/dfdxhet8aeez+TymiWvItZwQAv42zby7aob8SQ6tCxbbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOd7vDmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCD7C4CED1;
	Tue, 18 Feb 2025 00:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739839202;
	bh=V1WexgkaHOBQikIRrkTSn+Mq8VWyzkcWlkPtjI+FmYo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UOd7vDmmrtglsNxb5yzLz0WBcyZLNT25SO++ONfXoBEGn9fWi0Y6UK9Q7n9O+J8R+
	 nlTo04rSl2sLPrI2rbfj4Tp2RI+AmVNOX0WvJ7PncUmztX9pUJm3V4Djh5y5SBPtLi
	 cTBIfpt87CkDHN5Jtg6VDYinPb0HjM2Id0DbOuzhzkOsHMYPw9BLvLwiyGM4YMQ3S0
	 eXtXV1EXEwSZK01z9Wpr3Jp2BRX1zsxKptDsOhUk23/mTCVNaCr6oXQ4J9ia+IjmnU
	 eJ2SInEpCqiVpR/txeQe6Y5xgnvEMyvU+JceMnkaPGNluWhzj97NPsxuU6yCVbmFFU
	 L9uvGfB+LECqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3496D380CEE2;
	Tue, 18 Feb 2025 00:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] drop_monitor: fix incorrect initialization order
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173983923302.3583210.2597018228565274704.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 00:40:33 +0000
References: <20250213152054.2785669-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20250213152054.2785669-1-Ilia.Gavrilov@infotecs.ru>
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: nhorman@tuxdriver.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Feb 2025 15:20:55 +0000 you wrote:
> Syzkaller reports the following bug:
> 
> BUG: spinlock bad magic on CPU#1, syz-executor.0/7995
>  lock: 0xffff88805303f3e0, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> CPU: 1 PID: 7995 Comm: syz-executor.0 Tainted: G            E     5.10.209+ #1
> Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x119/0x179 lib/dump_stack.c:118
>  debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
>  do_raw_spin_lock+0x1f6/0x270 kernel/locking/spinlock_debug.c:112
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:117 [inline]
>  _raw_spin_lock_irqsave+0x50/0x70 kernel/locking/spinlock.c:159
>  reset_per_cpu_data+0xe6/0x240 [drop_monitor]
>  net_dm_cmd_trace+0x43d/0x17a0 [drop_monitor]
>  genl_family_rcv_msg_doit+0x22f/0x330 net/netlink/genetlink.c:739
>  genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
>  genl_rcv_msg+0x341/0x5a0 net/netlink/genetlink.c:800
>  netlink_rcv_skb+0x14d/0x440 net/netlink/af_netlink.c:2497
>  genl_rcv+0x29/0x40 net/netlink/genetlink.c:811
>  netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
>  netlink_unicast+0x54b/0x800 net/netlink/af_netlink.c:1348
>  netlink_sendmsg+0x914/0xe00 net/netlink/af_netlink.c:1916
>  sock_sendmsg_nosec net/socket.c:651 [inline]
>  __sock_sendmsg+0x157/0x190 net/socket.c:663
>  ____sys_sendmsg+0x712/0x870 net/socket.c:2378
>  ___sys_sendmsg+0xf8/0x170 net/socket.c:2432
>  __sys_sendmsg+0xea/0x1b0 net/socket.c:2461
>  do_syscall_64+0x30/0x40 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x62/0xc7
> RIP: 0033:0x7f3f9815aee9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f3f972bf0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f3f9826d050 RCX: 00007f3f9815aee9
> RDX: 0000000020000000 RSI: 0000000020001300 RDI: 0000000000000007
> RBP: 00007f3f981b63bd R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000006e R14: 00007f3f9826d050 R15: 00007ffe01ee6768
> 
> [...]

Here is the summary with links:
  - [net,v2] drop_monitor: fix incorrect initialization order
    https://git.kernel.org/netdev/net/c/07b598c0e6f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



