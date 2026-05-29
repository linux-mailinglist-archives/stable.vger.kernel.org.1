Return-Path: <stable+bounces-256547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GtgLtRNGWrzuQgAu9opvQ
	(envelope-from <stable+bounces-256547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:27:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9945FF23B
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E940B304F235
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF4A3AFCF5;
	Fri, 29 May 2026 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="o54Rz/UP"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF6033B6C6;
	Fri, 29 May 2026 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043143; cv=none; b=aafCnLrIzAJX2L2azcFSeSu++EAWjTPvJYiwDG/qHySUgVYajYnZ9KOtmK8p8oUuTsNvMxO9dMXAog42p3xGKv0978MM/pL4VGMHnt9YOW4/AfVDVDe6m9ejR/eiHDKOBsngxIJtuJ5H0yG46u/8UZvsByB/aM8V7U5IGJxatX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043143; c=relaxed/simple;
	bh=l3xgtWsnc/8P37Wt4I9y5h9Msr8UEl33UMan+h7su2k=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=aDVWWAC8uZn9pJc3oTh0Wi38UxJyLySV0iqkFvgMHLIhwF4VAw6wR/8p5ShjWl9i73LfPX6OairxHxSRWP+l7I/x3dCd010BQN58bpW9ZMwxgnTXkkIMX17ACBp2w28+RAJfwZoQ+cSxMkb0EPukOBwkqr3LA33RM0tSoXYeFw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=o54Rz/UP; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1780043128;
	bh=nVosto6nhcaBEAjsYH0X0Ne6xvjpeZ+XIIDQ0tzHwxI=;
	h=From:To:Cc:Subject:Date;
	b=o54Rz/UPPlYfLkiiccSGFdauKouzvqB45PysloAq3pI7NlNDyr9Lw6K85xHPF/Y5P
	 Zoq0N73BkhC8eT4AMzb+CNObxKCLkmNX9XUW/33/AfcVZ/SaSQwOPt7JL1akDQ5L/K
	 v/yNZw0sN4ByqUfXFBdU8LxDBzu6hNLNdgHR2dbs=
Received: from China-team ([47.95.114.252])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 56F268DA; Fri, 29 May 2026 16:21:47 +0800
X-QQ-mid: xmsmtpt1780042907tu7llr6rg
Message-ID: <tencent_2D8DE0C7BF6499B53C4E180C46C3106D7306@qq.com>
X-QQ-XMAILINFO: M+6QKz8nsrJQglZM38BhwlChqRkhX9ti1JYkT1pjIcg/J40i5zZ6L9acRMRihu
	 akrSmE9kzr3qOuXsrDxJJQ5O81SVuULzsH1CKaa9b7BiPFWJIZ0hDM8lA5qU+J4p9kS3ySb6hMoQ
	 CRWEbvNKRedIHX7Foz6wMiHzs20IAwRAO4q3gH/qvncTmpjubDGyEkOyvqrnCCodgTUkk4zuaUJA
	 lbDvWOqJ0a6KLBoIbQaAGjrFpnXbFyUCv9pYlnJvU30o/q4k5Tii7tMbIYUMMgXMtiMFkwwlKLrb
	 Fr+pfVP9DSBc3d02vpjkPPFpTHJsBKWcClL65rAqoM1z4cWjvQOaOIkeTvOY6xnbS+bM+GS5lBgh
	 SUm1XSKY10iwIeP+YGBP/MfA9HDbVj152prLimOVVtfkKuI3d7J1d8vDg0bzHAKO5BB7P6gCr7lo
	 c6eT7jzxnF3BLKRTO6+PS88Zin+5IIv0299HLHexZHvPEY5WbACPxXDcDJ+91pekL03bPrGo5qel
	 xafFwkmsxWB9yed22V+NF+Enst/UVe49AzP/sVWOHWbtwFLLwKngzTyuQO2yiV16zGzaKJ55Fbqt
	 lVstvU73w4+79WKiFv2UXC9kwpQqnArvvazeHpx2MreW6QgDgdM7ATgMnDincGDpyWDLMWIV51ST
	 yHDRKOvZXYTu1tJAmtSQrflyDF9Qf53V/UETgDy2QUixZMfe1G38M3AenW86kZ8rqUTMVfaR5K2E
	 53h3ZE8aZSAotx2gXzXmKRX/z/C2gdKYDHV31zBJl/kS3d50Jzxtqq/EQZCklqnuEw7OHOAzWUEn
	 3FM1FRtUOhdeTk31wzdQAVYIobzvJNs2nMDvmzkonj58DjgTWTF8DmdS/EC5prS1VvBOH/DVHDKL
	 l9PwtzH66KL4ZWrMd19/EESsgfWm36DMqtqN/Z1LToyhs2+iL+2nXd5QruojGmVRqeoVRuv4v8yz
	 H16c125j/1IP4dZIlLhjZMYPE5oX9rPGpBGw+ij2i7EZFzH0YPXgOKOiBlkQSvdX98xf/RS7Lw68
	 cX14jErsJ6smOzk2Vgs/nSw/D1OYkhwJLz0Y5sm/uQZ4oEi/ukQSZEczXlNwY=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Asim Viladi Oglu Manizada <manizada@pm.me>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y] ksmbd: fix OOB write in QUERY_INFO for compound requests
