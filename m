Return-Path: <stable+bounces-70294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 634A995FFEC
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 05:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC77282ECC
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 03:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C9A1F93E;
	Tue, 27 Aug 2024 03:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZS1AqR07"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8619017D2;
	Tue, 27 Aug 2024 03:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724730212; cv=none; b=gdJ0tOOcbl60Pqc4CI05xqte8hd2ZZlsG4AASjh5PSAIENmRXvuiF0tzp05a37Jxu2+KC003QAu4gP7rhhHraqiGXfucag38NvJMxn2IdIjrHtf7cHfFXA6axWSUxymyIwqDrWrsdJfaSskR78XsY9T90Rg2p+0/Et+IaTPcp8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724730212; c=relaxed/simple;
	bh=NMaZMu5kLVVRx3syKNFovcWtu0GpqpBq+L+KabGUL3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JZSRYV/h0Jf1D7xsXAjawnTo2vtZTXOX/ZCC1yhXylO+upKYdTTHr0ExqZW8V4BgBVBtAeySnflG1fWi4zOgAPshrmKagriHLFDAvId7kGqD8l4r1ku14oGNEOfsqZ7z3lnXpzlXHf3dRIXFZxh3GNFqfxw8u1FIy0i6wJ7fcjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZS1AqR07; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3d58d6e08so3884067a91.3;
        Mon, 26 Aug 2024 20:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724730211; x=1725335011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTaNDoHudMv3bzmqeleURjD4/FcotZDelM+rzdNVn6Q=;
        b=ZS1AqR07lNeXYboiV2xLza9cyFpAWFXfPY10eDspUXMt68pp92aw68ALgpl5MkbjSl
         hyuPqbUO0B/ulx8bkoQzMcpNnx3iuMLmOP1he+RE1s504TOMU1O8awcAMOMT03AbYF0u
         gA32gsFSPapvOtZDK//svHla9OxNjlsPWDgoCU+yxkJWwzou5mwPS8nVyB5L+HcgiGAj
         aM34hnbaqJaF0e01HfEkBqrGeXxY7Ptxm/OUgy0asWGSzxADrvuLGo1LFu6RcENdVhcX
         v2bk8iufuJLdCZbBVslB0K/8rPOUb2ElE1P0FrejNFHbTr6PhA6sUl/RnegZ3KJUX/xc
         DnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724730211; x=1725335011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTaNDoHudMv3bzmqeleURjD4/FcotZDelM+rzdNVn6Q=;
        b=Wbj3zbNP8rBenGUsWZQuYrxmtxpDaIlracwitOMkfHB/KX7F+/iS0ThPueuao8Wq6V
         lcxMPMl/2q2wOZmy4YhCtWio8EPpz3ronCNI+EK70XqCofOFhK2Hq69wJBLozaMO8Q5f
         d8XQCYma6KXCshfBonqi+Vu9s0Wy3n/VNAr7Un+jy/AbQ5iK1xlW/4o2Smtz2cSkhetm
         U8XtRKdfhh5WtBHRIfxAekW6vYvv7MrMbuoorEhsl0dSSFTAEHMJC0UPT0kaQQWoglne
         8mzDkAZru0QBbqFIRO+1WgnXcXH+SydMMDypq4kKaLO1e3E9Z3sntWI+7OZDNRk9JWb7
         A1ng==
X-Forwarded-Encrypted: i=1; AJvYcCW3JqAxy8UzZC+GWBOyy4WpWeK65ZHV95+yMsH/TyrUowldKrXzpXB4wfYn9AtHvQFhVLMrO+LR@vger.kernel.org, AJvYcCX22p3Vi+aIZby17uSiytxKGlJVXhTk26xIQdKauCDI/T9Ao82D9bQgJBZRfpLCusmt6W2TMHU1TCQGIqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOaeB/W9sAI1kOpQRNnfRoNe7cyC/DkHxbTu/GEJbBO0SEYV6B
	rz40HLhEqho7GQtIZXZ6fqBq8VtxoRZH286Z93zDbwY/dgz/TrVH
X-Google-Smtp-Source: AGHT+IEvnGKTv4Qjyeqw8RdfF5VIUg+jU6364AYs3SYNrNBJTvXwVoIbrOFLiA31uluktVcD83vvjg==
X-Received: by 2002:a17:90a:dd86:b0:2c9:84f9:a321 with SMTP id 98e67ed59e1d1-2d646c26b9fmr12604597a91.23.1724730210560;
        Mon, 26 Aug 2024 20:43:30 -0700 (PDT)
Received: from localhost ([123.113.110.156])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613af1884sm10676797a91.43.2024.08.26.20.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 20:43:29 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com
Cc: chao@kernel.org,
	jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Julian Sun <sunjunchao2870@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: Do not check the FI_DIRTY_INODE flag when umounting a ro fs.
Date: Tue, 27 Aug 2024 11:43:24 +0800
Message-Id: <20240827034324.339129-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <000000000000b0231406204772a1@google.com>
References: <000000000000b0231406204772a1@google.com>
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
 fs/f2fs/inode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index aef57172014f..52d273383ec2 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -892,8 +892,12 @@ void f2fs_evict_inode(struct inode *inode)
 			atomic_read(&fi->i_compr_blocks));
 
 	if (likely(!f2fs_cp_error(sbi) &&
-				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
-		f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));
+				!is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
+		if (!f2fs_readonly(sbi->sb))
+			f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));
+		else
+			f2fs_inode_synced(inode);
+	}
 	else
 		f2fs_inode_synced(inode);
 
-- 
2.39.2


