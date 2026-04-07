Return-Path: <stable+bounces-233629-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGYWM9gc1Wnr0wcAu9opvQ
	(envelope-from <stable+bounces-233629-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:03:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5978E3B096C
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71436306EB55
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 14:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8814133C53D;
	Tue,  7 Apr 2026 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZgjvxKxE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4BC4AEE2
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573789; cv=none; b=EOOALsdaS9B0tQUauLW5YJU2371PWHAOMX7Jq3FGU6pP5M89jV/iLQkI/6ZPXTd+sYMdwa6if5YY7Z9T1WeVxolRJ6TawU2P79Fd6LzpSlXkJtevd3wBTXwf6rI4h+wtfMcJAfX0m3wQzTFMYxKko+wHcZA8jC1ozC7jYlCO3lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573789; c=relaxed/simple;
	bh=QQQI/lqRjFK6Zg3h1d8ubtnDrnt+utGuJQ8+z/U3UNQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DmHs2wdMsv/2hn6QpZ29aThIgwBPLtnziDN7pnldMO/XUYwhF9+PEppYzboa4tv/ybeTziJauyRNPT9cMGEbQRXPeiVJMjfg4kFvGjx8C8XwSo9wNZF5OWc3lmXp5t/l+0vqGYR/PEwO9QaArcz9f93NxQmD0goyzyWUpxnxzCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZgjvxKxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AD7C116C6;
	Tue,  7 Apr 2026 14:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775573788;
	bh=QQQI/lqRjFK6Zg3h1d8ubtnDrnt+utGuJQ8+z/U3UNQ=;
	h=Subject:To:Cc:From:Date:From;
	b=ZgjvxKxEqvMd4FDumqEYA8H2v/U/kWT5tu3gjMpA30DnKtK5N2dnuFL7lCVdgW/es
	 uO2tqvGBa7sXr7cwBBVFTxY2GUbQAuyrv3z3Rs6tgYIO/7jpafWzWxl4r7gvJ6YXrR
	 E8HGzxbhOCpEQPGxmLVRHP6GjXyb9+Q1qqfkbgYs=
Subject: FAILED: patch "[PATCH] ksmbd: fix OOB write in QUERY_INFO for compound requests" failed to apply to 6.6-stable tree
To: manizada@pm.me,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 07 Apr 2026 16:56:26 +0200
Message-ID: <2026040726-bountiful-boil-8a78@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233629-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: 5978E3B096C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x fda9522ed6afaec45cabc198d8492270c394c7bc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040726-bountiful-boil-8a78@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fda9522ed6afaec45cabc198d8492270c394c7bc Mon Sep 17 00:00:00 2001
From: Asim Viladi Oglu Manizada <manizada@pm.me>
Date: Wed, 25 Mar 2026 09:14:22 +0900
Subject: [PATCH] ksmbd: fix OOB write in QUERY_INFO for compound requests

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

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 6fb7a795ff5d..8e4cfdc0ba02 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3402,20 +3402,24 @@ int smb2_open(struct ksmbd_work *work)
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
 
-					pntsd = kmalloc(sizeof(struct smb_ntsd) +
-							sizeof(struct smb_sid) * 3 +
-							sizeof(struct smb_acl) +
-							sizeof(struct smb_ace) * ace_num * 2,
-							KSMBD_DEFAULT_GFP);
+					pntsd = kvzalloc(scratch_len, KSMBD_DEFAULT_GFP);
 					if (!pntsd) {
+						rc = -ENOMEM;
 						posix_acl_release(fattr.cf_acls);
 						posix_acl_release(fattr.cf_dacls);
 						goto err_out;
@@ -3430,7 +3434,7 @@ int smb2_open(struct ksmbd_work *work)
 					posix_acl_release(fattr.cf_acls);
 					posix_acl_release(fattr.cf_dacls);
 					if (rc) {
-						kfree(pntsd);
+						kvfree(pntsd);
 						goto err_out;
 					}
 
@@ -3440,7 +3444,7 @@ int smb2_open(struct ksmbd_work *work)
 								    pntsd,
 								    pntsd_size,
 								    false);
-					kfree(pntsd);
+					kvfree(pntsd);
 					if (rc)
 						pr_err("failed to store ntacl in xattr : %d\n",
 						       rc);
@@ -5372,8 +5376,9 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 	if (test_share_config_flag(work->tcon->share_conf,
 				   KSMBD_SHARE_FLAG_PIPE)) {
 		/* smb2 info file called for pipe */
-		return smb2_get_info_file_pipe(work->sess, req, rsp,
+		rc = smb2_get_info_file_pipe(work->sess, req, rsp,
 					       work->response_buf);
+		goto iov_pin_out;
 	}
 
 	if (work->next_smb2_rcv_hdr_off) {
@@ -5473,6 +5478,12 @@ static int smb2_get_info_file(struct ksmbd_work *work,
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
 
@@ -5699,6 +5710,11 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
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
 
@@ -5708,13 +5724,14 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
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
@@ -5722,6 +5739,11 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 		ksmbd_debug(SMB, "Unsupported addition info: 0x%x)\n",
 		       addition_info);
 
+		pntsd = kzalloc(ALIGN(sizeof(struct smb_ntsd), 8),
+				KSMBD_DEFAULT_GFP);
+		if (!pntsd)
+			return -ENOMEM;
+
 		pntsd->revision = cpu_to_le16(1);
 		pntsd->type = cpu_to_le16(SELF_RELATIVE | DACL_PROTECTED);
 		pntsd->osidoffset = 0;
@@ -5730,9 +5752,7 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 		pntsd->dacloffset = 0;
 
 		secdesclen = sizeof(struct smb_ntsd);
-		rsp->OutputBufferLength = cpu_to_le32(secdesclen);
-
-		return 0;
+		goto iov_pin;
 	}
 
 	if (work->next_smb2_rcv_hdr_off) {
@@ -5764,18 +5784,58 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
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
+	pntsd = kvzalloc(scratch_len, KSMBD_DEFAULT_GFP);
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
-	if (rc)
-		return rc;
 
+	if (!rc && ALIGN(secdesclen, 8) > scratch_len)
+		rc = -EFBIG;
+	if (rc)
+		goto err_out;
+
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
@@ -5799,6 +5859,9 @@ int smb2_query_info(struct ksmbd_work *work)
 		goto err_out;
 	}
 
+	rsp->StructureSize = cpu_to_le16(9);
+	rsp->OutputBufferOffset = cpu_to_le16(72);
+
 	switch (req->InfoType) {
 	case SMB2_O_INFO_FILE:
 		ksmbd_debug(SMB, "GOT SMB2_O_INFO_FILE\n");
@@ -5819,14 +5882,6 @@ int smb2_query_info(struct ksmbd_work *work)
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
@@ -5837,6 +5892,8 @@ int smb2_query_info(struct ksmbd_work *work)
 			rsp->hdr.Status = STATUS_UNEXPECTED_IO_ERROR;
 		else if (rc == -ENOMEM)
 			rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
+		else if (rc == -EINVAL && rsp->hdr.Status == 0)
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
 		else if (rc == -EOPNOTSUPP || rsp->hdr.Status == 0)
 			rsp->hdr.Status = STATUS_INVALID_INFO_CLASS;
 		smb2_set_err_rsp(work);
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 49c2abb29bf5..c30d01877c41 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -915,6 +915,49 @@ int parse_sec_desc(struct mnt_idmap *idmap, struct smb_ntsd *pntsd,
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


