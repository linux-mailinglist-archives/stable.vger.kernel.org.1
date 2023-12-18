Return-Path: <stable+bounces-6959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF89781674C
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 08:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41F87B20EFF
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 07:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6827A79E2;
	Mon, 18 Dec 2023 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qUwgoo0X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3306179D1
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603D1C433C8;
	Mon, 18 Dec 2023 07:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702884073;
	bh=wu63cmdqsrbaiS1TbXx7u7Uj8tG/9V48INYAZWwVmFc=;
	h=Subject:To:Cc:From:Date:From;
	b=qUwgoo0XW9X3u+pOXavihNhENgvEskva4IUDLXXVm/COgFIB1YJJZMHJiBHEDRxRH
	 OTn8FAdPLpj4wMPIdWw1t5M2SsCebJ6Trv6Yg7h+x3WQuJbm+OIr4QQQhCBybVJrKQ
	 G1MOcOqZu2z2RxRshoqVvqDoqfQC4dHmmj34rLL4=
Subject: FAILED: patch "[PATCH] smb: client: fix OOB in smb2_query_reparse_point()" failed to apply to 5.10-stable tree
To: pc@manguebit.com,rtm@csail.mit.edu,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Dec 2023 08:21:02 +0100
Message-ID: <2023121802-manhandle-dynamite-db21@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3a42709fa909e22b0be4bb1e2795aa04ada732a3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121802-manhandle-dynamite-db21@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

3a42709fa909 ("smb: client: fix OOB in smb2_query_reparse_point()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3a42709fa909e22b0be4bb1e2795aa04ada732a3 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.com>
Date: Mon, 11 Dec 2023 10:26:43 -0300
Subject: [PATCH] smb: client: fix OOB in smb2_query_reparse_point()

Validate @ioctl_rsp->OutputOffset and @ioctl_rsp->OutputCount so that
their sum does not wrap to a number that is smaller than @reparse_buf
and we end up with a wild pointer as follows:

  BUG: unable to handle page fault for address: ffff88809c5cd45f
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 4a01067 P4D 4a01067 PUD 0
  Oops: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 2 PID: 1260 Comm: mount.cifs Not tainted 6.7.0-rc4 #2
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
  rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
  RIP: 0010:smb2_query_reparse_point+0x3e0/0x4c0 [cifs]
  Code: ff ff e8 f3 51 fe ff 41 89 c6 58 5a 45 85 f6 0f 85 14 fe ff ff
  49 8b 57 48 8b 42 60 44 8b 42 64 42 8d 0c 00 49 39 4f 50 72 40 <8b>
  04 02 48 8b 9d f0 fe ff ff 49 8b 57 50 89 03 48 8b 9d e8 fe ff
  RSP: 0018:ffffc90000347a90 EFLAGS: 00010212
  RAX: 000000008000001f RBX: ffff88800ae11000 RCX: 00000000000000ec
  RDX: ffff88801c5cd440 RSI: 0000000000000000 RDI: ffffffff82004aa4
  RBP: ffffc90000347bb0 R08: 00000000800000cd R09: 0000000000000001
  R10: 0000000000000000 R11: 0000000000000024 R12: ffff8880114d4100
  R13: ffff8880114d4198 R14: 0000000000000000 R15: ffff8880114d4000
  FS: 00007f02c07babc0(0000) GS:ffff88806ba00000(0000)
  knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffff88809c5cd45f CR3: 0000000011750000 CR4: 0000000000750ef0
  PKRU: 55555554
  Call Trace:
   <TASK>
   ? __die+0x23/0x70
   ? page_fault_oops+0x181/0x480
   ? search_module_extables+0x19/0x60
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? exc_page_fault+0x1b6/0x1c0
   ? asm_exc_page_fault+0x26/0x30
   ? _raw_spin_unlock_irqrestore+0x44/0x60
   ? smb2_query_reparse_point+0x3e0/0x4c0 [cifs]
   cifs_get_fattr+0x16e/0xa50 [cifs]
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? lock_acquire+0xbf/0x2b0
   cifs_root_iget+0x163/0x5f0 [cifs]
   cifs_smb3_do_mount+0x5bd/0x780 [cifs]
   smb3_get_tree+0xd9/0x290 [cifs]
   vfs_get_tree+0x2c/0x100
   ? capable+0x37/0x70
   path_mount+0x2d7/0xb80
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? _raw_spin_unlock_irqrestore+0x44/0x60
   __x64_sys_mount+0x11a/0x150
   do_syscall_64+0x47/0xf0
   entry_SYSCALL_64_after_hwframe+0x6f/0x77
  RIP: 0033:0x7f02c08d5b1e

Fixes: 2e4564b31b64 ("smb3: add support for stat of WSL reparse points for special file types")
Cc: stable@vger.kernel.org
Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index a6f4948adcbb..8f6f0a38b886 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3003,7 +3003,7 @@ static int smb2_query_reparse_point(const unsigned int xid,
 	struct kvec *rsp_iov;
 	struct smb2_ioctl_rsp *ioctl_rsp;
 	struct reparse_data_buffer *reparse_buf;
-	u32 plen;
+	u32 off, count, len;
 
 	cifs_dbg(FYI, "%s: path: %s\n", __func__, full_path);
 
@@ -3084,16 +3084,22 @@ static int smb2_query_reparse_point(const unsigned int xid,
 	 */
 	if (rc == 0) {
 		/* See MS-FSCC 2.3.23 */
+		off = le32_to_cpu(ioctl_rsp->OutputOffset);
+		count = le32_to_cpu(ioctl_rsp->OutputCount);
+		if (check_add_overflow(off, count, &len) ||
+		    len > rsp_iov[1].iov_len) {
+			cifs_tcon_dbg(VFS, "%s: invalid ioctl: off=%d count=%d\n",
+				      __func__, off, count);
+			rc = -EIO;
+			goto query_rp_exit;
+		}
 
-		reparse_buf = (struct reparse_data_buffer *)
-			((char *)ioctl_rsp +
-			 le32_to_cpu(ioctl_rsp->OutputOffset));
-		plen = le32_to_cpu(ioctl_rsp->OutputCount);
-
-		if (plen + le32_to_cpu(ioctl_rsp->OutputOffset) >
-		    rsp_iov[1].iov_len) {
-			cifs_tcon_dbg(FYI, "srv returned invalid ioctl len: %d\n",
-				 plen);
+		reparse_buf = (void *)((u8 *)ioctl_rsp + off);
+		len = sizeof(*reparse_buf);
+		if (count < len ||
+		    count < le16_to_cpu(reparse_buf->ReparseDataLength) + len) {
+			cifs_tcon_dbg(VFS, "%s: invalid ioctl: off=%d count=%d\n",
+				      __func__, off, count);
 			rc = -EIO;
 			goto query_rp_exit;
 		}


