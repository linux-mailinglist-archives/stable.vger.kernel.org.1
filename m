Return-Path: <stable+bounces-7422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E3981727B
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C59285772
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8374FF9A;
	Mon, 18 Dec 2023 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LpaiBwfT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A17B3787E;
	Mon, 18 Dec 2023 14:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACDAC433C7;
	Mon, 18 Dec 2023 14:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908424;
	bh=V4+yHMq+KHO/qpf44YmWBam38lHYDA2BPiRgcPBqmn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LpaiBwfTa211bYOZt7YnylaLkOKMflffiEY6tMRCvraUPlmTAW9ND5kLrrV74chXH
	 3I06Pyi8N3q6Bjqg0tJIxr+ohzQ2+vgh4PO8IhzYXodMzFCrYFW/NegRiAlXUn4IUo
	 dbd9GarKeEC+Uq/+jy22OZEm4eg9bFGoXp4EwqWo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robert Morris <rtm@csail.mit.edu>,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 154/166] smb: client: fix potential OOBs in smb2_parse_contexts()
Date: Mon, 18 Dec 2023 14:52:00 +0100
Message-ID: <20231218135112.025257069@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
References: <20231218135104.927894164@linuxfoundation.org>
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

commit af1689a9b7701d9907dfc84d2a4b57c4bc907144 upstream.

Validate offsets and lengths before dereferencing create contexts in
smb2_parse_contexts().

This fixes following oops when accessing invalid create contexts from
server:

  BUG: unable to handle page fault for address: ffff8881178d8cc3
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 4a01067 P4D 4a01067 PUD 0
  Oops: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 3 PID: 1736 Comm: mount.cifs Not tainted 6.7.0-rc4 #1
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
  rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
  RIP: 0010:smb2_parse_contexts+0xa0/0x3a0 [cifs]
  Code: f8 10 75 13 48 b8 93 ad 25 50 9c b4 11 e7 49 39 06 0f 84 d2 00
  00 00 8b 45 00 85 c0 74 61 41 29 c5 48 01 c5 41 83 fd 0f 76 55 <0f> b7
  7d 04 0f b7 45 06 4c 8d 74 3d 00 66 83 f8 04 75 bc ba 04 00
  RSP: 0018:ffffc900007939e0 EFLAGS: 00010216
  RAX: ffffc90000793c78 RBX: ffff8880180cc000 RCX: ffffc90000793c90
  RDX: ffffc90000793cc0 RSI: ffff8880178d8cc0 RDI: ffff8880180cc000
  RBP: ffff8881178d8cbf R08: ffffc90000793c22 R09: 0000000000000000
  R10: ffff8880180cc000 R11: 0000000000000024 R12: 0000000000000000
  R13: 0000000000000020 R14: 0000000000000000 R15: ffffc90000793c22
  FS: 00007f873753cbc0(0000) GS:ffff88806bc00000(0000)
  knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffff8881178d8cc3 CR3: 00000000181ca000 CR4: 0000000000750ef0
  PKRU: 55555554
  Call Trace:
   <TASK>
   ? __die+0x23/0x70
   ? page_fault_oops+0x181/0x480
   ? search_module_extables+0x19/0x60
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? exc_page_fault+0x1b6/0x1c0
   ? asm_exc_page_fault+0x26/0x30
   ? smb2_parse_contexts+0xa0/0x3a0 [cifs]
   SMB2_open+0x38d/0x5f0 [cifs]
   ? smb2_is_path_accessible+0x138/0x260 [cifs]
   smb2_is_path_accessible+0x138/0x260 [cifs]
   cifs_is_path_remote+0x8d/0x230 [cifs]
   cifs_mount+0x7e/0x350 [cifs]
   cifs_smb3_do_mount+0x128/0x780 [cifs]
   smb3_get_tree+0xd9/0x290 [cifs]
   vfs_get_tree+0x2c/0x100
   ? capable+0x37/0x70
   path_mount+0x2d7/0xb80
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? _raw_spin_unlock_irqrestore+0x44/0x60
   __x64_sys_mount+0x11a/0x150
   do_syscall_64+0x47/0xf0
   entry_SYSCALL_64_after_hwframe+0x6f/0x77
  RIP: 0033:0x7f8737657b1e

