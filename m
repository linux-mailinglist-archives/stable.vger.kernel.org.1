Return-Path: <stable+bounces-35050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87586894221
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B961A1C219F8
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8556B4653C;
	Mon,  1 Apr 2024 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QEbgC+WO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE5A8F5C;
	Mon,  1 Apr 2024 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990177; cv=none; b=CtzGbaC/Xl5YsAd+REe0azZgxhX/O6vbQ7wrhkzw4DAEl9H0YCTD5o/cxid/6ftE+QvgMANyRBDdSJnjnJHC3xofNKMN7a/nOTc3yxxYlMew5LmmH1HyW8HLF8hKZiCiBCQXbZ3Jym8oYdkaMfvgf2WSRMMogaE7naRBVz08Pwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990177; c=relaxed/simple;
	bh=ohFLb+5cSswo2y9al0BzUJaVme4urRusBkXPdb3yV1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+8x9YPru2rMSqldyzF3W5E0NgcltM1reQRhQ7Ik8f6X9uU/18zy/bgDwAheXq077r6GPdFDayZMLGD8XnBn2OCIYFYp+qDgq/aNJHaODTZBY919bD8ptQARMYqRiUFiSr9AbqY8yX4dmpazAVLnn4Q4U0Z5fNjfSNBoFSbu4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QEbgC+WO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5066C433F1;
	Mon,  1 Apr 2024 16:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990177;
	bh=ohFLb+5cSswo2y9al0BzUJaVme4urRusBkXPdb3yV1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QEbgC+WOz6Hm1p4Ng2fVZ2pabIe1FRvnVU72u3VhY7OtOrhbTZHsRUUbYWdl1U457
	 J/TyOJXbSW9tgMe7Z9B6qKvVpsMrPxuS9ihvsTupDVhpn/T+IDEVPMQwn4Y0RQglOq
	 FZzJwkJKsW4XntWMuuIR/jIQQDIA0cgMM2xlXevI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	Alexander Potapenko <glider@google.com>
Subject: [PATCH 6.6 269/396] xfs: initialise di_crc in xfs_log_dinode
Date: Mon,  1 Apr 2024 17:45:18 +0200
Message-ID: <20240401152555.923592372@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Chinner <dchinner@redhat.com>

commit 0573676fdde7ce3829ee6a42a8e5a56355234712 upstream.

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
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_inode_item.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -556,6 +556,9 @@ xfs_inode_to_log_dinode(
 		memset(to->di_pad2, 0, sizeof(to->di_pad2));
 		uuid_copy(&to->di_uuid, &ip->i_mount->m_sb.sb_meta_uuid);
 		to->di_v3_pad = 0;
+
+		/* dummy value for initialisation */
+		to->di_crc = 0;
 	} else {
 		to->di_version = 2;
 		to->di_flushiter = ip->i_flushiter;



