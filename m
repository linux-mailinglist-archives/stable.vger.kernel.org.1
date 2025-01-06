Return-Path: <stable+bounces-106956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42565A02981
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D743A5493
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E25A1DDC08;
	Mon,  6 Jan 2025 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pSYlFNtF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB410157E82;
	Mon,  6 Jan 2025 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177021; cv=none; b=SmBu0pqsN0s7u5hK7k3fpHCFfcPZfmq/sWkNTwyKK0MZTwA0srWpfXcaEX6t2wlDy7KtLWZK6QeobKCZGGl/3w0YnoTwcMzUUt09FqIdnph3izDFlIR12MNRqQVNOLf3zuM6E1jyXHGToP0dttKUdqaqjw+u6DkWn8v9ZHGtxj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177021; c=relaxed/simple;
	bh=SYirU+49SZ1cMVsNY680T4iwmZnbgcKwuYbpG/wHiJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GV7Q43y7WYkFBIkMudRh41jPl51bb6fsTVM2kxlJyP7PVdHLR8GzRYiXMvDpPqV69fwg0c9h9wzVaJ0eUpeSViyGcuupIQuZyn877kI7tJMqft34MG5J9MrF6UxszKKxbr5vavwE28pWZqgix3NmBAD9Mh2YqPmlz98Hzlbh4bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pSYlFNtF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D233C4CED6;
	Mon,  6 Jan 2025 15:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736177020;
	bh=SYirU+49SZ1cMVsNY680T4iwmZnbgcKwuYbpG/wHiJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pSYlFNtFRTc5pwQYvoN+HwFADiWHV9Si3Amk2HvpPT40TYLhtLK5LTpNB6k0CWRL4
	 iTdMEvN21T0YUHAURCKDhizmVzkYIk8UrG1woUdWEdtNoz3QdL3zpqwcMeVNitNNqh
	 oZjdc3uiK9gHVwtKaen2bASCeAbKUE6qs7PE/tXU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 007/222] smb/client: rename cifs_acl to smb_acl
Date: Mon,  6 Jan 2025 16:13:31 +0100
Message-ID: <20250106151150.874585132@linuxfoundation.org>
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

[ Upstream commit 251b93ae73805b216e84ed2190b525f319da4c87 ]

Preparation for moving acl definitions to new common header file.

Use the following shell command to rename:

  find fs/smb/client -type f -exec sed -i \
    's/struct cifs_acl/struct smb_acl/g' {} +

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: d413eabff18d ("fs/smb/client: implement chmod() for SMB3 POSIX Extensions")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsacl.c | 34 +++++++++++++++++-----------------
 fs/smb/client/cifsacl.h |  4 ++--
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index dd399f9a7424..2e1c9b528dde 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -758,7 +758,7 @@ static void dump_ace(struct cifs_ace *pace, char *end_of_acl)
 }
 #endif
 
