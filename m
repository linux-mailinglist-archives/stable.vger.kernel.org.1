Return-Path: <stable+bounces-72948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 871FC96A9F2
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 23:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2981C247F5
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 21:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A711EC00F;
	Tue,  3 Sep 2024 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfWC6aO9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B891EC002
	for <stable@vger.kernel.org>; Tue,  3 Sep 2024 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725398411; cv=none; b=rDtyIw0e7VzsvRqCNE/Xhat5G0Av3gg3EWQL+7tNuHP+ZFiHWirrlpkCShbou96Bg9YmF8XdAD+H9KxBtgKnTP51PAZ4OTdN1gDGsON6TVsLZVUOoh3gFlcQh0Peb59Y5ZaM/Wpo4//jkETCmqEIBH/AueTQsuWyztZAVusMAhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725398411; c=relaxed/simple;
	bh=7PR1onCvY9iwE5xcIi2zi5rBXO7y/z3Wy0kK1IlVAcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmZJANnhMcAczD3A/Tl2hiWEjgJixh0JJ+8PbVkFJFwiJxc+bRUJQmwYLlV0pDe8qf5GviVz06kB4c/TxzMB2zEeD8YQ1H2gVJ6SnwkKJztjrnSJlpJmZMaGGi/zH7jA2Kczj0XWIVEpMZMRh5UtJEfLY39PJVdEYaP3qgr90Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfWC6aO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79269C4CEC4;
	Tue,  3 Sep 2024 21:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725398410;
	bh=7PR1onCvY9iwE5xcIi2zi5rBXO7y/z3Wy0kK1IlVAcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sfWC6aO9FmwQTIdAaLOJb4FED/z5uWjdMAYRw5UNmKcfK+Q9o5xLJNp7Vj6D+70Ep
	 /RwR2H/45N0+lu4KDz67dB+e26PWCtgjqzoqEXA/cQAK2FvC3iRCu/E+9HYxQksGmF
	 xOHPe9NGwWv6L1pbzsFZclM19EOEZ/mkYlpUEbffm3Yu0xfQVvskdkt8Y0vm8DZP/r
	 4wAkbLnLfmsgkHIKKxCn+qGINQb/B+IrUsm1WmZ9Xnw3FBQbk3jzGIHWcUrn30AO0E
	 sqTY8ONvnQ/WcdlwiVhXcU6qqx8F3P4rIYFDaZ9B02sOSwwAVGv3PkL9l7HWhOkN3r
	 0T/Yj3TeD4qvA==
Date: Tue, 3 Sep 2024 21:20:08 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Julian Sun <sunjunchao2870@gmail.com>,
	linux-f2fs-devel@lists.sourceforge.net,
	syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: Do not check the FI_DIRTY_INODE flag when
 umounting a ro fs.
Message-ID: <Ztd9iJI4ubmpc0_T@google.com>
References: <20240828165425.324845-1-sunjunchao2870@gmail.com>
 <0f1e5069-7ff0-4d5f-8a3a-3806c8d21487@kernel.org>
 <8edbc0b87074fb9adcccb8b67032dc3a693c9bfa.camel@gmail.com>
 <b20810a7-e8b3-4478-9805-624a33d70b09@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b20810a7-e8b3-4478-9805-624a33d70b09@kernel.org>

On 09/03, Chao Yu wrote:
> On 2024/9/2 21:01, Julian Sun wrote:
> > On Mon, 2024-09-02 at 16:13 +0800, Chao Yu wrote:
> > > > On 2024/8/29 0:54, Julian Sun wrote:
> > > > > > Hi, all.
> > > > > > 
> > > > > > Recently syzbot reported a bug as following:
> > > > > > 
> > > > > > kernel BUG at fs/f2fs/inode.c:896!
> > > > > > CPU: 1 UID: 0 PID: 5217 Comm: syz-executor605 Not tainted
> > > > > > 6.11.0-rc4-syzkaller-00033-g872cf28b8df9 #0
> > > > > > RIP: 0010:f2fs_evict_inode+0x1598/0x15c0 fs/f2fs/inode.c:896
> > > > > > Call Trace:
> > > > > >    <TASK>
> > > > > >    evict+0x532/0x950 fs/inode.c:704
> > > > > >    dispose_list fs/inode.c:747 [inline]
> > > > > >    evict_inodes+0x5f9/0x690 fs/inode.c:797
> > > > > >    generic_shutdown_super+0x9d/0x2d0 fs/super.c:627
> > > > > >    kill_block_super+0x44/0x90 fs/super.c:1696
> > > > > >    kill_f2fs_super+0x344/0x690 fs/f2fs/super.c:4898
> > > > > >    deactivate_locked_super+0xc4/0x130 fs/super.c:473
> > > > > >    cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
> > > > > >    task_work_run+0x24f/0x310 kernel/task_work.c:228
> > > > > >    ptrace_notify+0x2d2/0x380 kernel/signal.c:2402
> > > > > >    ptrace_report_syscall include/linux/ptrace.h:415 [inline]
> > > > > >    ptrace_report_syscall_exit include/linux/ptrace.h:477
> > > > > > [inline]
> > > > > >    syscall_exit_work+0xc6/0x190 kernel/entry/common.c:173
> > > > > >    syscall_exit_to_user_mode_prepare kernel/entry/common.c:200
> > > > > > [inline]
> > > > > >    __syscall_exit_to_user_mode_work kernel/entry/common.c:205
> > > > > > [inline]
> > > > > >    syscall_exit_to_user_mode+0x279/0x370
> > > > > > kernel/entry/common.c:218
> > > > > >    do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
> > > > > >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > > > 
> > > > > > The syzbot constructed the following scenario: concurrently
> > > > > > creating directories and setting the file system to read-only.
> > > > > > In this case, while f2fs was making dir, the filesystem
> > > > > > switched to
> > > > > > readonly, and when it tried to clear the dirty flag, it
> > > > > > triggered
> 
> Go back to the root cause, I have no idea why it can leave dirty inode
> while mkdir races w/ readonly remount, due to the two operations should
> be exclusive, IIUC.

