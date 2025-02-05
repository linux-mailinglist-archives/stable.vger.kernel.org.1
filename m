Return-Path: <stable+bounces-113720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB90A293DB
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0923B1892311
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894E8165F16;
	Wed,  5 Feb 2025 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2XdWmUue"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463601684B0;
	Wed,  5 Feb 2025 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767931; cv=none; b=Txp7y3MoWpkGjM+5A+tVZO8Kr3lEi2nwQ5MQDVz6yKBfTKn1Gt/rv2NC5ttG2YW5I5kMzsl3NoozeDZs2tKVWZtoGru3+NUFdVCaTYOE5kJzefFRcdU2Mu5Tet5JsyuRz4qb0JylOxou8VG1Or11bSxbiO6aJ3qaixnatR4hZKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767931; c=relaxed/simple;
	bh=iRDnozzzP2K2hAZic5USh3G/A/hV/wEUYBwHoWGJCss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8QfvbRvxbEeB1SxtfVm0PAILUIIVNCibb9cQ/Esz5Iy0+LRPiSe588dy+AI9L8pCCN3AIxvWSr6zvmGg9/KpyDy3GFS4VeYFk7vCKDatAR7ifqt7tDSOkYlikb1wY7q7KrQo5jk8GmogJnU3R9FW1v5TV6A2U/5O6AXFOsOa3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2XdWmUue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69127C4CED1;
	Wed,  5 Feb 2025 15:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738767930;
	bh=iRDnozzzP2K2hAZic5USh3G/A/hV/wEUYBwHoWGJCss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2XdWmUuer8C8ryqyq9YyjkgdlLxrr80crXzjKbeOngaTo0AbY+FSBdHtTvqg/Ir1E
	 AmMn0k+75uCRR2RQx+cz9Df5vOu5D4b16u0hwmAe7ZtkPxO+N2ERcwoAn9FcCConDd
	 k3+Ce02/z9kWBDf16s0SRcUavbe54wVK7wc8yzPQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 531/590] cifs: Fix getting and setting SACLs over SMB1
Date: Wed,  5 Feb 2025 14:44:46 +0100
Message-ID: <20250205134515.582341120@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pali Rohár <pali@kernel.org>

[ Upstream commit 8b19dfb34d17e77a0809d433cc128b779282131b ]

SMB1 callback get_cifs_acl_by_fid() currently ignores its last argument and
therefore ignores request for SACL_SECINFO. Fix this issue by correctly
propagating info argument from get_cifs_acl() and get_cifs_acl_by_fid() to
CIFSSMBGetCIFSACL() function and pass SACL_SECINFO when requested.

For accessing SACLs it is needed to open object with SYSTEM_SECURITY
access. Pass this flag when trying to get or set SACLs.

Same logic is in the SMB2+ code path.

This change fixes getting and setting of "system.cifs_ntsd_full" and
"system.smb3_ntsd_full" xattrs over SMB1 as currently it silentely ignored
SACL part of passed xattr buffer.

