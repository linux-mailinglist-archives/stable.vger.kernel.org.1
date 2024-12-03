Return-Path: <stable+bounces-98081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E769E2B04
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 19:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B2A1C00F40
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE1C1F8921;
	Tue,  3 Dec 2024 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EYzqONlf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4763D81ADA;
	Tue,  3 Dec 2024 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242727; cv=none; b=jC4mH7BZiyww7Sgp56zzwQ2AmMUeoBTOc3SYH+1VJNQTBtEPOm3frT1y7NAnCzhXZG9KlgNjS6xrTN+zMuNcYpAZsnueVfxcGDkNJfBOk7sojHFe6uIqqM8ex926mLoLiJAJh0YCGE7UGv7p6VcmjhBqgP7Gx+UjIHXc4S5dEOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242727; c=relaxed/simple;
	bh=gJtIHxJtTpA8zKHdPLvUlu/QJe6TuvySX737ZkRFaRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peSl0vJ+pNk3YHPQP2Fv8dCsVZkxlr/4Sk8d8Fesz73ZzRO4MRIrFZ1oD7cw2h4s+iSHcqv3LXzXgGe8HhM5/GgWJwMN7yjWQDdIaXX500ynv+3ZZT6pSkc5co8Df7SDA+Bdc6e+9g0KxBGzH7SHGeIue+JDTTFBeeJvjj+YLs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EYzqONlf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACADC4CED6;
	Tue,  3 Dec 2024 16:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733242727;
	bh=gJtIHxJtTpA8zKHdPLvUlu/QJe6TuvySX737ZkRFaRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EYzqONlfbB81xRqUp/oogmFpuRq/4PfOgTqb0o+2Dv5TjIoTYbyyUhVthgyRak6cF
	 2srm97pq9g5Ivr6NxlVCaTV/M2k8a2dfbvED/EnBVMHmVnJ9hIumFY38n0XW79yoQf
	 BS3XZp2QcnhBoSp/8VGbCRNRdI6HTo3UD69YYjrw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ralph Boehme <slow@samba.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 749/826] fs/smb/client: implement chmod() for SMB3 POSIX Extensions
Date: Tue,  3 Dec 2024 15:47:56 +0100
Message-ID: <20241203144812.981971315@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ralph Boehme <slow@samba.org>

commit d413eabff18d640031fc955d107ad9c03c3bf9f1 upstream.

The NT ACL format for an SMB3 POSIX Extensions chmod() is a single ACE with the
magic S-1-5-88-3-mode SID:

  NT Security Descriptor
      Revision: 1
      Type: 0x8004, Self Relative, DACL Present
      Offset to owner SID: 56
      Offset to group SID: 124
      Offset to SACL: 0
      Offset to DACL: 20
      Owner: S-1-5-21-3177838999-3893657415-1037673384-1000
      Group: S-1-22-2-1000
      NT User (DACL) ACL
          Revision: NT4 (2)
          Size: 36
          Num ACEs: 1
          NT ACE: S-1-5-88-3-438, flags 0x00, Access Allowed, mask 0x00000000
              Type: Access Allowed
              NT ACE Flags: 0x00
              Size: 28
              Access required: 0x00000000
              SID: S-1-5-88-3-438

Owner and Group should be NULL, but the server is not required to fail the
request if they are present.

Signed-off-by: Ralph Boehme <slow@samba.org>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifsacl.c   |   50 +++++++++++++++++++++++++++-------------------
 fs/smb/client/cifsproto.h |    4 ++-
 fs/smb/client/inode.c     |    4 ++-
 fs/smb/client/smb2pdu.c   |    2 -
 4 files changed, 37 insertions(+), 23 deletions(-)

