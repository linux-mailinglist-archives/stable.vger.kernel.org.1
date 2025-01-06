Return-Path: <stable+bounces-106954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41575A02979
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404903A04A5
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B889154C04;
	Mon,  6 Jan 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1h8EjEda"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C79158A1F;
	Mon,  6 Jan 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177015; cv=none; b=u/csth3wH3KvdiD1t3KKIp5mrOfOA06x2az/90Ek/HwYHhK5CsRW5CDoWg4+WZKCIDHBdGNniiP0YbCKkXF+BgYwq+e3RdBLX57iYfvPupEIk3UXNhptmjIRS7uKpCWrKKfQPzHOnKdI1MmZ397FJktxgMIxTlBC4HNJLcdo+wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177015; c=relaxed/simple;
	bh=8jKB+GjQektUSUpYMWHabHe6lWflmVhs0ja4xQ8IW+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhHFJTX+18hpmP2TY0Y+StlJhVRVPKll4P926oCLCuwqD3jXrIjglKRoXvlCtb8es9EACqwXdOr178ayw+Gfee0rLad7zYEpkrb1241l9VOiBddMpDn9lCKu8rzwaiIH1yZu0AqNl4YPgcgQaE3e5fjgmlhAuMSyqrmg46OQDBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1h8EjEda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D82FC4CED2;
	Mon,  6 Jan 2025 15:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736177014;
	bh=8jKB+GjQektUSUpYMWHabHe6lWflmVhs0ja4xQ8IW+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1h8EjEdaxHbC/KsSUlK0Uz2RldSknkZpcA2fo3fIx0L+IyXTWJwcsyyWw7ptFF8wo
	 XR3n2QSaoS04IZOIaUOFCFSVB/MoEZ/zFB9xO8bkXyDmNM06U0ydVweHeoRAGUpNDT
	 XhQ5rbbP9l7PSwbQxNr0p+aPQgKKOvAsqw+non80=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 005/222] smb/client: rename cifs_ntsd to smb_ntsd
Date: Mon,  6 Jan 2025 16:13:29 +0100
Message-ID: <20250106151150.797902507@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151150.585603565@linuxfoundation.org>
References: <20250106151150.585603565@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

[ Upstream commit 3651487607ae778df1051a0a38bb34a5bd34e3b7 ]

Preparation for moving acl definitions to new common header file.

Use the following shell command to rename:

  find fs/smb/client -type f -exec sed -i \
    's/struct cifs_ntsd/struct smb_ntsd/g' {} +

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: d413eabff18d ("fs/smb/client: implement chmod() for SMB3 POSIX Extensions")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsacl.c   | 36 ++++++++++++++++++------------------
 fs/smb/client/cifsacl.h   |  6 +++---
 fs/smb/client/cifsglob.h  | 12 ++++++------
 fs/smb/client/cifsproto.h | 16 ++++++++--------
 fs/smb/client/cifssmb.c   |  6 +++---
 fs/smb/client/smb2ops.c   | 14 +++++++-------
 fs/smb/client/smb2pdu.c   |  2 +-
 fs/smb/client/smb2proto.h |  2 +-
 fs/smb/client/xattr.c     |  4 ++--
 9 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index f5b6df82e857..3f7657475cd9 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -515,8 +515,8 @@ exit_cifs_idmap(void)
 }
 
 /* copy ntsd, owner sid, and group sid from a security descriptor to another */
