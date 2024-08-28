Return-Path: <stable+bounces-71421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA218962C4A
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 17:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 020E4B2223A
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 15:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870F71A2C0C;
	Wed, 28 Aug 2024 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUqNmsuZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456271A0B05;
	Wed, 28 Aug 2024 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858803; cv=none; b=FD/Cij9kjrlhjOdRwgfJN7+OxT455K3xLGK+uEYRb62p9lu1Ssh6/aJL84AVYqBfm06DXNRpmSwRd/vQQg/Qf2x6ikGPsda9ZVlUaFpeqoWGPuIxGtc9HdufT3YtH1DpcA7L+/lZQG7fB72qGRzqNiV5Z5y2IgCcDpL6TCd8vg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858803; c=relaxed/simple;
	bh=k/WDgLr9ilvDDJLyAzEJMBsgISgafN8ICne+o59PpEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQVjr4SJzxK+WFA5HI+B5sivnEP8a9Wj36gh/ChCft0T62YXGhW1Un8yzAYXT22TS1u0XBMKiAWhq0zdo3JCTNBBFd8Yf5rfmcpkDPVOZ97fYQSH18Q1W+rMCgufCNbn8YfHSCaa2effACf/B5ssRRfO4qQf/l2qZ6uIVTaNDJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUqNmsuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7912DC51587;
	Wed, 28 Aug 2024 15:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724858802;
	bh=k/WDgLr9ilvDDJLyAzEJMBsgISgafN8ICne+o59PpEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lUqNmsuZvbVGjv7neQUwIXMLnFoL6zT9+9mJzsNv7nwZ9dwAlbNVa9DE6lHwFG3gG
	 I9Vf25s1nzhN06UW+1DtsfvSFa4N3YoOqPw1bHcRAHXFPUU5IvWElsm+Xw35LNLOLS
	 xGxXA0JraHYPCJSR5531sYWo1xcyyN8y32pT5CkhbavciuwPMAtNB78JkvGcEWMSnh
	 sCVfGAqx/cvoa09sqMVtVxs2ZtlW0CaGNUN7/mS8xzZAdvEp0RLSAiK/tFdAJzoPOe
	 /cXKbwnPCOHwFyZKAQg7eoOF0f7Y/YDB5/W56E1Aqdbed/AutgR5Yt66H5dgnp+zOf
	 cNZrvfYaRvFHA==
Date: Wed, 28 Aug 2024 15:26:40 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] f2fs: Do not check the FI_DIRTY_INODE flag when
 umounting a ro fs.
Message-ID: <Zs9BsP1UdFn4FoK5@google.com>
References: <000000000000b0231406204772a1@google.com>
 <20240827034324.339129-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827034324.339129-1-sunjunchao2870@gmail.com>

On 08/27, Julian Sun wrote:
> Hi, all.
> 
> Recently syzbot reported a bug as following:
> 
> kernel BUG at fs/f2fs/inode.c:896!
> CPU: 1 UID: 0 PID: 5217 Comm: syz-executor605 Not tainted 6.11.0-rc4-syzkaller-00033-g872cf28b8df9 #0
> RIP: 0010:f2fs_evict_inode+0x1598/0x15c0 fs/f2fs/inode.c:896
> Call Trace:
>  <TASK>
>  evict+0x532/0x950 fs/inode.c:704
>  dispose_list fs/inode.c:747 [inline]
>  evict_inodes+0x5f9/0x690 fs/inode.c:797
>  generic_shutdown_super+0x9d/0x2d0 fs/super.c:627
>  kill_block_super+0x44/0x90 fs/super.c:1696
>  kill_f2fs_super+0x344/0x690 fs/f2fs/super.c:4898
>  deactivate_locked_super+0xc4/0x130 fs/super.c:473
>  cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
>  task_work_run+0x24f/0x310 kernel/task_work.c:228
>  ptrace_notify+0x2d2/0x380 kernel/signal.c:2402
>  ptrace_report_syscall include/linux/ptrace.h:415 [inline]
>  ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
>  syscall_exit_work+0xc6/0x190 kernel/entry/common.c:173
>  syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
>  syscall_exit_to_user_mode+0x279/0x370 kernel/entry/common.c:218
>  do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The syzbot constructed the following scenario: concurrently
> creating directories and setting the file system to read-only.
> In this case, while f2fs was making dir, the filesystem switched to
> readonly, and when it tried to clear the dirty flag, it triggered this
> code path: f2fs_mkdir()-> f2fs_sync_fs()->f2fs_write_checkpoint()
> ->f2fs_readonly(). This resulted FI_DIRTY_INODE flag not being cleared,
> which eventually led to a bug being triggered during the FI_DIRTY_INODE
> check in f2fs_evict_inode().
> 
> In this case, we cannot do anything further, so if filesystem is readonly,
> do not trigger the BUG. Instead, clean up resources to the best of our
> ability to prevent triggering subsequent resource leak checks.
> 
> If there is anything important I'm missing, please let me know, thanks.
> 
> Reported-by: syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ebea2790904673d7c618
> Fixes: ca7d802a7d8e ("f2fs: detect dirty inode in evict_inode")
> CC: stable@vger.kernel.org
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> ---
>  fs/f2fs/inode.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index aef57172014f..52d273383ec2 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -892,8 +892,12 @@ void f2fs_evict_inode(struct inode *inode)
>  			atomic_read(&fi->i_compr_blocks));
>  
>  	if (likely(!f2fs_cp_error(sbi) &&
> -				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> -		f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));
> +				!is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
> +		if (!f2fs_readonly(sbi->sb))
> +			f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));
> +		else
> +			f2fs_inode_synced(inode);
> +	}
>  	else
>  		f2fs_inode_synced(inode);

What about:

  	if (likely(!f2fs_cp_error(sbi) &&
		   !is_sbi_flag_set(sbi, SBI_CP_DISABLED)) &&
		   !f2fs_readonly(sbi->sb)))
		f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));
	else
		f2fs_inode_synced(inode);

>

>  
> -- 
> 2.39.2

