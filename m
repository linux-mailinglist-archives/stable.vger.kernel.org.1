Return-Path: <stable+bounces-152463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBEFAD6090
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264C417A46A
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5A419A;
	Wed, 11 Jun 2025 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5fBK4QF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE19925BF01
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675706; cv=none; b=OZnbBbrUOb5byV81iKoUVzy89KAbzYoaqfPDW4AxfFrBW+vtyu9OV8gSReIsO8tj7qtovGZqHynWt/w0t+qA2AjCLKMT9kWcODljl0iv3Oc6i9ydimZg4Xj3X/jDAuVmbiUpGFUwy1eo35d1XRoAqT1GmrYTfitQW5VJGDVINNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675706; c=relaxed/simple;
	bh=c9lrL0G3sfF4GZ3QdOYnceQ+SGsCIYNtmoM7+0gYZ/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTl9j7W0YgqTvTEdXIdpTqMK7sFDi51WUeicV+T7dDrFRi2yIzUYK85E1sWVP/FLm0DSVlCWWdTvlIoSHX9WHiCeXvUUBEWSuTaeidWYf+AeWre3+vDB9PPNvEd6ZMUcP5pPQKEJPdP6Dp+fwoQlz2xNYL3P1Rj7MiIcwDctlvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5fBK4QF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2360ff7ac1bso2353715ad.3
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675704; x=1750280504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Vyjcf7LKhLEt57SbYflqTDSjfUl3obN/eBpEgIOrqc=;
        b=f5fBK4QF6PbGENEurW7ZW5gDc9wuVcdllltfS1wGhNU60AlhYbKsx7GawOnB0NKigR
         vsMo5hPlxtsWJPVkiL9XsaRqXS57LUALcPJg3/sQFrYCHRrv7+5NjksB//wReN/ZrONb
         b7QeXHDAaQ8UqqevH1BNpXqoilt3LCDkEfV/nEJ+3YZJn15/4hdnNJSr5Oq/S60so4iK
         /VDJmwJsfg8GBqeasohgeyLpoEcCkjxqBiNvQWBFGu9OgC5y65yJOvmXZUr8K5XKhh/f
         hcZvPCeNNuXG7ywbEj+QONWOtEXp+4b2cdrMoIqxwGCKBxvp7AXZSgwdA7nHv5OZOaE1
         0xGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675704; x=1750280504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Vyjcf7LKhLEt57SbYflqTDSjfUl3obN/eBpEgIOrqc=;
        b=pyq5IVDfZNCR5oTnn99YwoHoXgtycH9hR7NNb0vh03g4uEA57mI13UZT6GqrebqzlB
         Y8p03fLqfAie5xCnaU2NTUmQ/EnPHwdV8QgNF9vziNA7j24oP9thoeqVvwyc4g7ZCRwW
         Cko6jfVhgPwh2M98lj7VDjsqY0/nEwZT9XyPdlm+8iQ6/eQeToY5n40v/sVqYGPcXo8j
         /Lfl0ERDu7bh6Pp7SfQgfrjhuIUNNZzzYMXfImZDop9GYTc+doNlPKFepSf8hjlp0CqP
         eHeeZLSE3M0MZ+1qO+w6Qa+0vni8iIMvbrtmspRujGQN/BWpw2xJ9LKne10k/pUqBZVh
         3eDQ==
X-Gm-Message-State: AOJu0YyadIwfApY6VLUHgdL7+KltKza/3c5majnhkiW8QPYTR6ZmbWdv
	L2c9YjA4qkB7Ui4EUeBaHuDy0eek+rQInodStB81A+9uRfGSsEoJKDZksf2fk4yr
X-Gm-Gg: ASbGnctvp7OXxJ95RiNNn7/V06kzoXVWZ/RL023sefvty2s1/jQcrnNL7uwCn1hqM0+
	wof/bWqdXMS4inDEdp36vEypkQqItPMMKSC6HMuAeKESVhvvR+mXzdYgUwvb7cQ4QSknWxFPTJ/
	fcZBUJJMgjko6xamnhjMpvpnUz+RQchmuej5Sx+VHkayFo1AKP/+6ni/RlGr9pGQ/t+/P/sVkDi
	3mpe0dRXGkWKKmiV5refsLJyRXcNZb8heMhaWJPu2Lh8TwcxrCyt9c0n9n8jO57Z80InyFAjd1Q
	Y4C5UUDx/rQZ0R5RdHaSiEeTu9O1jX/UeLLD/zR9alDpr8SHT3r8bmKrZC7vMl+1OlQ76z71cvK
	KiY8Qg5R1nDQ=
