Return-Path: <stable+bounces-170006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7378B29FCB
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D5D2A3FFB
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E582261B6E;
	Mon, 18 Aug 2025 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="apKEh6y7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1FD261B6A
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514672; cv=none; b=TPJLQ7OZU1qDagg2s/DSo3/NbYzuARd+srEXYXtRzFykpJRJ0v6gG3IuRxCIK7n1rai8JClbbfAaZq2CWHgaZ0PmovvYH524Eer2gakKsYBO8JEHGeCGAAtdNTwPt1zwnVx4orz59T5YlWu9H8NeAB6q6BZl/5sfO+zKybhCYpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514672; c=relaxed/simple;
	bh=do9FgkLzD0jy+Otr/Mm9Kp7MCYnobV6u70Z/6+jmeME=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BQcT8c52a3YJlljHx+GPgIALBDKkypnhTn8jBscmFOGTejOsnatm0e3gAhPi/EKBcl349f1beQev4kya8kevnpup0yYonX3o96vULSF71sq8MSudsGk3TZlexTvfFTozq661iZWt8l4Aa+duDJvAesQfizGIn3wOmQjqShfX8Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=apKEh6y7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46212C4CEEB;
	Mon, 18 Aug 2025 10:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755514671;
	bh=do9FgkLzD0jy+Otr/Mm9Kp7MCYnobV6u70Z/6+jmeME=;
	h=Subject:To:Cc:From:Date:From;
	b=apKEh6y7mrkzto/Vp3BcVMaeabvN4hRMS7hFsqbxF+MBCSoWYi+AlGxtrHzNcmQYF
	 8A8iAUpn5hQNYRN5Q82r540SOWG68nMHyjjbFMwvk56ubvaTwTtESFSCCyYbZ5Wjey
	 4fS7QApFOwYlijIX6hr5QgDqoDtWNUmeRXn0VBWU=
Subject: FAILED: patch "[PATCH] btrfs: send: use fallocate for hole punching with send stream" failed to apply to 6.1-stable tree
To: fdmanana@suse.com,boris@bur.io,dsterba@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:57:48 +0200
Message-ID: <2025081848-kilobyte-skirmish-7ccd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 005b0a0c24e1628313e951516b675109a92cacfe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081848-kilobyte-skirmish-7ccd@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