Reported-by: Robert Morris <rtm@csail.mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cached_dir.c |   17 +++++---
 fs/smb/client/smb2pdu.c    |   91 +++++++++++++++++++++++++++------------------
 fs/smb/client/smb2proto.h  |   12 +++--
 3 files changed, 74 insertions(+), 46 deletions(-)

--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -291,16 +291,23 @@ int open_cached_dir(unsigned int xid, st
 	oparms.fid->mid = le64_to_cpu(o_rsp->hdr.MessageId);
 #endif /* CIFS_DEBUG2 */
 
-	rc = -EINVAL;
+
 	if (o_rsp->OplockLevel != SMB2_OPLOCK_LEVEL_LEASE) {
 		spin_unlock(&cfids->cfid_list_lock);
+		rc = -EINVAL;
 		goto oshr_free;
 	}
 
-	smb2_parse_contexts(server, o_rsp,
-			    &oparms.fid->epoch,
-			    oparms.fid->lease_key, &oplock,
-			    NULL, NULL);
+	rc = smb2_parse_contexts(server, rsp_iov,
+				 &oparms.fid->epoch,
+				 oparms.fid->lease_key,
+				 &oplock, NULL, NULL);
+	if (rc) {
+		spin_unlock(&cfids->cfid_list_lock);
+		goto oshr_free;
+	}
+
+	rc = -EINVAL;
 	if (!(oplock & SMB2_LEASE_READ_CACHING_HE)) {
 		spin_unlock(&cfids->cfid_list_lock);
 		goto oshr_free;
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2141,17 +2141,18 @@ parse_posix_ctxt(struct create_context *
 		 posix->nlink, posix->mode, posix->reparse_tag);
 }
 
-void
-smb2_parse_contexts(struct TCP_Server_Info *server,
-		    struct smb2_create_rsp *rsp,
-		    unsigned int *epoch, char *lease_key, __u8 *oplock,
-		    struct smb2_file_all_info *buf,
-		    struct create_posix_rsp *posix)
+int smb2_parse_contexts(struct TCP_Server_Info *server,
+			struct kvec *rsp_iov,
+			unsigned int *epoch,
+			char *lease_key, __u8 *oplock,
+			struct smb2_file_all_info *buf,
+			struct create_posix_rsp *posix)
 {
-	char *data_offset;
+	struct smb2_create_rsp *rsp = rsp_iov->iov_base;
 	struct create_context *cc;
-	unsigned int next;
-	unsigned int remaining;
+	size_t rem, off, len;
+	size_t doff, dlen;
+	size_t noff, nlen;
 	char *name;
 	static const char smb3_create_tag_posix[] = {
 		0x93, 0xAD, 0x25, 0x50, 0x9C,
@@ -2160,45 +2161,63 @@ smb2_parse_contexts(struct TCP_Server_In
 	};
 
 	*oplock = 0;
-	data_offset = (char *)rsp + le32_to_cpu(rsp->CreateContextsOffset);
-	remaining = le32_to_cpu(rsp->CreateContextsLength);
-	cc = (struct create_context *)data_offset;
+
+	off = le32_to_cpu(rsp->CreateContextsOffset);
+	rem = le32_to_cpu(rsp->CreateContextsLength);
+	if (check_add_overflow(off, rem, &len) || len > rsp_iov->iov_len)
+		return -EINVAL;
+	cc = (struct create_context *)((u8 *)rsp + off);
 
 	/* Initialize inode number to 0 in case no valid data in qfid context */
 	if (buf)
 		buf->IndexNumber = 0;
 
-	while (remaining >= sizeof(struct create_context)) {
-		name = le16_to_cpu(cc->NameOffset) + (char *)cc;
-		if (le16_to_cpu(cc->NameLength) == 4 &&
-		    strncmp(name, SMB2_CREATE_REQUEST_LEASE, 4) == 0)
-			*oplock = server->ops->parse_lease_buf(cc, epoch,
-							   lease_key);
-		else if (buf && (le16_to_cpu(cc->NameLength) == 4) &&
-		    strncmp(name, SMB2_CREATE_QUERY_ON_DISK_ID, 4) == 0)
-			parse_query_id_ctxt(cc, buf);
-		else if ((le16_to_cpu(cc->NameLength) == 16)) {
-			if (posix &&
-			    memcmp(name, smb3_create_tag_posix, 16) == 0)
+	while (rem >= sizeof(*cc)) {
+		doff = le16_to_cpu(cc->DataOffset);
+		dlen = le32_to_cpu(cc->DataLength);
+		if (check_add_overflow(doff, dlen, &len) || len > rem)
+			return -EINVAL;
+
+		noff = le16_to_cpu(cc->NameOffset);
+		nlen = le16_to_cpu(cc->NameLength);
+		if (noff + nlen >= doff)
+			return -EINVAL;
+
+		name = (char *)cc + noff;
+		switch (nlen) {
+		case 4:
+			if (!strncmp(name, SMB2_CREATE_REQUEST_LEASE, 4)) {
+				*oplock = server->ops->parse_lease_buf(cc, epoch,
+								       lease_key);
+			} else if (buf &&
+				   !strncmp(name, SMB2_CREATE_QUERY_ON_DISK_ID, 4)) {
+				parse_query_id_ctxt(cc, buf);
+			}
+			break;
+		case 16:
+			if (posix && !memcmp(name, smb3_create_tag_posix, 16))
 				parse_posix_ctxt(cc, buf, posix);
+			break;
+		default:
+			cifs_dbg(FYI, "%s: unhandled context (nlen=%zu dlen=%zu)\n",
+				 __func__, nlen, dlen);
+			if (IS_ENABLED(CONFIG_CIFS_DEBUG2))
+				cifs_dump_mem("context data: ", cc, dlen);
+			break;
 		}
-		/* else {
-			cifs_dbg(FYI, "Context not matched with len %d\n",
-				le16_to_cpu(cc->NameLength));
-			cifs_dump_mem("Cctxt name: ", name, 4);
-		} */
 
-		next = le32_to_cpu(cc->Next);
-		if (!next)
+		off = le32_to_cpu(cc->Next);
+		if (!off)
 			break;
-		remaining -= next;
-		cc = (struct create_context *)((char *)cc + next);
+		if (check_sub_overflow(rem, off, &rem))
+			return -EINVAL;
+		cc = (struct create_context *)((u8 *)cc + off);
 	}
 
 	if (rsp->OplockLevel != SMB2_OPLOCK_LEVEL_LEASE)
 		*oplock = rsp->OplockLevel;
 
-	return;
+	return 0;
 }
 
 static int
@@ -3029,8 +3048,8 @@ SMB2_open(const unsigned int xid, struct
 	}
 
 
-	smb2_parse_contexts(server, rsp, &oparms->fid->epoch,
-			    oparms->fid->lease_key, oplock, buf, posix);
+	rc = smb2_parse_contexts(server, &rsp_iov, &oparms->fid->epoch,
+				 oparms->fid->lease_key, oplock, buf, posix);
 creat_exit:
 	SMB2_open_free(&rqst);
 	free_rsp_buf(resp_buftype, rsp);
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -251,11 +251,13 @@ extern int smb3_validate_negotiate(const
 
 extern enum securityEnum smb2_select_sectype(struct TCP_Server_Info *,
 					enum securityEnum);
-extern void smb2_parse_contexts(struct TCP_Server_Info *server,
-				struct smb2_create_rsp *rsp,
-				unsigned int *epoch, char *lease_key,
-				__u8 *oplock, struct smb2_file_all_info *buf,
-				struct create_posix_rsp *posix);
+int smb2_parse_contexts(struct TCP_Server_Info *server,
+			struct kvec *rsp_iov,
+			unsigned int *epoch,
+			char *lease_key, __u8 *oplock,
+			struct smb2_file_all_info *buf,
+			struct create_posix_rsp *posix);
+
 extern int smb3_encryption_required(const struct cifs_tcon *tcon);
 extern int smb2_validate_iov(unsigned int offset, unsigned int buffer_length,
 			     struct kvec *iov, unsigned int min_buf_size);