X-Google-Smtp-Source: AGHT+IGzs1WEATTqx/oULKpew5dS5hxCbW8jk6a7XOl/T1BEw/XKHg+pULuNne/so9AWfcxoWw12rA==
X-Received: by 2002:a17:902:fc47:b0:234:914b:3841 with SMTP id d9443c01a7336-23641b28f22mr73120375ad.39.1749675703471;
        Wed, 11 Jun 2025 14:01:43 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:42 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 10/23] xfs: verify buffer, inode, and dquot items every tx commit
Date: Wed, 11 Jun 2025 14:01:14 -0700
Message-ID: <20250611210128.67687-11-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
In-Reply-To: <20250611210128.67687-1-leah.rumancik@gmail.com>
References: <20250611210128.67687-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 150bb10a28b9c8709ae227fc898d9cf6136faa1e ]

generic/388 has an annoying tendency to fail like this during log
recovery:

XFS (sda4): Unmounting Filesystem 435fe39b-82b6-46ef-be56-819499585130
XFS (sda4): Mounting V5 Filesystem 435fe39b-82b6-46ef-be56-819499585130
XFS (sda4): Starting recovery (logdev: internal)
00000000: 49 4e 81 b6 03 02 00 00 00 00 00 07 00 00 00 07  IN..............
00000010: 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 10  ................
00000020: 35 9a 8b c1 3e 6e 81 00 35 9a 8b c1 3f dc b7 00  5...>n..5...?...
00000030: 35 9a 8b c1 3f dc b7 00 00 00 00 00 00 3c 86 4f  5...?........<.O
00000040: 00 00 00 00 00 00 02 f3 00 00 00 00 00 00 00 00  ................
00000050: 00 00 1f 01 00 00 00 00 00 00 00 02 b2 74 c9 0b  .............t..
00000060: ff ff ff ff d7 45 73 10 00 00 00 00 00 00 00 2d  .....Es........-
00000070: 00 00 07 92 00 01 fe 30 00 00 00 00 00 00 00 1a  .......0........
00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00000090: 35 9a 8b c1 3b 55 0c 00 00 00 00 00 04 27 b2 d1  5...;U.......'..
000000a0: 43 5f e3 9b 82 b6 46 ef be 56 81 94 99 58 51 30  C_....F..V...XQ0
XFS (sda4): Internal error Bad dinode after recovery at line 539 of file fs/xfs/xfs_inode_item_recover.c.  Caller xlog_recover_items_pass2+0x4e/0xc0 [xfs]
CPU: 0 PID: 2189311 Comm: mount Not tainted 6.9.0-rc4-djwx #rc4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20171121_152543-x86-ol7-builder-01.us.oracle.com-4.el7.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x4f/0x60
 xfs_corruption_error+0x90/0xa0
 xlog_recover_inode_commit_pass2+0x5f1/0xb00
 xlog_recover_items_pass2+0x4e/0xc0
 xlog_recover_commit_trans+0x2db/0x350
 xlog_recovery_process_trans+0xab/0xe0
 xlog_recover_process_data+0xa7/0x130
 xlog_do_recovery_pass+0x398/0x840
 xlog_do_log_recovery+0x62/0xc0
 xlog_do_recover+0x34/0x1d0
 xlog_recover+0xe9/0x1a0
 xfs_log_mount+0xff/0x260
 xfs_mountfs+0x5d9/0xb60
 xfs_fs_fill_super+0x76b/0xa30
 get_tree_bdev+0x124/0x1d0
 vfs_get_tree+0x17/0xa0
 path_mount+0x72b/0xa90
 __x64_sys_mount+0x112/0x150
 do_syscall_64+0x49/0x100
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
 </TASK>
XFS (sda4): Corruption detected. Unmount and run xfs_repair
XFS (sda4): Metadata corruption detected at xfs_dinode_verify.part.0+0x739/0x920 [xfs], inode 0x427b2d1
XFS (sda4): Filesystem has been shut down due to log error (0x2).
XFS (sda4): Please unmount the filesystem and rectify the problem(s).
XFS (sda4): log mount/recovery failed: error -117
XFS (sda4): log mount failed

This inode log item recovery failing the dinode verifier after
replaying the contents of the inode log item into the ondisk inode.
Looking back into what the kernel was doing at the time of the fs
shutdown, a thread was in the middle of running a series of
transactions, each of which committed changes to the inode.

At some point in the middle of that chain, an invalid (at least
according to the verifier) change was committed.  Had the filesystem not
shut down in the middle of the chain, a subsequent transaction would
have corrected the invalid state and nobody would have noticed.  But
that's not what happened here.  Instead, the invalid inode state was
committed to the ondisk log, so log recovery tripped over it.

