Return-Path: <stable+bounces-43210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EC58BEFF2
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 00:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 628C8B2215D
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 22:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9FB7E107;
	Tue,  7 May 2024 22:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kkMz0t7W"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C36C374D9
	for <stable@vger.kernel.org>; Tue,  7 May 2024 22:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122530; cv=none; b=fbunZniP7UCzHd84AlGdQQhGH0YrWGQePOslBKWVnYwh6NKrV9gOm+Rr8+UaaVL0QvByvBiwyX2o7cYkrPqvkw8PuFhLghf/nrXyBU5KU8ixDwgQ+kupCTad/W+pFQk0p0CyRSfi4A0IeeIUC1+wxlJZX73GZ1pirDYj6IrSD74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122530; c=relaxed/simple;
	bh=NI5BJq218kttH3mt4xB6u0y0E238nghN+Xrmin+/YC4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OyxhGl7eAjAunwtpaFzVG92WfFO73Ge58kQBpWBIC31zltG3ab4gzuBfZ6eSwcUGi3qqFXXKwIvL11/XUhbSQ+QsH6/IgVD6NaJCZ3POg2MT2Ub82yrWyEy8SIA6O73oqnsb3/P2ppt+U/Pj+PqVzF66eKq5g8I0vRQpGM82VTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kkMz0t7W; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715122528; x=1746658528;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O3HStAj/TUucrrA9KYKcAcB2UoCYLRfsjrDcOuvbxWg=;
  b=kkMz0t7W+I6RIplaPtY8bqKjnZJjpFn/eycAsxdRR07OhMEW4bhYbpHU
   D0q83gJnpwb9SOMRue7ONOKI+NpycLwt7nZLruAh2553GRC5O0J10qkez
   DJkDuJWU+G4xllJ5V/UbKm/uNfOkHsTLn6CxRayqb0tLYtDABkkTgW80z
   c=;
X-IronPort-AV: E=Sophos;i="6.08,143,1712620800"; 
   d="scan'208";a="343288947"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 22:55:27 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:12795]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.21:2525] with esmtp (Farcaster)
 id 82f99ebc-a859-438e-a51d-2499d37ca6ab; Tue, 7 May 2024 22:55:25 +0000 (UTC)
X-Farcaster-Flow-ID: 82f99ebc-a859-438e-a51d-2499d37ca6ab
Received: from EX19D046UWB004.ant.amazon.com (10.13.139.164) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 7 May 2024 22:55:25 +0000
Received: from dev-dsk-shaoyi-2b-b6ac9e9c.us-west-2.amazon.com (10.189.91.91)
 by EX19D046UWB004.ant.amazon.com (10.13.139.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 7 May 2024 22:55:25 +0000
From: Shaoying Xu <shaoyi@amazon.com>
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: <shaoyi@amazon.com>, Paulo Alcantara <pc@manguebit.com>, Robert Morris
	<rtm@csail.mit.edu>, Steve French <stfrench@microsoft.com>, "Guruswamy
 Basavaiah" <guruswamy.basavaiah@broadcom.com>
Subject: [PATCH 5.4] smb: client: fix potential OOBs in smb2_parse_contexts()
Date: Tue, 7 May 2024 22:54:45 +0000
Message-ID: <20240507225445.25498-1-shaoyi@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D046UWB004.ant.amazon.com (10.13.139.164)

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit af1689a9b7701d9907dfc84d2a4b57c4bc907144 ]

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
[Guru: Removed changes to cached_dir.c and checking return value
of smb2_parse_contexts in smb2ops.c]
Signed-off-by: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
[v5.4: Fixed merge-conflicts in smb2_parse_contexts for
missing parameter POSIX response]
Signed-off-by: Shaoying Xu <shaoyi@amazon.com>
---
 fs/cifs/smb2ops.c   |  4 ++-
 fs/cifs/smb2pdu.c   | 81 +++++++++++++++++++++++++++++----------------
 fs/cifs/smb2proto.h | 10 +++---
 3 files changed, 62 insertions(+), 33 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index d9cdbae93608..17599294eecd 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -787,9 +787,11 @@ int open_shroot(unsigned int xid, struct cifs_tcon *tcon,
 	/* BB TBD check to see if oplock level check can be removed below */
 	if (o_rsp->OplockLevel == SMB2_OPLOCK_LEVEL_LEASE) {
 		kref_get(&tcon->crfid.refcount);
-		smb2_parse_contexts(server, o_rsp,
+		rc = smb2_parse_contexts(server, rsp_iov,
 				&oparms.fid->epoch,
 				oparms.fid->lease_key, &oplock, NULL);
+		if (rc)
+			goto oshr_exit;
 	} else
 		goto oshr_exit;
 
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 5545d5991bc2..af1d24caf906 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1929,48 +1929,73 @@ parse_query_id_ctxt(struct create_context *cc, struct smb2_file_all_info *buf)
 	buf->IndexNumber = pdisk_id->DiskFileId;
 }
 
-void
-smb2_parse_contexts(struct TCP_Server_Info *server,
-		       struct smb2_create_rsp *rsp,
-		       unsigned int *epoch, char *lease_key, __u8 *oplock,
-		       struct smb2_file_all_info *buf)
+int smb2_parse_contexts(struct TCP_Server_Info *server,
+			struct kvec *rsp_iov,
+			unsigned int *epoch,
+			char *lease_key, __u8 *oplock,
+			struct smb2_file_all_info *buf)
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
-
-		next = le32_to_cpu(cc->Next);
-		if (!next)
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
+		default:
+			cifs_dbg(FYI, "%s: unhandled context (nlen=%zu dlen=%zu)\n",
+				 __func__, nlen, dlen);
+			if (IS_ENABLED(CONFIG_CIFS_DEBUG2))
+				cifs_dump_mem("context data: ", cc, dlen);
+			break;
+		}
+
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
@@ -2680,8 +2705,8 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	}
 
 
-	smb2_parse_contexts(server, rsp, &oparms->fid->epoch,
-			    oparms->fid->lease_key, oplock, buf);
+	rc = smb2_parse_contexts(server, &rsp_iov, &oparms->fid->epoch,
+				 oparms->fid->lease_key, oplock, buf);
 creat_exit:
 	SMB2_open_free(&rqst);
 	free_rsp_buf(resp_buftype, rsp);
diff --git a/fs/cifs/smb2proto.h b/fs/cifs/smb2proto.h
index 7fb4fdd814f5..0c3480be7b8f 100644
--- a/fs/cifs/smb2proto.h
+++ b/fs/cifs/smb2proto.h
@@ -238,10 +238,12 @@ extern int smb3_validate_negotiate(const unsigned int, struct cifs_tcon *);
 
 extern enum securityEnum smb2_select_sectype(struct TCP_Server_Info *,
 					enum securityEnum);
-extern void smb2_parse_contexts(struct TCP_Server_Info *server,
-				struct smb2_create_rsp *rsp,
-				unsigned int *epoch, char *lease_key,
-				__u8 *oplock, struct smb2_file_all_info *buf);
+int smb2_parse_contexts(struct TCP_Server_Info *server,
+			struct kvec *rsp_iov,
+			unsigned int *epoch,
+			char *lease_key, __u8 *oplock,
+			struct smb2_file_all_info *buf);
+
 extern int smb3_encryption_required(const struct cifs_tcon *tcon);
 extern int smb2_validate_iov(unsigned int offset, unsigned int buffer_length,
 			     struct kvec *iov, unsigned int min_buf_size);
-- 
2.40.1


