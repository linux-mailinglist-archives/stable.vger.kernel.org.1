Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE0D7A7C39
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbjITL7U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjITL7S (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:59:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B7C92
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:59:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58356C433C8;
        Wed, 20 Sep 2023 11:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211152;
        bh=Xi/djxjTTjsuzaGipUuNXlLr8j6N0sAa4LuegFk1MzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nUnx5n6jCwz0sx9HBFzqUE1kDFcTem7zk2FnowNUnf/0LFDXe4eg86QODeEPb3wZI
         9c1lC1rMxYRl2mP6QK9LGO7dGWHK0VkCiWW/YwcyS+kPu7LIlFYl6heLKsXE9DjQFQ
         V8PvUibU6miHgKRY7h5cw/HRzD/RVnWsBSL38xLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adam Williamson <awilliam@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 6.1 127/139] selinux: fix handling of empty opts in selinux_fs_context_submount()
Date:   Wed, 20 Sep 2023 13:31:01 +0200
Message-ID: <20230920112840.330159958@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
References: <20230920112835.549467415@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ondrej Mosnacek <omosnace@redhat.com>

commit ccf1dab96be4caed7c5235b1cfdb606ac161b996 upstream.

selinux_set_mnt_opts() relies on the fact that the mount options pointer
is always NULL when all options are unset (specifically in its
!selinux_initialized() branch. However, the new
selinux_fs_context_submount() hook breaks this rule by allocating a new
structure even if no options are set. That causes any submount created
before a SELinux policy is loaded to be rejected in
selinux_set_mnt_opts().

Fix this by making selinux_fs_context_submount() leave fc->security
set to NULL when there are no options to be copied from the reference
superblock.

Cc: <stable@vger.kernel.org>
Reported-by: Adam Williamson <awilliam@redhat.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2236345
Fixes: d80a8f1b58c2 ("vfs, security: Fix automount superblock LSM init problem, preventing NFS sb sharing")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/selinux/hooks.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2769,14 +2769,20 @@ static int selinux_umount(struct vfsmoun
 static int selinux_fs_context_submount(struct fs_context *fc,
 				   struct super_block *reference)
 {
-	const struct superblock_security_struct *sbsec;
+	const struct superblock_security_struct *sbsec = selinux_superblock(reference);
 	struct selinux_mnt_opts *opts;
 
+	/*
+	 * Ensure that fc->security remains NULL when no options are set
+	 * as expected by selinux_set_mnt_opts().
+	 */
+	if (!(sbsec->flags & (FSCONTEXT_MNT|CONTEXT_MNT|DEFCONTEXT_MNT)))
+		return 0;
+
 	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
 	if (!opts)
 		return -ENOMEM;
 
-	sbsec = selinux_superblock(reference);
 	if (sbsec->flags & FSCONTEXT_MNT)
 		opts->fscontext_sid = sbsec->sid;
 	if (sbsec->flags & CONTEXT_MNT)


