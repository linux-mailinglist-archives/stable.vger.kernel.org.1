Return-Path: <stable+bounces-207990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B409CD0E02B
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 01:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B67F301C3ED
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 00:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB1713635E;
	Sun, 11 Jan 2026 00:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a4+50NZ3"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6C2611E
	for <stable@vger.kernel.org>; Sun, 11 Jan 2026 00:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768091877; cv=none; b=uzynAFVVNj3m7FMwrT4q5IOI3SFNvEJS+EGFCUAnUJXEaObRnSDuaHOlzcffhinaA7ptnvwFDZ3LpHTD9qgTQUZahQ3v7kDoWv+mmhhl5EhomqTYXWzp9NZ98Z0QjX7tdr1CYbJ3fSA9HBL6skY39JwpRMSYwkgsP4wkJZTjV34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768091877; c=relaxed/simple;
	bh=KDJYQlHRr9lMKGs53yBP/+oTu5HcUz2nH326y2u4wkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yiekzu7tuw1DOpZQQlaks2sUdgtNqRwsAZPcdFHcJPtYgXJkrqGIX88YxNTSf9xDfM6e7zAJka/Lk1V0CEVitKqOhYL2oTDBVsjT953JLOc97gw/S7+BiFG64U4e1fGZ2bwR+DYgFrRfUigdpDvQQZcgZOFrRy4C+iV855VrPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a4+50NZ3; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768091873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+olqRexjNuwgq+miMhde6thSUMt2UPrlXVYzPacxdTc=;
	b=a4+50NZ3tj7TAIoV03ZMEpF/glj6Uml5sUvEZPgurEFOQGmePFt3Jbib61G6pzgmYh6Hqo
	3E1qxDlkl3vUpm18zk3zLeftn+F5eFXmS2uxERU3BcHiWdoqNoWUhOAqjOepzmlLt6pMoh
	KMoD5oEAz7pbVB7PtpZxQG9bow0I+6M=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Tyler Hicks <code@tyhicks.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Ard Biesheuvel <ardb@kernel.org>,
	Zipeng Zhang <zhangzipeng0@foxmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Michael Halcrow <mhalcrow@us.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org,
	ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ecryptfs: Add missing gotos in ecryptfs_read_metadata
Date: Sun, 11 Jan 2026 01:36:52 +0100
Message-ID: <20260111003655.491722-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add two missing goto statements to exit ecryptfs_read_metadata() when an
error occurs.

The first goto is required; otherwise ECRYPTFS_METADATA_IN_XATTR may be
set when xattr metadata is enabled even though parsing the metadata
failed. The second goto is not strictly necessary, but it makes the
error path explicit instead of relying on falling through to 'out'.

Cc: stable@vger.kernel.org
Fixes: dd2a3b7ad98f ("[PATCH] eCryptfs: Generalize metadata read/write")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/ecryptfs/crypto.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 260f8a4938b0..d49cdf7292ab 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1328,6 +1328,7 @@ int ecryptfs_read_metadata(struct dentry *ecryptfs_dentry)
 			       "file xattr region either, inode %lu\n",
 				ecryptfs_inode->i_ino);
 			rc = -EINVAL;
+			goto out;
 		}
 		if (crypt_stat->mount_crypt_stat->flags
 		    & ECRYPTFS_XATTR_METADATA_ENABLED) {
@@ -1340,6 +1341,7 @@ int ecryptfs_read_metadata(struct dentry *ecryptfs_dentry)
 			       "this like an encrypted file, inode %lu\n",
 				ecryptfs_inode->i_ino);
 			rc = -EINVAL;
+			goto out;
 		}
 	}
 out:
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