The actual defect here was an overzealous inode verifier, which was
fixed in a separate patch.  This patch adds some transaction precommit
functions for CONFIG_XFS_DEBUG=y mode so that we can detect these kinds
of transient errors at transaction commit time, where it's much easier
to find the root cause.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/Kconfig          | 12 ++++++++++++
 fs/xfs/xfs.h            |  4 ++++
 fs/xfs/xfs_buf_item.c   | 32 ++++++++++++++++++++++++++++++++
 fs/xfs/xfs_dquot_item.c | 31 +++++++++++++++++++++++++++++++
 fs/xfs/xfs_inode_item.c | 32 ++++++++++++++++++++++++++++++++
 5 files changed, 111 insertions(+)

diff --git a/fs/xfs/Kconfig b/fs/xfs/Kconfig
index 9fac5ea8d0e4..dff90db507e3 100644
--- a/fs/xfs/Kconfig
+++ b/fs/xfs/Kconfig
@@ -152,10 +152,22 @@ config XFS_DEBUG
 	  Note that the resulting code will be HUGE and SLOW, and probably
 	  not useful unless you are debugging a particular problem.
 
 	  Say N unless you are an XFS developer, or you play one on TV.
 
+config XFS_DEBUG_EXPENSIVE
+	bool "XFS expensive debugging checks"
+	depends on XFS_FS && XFS_DEBUG
+	help
+	  Say Y here to get an XFS build with expensive debugging checks
+	  enabled.  These checks may affect performance significantly.
+
+	  Note that the resulting code will be HUGER and SLOWER, and probably
+	  not useful unless you are debugging a particular problem.
+
+	  Say N unless you are an XFS developer, or you play one on TV.
+
 config XFS_ASSERT_FATAL
 	bool "XFS fatal asserts"
 	default y
 	depends on XFS_FS && XFS_DEBUG
 	help
diff --git a/fs/xfs/xfs.h b/fs/xfs/xfs.h
index f6ffb4f248f7..9355ccad9503 100644
--- a/fs/xfs/xfs.h
+++ b/fs/xfs/xfs.h
@@ -8,10 +8,14 @@
 
 #ifdef CONFIG_XFS_DEBUG
 #define DEBUG 1
 #endif
 
+#ifdef CONFIG_XFS_DEBUG_EXPENSIVE
+#define DEBUG_EXPENSIVE 1
+#endif
+
 #ifdef CONFIG_XFS_ASSERT_FATAL
 #define XFS_ASSERT_FATAL 1
 #endif
 
 #ifdef CONFIG_XFS_WARN
diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 023d4e0385dd..b02ce568de0c 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -20,10 +20,11 @@
 #include "xfs_dquot_item.h"
 #include "xfs_dquot.h"
 #include "xfs_trace.h"
 #include "xfs_log.h"
 #include "xfs_log_priv.h"
+#include "xfs_error.h"
 
 
 struct kmem_cache	*xfs_buf_item_cache;
 
 static inline struct xfs_buf_log_item *BUF_ITEM(struct xfs_log_item *lip)
@@ -779,12 +780,43 @@ xfs_buf_item_committed(
 	if ((bip->bli_flags & XFS_BLI_INODE_ALLOC_BUF) && lip->li_lsn != 0)
 		return lip->li_lsn;
 	return lsn;
 }
 
