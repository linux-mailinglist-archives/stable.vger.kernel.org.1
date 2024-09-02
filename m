Return-Path: <stable+bounces-72681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 801D3968173
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 10:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B101C21CBE
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 08:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B69E17E017;
	Mon,  2 Sep 2024 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rITedFPd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AB718C3E
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264813; cv=none; b=OQbfV4LHgEfiylrW95rRaslMqjOgyvDlObjc6mOehufgPl91WCHGSU4vqshooELPmrgCNRDnL2c7NiDA9YfrElkFqea/WXMYfwg0euBVVAQIjIseXhyOYO768Xm/OX1ivYTrxxCdB5aGOSdqJuMQjNF1kwBairdWd8tcJUAz2yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264813; c=relaxed/simple;
	bh=F6vs45rHNeph1oTKE2f2kjgTNGniVmqFJlmqSB39dkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RtclDsdDx/jNRJWsIwQ98AgoXmraALhua6BxGNC/8VuSg5YmtIbfqMc9KgAZf9mEXYju+91a0qjU1GvEt3ccoIkLZK9BXnoHTfG7o1i689zhj9Q593MvFpCdFM0Q4w9jGA6u+3rWwalvFDUdfTANsTneJHY1TMaWvjNOaMYEZx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rITedFPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F65C4CEC8;
	Mon,  2 Sep 2024 08:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725264812;
	bh=F6vs45rHNeph1oTKE2f2kjgTNGniVmqFJlmqSB39dkA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rITedFPdMCrORPmGDNJWgoiHajp3uO4bZ0+HUZ3A2X2YFi6S/U8qeRB7d7h/ETnso
	 aKFaFPmr3eLLPEZC2Zqqd99KmJ5wJtb3L6AG4k8Tmqx5m+s94Cxs/cKEpt7zb1jZXS
	 k4fOtsiwm1b5UbFfKY7cZtg3f6Sjt0OG4DhzQ4JoK8OdRcdxTzG6RiBjj92swXJdfZ
	 lSn4souNCRQTdNyOkVt9tyfUDRiOxRT1ebecGRVeVQhGhVZOTjFYzi4CDvIMGQHwxt
	 WUOkNPzOrO0Euk1Ub5B05SMpOlD4f8/i/4NKbvM25zaXG88IGUvKoNdz0tAM5Wlj+s
	 rVMeepLDywEYw==
Message-ID: <0f1e5069-7ff0-4d5f-8a3a-3806c8d21487@kernel.org>
Date: Mon, 2 Sep 2024 16:13:28 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] f2fs: Do not check the FI_DIRTY_INODE flag when
 umounting a ro fs.
To: Julian Sun <sunjunchao2870@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org,
 syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20240828165425.324845-1-sunjunchao2870@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240828165425.324845-1-sunjunchao2870@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/29 0:54, Julian Sun wrote:
> Hi, all.
> 
> Recently syzbot reported a bug as following:
> 
> kernel BUG at fs/f2fs/inode.c:896!
> CPU: 1 UID: 0 PID: 5217 Comm: syz-executor605 Not tainted 6.11.0-rc4-syzkaller-00033-g872cf28b8df9 #0
> RIP: 0010:f2fs_evict_inode+0x1598/0x15c0 fs/f2fs/inode.c:896
> Call Trace:
>   <TASK>
>   evict+0x532/0x950 fs/inode.c:704
>   dispose_list fs/inode.c:747 [inline]
>   evict_inodes+0x5f9/0x690 fs/inode.c:797
>   generic_shutdown_super+0x9d/0x2d0 fs/super.c:627
>   kill_block_super+0x44/0x90 fs/super.c:1696
>   kill_f2fs_super+0x344/0x690 fs/f2fs/super.c:4898
>   deactivate_locked_super+0xc4/0x130 fs/super.c:473
>   cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
>   task_work_run+0x24f/0x310 kernel/task_work.c:228
>   ptrace_notify+0x2d2/0x380 kernel/signal.c:2402
>   ptrace_report_syscall include/linux/ptrace.h:415 [inline]
>   ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
>   syscall_exit_work+0xc6/0x190 kernel/entry/common.c:173
>   syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
>   __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
>   syscall_exit_to_user_mode+0x279/0x370 kernel/entry/common.c:218
>   do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
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
>   fs/f2fs/inode.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index aef57172014f..ebf825dba0a5 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -892,7 +892,8 @@ void f2fs_evict_inode(struct inode *inode)
>   			atomic_read(&fi->i_compr_blocks));
>   
>   	if (likely(!f2fs_cp_error(sbi) &&
> -				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> +				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)) &&
> +				!f2fs_readonly(sbi->sb))

Is it fine to drop this dirty inode? Since once it remounts f2fs as rw one,
previous updates on such inode may be lost? Or am I missing something?

Thanks,

>   		f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));
>   	else
>   		f2fs_inode_synced(inode);


