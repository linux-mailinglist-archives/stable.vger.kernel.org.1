Return-Path: <stable+bounces-170987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD0FB2A74B
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229F26860D4
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEE6335BB5;
	Mon, 18 Aug 2025 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L2xvM756"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EE9335BB9;
	Mon, 18 Aug 2025 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524446; cv=none; b=YmKzf8fAmYEsLgkdg3bS+z1FZj+9Zoh4vg3tZeOe4JtzpLOC74HyeNRuSDR2EPwZDeGs+utKQUqv17+bNmpNG74Hj6wa2wla8LSjj7J69Mw1xj6K2xrjG5PhQ5bj8FJDIgz/AsT3RWiucNC0X9AKXwsdrxk/T9R+ZMRR0NCAIDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524446; c=relaxed/simple;
	bh=09uaypUhDnGb1NfJjgYPh4rtSRf4U04o5pzx5lYup7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcA3xWhoLm1hJW7Su/rJbN1S6BlaJgmJBqYsQOKxOaxD4jCRFKhM44fm7g+IfBl6IpZ3MS/vhS8OnPNcUa+VwqmL6VDikdNPNfnw4xW4CjiwLuXu/xvDcZf0Zgdws61g8aMHUT54NzXJKtk01+RL+N2TGi1g4NhwJaJwRoW8tCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L2xvM756; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB5FC4CEF1;
	Mon, 18 Aug 2025 13:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755524446;
	bh=09uaypUhDnGb1NfJjgYPh4rtSRf4U04o5pzx5lYup7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2xvM7562K2c4pbRQtzTQUXm21OvCAXO7JImWhaHgryeWsydfFh0YIKDn0nKQPOp2
	 mQ7+hnl1K+8FEB22QqeAArpT8yO+Mjbww+bN7f+tcpGdfq1y47r1TY/WCI4YaDO5nL
	 F8bzRodHjD6z3Xk/p4c+GaWTiKBeTMlmajHtFDew=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Boris Burkov <boris@bur.io>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.15 475/515] btrfs: send: use fallocate for hole punching with send stream v2
Date: Mon, 18 Aug 2025 14:47:41 +0200
Message-ID: <20250818124516.707712635@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124458.334548733@linuxfoundation.org>
References: <20250818124458.334548733@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 005b0a0c24e1628313e951516b675109a92cacfe upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/send.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/bsearch.h>
+#include <linux/falloc.h>
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/sort.h>
@@ -5465,6 +5466,30 @@ tlv_put_failure:
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
@@ -5473,6 +5498,14 @@ static int send_hole(struct send_ctx *sc
 	int ret = 0;
 
 	/*
+	 * Starting with send stream v2 we have fallocate and can use it to
+	 * punch holes instead of sending writes full of zeroes.
+	 */
+	if (proto_cmd_ok(sctx, BTRFS_SEND_C_FALLOCATE))
+		return send_fallocate(sctx, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				      offset, end - offset);
+
+	/*
 	 * A hole that starts at EOF or beyond it. Since we do not yet support
 	 * fallocate (for extent preallocation and hole punching), sending a
 	 * write of zeroes starting at EOF or beyond would later require issuing



