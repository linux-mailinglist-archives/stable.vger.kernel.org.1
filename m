Return-Path: <stable+bounces-71427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEC9962D40
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 18:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AF51C214F4
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 16:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC831A3BBF;
	Wed, 28 Aug 2024 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIEO1E3N"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3E07E574;
	Wed, 28 Aug 2024 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861178; cv=none; b=A2f2SiqtcpXoroE7r/ZG1LymLYlgyISsnIDdJvB3LP554v/niyOlW7xtRAJchw4RxEz6lUJN5wbDwXgv2Ff+eC52U6PMWGtXVUqh3l5E27Q6qdfuXQX3AGxbkVUe9F+wtfFiYX0myQ01u9d7BL1J3ltWezj6OznlBg0PDToosvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861178; c=relaxed/simple;
	bh=Pcc2ywD3Ph5edpvvemDwE9pwJ5atBlosbGQO/CDOgmc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K4/GKsNSGcjimob0UD7acTXvFj8M7WR/h+B0gn6O1Xr4IwL/spyPixlpDLdrjwzds81/Jsz83lpqmic9tfAAFZ0vrYM8pLnOXh5/r5QKG/6qBiPrK0ykvBF4qaEqZcdCLo2z6PkE5C2JF6B+dVstE5CkDdI4YN4XiWJ8pqP9HFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIEO1E3N; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-201f7fb09f6so60055655ad.2;
        Wed, 28 Aug 2024 09:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724861176; x=1725465976; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pcc2ywD3Ph5edpvvemDwE9pwJ5atBlosbGQO/CDOgmc=;
        b=YIEO1E3NT/26mFb37fAVQUJZ433Iw3QBh6MrtdzrCGoCBy3gkgtUW+MSxcFjo453Xr
         unNl1syArulBAK28qzYl9vYVASkpq93+0mbb6+0onOZ0kYce0wkSaGiG58oZw2TifBVd
         OYirOeYRhFq1ZvcPCD6NJIrnV/TPuOsH2Lw4ibRDvUWl5MxlAnL6hkHpgzdnozFxurnX
         ODWHtlFshQWjw6TXgzEVhRfLb6TSj5TCbtDpLRHdjCi1WoJtrLUL7xGtFBrIMSDRHZN6
         Eh2D5tN4O92t4+qRPQugYUH9tWRPYaFgRRgaRVFggms8dR7i+WPJs2tc/exemdPgdiyu
         Cx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724861176; x=1725465976;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pcc2ywD3Ph5edpvvemDwE9pwJ5atBlosbGQO/CDOgmc=;
        b=ferDg55ZOWgGGttF4Q+TaLf9C+SHRqM+NVXJQzYAZRMm3pWai8hki8HRrkc+TQY20h
         h0G8koqAfWvTI9pLRFh8X2EE+jtuSD8S+nsA7lJdJholu9LcAQ7aCGiTRQaA3GDykCgi
         71ONbOLrRC8QT1fZZkqRbqvAN5MkZE5TI5KzbsFVk+fDCa03XtZbP1WUVni+2A5W83gJ
         FpV7jEYLxObWoOtEqlsHc1iyx8tkZ8K1XebhIt5FL42K28j2Dobxx0yxUFzA9PGl7U4C
         g3GZ83/wwqlpaW1T8wkCaU6M6V2VHEf9s4iAx8nrH6XSTlVn+YbPItA/s+K9+goR2yO7
         CJew==
X-Forwarded-Encrypted: i=1; AJvYcCVQCJqrhg4f6aB4lckLokFxm7zFG+WPgDh/yoXlsS6f/mQ+wkreY2PNaA9j7sym9UTM5u6ikosFwG3OXPM=@vger.kernel.org, AJvYcCVq2iuXqvqdOqVkoKMO9/9G+p1GEuHr/DCZGwu7oCMqBv0UJHJAAhMnpTFlx5vMH0ZlVdDY1AHQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9n8bTDMRNkwC6ag81wtrm5h6Ste9FWmwBQIpLyyiS1p4w0JAN
	M2yZtxiP8T6lFOZiSD+Pr0CWpkN4LSmRUoC/kUber8pmAcLZygz4
X-Google-Smtp-Source: AGHT+IEJgTitc5j5MuB4aK+ZM8bcNpkkHTQk7StOQd6wdrMwd5G3xO/DVk+x+wtaNoY1TfJChdqveg==
X-Received: by 2002:a17:903:41ca:b0:1fd:672f:2b34 with SMTP id d9443c01a7336-2039e4b77eamr141094535ad.33.1724861175477;
        Wed, 28 Aug 2024 09:06:15 -0700 (PDT)
