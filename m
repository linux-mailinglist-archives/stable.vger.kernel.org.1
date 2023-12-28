Return-Path: <stable+bounces-8656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 295EC81F812
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 13:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89FDCB23955
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 12:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127BC7466;
	Thu, 28 Dec 2023 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HAolmphE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C896FD6
	for <stable@vger.kernel.org>; Thu, 28 Dec 2023 12:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206C8C433C7;
	Thu, 28 Dec 2023 12:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703765396;
	bh=RrwknyP3Exg3Jorn3tdd47lgbqM9kgmT3bzy9HjaKn8=;
	h=Subject:To:Cc:From:Date:From;
	b=HAolmphEQ5roi+DKPpAS4noZjeAYdgxJV6V3Aju+jxLw3zIUUGmfAb9BBvfebYPFO
	 QqSf9N26M2ws25ybYJFgLDS5rW1Wk6YV5rjJartFC8wFVrWjBc65BvB4tRZu/cbFMM
	 ZcQqvonw2dn5DzdrdRMyTJQP4W9tZ6pP1dcX4rHI=
Subject: FAILED: patch "[PATCH] smb: client: fix OOB in cifsd when receiving compounded resps" failed to apply to 5.10-stable tree
To: pc@manguebit.com,rtm@csail.mit.edu,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 Dec 2023 12:09:51 +0000
Message-ID: <2023122851-salsa-trapezoid-707d@gregkh>
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
git cherry-pick -x a8f68b11158f09754418de62e6b3e7b9b7a50cc9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023122851-salsa-trapezoid-707d@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

a8f68b11158f ("smb: client: fix OOB in cifsd when receiving compounded resps")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
abdb1742a312 ("cifs: get rid of mount options string parsing")
9fd29a5bae6e ("cifs: use fs_context for automounts")
5dd8ce24667a ("cifs: missing directory in MAINTAINERS file")
332019e23a51 ("Merge tag '5.20-rc-smb3-client-fixes-part2' of git://git.samba.org/sfrench/cifs-2.6")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a8f68b11158f09754418de62e6b3e7b9b7a50cc9 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.com>
Date: Wed, 13 Dec 2023 12:25:56 -0300
Subject: [PATCH] smb: client: fix OOB in cifsd when receiving compounded resps

Validate next header's offset in ->next_header() so that it isn't
smaller than MID_HEADER_SIZE(server) and then standard_receive3() or
->receive() ends up writing off the end of the buffer because
'pdu_length - MID_HEADER_SIZE(server)' wraps up to a huge length:

  BUG: KASAN: slab-out-of-bounds in _copy_to_iter+0x4fc/0x840
  Write of size 701 at addr ffff88800caf407f by task cifsd/1090

  CPU: 0 PID: 1090 Comm: cifsd Not tainted 6.7.0-rc4 #5
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
  rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x4a/0x80
   print_report+0xcf/0x650
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? __phys_addr+0x46/0x90
   kasan_report+0xd8/0x110
   ? _copy_to_iter+0x4fc/0x840
   ? _copy_to_iter+0x4fc/0x840
   kasan_check_range+0x105/0x1b0
   __asan_memcpy+0x3c/0x60
   _copy_to_iter+0x4fc/0x840
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? hlock_class+0x32/0xc0
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? __pfx__copy_to_iter+0x10/0x10
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? lock_is_held_type+0x90/0x100
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? __might_resched+0x278/0x360
   ? __pfx___might_resched+0x10/0x10
   ? srso_alias_return_thunk+0x5/0xfbef5
   __skb_datagram_iter+0x2c2/0x460
   ? __pfx_simple_copy_to_iter+0x10/0x10
   skb_copy_datagram_iter+0x6c/0x110
   tcp_recvmsg_locked+0x9be/0xf40
   ? __pfx_tcp_recvmsg_locked+0x10/0x10
   ? mark_held_locks+0x5d/0x90
   ? srso_alias_return_thunk+0x5/0xfbef5
   tcp_recvmsg+0xe2/0x310
   ? __pfx_tcp_recvmsg+0x10/0x10
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? lock_acquire+0x14a/0x3a0
   ? srso_alias_return_thunk+0x5/0xfbef5
   inet_recvmsg+0xd0/0x370
   ? __pfx_inet_recvmsg+0x10/0x10
   ? __pfx_lock_release+0x10/0x10
   ? do_raw_spin_trylock+0xd1/0x120
   sock_recvmsg+0x10d/0x150
   cifs_readv_from_socket+0x25a/0x490 [cifs]
   ? __pfx_cifs_readv_from_socket+0x10/0x10 [cifs]
   ? srso_alias_return_thunk+0x5/0xfbef5
   cifs_read_from_socket+0xb5/0x100 [cifs]
   ? __pfx_cifs_read_from_socket+0x10/0x10 [cifs]
   ? __pfx_lock_release+0x10/0x10
   ? do_raw_spin_trylock+0xd1/0x120
   ? _raw_spin_unlock+0x23/0x40
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? __smb2_find_mid+0x126/0x230 [cifs]
   cifs_demultiplex_thread+0xd39/0x1270 [cifs]
   ? __pfx_cifs_demultiplex_thread+0x10/0x10 [cifs]
   ? __pfx_lock_release+0x10/0x10
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? mark_held_locks+0x1a/0x90
   ? lockdep_hardirqs_on_prepare+0x136/0x210
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? __kthread_parkme+0xce/0xf0
   ? __pfx_cifs_demultiplex_thread+0x10/0x10 [cifs]
   kthread+0x18d/0x1d0
   ? kthread+0xdb/0x1d0
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x34/0x60
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1b/0x30
   </TASK>

