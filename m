Return-Path: <stable+bounces-171741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9834FB2B77C
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 05:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC00189F1FE
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 03:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB0E2D24AF;
	Tue, 19 Aug 2025 03:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuTjvZjn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC061233735
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 03:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755573526; cv=none; b=fqR9jP/DjZmDDJ/5xtUFznNKTcU6t/p5eT8zcsJjnPzmWk15mqQSPsKsbWu0W+NFldkiMg8SSzOGyrPHgcmh0iLTFLgE4jltCxiABEw9vEeZQLfMZPf9WHwDwNU8TRIh6dygL7eB9zH67RuNidXAhfc1JwXq8JsREpgfSuL+RhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755573526; c=relaxed/simple;
	bh=63o8ZPK86MEp9CM6bbUA7dQjPLCPQ3Xe02WcfwDxlXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9xpJFJAWr8UdmwqeELZLqkuHjsM9O7mn8QxGu9hWfJV43SmG8VdkSeCuhrv+nLaXoKPK1pUTES/lRz7I6PUJprKhvuRZEdKTjt9zaZn7l6IJhnOmfp+597+pzncLAFOc/NmRf4n5PNjwiKSlsiqlAFdxSdkRInK7v+im+pw2i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuTjvZjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BD4C4CEF4;
	Tue, 19 Aug 2025 03:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755573525;
	bh=63o8ZPK86MEp9CM6bbUA7dQjPLCPQ3Xe02WcfwDxlXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BuTjvZjnnCwf2rEHWRk2LfmMy6dT/70/oKY1vwZvctBDLPND/EIoYyS7I58Y59DIB
	 FFrHvCBmHc16I1FHyheBqSYEX8a9yLMaMHrx17X53UxN/Gsk9lJh5P0QiGXoTxEfpr
	 eUY5ORUG1nHGg8wkC2qhbKmzP4ybTQVRxO24ioQXg6pFrseZqbnbG/azevJRPlyat4
	 r/y9HilKjnb/uS+vN1302iS2zR8d8zbmJ4byZ+Tn3QM0SqzjNVPAeWtj/eBqcCtd1S
	 1IiGioxqEjipFLvIvl53VJMNVIVFJDX60x42ExILlzWTGPqQjQl4eQq6DWIMzO4QZi
	 T6kB9+pBXl94Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] btrfs: send: use fallocate for hole punching with send stream v2
Date: Mon, 18 Aug 2025 23:18:42 -0400
Message-ID: <20250819031842.309897-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081848-kilobyte-skirmish-7ccd@gregkh>
References: <2025081848-kilobyte-skirmish-7ccd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 005b0a0c24e1628313e951516b675109a92cacfe ]

Currently holes are sent as writes full of zeroes, which results in
unnecessarily using disk space at the receiving end and increasing the
stream size.

In some cases we avoid sending writes of zeroes, like during a full
send operation where we just skip writes for holes.

But for some cases we fill previous holes with writes of zeroes too, like
in this scenario:

1) We have a file with a hole in the range [2M, 3M), we snapshot the
   subvolume and do a full send. The range [2M, 3M) stays as a hole at
   the receiver since we skip sending write commands full of zeroes;

2) We punch a hole for the range [3M, 4M) in our file, so that now it
   has a 2M hole in the range [2M, 4M), and snapshot the subvolume.
   Now if we do an incremental send, we will send write commands full
   of zeroes for the range [2M, 4M), removing the hole for [2M, 3M) at
   the receiver.

We could improve cases such as this last one by doing additional
comparisons of file extent items (or their absence) between the parent
and send snapshots, but that's a lot of code to add plus additional CPU
and IO costs.

Since the send stream v2 already has a fallocate command and btrfs-progs
implements a callback to execute fallocate since the send stream v2
support was added to it, update the kernel to use fallocate for punching
holes for V2+ streams.

Test coverage is provided by btrfs/284 which is a version of btrfs/007
that exercises send stream v2 instead of v1, using fsstress with random
operations and fssum to verify file contents.

Link: https://github.com/kdave/btrfs-progs/issues/1001
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ Replaced get_cur_inode_path() with fs_path_alloc() and get_cur_path() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/send.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 0735decec99b..f5a9f6689c46 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/bsearch.h>
+#include <linux/falloc.h>
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/sort.h>
@@ -5231,6 +5232,36 @@ static int send_update_extent(struct send_ctx *sctx,
 	return ret;
 }
 
+static int send_fallocate(struct send_ctx *sctx, u32 mode, u64 offset, u64 len)
+{
+	struct fs_path *p;
+	int ret;
+
+	p = fs_path_alloc();
+	if (!p)
+		return -ENOMEM;
+
+	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
+	if (ret < 0)
+		goto out;
+
+	ret = begin_cmd(sctx, BTRFS_SEND_C_FALLOCATE);
+	if (ret < 0)
+		goto out;
+
+	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
+	TLV_PUT_U32(sctx, BTRFS_SEND_A_FALLOCATE_MODE, mode);
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_SIZE, len);
+
+	ret = send_cmd(sctx);
+
+tlv_put_failure:
+out:
+	fs_path_free(p);
+	return ret;
+}
+
 static int send_hole(struct send_ctx *sctx, u64 end)
 {
 	struct fs_path *p = NULL;
@@ -5238,6 +5269,14 @@ static int send_hole(struct send_ctx *sctx, u64 end)
 	u64 offset = sctx->cur_inode_last_extent;
 	int ret = 0;
 
+	/*
+	 * Starting with send stream v2 we have fallocate and can use it to
+	 * punch holes instead of sending writes full of zeroes.
+	 */
+	if (proto_cmd_ok(sctx, BTRFS_SEND_C_FALLOCATE))
+		return send_fallocate(sctx, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				      offset, end - offset);
+
 	/*
 	 * A hole that starts at EOF or beyond it. Since we do not yet support
 	 * fallocate (for extent preallocation and hole punching), sending a
-- 
2.50.1


