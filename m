Return-Path: <stable+bounces-132039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D63A837B3
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 06:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C242463596
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 04:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FB3202983;
	Thu, 10 Apr 2025 04:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjw7MoTV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907531F0E3C;
	Thu, 10 Apr 2025 04:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744258203; cv=none; b=raVdpd3sLy36X3HQvKKWpxh/on86p3ZT60ITNbTM82hAkNWg36qgkjZJzP8X05zgD4852q51ouFuS/eWlq/3lrmRDi6oWNwoourcTkQx5I8Jc9N4G3O70NpD/Fqu3m4Sn79ZzEF4XHBcJUkmO8TYVvQZNtx3kF5gVJAIwwdp0FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744258203; c=relaxed/simple;
	bh=e1aWT6dh170s8MiHDD2MzGXXLQwqhDLj44qxoDSx4Fo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XRaILr3VpvU3dbXCw1UwUyCiVxrjYZ8C7yEQ+ASzdEneylq6oW2fnwGgTzvukunTdyJofl3awoPxqDO6EMKJou0IziGGqayOtrUnIkW2P4zBfL3SJfQVmtRYNmP6alSz+rtRDJPrL+fl+Q7UaDKVCw4iegN5H4MCz1zV3j79Zik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjw7MoTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008D6C4CEEA;
	Thu, 10 Apr 2025 04:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744258203;
	bh=e1aWT6dh170s8MiHDD2MzGXXLQwqhDLj44qxoDSx4Fo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hjw7MoTVyA7r1w4TsNKxC6C+aXtOHzDgW67u9EiEgLBSVw8FzMxTFW6geMl3Iu7tm
	 fRKysTN1Sr7kpppAh38vyiMwR7GmCJ4OoaclguMYfOw5q9NvYzeVZEPYgPVWob4PiI
	 WA1wud6X2ttjZVCWNqe8DstxYfDgW7+uOglyM1ZIsHIgJlJhcA4++AURQca7cddPiZ
	 e1kLKdS82xOttnZgVPKFot9ueRcZmGCyX+Kaon+WG634+gZ7Bzs0c5qwWgMCKjda8o
	 iIHpMGL6DNg8twbeSy87aXBjlnD+4ygGlF1Jrzthnd2qgBqSg9o1dpofZRCuThjR0c
	 +11eDW0o8J0UQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF333380CEF9;
	Thu, 10 Apr 2025 04:10:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to do sanity check on ino and xnid
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174425824024.3146257.6460285688268624018.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 04:10:40 +0000
References: <20250324053339.2994251-1-chao@kernel.org>
In-Reply-To: <20250324053339.2994251-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, syzbot+cc448dcdc7ae0b4e4ffa@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 24 Mar 2025 13:33:39 +0800 you wrote:
> syzbot reported a f2fs bug as below:
> 
> INFO: task syz-executor140:5308 blocked for more than 143 seconds.
>       Not tainted 6.14.0-rc7-syzkaller-00069-g81e4f8d68c66 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor140 state:D stack:24016 pid:5308  tgid:5308  ppid:5306   task_flags:0x400140 flags:0x00000006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5378 [inline]
>  __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
>  __schedule_loop kernel/sched/core.c:6842 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6857
>  io_schedule+0x8d/0x110 kernel/sched/core.c:7690
>  folio_wait_bit_common+0x839/0xee0 mm/filemap.c:1317
>  __folio_lock mm/filemap.c:1664 [inline]
>  folio_lock include/linux/pagemap.h:1163 [inline]
>  __filemap_get_folio+0x147/0xb40 mm/filemap.c:1917
>  pagecache_get_page+0x2c/0x130 mm/folio-compat.c:87
>  find_get_page_flags include/linux/pagemap.h:842 [inline]
>  f2fs_grab_cache_page+0x2b/0x320 fs/f2fs/f2fs.h:2776
>  __get_node_page+0x131/0x11b0 fs/f2fs/node.c:1463
>  read_xattr_block+0xfb/0x190 fs/f2fs/xattr.c:306
>  lookup_all_xattrs fs/f2fs/xattr.c:355 [inline]
>  f2fs_getxattr+0x676/0xf70 fs/f2fs/xattr.c:533
>  __f2fs_get_acl+0x52/0x870 fs/f2fs/acl.c:179
>  f2fs_acl_create fs/f2fs/acl.c:375 [inline]
>  f2fs_init_acl+0xd7/0x9b0 fs/f2fs/acl.c:418
>  f2fs_init_inode_metadata+0xa0f/0x1050 fs/f2fs/dir.c:539
>  f2fs_add_inline_entry+0x448/0x860 fs/f2fs/inline.c:666
>  f2fs_add_dentry+0xba/0x1e0 fs/f2fs/dir.c:765
>  f2fs_do_add_link+0x28c/0x3a0 fs/f2fs/dir.c:808
>  f2fs_add_link fs/f2fs/f2fs.h:3616 [inline]
>  f2fs_mknod+0x2e8/0x5b0 fs/f2fs/namei.c:766
>  vfs_mknod+0x36d/0x3b0 fs/namei.c:4191
>  unix_bind_bsd net/unix/af_unix.c:1286 [inline]
>  unix_bind+0x563/0xe30 net/unix/af_unix.c:1379
>  __sys_bind_socket net/socket.c:1817 [inline]
>  __sys_bind+0x1e4/0x290 net/socket.c:1848
>  __do_sys_bind net/socket.c:1853 [inline]
>  __se_sys_bind net/socket.c:1851 [inline]
>  __x64_sys_bind+0x7a/0x90 net/socket.c:1851
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to do sanity check on ino and xnid
    https://git.kernel.org/jaegeuk/f2fs/c/061cf3a84bde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