+#ifdef DEBUG_EXPENSIVE
+static int
+xfs_buf_item_precommit(
+	struct xfs_trans	*tp,
+	struct xfs_log_item	*lip)
+{
+	struct xfs_buf_log_item	*bip = BUF_ITEM(lip);
+	struct xfs_buf		*bp = bip->bli_buf;
+	struct xfs_mount	*mp = bp->b_mount;
+	xfs_failaddr_t		fa;
+
+	if (!bp->b_ops || !bp->b_ops->verify_struct)
+		return 0;
+	if (bip->bli_flags & XFS_BLI_STALE)
+		return 0;
+
+	fa = bp->b_ops->verify_struct(bp);
+	if (fa) {
+		xfs_buf_verifier_error(bp, -EFSCORRUPTED, bp->b_ops->name,
+				bp->b_addr, BBTOB(bp->b_length), fa);
+		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_INCORE);
+		ASSERT(fa == NULL);
+	}
+
+	return 0;
+}
+#else
+# define xfs_buf_item_precommit	NULL
+#endif
+
 static const struct xfs_item_ops xfs_buf_item_ops = {
 	.iop_size	= xfs_buf_item_size,
+	.iop_precommit	= xfs_buf_item_precommit,
 	.iop_format	= xfs_buf_item_format,
 	.iop_pin	= xfs_buf_item_pin,
 	.iop_unpin	= xfs_buf_item_unpin,
 	.iop_release	= xfs_buf_item_release,
 	.iop_committing	= xfs_buf_item_committing,
diff --git a/fs/xfs/xfs_dquot_item.c b/fs/xfs/xfs_dquot_item.c
index 6a1aae799cf1..7d19091215b0 100644
--- a/fs/xfs/xfs_dquot_item.c
+++ b/fs/xfs/xfs_dquot_item.c
@@ -15,10 +15,11 @@
 #include "xfs_trans.h"
 #include "xfs_buf_item.h"
 #include "xfs_trans_priv.h"
 #include "xfs_qm.h"
 #include "xfs_log.h"
+#include "xfs_error.h"
 
 static inline struct xfs_dq_logitem *DQUOT_ITEM(struct xfs_log_item *lip)
 {
 	return container_of(lip, struct xfs_dq_logitem, qli_item);
 }
@@ -191,12 +192,42 @@ xfs_qm_dquot_logitem_committing(
 	xfs_csn_t		seq)
 {
 	return xfs_qm_dquot_logitem_release(lip);
 }
 
+#ifdef DEBUG_EXPENSIVE
+static int
+xfs_qm_dquot_logitem_precommit(
+	struct xfs_trans	*tp,
+	struct xfs_log_item	*lip)
+{
+	struct xfs_dquot	*dqp = DQUOT_ITEM(lip)->qli_dquot;
+	struct xfs_mount	*mp = dqp->q_mount;
+	struct xfs_disk_dquot	ddq = { };
+	xfs_failaddr_t		fa;
+
+	xfs_dquot_to_disk(&ddq, dqp);
+	fa = xfs_dquot_verify(mp, &ddq, dqp->q_id);
+	if (fa) {
+		XFS_CORRUPTION_ERROR("Bad dquot during logging",
+				XFS_ERRLEVEL_LOW, mp, &ddq, sizeof(ddq));
+		xfs_alert(mp,
+ "Metadata corruption detected at %pS, dquot 0x%x",
+				fa, dqp->q_id);
+		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_INCORE);
+		ASSERT(fa == NULL);
+	}
+
+	return 0;
+}
+#else
+# define xfs_qm_dquot_logitem_precommit	NULL
+#endif
+
 static const struct xfs_item_ops xfs_dquot_item_ops = {
 	.iop_size	= xfs_qm_dquot_logitem_size,
+	.iop_precommit	= xfs_qm_dquot_logitem_precommit,
 	.iop_format	= xfs_qm_dquot_logitem_format,
 	.iop_pin	= xfs_qm_dquot_logitem_pin,
 	.iop_unpin	= xfs_qm_dquot_logitem_unpin,
 	.iop_release	= xfs_qm_dquot_logitem_release,
 	.iop_committing	= xfs_qm_dquot_logitem_committing,
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 2ec23c9af760..a734ca8d8f03 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -34,10 +34,40 @@ xfs_inode_item_sort(
 	struct xfs_log_item	*lip)
 {
 	return INODE_ITEM(lip)->ili_inode->i_ino;
 }
 
+#ifdef DEBUG_EXPENSIVE
+static void
+xfs_inode_item_precommit_check(
+	struct xfs_inode	*ip)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_dinode	*dip;
+	xfs_failaddr_t		fa;
+
+	dip = kzalloc(mp->m_sb.sb_inodesize, GFP_KERNEL | GFP_NOFS);
+	if (!dip) {
+		ASSERT(dip != NULL);
+		return;
+	}
+
+	xfs_inode_to_disk(ip, dip, 0);
+	xfs_dinode_calc_crc(mp, dip);
+	fa = xfs_dinode_verify(mp, ip->i_ino, dip);
+	if (fa) {
+		xfs_inode_verifier_error(ip, -EFSCORRUPTED, __func__, dip,
+				sizeof(*dip), fa);
+		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_INCORE);
+		ASSERT(fa == NULL);
+	}
+	kfree(dip);
+}
+#else
+# define xfs_inode_item_precommit_check(ip)	((void)0)
+#endif
+
 /*
  * Prior to finally logging the inode, we have to ensure that all the
  * per-modification inode state changes are applied. This includes VFS inode
  * state updates, format conversions, verifier state synchronisation and
  * ensuring the inode buffer remains in memory whilst the inode is dirty.
@@ -166,10 +196,12 @@ xfs_inode_item_precommit(
 	 * in xfs_iflush() for an explanation of this coordination mechanism.
 	 */
 	iip->ili_fields |= (flags | iip->ili_last_fields);
 	spin_unlock(&iip->ili_lock);
 
+	xfs_inode_item_precommit_check(ip);
+
 	/*
 	 * We are done with the log item transaction dirty state, so clear it so
 	 * that it doesn't pollute future transactions.
 	 */
 	iip->ili_dirty_flags = 0;
-- 
2.50.0.rc1.591.g9c95f17f64-goog