Fixes: 8ce79ec359ad ("cifs: update multiplex loop to handle compounded responses")
Cc: stable@vger.kernel.org
Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 7558167f603c..55b3ce944022 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -532,7 +532,8 @@ struct smb_version_operations {
 				 struct mid_q_entry **, char **, int *);
 	enum securityEnum (*select_sectype)(struct TCP_Server_Info *,
 			    enum securityEnum);
-	int (*next_header)(char *);
+	int (*next_header)(struct TCP_Server_Info *server, char *buf,
+			   unsigned int *noff);
 	/* ioctl passthrough for query_info */
 	int (*ioctl_query_info)(const unsigned int xid,
 				struct cifs_tcon *tcon,
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 9dc6dc2754c2..dd2a1fb65e71 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1201,7 +1201,12 @@ cifs_demultiplex_thread(void *p)
 		server->total_read += length;
 
 		if (server->ops->next_header) {
-			next_offset = server->ops->next_header(buf);
+			if (server->ops->next_header(server, buf, &next_offset)) {
+				cifs_dbg(VFS, "%s: malformed response (next_offset=%u)\n",
+					 __func__, next_offset);
+				cifs_reconnect(server, true);
+				continue;
+			}
 			if (next_offset)
 				server->pdu_size = next_offset;
 		}
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 8f6f0a38b886..62b0a8df867b 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5074,17 +5074,22 @@ smb3_handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 				NULL, 0, false);
 }
 
-static int
-smb2_next_header(char *buf)
+static int smb2_next_header(struct TCP_Server_Info *server, char *buf,
+			    unsigned int *noff)
 {
 	struct smb2_hdr *hdr = (struct smb2_hdr *)buf;
 	struct smb2_transform_hdr *t_hdr = (struct smb2_transform_hdr *)buf;
 
-	if (hdr->ProtocolId == SMB2_TRANSFORM_PROTO_NUM)
-		return sizeof(struct smb2_transform_hdr) +
-		  le32_to_cpu(t_hdr->OriginalMessageSize);
-
-	return le32_to_cpu(hdr->NextCommand);
+	if (hdr->ProtocolId == SMB2_TRANSFORM_PROTO_NUM) {
+		*noff = le32_to_cpu(t_hdr->OriginalMessageSize);
+		if (unlikely(check_add_overflow(*noff, sizeof(*t_hdr), noff)))
+			return -EINVAL;
+	} else {
+		*noff = le32_to_cpu(hdr->NextCommand);
+	}
+	if (unlikely(*noff && *noff < MID_HEADER_SIZE(server)))
+		return -EINVAL;
+	return 0;
 }
 
 int cifs_sfu_make_node(unsigned int xid, struct inode *inode,


