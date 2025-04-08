Return-Path: <stable+bounces-131620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CC4A80BD8
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547958C613D
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666E326E178;
	Tue,  8 Apr 2025 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wsfHM/f2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E6726B2C1;
	Tue,  8 Apr 2025 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116889; cv=none; b=ffXHd/NujGXnKqKG9vIsOohwqdDsLCU05zgpQ/NDCfIGwiodvErb/yJ/VMclrRy8dV1/hbAxAhjchSd98m+vFFYu3PM9uZz2O+MnHN1olJWxeg1NITixgX7SRY7uPvHdMgf6VZjSv9yxiMKXZjyNR7BbjEmHYAUWx4kKkWhnoSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116889; c=relaxed/simple;
	bh=SH8rCMmCZJbAlnpNdR+e9Oaar0J/VP72sCTuS6p5lr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujqhGAMWazLw/y09qDitDUwokaOi1Ww7Pgb1QkCKJARgIFBJj7G9vD7cj0Whdtind1khJzwgAuGax6wDwTgGS4oaMT8EHS3fDXcOTCCREjXBr3YQppsfiaSIrW46utjqRdi2kom5i6TQTgyXKnvmmDCLCXjsfZbZr8mFz87eJVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wsfHM/f2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4440C4CEE5;
	Tue,  8 Apr 2025 12:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116889;
	bh=SH8rCMmCZJbAlnpNdR+e9Oaar0J/VP72sCTuS6p5lr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wsfHM/f29A84wUWlqQ7qUV6NyLLt43USd0xQuIs9nGThXYIhjPOLGD2nDe6N7BYwq
	 iV1aiL7NUNxRnpgSW/I8tTgjb+25pHQoSZVRrm83GL/UAw1v5J5Cez8ba3nLjzUXGE
	 TKVB5wL3Se56zWYjoEm7SH29lBmtruR+EbVNSnmM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Igor Leite Ladessa <igor-ladessa@hotmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 267/423] smb: common: change the data type of num_aces to le16
Date: Tue,  8 Apr 2025 12:49:53 +0200
Message-ID: <20250408104851.971039772@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 62e7dd0a39c2d0d7ff03274c36df971f1b3d2d0d ]

2.4.5 in [MS-DTYP].pdf describe the data type of num_aces as le16.

AceCount (2 bytes): An unsigned 16-bit integer that specifies the count
of the number of ACE records in the ACL.

Change it to le16 and add reserved field to smb_acl struct.

