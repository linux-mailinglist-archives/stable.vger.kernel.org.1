Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A527A390E
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239941AbjIQToG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239983AbjIQTnz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:43:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA2CE7
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:43:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4426CC433C7;
        Sun, 17 Sep 2023 19:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979829;
        bh=e5iCdhE9TlPfZNYXiwGw+iiQct0rfeO3cdnaZmKN7yA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fm68CX/UAlB4DMLBfWcWopXjQ/7G9ZxQrE55r2cB1KzewCycyywp3vVkEXi6DSkVy
         h2/mVLoQX5ECmYonhEIf3MurEaFjbByTl/dprGuGQW5/bRJglj0ksqF3NR2jgskcgv
         RbLr9MMSdOckjVoz2ZYubZ9OsyGascx4uYY8euw8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Ian Kent <raven@themaw.net>,
        Imran Khan <imran.f.khan@oracle.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Minchan Kim <minchan@kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>
Subject: [PATCH 6.5 019/285] kernfs: fix missing kernfs_iattr_rwsem locking
Date:   Sun, 17 Sep 2023 21:10:19 +0200
Message-ID: <20230917191052.290816866@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Kent <raven@themaw.net>

commit 0559f63057f927d298d68294d6ff77ce09b99255 upstream.

When the kernfs_iattr_rwsem was introduced a case was missed.

The update of the kernfs directory node child count was also protected
by the kernfs_rwsem and needs to be included in the change so that the
child count (and so the inode n_link attribute) does not change while
holding the rwsem for read.

Fixes: 9caf69614225 ("kernfs: Introduce separate rwsem to protect inode attributes.")
Cc: stable <stable@kernel.org>
Signed-off-by: Ian Kent <raven@themaw.net>
Reviewed-By: Imran Khan <imran.f.khan@oracle.com>
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Eric Sandeen <sandeen@sandeen.net>
Link: https://lore.kernel.org/r/169128520941.68052.15749253469930138901.stgit@donald.themaw.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/kernfs/dir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 5a1a4af9d3d2..bf243015834e 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -383,9 +383,11 @@ static int kernfs_link_sibling(struct kernfs_node *kn)
 	rb_insert_color(&kn->rb, &kn->parent->dir.children);
 
 	/* successfully added, account subdir number */
+	down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 	if (kernfs_type(kn) == KERNFS_DIR)
 		kn->parent->dir.subdirs++;
 	kernfs_inc_rev(kn->parent);
+	up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 
 	return 0;
 }
@@ -408,9 +410,11 @@ static bool kernfs_unlink_sibling(struct kernfs_node *kn)
 	if (RB_EMPTY_NODE(&kn->rb))
 		return false;
 
+	down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 	if (kernfs_type(kn) == KERNFS_DIR)
 		kn->parent->dir.subdirs--;
 	kernfs_inc_rev(kn->parent);
+	up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 
 	rb_erase(&kn->rb, &kn->parent->dir.children);
 	RB_CLEAR_NODE(&kn->rb);
-- 
2.42.0



