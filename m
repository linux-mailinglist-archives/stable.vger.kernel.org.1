Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667A97A3AFC
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240569AbjIQULT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240576AbjIQULM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:11:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84669F1
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:11:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CD6C433C9;
        Sun, 17 Sep 2023 20:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981466;
        bh=l+xwsInZGZpQVJM6Mgue/V9oLsQDhCMg9mm4a+BC4Io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0nf3iPuxg/ltj0mgtqcWoMYt/672VVDIgFwPfzfsjhY3t6x3jcs1PIXCGnpfQ4G0Z
         F8Xvbkb6aOQZ3fa7K3yGMH1MpMGQtAqxQww7YMrLeUciMbdP4s/g849tHtfxFBgP9O
         DKvjE5Jc5l/23nFt4bItEqJvgHDNSEB7N3Aahr8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 059/511] tmpfs: verify {g,u}id mount options correctly
Date:   Sun, 17 Sep 2023 21:08:06 +0200
Message-ID: <20230917191115.311806666@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 0200679fc7953177941e41c2a4241d0b6c2c5de8 ]

A while ago we received the following report:

"The other outstanding issue I noticed comes from the fact that
fsconfig syscalls may occur in a different userns than that which
called fsopen. That means that resolving the uid/gid via
current_user_ns() can save a kuid that isn't mapped in the associated
namespace when the filesystem is finally mounted. This means that it
is possible for an unprivileged user to create files owned by any
group in a tmpfs mount (since we can set the SUID bit on the tmpfs
directory), or a tmpfs that is owned by any user, including the root
group/user."

The contract for {g,u}id mount options and {g,u}id values in general set
from userspace has always been that they are translated according to the
caller's idmapping. In so far, tmpfs has been doing the correct thing.
But since tmpfs is mountable in unprivileged contexts it is also
necessary to verify that the resulting {k,g}uid is representable in the
namespace of the superblock to avoid such bugs as above.

The new mount api's cross-namespace delegation abilities are already
widely used. After having talked to a bunch of userspace this is the
most faithful solution with minimal regression risks. I know of one
users - systemd - that makes use of the new mount api in this way and
they don't set unresolable {g,u}ids. So the regression risk is minimal.

Link: https://lore.kernel.org/lkml/CALxfFW4BXhEwxR0Q5LSkg-8Vb4r2MONKCcUCVioehXQKr35eHg@mail.gmail.com
Fixes: f32356261d44 ("vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount API")
Reviewed-by: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Reported-by: Seth Jenkins <sethjenkins@google.com>
Message-Id: <20230801-vfs-fs_context-uidgid-v1-1-daf46a050bbf@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shmem.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 41efb92c4e38f..663fb117cd877 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3394,6 +3394,8 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 	unsigned long long size;
 	char *rest;
 	int opt;
+	kuid_t kuid;
+	kgid_t kgid;
 
 	opt = fs_parse(fc, shmem_fs_parameters, param, &result);
 	if (opt < 0)
@@ -3429,14 +3431,32 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		ctx->mode = result.uint_32 & 07777;
 		break;
 	case Opt_uid:
-		ctx->uid = make_kuid(current_user_ns(), result.uint_32);
-		if (!uid_valid(ctx->uid))
+		kuid = make_kuid(current_user_ns(), result.uint_32);
+		if (!uid_valid(kuid))
 			goto bad_value;
+
+		/*
+		 * The requested uid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kuid_has_mapping(fc->user_ns, kuid))
+			goto bad_value;
+
+		ctx->uid = kuid;
 		break;
 	case Opt_gid:
-		ctx->gid = make_kgid(current_user_ns(), result.uint_32);
-		if (!gid_valid(ctx->gid))
+		kgid = make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(kgid))
 			goto bad_value;
+
+		/*
+		 * The requested gid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kgid_has_mapping(fc->user_ns, kgid))
+			goto bad_value;
+
+		ctx->gid = kgid;
 		break;
 	case Opt_huge:
 		ctx->huge = result.uint_32;
-- 
2.40.1



