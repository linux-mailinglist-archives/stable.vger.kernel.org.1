Return-Path: <stable+bounces-245986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCccEpNpA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-245986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:55:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CC25264AA
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F18C631399C7
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C7C3955D1;
	Tue, 12 May 2026 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lSum13w+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575343EDE4F;
	Tue, 12 May 2026 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608064; cv=none; b=sFMh9uLutQCL/mGf2QGp1hN4e8l0+7GrNPpIBepJPJOMDzYBJwscTg+6ViKO66T19YuS4Wt5WULdO6ndtCXbeJAxPcBrmkezeogMZpCavaG0VA1r3+D9ECFjDGMsYUjESCQdl/kOVzhIbyG+E5eHOs3tAhjQG2iwmtPBlyx/v4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608064; c=relaxed/simple;
	bh=xD5QdFJtyq3y7A+8FCgoe+nGw+DXTXCyz3VkttlDZKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oboGwbzeBz8CF8UWUiYDkDLE6ReBkulLLs9QbKAW4s/A295O6FfBjB64nKnsXArSJIBJYzB5/s3Ag96kjvlvkQ9IJPvmq7WcEbWdK1qzwqilOrZcoBrTuqGK/hUNJ6U80q9gQaw58w16Xg1kVdX3kYQ9Kn8Qq0KM1cdJyo7PtGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lSum13w+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E344FC2BCB0;
	Tue, 12 May 2026 17:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608064;
	bh=xD5QdFJtyq3y7A+8FCgoe+nGw+DXTXCyz3VkttlDZKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lSum13w+tCUWYmw1/K1ciMylchaH1t2PCQ6n3spcMaFmPyIhziM0iesctlmX50QHb
	 8QH80rmiWQRyn+doVyOUFn0Wywscf2VScf4C+XASt4QOQcnzrkRwztK3H+B+KGGzjJ
	 5j2+cJqjQOgruHHfg8zF1XQeCwf942kmIGU2HxME=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 140/206] smb: client: validate dacloffset before building DACL pointers
Date: Tue, 12 May 2026 19:39:52 +0200
Message-ID: <20260512173935.825957132@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 01CC25264AA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-245986-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,microsoft.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

commit f98b48151cc502ada59d9778f0112d21f2586ca3 upstream.

parse_sec_desc(), build_sec_desc(), and the chown path in
id_mode_to_cifs_acl() all add the server-supplied dacloffset to pntsd
before proving a DACL header fits inside the returned security
descriptor.

On 32-bit builds a malicious server can return dacloffset near
U32_MAX, wrap the derived DACL pointer below end_of_acl, and then slip
past the later pointer-based bounds checks. build_sec_desc() and
id_mode_to_cifs_acl() can then dereference DACL fields from the wrapped
pointer in the chmod/chown rewrite paths.

Validate dacloffset numerically before building any DACL pointer and
reuse the same helper at the three DACL entry points.

Fixes: bc3e9dd9d104 ("cifs: Change SIDs in ACEs while transferring file ownership.")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifsacl.c |   35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1265,6 +1265,17 @@ static int parse_sid(struct smb_sid *psi
 	return 0;
 }
 
+static bool dacl_offset_valid(unsigned int acl_len, __u32 dacloffset)
+{
+	if (acl_len < sizeof(struct smb_acl))
+		return false;
+
+	if (dacloffset < sizeof(struct smb_ntsd))
+		return false;
+
+	return dacloffset <= acl_len - sizeof(struct smb_acl);
+}
+
 
 /* Convert CIFS ACL to POSIX form */
 static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
@@ -1285,7 +1296,6 @@ static int parse_sec_desc(struct cifs_sb
 	group_sid_ptr = (struct smb_sid *)((char *)pntsd +
 				le32_to_cpu(pntsd->gsidoffset));
 	dacloffset = le32_to_cpu(pntsd->dacloffset);
-	dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 	cifs_dbg(NOISY, "revision %d type 0x%x ooffset 0x%x goffset 0x%x sacloffset 0x%x dacloffset 0x%x\n",
 		 pntsd->revision, pntsd->type, le32_to_cpu(pntsd->osidoffset),
 		 le32_to_cpu(pntsd->gsidoffset),
@@ -1316,11 +1326,18 @@ static int parse_sec_desc(struct cifs_sb
 		return rc;
 	}
 
-	if (dacloffset)
+	if (dacloffset) {
+		if (!dacl_offset_valid(acl_len, dacloffset)) {
+			cifs_dbg(VFS, "Server returned illegal DACL offset\n");
+			return -EINVAL;
+		}
+
+		dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 		parse_dacl(dacl_ptr, end_of_acl, owner_sid_ptr,
 			   group_sid_ptr, fattr, get_mode_from_special_sid);
-	else
+	} else {
 		cifs_dbg(FYI, "no ACL\n"); /* BB grant all or default perms? */
+	}
 
 	return rc;
 }
@@ -1343,6 +1360,11 @@ static int build_sec_desc(struct smb_nts
 
 	dacloffset = le32_to_cpu(pntsd->dacloffset);
 	if (dacloffset) {
+		if (!dacl_offset_valid(secdesclen, dacloffset)) {
+			cifs_dbg(VFS, "Server returned illegal DACL offset\n");
+			return -EINVAL;
+		}
+
 		dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 		rc = validate_dacl(dacl_ptr, end_of_acl);
 		if (rc)
@@ -1716,6 +1738,12 @@ id_mode_to_cifs_acl(struct inode *inode,
 		nsecdesclen = sizeof(struct smb_ntsd) + (sizeof(struct smb_sid) * 2);
 		dacloffset = le32_to_cpu(pntsd->dacloffset);
 		if (dacloffset) {
+			if (!dacl_offset_valid(secdesclen, dacloffset)) {
+				cifs_dbg(VFS, "Server returned illegal DACL offset\n");
+				rc = -EINVAL;
+				goto id_mode_to_cifs_acl_exit;
+			}
+
 			dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 			rc = validate_dacl(dacl_ptr, (char *)pntsd + secdesclen);
 			if (rc) {
@@ -1758,6 +1786,7 @@ id_mode_to_cifs_acl(struct inode *inode,
 		rc = ops->set_acl(pnntsd, nsecdesclen, inode, path, aclflag);
 		cifs_dbg(NOISY, "set_cifs_acl rc: %d\n", rc);
 	}
+id_mode_to_cifs_acl_exit:
 	cifs_put_tlink(tlink);
 
 	kfree(pnntsd);