-static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
+static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 		       struct smb_sid *pownersid, struct smb_sid *pgrpsid,
 		       struct cifs_fattr *fattr, bool mode_from_special_sid)
 {
@@ -793,7 +793,7 @@ static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
 	fattr->cf_mode &= ~(0777);
 
 	acl_base = (char *)pdacl;
-	acl_size = sizeof(struct cifs_acl);
+	acl_size = sizeof(struct smb_acl);
 
 	num_aces = le32_to_cpu(pdacl->num_aces);
 	if (num_aces > 0) {
@@ -1034,7 +1034,7 @@ static void populate_new_aces(char *nacl_base,
 	*pnsize = nsize;
 }
 
-static __u16 replace_sids_and_copy_aces(struct cifs_acl *pdacl, struct cifs_acl *pndacl,
+static __u16 replace_sids_and_copy_aces(struct smb_acl *pdacl, struct smb_acl *pndacl,
 		struct smb_sid *pownersid, struct smb_sid *pgrpsid,
 		struct smb_sid *pnownersid, struct smb_sid *pngrpsid)
 {
@@ -1049,11 +1049,11 @@ static __u16 replace_sids_and_copy_aces(struct cifs_acl *pdacl, struct cifs_acl
 	u16 ace_size = 0;
 
 	acl_base = (char *)pdacl;
-	size = sizeof(struct cifs_acl);
+	size = sizeof(struct smb_acl);
 	src_num_aces = le32_to_cpu(pdacl->num_aces);
 
 	nacl_base = (char *)pndacl;
-	nsize = sizeof(struct cifs_acl);
+	nsize = sizeof(struct smb_acl);
 
 	/* Go through all the ACEs */
 	for (i = 0; i < src_num_aces; ++i) {
@@ -1074,7 +1074,7 @@ static __u16 replace_sids_and_copy_aces(struct cifs_acl *pdacl, struct cifs_acl
 	return nsize;
 }
 
-static int set_chmod_dacl(struct cifs_acl *pdacl, struct cifs_acl *pndacl,
+static int set_chmod_dacl(struct smb_acl *pdacl, struct smb_acl *pndacl,
 		struct smb_sid *pownersid,	struct smb_sid *pgrpsid,
 		__u64 *pnmode, bool mode_from_sid)
 {
@@ -1091,7 +1091,7 @@ static int set_chmod_dacl(struct cifs_acl *pdacl, struct cifs_acl *pndacl,
 
 	/* Assuming that pndacl and pnmode are never NULL */
 	nacl_base = (char *)pndacl;
-	nsize = sizeof(struct cifs_acl);
+	nsize = sizeof(struct smb_acl);
 
 	/* If pdacl is NULL, we don't have a src. Simply populate new ACL. */
 	if (!pdacl) {
@@ -1103,7 +1103,7 @@ static int set_chmod_dacl(struct cifs_acl *pdacl, struct cifs_acl *pndacl,
 	}
 
 	acl_base = (char *)pdacl;
-	size = sizeof(struct cifs_acl);
+	size = sizeof(struct smb_acl);
 	src_num_aces = le32_to_cpu(pdacl->num_aces);
 
 	/* Retain old ACEs which we can retain */
@@ -1196,7 +1196,7 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 {
 	int rc = 0;
 	struct smb_sid *owner_sid_ptr, *group_sid_ptr;
-	struct cifs_acl *dacl_ptr; /* no need for SACL ptr */
+	struct smb_acl *dacl_ptr; /* no need for SACL ptr */
 	char *end_of_acl = ((char *)pntsd) + acl_len;
 	__u32 dacloffset;
 
@@ -1208,7 +1208,7 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 	group_sid_ptr = (struct smb_sid *)((char *)pntsd +
 				le32_to_cpu(pntsd->gsidoffset));
 	dacloffset = le32_to_cpu(pntsd->dacloffset);
-	dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
+	dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 	cifs_dbg(NOISY, "revision %d type 0x%x ooffset 0x%x goffset 0x%x sacloffset 0x%x dacloffset 0x%x\n",
 		 pntsd->revision, pntsd->type, le32_to_cpu(pntsd->osidoffset),
 		 le32_to_cpu(pntsd->gsidoffset),
@@ -1259,14 +1259,14 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 	__u32 sidsoffset;
 	struct smb_sid *owner_sid_ptr, *group_sid_ptr;
 	struct smb_sid *nowner_sid_ptr = NULL, *ngroup_sid_ptr = NULL;
-	struct cifs_acl *dacl_ptr = NULL;  /* no need for SACL ptr */
-	struct cifs_acl *ndacl_ptr = NULL; /* no need for SACL ptr */
+	struct smb_acl *dacl_ptr = NULL;  /* no need for SACL ptr */
+	struct smb_acl *ndacl_ptr = NULL; /* no need for SACL ptr */
 	char *end_of_acl = ((char *)pntsd) + secdesclen;
 	u16 size = 0;
 
 	dacloffset = le32_to_cpu(pntsd->dacloffset);
 	if (dacloffset) {
-		dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
+		dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 		if (end_of_acl < (char *)dacl_ptr + le16_to_cpu(dacl_ptr->size)) {
 			cifs_dbg(VFS, "Server returned illegal ACL size\n");
 			return -EINVAL;
@@ -1280,7 +1280,7 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 
 	if (pnmode && *pnmode != NO_CHANGE_64) { /* chmod */
 		ndacloffset = sizeof(struct smb_ntsd);
-		ndacl_ptr = (struct cifs_acl *)((char *)pnntsd + ndacloffset);
+		ndacl_ptr = (struct smb_acl *)((char *)pnntsd + ndacloffset);
 		ndacl_ptr->revision =
 			dacloffset ? dacl_ptr->revision : cpu_to_le16(ACL_REVISION);
 
@@ -1298,7 +1298,7 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 		*aclflag |= CIFS_ACL_DACL;
 	} else {
 		ndacloffset = sizeof(struct smb_ntsd);
-		ndacl_ptr = (struct cifs_acl *)((char *)pnntsd + ndacloffset);
+		ndacl_ptr = (struct smb_acl *)((char *)pnntsd + ndacloffset);
 		ndacl_ptr->revision =
 			dacloffset ? dacl_ptr->revision : cpu_to_le16(ACL_REVISION);
 		ndacl_ptr->num_aces = dacl_ptr ? dacl_ptr->num_aces : 0;
@@ -1580,7 +1580,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 	__u32 secdesclen = 0;
 	__u32 nsecdesclen = 0;
 	__u32 dacloffset = 0;
-	struct cifs_acl *dacl_ptr = NULL;
+	struct smb_acl *dacl_ptr = NULL;
 	struct smb_ntsd *pntsd = NULL; /* acl obtained from server */
 	struct smb_ntsd *pnntsd = NULL; /* modified acl to be sent to server */
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
@@ -1633,7 +1633,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 		nsecdesclen = sizeof(struct smb_ntsd) + (sizeof(struct smb_sid) * 2);
 		dacloffset = le32_to_cpu(pntsd->dacloffset);
 		if (dacloffset) {
-			dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
+			dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 			if (mode_from_sid)
 				nsecdesclen +=
 					le32_to_cpu(dacl_ptr->num_aces) * sizeof(struct cifs_ace);
diff --git a/fs/smb/client/cifsacl.h b/fs/smb/client/cifsacl.h
index 6a38718220fc..a23d59987828 100644
--- a/fs/smb/client/cifsacl.h
+++ b/fs/smb/client/cifsacl.h
@@ -34,7 +34,7 @@
  * owner, group and world).
  */
 #define DEFAULT_SEC_DESC_LEN (sizeof(struct smb_ntsd) + \
-			      sizeof(struct cifs_acl) + \
+			      sizeof(struct smb_acl) + \
 			      (sizeof(struct cifs_ace) * 4))
 
 /*
@@ -74,7 +74,7 @@ struct smb_sid {
 /* size of a struct smb_sid, sans sub_auth array */
 #define CIFS_SID_BASE_SIZE (1 + 1 + NUM_AUTHS)
 
-struct cifs_acl {
+struct smb_acl {
 	__le16 revision; /* revision level */
 	__le16 size;
 	__le32 num_aces;
-- 
2.39.5