--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -885,12 +885,17 @@ unsigned int setup_authusers_ACE(struct
  * Fill in the special SID based on the mode. See
  * https://technet.microsoft.com/en-us/library/hh509017(v=ws.10).aspx
  */
-unsigned int setup_special_mode_ACE(struct smb_ace *pntace, __u64 nmode)
+unsigned int setup_special_mode_ACE(struct smb_ace *pntace,
+				    bool posix,
+				    __u64 nmode)
 {
 	int i;
 	unsigned int ace_size = 28;
 
-	pntace->type = ACCESS_DENIED_ACE_TYPE;
+	if (posix)
+		pntace->type = ACCESS_ALLOWED_ACE_TYPE;
+	else
+		pntace->type = ACCESS_DENIED_ACE_TYPE;
 	pntace->flags = 0x0;
 	pntace->access_req = 0;
 	pntace->sid.num_subauth = 3;
@@ -933,7 +938,8 @@ static void populate_new_aces(char *nacl
 		struct smb_sid *pownersid,
 		struct smb_sid *pgrpsid,
 		__u64 *pnmode, u32 *pnum_aces, u16 *pnsize,
-		bool modefromsid)
+		bool modefromsid,
+		bool posix)
 {
 	__u64 nmode;
 	u32 num_aces = 0;
@@ -950,13 +956,15 @@ static void populate_new_aces(char *nacl
 	num_aces = *pnum_aces;
 	nsize = *pnsize;
 
-	if (modefromsid) {
-		pnntace = (struct smb_ace *) (nacl_base + nsize);
-		nsize += setup_special_mode_ACE(pnntace, nmode);
-		num_aces++;
+	if (modefromsid || posix) {
 		pnntace = (struct smb_ace *) (nacl_base + nsize);
-		nsize += setup_authusers_ACE(pnntace);
+		nsize += setup_special_mode_ACE(pnntace, posix, nmode);
 		num_aces++;
+		if (modefromsid) {
+			pnntace = (struct smb_ace *) (nacl_base + nsize);
+			nsize += setup_authusers_ACE(pnntace);
+			num_aces++;
+		}
 		goto set_size;
 	}
 
@@ -1076,7 +1084,7 @@ static __u16 replace_sids_and_copy_aces(
 
 static int set_chmod_dacl(struct smb_acl *pdacl, struct smb_acl *pndacl,
 		struct smb_sid *pownersid,	struct smb_sid *pgrpsid,
-		__u64 *pnmode, bool mode_from_sid)
+		__u64 *pnmode, bool mode_from_sid, bool posix)
 {
 	int i;
 	u16 size = 0;
@@ -1094,11 +1102,11 @@ static int set_chmod_dacl(struct smb_acl
 	nsize = sizeof(struct smb_acl);
 
 	/* If pdacl is NULL, we don't have a src. Simply populate new ACL. */
-	if (!pdacl) {
+	if (!pdacl || posix) {
 		populate_new_aces(nacl_base,
 				pownersid, pgrpsid,
 				pnmode, &num_aces, &nsize,
-				mode_from_sid);
+				mode_from_sid, posix);
 		goto finalize_dacl;
 	}
 
@@ -1115,7 +1123,7 @@ static int set_chmod_dacl(struct smb_acl
 			populate_new_aces(nacl_base,
 					pownersid, pgrpsid,
 					pnmode, &num_aces, &nsize,
-					mode_from_sid);
+					mode_from_sid, posix);
 
 			new_aces_set = true;
 		}
@@ -1144,7 +1152,7 @@ next_ace:
 		populate_new_aces(nacl_base,
 				pownersid, pgrpsid,
 				pnmode, &num_aces, &nsize,
-				mode_from_sid);
+				mode_from_sid, posix);
 
 		new_aces_set = true;
 	}
@@ -1251,7 +1259,7 @@ static int parse_sec_desc(struct cifs_sb
 /* Convert permission bits from mode to equivalent CIFS ACL */
 static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 	__u32 secdesclen, __u32 *pnsecdesclen, __u64 *pnmode, kuid_t uid, kgid_t gid,
-	bool mode_from_sid, bool id_from_sid, int *aclflag)
+	bool mode_from_sid, bool id_from_sid, bool posix, int *aclflag)
 {
 	int rc = 0;
 	__u32 dacloffset;
@@ -1288,7 +1296,7 @@ static int build_sec_desc(struct smb_nts
 		ndacl_ptr->num_aces = cpu_to_le32(0);
 
 		rc = set_chmod_dacl(dacl_ptr, ndacl_ptr, owner_sid_ptr, group_sid_ptr,
-				    pnmode, mode_from_sid);
+				    pnmode, mode_from_sid, posix);
 
 		sidsoffset = ndacloffset + le16_to_cpu(ndacl_ptr->size);
 		/* copy the non-dacl portion of secdesc */
@@ -1587,6 +1595,7 @@ id_mode_to_cifs_acl(struct inode *inode,
 	struct tcon_link *tlink = cifs_sb_tlink(cifs_sb);
 	struct smb_version_operations *ops;
 	bool mode_from_sid, id_from_sid;
+	bool posix = tlink_tcon(tlink)->posix_extensions;
 	const u32 info = 0;
 
 	if (IS_ERR(tlink))
@@ -1622,12 +1631,13 @@ id_mode_to_cifs_acl(struct inode *inode,
 		id_from_sid = false;
 
 	/* Potentially, five new ACEs can be added to the ACL for U,G,O mapping */
-	nsecdesclen = secdesclen;
 	if (pnmode && *pnmode != NO_CHANGE_64) { /* chmod */
-		if (mode_from_sid)
-			nsecdesclen += 2 * sizeof(struct smb_ace);
+		if (posix)
+			nsecdesclen = 1 * sizeof(struct smb_ace);
+		else if (mode_from_sid)
+			nsecdesclen = secdesclen + (2 * sizeof(struct smb_ace));
 		else /* cifsacl */
-			nsecdesclen += 5 * sizeof(struct smb_ace);
+			nsecdesclen = secdesclen + (5 * sizeof(struct smb_ace));
 	} else { /* chown */
 		/* When ownership changes, changes new owner sid length could be different */
 		nsecdesclen = sizeof(struct smb_ntsd) + (sizeof(struct smb_sid) * 2);
@@ -1657,7 +1667,7 @@ id_mode_to_cifs_acl(struct inode *inode,
 	}
 
 	rc = build_sec_desc(pntsd, pnntsd, secdesclen, &nsecdesclen, pnmode, uid, gid,
-			    mode_from_sid, id_from_sid, &aclflag);
+			    mode_from_sid, id_from_sid, posix, &aclflag);
 
 	cifs_dbg(NOISY, "build_sec_desc rc: %d\n", rc);
 
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -244,7 +244,9 @@ extern int cifs_set_acl(struct mnt_idmap
 extern int set_cifs_acl(struct smb_ntsd *pntsd, __u32 len, struct inode *ino,
 				const char *path, int flag);
 extern unsigned int setup_authusers_ACE(struct smb_ace *pace);
-extern unsigned int setup_special_mode_ACE(struct smb_ace *pace, __u64 nmode);
+extern unsigned int setup_special_mode_ACE(struct smb_ace *pace,
+					   bool posix,
+					   __u64 nmode);
 extern unsigned int setup_special_user_owner_ACE(struct smb_ace *pace);
 
 extern void dequeue_mid(struct mid_q_entry *mid, bool malformed);
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -3062,6 +3062,7 @@ cifs_setattr_nounix(struct dentry *diren
 	int rc = -EACCES;
 	__u32 dosattr = 0;
 	__u64 mode = NO_CHANGE_64;
+	bool posix = cifs_sb_master_tcon(cifs_sb)->posix_extensions;
 
 	xid = get_xid();
 
@@ -3152,7 +3153,8 @@ cifs_setattr_nounix(struct dentry *diren
 		mode = attrs->ia_mode;
 		rc = 0;
 		if ((cifs_sb->mnt_cifs_flags & CIFS_MOUNT_CIFS_ACL) ||
-		    (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_MODE_FROM_SID)) {
+		    (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_MODE_FROM_SID) ||
+		    posix) {
 			rc = id_mode_to_cifs_acl(inode, full_path, &mode,
 						INVALID_UID, INVALID_GID);
 			if (rc) {
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2685,7 +2685,7 @@ create_sd_buf(umode_t mode, bool set_own
 	ptr += sizeof(struct smb3_acl);
 
 	/* create one ACE to hold the mode embedded in reserved special SID */
-	acelen = setup_special_mode_ACE((struct smb_ace *)ptr, (__u64)mode);
+	acelen = setup_special_mode_ACE((struct smb_ace *)ptr, false, (__u64)mode);
 	ptr += acelen;
 	acl_size = acelen + sizeof(struct smb3_acl);
 	ace_count = 1;



