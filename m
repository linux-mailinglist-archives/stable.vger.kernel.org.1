Return-Path: <stable+bounces-124379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE47A6029D
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F3019C58E1
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B881F3FED;
	Thu, 13 Mar 2025 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AE53mhJE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD841F4603
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897588; cv=none; b=mWlLl5Xf/kOZdAXOxSHJ2GfYX9nLC6UtjeAJ3CH66vB0PSM97V+eu67nwqr4mEcDvZ3OPCBubZEdIVzxWlxTU423PZEJzJYkb9ZE+1dEd82h+JnZ0ChOHCMT9u1Emgw+tTj7b0uSgNuF+WbPrmHdWcc3a1sRsTwa/1kJuL4XF0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897588; c=relaxed/simple;
	bh=0o3rySqvjXETfrOZ5E7FlTGLavyu02CxrKVfZqeTLJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlkoG2tmDrI4iYMdDKQD5Jn7iEH2HsLoGGE6IheSfDFYMjau+avGUrpiu2D06Dw7rB/0DaO2SSwIAYcjrWilm2Sv189VhYu0bDjXN6Hz0Cu9JUc2xg1MacAdIHaU+HXYgAxt/FjiBCLeS8CVZVOLQDr9ykGHxAxwnmh0eJ5ATA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AE53mhJE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22438c356c8so28483505ad.1
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897587; x=1742502387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DFCjHzkKjbVfWrYut0qEvJjNbAdFZgdjHnMa6VC2I0=;
        b=AE53mhJEZVLHYT4G4kgQX3EIa2eUdCoKFeajrjTa58RvfyvZMgFHLHWpeJUOtsOkJX
         lQ6lGxftknCaWCi6D2UIaWzwJ2CeNOYmDqr313uhnwt0WxsaGibyNpkDZoJRChOF8x7R
         VHgCSP2TpGpbwVN1/WZbh4ith3I/bZO26pkE5KJnjPpPko2MRjer9vX5OM1hjTvcG2s5
         1UOfTSulXZXLALzmnNjm9h3OYUkDARCf66IvxlKpqd/8Q1wvBvi6IjSCJ+jXDI8U/kbM
         b2JPG/Dgo9t3alFX1xD1GCMSmkZwyFwp8z/S9rFJAoH2J0d3Tv0LfrXMWqZRJ1vDnv5H
         aMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897587; x=1742502387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DFCjHzkKjbVfWrYut0qEvJjNbAdFZgdjHnMa6VC2I0=;
        b=JVdzxzTQ5iw0i/+R7I8v46LroJlMf5NabHj3OsnmIMMTRz10GFuZHES4shk0jZCWll
         2jB7/Ovl4URYdjj8ZUMpNh3CAepctpcnYGy+q8ewaXBC89wWoB+IJ+0sAoV5I38J7MV1
         MAAECiZjCqSpHbnwTn8ar5A1KKEw5I9LzJpfns1SOS9HrpyDdLg8uUt82w1rIqvFHk/D
         /9QE7J08xsdydo7pSndaR8q5IL6Goln0BnmMxp7icpaaFwXexVCIs41bzliV0dK7qQsj
         ZH9B8ETV3ulWRGp4bxrzJF3j4sShHM2MiKycQK3YUKtEUZ2A7345oOOf2QfF5xjW5O1A
         upMA==
X-Gm-Message-State: AOJu0YyywymV7eo2yG4xGBZP+8MC42dYhhHdgZHRBXUOsMUKX52Oinj/
	SxVAfwx7Mhnp4ZMTMmyjVUPiOWG97xHAJZQIE3DvMk85SPstI4peM5Cp4PKj
X-Gm-Gg: ASbGncuA0JdpRYit6vxr13szA8JYNdga/AMt9sKl6J7cTohBzTaHg9atWGCQecr51Ke
	vwTbhy/gfHmycdKVwtrWbC7RixbUBfAU2AANOmhXI8e9EdpOde2Xg5JTYGMl7QoJ6AlluCwILUq
	nIUSGv0y1WpUdCmLK1QCf611AXW7qWjQ+l9xvSKM2KyBf20rA1FIkre9BLKBpB5+h8nehBgR9HE
	GZx3ebU9s4GninBf1h2GW4mcKezEZZ00muEWUf1LgbNz/JAxQbucGtuTdikyPC5tybensg9/NR4
	XEvMOLD77N8uUALRJAB6734K6Hb2L3tw5lhOs9R5WO51Catb2Lqx3opC4ySwl2wNcOqy8es=
X-Google-Smtp-Source: AGHT+IFVLaR06rcZiwu8EzAhitIiK1WZRLWun6FnBzQ7ZW5Yc1bBWyATlloyj4IynEwFpdKpq8VMZg==
X-Received: by 2002:a17:902:f647:b0:21f:7077:2aaf with SMTP id d9443c01a7336-225dd901b2emr11921985ad.44.1741897586614;
        Thu, 13 Mar 2025 13:26:26 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:26 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	Dave Chinner <dchinner@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 23/29] xfs: initialise di_crc in xfs_log_dinode
Date: Thu, 13 Mar 2025 13:25:43 -0700
Message-ID: <20250313202550.2257219-24-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
In-Reply-To: <20250313202550.2257219-1-leah.rumancik@gmail.com>
References: <20250313202550.2257219-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

[ Upstream commit 0573676fdde7ce3829ee6a42a8e5a56355234712 ]

