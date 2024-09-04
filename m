Return-Path: <stable+bounces-73090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 803D196C1BB
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 17:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A497B1C21EA1
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 15:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31F41DC723;
	Wed,  4 Sep 2024 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHls62bu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62561DDCD
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462404; cv=none; b=d/dPt3RW/BapMqIP2peUniHwkI2deksU2ttpoq/npMNti0B/DY7gICnoFqlUL9GYLVyHRor3hcEJ2/AB3kzEdOTRFSSMUW7Of5eWxZgosUOhLk4fP+edlgUYVJv21e4mcKG7GeaivDXmIkV1zTZmAcIR3Sp4NO3WORZsaXYuM0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462404; c=relaxed/simple;
	bh=TEfrXJ4O9S3AYRQMn8oDiwOTMf8cw1Cvb2GbkdyH7hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/HfIrXS8mrmVdVtgDLZRVjgjVO77KnX9pKYVJlR/DdptIIkNs5S3urAXwH7ttNkj0i8F2Qq7wwm0u897wwyemA3nZLg/YWvUyy9Be6H6VQ3CBw9FTnRni7shs3am+TcC788FUEiEm4jFnAyhqbNcyVL2Iwke+rvz5URCgBOefw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHls62bu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6DEC4CEC2;
	Wed,  4 Sep 2024 15:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725462404;
	bh=TEfrXJ4O9S3AYRQMn8oDiwOTMf8cw1Cvb2GbkdyH7hw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IHls62bu3EvxbI3Rd3MHvEmNOWikLGivHvIHcJpS80WCcIyVsTXffgBf1u6meZRrE
	 McvKPo4xOu2OWjwJrKwFcQWq5MLLU0FOBerhCq/D277VKznfJIVyUu1wSXoEXkudGc
	 06J5gG9S/+w66xjMQHSEGYE0y2xM/4vdQx+ZjU3p8tiRD6clGigxjug2tK773V479f
	 4iwQO2RjKbXtKhoXw/UzJ0dsYEztmuw3TvIl563pOo/lPLYf6rEnRfzylUCsuqRr7M
	 /Bhs0wgsOHl7eP1URUxVo5JvQiQMpnWCCTFj9l6eH1mZoXrnvAlO4+93gMjpiSyxb7
	 YKRRr1LYLkNAw==
Message-ID: <db0f8aef-a5af-4da9-b6ae-4fb60d0bfc4f@kernel.org>
Date: Wed, 4 Sep 2024 23:06:38 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] f2fs: Do not check the FI_DIRTY_INODE flag when
 umounting a ro fs.
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Julian Sun <sunjunchao2870@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net,
 syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20240828165425.324845-1-sunjunchao2870@gmail.com>
 <0f1e5069-7ff0-4d5f-8a3a-3806c8d21487@kernel.org>
 <8edbc0b87074fb9adcccb8b67032dc3a693c9bfa.camel@gmail.com>
 <b20810a7-e8b3-4478-9805-624a33d70b09@kernel.org>
 <Ztd9iJI4ubmpc0_T@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
Autocrypt: addr=chao@kernel.org; keydata=
 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
