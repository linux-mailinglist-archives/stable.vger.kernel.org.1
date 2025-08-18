Return-Path: <stable+bounces-170004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF73B29FCF
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38CA19654E5
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D1B261B6D;
	Mon, 18 Aug 2025 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mBxzjE7t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7432261B65
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514650; cv=none; b=lLhqe9gipAQ8Ie4sASKwyuQAv/uKSosMkdFz4Ie4d3U7X7dj6bo/erGBIVbaDpvFP3PbSDgLlj0S11KGXtx74h/MoEEBWvcwPsTmOqtihMlFKSsr8SQ++E3MXrLeXKe1KENC8Zbc/4NebMVEIxmbx8uHSuXFirebp4XiRqcRmIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514650; c=relaxed/simple;
	bh=EF1LQ1PVKi6TwmHBgHqYGt37EYLJ3yjMe4MaWeWjcoo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZsDM71DuiAYDm7Fn70LfkEFWWD21fhAbKFw0a02Yk2iaat+FkxWfA3Haw9k58jFWV88By7K+nNjlmstrZF2+iCsyXPVXvzvxgexzQJr+ntpNlaDbEdGIRWcSZQumcF+1l584GCiH8T7mUlye75us8MtI8wloxS+xKEkqYtJHym0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mBxzjE7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F32C4CEEB;
	Mon, 18 Aug 2025 10:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755514650;
	bh=EF1LQ1PVKi6TwmHBgHqYGt37EYLJ3yjMe4MaWeWjcoo=;
	h=Subject:To:Cc:From:Date:From;
	b=mBxzjE7tPKp29ytHmojAloklXVvJFh6EINrsQDIhDc3v+mmYCi74bJOOA9+wDVFDi
	 47O0b30fQxySwVc3W2XG2OjhkXI47Y5Fk3K08NxFEopVal6Oj8Cr8ihbozHCq43HzT
	 OZpB9/FNdbOgEbSlPgHv9UA5RPwV7tlX8PqU3pOA=
Subject: FAILED: patch "[PATCH] btrfs: send: use fallocate for hole punching with send stream" failed to apply to 6.12-stable tree
To: fdmanana@suse.com,boris@bur.io,dsterba@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:57:27 +0200
Message-ID: <2025081827-washed-yelp-3c3e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 005b0a0c24e1628313e951516b675109a92cacfe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081827-washed-yelp-3c3e@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 005b0a0c24e1628313e951516b675109a92cacfe Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Fri, 18 Jul 2025 13:07:29 +0100
Subject: [PATCH] btrfs: send: use fallocate for hole punching with send stream
 v2

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

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 09822e766e41..7664025a5af4 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/bsearch.h>
+#include <linux/falloc.h>
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/sort.h>
@@ -5405,6 +5406,30 @@ static int send_update_extent(struct send_ctx *sctx,
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
@@ -5412,6 +5437,14 @@ static int send_hole(struct send_ctx *sctx, u64 end)
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


