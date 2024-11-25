Return-Path: <stable+bounces-95403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8399D8910
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 16:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45292866F7
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AF91AF0B6;
	Mon, 25 Nov 2024 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Npvem3Pj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5510A1A0AF0
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548051; cv=none; b=MMpIf6QeLHU+Ql20y3d5IbvqXvPI4t1CFRIDkoh8cJt35n66zw5EKIsVUxuqNBI4+k+aSPTa0WEVSbZ8AMISLN+PoiEyjv6/hCzeHDvpwxRVtHqsLLqrE2hgQFV2C24/ZH+Cxn535Bb6P+mKjD8dmvjU66o5JcWv4u8lCyZEkoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548051; c=relaxed/simple;
	bh=gBEvD9IYsQuoHSWZQwB11PY4BEDXjLiwiXo95hi3dpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mk/HH3Wbdp6tNt9TBetQJDG7kAA2RehE38SEW2Yq3YKz5UUdx4mttnVOYoRmB8Sg6oE+SsU/2uL6ZAxA1sudp+Ie4b6T9OoAVZejd6ozRHjiiiXvJiZHO6Z0w0SqPGQO5w6ywg45398EGrNlRb4ijdxk52wnzZtP/HgOmWPZvdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Npvem3Pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0101C4CECE;
	Mon, 25 Nov 2024 15:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732548051;
	bh=gBEvD9IYsQuoHSWZQwB11PY4BEDXjLiwiXo95hi3dpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Npvem3PjyBYBYwbrXCwpYjtAcp/FoHuqy91pxLmmqWs7Rvrut6nYaDbqrdAjTkeW8
	 17jy9/y8TcPHOlnQU5zTqnGecnw2UbyrjsGnDUZbiHCnnqr2TjGvH3R0qcIcuvXoGm
	 dYBsbx0e8ULbpsBfuLMQoBUInI4lPmPAv2gvKtT2Fsi6u5VpWbyncNEPV5sq5L2yot
	 V+8wfaEPcdtyFPkMznxCDKzYA69GYN8IDUPEENtfpnlrBRufhOrpud/emdGg2JtCLW
	 7xpKPMcOfarWe7+wxy16zDZDtVcgkVvgllW4fHF2VQVwNmvDa3cRUWOaRhjZK2WLJx
	 HS3LhJZvi8TOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mahmoud Adam <mngyadam@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 5.4/5.10/5.15] cifs: Fix buffer overflow when parsing NFS reparse points
Date: Mon, 25 Nov 2024 10:20:49 -0500
Message-ID: <20241125085122-34d77d74a23c624e@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241125083746.74543-1-mngyadam@amazon.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: e2a8910af01653c1c268984855629d71fb81f404

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mahmoud Adam <mngyadam@amazon.com>
Commit author: Pali Rohár <pali@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: c173d47b69f0)
6.6.y | Present (different SHA1: c6db81c550ce)
6.1.y | Present (different SHA1: 08461ff8be1c)
5.15.y | Present (different SHA1: 6bddea684ef2)

Note: The patch differs from the upstream commit:
---
--- -	2024-11-25 08:41:08.697150675 -0500
+++ /tmp/tmp.5TBHo3EDHj	2024-11-25 08:41:08.686554930 -0500
@@ -1,3 +1,5 @@
+commit e2a8910af01653c1c268984855629d71fb81f404 upstream.
+
 ReparseDataLength is sum of the InodeType size and DataBuffer size.
 So to get DataBuffer size it is needed to subtract InodeType's size from
 ReparseDataLength.
@@ -18,48 +20,32 @@
 Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
 Signed-off-by: Pali Rohár <pali@kernel.org>
 Signed-off-by: Steve French <stfrench@microsoft.com>
+[use variable name symlink_buf, the other buf->InodeType accesses are
+not used in current version so skip]
+Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
 ---
- fs/smb/client/reparse.c | 15 ++++++++++++++-
- 1 file changed, 14 insertions(+), 1 deletion(-)
+v2: fix upstream format.
+https://lore.kernel.org/stable/20241122152943.76044-1-mngyadam@amazon.com/
+ fs/cifs/smb2ops.c | 6 ++++++
+ 1 file changed, 6 insertions(+)
 
-diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
-index 3b48a093cfb1f..8ea7a848aa393 100644
---- a/fs/smb/client/reparse.c
-+++ b/fs/smb/client/reparse.c
-@@ -320,9 +320,16 @@ static int parse_reparse_posix(struct reparse_posix_data *buf,
- 	unsigned int len;
- 	u64 type;
+diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
+index 9ec67b76bc062..4f7639afa7627 100644
+--- a/fs/cifs/smb2ops.c
++++ b/fs/cifs/smb2ops.c
+@@ -2807,6 +2807,12 @@ parse_reparse_posix(struct reparse_posix_data *symlink_buf,
  
-+	len = le16_to_cpu(buf->ReparseDataLength);
-+	if (len < sizeof(buf->InodeType)) {
+ 	/* See MS-FSCC 2.1.2.6 for the 'NFS' style reparse tags */
+ 	len = le16_to_cpu(symlink_buf->ReparseDataLength);
++	if (len < sizeof(symlink_buf->InodeType)) {
 +		cifs_dbg(VFS, "srv returned malformed nfs buffer\n");
 +		return -EIO;
 +	}
 +
-+	len -= sizeof(buf->InodeType);
-+
- 	switch ((type = le64_to_cpu(buf->InodeType))) {
- 	case NFS_SPECFILE_LNK:
--		len = le16_to_cpu(buf->ReparseDataLength);
- 		data->symlink_target = cifs_strndup_from_utf16(buf->DataBuffer,
- 							       len, true,
- 							       cifs_sb->local_nls);
-@@ -482,12 +489,18 @@ bool cifs_reparse_point_to_fattr(struct cifs_sb_info *cifs_sb,
- 	u32 tag = data->reparse.tag;
++	len -= sizeof(symlink_buf->InodeType);
  
- 	if (tag == IO_REPARSE_TAG_NFS && buf) {
-+		if (le16_to_cpu(buf->ReparseDataLength) < sizeof(buf->InodeType))
-+			return false;
- 		switch (le64_to_cpu(buf->InodeType)) {
- 		case NFS_SPECFILE_CHR:
-+			if (le16_to_cpu(buf->ReparseDataLength) != sizeof(buf->InodeType) + 8)
-+				return false;
- 			fattr->cf_mode |= S_IFCHR;
- 			fattr->cf_rdev = reparse_mkdev(buf->DataBuffer);
- 			break;
- 		case NFS_SPECFILE_BLK:
-+			if (le16_to_cpu(buf->ReparseDataLength) != sizeof(buf->InodeType) + 8)
-+				return false;
- 			fattr->cf_mode |= S_IFBLK;
- 			fattr->cf_rdev = reparse_mkdev(buf->DataBuffer);
- 			break;
+ 	if (le64_to_cpu(symlink_buf->InodeType) != NFS_SPECFILE_LNK) {
+ 		cifs_dbg(VFS, "%lld not a supported symlink type\n",
+-- 
+2.40.1
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

