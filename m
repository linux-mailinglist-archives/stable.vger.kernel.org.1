Return-Path: <stable+bounces-132673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E538A88FDC
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 00:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42DF3A555C
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 22:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420141F3BBB;
	Mon, 14 Apr 2025 22:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwZEtazG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0088F201100;
	Mon, 14 Apr 2025 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744671421; cv=none; b=baLuPyJKyu7AZQrjbfcobxWdFSlPbmCfGet4S6NL5EufZvRElyfLVn+cfxhH7sYbRtQgG8dqcT2mokAcxLBtktOcf7kVodYotJxUOS+qVWAmJDwMt7jxF6tAofBAsCaZBSVkQ8QLfK9LlnphX9z4kjy5gah7upsuKXs2jctXhzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744671421; c=relaxed/simple;
	bh=O8Cg+UG/jr/Kl6PFms4D8O0Iw2r6nd/5sC7AS9OipL0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JP72UpS5fL2+Jq8sNBRU6ABU+auRyhvLR/e59PrZ2uWLgTpOn0xu1zu9z1USuszg9Fed0uxY4aLkzGFOM9lfyW6vjntzZZzgGW88Amd8xZgZb0qF3sneZQd9KfN7kv1HhLX0lTc2IYrzsZFoDdCRASgILj0e6Wc2/iBtwh8JLxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwZEtazG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E61C4CEE2;
	Mon, 14 Apr 2025 22:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744671420;
	bh=O8Cg+UG/jr/Kl6PFms4D8O0Iw2r6nd/5sC7AS9OipL0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iwZEtazGwIwnf1+eHRLraxUGavhdd4vcGyb8TYMUBGZfsBMB8wbyxPlDn/Q2yDUqy
	 uKBCdLCOo5CwKKS+pJ0xwdj8qOKiU9C6+wretJqKCIlCSs3fKIS5HuMCgpwFQXSoWc
	 ROkB1Ut0j5PH98ZDCw1i/p+VGpZiEuwd+lBTsW0Zs1GWqhte2mKR3BOqmkM4pcP34H
	 JW5zzIofKiNKPTKT5gN1DMKeaHej35mmuH+S73f9ebdU+rLdhkSJP73d82nFh3BnwE
	 NZrigqBcvLgtBsvEwq0iZ/0o8HhwSs9rsvlNBlWkSs6aR5edT1ogEr13LwtctB20yY
	 cmwAftB3zhbDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD6E3822D1A;
	Mon, 14 Apr 2025 22:57:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: prevent kernel warning due to negative
 i_nlink from corrupted image
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174467145850.2060374.10714533632161359459.git-patchwork-notify@kernel.org>
Date: Mon, 14 Apr 2025 22:57:38 +0000
References: <20250412214226.2907676-1-jaegeuk@kernel.org>
In-Reply-To: <20250412214226.2907676-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 stable@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat, 12 Apr 2025 21:42:26 +0000 you wrote:
> WARNING: CPU: 1 PID: 9426 at fs/inode.c:417 drop_nlink+0xac/0xd0
> home/cc/linux/fs/inode.c:417
> Modules linked in:
> CPU: 1 UID: 0 PID: 9426 Comm: syz-executor568 Not tainted
> 6.14.0-12627-g94d471a4f428 #2 PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:drop_nlink+0xac/0xd0 home/cc/linux/fs/inode.c:417
> Code: 48 8b 5d 28 be 08 00 00 00 48 8d bb 70 07 00 00 e8 f9 67 e6 ff
> f0 48 ff 83 70 07 00 00 5b 5d e9 9a 12 82 ff e8 95 12 82 ff 90
> &lt;0f&gt; 0b 90 c7 45 48 ff ff ff ff 5b 5d e9 83 12 82 ff e8 fe 5f e6
> ff
> RSP: 0018:ffffc900026b7c28 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8239710f
> RDX: ffff888041345a00 RSI: ffffffff8239717b RDI: 0000000000000005
> RBP: ffff888054509ad0 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: ffffffff9ab36f08 R12: ffff88804bb40000
> R13: ffff8880545091e0 R14: 0000000000008000 R15: ffff8880545091e0
> FS:  000055555d0c5880(0000) GS:ffff8880eb3e3000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f915c55b178 CR3: 0000000050d20000 CR4: 0000000000352ef0
> Call Trace:
>  <task>
>  f2fs_i_links_write home/cc/linux/fs/f2fs/f2fs.h:3194 [inline]
>  f2fs_drop_nlink+0xd1/0x3c0 home/cc/linux/fs/f2fs/dir.c:845
>  f2fs_delete_entry+0x542/0x1450 home/cc/linux/fs/f2fs/dir.c:909
>  f2fs_unlink+0x45c/0x890 home/cc/linux/fs/f2fs/namei.c:581
>  vfs_unlink+0x2fb/0x9b0 home/cc/linux/fs/namei.c:4544
>  do_unlinkat+0x4c5/0x6a0 home/cc/linux/fs/namei.c:4608
>  __do_sys_unlink home/cc/linux/fs/namei.c:4654 [inline]
>  __se_sys_unlink home/cc/linux/fs/namei.c:4652 [inline]
>  __x64_sys_unlink+0xc5/0x110 home/cc/linux/fs/namei.c:4652
>  do_syscall_x64 home/cc/linux/arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xc7/0x250 home/cc/linux/arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fb3d092324b
> Code: 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66
> 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 57 00 00 00 0f 05
> &lt;48&gt; 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01
> 48
> RSP: 002b:00007ffdc232d938 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb3d092324b
> RDX: 00007ffdc232d960 RSI: 00007ffdc232d960 RDI: 00007ffdc232d9f0
> RBP: 00007ffdc232d9f0 R08: 0000000000000001 R09: 00007ffdc232d7c0
> R10: 00000000fffffffd R11: 0000000000000206 R12: 00007ffdc232eaf0
> R13: 000055555d0cebb0 R14: 00007ffdc232d958 R15: 0000000000000001
>  </task>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: prevent kernel warning due to negative i_nlink from corrupted image
    https://git.kernel.org/jaegeuk/f2fs/c/42cb74a92ada

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



