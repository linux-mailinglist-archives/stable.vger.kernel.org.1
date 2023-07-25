Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE1E761137
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbjGYKsu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjGYKsp (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:48:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C141010FD
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:48:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56F576165E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6596EC433C7;
        Tue, 25 Jul 2023 10:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282123;
        bh=bHSPKhK+umItmdo8BplFHrAVX6l3M6Qv2Q7VLFh2NzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1gq9ah9BJaWTceSWXjYq+GOm+shZuhJER/r3PI/bAiOxvqjtA3tt4Bd90PSSL20X+
         NgMJPB5qus9xBE/oONPjjAaxG7We2a1im7iNOrMjfyXDvMYEMaYdT0J5xQHYOUdkIc
         dchpTw6SSxTJtb+h7S7seDJh2n6VDlT3LS5+FGEw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 6.4 017/227] fuse: add feature flag for expire-only
Date:   Tue, 25 Jul 2023 12:43:04 +0200
Message-ID: <20230725104515.511815463@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

commit 5cadfbd5a11e5495cac217534c5f788168b1afd7 upstream.

Add an init flag idicating whether the FUSE_EXPIRE_ONLY flag of
FUSE_NOTIFY_INVAL_ENTRY is effective.

This is needed for backports of this feature, otherwise the server could
just check the protocol version.

Fixes: 4f8d37020e1f ("fuse: add "expire only" mode to FUSE_NOTIFY_INVAL_ENTRY")
Cc: <stable@vger.kernel.org> # v6.2
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fuse/inode.c           |    3 ++-
 include/uapi/linux/fuse.h |    3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1254,7 +1254,8 @@ void fuse_send_init(struct fuse_mount *f
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
 		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
-		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP;
+		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
+		FUSE_HAS_EXPIRE_ONLY;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -206,6 +206,7 @@
  *  - add extension header
  *  - add FUSE_EXT_GROUPS
  *  - add FUSE_CREATE_SUPP_GROUP
+ *  - add FUSE_HAS_EXPIRE_ONLY
  */
 
 #ifndef _LINUX_FUSE_H
@@ -369,6 +370,7 @@ struct fuse_file_lock {
  * FUSE_HAS_INODE_DAX:  use per inode DAX
  * FUSE_CREATE_SUPP_GROUP: add supplementary group info to create, mkdir,
  *			symlink and mknod (single group that matches parent)
+ * FUSE_HAS_EXPIRE_ONLY: kernel supports expiry-only entry invalidation
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -406,6 +408,7 @@ struct fuse_file_lock {
 #define FUSE_SECURITY_CTX	(1ULL << 32)
 #define FUSE_HAS_INODE_DAX	(1ULL << 33)
 #define FUSE_CREATE_SUPP_GROUP	(1ULL << 34)
+#define FUSE_HAS_EXPIRE_ONLY	(1ULL << 35)
 
 /**
  * CUSE INIT request/reply flags