Fixes: 3970acf7ddb9 ("SMB3: Add support for getting and setting SACLs")
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsacl.c   | 25 +++++++++++++++----------
 fs/smb/client/cifsproto.h |  2 +-
 fs/smb/client/cifssmb.c   |  4 ++--
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index c68ad526a4de1..ebe9a7d7c70e8 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1395,7 +1395,7 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 struct smb_ntsd *get_cifs_acl_by_fid(struct cifs_sb_info *cifs_sb,
 				      const struct cifs_fid *cifsfid, u32 *pacllen,
-				      u32 __maybe_unused unused)
+				      u32 info)
 {
 	struct smb_ntsd *pntsd = NULL;
 	unsigned int xid;
@@ -1407,7 +1407,7 @@ struct smb_ntsd *get_cifs_acl_by_fid(struct cifs_sb_info *cifs_sb,
 
 	xid = get_xid();
 	rc = CIFSSMBGetCIFSACL(xid, tlink_tcon(tlink), cifsfid->netfid, &pntsd,
-				pacllen);
+				pacllen, info);
 	free_xid(xid);
 
 	cifs_put_tlink(tlink);
@@ -1419,7 +1419,7 @@ struct smb_ntsd *get_cifs_acl_by_fid(struct cifs_sb_info *cifs_sb,
 }
 
 static struct smb_ntsd *get_cifs_acl_by_path(struct cifs_sb_info *cifs_sb,
-		const char *path, u32 *pacllen)
+		const char *path, u32 *pacllen, u32 info)
 {
 	struct smb_ntsd *pntsd = NULL;
 	int oplock = 0;
@@ -1446,9 +1446,12 @@ static struct smb_ntsd *get_cifs_acl_by_path(struct cifs_sb_info *cifs_sb,
 		.fid = &fid,
 	};
 
+	if (info & SACL_SECINFO)
+		oparms.desired_access |= SYSTEM_SECURITY;
+
 	rc = CIFS_open(xid, &oparms, &oplock, NULL);
 	if (!rc) {
-		rc = CIFSSMBGetCIFSACL(xid, tcon, fid.netfid, &pntsd, pacllen);
+		rc = CIFSSMBGetCIFSACL(xid, tcon, fid.netfid, &pntsd, pacllen, info);
 		CIFSSMBClose(xid, tcon, fid.netfid);
 	}
 
@@ -1472,7 +1475,7 @@ struct smb_ntsd *get_cifs_acl(struct cifs_sb_info *cifs_sb,
 	if (inode)
 		open_file = find_readable_file(CIFS_I(inode), true);
 	if (!open_file)
-		return get_cifs_acl_by_path(cifs_sb, path, pacllen);
+		return get_cifs_acl_by_path(cifs_sb, path, pacllen, info);
 
 	pntsd = get_cifs_acl_by_fid(cifs_sb, &open_file->fid, pacllen, info);
 	cifsFileInfo_put(open_file);
@@ -1485,7 +1488,7 @@ int set_cifs_acl(struct smb_ntsd *pnntsd, __u32 acllen,
 {
 	int oplock = 0;
 	unsigned int xid;
-	int rc, access_flags;
+	int rc, access_flags = 0;
 	struct cifs_tcon *tcon;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct tcon_link *tlink = cifs_sb_tlink(cifs_sb);
@@ -1498,10 +1501,12 @@ int set_cifs_acl(struct smb_ntsd *pnntsd, __u32 acllen,
 	tcon = tlink_tcon(tlink);
 	xid = get_xid();
 
-	if (aclflag == CIFS_ACL_OWNER || aclflag == CIFS_ACL_GROUP)
-		access_flags = WRITE_OWNER;
-	else
-		access_flags = WRITE_DAC;
+	if (aclflag & CIFS_ACL_OWNER || aclflag & CIFS_ACL_GROUP)
+		access_flags |= WRITE_OWNER;
+	if (aclflag & CIFS_ACL_SACL)
+		access_flags |= SYSTEM_SECURITY;
+	if (aclflag & CIFS_ACL_DACL)
+		access_flags |= WRITE_DAC;
 
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index a697e53ccee2b..907af3cbffd1b 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -568,7 +568,7 @@ extern int CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
 		const struct nls_table *nls_codepage,
 		struct cifs_sb_info *cifs_sb);
 extern int CIFSSMBGetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon,
-			__u16 fid, struct smb_ntsd **acl_inf, __u32 *buflen);
+			__u16 fid, struct smb_ntsd **acl_inf, __u32 *buflen, __u32 info);
 extern int CIFSSMBSetCIFSACL(const unsigned int, struct cifs_tcon *, __u16,
 			struct smb_ntsd *pntsd, __u32 len, int aclflag);
 extern int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 0eae60731c20c..e2a14e25da87c 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3427,7 +3427,7 @@ validate_ntransact(char *buf, char **ppparm, char **ppdata,
 /* Get Security Descriptor (by handle) from remote server for a file or dir */
 int
 CIFSSMBGetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon, __u16 fid,
-		  struct smb_ntsd **acl_inf, __u32 *pbuflen)
+		  struct smb_ntsd **acl_inf, __u32 *pbuflen, __u32 info)
 {
 	int rc = 0;
 	int buf_type = 0;
@@ -3450,7 +3450,7 @@ CIFSSMBGetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon, __u16 fid,
 	pSMB->MaxSetupCount = 0;
 	pSMB->Fid = fid; /* file handle always le */
 	pSMB->AclFlags = cpu_to_le32(CIFS_ACL_OWNER | CIFS_ACL_GROUP |
-				     CIFS_ACL_DACL);
+				     CIFS_ACL_DACL | info);
 	pSMB->ByteCount = cpu_to_le16(11); /* 3 bytes pad + 8 bytes parm */
 	inc_rfc1001_len(pSMB, 11);
 	iov[0].iov_base = (char *)pSMB;
-- 
2.39.5




