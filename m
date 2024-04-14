Return-Path: <stable+bounces-38650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C538A0FB4
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5767D1C21645
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA64145B1A;
	Thu, 11 Apr 2024 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kMo7IF3n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C39F1422CE;
	Thu, 11 Apr 2024 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831193; cv=none; b=JtkLmIaNw28ThLFu7f4p1DvEwmKGd1Le/pEHF0/UmWIBKYTnAfK82rlInFtWBWBPZqYp6WAd8zxZa7YXINk+BQvlyzpWdymMD5Hyx3YxiEsDH3tb5mIu2sp0oxXJTV3UYd0sU3xTHUPCeuCYzj5Sqz+CMjmKQl+/M6sW1bRis6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831193; c=relaxed/simple;
	bh=FfPncGbjvyvnmXlEylkh7AoYiGy6XXcu3CrlCVJGuTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Be/P+Z2VHosXNU6VJK7PUPbqaBgjxQVqxYqyqbXwpk4AAM9b1vA+zNeA2Ey1szweVHD+zbaBrBbBW0dUifGoSNdnm2Rp8jc++JUv6LkHibWtMbYRrY7NVDerE3mFgL/MrALePFn2EYDrkap9IKtbiFcQPCLVrNKtjDsDMVpIgPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kMo7IF3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F5EC433F1;
	Thu, 11 Apr 2024 10:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831193;
	bh=FfPncGbjvyvnmXlEylkh7AoYiGy6XXcu3CrlCVJGuTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kMo7IF3nSte+qyUN0v4FFQzN5dAmqXOu515YzrjbY6PYou5rTgPLUVHyVm/blx4qC
	 h1OeiU8Hd6NM10toDSVKyvQt8BjIZGgC/7ACJ7KiFuUR/1teXLqUoK/joFZ+4JdGh5
	 P5OW+S3rL9860WbrRdcOtIzXzb+YUsimnxKxv0cY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 039/114] btrfs: export: handle invalid inode or root reference in btrfs_get_parent()
Date: Thu, 11 Apr 2024 11:56:06 +0200
Message-ID: <20240411095418.062072966@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095416.853744210@linuxfoundation.org>
References: <20240411095416.853744210@linuxfoundation.org>
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

From: David Sterba <dsterba@suse.com>

[ Upstream commit 26b66d1d366a375745755ca7365f67110bbf6bd5 ]

The get_parent handler looks up a parent of a given dentry, this can be
either a subvolume or a directory. The search is set up with offset -1
but it's never expected to find such item, as it would break allowed
range of inode number or a root id. This means it's a corruption (ext4
also returns this error code).

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/export.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 744a02b7fd671..203e5964c9b0f 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -174,8 +174,15 @@ struct dentry *btrfs_get_parent(struct dentry *child)
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
 		goto fail;
+	if (ret == 0) {
+		/*
+		 * Key with offset of -1 found, there would have to exist an
+		 * inode with such number or a root with such id.
+		 */
+		ret = -EUCLEAN;
+		goto fail;
+	}
 
-	BUG_ON(ret == 0); /* Key with offset of -1 found */
 	if (path->slots[0] == 0) {
 		ret = -ENOENT;
 		goto fail;
-- 
2.43.0