Alexander Potapenko report that KMSAN was issuing these warnings:

kmalloc-ed xlog buffer of size 512 : ffff88802fc26200
kmalloc-ed xlog buffer of size 368 : ffff88802fc24a00
kmalloc-ed xlog buffer of size 648 : ffff88802b631000
kmalloc-ed xlog buffer of size 648 : ffff88802b632800
kmalloc-ed xlog buffer of size 648 : ffff88802b631c00
xlog_write_iovec: copying 12 bytes from ffff888017ddbbd8 to ffff88802c300400
xlog_write_iovec: copying 28 bytes from ffff888017ddbbe4 to ffff88802c30040c
xlog_write_iovec: copying 68 bytes from ffff88802fc26274 to ffff88802c300428
xlog_write_iovec: copying 188 bytes from ffff88802fc262bc to ffff88802c30046c
=====================================================
BUG: KMSAN: uninit-value in xlog_write_iovec fs/xfs/xfs_log.c:2227
BUG: KMSAN: uninit-value in xlog_write_full fs/xfs/xfs_log.c:2263
BUG: KMSAN: uninit-value in xlog_write+0x1fac/0x2600 fs/xfs/xfs_log.c:2532
 xlog_write_iovec fs/xfs/xfs_log.c:2227
 xlog_write_full fs/xfs/xfs_log.c:2263
 xlog_write+0x1fac/0x2600 fs/xfs/xfs_log.c:2532
 xlog_cil_write_chain fs/xfs/xfs_log_cil.c:918
 xlog_cil_push_work+0x30f2/0x44e0 fs/xfs/xfs_log_cil.c:1263
 process_one_work kernel/workqueue.c:2630
 process_scheduled_works+0x1188/0x1e30 kernel/workqueue.c:2703
 worker_thread+0xee5/0x14f0 kernel/workqueue.c:2784
 kthread+0x391/0x500 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Uninit was created at:
 slab_post_alloc_hook+0x101/0xac0 mm/slab.h:768
 slab_alloc_node mm/slub.c:3482
 __kmem_cache_alloc_node+0x612/0xae0 mm/slub.c:3521
 __do_kmalloc_node mm/slab_common.c:1006
 __kmalloc+0x11a/0x410 mm/slab_common.c:1020
 kmalloc ./include/linux/slab.h:604
 xlog_kvmalloc fs/xfs/xfs_log_priv.h:704
 xlog_cil_alloc_shadow_bufs fs/xfs/xfs_log_cil.c:343
 xlog_cil_commit+0x487/0x4dc0 fs/xfs/xfs_log_cil.c:1574
 __xfs_trans_commit+0x8df/0x1930 fs/xfs/xfs_trans.c:1017
 xfs_trans_commit+0x30/0x40 fs/xfs/xfs_trans.c:1061
 xfs_create+0x15af/0x2150 fs/xfs/xfs_inode.c:1076
 xfs_generic_create+0x4cd/0x1550 fs/xfs/xfs_iops.c:199
 xfs_vn_create+0x4a/0x60 fs/xfs/xfs_iops.c:275
 lookup_open fs/namei.c:3477
 open_last_lookups fs/namei.c:3546
 path_openat+0x29ac/0x6180 fs/namei.c:3776
 do_filp_open+0x24d/0x680 fs/namei.c:3809
 do_sys_openat2+0x1bc/0x330 fs/open.c:1440
 do_sys_open fs/open.c:1455
 __do_sys_openat fs/open.c:1471
 __se_sys_openat fs/open.c:1466
 __x64_sys_openat+0x253/0x330 fs/open.c:1466
 do_syscall_x64 arch/x86/entry/common.c:51
 do_syscall_64+0x4f/0x140 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b arch/x86/entry/entry_64.S:120

Bytes 112-115 of 188 are uninitialized
Memory access of size 188 starts at ffff88802fc262bc

This is caused by the struct xfs_log_dinode not having the di_crc
field initialised. Log recovery never uses this field (it is only
present these days for on-disk format compatibility reasons) and so
it's value is never checked so nothing in XFS has caught this.

Further, none of the uninitialised memory access warning tools have
caught this (despite catching other uninit memory accesses in the
struct xfs_log_dinode back in 2017!) until recently. Alexander
annotated the XFS code to get the dump of the actual bytes that were
detected as uninitialised, and from that report it took me about 30s
to realise what the issue was.

The issue was introduced back in 2016 and every inode that is logged
fails to initialise this field. This is no actual bad behaviour
caused by this issue - I find it hard to even classify it as a
bug...

Reported-and-tested-by: Alexander Potapenko <glider@google.com>
Fixes: f8d55aa0523a ("xfs: introduce inode log format object")
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_inode_item.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 91c847a84e10..2ec23c9af760 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -554,10 +554,13 @@ xfs_inode_to_log_dinode(
 		to->di_ino = ip->i_ino;
 		to->di_lsn = lsn;
 		memset(to->di_pad2, 0, sizeof(to->di_pad2));
 		uuid_copy(&to->di_uuid, &ip->i_mount->m_sb.sb_meta_uuid);
 		to->di_v3_pad = 0;
+
+		/* dummy value for initialisation */
+		to->di_crc = 0;
 	} else {
 		to->di_version = 2;
 		to->di_flushiter = ip->i_flushiter;
 		memset(to->di_v2_pad, 0, sizeof(to->di_v2_pad));
 	}
-- 
2.49.0.rc1.451.g8f38331e32-goog


