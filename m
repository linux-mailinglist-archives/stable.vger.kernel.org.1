Return-Path: <stable+bounces-199991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B1CCA333B
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 11:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85AE3302016B
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 10:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1E92DAFA8;
	Thu,  4 Dec 2025 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftMwOJ3K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C4A1C28E;
	Thu,  4 Dec 2025 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764843787; cv=none; b=CvgCeEO5JNo+Ll0cp+WO1MxT0nZPvLgbHSQSRemNWrsu7pV9A5V46i7hH/5cWHlUwOb4AI7qtsmlZL+zrz8k4w++7Gdn5/CovElPcI09kRDonBTYCFliUbef6KC0wCQIVUFo8iZjGU03tacF1aLlk9tyw3+ADfQ28MtUgzpnpc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764843787; c=relaxed/simple;
	bh=3iWgpvWwBbytpY9cQwdNWXJ+A62+Nlt6nuF09p4zyBY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PmPiYqRDs0nArUc3Hvd9AMZKKHZhw0zTKBIF3xKPr1csUmD/EM6PeEdp4jQew7yuhjTy+IRRyJh1OVo2kDWzyCAuuW4QIwXbXZJmrYtmU7yBR1/aFbuTUTUEcvqgyWyDJos+aE+zLEzZGOGJEftS4B1ICrEqew4rAXIdwxMoX/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftMwOJ3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4B6C4CEFB;
	Thu,  4 Dec 2025 10:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764843787;
	bh=3iWgpvWwBbytpY9cQwdNWXJ+A62+Nlt6nuF09p4zyBY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ftMwOJ3Ka+ViFJHX2Qa31FBZ1yqjDGmECs17+He0c4dn49b4ONHxrQoLiWfmLxCUj
	 wZ74PRVm/G/d6tU/7j6rRVUTkPsjbmDM1iMd/b02zmmMNzM5kLzJa3wTcXqPgUlPrz
	 Nzvenb3GBwrgYof4LFRsz38vTto37AaG+ucrxqqm92x4k4BAcuU302PvLBfrmxg0Tg
	 LbOnNqZyqgaLzcMryjvE5y3JmwEaaKkFuIe+RgwvknJFEYbiVos4YVLSrm144NZ8Eo
	 gASIjFH0A1lh98CtBQK+zJKfXEdMQw22TzJfqsJ2YJyZcydxawVm5CBiTYKdOgleha
	 nJpFI/LriJ+KQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A3D3AA9A9C;
	Thu,  4 Dec 2025 10:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net/hsr: fix NULL pointer dereference in
 prp_get_untagged_frame()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176484360579.718719.17275039273482574777.git-patchwork-notify@kernel.org>
Date: Thu, 04 Dec 2025 10:20:05 +0000
References: <20251129093718.25320-1-ssrane_b23@ee.vjti.ac.in>
In-Reply-To: <20251129093718.25320-1-ssrane_b23@ee.vjti.ac.in>
To: SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jkarrenpalo@gmail.com,
 fmaurer@redhat.com, arvid.brodin@alten.se, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
 khalid@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 29 Nov 2025 15:07:18 +0530 you wrote:
> prp_get_untagged_frame() calls __pskb_copy() to create frame->skb_std
> but doesn't check if the allocation failed. If __pskb_copy() returns
> NULL, skb_clone() is called with a NULL pointer, causing a crash:
> Oops: general protection fault, probably for non-canonical address 0xdffffc000000000f: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000078-0x000000000000007f]
> CPU: 0 UID: 0 PID: 5625 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:skb_clone+0xd7/0x3a0 net/core/skbuff.c:2041
> Code: 03 42 80 3c 20 00 74 08 4c 89 f7 e8 23 29 05 f9 49 83 3e 00 0f 85 a0 01 00 00 e8 94 dd 9d f8 48 8d 6b 7e 49 89 ee 49 c1 ee 03 <43> 0f b6 04 26 84 c0 0f 85 d1 01 00 00 44 0f b6 7d 00 41 83 e7 0c
> RSP: 0018:ffffc9000d00f200 EFLAGS: 00010207
> RAX: ffffffff892235a1 RBX: 0000000000000000 RCX: ffff88803372a480
> RDX: 0000000000000000 RSI: 0000000000000820 RDI: 0000000000000000
> RBP: 000000000000007e R08: ffffffff8f7d0f77 R09: 1ffffffff1efa1ee
> R10: dffffc0000000000 R11: fffffbfff1efa1ef R12: dffffc0000000000
> R13: 0000000000000820 R14: 000000000000000f R15: ffff88805144cc00
> FS:  0000555557f6d500(0000) GS:ffff88808d72f000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000555581d35808 CR3: 000000005040e000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  hsr_forward_do net/hsr/hsr_forward.c:-1 [inline]
>  hsr_forward_skb+0x1013/0x2860 net/hsr/hsr_forward.c:741
>  hsr_handle_frame+0x6ce/0xa70 net/hsr/hsr_slave.c:84
>  __netif_receive_skb_core+0x10b9/0x4380 net/core/dev.c:5966
>  __netif_receive_skb_one_core net/core/dev.c:6077 [inline]
>  __netif_receive_skb+0x72/0x380 net/core/dev.c:6192
>  netif_receive_skb_internal net/core/dev.c:6278 [inline]
>  netif_receive_skb+0x1cb/0x790 net/core/dev.c:6337
>  tun_rx_batched+0x1b9/0x730 drivers/net/tun.c:1485
>  tun_get_user+0x2b65/0x3e90 drivers/net/tun.c:1953
>  tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1999
>  new_sync_write fs/read_write.c:593 [inline]
>  vfs_write+0x5c9/0xb30 fs/read_write.c:686
>  ksys_write+0x145/0x250 fs/read_write.c:738
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f0449f8e1ff
> Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 f9 92 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 4c 93 02 00 48
> RSP: 002b:00007ffd7ad94c90 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f044a1e5fa0 RCX: 00007f0449f8e1ff
> RDX: 000000000000003e RSI: 0000200000000500 RDI: 00000000000000c8
> RBP: 00007ffd7ad94d20 R08: 0000000000000000 R09: 0000000000000000
> R10: 000000000000003e R11: 0000000000000293 R12: 0000000000000001
> R13: 00007f044a1e5fa0 R14: 00007f044a1e5fa0 R15: 0000000000000003
>  </TASK>
> Add a NULL check immediately after __pskb_copy() to handle allocation
> failures gracefully.
> 
> [...]

Here is the summary with links:
  - [net,v3] net/hsr: fix NULL pointer dereference in prp_get_untagged_frame()
    https://git.kernel.org/netdev/net/c/188e0fa5a679

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



