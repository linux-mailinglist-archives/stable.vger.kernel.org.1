Return-Path: <stable+bounces-94634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859789D648F
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 20:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F758B2223F
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 19:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F06D1DF972;
	Fri, 22 Nov 2024 19:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptzVirLR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CED264A8F
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732303587; cv=none; b=WshtafJ65f4PH9j6zhvdBLTwCbMh6nzGzg55S4ls0ygq1wMnCYAvbjrHMQMHqJdXTMc3//+0URHQ50587YPOX+AAIxROIyM6vDUk/O9k3EbeTfvW1gBOM0yGmAS8iPMeZ0FOguvGkoo8IknbGngknj/EnPs8bcOTyEmah9b1ecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732303587; c=relaxed/simple;
	bh=feduIjuhQgRBbHdz+xnmAKsLuukgIzLs2wawcIbNeJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VyHftvQhTgt1/zrmhCfl6C0zor+8KhfnFh9NY5yGa/DMOntoIZieaYgJcXPEFzb3caUUWkqQ+BhG9cXd5XUtvoJ3w4SXqvS5h+sV9NKL/UfirhClLPlSPx7UkoOncwStjlCgEKETa644p8ExQUNbDrhn6JYiDAoXYB2n5XfC/EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptzVirLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3A8C4CECE;
	Fri, 22 Nov 2024 19:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732303585;
	bh=feduIjuhQgRBbHdz+xnmAKsLuukgIzLs2wawcIbNeJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ptzVirLRTonJ0BPECagJZO/54eIBnQrOpWbHdBwDi30zpJU7aTXSMqaj/F0m7kC4t
	 0ZgdGgSxsbFbvCCpKUNIA9TbSpAI6kjSQUAszmMOFQijjEGGgua1/GinpCqhbzY+ti
	 5pX4T/nXqygRrZYXcv2NTjPPYdsrhNp3t1rEaVgzHu2jj6gFtcI3W2Oq5ZHlMS+N70
	 7JjkUTDthThyKNIxg42e1QI6eQ32SgGDt6iHtv5VKWBcg1eVUiy3yOjXlzSPr5Oc7b
	 KHymJ6EPO1wWa/CBthV0Grq7767GCg/WCw5v71KJOR83FiOJUPZf+quJ9hKqykFwuf
	 8OvrSDtkwp3Nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mahmoud Adam <mngyadam@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4/5.10/5.15] cifs: Fix buffer overflow when parsing NFS reparse points
Date: Fri, 22 Nov 2024 14:26:23 -0500
Message-ID: <20241122125348-1a37cb03c30264bf@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241122152943.76044-1-mngyadam@amazon.com>
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
6.11.y | Present (different SHA1: c173d47b69f0)
6.6.y | Present (different SHA1: c6db81c550ce)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-22 12:31:36.852804062 -0500
+++ /tmp/tmp.ZKhxfvejkU	2024-11-22 12:31:36.843027135 -0500
@@ -1,3 +1,5 @@
+upstream e2a8910af01653c1c268984855629d71fb81f404 commit.
+
 ReparseDataLength is sum of the InodeType size and DataBuffer size.
 So to get DataBuffer size it is needed to subtract InodeType's size from
 ReparseDataLength.
@@ -18,48 +20,31 @@
 Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
 Signed-off-by: Pali Rohár <pali@kernel.org>
 Signed-off-by: Steve French <stfrench@microsoft.com>
+[use variable name symlink_buf, the other buf->InodeType accesses are
+not used in current version so skip]
+Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
 ---
- fs/smb/client/reparse.c | 15 ++++++++++++++-
- 1 file changed, 14 insertions(+), 1 deletion(-)
+This fixes CVE-2024-49996.
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
+index 6c30fff8a029e..ee9a1e6550e3c 100644
+--- a/fs/cifs/smb2ops.c
++++ b/fs/cifs/smb2ops.c
+@@ -2971,6 +2971,12 @@ parse_reparse_posix(struct reparse_posix_data *symlink_buf,
  
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