Wait, we can think of writable disk mounted as fs-readonly. In that case,
IIRC, we allow to recover files/data by roll-forward and so on, which can
make some dirty inodes. Can we check if there's any missing path which does
not flush dirty inode?

> 
> - mkdir
>  - do_mkdirat
>   - filename_create
>    - mnt_want_write
>     - mnt_get_write_access
> 				- mount
> 				 - do_remount
> 				  - reconfigure_super
> 				   - sb_prepare_remount_readonly
> 				    - mnt_hold_writers
>   - vfs_mkdir
>    - f2fs_mkdir
> 
> But when I try to reproduce this bug w/ reproducer provided by syzbot,
> I have found a clue in the log:
> 
> "skip recovering inline_dots inode..."
> 
> So I doubt the root cause is __recover_dot_dentries() in f2fs_lookup()
> generates dirty data/meta, in this path, we will not grab related lock
> to exclude readonly remount.
> 
> Let me try to verify below patch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=wip&id=69dc8fbbbb39f85f9f436ca562c98afbcc2a48d2
> 
> Thanks,
> 
> > > > > > this
> > > > > > code path: f2fs_mkdir()-> f2fs_sync_fs()-
> > > > > > > f2fs_write_checkpoint()
> > > > > > ->f2fs_readonly(). This resulted FI_DIRTY_INODE flag not being
> > > > > > cleared,
> > > > > > which eventually led to a bug being triggered during the
> > > > > > FI_DIRTY_INODE
> > > > > > check in f2fs_evict_inode().
> > > > > > 
> > > > > > In this case, we cannot do anything further, so if filesystem
> > > > > > is
> > > > > > readonly,
> > > > > > do not trigger the BUG. Instead, clean up resources to the best
> > > > > > of
> > > > > > our
> > > > > > ability to prevent triggering subsequent resource leak checks.
> > > > > > 
> > > > > > If there is anything important I'm missing, please let me know,
> > > > > > thanks.
> > > > > > 
> > > > > > Reported-by:
> > > > > > syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com
> > > > > > Closes:
> > > > > > https://syzkaller.appspot.com/bug?extid=ebea2790904673d7c618
> > > > > > Fixes: ca7d802a7d8e ("f2fs: detect dirty inode in evict_inode")
> > > > > > CC: stable@vger.kernel.org
> > > > > > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > > > > > ---
> > > > > >    fs/f2fs/inode.c | 3 ++-
> > > > > >    1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > > > > > index aef57172014f..ebf825dba0a5 100644
> > > > > > --- a/fs/f2fs/inode.c
> > > > > > +++ b/fs/f2fs/inode.c
> > > > > > @@ -892,7 +892,8 @@ void f2fs_evict_inode(struct inode *inode)
> > > > > >                          atomic_read(&fi->i_compr_blocks));
> > > > > >          if (likely(!f2fs_cp_error(sbi) &&
> > > > > > -                               !is_sbi_flag_set(sbi,
> > > > > > SBI_CP_DISABLED)))
> > > > > > +                               !is_sbi_flag_set(sbi,
> > > > > > SBI_CP_DISABLED)) &&
> > > > > > +                               !f2fs_readonly(sbi->sb))
> > > > 
> > > > Is it fine to drop this dirty inode? Since once it remounts f2fs as
> > > > rw one,
> > > > previous updates on such inode may be lost? Or am I missing
> > > > something?
> > 
> > The purpose of calling this here is mainly to avoid triggering the
> > f2fs_bug_on(sbi, 1); statement in the subsequent f2fs_put_super() due
> > to a reference count check failure.
> > I would say it's possible, but there doesn't seem to be much more we
> > can do in this scenario: the inode is about to be freed, and the file
> > system is read-only. Or do we need a mechanism to save the inode that
> > is about to be freed and then write it back to disk at the appropriate
> > time after the file system becomes rw again? But such a mechanism
> > sounds somewhat complex and a little bit of weird... Do you have any
> > suggestions?
> 
> 
> 
> 
> > > > 
> > > > Thanks,
> > > > 
> > > > > >                  f2fs_bug_on(sbi, is_inode_flag_set(inode,
> > > > > > FI_DIRTY_INODE));
> > > > > >          else
> > > > > >                  f2fs_inode_synced(inode);
> > > > 
> > 
> > 
> > Thanks,