Reported-by: Igor Leite Ladessa <igor-ladessa@hotmail.com>
Tested-by: Igor Leite Ladessa <igor-ladessa@hotmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsacl.c | 26 +++++++++++++-------------
 fs/smb/common/smbacl.h  |  3 ++-
 fs/smb/server/smbacl.c  | 31 ++++++++++++++++---------------
 fs/smb/server/smbacl.h  |  2 +-
 4 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index ebe9a7d7c70e8..1f036169fb582 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -763,7 +763,7 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 		       struct cifs_fattr *fattr, bool mode_from_special_sid)
 {
 	int i;
-	int num_aces = 0;
+	u16 num_aces = 0;
 	int acl_size;
 	char *acl_base;
 	struct smb_ace **ppace;
@@ -785,7 +785,7 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 
 	cifs_dbg(NOISY, "DACL revision %d size %d num aces %d\n",
 		 le16_to_cpu(pdacl->revision), le16_to_cpu(pdacl->size),
-		 le32_to_cpu(pdacl->num_aces));
+		 le16_to_cpu(pdacl->num_aces));
 
 	/* reset rwx permissions for user/group/other.
 	   Also, if num_aces is 0 i.e. DACL has no ACEs,
@@ -795,7 +795,7 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 	acl_base = (char *)pdacl;
 	acl_size = sizeof(struct smb_acl);
 
-	num_aces = le32_to_cpu(pdacl->num_aces);
+	num_aces = le16_to_cpu(pdacl->num_aces);
 	if (num_aces > 0) {
 		umode_t denied_mode = 0;
 
@@ -937,12 +937,12 @@ unsigned int setup_special_user_owner_ACE(struct smb_ace *pntace)
 static void populate_new_aces(char *nacl_base,
 		struct smb_sid *pownersid,
 		struct smb_sid *pgrpsid,
-		__u64 *pnmode, u32 *pnum_aces, u16 *pnsize,
+		__u64 *pnmode, u16 *pnum_aces, u16 *pnsize,
 		bool modefromsid,
 		bool posix)
 {
 	__u64 nmode;
-	u32 num_aces = 0;
+	u16 num_aces = 0;
 	u16 nsize = 0;
 	__u64 user_mode;
 	__u64 group_mode;
@@ -1050,7 +1050,7 @@ static __u16 replace_sids_and_copy_aces(struct smb_acl *pdacl, struct smb_acl *p
 	u16 size = 0;
 	struct smb_ace *pntace = NULL;
 	char *acl_base = NULL;
-	u32 src_num_aces = 0;
+	u16 src_num_aces = 0;
 	u16 nsize = 0;
 	struct smb_ace *pnntace = NULL;
 	char *nacl_base = NULL;
@@ -1058,7 +1058,7 @@ static __u16 replace_sids_and_copy_aces(struct smb_acl *pdacl, struct smb_acl *p
 
 	acl_base = (char *)pdacl;
 	size = sizeof(struct smb_acl);
-	src_num_aces = le32_to_cpu(pdacl->num_aces);
+	src_num_aces = le16_to_cpu(pdacl->num_aces);
 
 	nacl_base = (char *)pndacl;
 	nsize = sizeof(struct smb_acl);
@@ -1090,11 +1090,11 @@ static int set_chmod_dacl(struct smb_acl *pdacl, struct smb_acl *pndacl,
 	u16 size = 0;
 	struct smb_ace *pntace = NULL;
 	char *acl_base = NULL;
-	u32 src_num_aces = 0;
+	u16 src_num_aces = 0;
 	u16 nsize = 0;
 	struct smb_ace *pnntace = NULL;
 	char *nacl_base = NULL;
-	u32 num_aces = 0;
+	u16 num_aces = 0;
 	bool new_aces_set = false;
 
 	/* Assuming that pndacl and pnmode are never NULL */
