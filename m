Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B567616DA
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjGYLns (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbjGYLnQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:43:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC07E1FDA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:42:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4010B616B8
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF09C433C7;
        Tue, 25 Jul 2023 11:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285333;
        bh=CZNTdOr0qThjqT/wf9+TGGciE3frlEIOaIt1tsNMhY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fph9OvkGhmmREGFqXyM6WkC8T7DyVRNkd1tc72e98ZM+neJ2K3B9Mdy8g5ixGaCrm
         C6K3Vxr/8pp5IqsjLikwUuJLRBPcVFjgI8jBmBXJNP9JxqAovpZ2b5Px8KV0nFhBe9
         UlGmglyrqdIW2pnewtyB5cx+34OXupyz1ukRrB1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tim Gardner <tim.gardner@canonical.com>,
        kernel test robot <lkp@intel.com>,
        Ron Economos <re@w6rz.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fabian Frederick <fabf@skynet.be>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.4 168/313] jffs2: reduce stack usage in jffs2_build_xattr_subsystem()
Date:   Tue, 25 Jul 2023 12:45:21 +0200
Message-ID: <20230725104528.217124950@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
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

From: Fabian Frederick <fabf@skynet.be>

commit 1168f095417643f663caa341211e117db552989f upstream.

Use kcalloc() for allocation/flush of 128 pointers table to
reduce stack usage.

Function now returns -ENOMEM or 0 on success.

stackusage
Before:
./fs/jffs2/xattr.c:775  jffs2_build_xattr_subsystem     1208
dynamic,bounded

After:
./fs/jffs2/xattr.c:775  jffs2_build_xattr_subsystem     192
dynamic,bounded

Also update definition when CONFIG_JFFS2_FS_XATTR is not enabled

Tested with an MTD mount point and some user set/getfattr.

Many current target on OpenWRT also suffer from a compilation warning
(that become an error with CONFIG_WERROR) with the following output:

fs/jffs2/xattr.c: In function 'jffs2_build_xattr_subsystem':
fs/jffs2/xattr.c:887:1: error: the frame size of 1088 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
  887 | }
      | ^

Using dynamic allocation fix this compilation warning.

Fixes: c9f700f840bd ("[JFFS2][XATTR] using 'delete marker' for xdatum/xref deletion")
Reported-by: Tim Gardner <tim.gardner@canonical.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Ron Economos <re@w6rz.net>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Fabian Frederick <fabf@skynet.be>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Cc: stable@vger.kernel.org
Message-Id: <20230506045612.16616-1-ansuelsmth@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/jffs2/build.c |    5 ++++-
 fs/jffs2/xattr.c |   13 +++++++++----
 fs/jffs2/xattr.h |    4 ++--
 3 files changed, 15 insertions(+), 7 deletions(-)

--- a/fs/jffs2/build.c
+++ b/fs/jffs2/build.c
@@ -211,7 +211,10 @@ static int jffs2_build_filesystem(struct
 		ic->scan_dents = NULL;
 		cond_resched();
 	}
-	jffs2_build_xattr_subsystem(c);
+	ret = jffs2_build_xattr_subsystem(c);
+	if (ret)
+		goto exit;
+
 	c->flags &= ~JFFS2_SB_FLAG_BUILDING;
 
 	dbg_fsbuild("FS build complete\n");
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -772,10 +772,10 @@ void jffs2_clear_xattr_subsystem(struct
 }
 
 #define XREF_TMPHASH_SIZE	(128)
-void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
+int jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
 {
 	struct jffs2_xattr_ref *ref, *_ref;
-	struct jffs2_xattr_ref *xref_tmphash[XREF_TMPHASH_SIZE];
+	struct jffs2_xattr_ref **xref_tmphash;
 	struct jffs2_xattr_datum *xd, *_xd;
 	struct jffs2_inode_cache *ic;
 	struct jffs2_raw_node_ref *raw;
@@ -784,9 +784,12 @@ void jffs2_build_xattr_subsystem(struct
 
 	BUG_ON(!(c->flags & JFFS2_SB_FLAG_BUILDING));
 
+	xref_tmphash = kcalloc(XREF_TMPHASH_SIZE,
+			       sizeof(struct jffs2_xattr_ref *), GFP_KERNEL);
+	if (!xref_tmphash)
+		return -ENOMEM;
+
 	/* Phase.1 : Merge same xref */
-	for (i=0; i < XREF_TMPHASH_SIZE; i++)
-		xref_tmphash[i] = NULL;
 	for (ref=c->xref_temp; ref; ref=_ref) {
 		struct jffs2_xattr_ref *tmp;
 
@@ -884,6 +887,8 @@ void jffs2_build_xattr_subsystem(struct
 		     "%u of xref (%u dead, %u orphan) found.\n",
 		     xdatum_count, xdatum_unchecked_count, xdatum_orphan_count,
 		     xref_count, xref_dead_count, xref_orphan_count);
+	kfree(xref_tmphash);
+	return 0;
 }
 
 struct jffs2_xattr_datum *jffs2_setup_xattr_datum(struct jffs2_sb_info *c,
--- a/fs/jffs2/xattr.h
+++ b/fs/jffs2/xattr.h
@@ -71,7 +71,7 @@ static inline int is_xattr_ref_dead(stru
 #ifdef CONFIG_JFFS2_FS_XATTR
 
 extern void jffs2_init_xattr_subsystem(struct jffs2_sb_info *c);
-extern void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c);
+extern int jffs2_build_xattr_subsystem(struct jffs2_sb_info *c);
 extern void jffs2_clear_xattr_subsystem(struct jffs2_sb_info *c);
 
 extern struct jffs2_xattr_datum *jffs2_setup_xattr_datum(struct jffs2_sb_info *c,
@@ -103,7 +103,7 @@ extern ssize_t jffs2_listxattr(struct de
 #else
 
 #define jffs2_init_xattr_subsystem(c)
-#define jffs2_build_xattr_subsystem(c)
+#define jffs2_build_xattr_subsystem(c)		(0)
 #define jffs2_clear_xattr_subsystem(c)
 
 #define jffs2_xattr_do_crccheck_inode(c, ic)