Received: from [127.0.0.1] ([174.139.202.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385580810sm100329295ad.105.2024.08.28.09.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 09:06:14 -0700 (PDT)
Message-ID: <e09856753d986a810601e2e84261e783f30b0d04.camel@gmail.com>
Subject: Re: [PATCH] f2fs: Do not check the FI_DIRTY_INODE flag when
 umounting a ro fs.
From: Julian Sun <sunjunchao2870@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com, chao@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, stable@vger.kernel.org
Date: Thu, 29 Aug 2024 00:06:09 +0800
In-Reply-To: <Zs9BsP1UdFn4FoK5@google.com>
References: <000000000000b0231406204772a1@google.com>
	 <20240827034324.339129-1-sunjunchao2870@gmail.com>
	 <Zs9BsP1UdFn4FoK5@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-28 at 15:26 +0000, Jaegeuk Kim wrote:
> On 08/27, Julian Sun wrote:
> > Hi, all.
> >=20
> > Recently syzbot reported a bug as following:
> >=20
> > kernel BUG at fs/f2fs/inode.c:896!
> > CPU: 1 UID: 0 PID: 5217 Comm: syz-executor605 Not tainted 6.11.0-
> > rc4-syzkaller-00033-g872cf28b8df9 #0
> > RIP: 0010:f2fs_evict_inode+0x1598/0x15c0 fs/f2fs/inode.c:896
> > Call Trace:
> > =C2=A0<TASK>
> > =C2=A0evict+0x532/0x950 fs/inode.c:704
> > =C2=A0dispose_list fs/inode.c:747 [inline]
> > =C2=A0evict_inodes+0x5f9/0x690 fs/inode.c:797
> > =C2=A0generic_shutdown_super+0x9d/0x2d0 fs/super.c:627
> > =C2=A0kill_block_super+0x44/0x90 fs/super.c:1696
> > =C2=A0kill_f2fs_super+0x344/0x690 fs/f2fs/super.c:4898
> > =C2=A0deactivate_locked_super+0xc4/0x130 fs/super.c:473
> > =C2=A0cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
> > =C2=A0task_work_run+0x24f/0x310 kernel/task_work.c:228
> > =C2=A0ptrace_notify+0x2d2/0x380 kernel/signal.c:2402
> > =C2=A0ptrace_report_syscall include/linux/ptrace.h:415 [inline]
> > =C2=A0ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
> > =C2=A0syscall_exit_work+0xc6/0x190 kernel/entry/common.c:173
> > =C2=A0syscall_exit_to_user_mode_prepare kernel/entry/common.c:200
> > [inline]
> > =C2=A0__syscall_exit_to_user_mode_work kernel/entry/common.c:205
> > [inline]
> > =C2=A0syscall_exit_to_user_mode+0x279/0x370 kernel/entry/common.c:218
> > =C2=A0do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
> > =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
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
> > =C2=A0fs/f2fs/inode.c | 8 ++++++--
> > =C2=A01 file changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index aef57172014f..52d273383ec2 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -892,8 +892,12 @@ void f2fs_evict_inode(struct inode *inode)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
atomic_read(&fi->i_compr_blocks));
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (likely(!f2fs_cp_err=
or(sbi) &&
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0!is_sbi_flag_set(sbi,
> > SBI_CP_DISABLED)))
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0f2fs_bug_on(sbi, is_inode_flag_set(inode,
> > FI_DIRTY_INODE));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0!is_sbi_flag_set(sbi,
> > SBI_CP_DISABLED))) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (!f2fs_readonly(sbi->sb))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0f2fs_b=
ug_on(sbi, is_inode_flag_set(inode,
> > FI_DIRTY_INODE));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0f2fs_i=
node_synced(inode);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0f2fs_inode_synced(inode);
>=20
> What about:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (likely(!f2fs_cp_error=
(sbi) &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !is_sbi_flag_set(sbi, SBI_CP_DISABLED)=
) &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !f2fs_readonly(sbi->sb)))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0f2fs_bug_on(sbi, is_inode_flag_set(inode,
> FI_DIRTY_INODE));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0f2fs_inode_synced(inode);

Hi, Jaegeuk, thanks for your review.

Yeah, it is semantically identical, and the code is clearer.
I will fix it in patch v2.
>=20
> >=20
>=20
> > =C2=A0
> > --=20
> > 2.39.2


