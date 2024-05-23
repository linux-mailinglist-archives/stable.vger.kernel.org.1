Return-Path: <stable+bounces-45921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5591C8CD491
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A93A3B23702
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FBD14830E;
	Thu, 23 May 2024 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0gLBWgTw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8359D1E497;
	Thu, 23 May 2024 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470746; cv=none; b=baTn3wulmiNfKMB+DR+fXnIX6q9lFiZz5I1/DYcU1f0pqTAR/LbxF92ZrcrWkTv6/d5FM3Vsg506hScJBLGWvPMdHXEa8CHA50+lG7Uc0rVLaSqYw8Eh4y27w1iHJhylu8hWupPn4hAWmPioSnTuGJLIg5OqPFS2/WsgCDWC6Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470746; c=relaxed/simple;
	bh=PQT+AkbWYAe5vGMUMUKenkfv3vs+MAwr58Yw8auunbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNSwvQI3xrN5uj4kWNK3ZElIkWEsSi1Wdg1eK9t1HOhNMC7JE6dZ94I3TzcuZW9Bo+NokpWJ3tgqXVtDGOAoWRmIO161otfDra4sni8keObntdEWqLc0kTUuDVvU+iznhR+VptMXhAKqI91euXEREH8NUzai30ZnOPszvgN/Fpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0gLBWgTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02007C2BD10;
	Thu, 23 May 2024 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470746;
	bh=PQT+AkbWYAe5vGMUMUKenkfv3vs+MAwr58Yw8auunbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0gLBWgTw8EwX9VCR4oc7y9zudhhr/jikx+QWEQyFQ2/DodvQAIcSurRcjJD5g8UDX
	 qbRKuxNG6yOyWELxduW7VpWNNfEKbachPQLFNtIfrUsQlStyfdSO0xUOtCJxVyHh3v
	 Ws59onUXi2eW1l/11/GToLu4ey4WRBELu8gRiFyw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 073/102] smb: client: instantiate when creating SFU files
Date: Thu, 23 May 2024 15:13:38 +0200
Message-ID: <20240523130345.220416383@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523130342.462912131@linuxfoundation.org>
References: <20240523130342.462912131@linuxfoundation.org>
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

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit c6ff459037b2e35450af2351037eac4c8aca1d6b ]

In cifs_sfu_make_node(), on success, instantiate rather than leave it
with dentry unhashed negative to support callers that expect mknod(2)
to always instantiate.

This fixes the following test case:

  mount.cifs //srv/share /mnt -o ...,sfu
  mkfifo /mnt/fifo
  ./xfstests/ltp/growfiles -b -W test -e 1 -u -i 0 -L 30 /mnt/fifo
  ...
  BUG: unable to handle page fault for address: 000000034cec4e58
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 1 PREEMPT SMP PTI
  CPU: 0 PID: 138098 Comm: growfiles Kdump: loaded Not tainted
  5.14.0-436.3987_1240945149.el9.x86_64 #1
  Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
  RIP: 0010:_raw_callee_save__kvm_vcpu_is_preempted+0x0/0x20
  Code: e8 15 d9 61 00 e9 63 ff ff ff 41 bd ea ff ff ff e9 58 ff ff ff e8
  d0 71 c0 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <48> 8b 04
  fd 60 2b c1 99 80 b8 90 50 03 00 00 0f 95 c0 c3 cc cc cc
  RSP: 0018:ffffb6a143cf7cf8 EFLAGS: 00010206
  RAX: ffff8a9bc30fb038 RBX: ffff8a9bc666a200 RCX: ffff8a9cc0260000
  RDX: 00000000736f622e RSI: ffff8a9bc30fb038 RDI: 000000007665645f
  RBP: ffffb6a143cf7d70 R08: 0000000000001000 R09: 0000000000000001
  R10: 0000000000000001 R11: 0000000000000000 R12: ffff8a9bc666a200
  R13: 0000559a302a12b0 R14: 0000000000001000 R15: 0000000000000000
  FS: 00007fbed1dbb740(0000) GS:ffff8a9cf0000000(0000)
  knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 000000034cec4e58 CR3: 0000000128ec6006 CR4: 0000000000770ef0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  PKRU: 55555554
  Call Trace:
   <TASK>
   ? show_trace_log_lvl+0x1c4/0x2df
   ? show_trace_log_lvl+0x1c4/0x2df
   ? __mutex_lock.constprop.0+0x5f7/0x6a0
   ? __die_body.cold+0x8/0xd
   ? page_fault_oops+0x134/0x170
   ? exc_page_fault+0x62/0x150
   ? asm_exc_page_fault+0x22/0x30
   ? _pfx_raw_callee_save__kvm_vcpu_is_preempted+0x10/0x10
   __mutex_lock.constprop.0+0x5f7/0x6a0
   ? __mod_memcg_lruvec_state+0x84/0xd0
   pipe_write+0x47/0x650
   ? do_anonymous_page+0x258/0x410
   ? inode_security+0x22/0x60
   ? selinux_file_permission+0x108/0x150
   vfs_write+0x2cb/0x410
   ksys_write+0x5f/0xe0
   do_syscall_64+0x5c/0xf0
   ? syscall_exit_to_user_mode+0x22/0x40
   ? do_syscall_64+0x6b/0xf0
   ? sched_clock_cpu+0x9/0xc0
   ? exc_page_fault+0x62/0x150
   entry_SYSCALL_64_after_hwframe+0x6e/0x76

