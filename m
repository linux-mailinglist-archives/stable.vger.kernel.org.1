Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EF67037A4
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243929AbjEORX0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244109AbjEORXH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:23:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3263E12492
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:21:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 132B362C56
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CEBC433EF;
        Mon, 15 May 2023 17:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171273;
        bh=Kd0NWkY0y7jCOTkO6lIGUyZ2q02mDPaJKTU8wMhqGfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WEwgT6Pkzz90WMYvzo1Ax8M7UcTXqxd6xP2TzZdsD+DGzQ0GUMlykzSpe7lPmgjOH
         LUZJaK/4ZguoW8h0GCwQKqlMaM3RB1+sJ/faEnOaMrRZ0BSpDOHVyqhvRStL/JMWoZ
         OiQN4NBz09XrInNjPhb/6MZQzLL+2hQVpStKM9lk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 6.2 156/242] proc_sysctl: update docs for __register_sysctl_table()
Date:   Mon, 15 May 2023 18:28:02 +0200
Message-Id: <20230515161726.568117182@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

commit 67ff32289acad9ed338cd9f2351b44939e55163e upstream.

Update the docs for __register_sysctl_table() to make it clear no child
entries can be passed. When the child is true these are non-leaf entries
on the ctl table and sysctl treats these as directories. The point to
__register_sysctl_table() is to deal only with directories not part of
the ctl table where thay may riside, to be simple and avoid recursion.

While at it, hint towards using long on extra1 and extra2 later.

Cc: stable@vger.kernel.org # v5.17
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/proc_sysctl.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1287,7 +1287,7 @@ out:
  * __register_sysctl_table - register a leaf sysctl table
  * @set: Sysctl tree to register on
  * @path: The path to the directory the sysctl table is in.
- * @table: the top-level table structure
+ * @table: the top-level table structure without any child
  *
  * Register a sysctl table hierarchy. @table should be a filled in ctl_table
  * array. A completely 0 filled entry terminates the table.
@@ -1308,9 +1308,12 @@ out:
  * proc_handler - the text handler routine (described below)
  *
  * extra1, extra2 - extra pointers usable by the proc handler routines
+ * XXX: we should eventually modify these to use long min / max [0]
+ * [0] https://lkml.kernel.org/87zgpte9o4.fsf@email.froward.int.ebiederm.org
  *
  * Leaf nodes in the sysctl tree will be represented by a single file
- * under /proc; non-leaf nodes will be represented by directories.
+ * under /proc; non-leaf nodes (where child is not NULL) are not allowed,
+ * sysctl_check_table() verifies this.
  *
  * There must be a proc_handler routine for any terminal nodes.
  * Several default handlers are available to cover common cases -
@@ -1352,7 +1355,7 @@ struct ctl_table_header *__register_sysc
 
 	spin_lock(&sysctl_lock);
 	dir = &set->dir;
-	/* Reference moved down the diretory tree get_subdir */
+	/* Reference moved down the directory tree get_subdir */
 	dir->header.nreg++;
 	spin_unlock(&sysctl_lock);
 
@@ -1369,6 +1372,11 @@ struct ctl_table_header *__register_sysc
 		if (namelen == 0)
 			continue;
 
+		/*
+		 * namelen ensures if name is "foo/bar/yay" only foo is
+		 * registered first. We traverse as if using mkdir -p and
+		 * return a ctl_dir for the last directory entry.
+		 */
 		dir = get_subdir(dir, name, namelen);
 		if (IS_ERR(dir))
 			goto fail;


