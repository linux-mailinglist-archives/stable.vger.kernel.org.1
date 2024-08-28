Return-Path: <stable+bounces-71430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7379B962DE8
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 18:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E331F24AC0
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 16:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A7A1A38CD;
	Wed, 28 Aug 2024 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXaFuk+I"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99575381B1
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864074; cv=none; b=PbqeYcVW2AfSE3DWeaiNGbBBwx/nMsjku+gPKp0J6M4BjPIBoBgrGTRegy/gy2vaxk9EAqjPmRQfPpGTzzoQ/vfnvjyoFjl6u57gtnIqdkXLfoA9UGTUdjGgW1UQk/TynCONlx1L8i/ZzHgS/XhBci2nqtxw51q45x8ElsiuxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864074; c=relaxed/simple;
	bh=M+pLKN8f+cprDroY9OC4x1LMbL663fwm1BXnx449Om0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gUw9t1hXLXHHU9QFVfXzTqh4CLxOXFyOs3GbKDdH01+QtWByLwr8EB+FZrHecGTVgDR9r4M6AKovm4p6GJ8cCooYKtpx0YGaFYBA0qprQLEHNBpshM8e1EU/YWxizXOQdITCWp2Ni5q6o1mMG3sI8014JUrOE/HCdcbq7USmfvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXaFuk+I; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-709346604a7so4961061a34.1
        for <stable@vger.kernel.org>; Wed, 28 Aug 2024 09:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724864071; x=1725468871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=maENbqQ9rupduUpvBioLzq6uP9AprJlBe/pp6XMiOLg=;
        b=NXaFuk+IFxVjemLw9pNgTpvKQvJB+i8pAK/BnV5K6Ubn9tsGIReSvN1gjYV6E76Usf
         o7oGiZu6U4x31SOR9IcvHLJRvRcwJoCZ0VzWsS6lzXX/nVHp/Y25oDaVaAnjcyMJ7Bpg
         t3FH0C6aqXeqkpzCmILfmGKMUroSxW2wXQqEmHOERLKhQgXd6s9SxukA9nt0SeFFwa07
         RmXTHBaN9atrHH8oD59h5ieCNp15IvH6Sjwdb5gkZt9OWd0YqR0i4x+wi5sW4fgghSGH
         YGT0G0o6hYMJ4xeQzDKBW7ZvgHgFW+xQ1zLoD27LBRnAtRm4eGCXExwdMO23HjpP2K6l
         2qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724864071; x=1725468871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maENbqQ9rupduUpvBioLzq6uP9AprJlBe/pp6XMiOLg=;
        b=wFm4tyg/6YcrsJM+9fGcpdNtbw8iHpxqPViFz9OCOvb5TdGCkkSMZblzlo+ZapDb5+
         AtwfXLx1xN25Tpfee+qP5t8M81cyPlWM2m4zxHXhSWlLNBcTyfndYjCAqBzh0tT5gzT5
         VSs24abkI+nHtTbNy2krQPrQAkeZzku7i8FPbOLW1mcFDMwVCLzFcQCr0Gi8vcLhywdg
         SOtiikzlsNfmtCok2EaCWjVeApWsJ9jUg2MnzP276f/oXLi1/NSoMq9hO+Oe7fPV538Y
         2OOv9rukoqtXU4UuGdCjZzRkKDVSyZLVSMfoHQSoGYOCUWT5ckswgJmqxWhCEM5uuyzz
         bYNw==
X-Forwarded-Encrypted: i=1; AJvYcCVgUwLU6hmhtqRSRHtNOuhbQhPNAq5x/e+FZ8YPmLbJ6rUKTaFniyctsIybVyKrc64H4IkZQy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIXIYlHY2CyX2IKJxpiYCo4kbtWqlGGkRdV16y9NqI9D2k4L3Q
	BHVr14ZCn1hOhQjPMeP7pazxVd9LA5gtfvFCrMas9Gy1fJnxsWVK
X-Google-Smtp-Source: AGHT+IFPU7Ln1YrBKkH7iL2ZhVyIK8ZVoVejR9wWlVvhNApfL13xziziELWYh2mXT8bTRLDEroT3gg==
X-Received: by 2002:a05:6358:590a:b0:1aa:b8ba:8e with SMTP id e5c5f4694b2df-1b603cc8defmr47422855d.22.1724864071298;
        Wed, 28 Aug 2024 09:54:31 -0700 (PDT)
Received: from localhost ([124.127.77.193])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac9827bsm9808313a12.1.2024.08.28.09.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 09:54:30 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org,
	chao@kernel.org,
	Julian Sun <sunjunchao2870@gmail.com>,
	syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] f2fs: Do not check the FI_DIRTY_INODE flag when umounting a ro fs.
Date: Thu, 29 Aug 2024 00:54:25 +0800
Message-Id: <20240828165425.324845-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, all.

Recently syzbot reported a bug as following:

kernel BUG at fs/f2fs/inode.c:896!
CPU: 1 UID: 0 PID: 5217 Comm: syz-executor605 Not tainted 6.11.0-rc4-syzkaller-00033-g872cf28b8df9 #0
RIP: 0010:f2fs_evict_inode+0x1598/0x15c0 fs/f2fs/inode.c:896
Call Trace:
 <TASK>
 evict+0x532/0x950 fs/inode.c:704
 dispose_list fs/inode.c:747 [inline]
 evict_inodes+0x5f9/0x690 fs/inode.c:797
 generic_shutdown_super+0x9d/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1696
 kill_f2fs_super+0x344/0x690 fs/f2fs/super.c:4898
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 ptrace_notify+0x2d2/0x380 kernel/signal.c:2402
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work+0xc6/0x190 kernel/entry/common.c:173
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
 syscall_exit_to_user_mode+0x279/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The syzbot constructed the following scenario: concurrently
creating directories and setting the file system to read-only.
In this case, while f2fs was making dir, the filesystem switched to
readonly, and when it tried to clear the dirty flag, it triggered this
code path: f2fs_mkdir()-> f2fs_sync_fs()->f2fs_write_checkpoint()
->f2fs_readonly(). This resulted FI_DIRTY_INODE flag not being cleared,
which eventually led to a bug being triggered during the FI_DIRTY_INODE
check in f2fs_evict_inode().

In this case, we cannot do anything further, so if filesystem is readonly,
do not trigger the BUG. Instead, clean up resources to the best of our
ability to prevent triggering subsequent resource leak checks.

If there is anything important I'm missing, please let me know, thanks.

Reported-by: syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ebea2790904673d7c618
Fixes: ca7d802a7d8e ("f2fs: detect dirty inode in evict_inode")
CC: stable@vger.kernel.org
Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/f2fs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index aef57172014f..ebf825dba0a5 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -892,7 +892,8 @@ void f2fs_evict_inode(struct inode *inode)
 			atomic_read(&fi->i_compr_blocks));
 
 	if (likely(!f2fs_cp_error(sbi) &&
-				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
+				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)) &&
+				!f2fs_readonly(sbi->sb))
 		f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));
 	else
 		f2fs_inode_synced(inode);
-- 
2.39.2


