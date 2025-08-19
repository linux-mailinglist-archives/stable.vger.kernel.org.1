Return-Path: <stable+bounces-171693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B672AB2B59C
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587CB18A4DC6
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 00:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FF218EFD1;
	Tue, 19 Aug 2025 00:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mw19e5ZZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119B73451D0
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 00:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755565075; cv=none; b=qO8ZGmynkWeKG77RvsNn/1tTG5Ro9fZEZQO+URP0MABUH59sYLtW8T8W9tdZEG+UueP/Y4ISLL0VJ29hoGlRb6iOBmQlDYLZKPUmijKL4KxvAmVLhHf16gDqidCzFh5vrSZn4iQcmXsKeRA3u1gfqsczwDz3VJZnE8KPQFzAOpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755565075; c=relaxed/simple;
	bh=CvCsodGglAMM0GSvOYYM4Yt8O0UWV7PMcNd7Hz2t2jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+NAP8aZ+gDgf90OuWrx+uYOJeogTfUusEave2XYhBcoPxiaee6XiIQKOSow2whOVpr0hoYuK56BGpHZ1hB+U4/vzQR0eCpy6OAZmJVrNJ521aLJxJ3K0ISZpsEG3rLPn80qQSYqI776AuKybqFFFIbOTVXCtfwIyPtXVGdRzZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mw19e5ZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B230C4CEEB;
	Tue, 19 Aug 2025 00:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755565074;
	bh=CvCsodGglAMM0GSvOYYM4Yt8O0UWV7PMcNd7Hz2t2jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mw19e5ZZntLlbE53mz76xuAbQek9cOxf5ZvPtKd7Q+yRGKAKzDl+VbdipONvY9R+9
	 bQRmSA943CGHAGvUL/X0hiv8LOFmG/y3rwlYdNTItM9XUM2Won9Fzq2nKZr0y+igTB
	 gETz5h5+czcZCRJUmfDvgcz0iY9T5Z0TkFzjufowx+IhBVddr/E33wZUhTCYr0FBzm
	 PvMZhFyEoKDmuJjJpaSdhtXaK5npmAhA4eUh/Uuq9xzWxPof+yaOpwn7e3C4v7bzra
	 NXgyQHvnltRqs5boMZ1npiuLL6XDv1OvfacXrPthIyRmnroICYbKp7lxlibSftHw+k
	 JVkyPy/kSo/ig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] btrfs: move transaction aborts to the error site in add_block_group_free_space()
Date: Mon, 18 Aug 2025 20:57:50 -0400
Message-ID: <20250819005751.234544-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081810-washer-purchase-bdf5@gregkh>
References: <2025081810-washer-purchase-bdf5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Sterba <dsterba@suse.com>

[ Upstream commit b63c8c1ede4407835cb8c8bed2014d96619389f3 ]

Transaction aborts should be done next to the place the error happens,
which was not done in add_block_group_free_space().

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 1f06c942aa70 ("btrfs: always abort transaction on failure to add block group to free space tree")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/free-space-tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 300ee0b68b49..be682925a14a 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1396,16 +1396,17 @@ int add_block_group_free_space(struct btrfs_trans_handle *trans,
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
 	ret = __add_block_group_free_space(trans, block_group, path);
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
 
 out:
 	btrfs_free_path(path);
 	mutex_unlock(&block_group->free_space_lock);
-	if (ret)
-		btrfs_abort_transaction(trans, ret);
 	return ret;
 }
 
-- 
2.50.1