In-Reply-To: <Ztd9iJI4ubmpc0_T@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/9/4 5:20, Jaegeuk Kim wrote:
> On 09/03, Chao Yu wrote:
>> On 2024/9/2 21:01, Julian Sun wrote:
>>> On Mon, 2024-09-02 at 16:13 +0800, Chao Yu wrote:
>>>>> On 2024/8/29 0:54, Julian Sun wrote:
>>>>>>> Hi, all.
>>>>>>>
>>>>>>> Recently syzbot reported a bug as following:
>>>>>>>
>>>>>>> kernel BUG at fs/f2fs/inode.c:896!
>>>>>>> CPU: 1 UID: 0 PID: 5217 Comm: syz-executor605 Not tainted
>>>>>>> 6.11.0-rc4-syzkaller-00033-g872cf28b8df9 #0
>>>>>>> RIP: 0010:f2fs_evict_inode+0x1598/0x15c0 fs/f2fs/inode.c:896
>>>>>>> Call Trace:
>>>>>>>     <TASK>
>>>>>>>     evict+0x532/0x950 fs/inode.c:704
>>>>>>>     dispose_list fs/inode.c:747 [inline]
>>>>>>>     evict_inodes+0x5f9/0x690 fs/inode.c:797
>>>>>>>     generic_shutdown_super+0x9d/0x2d0 fs/super.c:627
>>>>>>>     kill_block_super+0x44/0x90 fs/super.c:1696
>>>>>>>     kill_f2fs_super+0x344/0x690 fs/f2fs/super.c:4898
>>>>>>>     deactivate_locked_super+0xc4/0x130 fs/super.c:473
>>>>>>>     cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
>>>>>>>     task_work_run+0x24f/0x310 kernel/task_work.c:228
>>>>>>>     ptrace_notify+0x2d2/0x380 kernel/signal.c:2402
>>>>>>>     ptrace_report_syscall include/linux/ptrace.h:415 [inline]
>>>>>>>     ptrace_report_syscall_exit include/linux/ptrace.h:477
>>>>>>> [inline]
>>>>>>>     syscall_exit_work+0xc6/0x190 kernel/entry/common.c:173
>>>>>>>     syscall_exit_to_user_mode_prepare kernel/entry/common.c:200
>>>>>>> [inline]
>>>>>>>     __syscall_exit_to_user_mode_work kernel/entry/common.c:205
>>>>>>> [inline]
>>>>>>>     syscall_exit_to_user_mode+0x279/0x370
>>>>>>> kernel/entry/common.c:218
>>>>>>>     do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>>>>>>>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>>>>>
>>>>>>> The syzbot constructed the following scenario: concurrently
>>>>>>> creating directories and setting the file system to read-only.
>>>>>>> In this case, while f2fs was making dir, the filesystem
>>>>>>> switched to
>>>>>>> readonly, and when it tried to clear the dirty flag, it
>>>>>>> triggered
>>
>> Go back to the root cause, I have no idea why it can leave dirty inode
>> while mkdir races w/ readonly remount, due to the two operations should
>> be exclusive, IIUC.
> 
> Wait, we can think of writable disk mounted as fs-readonly. In that case,
> IIRC, we allow to recover files/data by roll-forward and so on, which can

We will remove SB_RDONLY flag from sb->s_flags intentionally before
recovery, so that following write_checkpoint() or sync_filesystem()
won't skip flushing due to sb is readonly.

static bool f2fs_recover_quota_begin(struct f2fs_sb_info *sbi)
{
...
	if (readonly) {
		sbi->sb->s_flags &= ~SB_RDONLY;
		set_sbi_flag(sbi, SBI_IS_WRITABLE);
	}
...
}

> make some dirty inodes. Can we check if there's any missing path which does
> not flush dirty inode?

I guess the root cause of this issue is like this:

- f2fs_lookup
  - __recover_dot_dentries()
   - clear_inode_flag(dir, FI_INLINE_DOTS)
    - __mark_inode_dirty_flag()
					- remount rdonly
					 - sb->s_flags |= SB_RDONLY

- umount
  - kill_f2fs_super
   - kill_block_super
    - generic_shutdown_super
     - sync_filesystem skips due to sb_rdonly is true
     - evict_inodes
      - dispose_list
       - f2fs_evict_inode panic

So how about this?

https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=wip&id=e080fc8bec4d674cb8eb26ef0a0432f88bd65dd0

Thanks,

