Return-Path: <stable+bounces-19447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C3D850B93
	for <lists+stable@lfdr.de>; Sun, 11 Feb 2024 21:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD7D2809E2
	for <lists+stable@lfdr.de>; Sun, 11 Feb 2024 20:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C911E5E3A5;
	Sun, 11 Feb 2024 20:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Rz/ZroIW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED3B5381E
	for <stable@vger.kernel.org>; Sun, 11 Feb 2024 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707684856; cv=none; b=k7zzBEH0kN4tPTfjQ4gcbRdYBf1hw5AULVlW9GU8BU9/hRLsolQpucBy6Ib0xjzsWRuHIIlCsflIUI+LtzepFtksIattAb2nWiFn6Zut3v7yd6UtqyxlqxTpiqmmQK9irsJ1e2kpWV5hmi6+Fy959I05wBy3lqeXVJgv7rKnqAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707684856; c=relaxed/simple;
	bh=hHbduaqkV3mcbYMpoL6PYWcddihCk71uUwgDtu+fzvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qjT0hj/XdE5iDhwPoQLm5lq+o7+BDD67X1vikaCSZpg14psMm+DZws03KcnRkUyc/9PUluUzBsPsorDKUpjNEIg+p0itnWgbis4CB0DHDSfEoHnByd24k+fDx4K8O7fAdLShJ06wsCSA0jOuoaT8joH8ZifQLzlVkbTNiEcwu/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Rz/ZroIW; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-296db7e258dso1707710a91.0
        for <stable@vger.kernel.org>; Sun, 11 Feb 2024 12:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707684853; x=1708289653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeXRdFJH8rsWandURsi1IDZPVHlPbfmmKxcxSF2+0m4=;
        b=Rz/ZroIWu/0l0UKn+wSB2SsK8cQXzeLAqurB/Papk7glcynGu9ILFGiT1gy9Wj9pIL
         fN//QDuiGDNmF5bkafSosbQSrzcX17pI0hNEuVMkuz3j1JDqFV5HTWFfDcFkYLNxlN+4
         3K+G2xUi8gEp5kcLTDvzfWV+OogCYyxHVo/ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707684853; x=1708289653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WeXRdFJH8rsWandURsi1IDZPVHlPbfmmKxcxSF2+0m4=;
        b=wf4+pUimQkmIrm2E1ClsGvIVIRfVOH+RnchEpEz9DcwcCJ/O/Q9Q8b7Bqa/1ROuaP8
         IxSFfA9Yqx+9IrpLZvXTsCgUBY7WocCiiJuLGI89XkyOhTRMjjhMb7K+If2GqTSz1RXl
         Pp9kOimSz84Hb09lGSh+6EIqlXksf4XlPYY7SZtPB/8z9r5MGqIPioOS1FWbkD3Upwu4
         96twnvSJLjnUM6FMzwvQPymTFoENx/bq0o7CRY1D8ctamImR9ykSiCUFqOosHgOPjVFS
         volvlpwqCC8Rt6LiI9R85CJWp1bpY0LSr4bkO0z20unwlRVGLzwXMlyLD/jDqczQEZxf
         cjig==
X-Gm-Message-State: AOJu0YzJ0LkZV0QExmtfKA9XMTx5MfyHjeXr4rDL9Spsz4Azz9nh703v
	PMUhdhIpK3GQAAsj3xCPP89BMDIA8Ebcx2UMSOVMTipJn92OTu7CZvMiXgRrfDf6p9RcALlBe8M
	2vNYzXGomy0pVNEqtq6o0XS74Tsp3ea1cnhGxr/sudHtSWVKzKTgXjgbdt/hIPNXuCkMt0uvEvT
	UNSNF/bTX/fN8lWfUWYjmCruUVay4fsQFr9IsVfEfBTeILI1/l5mJ8fmHseQ==
X-Google-Smtp-Source: AGHT+IGIEAMXCBn23zu2tz3mvd40MOEDCWC6OW+AqS67gr7Bg2gRi04OKD8w8k2XATMRLriSMFd3Pw==
X-Received: by 2002:a17:90a:f009:b0:296:930:8792 with SMTP id bt9-20020a17090af00900b0029609308792mr7343018pjb.9.1707684853131;
        Sun, 11 Feb 2024 12:54:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXSZ0S/jU8WkYac375WGevILm+WDRrpBD9VK1pqXsLJs6/uRfWf9jc84meW+23s8bQoJReoQfdPZs15nhRLb+MaoSgrfeNUVraBLChG7s98XkZw90Tt2yGP0fzBxzt6YMmiexE6EuBIeGoqUgoeyJ4xNMXI3heGh54adO/5zz1xDaCJ3pxu0okhpAh/yYFK5lMm/FNDbEzg6L6/CDWgxGTknbRZcT1+44DbxggQyhNGVtL6k1+/gU/doIzvj7kQwKIqnpQ=
Received: from bguruswamy-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id cv16-20020a17090afd1000b0028ce81d9f32sm5423735pjb.16.2024.02.11.12.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 12:54:12 -0800 (PST)
From: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ajay.kaher@broadcom.com,
	tapas.kundu@broadcom.com,
	Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>,
	Robert Morris <rtm@csail.mit.edu>,
	Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH v2 5.15.y 2/3] smb: client: fix potential OOBs in smb2_parse_contexts()
Date: Mon, 12 Feb 2024 02:23:12 +0530
Message-Id: <20240211205313.3097033-3-guruswamy.basavaiah@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240211205313.3097033-1-guruswamy.basavaiah@broadcom.com>
References: <20240211205313.3097033-1-guruswamy.basavaiah@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 fs/cifs/smb2ops.c   |  4 +-
 fs/cifs/smb2pdu.c   | 93 +++++++++++++++++++++++++++------------------
 fs/cifs/smb2proto.h | 12 +++---
 3 files changed, 66 insertions(+), 43 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 867b32b1393f..0930efc7ba37 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -908,10 +908,12 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		 */
 		kref_get(&tcon->crfid.refcount);
 		tcon->crfid.has_lease = true;
-		smb2_parse_contexts(server, o_rsp,
+		rc = smb2_parse_contexts(server, rsp_iov,
 				&oparms.fid->epoch,
 				    oparms.fid->lease_key, &oplock,
 				    NULL, NULL);
+		if (rc)
+			goto oshr_exit;
 	} else
 		goto oshr_exit;
 
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 6714e9db0ee8..541f7d6aaf3d 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2056,17 +2056,18 @@ parse_posix_ctxt(struct create_context *cc, struct smb2_file_all_info *info,
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
@@ -2075,45 +2076,63 @@ smb2_parse_contexts(struct TCP_Server_Info *server,
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
-
-		next = le32_to_cpu(cc->Next);
-		if (!next)
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
@@ -2983,8 +3002,8 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	}
 
 
-	smb2_parse_contexts(server, rsp, &oparms->fid->epoch,
-			    oparms->fid->lease_key, oplock, buf, posix);
+	rc = smb2_parse_contexts(server, &rsp_iov, &oparms->fid->epoch,
+				 oparms->fid->lease_key, oplock, buf, posix);
 creat_exit:
 	SMB2_open_free(&rqst);
 	free_rsp_buf(resp_buftype, rsp);
diff --git a/fs/cifs/smb2proto.h b/fs/cifs/smb2proto.h
index 547945443fa7..6c5a4d44b248 100644
--- a/fs/cifs/smb2proto.h
+++ b/fs/cifs/smb2proto.h
@@ -259,11 +259,13 @@ extern int smb3_validate_negotiate(const unsigned int, struct cifs_tcon *);
 
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
-- 
2.25.1


