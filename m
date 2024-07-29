Return-Path: <stable+bounces-62389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0A893EF0C
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431B91C21B92
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E35112C522;
	Mon, 29 Jul 2024 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QkkQF4GG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8A484A2F
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239537; cv=none; b=LCKkewGC/UJiDAdCz4OlobJQKf2FrBACGaEdqi4jbXsaQfL8P3rtCws2PZZNMAFxdV/FeBIB7xPwTi+JZIRZwHtf1GRw29S94pv1erTwKcsh9GMFN8NQaaxkmIm3WrEidpRYR3vFyr6Y/kBqIg11M3CJYe/R4wZH+c7hl7cl+gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239537; c=relaxed/simple;
	bh=d3vz/J2gQN14Rr6qsSsEQ//+fc+c199SWWgQloShnBQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IRRWqppaAEOH/la5hcNkFudeIrxAzTW3opiV4xnAlyCjqbVmO/aX9qv7L4xvRS/83vD+ghh6Uz88eYTBeGkWEc61TZ91FOacqr3Sib5ABBvLMktCnuDYPvmG7Bh+ie8udcg1XpmO3anojnnTgpLCtcM+SmEh+8qpDjs45z16W60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QkkQF4GG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E381C4AF0B;
	Mon, 29 Jul 2024 07:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722239537;
	bh=d3vz/J2gQN14Rr6qsSsEQ//+fc+c199SWWgQloShnBQ=;
	h=Subject:To:Cc:From:Date:From;
	b=QkkQF4GGh1I214Ekm9Mfqm8qkHwtTbyYn1hibuHf1dGjZ77xhfLJytutePoVQakQB
	 0u3Gfx7CKxyR38S3PmovOGwpTQqHpnvnb3D9/fWHJ0v9/9w8w66GJJDgB7bvdNFYQR
	 7oN0OHB29AX2EhGgpfMlq92TdXScg2gsu1L+dccs=
Subject: FAILED: patch "[PATCH] fuse: verify {g,u}id mount options correctly" failed to apply to 5.10-stable tree
To: sandeen@redhat.com,brauner@kernel.org,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:52:08 +0200
Message-ID: <2024072908-everglade-starved-66da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 525bd65aa759ec320af1dc06e114ed69733e9e23
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072908-everglade-starved-66da@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

525bd65aa759 ("fuse: verify {g,u}id mount options correctly")
84c215075b57 ("fuse: name fs_context consistently")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 525bd65aa759ec320af1dc06e114ed69733e9e23 Mon Sep 17 00:00:00 2001
From: Eric Sandeen <sandeen@redhat.com>
Date: Tue, 2 Jul 2024 17:22:41 -0500
Subject: [PATCH] fuse: verify {g,u}id mount options correctly

As was done in
0200679fc795 ("tmpfs: verify {g,u}id mount options correctly")
we need to validate that the requested uid and/or gid is representable in
the filesystem's idmapping.

Cribbing from the above commit log,

The contract for {g,u}id mount options and {g,u}id values in general set
from userspace has always been that they are translated according to the
caller's idmapping. In so far, fuse has been doing the correct thing.
But since fuse is mountable in unprivileged contexts it is also
necessary to verify that the resulting {k,g}uid is representable in the
namespace of the superblock.

Fixes: c30da2e981a7 ("fuse: convert to use the new mount API")
Cc: stable@vger.kernel.org # 5.4+
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Link: https://lore.kernel.org/r/8f07d45d-c806-484d-a2e3-7a2199df1cd2@redhat.com
Reviewed-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 99e44ea7d875..32fe6fa72f46 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -755,6 +755,8 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 	struct fs_parse_result result;
 	struct fuse_fs_context *ctx = fsc->fs_private;
 	int opt;
+	kuid_t kuid;
+	kgid_t kgid;
 
 	if (fsc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
 		/*
@@ -799,16 +801,30 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		break;
 
 	case OPT_USER_ID:
-		ctx->user_id = make_kuid(fsc->user_ns, result.uint_32);
-		if (!uid_valid(ctx->user_id))
+		kuid =  make_kuid(fsc->user_ns, result.uint_32);
+		if (!uid_valid(kuid))
 			return invalfc(fsc, "Invalid user_id");
+		/*
+		 * The requested uid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kuid_has_mapping(fsc->user_ns, kuid))
+			return invalfc(fsc, "Invalid user_id");
+		ctx->user_id = kuid;
 		ctx->user_id_present = true;
 		break;
 
 	case OPT_GROUP_ID:
-		ctx->group_id = make_kgid(fsc->user_ns, result.uint_32);
-		if (!gid_valid(ctx->group_id))
+		kgid = make_kgid(fsc->user_ns, result.uint_32);;
+		if (!gid_valid(kgid))
 			return invalfc(fsc, "Invalid group_id");
+		/*
+		 * The requested gid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kgid_has_mapping(fsc->user_ns, kgid))
+			return invalfc(fsc, "Invalid group_id");
+		ctx->group_id = kgid;
 		ctx->group_id_present = true;
 		break;
 