@@ -1112,7 +1112,7 @@ static int set_chmod_dacl(struct smb_acl *pdacl, struct smb_acl *pndacl,
 
 	acl_base = (char *)pdacl;
 	size = sizeof(struct smb_acl);
-	src_num_aces = le32_to_cpu(pdacl->num_aces);
+	src_num_aces = le16_to_cpu(pdacl->num_aces);
 
 	/* Retain old ACEs which we can retain */
 	for (i = 0; i < src_num_aces; ++i) {
@@ -1158,7 +1158,7 @@ static int set_chmod_dacl(struct smb_acl *pdacl, struct smb_acl *pndacl,
 	}
 
 finalize_dacl:
-	pndacl->num_aces = cpu_to_le32(num_aces);
+	pndacl->num_aces = cpu_to_le16(num_aces);
 	pndacl->size = cpu_to_le16(nsize);
 
 	return 0;
@@ -1293,7 +1293,7 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 			dacloffset ? dacl_ptr->revision : cpu_to_le16(ACL_REVISION);
 
 		ndacl_ptr->size = cpu_to_le16(0);
-		ndacl_ptr->num_aces = cpu_to_le32(0);
+		ndacl_ptr->num_aces = cpu_to_le16(0);
 
 		rc = set_chmod_dacl(dacl_ptr, ndacl_ptr, owner_sid_ptr, group_sid_ptr,
 				    pnmode, mode_from_sid, posix);
@@ -1651,7 +1651,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 			dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 			if (mode_from_sid)
 				nsecdesclen +=
-					le32_to_cpu(dacl_ptr->num_aces) * sizeof(struct smb_ace);
+					le16_to_cpu(dacl_ptr->num_aces) * sizeof(struct smb_ace);
 			else /* cifsacl */
 				nsecdesclen += le16_to_cpu(dacl_ptr->size);
 		}
diff --git a/fs/smb/common/smbacl.h b/fs/smb/common/smbacl.h
index 6a60698fc6f0f..a624ec9e4a144 100644
--- a/fs/smb/common/smbacl.h
+++ b/fs/smb/common/smbacl.h
@@ -107,7 +107,8 @@ struct smb_sid {
 struct smb_acl {
 	__le16 revision; /* revision level */
 	__le16 size;
-	__le32 num_aces;
+	__le16 num_aces;
+	__le16 reserved;
 } __attribute__((packed));
 
 struct smb_ace {
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 109036e2227ca..5e6ffb821f6fd 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -333,7 +333,7 @@ void posix_state_to_acl(struct posix_acl_state *state,
 	pace->e_perm = state->other.allow;
 }
 
-int init_acl_state(struct posix_acl_state *state, int cnt)
+int init_acl_state(struct posix_acl_state *state, u16 cnt)
 {
 	int alloc;
 
@@ -368,7 +368,7 @@ static void parse_dacl(struct mnt_idmap *idmap,
 		       struct smb_fattr *fattr)
 {
 	int i, ret;
-	int num_aces = 0;
+	u16 num_aces = 0;
 	unsigned int acl_size;
 	char *acl_base;
 	struct smb_ace **ppace;
@@ -389,12 +389,12 @@ static void parse_dacl(struct mnt_idmap *idmap,
 
 	ksmbd_debug(SMB, "DACL revision %d size %d num aces %d\n",
 		    le16_to_cpu(pdacl->revision), le16_to_cpu(pdacl->size),
-		    le32_to_cpu(pdacl->num_aces));
+		    le16_to_cpu(pdacl->num_aces));
 
 	acl_base = (char *)pdacl;
 	acl_size = sizeof(struct smb_acl);
 
-	num_aces = le32_to_cpu(pdacl->num_aces);
+	num_aces = le16_to_cpu(pdacl->num_aces);
 	if (num_aces <= 0)
 		return;
 
@@ -583,7 +583,7 @@ static void parse_dacl(struct mnt_idmap *idmap,
 
 static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 				       struct smb_ace *pndace,
-				       struct smb_fattr *fattr, u32 *num_aces,
+				       struct smb_fattr *fattr, u16 *num_aces,
 				       u16 *size, u32 nt_aces_num)
 {
 	struct posix_acl_entry *pace;
@@ -704,7 +704,7 @@ static void set_ntacl_dacl(struct mnt_idmap *idmap,
 			   struct smb_fattr *fattr)
 {
 	struct smb_ace *ntace, *pndace;
-	int nt_num_aces = le32_to_cpu(nt_dacl->num_aces), num_aces = 0;
+	u16 nt_num_aces = le16_to_cpu(nt_dacl->num_aces), num_aces = 0;
 	unsigned short size = 0;
 	int i;
 
@@ -731,7 +731,7 @@ static void set_ntacl_dacl(struct mnt_idmap *idmap,
 
 	set_posix_acl_entries_dacl(idmap, pndace, fattr,
 				   &num_aces, &size, nt_num_aces);
-	pndacl->num_aces = cpu_to_le32(num_aces);
+	pndacl->num_aces = cpu_to_le16(num_aces);
 	pndacl->size = cpu_to_le16(le16_to_cpu(pndacl->size) + size);
 }
 
@@ -739,7 +739,7 @@ static void set_mode_dacl(struct mnt_idmap *idmap,
 			  struct smb_acl *pndacl, struct smb_fattr *fattr)
 {
 	struct smb_ace *pace, *pndace;
-	u32 num_aces = 0;
+	u16 num_aces = 0;
 	u16 size = 0, ace_size = 0;
 	uid_t uid;
 	const struct smb_sid *sid;
@@ -795,7 +795,7 @@ static void set_mode_dacl(struct mnt_idmap *idmap,
 				 fattr->cf_mode, 0007);
 
 out:
-	pndacl->num_aces = cpu_to_le32(num_aces);
+	pndacl->num_aces = cpu_to_le16(num_aces);
 	pndacl->size = cpu_to_le16(le16_to_cpu(pndacl->size) + size);
 }
 
@@ -1025,8 +1025,9 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 	struct smb_sid owner_sid, group_sid;
 	struct dentry *parent = path->dentry->d_parent;
 	struct mnt_idmap *idmap = mnt_idmap(path->mnt);
-	int inherited_flags = 0, flags = 0, i, ace_cnt = 0, nt_size = 0, pdacl_size;
-	int rc = 0, num_aces, dacloffset, pntsd_type, pntsd_size, acl_len, aces_size;
+	int inherited_flags = 0, flags = 0, i, nt_size = 0, pdacl_size;
+	int rc = 0, dacloffset, pntsd_type, pntsd_size, acl_len, aces_size;
+	u16 num_aces, ace_cnt = 0;
 	char *aces_base;
 	bool is_dir = S_ISDIR(d_inode(path->dentry)->i_mode);
 
@@ -1042,7 +1043,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 
 	parent_pdacl = (struct smb_acl *)((char *)parent_pntsd + dacloffset);
 	acl_len = pntsd_size - dacloffset;
-	num_aces = le32_to_cpu(parent_pdacl->num_aces);
+	num_aces = le16_to_cpu(parent_pdacl->num_aces);
 	pntsd_type = le16_to_cpu(parent_pntsd->type);
 	pdacl_size = le16_to_cpu(parent_pdacl->size);
 
@@ -1201,7 +1202,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 			pdacl = (struct smb_acl *)((char *)pntsd + le32_to_cpu(pntsd->dacloffset));
 			pdacl->revision = cpu_to_le16(2);
 			pdacl->size = cpu_to_le16(sizeof(struct smb_acl) + nt_size);
-			pdacl->num_aces = cpu_to_le32(ace_cnt);
+			pdacl->num_aces = cpu_to_le16(ace_cnt);
 			pace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 			memcpy(pace, aces_base, nt_size);
 			pntsd_size += sizeof(struct smb_acl) + nt_size;
@@ -1282,7 +1283,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 
 		ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 		aces_size = acl_size - sizeof(struct smb_acl);
-		for (i = 0; i < le32_to_cpu(pdacl->num_aces); i++) {
+		for (i = 0; i < le16_to_cpu(pdacl->num_aces); i++) {
 			if (offsetof(struct smb_ace, access_req) > aces_size)
 				break;
 			ace_size = le16_to_cpu(ace->size);
@@ -1303,7 +1304,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 
 	ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 	aces_size = acl_size - sizeof(struct smb_acl);
-	for (i = 0; i < le32_to_cpu(pdacl->num_aces); i++) {
+	for (i = 0; i < le16_to_cpu(pdacl->num_aces); i++) {
 		if (offsetof(struct smb_ace, access_req) > aces_size)
 			break;
 		ace_size = le16_to_cpu(ace->size);
diff --git a/fs/smb/server/smbacl.h b/fs/smb/server/smbacl.h
index 24ce576fc2924..355adaee39b87 100644
--- a/fs/smb/server/smbacl.h
+++ b/fs/smb/server/smbacl.h
@@ -86,7 +86,7 @@ int parse_sec_desc(struct mnt_idmap *idmap, struct smb_ntsd *pntsd,
 int build_sec_desc(struct mnt_idmap *idmap, struct smb_ntsd *pntsd,
 		   struct smb_ntsd *ppntsd, int ppntsd_size, int addition_info,
 		   __u32 *secdesclen, struct smb_fattr *fattr);
-int init_acl_state(struct posix_acl_state *state, int cnt);
+int init_acl_state(struct posix_acl_state *state, u16 cnt);
 void free_acl_state(struct posix_acl_state *state);
 void posix_state_to_acl(struct posix_acl_state *state,
 			struct posix_acl_entry *pace);
-- 
2.39.5