> 
>>
>> - mkdir
>>   - do_mkdirat
>>    - filename_create
>>     - mnt_want_write
>>      - mnt_get_write_access
>> 				- mount
>> 				 - do_remount
>> 				  - reconfigure_super
>> 				   - sb_prepare_remount_readonly
>> 				    - mnt_hold_writers
>>    - vfs_mkdir
>>     - f2fs_mkdir
>>
>> But when I try to reproduce this bug w/ reproducer provided by syzbot,
>> I have found a clue in the log:
>>
>> "skip recovering inline_dots inode..."
>>
>> So I doubt the root cause is __recover_dot_dentries() in f2fs_lookup()
>> generates dirty data/meta, in this path, we will not grab related lock
>> to exclude readonly remount.
>>
>> Let me try to verify below patch:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=wip&id=69dc8fbbbb39f85f9f436ca562c98afbcc2a48d2
>>
>> Thanks,
>>
>>>>>>> this
>>>>>>> code path: f2fs_mkdir()-> f2fs_sync_fs()-
>>>>>>>> f2fs_write_checkpoint()
>>>>>>> ->f2fs_readonly(). This resulted FI_DIRTY_INODE flag not being
>>>>>>> cleared,
>>>>>>> which eventually led to a bug being triggered during the
>>>>>>> FI_DIRTY_INODE
>>>>>>> check in f2fs_evict_inode().
>>>>>>>
>>>>>>> In this case, we cannot do anything further, so if filesystem
>>>>>>> is
>>>>>>> readonly,
>>>>>>> do not trigger the BUG. Instead, clean up resources to the best
>>>>>>> of
>>>>>>> our
>>>>>>> ability to prevent triggering subsequent resource leak checks.
>>>>>>>
>>>>>>> If there is anything important I'm missing, please let me know,
>>>>>>> thanks.
>>>>>>>
>>>>>>> Reported-by:
>>>>>>> syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com
>>>>>>> Closes:
>>>>>>> https://syzkaller.appspot.com/bug?extid=ebea2790904673d7c618
>>>>>>> Fixes: ca7d802a7d8e ("f2fs: detect dirty inode in evict_inode")
>>>>>>> CC: stable@vger.kernel.org
>>>>>>> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
>>>>>>> ---
>>>>>>>     fs/f2fs/inode.c | 3 ++-
>>>>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>>>>>>> index aef57172014f..ebf825dba0a5 100644
>>>>>>> --- a/fs/f2fs/inode.c
>>>>>>> +++ b/fs/f2fs/inode.c
>>>>>>> @@ -892,7 +892,8 @@ void f2fs_evict_inode(struct inode *inode)
>>>>>>>                           atomic_read(&fi->i_compr_blocks));
>>>>>>>           if (likely(!f2fs_cp_error(sbi) &&
>>>>>>> -                               !is_sbi_flag_set(sbi,
>>>>>>> SBI_CP_DISABLED)))
>>>>>>> +                               !is_sbi_flag_set(sbi,
>>>>>>> SBI_CP_DISABLED)) &&
>>>>>>> +                               !f2fs_readonly(sbi->sb))
>>>>>
>>>>> Is it fine to drop this dirty inode? Since once it remounts f2fs as
>>>>> rw one,
>>>>> previous updates on such inode may be lost? Or am I missing
>>>>> something?
>>>
>>> The purpose of calling this here is mainly to avoid triggering the
>>> f2fs_bug_on(sbi, 1); statement in the subsequent f2fs_put_super() due
>>> to a reference count check failure.
>>> I would say it's possible, but there doesn't seem to be much more we
>>> can do in this scenario: the inode is about to be freed, and the file
>>> system is read-only. Or do we need a mechanism to save the inode that
>>> is about to be freed and then write it back to disk at the appropriate
>>> time after the file system becomes rw again? But such a mechanism
>>> sounds somewhat complex and a little bit of weird... Do you have any
>>> suggestions?
>>
>>
>>
>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>>>>                   f2fs_bug_on(sbi, is_inode_flag_set(inode,
>>>>>>> FI_DIRTY_INODE));
>>>>>>>           else
>>>>>>>                   f2fs_inode_synced(inode);
>>>>>
>>>
>>>
>>> Thanks,


