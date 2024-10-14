Return-Path: <stable+bounces-83833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218D499CCC4
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5359E1C221F5
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FC01AAE2B;
	Mon, 14 Oct 2024 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RSvh+Xv3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6B91AA7A5;
	Mon, 14 Oct 2024 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915873; cv=none; b=Hv5y3DUIFy1PYTAF31mlKUF84bMwbvrm94gws+mpeOVe6FP44CfqrewlifFy3xcPdlwQzkg0B3z2BuzP9aJiDIyXv1OHhjuLrHVfSxQWn04vZONWOdstELYu9+LdXr1iYafzS4D6aLlEhAKUNeU1na7Iq5zsS7iw3zT6dhhJF1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915873; c=relaxed/simple;
	bh=evcQytSPwmapF4wdxr6NhcD9B4oea7CfqjUZRULSrmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoFkosdbM4MHYP2DhA9025A2jrMGM9PhuIC8aqayvWMuWfTBbGYqo0oi7X/4Vfooonn20XguXP0Ok03xLLLY7F0IOexkioxsAJIi1CWfLtTPXa4aPIzeudQcZzWp4uMo8NRJaL8ZiJ/X3gtWqgq4WALEDNBTIxXxKKr7ryqF/zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RSvh+Xv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E564C4CEC3;
	Mon, 14 Oct 2024 14:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728915873;
	bh=evcQytSPwmapF4wdxr6NhcD9B4oea7CfqjUZRULSrmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RSvh+Xv3lrMYkIywTnPLqtBzaJtkynuZq7khEbc6A56xyGW3jtqDocSYbEZBtP/t+
	 J2tDmbh9xF0iKhmFyn4i7vjqGGnlPdBbdB6CZ40GHA1TBgZoad1LFNAgn7rDYwqSE9
	 38nvizGUVjiNv0mpgUIhpPVGwtSnSdZ2SYACXCcQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 003/214] fs/ntfs3: Do not call file_modified if collapse range failed
Date: Mon, 14 Oct 2024 16:17:46 +0200
Message-ID: <20241014141045.125903072@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141044.974962104@linuxfoundation.org>
References: <20241014141044.974962104@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 2db86f7995fe6b62a4d6fee9f3cdeba3c6d27606 ]

Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index ca1ddc46bd866..cddc51f9a93b2 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -484,7 +484,7 @@ static int ntfs_truncate(struct inode *inode, loff_t new_size)
 }
 
 /*
- * ntfs_fallocate
+ * ntfs_fallocate - file_operations::ntfs_fallocate
  *
  * Preallocate space for a file. This implements ntfs's fallocate file
  * operation, which gets called from sys_fallocate system call. User
@@ -619,6 +619,8 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 		ni_lock(ni);
 		err = attr_collapse_range(ni, vbo, len);
 		ni_unlock(ni);
+		if (err)
+			goto out;
 	} else if (mode & FALLOC_FL_INSERT_RANGE) {
 		/* Check new size. */
 		err = inode_newsize_ok(inode, new_size);
-- 
2.43.0




