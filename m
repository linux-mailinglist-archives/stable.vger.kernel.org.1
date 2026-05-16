Return-Path: <stable+bounces-249027-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKFzHNvACGrC3wMAu9opvQ
	(envelope-from <stable+bounces-249027-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 21:09:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAB155D75F
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 21:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 775003008762
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 19:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA82735E1A4;
	Sat, 16 May 2026 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDFFOdLE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE95B405C31
	for <stable@vger.kernel.org>; Sat, 16 May 2026 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778958552; cv=none; b=AxS1vPD1rQRqgVb1Dw1bAqHWrItXIlWp13JrYV7Y/A/W27KFX3+1s7HqUkOdSSmWVIjMNKvKO/dCg8uxd4oni9yQOpjDMWXBQVRI1TmNIa2QBhgPFw4tjO9PIeoP3ZA9FKSeeAxPVQYYUiJYgk7igzvyG1ZzJYRWkH/mpwZ+4sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778958552; c=relaxed/simple;
	bh=PupwsvDmPVZNCim68Y3equC+W1HoPvU7Lah15QbqscE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHLNyl7BsPZdfObU6sz0vT4C+/A15GhO26pV2XzjzbfDmYSeu5FdzzzNiFS2SFuK+CseJ9RqMRuq8Zw6wAjOxuGSABtvuFCo7vxJNznLybsSSNg5kYV10akUG5zAzkRNEQABnRyHCcd+nsrOVa+PVtq3Ro74aGI0c9LqM73xZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDFFOdLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF00C19425;
	Sat, 16 May 2026 19:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778958552;
	bh=PupwsvDmPVZNCim68Y3equC+W1HoPvU7Lah15QbqscE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VDFFOdLEM75D5xZmLNYWl0fa28XsF3QNGWF/69J0S4PzZ15UgCZY4YYPqlmm0tco1
	 xkb1hnNQ7SpASZkRcA+vx3aGeUAYmwA/z1d2djiJvCVAGFAvW/2F7sGNICDtejMU1O
	 M9iLksOQpL8lgyMsE6F4CKL9AA+QwM/uKacEeKAyVk4gOE3/FO4nxafwEBbQ2u2kJE
	 NPxa8jaXgNC+l7t1z8ekoRerGXNjPchnW9+ff4T1XVwFivedvDE0jiSxhgcFdmT+i6
	 hSJMWNDaCwuH2WJT8NCQ0cgUUrbv863rcQHECavEeFjBki/afeXK5bUmR4SyybJtaZ
	 8cXOAQXjzTfzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: validate dacloffset before building DACL pointers
Date: Sat, 16 May 2026 15:09:10 -0400
Message-ID: <20260516190910.4016968-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051249-smartness-undercoat-cf5c@gregkh>
References: <2026051249-smartness-undercoat-cf5c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CEAB155D75F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,microsoft.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249027-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit f98b48151cc502ada59d9778f0112d21f2586ca3 ]

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
[ renamed smb_ntsd/smb_acl structs to cifs_ntsd/cifs_acl and kept existing inline ACL size check instead of using missing validate_dacl() helper ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsacl.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index bf861fef2f0c3..8b8f2d909e1b2 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -1183,6 +1183,17 @@ static int parse_sid(struct cifs_sid *psid, char *end_of_acl)
 	return 0;
 }
 
+static bool dacl_offset_valid(unsigned int acl_len, __u32 dacloffset)
+{
+	if (acl_len < sizeof(struct cifs_acl))
+		return false;
+
+	if (dacloffset < sizeof(struct cifs_ntsd))
+		return false;
+
+	return dacloffset <= acl_len - sizeof(struct cifs_acl);
+}
+
 
 /* Convert CIFS ACL to POSIX form */
 static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
@@ -1203,7 +1214,6 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 	group_sid_ptr = (struct cifs_sid *)((char *)pntsd +
 				le32_to_cpu(pntsd->gsidoffset));
 	dacloffset = le32_to_cpu(pntsd->dacloffset);
-	dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
 	cifs_dbg(NOISY, "revision %d type 0x%x ooffset 0x%x goffset 0x%x sacloffset 0x%x dacloffset 0x%x\n",
 		 pntsd->revision, pntsd->type, le32_to_cpu(pntsd->osidoffset),
 		 le32_to_cpu(pntsd->gsidoffset),
@@ -1234,11 +1244,18 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 		return rc;
 	}
 
-	if (dacloffset)
+	if (dacloffset) {
+		if (!dacl_offset_valid(acl_len, dacloffset)) {
+			cifs_dbg(VFS, "Server returned illegal DACL offset\n");
+			return -EINVAL;
+		}
+
+		dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
 		parse_dacl(dacl_ptr, end_of_acl, owner_sid_ptr,
 			   group_sid_ptr, fattr, get_mode_from_special_sid);
-	else
+	} else {
 		cifs_dbg(FYI, "no ACL\n"); /* BB grant all or default perms? */
+	}
 
 	return rc;
 }
@@ -1261,6 +1278,11 @@ static int build_sec_desc(struct cifs_ntsd *pntsd, struct cifs_ntsd *pnntsd,
 
 	dacloffset = le32_to_cpu(pntsd->dacloffset);
 	if (dacloffset) {
+		if (!dacl_offset_valid(secdesclen, dacloffset)) {
+			cifs_dbg(VFS, "Server returned illegal DACL offset\n");
+			return -EINVAL;
+		}
+
 		dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
 		if (end_of_acl < (char *)dacl_ptr + le16_to_cpu(dacl_ptr->size)) {
 			cifs_dbg(VFS, "Server returned illegal ACL size\n");
@@ -1624,6 +1646,12 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 		nsecdesclen = sizeof(struct cifs_ntsd) + (sizeof(struct cifs_sid) * 2);
 		dacloffset = le32_to_cpu(pntsd->dacloffset);
 		if (dacloffset) {
+			if (!dacl_offset_valid(secdesclen, dacloffset)) {
+				cifs_dbg(VFS, "Server returned illegal DACL offset\n");
+				rc = -EINVAL;
+				goto id_mode_to_cifs_acl_exit;
+			}
+
 			dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
 			if (mode_from_sid)
 				nsecdesclen +=
@@ -1660,6 +1688,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 		rc = ops->set_acl(pnntsd, nsecdesclen, inode, path, aclflag);
 		cifs_dbg(NOISY, "set_cifs_acl rc: %d\n", rc);
 	}
+id_mode_to_cifs_acl_exit:
 	cifs_put_tlink(tlink);
 
 	kfree(pnntsd);
-- 
2.53.0


