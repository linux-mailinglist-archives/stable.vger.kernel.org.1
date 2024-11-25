Return-Path: <stable+bounces-95400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 183249D890D
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 16:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE066161D9E
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D35E1B3936;
	Mon, 25 Nov 2024 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cy3QPsMb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4C31AF0B6
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548045; cv=none; b=cZiH71B/X4xfPIbjRitkPOTLeV5pgXDuqSrkoCcBipgM6eTfh044NNRHmfgZ4Hq9EociT+9BICd8lITTeebP/rp/obTsyfy0W8CCEfXryt7jpKqunSYo09P2i9m5W4CAE73eNQiMbG4JlTsi1V+F0DzNA1FylrZcsLHTrsvh5TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548045; c=relaxed/simple;
	bh=7cLTzp6j3kHptf+Cl8EEBnVy+okByfZVzMz1Bk/O4nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIXMxJG4E1XhcYwzOrC0tG4pzdwJM9ttnVwLHOnaIKLjnylONbbAsEhe43Q0xPH6HMR3Pzkcp3FAhUk6esK1ZOyvVGR2hT008R5xob+WQz3B+81LRfb2jx711z65AcZVRbVNTGyQtUfAd12MZgK9ajm9eYEl1Z4gPJRtt/Ia/LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cy3QPsMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93218C4CECE;
	Mon, 25 Nov 2024 15:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732548045;
	bh=7cLTzp6j3kHptf+Cl8EEBnVy+okByfZVzMz1Bk/O4nY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cy3QPsMbWqjITzA2XEgxpDpBtlE7PXCyRMknmm1C7S8o7XE34N68VYVgXpc47ydMG
	 SUnnu0GWHa0WylfIKVazytiSa0kTTJyGRXIaI6PyJQDiVumyXtG+zFGeiFq9BzA6fK
	 VfWCk7uE0fmjakauHPKK/qYretYSIuR79D8h21f5W8ZqLaqd9KVYzB6En6qsYxXc56
	 Wb5LVuKirv3tWtbybHUq5EEAnvyJDmVVs2ZRAr2+HjYnjK21yI58MIFHhtdEHD9YLt
	 TvpLc7DjQ2c+CCIc3TSERFkI+91+YD8qhCaWAdGRorelfcou82KSbh2GyYHExXTvKN
	 2U7+/rjsEi3YQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mahmoud Adam <mngyadam@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.1] cifs: Fix buffer overflow when parsing NFS reparse points
Date: Mon, 25 Nov 2024 10:20:43 -0500
Message-ID: <20241125083325-c8ba1de6dab8bc53@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241125084801.83439-1-mngyadam@amazon.com>
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

Note: The patch differs from the upstream commit:
---
--- -	2024-11-25 08:29:51.938406404 -0500
+++ /tmp/tmp.ZDtVEXXRHN	2024-11-25 08:29:51.928317283 -0500
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
+https://lore.kernel.org/stable/Z0Pd9slDKJNM0n3T@ca93ea81d97d/T/#m8cdb746a2527f2c27c95c9b2b25b5cc8f20ce74a
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
| stable/linux-6.1.y        |  Success    |  Success   |