Date: Fri, 29 May 2026 16:21:25 +0800
X-OQ-MSGID: <20260529082125.62990-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-256547-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,pm.me,kernel.org,microsoft.com,foxmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[foxmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,pm.me:email,qq.com:mid]
X-Rspamd-Queue-Id: BE9945FF23B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Asim Viladi Oglu Manizada <manizada@pm.me>

[ Upstream commit fda9522ed6afaec45cabc198d8492270c394c7bc ]

When a compound request such as READ + QUERY_INFO(Security) is received,
and the first command (READ) consumes most of the response buffer,
ksmbd could write beyond the allocated buffer while building a security
descriptor.

The root cause was that smb2_get_info_sec() checked buffer space using
ppntsd_size from xattr, while build_sec_desc() often synthesized a
significantly larger descriptor from POSIX ACLs.

This patch introduces smb_acl_sec_desc_scratch_len() to accurately
compute the final descriptor size beforehand, performs proper buffer
checking with smb2_calc_max_out_buf_len(), and uses exact-sized
allocation + iov pinning.

Cc: stable@vger.kernel.org
Fixes: e2b76ab8b5c9 ("ksmbd: add support for read compound")
Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ In v6.6, replace KSMBD_DEFAULT_GFP with GFP_KERNEL per
commit 0066f623bce8 ("ksmbd: use __GFP_RETRY_MAYFAIL"). ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
Testing:
  - Backport compiles cleanly on 6.6.141 (x86_64)
  - Regression tests pass: file I/O, directory operations, security
    descriptor queries (OWNER/GROUP/DACL), filesystem info queries,
    large reads, and compound requests all work correctly
  - Verified compound READ + QUERY_INFO(Security) is processed without
    memory corruption on a file with 100 POSIX ACL entries (~3KB SD)