Cc: stable@vger.kernel.org
Fixes: 72bc63f5e23a ("smb3: fix creating FIFOs when mounting with "sfu" mount option")
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2ops.c | 94 ++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 39 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 981a922cf38f0..df6c6d31236ad 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4956,68 +4956,84 @@ static int smb2_next_header(struct TCP_Server_Info *server, char *buf,
 	return 0;
 }
 
-int cifs_sfu_make_node(unsigned int xid, struct inode *inode,
-		       struct dentry *dentry, struct cifs_tcon *tcon,
-		       const char *full_path, umode_t mode, dev_t dev)
+static int __cifs_sfu_make_node(unsigned int xid, struct inode *inode,
+				struct dentry *dentry, struct cifs_tcon *tcon,
+				const char *full_path, umode_t mode, dev_t dev)
 {
-	struct cifs_open_info_data buf = {};
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct cifs_open_parms oparms;
 	struct cifs_io_parms io_parms = {};
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct cifs_fid fid;
 	unsigned int bytes_written;
-	struct win_dev *pdev;
+	struct win_dev pdev = {};
 	struct kvec iov[2];
 	__u32 oplock = server->oplocks ? REQ_OPLOCK : 0;
 	int rc;
 
-	if (!S_ISCHR(mode) && !S_ISBLK(mode) && !S_ISFIFO(mode))
+	switch (mode & S_IFMT) {
+	case S_IFCHR:
+		strscpy(pdev.type, "IntxCHR", strlen("IntxChr"));
+		pdev.major = cpu_to_le64(MAJOR(dev));
+		pdev.minor = cpu_to_le64(MINOR(dev));
+		break;
+	case S_IFBLK:
+		strscpy(pdev.type, "IntxBLK", strlen("IntxBLK"));
+		pdev.major = cpu_to_le64(MAJOR(dev));
+		pdev.minor = cpu_to_le64(MINOR(dev));
+		break;
+	case S_IFIFO:
+		strscpy(pdev.type, "LnxFIFO", strlen("LnxFIFO"));
+		break;
+	default:
 		return -EPERM;
+	}
 
-	oparms = (struct cifs_open_parms) {
-		.tcon = tcon,
-		.cifs_sb = cifs_sb,
-		.desired_access = GENERIC_WRITE,
-		.create_options = cifs_create_options(cifs_sb, CREATE_NOT_DIR |
-						      CREATE_OPTION_SPECIAL),
-		.disposition = FILE_CREATE,
-		.path = full_path,
-		.fid = &fid,
-	};
+	oparms = CIFS_OPARMS(cifs_sb, tcon, full_path, GENERIC_WRITE,
+			     FILE_CREATE, CREATE_NOT_DIR |
+			     CREATE_OPTION_SPECIAL, ACL_NO_MODE);
+	oparms.fid = &fid;
 
-	rc = server->ops->open(xid, &oparms, &oplock, &buf);
+	rc = server->ops->open(xid, &oparms, &oplock, NULL);
 	if (rc)
 		return rc;
 
-	/*
-	 * BB Do not bother to decode buf since no local inode yet to put
-	 * timestamps in, but we can reuse it safely.
-	 */
-	pdev = (struct win_dev *)&buf.fi;
 	io_parms.pid = current->tgid;
 	io_parms.tcon = tcon;
-	io_parms.length = sizeof(*pdev);
-	iov[1].iov_base = pdev;
-	iov[1].iov_len = sizeof(*pdev);
-	if (S_ISCHR(mode)) {
-		memcpy(pdev->type, "IntxCHR", 8);
-		pdev->major = cpu_to_le64(MAJOR(dev));
-		pdev->minor = cpu_to_le64(MINOR(dev));
-	} else if (S_ISBLK(mode)) {
-		memcpy(pdev->type, "IntxBLK", 8);
-		pdev->major = cpu_to_le64(MAJOR(dev));
-		pdev->minor = cpu_to_le64(MINOR(dev));
-	} else if (S_ISFIFO(mode)) {
-		memcpy(pdev->type, "LnxFIFO", 8);
-	}
+	io_parms.length = sizeof(pdev);
+	iov[1].iov_base = &pdev;
+	iov[1].iov_len = sizeof(pdev);
 
 	rc = server->ops->sync_write(xid, &fid, &io_parms,
 				     &bytes_written, iov, 1);
 	server->ops->close(xid, tcon, &fid);
-	d_drop(dentry);
-	/* FIXME: add code here to set EAs */
-	cifs_free_open_info(&buf);
+	return rc;
+}
+
+int cifs_sfu_make_node(unsigned int xid, struct inode *inode,
+		       struct dentry *dentry, struct cifs_tcon *tcon,
+		       const char *full_path, umode_t mode, dev_t dev)
+{
+	struct inode *new = NULL;
+	int rc;
+
+	rc = __cifs_sfu_make_node(xid, inode, dentry, tcon,
+				  full_path, mode, dev);
+	if (rc)
+		return rc;
+
+	if (tcon->posix_extensions) {
+		rc = smb311_posix_get_inode_info(&new, full_path, NULL,
+						 inode->i_sb, xid);
+	} else if (tcon->unix_ext) {
+		rc = cifs_get_inode_info_unix(&new, full_path,
+					      inode->i_sb, xid);
+	} else {
+		rc = cifs_get_inode_info(&new, full_path, NULL,
+					 inode->i_sb, xid, NULL);
+	}
+	if (!rc)
+		d_instantiate(dentry, new);
 	return rc;
 }
 
-- 
2.43.0




