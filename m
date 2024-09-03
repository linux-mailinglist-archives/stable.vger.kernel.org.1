Return-Path: <stable+bounces-72840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5868F969EE3
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 15:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC9428538E
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 13:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FF41A7245;
	Tue,  3 Sep 2024 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7mA03Vi"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311AB188010
	for <stable@vger.kernel.org>; Tue,  3 Sep 2024 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725369557; cv=none; b=eJdr1YnGYHXsDqAbVfkv6EtPNUxL0P2uGsV+vdTqRsaI6vnDV0RvrBDEAhhz+C0cQHLD4ZPVX6Sy20croAyyP8VWGL5r0AftooV+WU1e/c4Nnh/u+U1nZDDlUKp3Um1VtqMH8MnbVBpe6uzslsehBoSsUq2AsRiDsdb+l/+0zl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725369557; c=relaxed/simple;
	bh=nXLxdtE8dKy73TUb2uzwOpBR3I6kFdQEuWkttJKFH4c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MWl41iNjuqz+5GIw6rNJXMbC1fkM0B2NUct37d04PqkuZNsZe5Zf26xrbIyegRF+LR+NZD/Smch/gmJYZVB1J8wYhwn0kKSYPh+SOA/TXMhFOJxw/xSX5t4h9inEzNqdY4aAW70KyVU328+cKYyR/GxPaoLjBhDcLlUQqAE3a1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7mA03Vi; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5dca9cc71b2so3190197eaf.2
        for <stable@vger.kernel.org>; Tue, 03 Sep 2024 06:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725369555; x=1725974355; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nXLxdtE8dKy73TUb2uzwOpBR3I6kFdQEuWkttJKFH4c=;
        b=l7mA03ViqAlbhlBqNQNEFc3UZZf9bYfqGdrxi/r0IlFlGa0jBY0Q7ZmGFPEC4Wg8o3
         8BEQjV3OpkY6sr/whqEfVRyxj1ovu1jvn9OOKp9PqfKNSCZvQA3k63vcjWefB3aaT7Wn
         a4ws0or7N66V+rcfu06RRUhBQ+DDE/IJGYkPlPP3Blx5xoED1syAuVWZNC6VMkZGAaiW
         rgP8NrDx8Mrfql9LMgqaH6e91BRWQh1Z2eP220kUducL/4TNIt5BSFJrdf/VHXP85UYR
         5KMcmZEQJDXwqAxhMW60K50/4KPhMjHmAdk05tV6sn/JIEgkZmumWWWYHa/Nqp11DMi2
         sPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725369555; x=1725974355;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nXLxdtE8dKy73TUb2uzwOpBR3I6kFdQEuWkttJKFH4c=;
        b=rnWPKax/L93Q43RiSkP4pynAUelhyjW1tKN3cOx/ECU7qzVcWbPNZ7RpPWd40AYyZ7
         lBHalJy9kuJNuU8OJ2eny6o3Eo3N0s4kn/7THgrT/mWi+TZbrU1ZjmVNs7uR8K1207Vm
         yYfYCtJdIqdlWT56Jf6763i3NN66kHaCbAUYw2Vdjjlc5hUC+aHUE03gXbRI7H+7Qccx
         7VCzR1WBZQphkD6yprL42nPq3kTMlcAciqX+fqHekZjI6vchqVD9fBxAgvSncuVgSXyh
         DVfV60SWhs2/W/YNLHrLDmvtgiKMdpjXSQO8+7tfv9TUfBYLkP7r/YD6bAgqfj4TIjlL
         H+oA==
X-Forwarded-Encrypted: i=1; AJvYcCXN7Lc3tvqApXdGq++NVvNMAciCoNhFaewJc4Urmf0+nkmWkBJ78JoWn679St2Ba5gWEw1//Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz54/WjUUYbhNYrg/b/nHM441W4DOLpkJAoPBfytU7RlDpsGbZu
	fYq1WxxyoMwBXFwIV/x7t0gTbOzPFyUoiihLlBuqIuoszexAobRF
X-Google-Smtp-Source: AGHT+IHmqKB2ApI4jtmnVOIKPHAaEfmCOJEP0+RdE5W02PZplPzBvvvrHQ15gjBnd/lnsJzhYx3fSg==
X-Received: by 2002:a05:6358:528a:b0:1b8:15fd:49f6 with SMTP id e5c5f4694b2df-1b815fd4c10mr151831555d.27.1725369554677;
        Tue, 03 Sep 2024 06:19:14 -0700 (PDT)
