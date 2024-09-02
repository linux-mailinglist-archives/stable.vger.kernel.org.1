Return-Path: <stable+bounces-72724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 258F696883F
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 15:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C33AB26949
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 13:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7572A19C56C;
	Mon,  2 Sep 2024 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xj1ubEtf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8632746E
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282071; cv=none; b=bTxZRBXQjsLj8mj8hk9rEf8TZz5gnW2tDEO3Fok+9Kuypp7bB10kMasNxJqaRjgl/fONBsrkx2g41h8tUZboT2RQjL+c0MpBFVuz1WbghwPTgSqcrTE79kALGJSe6InIIDt4sXv/FYoexZcS/lgh8TWgrWELJ+8s7obyVYTrAQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282071; c=relaxed/simple;
	bh=BoNVOtDr+VrUOkBVF3JBkCILloNfEoHqSjUAIRQBmzY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KSXEE40gmIFjxF3Gkib3EJ7DM03VGHAfQUZ0r4fEIc/6dw9w62888sXdavoE5JLhC8IWqdgbz0om0oa2+7x1eWJHiKCWSlkFB/1bT0SHakbqWLu2V02pyl6od2zFXlcqDgaz0+641E87xW8m9q3HPWLLlkVq7pgEY8JIwnhKEKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xj1ubEtf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2059204f448so3521515ad.0
        for <stable@vger.kernel.org>; Mon, 02 Sep 2024 06:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725282069; x=1725886869; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BoNVOtDr+VrUOkBVF3JBkCILloNfEoHqSjUAIRQBmzY=;
        b=Xj1ubEtfq5oFklFDr6Jt7KkuDMPQ98cRsjlNK7bZdyrr2+NVAM502tdtsJ2o9xHvx0
         GEMk26WO0QfKur8s/zNJQftd+qbzAnoFjyx44EC0XuUhKoF6YDBpjPJ8uK/1uIsyixPf
         IVApvYOZcak5iWpZGh8G42aGhhRRSqxP35KdQuBrnyiNUgfrHjRNpxm6BsFcZmiEMS4X
         UsD8m2ZuzUvD6Ju71YdUicloZmt3fYhYKVdad4qo2HdNvDNSDEIGct/I9MO2J1wNAD/B
         I9JMIxomXEzkpIt1/AijL/LqY2NmCR+nwkqqCHyq+v6WWqaXxQvd6ebWqCUPsU9ZDRwi
         Rr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725282069; x=1725886869;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BoNVOtDr+VrUOkBVF3JBkCILloNfEoHqSjUAIRQBmzY=;
        b=KNnf9pqBsYnCmSht3NbSyqiiapiP4ESDNNIGqeAToTTAsh1ntKPCM6EEz1frvMfnfN
         HtkWxpY7BlaGZD4A87yPxmFS577mM+kjuDj1KjqWV0KOW/SWDHhPOVhhi+kgHN5Pr6xt
         3Q7r2q8STICc4AynjpgaIhiIsqZTipgSPERITctz5o+n8R31kdXUCM8WVoQK3cx+q3wi
         rHLAeMQnwAaXmj6RMBeV8mveS6MaagbvDGKxoM9qLDmG1jvJSulz9OuZDQgMBG01ZKup
         ei7pawP0v+MQrleblQOF7a+q6JaRs1VkxjGyPLGnp86NNvcohxeHmXi1wnaZV7SCuCiJ
         CoWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrapVHf6elGtN8+Ch20P907c2qF0r49zmobDL5JUiVeuu8QSm9hwMdJ/0eeBTG6QUvbKEWF7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMvCZZ5+HpaI2YHrhXHaQ8aZkE9ck6Lr8kHMtaxwK//ULYXBtE
	4A8G0lfqbG2R1P/unPvB4ZZIs7ZgKJLoDAc80S0FW0VQ/TBPMWI9
X-Google-Smtp-Source: AGHT+IEYlOZ1tNxKqmlqm0I3UXHQMbJrtLOYA/TfiVNX348opQCdQS5u0PCaJyMkkMz88hu7oq1BrQ==
X-Received: by 2002:a17:902:f549:b0:205:76f3:fc2c with SMTP id d9443c01a7336-20576f3ff48mr27866685ad.16.1725282066601;
        Mon, 02 Sep 2024 06:01:06 -0700 (PDT)
