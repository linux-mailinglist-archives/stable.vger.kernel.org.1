Return-Path: <stable+bounces-5194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E17080B9A9
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 08:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72911F21009
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 07:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0783F33E1;
	Sun, 10 Dec 2023 07:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr0zsTv9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1F0199E
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 23:27:15 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d0bb7ff86cso32882915ad.1
        for <stable@vger.kernel.org>; Sat, 09 Dec 2023 23:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702193235; x=1702798035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsvFTErgx+HRC1thmaku0o7ipX8h2bA49ymPH14mwNA=;
        b=Dr0zsTv9KAuT4ss6U8/KUCq5jK1c1+kOdzwA4tFvJN3y5y0fUseBowS8ZBwGAfdSL2
         cJLlID2qeL+LWQ+aiSbemRTkjPh9z2cbFiiuSRYHDg4AX8fOD7JTf5SxhnbM7ICNMlx/
         Lbm7XzuJzmOe43i1cjSaiLqzA3611iFtoliJUwGCd22G0e1A1z3iUPYTC/qzkT34EuCS
         4OQ9EFw1a1Dj76JXZj4pVTywKSvpW8ni66j+cdHnMFWKzxsvv/ILqyYUkuDK1a19BG13
         MEzw7IU/SG2R09mbqvnzPSZXilRztD53MannG73rhTQMpyJjpmSS6e3lwBMs3oVDUrFj
         WNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702193235; x=1702798035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsvFTErgx+HRC1thmaku0o7ipX8h2bA49ymPH14mwNA=;
        b=kWKo7DfK0yy2QTHlTKvpyLzeECnLS8aIdanpIR+dgUPglzce7TStNJ9AO4RBd94V7D
         S2gu7MvThj66mU9G2hPw541ee+zEVzOT1rgd4Jvex/RAAaQB/LHBgfKG+Y+mQKgbtVR7
         1cMK1ML9VRG3eOivUTaMLAoM+3zKCr16dFwfNMJSTN7aS9y1ZUkze73qOjm9+yqfrZz9
         YxlkBZHU23GbnozZyEKZXVdbYda1JDchvsupfY+It2zzpAl1KYuL7WZSQxRgEivTtirF
         R700YfdREi0p/rG+ghGffmTuNxi8os0F/eWDwvkNk39kYVwyI5ULnDmLIT/pKVWGn+f3
         pSuw==
X-Gm-Message-State: AOJu0YzwF5tFyn9rUrXGDuwrJiszGJdwVWZ9ki2hOnANXqtP4aPLyP5e
	78QrakAvBGTNNSAGg9W1MjAekHURy8M=
X-Google-Smtp-Source: AGHT+IEO2fyvD/6wPXCUY4ElnaQfHvOxdvAzT11ETKEzGU4Cu+BsLbsprkggiUydAbP/4euHLPWPyw==
X-Received: by 2002:a17:903:98f:b0:1d0:6ffd:610c with SMTP id mb15-20020a170903098f00b001d06ffd610cmr3529893plb.46.1702193234582;
        Sat, 09 Dec 2023 23:27:14 -0800 (PST)
Received: from carrot.. (i223-217-190-115.s42.a014.ap.plala.or.jp. [223.217.190.115])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902ce8800b001cfc46baa40sm4359166plg.158.2023.12.09.23.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 23:27:13 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.14 4.19 5.4] nilfs2: fix missing error check for sb_set_blocksize call
Date: Sun, 10 Dec 2023 16:26:48 +0900
Message-Id: <20231210072648.3054-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAKFNMokAa1hUUL95wxCZRXzLMuOPiQ6Cu0yOrcdbKvW=zT1z0g@mail.gmail.com>
References: <CAKFNMokAa1hUUL95wxCZRXzLMuOPiQ6Cu0yOrcdbKvW=zT1z0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit d61d0ab573649789bf9eb909c89a1a193b2e3d10 upstream.

When mounting a filesystem image with a block size larger than the page
size, nilfs2 repeatedly outputs long error messages with stack traces to
the kernel log, such as the following:

 getblk(): invalid block size 8192 requested
 logical block size: 512
 ...
 Call Trace:
  dump_stack_lvl+0x92/0xd4
  dump_stack+0xd/0x10
  bdev_getblk+0x33a/0x354
  __breadahead+0x11/0x80
  nilfs_search_super_root+0xe2/0x704 [nilfs2]
  load_nilfs+0x72/0x504 [nilfs2]
  nilfs_mount+0x30f/0x518 [nilfs2]
  legacy_get_tree+0x1b/0x40
  vfs_get_tree+0x18/0xc4
  path_mount+0x786/0xa88
  __ia32_sys_mount+0x147/0x1a8
  __do_fast_syscall_32+0x56/0xc8
  do_fast_syscall_32+0x29/0x58
  do_SYSENTER_32+0x15/0x18
  entry_SYSENTER_32+0x98/0xf1
 ...

This overloads the system logger.  And to make matters worse, it sometimes
crashes the kernel with a memory access violation.

This is because the return value of the sb_set_blocksize() call, which
should be checked for errors, is not checked.

The latter issue is due to out-of-buffer memory being accessed based on a
large block size that caused sb_set_blocksize() to fail for buffers read
with the initial minimum block size that remained unupdated in the
super_block structure.

Since nilfs2 mkfs tool does not accept block sizes larger than the system
page size, this has been overlooked.  However, it is possible to create
this situation by intentionally modifying the tool or by passing a
filesystem image created on a system with a large page size to a system
with a smaller page size and mounting it.

Fix this issue by inserting the expected error handling for the call to
sb_set_blocksize().

Link: https://lkml.kernel.org/r/20231129141547.4726-1-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
Please apply this patch to the stable trees indicated by the subject line
prefix, instead of the patch I asked you to drop earlier.

In this patch, "nilfs_err()" is replaced with its equivalent since it
doesn't yet exist in these kernels.  With this tweak, this patch is
applicable from v4.8 to v5.8.  Also this patch has been tested against
these three stable trees.

Thanks,
Ryusuke Konishi

fs/nilfs2/the_nilfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index d550a564645e..c8d869bc25b0 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -688,7 +688,11 @@ int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb, char *data)
 			goto failed_sbh;
 		}
 		nilfs_release_super_block(nilfs);
-		sb_set_blocksize(sb, blocksize);
+		if (!sb_set_blocksize(sb, blocksize)) {
+			nilfs_msg(sb, KERN_ERR, "bad blocksize %d", blocksize);
+			err = -EINVAL;
+			goto out;
+		}
 
 		err = nilfs_load_super_block(nilfs, sb, blocksize, &sbp);
 		if (err)
-- 
2.39.3