-static __u32 copy_sec_desc(const struct cifs_ntsd *pntsd,
-				struct cifs_ntsd *pnntsd,
+static __u32 copy_sec_desc(const struct smb_ntsd *pntsd,
+				struct smb_ntsd *pnntsd,
 				__u32 sidsoffset,
 				struct cifs_sid *pownersid,
 				struct cifs_sid *pgrpsid)
@@ -527,7 +527,7 @@ static __u32 copy_sec_desc(const struct cifs_ntsd *pntsd,
 	/* copy security descriptor control portion */
 	pnntsd->revision = pntsd->revision;
 	pnntsd->type = pntsd->type;
-	pnntsd->dacloffset = cpu_to_le32(sizeof(struct cifs_ntsd));
+	pnntsd->dacloffset = cpu_to_le32(sizeof(struct smb_ntsd));
 	pnntsd->sacloffset = 0;
 	pnntsd->osidoffset = cpu_to_le32(sidsoffset);
 	pnntsd->gsidoffset = cpu_to_le32(sidsoffset + sizeof(struct cifs_sid));
@@ -1191,7 +1191,7 @@ static int parse_sid(struct cifs_sid *psid, char *end_of_acl)
 
 /* Convert CIFS ACL to POSIX form */
 static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
-		struct cifs_ntsd *pntsd, int acl_len, struct cifs_fattr *fattr,
+		struct smb_ntsd *pntsd, int acl_len, struct cifs_fattr *fattr,
 		bool get_mode_from_special_sid)
 {
 	int rc = 0;
@@ -1249,7 +1249,7 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 }
 
 /* Convert permission bits from mode to equivalent CIFS ACL */
-static int build_sec_desc(struct cifs_ntsd *pntsd, struct cifs_ntsd *pnntsd,
+static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 	__u32 secdesclen, __u32 *pnsecdesclen, __u64 *pnmode, kuid_t uid, kgid_t gid,
 	bool mode_from_sid, bool id_from_sid, int *aclflag)
 {
@@ -1279,7 +1279,7 @@ static int build_sec_desc(struct cifs_ntsd *pntsd, struct cifs_ntsd *pnntsd,
 			le32_to_cpu(pntsd->gsidoffset));
 
 	if (pnmode && *pnmode != NO_CHANGE_64) { /* chmod */
-		ndacloffset = sizeof(struct cifs_ntsd);
+		ndacloffset = sizeof(struct smb_ntsd);
 		ndacl_ptr = (struct cifs_acl *)((char *)pnntsd + ndacloffset);
 		ndacl_ptr->revision =
 			dacloffset ? dacl_ptr->revision : cpu_to_le16(ACL_REVISION);
@@ -1297,7 +1297,7 @@ static int build_sec_desc(struct cifs_ntsd *pntsd, struct cifs_ntsd *pnntsd,
 
 		*aclflag |= CIFS_ACL_DACL;
 	} else {
-		ndacloffset = sizeof(struct cifs_ntsd);
+		ndacloffset = sizeof(struct smb_ntsd);
 		ndacl_ptr = (struct cifs_acl *)((char *)pnntsd + ndacloffset);
 		ndacl_ptr->revision =
 			dacloffset ? dacl_ptr->revision : cpu_to_le16(ACL_REVISION);
@@ -1385,11 +1385,11 @@ static int build_sec_desc(struct cifs_ntsd *pntsd, struct cifs_ntsd *pnntsd,
 }
 
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
-struct cifs_ntsd *get_cifs_acl_by_fid(struct cifs_sb_info *cifs_sb,
+struct smb_ntsd *get_cifs_acl_by_fid(struct cifs_sb_info *cifs_sb,
 				      const struct cifs_fid *cifsfid, u32 *pacllen,
 				      u32 __maybe_unused unused)
 {
-	struct cifs_ntsd *pntsd = NULL;
+	struct smb_ntsd *pntsd = NULL;
 	unsigned int xid;
 	int rc;
 	struct tcon_link *tlink = cifs_sb_tlink(cifs_sb);
@@ -1410,10 +1410,10 @@ struct cifs_ntsd *get_cifs_acl_by_fid(struct cifs_sb_info *cifs_sb,
 	return pntsd;
 }
 
-static struct cifs_ntsd *get_cifs_acl_by_path(struct cifs_sb_info *cifs_sb,
+static struct smb_ntsd *get_cifs_acl_by_path(struct cifs_sb_info *cifs_sb,
 		const char *path, u32 *pacllen)
 {
-	struct cifs_ntsd *pntsd = NULL;
+	struct smb_ntsd *pntsd = NULL;
 	int oplock = 0;
 	unsigned int xid;
 	int rc;
@@ -1454,11 +1454,11 @@ static struct cifs_ntsd *get_cifs_acl_by_path(struct cifs_sb_info *cifs_sb,
 }
 
 /* Retrieve an ACL from the server */
-struct cifs_ntsd *get_cifs_acl(struct cifs_sb_info *cifs_sb,
+struct smb_ntsd *get_cifs_acl(struct cifs_sb_info *cifs_sb,
 				      struct inode *inode, const char *path,
 			       u32 *pacllen, u32 info)
 {
-	struct cifs_ntsd *pntsd = NULL;
+	struct smb_ntsd *pntsd = NULL;
 	struct cifsFileInfo *open_file = NULL;
 
 	if (inode)
@@ -1472,7 +1472,7 @@ struct cifs_ntsd *get_cifs_acl(struct cifs_sb_info *cifs_sb,
 }
 
  /* Set an ACL on the server */
-int set_cifs_acl(struct cifs_ntsd *pnntsd, __u32 acllen,
+int set_cifs_acl(struct smb_ntsd *pnntsd, __u32 acllen,
 			struct inode *inode, const char *path, int aclflag)
 {
 	int oplock = 0;
@@ -1528,7 +1528,7 @@ cifs_acl_to_fattr(struct cifs_sb_info *cifs_sb, struct cifs_fattr *fattr,
 		  struct inode *inode, bool mode_from_special_sid,
 		  const char *path, const struct cifs_fid *pfid)
 {
-	struct cifs_ntsd *pntsd = NULL;
+	struct smb_ntsd *pntsd = NULL;
 	u32 acllen = 0;
 	int rc = 0;
 	struct tcon_link *tlink = cifs_sb_tlink(cifs_sb);
@@ -1581,8 +1581,8 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 	__u32 nsecdesclen = 0;
 	__u32 dacloffset = 0;
 	struct cifs_acl *dacl_ptr = NULL;
-	struct cifs_ntsd *pntsd = NULL; /* acl obtained from server */
-	struct cifs_ntsd *pnntsd = NULL; /* modified acl to be sent to server */
+	struct smb_ntsd *pntsd = NULL; /* acl obtained from server */
+	struct smb_ntsd *pnntsd = NULL; /* modified acl to be sent to server */
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct tcon_link *tlink = cifs_sb_tlink(cifs_sb);
 	struct smb_version_operations *ops;
@@ -1630,7 +1630,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 			nsecdesclen += 5 * sizeof(struct cifs_ace);
 	} else { /* chown */
 		/* When ownership changes, changes new owner sid length could be different */
-		nsecdesclen = sizeof(struct cifs_ntsd) + (sizeof(struct cifs_sid) * 2);
+		nsecdesclen = sizeof(struct smb_ntsd) + (sizeof(struct cifs_sid) * 2);
 		dacloffset = le32_to_cpu(pntsd->dacloffset);
 		if (dacloffset) {
 			dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
diff --git a/fs/smb/client/cifsacl.h b/fs/smb/client/cifsacl.h
index ccbfc754bd3c..1516545d7f67 100644
--- a/fs/smb/client/cifsacl.h
+++ b/fs/smb/client/cifsacl.h
@@ -33,7 +33,7 @@
  * Security Descriptor length containing DACL with 3 ACEs (one each for
  * owner, group and world).
  */
-#define DEFAULT_SEC_DESC_LEN (sizeof(struct cifs_ntsd) + \
+#define DEFAULT_SEC_DESC_LEN (sizeof(struct smb_ntsd) + \
 			      sizeof(struct cifs_acl) + \
 			      (sizeof(struct cifs_ace) * 4))
 
@@ -55,7 +55,7 @@
 #define SID_STRING_BASE_SIZE (2 + 3 + 15 + 1)
 #define SID_STRING_SUBAUTH_SIZE (11) /* size of a single subauth string */
 
-struct cifs_ntsd {
+struct smb_ntsd {
 	__le16 revision; /* revision level */
 	__le16 type;
 	__le32 osidoffset;
@@ -194,6 +194,6 @@ struct owner_group_sids {
  * Minimum security descriptor can be one without any SACL and DACL and can
  * consist of revision, type, and two sids of minimum size for owner and group
  */
-#define MIN_SEC_DESC_LEN  (sizeof(struct cifs_ntsd) + (2 * MIN_SID_LEN))
+#define MIN_SEC_DESC_LEN  (sizeof(struct smb_ntsd) + (2 * MIN_SID_LEN))
 
 #endif /* _CIFSACL_H */
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 6b57b167a49d..cf22629bf90b 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -539,12 +539,12 @@ struct smb_version_operations {
 	int (*set_EA)(const unsigned int, struct cifs_tcon *, const char *,
 			const char *, const void *, const __u16,
 			const struct nls_table *, struct cifs_sb_info *);
-	struct cifs_ntsd * (*get_acl)(struct cifs_sb_info *, struct inode *,
-			const char *, u32 *, u32);
-	struct cifs_ntsd * (*get_acl_by_fid)(struct cifs_sb_info *,
-			const struct cifs_fid *, u32 *, u32);
-	int (*set_acl)(struct cifs_ntsd *, __u32, struct inode *, const char *,
-			int);
+	struct smb_ntsd * (*get_acl)(struct cifs_sb_info *cifssb, struct inode *ino,
+			const char *patch, u32 *plen, u32 info);
+	struct smb_ntsd * (*get_acl_by_fid)(struct cifs_sb_info *cifssmb,
+			const struct cifs_fid *pfid, u32 *plen, u32 info);
+	int (*set_acl)(struct smb_ntsd *pntsd, __u32 len, struct inode *ino, const char *path,
+			int flag);
 	/* writepages retry size */
 	unsigned int (*wp_retry_size)(struct inode *);
 	/* get mtu credits */
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 83692bf60007..f34c533efe49 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -231,16 +231,16 @@ extern int cifs_acl_to_fattr(struct cifs_sb_info *cifs_sb,
 			      const char *path, const struct cifs_fid *pfid);
 extern int id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 					kuid_t uid, kgid_t gid);
-extern struct cifs_ntsd *get_cifs_acl(struct cifs_sb_info *, struct inode *,
-				      const char *, u32 *, u32);
-extern struct cifs_ntsd *get_cifs_acl_by_fid(struct cifs_sb_info *,
-				const struct cifs_fid *, u32 *, u32);
+extern struct smb_ntsd *get_cifs_acl(struct cifs_sb_info *cifssmb, struct inode *ino,
+				      const char *path, u32 *plen, u32 info);
+extern struct smb_ntsd *get_cifs_acl_by_fid(struct cifs_sb_info *cifssb,
+				const struct cifs_fid *pfid, u32 *plen, u32 info);
 extern struct posix_acl *cifs_get_acl(struct mnt_idmap *idmap,
 				      struct dentry *dentry, int type);
 extern int cifs_set_acl(struct mnt_idmap *idmap,
 			struct dentry *dentry, struct posix_acl *acl, int type);
-extern int set_cifs_acl(struct cifs_ntsd *, __u32, struct inode *,
-				const char *, int);
+extern int set_cifs_acl(struct smb_ntsd *pntsd, __u32 len, struct inode *ino,
+				const char *path, int flag);
 extern unsigned int setup_authusers_ACE(struct cifs_ace *pace);
 extern unsigned int setup_special_mode_ACE(struct cifs_ace *pace, __u64 nmode);
 extern unsigned int setup_special_user_owner_ACE(struct cifs_ace *pace);
@@ -568,9 +568,9 @@ extern int CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
 		const struct nls_table *nls_codepage,
 		struct cifs_sb_info *cifs_sb);
 extern int CIFSSMBGetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon,
-			__u16 fid, struct cifs_ntsd **acl_inf, __u32 *buflen);
+			__u16 fid, struct smb_ntsd **acl_inf, __u32 *buflen);
 extern int CIFSSMBSetCIFSACL(const unsigned int, struct cifs_tcon *, __u16,
-			struct cifs_ntsd *, __u32, int);
+			struct smb_ntsd *pntsd, __u32 len, int aclflag);
 extern int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
 			   const unsigned char *searchName,
 			   struct posix_acl **acl, const int acl_type,
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index a34db419e46f..2f8745736dbb 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3385,7 +3385,7 @@ validate_ntransact(char *buf, char **ppparm, char **ppdata,
 /* Get Security Descriptor (by handle) from remote server for a file or dir */
 int
 CIFSSMBGetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon, __u16 fid,
-		  struct cifs_ntsd **acl_inf, __u32 *pbuflen)
+		  struct smb_ntsd **acl_inf, __u32 *pbuflen)
 {
 	int rc = 0;
 	int buf_type = 0;
@@ -3455,7 +3455,7 @@ CIFSSMBGetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon, __u16 fid,
 
 		/* check if buffer is big enough for the acl
 		   header followed by the smallest SID */
-		if ((*pbuflen < sizeof(struct cifs_ntsd) + 8) ||
+		if ((*pbuflen < sizeof(struct smb_ntsd) + 8) ||
 		    (*pbuflen >= 64 * 1024)) {
 			cifs_dbg(VFS, "bad acl length %d\n", *pbuflen);
 			rc = -EINVAL;
@@ -3475,7 +3475,7 @@ CIFSSMBGetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon, __u16 fid,
 
 int
 CIFSSMBSetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon, __u16 fid,
-			struct cifs_ntsd *pntsd, __u32 acllen, int aclflag)
+			struct smb_ntsd *pntsd, __u32 acllen, int aclflag)
 {
 	__u16 byte_count, param_count, data_count, param_offset, data_offset;
 	int rc = 0;
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 6645f147d57c..fc6d00344c50 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3001,11 +3001,11 @@ smb2_get_dfs_refer(const unsigned int xid, struct cifs_ses *ses,
 	return rc;
 }
 
-static struct cifs_ntsd *
+static struct smb_ntsd *
 get_smb2_acl_by_fid(struct cifs_sb_info *cifs_sb,
 		    const struct cifs_fid *cifsfid, u32 *pacllen, u32 info)
 {
-	struct cifs_ntsd *pntsd = NULL;
+	struct smb_ntsd *pntsd = NULL;
 	unsigned int xid;
 	int rc = -EOPNOTSUPP;
 	struct tcon_link *tlink = cifs_sb_tlink(cifs_sb);
@@ -3030,11 +3030,11 @@ get_smb2_acl_by_fid(struct cifs_sb_info *cifs_sb,
 
 }
 
-static struct cifs_ntsd *
+static struct smb_ntsd *
 get_smb2_acl_by_path(struct cifs_sb_info *cifs_sb,
 		     const char *path, u32 *pacllen, u32 info)
 {
-	struct cifs_ntsd *pntsd = NULL;
+	struct smb_ntsd *pntsd = NULL;
 	u8 oplock = SMB2_OPLOCK_LEVEL_NONE;
 	unsigned int xid;
 	int rc;
@@ -3097,7 +3097,7 @@ get_smb2_acl_by_path(struct cifs_sb_info *cifs_sb,
 }
 
 static int
-set_smb2_acl(struct cifs_ntsd *pnntsd, __u32 acllen,
+set_smb2_acl(struct smb_ntsd *pnntsd, __u32 acllen,
 		struct inode *inode, const char *path, int aclflag)
 {
 	u8 oplock = SMB2_OPLOCK_LEVEL_NONE;
@@ -3155,12 +3155,12 @@ set_smb2_acl(struct cifs_ntsd *pnntsd, __u32 acllen,
 }
 
 /* Retrieve an ACL from the server */
-static struct cifs_ntsd *
+static struct smb_ntsd *
 get_smb2_acl(struct cifs_sb_info *cifs_sb,
 	     struct inode *inode, const char *path,
 	     u32 *pacllen, u32 info)
 {
-	struct cifs_ntsd *pntsd = NULL;
+	struct smb_ntsd *pntsd = NULL;
 	struct cifsFileInfo *open_file = NULL;
 
 	if (inode && !(info & SACL_SECINFO))
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 38b26468eb0c..0a4985bba55f 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -5626,7 +5626,7 @@ SMB2_set_eof(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
 int
 SMB2_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
 		u64 persistent_fid, u64 volatile_fid,
-		struct cifs_ntsd *pnntsd, int pacllen, int aclflag)
+		struct smb_ntsd *pnntsd, int pacllen, int aclflag)
 {
 	return send_set_info(xid, tcon, persistent_fid, volatile_fid,
 			current->tgid, 0, SMB2_O_INFO_SECURITY, aclflag,
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index 613667b46c58..fd90d8e5a1d1 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -247,7 +247,7 @@ extern int SMB2_set_info_init(struct cifs_tcon *tcon,
 extern void SMB2_set_info_free(struct smb_rqst *rqst);
 extern int SMB2_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
 			u64 persistent_fid, u64 volatile_fid,
-			struct cifs_ntsd *pnntsd, int pacllen, int aclflag);
+			struct smb_ntsd *pnntsd, int pacllen, int aclflag);
 extern int SMB2_set_ea(const unsigned int xid, struct cifs_tcon *tcon,
 		       u64 persistent_fid, u64 volatile_fid,
 		       struct smb2_file_full_ea_info *buf, int len);
diff --git a/fs/smb/client/xattr.c b/fs/smb/client/xattr.c
index c2bf829310be..e8696ad4da99 100644
--- a/fs/smb/client/xattr.c
+++ b/fs/smb/client/xattr.c
@@ -162,7 +162,7 @@ static int cifs_xattr_set(const struct xattr_handler *handler,
 	case XATTR_CIFS_ACL:
 	case XATTR_CIFS_NTSD:
 	case XATTR_CIFS_NTSD_FULL: {
-		struct cifs_ntsd *pacl;
+		struct smb_ntsd *pacl;
 
 		if (!value)
 			goto out;
@@ -315,7 +315,7 @@ static int cifs_xattr_get(const struct xattr_handler *handler,
 		 * fetch owner and DACL otherwise
 		 */
 		u32 acllen, extra_info;
-		struct cifs_ntsd *pacl;
+		struct smb_ntsd *pacl;
 
 		if (pTcon->ses->server->ops->get_acl == NULL)
 			goto out; /* rc already EOPNOTSUPP */
-- 
2.39.5