Received: from [127.0.0.1] ([103.85.75.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515537890sm65785455ad.180.2024.09.02.06.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 06:01:05 -0700 (PDT)
Message-ID: <8edbc0b87074fb9adcccb8b67032dc3a693c9bfa.camel@gmail.com>
Subject: Re: [PATCH v2] f2fs: Do not check the FI_DIRTY_INODE flag when
 umounting a ro fs.
From: Julian Sun <sunjunchao2870@gmail.com>
To: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org,
 syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com, 
 stable@vger.kernel.org
Date: Mon, 02 Sep 2024 21:01:02 +0800
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
> > On 2024/8/29 0:54, Julian Sun wrote:
> > > > Hi, all.
> > > >=20
> > > > Recently syzbot reported a bug as following:
> > > >=20
> > > > kernel BUG at fs/f2fs/inode.c:896!
> > > > CPU: 1 UID: 0 PID: 5217 Comm: syz-executor605 Not tainted
> > > > 6.11.0-rc4-syzkaller-00033-g872cf28b8df9 #0
> > > > RIP: 0010:f2fs_evict_inode+0x1598/0x15c0 fs/f2fs/inode.c:896
> > > > Call Trace:
> > > > =C2=A0 <TASK>
> > > > =C2=A0 evict+0x532/0x950 fs/inode.c:704
> > > > =C2=A0 dispose_list fs/inode.c:747 [inline]
> > > > =C2=A0 evict_inodes+0x5f9/0x690 fs/inode.c:797
> > > > =C2=A0 generic_shutdown_super+0x9d/0x2d0 fs/super.c:627
> > > > =C2=A0 kill_block_super+0x44/0x90 fs/super.c:1696
> > > > =C2=A0 kill_f2fs_super+0x344/0x690 fs/f2fs/super.c:4898
> > > > =C2=A0 deactivate_locked_super+0xc4/0x130 fs/super.c:473
> > > > =C2=A0 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
> > > > =C2=A0 task_work_run+0x24f/0x310 kernel/task_work.c:228
> > > > =C2=A0 ptrace_notify+0x2d2/0x380 kernel/signal.c:2402
> > > > =C2=A0 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
> > > > =C2=A0 ptrace_report_syscall_exit include/linux/ptrace.h:477
> > > > [inline]
> > > > =C2=A0 syscall_exit_work+0xc6/0x190 kernel/entry/common.c:173
> > > > =C2=A0 syscall_exit_to_user_mode_prepare kernel/entry/common.c:200
> > > > [inline]
> > > > =C2=A0 __syscall_exit_to_user_mode_work kernel/entry/common.c:205
> > > > [inline]
> > > > =C2=A0 syscall_exit_to_user_mode+0x279/0x370
> > > > kernel/entry/common.c:218
> > > > =C2=A0 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
> > > > =C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > >=20
> > > > The syzbot constructed the following scenario: concurrently
> > > > creating directories and setting the file system to read-only.
> > > > In this case, while f2fs was making dir, the filesystem
> > > > switched to
> > > > readonly, and when it tried to clear the dirty flag, it
> > > > triggered
> > > > this
> > > > code path: f2fs_mkdir()-> f2fs_sync_fs()-
> > > > >f2fs_write_checkpoint()
> > > > ->f2fs_readonly(). This resulted FI_DIRTY_INODE flag not being
> > > > cleared,
> > > > which eventually led to a bug being triggered during the
> > > > FI_DIRTY_INODE
> > > > check in f2fs_evict_inode().
> > > >=20
> > > > In this case, we cannot do anything further, so if filesystem
> > > > is
> > > > readonly,
> > > > do not trigger the BUG. Instead, clean up resources to the best
> > > > of
> > > > our
> > > > ability to prevent triggering subsequent resource leak checks.
> > > >=20
> > > > If there is anything important I'm missing, please let me know,
> > > > thanks.
> > > >=20
> > > > Reported-by:
> > > > syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com
> > > > Closes:=20
> > > > https://syzkaller.appspot.com/bug?extid=3Debea2790904673d7c618
> > > > Fixes: ca7d802a7d8e ("f2fs: detect dirty inode in evict_inode")
> > > > CC: stable@vger.kernel.org
> > > > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > > > ---
> > > > =C2=A0 fs/f2fs/inode.c | 3 ++-
> > > > =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > > > index aef57172014f..ebf825dba0a5 100644
> > > > --- a/fs/f2fs/inode.c
> > > > +++ b/fs/f2fs/inode.c
> > > > @@ -892,7 +892,8 @@ void f2fs_evict_inode(struct inode *inode)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0atomic_read(&fi->i_compr_blocks));
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (likely(!f2fs_cp=
_error(sbi) &&
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0!is_sbi_flag_set(sbi,
> > > > SBI_CP_DISABLED)))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0!is_sbi_flag_set(sbi,
> > > > SBI_CP_DISABLED)) &&
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0!f2fs_readonly(sbi->sb))
> >=20
> > Is it fine to drop this dirty inode? Since once it remounts f2fs as
> > rw one,
> > previous updates on such inode may be lost? Or am I missing
> > something?

The purpose of calling this here is mainly to avoid triggering the
f2fs_bug_on(sbi, 1); statement in the subsequent f2fs_put_super() due
to a reference count check failure.=C2=A0
I would say it's possible, but there doesn't seem to be much more we
can do in this scenario: the inode is about to be freed, and the file
system is read-only. Or do we need a mechanism to save the inode that
is about to be freed and then write it back to disk at the appropriate
time after the file system becomes rw again? But such a mechanism
sounds somewhat complex and a little bit of weird... Do you have any
suggestions?
> >=20
> > Thanks,
> >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0f2fs_bug_on(sbi, is_inode_flag_set(inode,
> > > > FI_DIRTY_INODE));
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0f2fs_inode_synced(inode);
> >=20


Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

