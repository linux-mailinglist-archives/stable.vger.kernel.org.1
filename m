Return-Path: <stable+bounces-94622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E43889D60EB
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 15:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5741F28433D
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19434137772;
	Fri, 22 Nov 2024 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yi7W27J5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA0D2D05E
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287362; cv=none; b=KNQ4q4vcNFO7SvWuT4lQhcAuMCEjDzNemtz6IyTILpQkfTwSYh/lNjIlyMzdT1kgoh4+vqr9phAXkftdaJCN8CNN8noSdsdYcSDEF6SLMAB6NqAA7aX+aLLe/5iyt1bVRXiTUTygEY/rn8Ayi/YkysOFbxBSrnad/PyF6eeb8MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287362; c=relaxed/simple;
	bh=LARv/bRrvd17av6Y+FbbZmSLxlsfSRo1ocSHX+9mZwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YpsBRKj2OGqp82YfdR9ctp81B+QedZjZvMII4Un4rp27OUEHfAbJmCGyRzZtDTTubrZBhawCLEfkC/r6/Ti7SuvgboPBHcp0dqbcJU8TyrcMPgFjenxbqbdGlwMEs5F7JV8EB9VK/CT4cu18wUx/+ekM7JQhnYI7KUkIuw6qNU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yi7W27J5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226BEC4CECF;
	Fri, 22 Nov 2024 14:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732287362;
	bh=LARv/bRrvd17av6Y+FbbZmSLxlsfSRo1ocSHX+9mZwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yi7W27J5K7+yhxSVi5SGGJ7UpfOlbDYCfXRc6iW4sUNzhknR5VaEzMD6p+nUnb58d
	 4o9LKo/vSZkBXWBJC1BzCU3a1aSGekinTAtL5lLp4hYUlnEAUAOf3AzDNw4zr2mbQB
	 FoR9KIClwZdtnfwuQptg837049M7Ad1JQvrBy5bJfSGfTiKgmOKzoUvphOPvk5hnO/
	 /Zz2AFRRbk/4Ko7vIU2aOWDmAMbxHR+uLX5Bxu3nf9nx9gou8GIqYqlVCE4OB3JT4v
	 R0/td5EVFJIstdwAr14C7UzVuNU/0TmgqlywtcV/wmjSZ/TH3v/1Og/rpGylLixB5J
	 cDV109pzOYuxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mahmoud Adam <mngyadam@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] cifs: Fix buffer overflow when parsing NFS reparse points
Date: Fri, 22 Nov 2024 09:56:00 -0500
Message-ID: <20241122095529-423c0f305d9962cd@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241122134410.124563-1-mngyadam@amazon.com>
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

Found matching upstream commit: e2a8910af01653c1c268984855629d71fb81f404

WARNING: Author mismatch between patch and found commit:
Backport author: Mahmoud Adam <mngyadam@amazon.com>
Commit author: Pali Rohár <pali@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
--- -	2024-11-22 09:47:45.236983679 -0500
+++ /tmp/tmp.lZ1aBV8tvg	2024-11-22 09:47:45.226445426 -0500
@@ -1,3 +1,5 @@
+upstream e2a8910af01653c1c268984855629d71fb81f404 commit.
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
+This fixes CVE-2024-49996, and applies cleanly on 5.4->6.1, 6.6 and
+later already has the fix.
+ fs/smb/client/smb2ops.c | 6 ++++++
+ 1 file changed, 6 insertions(+)
 
-diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
-index 3b48a093cfb1f..8ea7a848aa393 100644
---- a/fs/smb/client/reparse.c
-+++ b/fs/smb/client/reparse.c
-@@ -320,9 +320,16 @@ static int parse_reparse_posix(struct reparse_posix_data *buf,
- 	unsigned int len;
- 	u64 type;
+diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
+index d1e5ff9a3cd39..fcfbc096924a8 100644
+--- a/fs/smb/client/smb2ops.c
++++ b/fs/smb/client/smb2ops.c
+@@ -2897,6 +2897,12 @@ parse_reparse_posix(struct reparse_posix_data *symlink_buf,
  
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
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.11.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |
| stable/linux-4.19.y       |  Failed     |  N/A       |

