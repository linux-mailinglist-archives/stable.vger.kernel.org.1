Return-Path: <stable+bounces-171723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26785B2B6E4
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 04:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94202526378
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8633D287255;
	Tue, 19 Aug 2025 02:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m39hSqay"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A96286D64
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755569770; cv=none; b=Hw70SHdSa9Aud/v5a2BMhE9U5+bFjoMCUTyt5HsWFuQRVyHY4pvZq+VvT9x+QfUwhqPmpALskNSXeBoum6Lk3MGxigcF9KyJfREcPVcE1N4PTlHeGhhHfBZtjGWlHZyx1UqD9U8RQd6w1VXpo7qq+fz4lB6LDdtLNVvixlTurTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755569770; c=relaxed/simple;
	bh=Hxvgv2kOX0w7Sqp1uKSNpvzTKekr40+ShhNmiO7vp+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nl/x0c8ECT/jGKXlDVwA1xoyEFtX1y1AQ5lNlT9dFQLIXukQ+W4wlQDrJJch7X4FMCRBTDdHRVdAiBfCuDXNyacAuKen13z9OuvHfA72uSlUb5jKcVOFpepR3aSRzuicjVgGL8auhOtgqW/VyqX17zfK0GtWULuUG81dQUGcXE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m39hSqay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C95BC113D0;
	Tue, 19 Aug 2025 02:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755569769;
	bh=Hxvgv2kOX0w7Sqp1uKSNpvzTKekr40+ShhNmiO7vp+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m39hSqay2LgGKVz6M/y7Ba5h5JlPhW2/ESxk7VvEpTMQFLrvihXVgxbXx9bhZgjff
	 gAzWiOUueZmHfzDurM5CN8vj7zGV4lMnVxfRCFnmuiDiuaeSDvg+jMCQL6Is3r5p26
	 Y4eRz0jjMqHQWvRA2z9kumQ4oAgqa+nHKrpArOAiHUXPIx2ZiZqUOYPoYesbQIZQSW
	 t6FIsZzxjX0Dyuk9wmF3ThaSBK1/iDVwhmOfqi+LRNei8aDjHyN0lVoy9cmN9mhnvS
	 +kL5FGnnVN1mJDbPg1TXa/3tl5IYutBIhjFCsvlPq6V/k0xDrrUgnE2Q708TTrYXFm
	 hDsfhNqbEMagQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 6/7] btrfs: send: use fallocate for hole punching with send stream v2
Date: Mon, 18 Aug 2025 22:16:00 -0400
Message-ID: <20250819021601.274993-6-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819021601.274993-1-sashal@kernel.org>
References: <2025081827-washed-yelp-3c3e@gregkh>
 <20250819021601.274993-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/send.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 224e4c7d1e89..361880e81dc3 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/bsearch.h>
+#include <linux/falloc.h>
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/sort.h>
@@ -5518,6 +5519,30 @@ static int send_update_extent(struct send_ctx *sctx,
 	return ret;
 }
 
+static int send_fallocate(struct send_ctx *sctx, u32 mode, u64 offset, u64 len)
+{
+	struct fs_path *path;
+	int ret;
+
+	path = get_cur_inode_path(sctx);
+	if (IS_ERR(path))
+		return PTR_ERR(path);
+
+	ret = begin_cmd(sctx, BTRFS_SEND_C_FALLOCATE);
+	if (ret < 0)
+		return ret;
+
+	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, path);
+	TLV_PUT_U32(sctx, BTRFS_SEND_A_FALLOCATE_MODE, mode);
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_SIZE, len);
+
+	ret = send_cmd(sctx);
+
+tlv_put_failure:
+	return ret;
+}
+
 static int send_hole(struct send_ctx *sctx, u64 end)
 {
 	struct fs_path *p = NULL;
@@ -5525,6 +5550,14 @@ static int send_hole(struct send_ctx *sctx, u64 end)
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