---
 fs/smb/server/smb2pdu.c | 121 +++++++++++++++++++++++++++++-----------
 fs/smb/server/smbacl.c  |  43 ++++++++++++++
 fs/smb/server/smbacl.h  |   2 +
 3 files changed, 134 insertions(+), 32 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index d68fe617369e..ce60c26b2297 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3384,20 +3384,24 @@ int smb2_open(struct ksmbd_work *work)
 							   KSMBD_SHARE_FLAG_ACL_XATTR)) {
 					struct smb_fattr fattr;
 					struct smb_ntsd *pntsd;
-					int pntsd_size, ace_num = 0;
+					int pntsd_size;
+					size_t scratch_len;
 
 					ksmbd_acls_fattr(&fattr, idmap, inode);
-					if (fattr.cf_acls)
-						ace_num = fattr.cf_acls->a_count;
-					if (fattr.cf_dacls)
-						ace_num += fattr.cf_dacls->a_count;
-
-					pntsd = kmalloc(sizeof(struct smb_ntsd) +
-							sizeof(struct smb_sid) * 3 +
-							sizeof(struct smb_acl) +
-							sizeof(struct smb_ace) * ace_num * 2,
-							GFP_KERNEL);
+					scratch_len = smb_acl_sec_desc_scratch_len(&fattr,
+							NULL, 0,
+							OWNER_SECINFO | GROUP_SECINFO |
+							DACL_SECINFO);
+					if (!scratch_len || scratch_len == SIZE_MAX) {
+						rc = -EFBIG;
+						posix_acl_release(fattr.cf_acls);
+						posix_acl_release(fattr.cf_dacls);
+						goto err_out;
+					}
+
+					pntsd = kvzalloc(scratch_len, GFP_KERNEL);
 					if (!pntsd) {
+						rc = -ENOMEM;
 						posix_acl_release(fattr.cf_acls);
 						posix_acl_release(fattr.cf_dacls);
 						goto err_out;
@@ -3412,7 +3416,7 @@ int smb2_open(struct ksmbd_work *work)
 					posix_acl_release(fattr.cf_acls);
 					posix_acl_release(fattr.cf_dacls);
 					if (rc) {
-						kfree(pntsd);
+						kvfree(pntsd);
 						goto err_out;
 					}
 
@@ -3422,7 +3426,7 @@ int smb2_open(struct ksmbd_work *work)
 								    pntsd,
 								    pntsd_size,
 								    false);
-					kfree(pntsd);
+					kvfree(pntsd);
 					if (rc)
 						pr_err("failed to store ntacl in xattr : %d\n",
 						       rc);
@@ -5344,8 +5348,9 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 	if (test_share_config_flag(work->tcon->share_conf,
 				   KSMBD_SHARE_FLAG_PIPE)) {
 		/* smb2 info file called for pipe */
-		return smb2_get_info_file_pipe(work->sess, req, rsp,
+		rc = smb2_get_info_file_pipe(work->sess, req, rsp,
 					       work->response_buf);
+		goto iov_pin_out;
 	}
 
 	if (work->next_smb2_rcv_hdr_off) {
@@ -5445,6 +5450,12 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 		rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
 				      rsp, work->response_buf);
 	ksmbd_fd_put(work, fp);
+
+iov_pin_out:
+	if (!rc)
+		rc = ksmbd_iov_pin_rsp(work, (void *)rsp,
+				offsetof(struct smb2_query_info_rsp, Buffer) +
+				le32_to_cpu(rsp->OutputBufferLength));
 	return rc;
 }
 
@@ -5664,6 +5675,11 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 	rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
 			      rsp, work->response_buf);
 	path_put(&path);
+
+	if (!rc)
+		rc = ksmbd_iov_pin_rsp(work, (void *)rsp,
+				offsetof(struct smb2_query_info_rsp, Buffer) +
+				le32_to_cpu(rsp->OutputBufferLength));
 	return rc;
 }
 
