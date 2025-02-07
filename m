Return-Path: <stable+bounces-114302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC58A2CC96
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 20:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8B83A7561
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 19:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A281A3147;
	Fri,  7 Feb 2025 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGcvdgnF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5060B1A3142;
	Fri,  7 Feb 2025 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956550; cv=none; b=VD3JRxsEPKyIWdwNQ5RDDFj+S7u2XHs7HF6fjwltm4S3Bd0q/D8LH/luc6DLkiPn01WXxAA3xVvF6j77AX3zurCm3goc7hLppVBiWwUQRyrvBPeV1wPFQAzTUqOxetBm6FFSpoMr1znqVp71badNfj2j7vZs+CwJWMhrqWCbR10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956550; c=relaxed/simple;
	bh=i1/Cf+BoP37std9//ockXxMRMAbScI6exUFNK/So7CQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVV+ZnhyxRhc/ZjRgfm/S8GZhBqha0hhAkg6F7CXOy2mcR8LU3T5+uZSZrfzLsB0U4XX5r/5+aHSEePvEigTX+05SXuaxQueXgiQsHU2yep92L1ZKbMQ3MmxzMDYaLbseWOKlKl68qTqBMR/4xBdrbdtFlxKuMHatLdr8aJrKaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGcvdgnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C21AC4CED1;
	Fri,  7 Feb 2025 19:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738956550;
	bh=i1/Cf+BoP37std9//ockXxMRMAbScI6exUFNK/So7CQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jGcvdgnF/SLkbAZpj6e+x3VZWo30q6Qo8u/ejiSyz8dL/67wcIZfAtNE4I0f4ixu5
	 sgYkb4V8d0PZyshT1X2zJJVvAGMRCCz2cyJQXgGfpH0SlHUfouWtwxWH4XlaVdbjOi
	 P4nyRvS4Czs8PpCbDK+H7btYNQRnilE6nnkmPG+FyB7Fq3uauSc5l4CLiV0Zlgom2C
	 PP9jhjd98R7W/eLKLNrkPKDEXnnhRWIHLd/ADYfEMvNQUzd9NXO9CGUDQrEgwnL4tx
	 2AXhpjXYhlF06iUBDgmL8CYCFQJ2ulTCIiYZlbtbe9KlCUCG5oAdpIIkiNQS/5YEgs
	 F1nd4yWo2a2vw==
Date: Fri, 07 Feb 2025 11:29:09 -0800
Subject: [PATCH 11/11] xfs: fix mount hang during primary superblock recovery
 failure
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, xfs-stable@lists.linux.dev
Cc: stable@vger.kernel.org, leo.lilong@huawei.com, hch@lst.de, cem@kernel.org,
 stable@vger.kernel.org
Message-ID: <173895601583.3373740.17804889699108024787.stgit@frogsfrogsfrogs>
In-Reply-To: <173895601380.3373740.10524153147164865557.stgit@frogsfrogsfrogs>
References: <173895601380.3373740.10524153147164865557.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Long Li <leo.lilong@huawei.com>

commit efebe42d95fbba91dca6e3e32cb9e0612eb56de5 upstream

When mounting an image containing a log with sb modifications that require
log replay, the mount process hang all the time and stack as follows:

  [root@localhost ~]# cat /proc/557/stack
  [<0>] xfs_buftarg_wait+0x31/0x70
  [<0>] xfs_buftarg_drain+0x54/0x350
  [<0>] xfs_mountfs+0x66e/0xe80
  [<0>] xfs_fs_fill_super+0x7f1/0xec0
  [<0>] get_tree_bdev_flags+0x186/0x280
  [<0>] get_tree_bdev+0x18/0x30
  [<0>] xfs_fs_get_tree+0x1d/0x30
  [<0>] vfs_get_tree+0x2d/0x110
  [<0>] path_mount+0xb59/0xfc0
  [<0>] do_mount+0x92/0xc0
  [<0>] __x64_sys_mount+0xc2/0x160
  [<0>] x64_sys_call+0x2de4/0x45c0
  [<0>] do_syscall_64+0xa7/0x240
  [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

During log recovery, while updating the in-memory superblock from the
primary SB buffer, if an error is encountered, such as superblock
corruption occurs or some other reasons, we will proceed to out_release
and release the xfs_buf. However, this is insufficient because the
xfs_buf's log item has already been initialized and the xfs_buf is held
by the buffer log item as follows, the xfs_buf will not be released,
causing the mount thread to hang.

  xlog_recover_do_primary_sb_buffer
    xlog_recover_do_reg_buffer
      xlog_recover_validate_buf_type
        xfs_buf_item_init(bp, mp)

The solution is straightforward, we simply need to allow it to be
handled by the normal buffer write process. The filesystem will be
shutdown before the submission of buffer_list in xlog_do_recovery_pass(),
ensuring the correct release of the xfs_buf as follows:

  xlog_do_recovery_pass
    error = xlog_recover_process
      xlog_recover_process_data
        xlog_recover_process_ophdr
          xlog_recovery_process_trans
            ...
              xlog_recover_buf_commit_pass2
                error = xlog_recover_do_primary_sb_buffer
                  //Encounter error and return
                if (error)
                  goto out_writebuf
                ...
              out_writebuf:
                xfs_buf_delwri_queue(bp, buffer_list) //add bp to list
                return  error
            ...
    if (!list_empty(&buffer_list))
      if (error)
        xlog_force_shutdown(log, SHUTDOWN_LOG_IO_ERROR); //shutdown first
      xfs_buf_delwri_submit(&buffer_list); //submit buffers in list
        __xfs_buf_submit
          if (bp->b_mount->m_log && xlog_is_shutdown(bp->b_mount->m_log))
            xfs_buf_ioend_fail(bp)  //release bp correctly

Fixes: 6a18765b54e2 ("xfs: update the file system geometry after recoverying superblock buffers")
Cc: stable@vger.kernel.org # v6.12
Signed-off-by: Long Li <leo.lilong@huawei.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/xfs_buf_item_recover.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/xfs_buf_item_recover.c b/fs/xfs/xfs_buf_item_recover.c
index 5180cbf5a90b4b..0185c92df8c2ea 100644
--- a/fs/xfs/xfs_buf_item_recover.c
+++ b/fs/xfs/xfs_buf_item_recover.c
@@ -1036,11 +1036,20 @@ xlog_recover_buf_commit_pass2(
 		error = xlog_recover_do_primary_sb_buffer(mp, item, bp, buf_f,
 				current_lsn);
 		if (error)
-			goto out_release;
+			goto out_writebuf;
 	} else {
 		xlog_recover_do_reg_buffer(mp, item, bp, buf_f, current_lsn);
 	}
 
+	/*
+	 * Buffer held by buf log item during 'normal' buffer recovery must
+	 * be committed through buffer I/O submission path to ensure proper
+	 * release. When error occurs during sb buffer recovery, log shutdown
+	 * will be done before submitting buffer list so that buffers can be
+	 * released correctly through ioend failure path.
+	 */
+out_writebuf:
+
 	/*
 	 * Perform delayed write on the buffer.  Asynchronous writes will be
 	 * slower when taking into account all the buffers to be flushed.


