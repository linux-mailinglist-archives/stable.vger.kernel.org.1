Return-Path: <stable+bounces-170147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B21B2A311
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3809E5655A0
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24C0261B8D;
	Mon, 18 Aug 2025 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VxIFGulu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED74320CB7;
	Mon, 18 Aug 2025 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521678; cv=none; b=FCqlZ0X4e6wciWpTUfbMrUZXX+kkJac7sPX+bAE0VaLxFOlqyrSPiizGwxeITKIsRN+6c5RlrrMLOYfxL3bePJBvytTtl3Phg6s6KxjBqVTgkCzLsune+AKR1nYpaRJFpVIrHzXa6kd0f36OSzbkV8zAsO4+0qzf5Rog/NeZgcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521678; c=relaxed/simple;
	bh=3+cQyrgpOXNMUKikU0Qc4TKDNcaR4MzpM0QBDz1UHN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdFXOzz9LM9HNRzvzV2RBqs+ID7CPa0R3Zl/uCdI/rOs7n6m/8wHxu+X7k4HvyclROVJPpReUQhq7vDPQg8A0tVVWdD1rO+h8cT3uxOHWvZXaFxI+xOs93j+bMSTa4bGIXJJxECqEqIeK/20hIoIThWwtGayTyJE3I6NDIzbstQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VxIFGulu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C214FC4CEEB;
	Mon, 18 Aug 2025 12:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755521678;
	bh=3+cQyrgpOXNMUKikU0Qc4TKDNcaR4MzpM0QBDz1UHN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VxIFGuluewT/NOpt7uSLq7ZbHsWCpQEYdc5VHmhxCSoibIAg4wh7zfjk11Kfb+MQP
	 5avSYg/vuvJFABeAiS2PUOg+eHnBBpwH9WYaGC0Eb5QilUVn9B+PUVuTmEBuSFZWAg
	 8J4ketAlG+eLWLG4GnH1DQBRpzoOlonpuQODIwb4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wei Gao <wegao@suse.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 091/444] ext2: Handle fiemap on empty files to prevent EINVAL
Date: Mon, 18 Aug 2025 14:41:57 +0200
Message-ID: <20250818124452.356191552@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Gao <wegao@suse.com>

[ Upstream commit a099b09a3342a0b28ea330e405501b5b4d0424b4 ]

Previously, ext2_fiemap would unconditionally apply "len = min_t(u64, len,
i_size_read(inode));", When inode->i_size was 0 (for an empty file), this
would reduce the requested len to 0. Passing len = 0 to iomap_fiemap could
then result in an -EINVAL error, even for valid queries on empty files.

Link: https://github.com/linux-test-project/ltp/issues/1246
Signed-off-by: Wei Gao <wegao@suse.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250613152402.3432135-1-wegao@suse.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext2/inode.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 30f8201c155f..177b1f852b63 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -895,9 +895,19 @@ int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 start, u64 len)
 {
 	int ret;
+	loff_t i_size;
 
 	inode_lock(inode);
-	len = min_t(u64, len, i_size_read(inode));
+	i_size = i_size_read(inode);
+	/*
+	 * iomap_fiemap() returns EINVAL for 0 length. Make sure we don't trim
+	 * length to 0 but still trim the range as much as possible since
+	 * ext2_get_blocks() iterates unmapped space block by block which is
+	 * slow.
+	 */
+	if (i_size == 0)
+		i_size = 1;
+	len = min_t(u64, len, i_size);
 	ret = iomap_fiemap(inode, fieinfo, start, len, &ext2_iomap_ops);
 	inode_unlock(inode);
 
-- 
2.39.5