@@ -5673,13 +5689,14 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 {
 	struct ksmbd_file *fp;
 	struct mnt_idmap *idmap;
-	struct smb_ntsd *pntsd = (struct smb_ntsd *)rsp->Buffer, *ppntsd = NULL;
+	struct smb_ntsd *pntsd = NULL, *ppntsd = NULL;
 	struct smb_fattr fattr = {{0}};
 	struct inode *inode;
 	__u32 secdesclen = 0;
 	unsigned int id = KSMBD_NO_FID, pid = KSMBD_NO_FID;
 	int addition_info = le32_to_cpu(req->AdditionalInformation);
-	int rc = 0, ppntsd_size = 0;
+	int rc = 0, ppntsd_size = 0, max_len;
+	size_t scratch_len = 0;
 
 	if (addition_info & ~(OWNER_SECINFO | GROUP_SECINFO | DACL_SECINFO |
 			      PROTECTED_DACL_SECINFO |
@@ -5687,6 +5704,11 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 		ksmbd_debug(SMB, "Unsupported addition info: 0x%x)\n",
 		       addition_info);
 
+		pntsd = kzalloc(ALIGN(sizeof(struct smb_ntsd), 8),
+				GFP_KERNEL);
+		if (!pntsd)
+			return -ENOMEM;
+
 		pntsd->revision = cpu_to_le16(1);
 		pntsd->type = cpu_to_le16(SELF_RELATIVE | DACL_PROTECTED);
 		pntsd->osidoffset = 0;
@@ -5695,9 +5717,7 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 		pntsd->dacloffset = 0;
 
 		secdesclen = sizeof(struct smb_ntsd);
-		rsp->OutputBufferLength = cpu_to_le32(secdesclen);
-
-		return 0;
+		goto iov_pin;
 	}
 
 	if (work->next_smb2_rcv_hdr_off) {
@@ -5729,18 +5749,58 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 						     &ppntsd);
 
 	/* Check if sd buffer size exceeds response buffer size */
-	if (smb2_resp_buf_len(work, 8) > ppntsd_size)
-		rc = build_sec_desc(idmap, pntsd, ppntsd, ppntsd_size,
-				    addition_info, &secdesclen, &fattr);
+	max_len = smb2_calc_max_out_buf_len(work,
+			offsetof(struct smb2_query_info_rsp, Buffer),
+			le32_to_cpu(req->OutputBufferLength));
+	if (max_len < 0) {
+		rc = -EINVAL;
+		goto release_acl;
+	}
+
+	scratch_len = smb_acl_sec_desc_scratch_len(&fattr, ppntsd,
+			ppntsd_size, addition_info);
+	if (!scratch_len || scratch_len == SIZE_MAX) {
+		rc = -EFBIG;
+		goto release_acl;
+	}
+
+	pntsd = kvzalloc(scratch_len, GFP_KERNEL);
+	if (!pntsd) {
+		rc = -ENOMEM;
+		goto release_acl;
+	}
+
+	rc = build_sec_desc(idmap, pntsd, ppntsd, ppntsd_size,
+			addition_info, &secdesclen, &fattr);
+
+release_acl:
 	posix_acl_release(fattr.cf_acls);
 	posix_acl_release(fattr.cf_dacls);
 	kfree(ppntsd);
 	ksmbd_fd_put(work, fp);
+
+	if (!rc && ALIGN(secdesclen, 8) > scratch_len)
+		rc = -EFBIG;
 	if (rc)
-		return rc;
+		goto err_out;
 
+iov_pin:
 	rsp->OutputBufferLength = cpu_to_le32(secdesclen);
-	return 0;
+	rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
+			      rsp, work->response_buf);
+	if (rc)
+		goto err_out;
+
+	rc = ksmbd_iov_pin_rsp_read(work, (void *)rsp,
+			offsetof(struct smb2_query_info_rsp, Buffer),
+			pntsd, secdesclen);
+err_out:
+	if (rc) {
+		rsp->OutputBufferLength = 0;
+		kvfree(pntsd);
+	}
+
+	return rc;
 }
 
 /**
@@ -5764,6 +5824,9 @@ int smb2_query_info(struct ksmbd_work *work)
 		goto err_out;
 	}
 
+	rsp->StructureSize = cpu_to_le16(9);
+	rsp->OutputBufferOffset = cpu_to_le16(72);
+
 	switch (req->InfoType) {
 	case SMB2_O_INFO_FILE:
 		ksmbd_debug(SMB, "GOT SMB2_O_INFO_FILE\n");
@@ -5784,14 +5847,6 @@ int smb2_query_info(struct ksmbd_work *work)
 	}
 	ksmbd_revert_fsids(work);
 
-	if (!rc) {
-		rsp->StructureSize = cpu_to_le16(9);
-		rsp->OutputBufferOffset = cpu_to_le16(72);
-		rc = ksmbd_iov_pin_rsp(work, (void *)rsp,
-				       offsetof(struct smb2_query_info_rsp, Buffer) +
-					le32_to_cpu(rsp->OutputBufferLength));
-	}
-
 err_out:
 	if (rc < 0) {
 		if (rc == -EACCES)
@@ -5802,6 +5857,8 @@ int smb2_query_info(struct ksmbd_work *work)
 			rsp->hdr.Status = STATUS_UNEXPECTED_IO_ERROR;
 		else if (rc == -ENOMEM)
 			rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
+		else if (rc == -EINVAL && rsp->hdr.Status == 0)
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
 		else if (rc == -EOPNOTSUPP || rsp->hdr.Status == 0)
 			rsp->hdr.Status = STATUS_INVALID_INFO_CLASS;
 		smb2_set_err_rsp(work);
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index ff59217b4bea..a295007609d2 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -924,6 +924,49 @@ int parse_sec_desc(struct mnt_idmap *idmap, struct smb_ntsd *pntsd,
 	return 0;
 }
 
+size_t smb_acl_sec_desc_scratch_len(struct smb_fattr *fattr,
+		struct smb_ntsd *ppntsd, int ppntsd_size, int addition_info)
+{
+	size_t len = sizeof(struct smb_ntsd);
+	size_t tmp;
+
+	if (addition_info & OWNER_SECINFO)
+		len += sizeof(struct smb_sid);
+	if (addition_info & GROUP_SECINFO)
+		len += sizeof(struct smb_sid);
+	if (!(addition_info & DACL_SECINFO))
+		return len;
+
+	len += sizeof(struct smb_acl);
+	if (ppntsd && ppntsd_size > 0) {
+		unsigned int dacl_offset = le32_to_cpu(ppntsd->dacloffset);
+
+		if (dacl_offset < ppntsd_size &&
+		    check_add_overflow(len, ppntsd_size - dacl_offset, &len))
+			return 0;
+	}
+
+	if (fattr->cf_acls) {
+		if (check_mul_overflow((size_t)fattr->cf_acls->a_count,
+					2 * sizeof(struct smb_ace), &tmp) ||
+		    check_add_overflow(len, tmp, &len))
+			return 0;
+	} else {
+		/* default/minimum DACL */
+		if (check_add_overflow(len, 5 * sizeof(struct smb_ace), &len))
+			return 0;
+	}
+
+	if (fattr->cf_dacls) {
+		if (check_mul_overflow((size_t)fattr->cf_dacls->a_count,
+					sizeof(struct smb_ace), &tmp) ||
+		    check_add_overflow(len, tmp, &len))
+			return 0;
+	}
+
+	return len;
+}
+
 /* Convert permission bits from mode to equivalent CIFS ACL */
 int build_sec_desc(struct mnt_idmap *idmap,
 		   struct smb_ntsd *pntsd, struct smb_ntsd *ppntsd,
diff --git a/fs/smb/server/smbacl.h b/fs/smb/server/smbacl.h
index 355adaee39b8..ab21ba2cd4df 100644
--- a/fs/smb/server/smbacl.h
+++ b/fs/smb/server/smbacl.h
@@ -101,6 +101,8 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 		 bool type_check, bool get_write);
 void id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid);
 void ksmbd_init_domain(u32 *sub_auth);
+size_t smb_acl_sec_desc_scratch_len(struct smb_fattr *fattr,
+		struct smb_ntsd *ppntsd, int ppntsd_size, int addition_info);
 
 static inline uid_t posix_acl_uid_translate(struct mnt_idmap *idmap,
 					    struct posix_acl_entry *pace)
-- 
2.43.0