Received: from [127.0.0.1] ([191.96.241.67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9be21bsm7983314a12.74.2024.09.03.06.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 06:19:14 -0700 (PDT)
Message-ID: <db89aa34ab0068581ecb103b3aea0d484d8534bc.camel@gmail.com>
Subject: Re: [PATCH v2] f2fs: Do not check the FI_DIRTY_INODE flag when
 umounting a ro fs.
From: Julian Sun <sunjunchao2870@gmail.com>
To: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org,
 syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com, 
 stable@vger.kernel.org
Date: Tue, 03 Sep 2024 21:19:10 +0800
In-Reply-To: <0f1e5069-7ff0-4d5f-8a3a-3806c8d21487@kernel.org>
References: <20240828165425.324845-1-sunjunchao2870@gmail.com>
	 <0f1e5069-7ff0-4d5f-8a3a-3806c8d21487@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-02 at 16:13 +0800, Chao Yu wrote:
> On 2024/8/29 0:54, Julian Sun wrote:
> > Hi, all.
> >=20
> > Recently syzbot reported a bug as following:
> >=20
> > kernel BUG at fs/f2fs/inode.c:896!
> > CPU: 1 UID: 0 PID: 5217 Comm: syz-executor605 Not tainted 6.11.0-
> > rc4-syzkaller-00033-g872cf28b8df9 #0
> > RIP: 0010:f2fs_evict_inode+0x1598/0x15c0 fs/f2fs/inode.c:896
> > Call Trace:
> > =C2=A0 <TASK>
> > =C2=A0 evict+0x532/0x950 fs/inode.c:704
> > =C2=A0 dispose_list fs/inode.c:747 [inline]
> > =C2=A0 evict_inodes+0x5f9/0x690 fs/inode.c:797
> > =C2=A0 generic_shutdown_super+0x9d/0x2d0 fs/super.c:627
> > =C2=A0 kill_block_super+0x44/0x90 fs/super.c:1696
> > =C2=A0 kill_f2fs_super+0x344/0x690 fs/f2fs/super.c:4898
> > =C2=A0 deactivate_locked_super+0xc4/0x130 fs/super.c:473
> > =C2=A0 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
> > =C2=A0 task_work_run+0x24f/0x310 kernel/task_work.c:228
> > =C2=A0 ptrace_notify+0x2d2/0x380 kernel/signal.c:2402
> > =C2=A0 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
> > =C2=A0 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
> > =C2=A0 syscall_exit_work+0xc6/0x190 kernel/entry/common.c:173
> > =C2=A0 syscall_exit_to_user_mode_prepare kernel/entry/common.c:200
> > [inline]
> > =C2=A0 __syscall_exit_to_user_mode_work kernel/entry/common.c:205
> > [inline]
> > =C2=A0 syscall_exit_to_user_mode+0x279/0x370 kernel/entry/common.c:218
> > =C2=A0 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
> > =C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >=20
> > The syzbot constructed the following scenario: concurrently
> > creating directories and setting the file system to read-only.
> > In this case, while f2fs was making dir, the filesystem switched to
> > readonly, and when it tried to clear the dirty flag, it triggered
> > this
> > code path: f2fs_mkdir()-> f2fs_sync_fs()->f2fs_write_checkpoint()
> > ->f2fs_readonly(). This resulted FI_DIRTY_INODE flag not being
> > cleared,
> > which eventually led to a bug being triggered during the
> > FI_DIRTY_INODE
> > check in f2fs_evict_inode().
> >=20
> > In this case, we cannot do anything further, so if filesystem is
> > readonly,
> > do not trigger the BUG. Instead, clean up resources to the best of
> > our
> > ability to prevent triggering subsequent resource leak checks.
> >=20
> > If there is anything important I'm missing, please let me know,
> > thanks.
> >=20
> > Reported-by: syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com
> > Closes:
> > https://syzkaller.appspot.com/bug?extid=3Debea2790904673d7c618
> > Fixes: ca7d802a7d8e ("f2fs: detect dirty inode in evict_inode")
> > CC: stable@vger.kernel.org
> > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > ---
> > =C2=A0 fs/f2fs/inode.c | 3 ++-
> > =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index aef57172014f..ebf825dba0a5 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -892,7 +892,8 @@ void f2fs_evict_inode(struct inode *inode)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
atomic_read(&fi->i_compr_blocks));
> > =C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (likely(!f2fs_cp_err=
or(sbi) &&
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0!is_sbi_flag_set(sbi,
> > SBI_CP_DISABLED)))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0!is_sbi_flag_set(sbi,
> > SBI_CP_DISABLED)) &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0!f2fs_readonly(sbi->sb))
>=20
> Is it fine to drop this dirty inode? Since once it remounts f2fs as
> rw one,
> previous updates on such inode may be lost? Or am I missing
> something?
Hi, Chao.

I believe the issue you pointed out goes beyond the scope of the
problem reported by syzbot, as I have seen this issue in some existing
code as well, such as in the handling of read-only file systems in
f2fs_mark_inode_dirty_sync(), f2fs_write_checkpoint(),
f2fs_do_sync_file(), etc.

If you do believe the problem needs to be fixed, we can discuss it
further, but it should be addressed in a separate patch.

If there is anything important I'm missing, please let me know, thanks.
>=20
> Thanks,
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0f2fs_bug_on(sbi, is_inode_flag_set(inode,
> > FI_DIRTY_INODE));
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0f2fs_inode_synced(inode);
>=20

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

