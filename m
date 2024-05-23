Return-Path: <stable+bounces-45887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5947B8CD469
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB7C1F215E5
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE4614D2B4;
	Thu, 23 May 2024 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EveyBl29"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483EC14BF89;
	Thu, 23 May 2024 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470648; cv=none; b=oSGPMMNJaV0LWorPnHQYvhBLjIVQWpuIr0yjL2djR0FBdrhce/EvZxXpNAZ4T6uau2AtDrWx3hNhLnQz0PhSR0/ZqLxAvrv1W5UZvtfq5HXZMVpozOtal03Ev7wwE9xgfO8eyMdKjQLI8cFLeqaMZPtkdkHjZSLRP3AilcmckDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470648; c=relaxed/simple;
	bh=5Rjlqt9ne6Qs+glYGpPaiKYjoIKQHXhUNC/GAhng07k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mb3iaQMeb81SCq5Nev5ZwSiyNY8Y6Qc6WgIF4FbzL8/R9DUH/CECTwYYaENTWJDZmYgnPxybO1kn4024BDeBNgKn4RJf/9eXunDn2/GwlxXizhTLkKRRMTFxZxWp6K5ePBI0KJqO+p89oGk95Lv4h5O3W/QFJ4+DWMyLhj6lQaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EveyBl29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64E9C32781;
	Thu, 23 May 2024 13:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470648;
	bh=5Rjlqt9ne6Qs+glYGpPaiKYjoIKQHXhUNC/GAhng07k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EveyBl29VTNk5UoZ7Xox1h4UY6Zscc/qSpS0pFAVWtD4W5xAMu9PMeG1DIxUlhGlJ
	 c9O3FSq9nyRFA1N0ad3+rzu0LveSLq78HV5LWwq/POsJU9iGrDyLwo9Ew8YCs+Ifyb
	 Nf07/dMTnOdHQ1FmX+s+GqRhbr1Lvqh9sGBURFDw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 039/102] smb3: update allocation size more accurately on write completion
Date: Thu, 23 May 2024 15:13:04 +0200
Message-ID: <20240523130343.937943967@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523130342.462912131@linuxfoundation.org>
References: <20240523130342.462912131@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

[ Upstream commit dbfdff402d89854126658376cbcb08363194d3cd ]

Changes to allocation size are approximated for extending writes of cached
files until the server returns the actual value (on SMB3 close or query info
for example), but it was setting the estimated value for number of blocks
to larger than the file size even if the file is likely sparse which
breaks various xfstests (e.g. generic/129, 130, 221, 228).

When i_size and i_blocks are updated in write completion do not increase
allocation size more than what was written (rounded up to 512 bytes).

Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/file.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 6d44991e1ccdc..751ae89cefe36 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -3204,8 +3204,15 @@ static int cifs_write_end(struct file *file, struct address_space *mapping,
 	if (rc > 0) {
 		spin_lock(&inode->i_lock);
 		if (pos > inode->i_size) {
+			loff_t additional_blocks = (512 - 1 + copied) >> 9;
+
 			i_size_write(inode, pos);
-			inode->i_blocks = (512 - 1 + pos) >> 9;
+			/*
+			 * Estimate new allocation size based on the amount written.
+			 * This will be updated from server on close (and on queryinfo)
+			 */
+			inode->i_blocks = min_t(blkcnt_t, (512 - 1 + pos) >> 9,
+						inode->i_blocks + additional_blocks);
 		}
 		spin_unlock(&inode->i_lock);
 	}
-- 
2.43.0




