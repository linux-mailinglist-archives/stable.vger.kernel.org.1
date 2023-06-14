Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA65F713D8F
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjE1T0w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjE1T0v (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:26:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0134A106
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:26:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D592D61C50
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DA0C433D2;
        Sun, 28 May 2023 19:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301997;
        bh=Wc1qUG8K37tcq1AEvJbPEzAs25/PdWfETdyPTctCIX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wzEBttgVzZQ3KQwHrb8GJqdRvkAGk6ZR5QD5VPWMKfuVGuP26ZHaBs2GWDSsKJUeH
         iDFlmTlIOYTneEI4rBwRf4m6DTAk/j0piokOpVV95QKu8XarsGjLISKanluvGsr6U5
         iP2pGRll966B8gXYY0Db61fEoR5LAwrGPMmZL1wE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiri Slaby <jslaby@suse.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 119/161] vc_screen: rewrite vcs_size to accept vc, not inode
Date:   Sun, 28 May 2023 20:10:43 +0100
Message-Id: <20230528190840.824792952@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>

[ Upstream commit 71d4abfab322e827a75304431fe0fad3c805cb80 ]

It is weird to fetch the information from the inode over and over. Read
and write already have the needed information, so rewrite vcs_size to
accept a vc, attr and unicode and adapt vcs_lseek to that.

Also make sure all sites check the return value of vcs_size for errors.

And document it using kernel-doc.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Link: https://lore.kernel.org/r/20200818085706.12163-5-jslaby@suse.cz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 8fb9ea65c9d1 ("vc_screen: reload load of struct vc_data pointer in vcs_write() to avoid UAF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/vt/vc_screen.c | 46 ++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 90de3331e4a51..48d74269f1d59 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -200,39 +200,47 @@ vcs_vc(struct inode *inode, int *viewed)
 	return vc_cons[currcons].d;
 }
 
-/*
- * Returns size for VC carried by inode.
+/**
+ * vcs_size -- return size for a VC in @vc
+ * @vc: which VC
+ * @attr: does it use attributes?
+ * @unicode: is it unicode?
+ *
  * Must be called with console_lock.
  */
-static int
-vcs_size(struct inode *inode)
+static int vcs_size(const struct vc_data *vc, bool attr, bool unicode)
 {
 	int size;
-	struct vc_data *vc;
 
 	WARN_CONSOLE_UNLOCKED();
 
-	vc = vcs_vc(inode, NULL);
-	if (!vc)
-		return -ENXIO;
-
 	size = vc->vc_rows * vc->vc_cols;
 
-	if (use_attributes(inode)) {
-		if (use_unicode(inode))
+	if (attr) {
+		if (unicode)
 			return -EOPNOTSUPP;
-		size = 2*size + HEADER_SIZE;
-	} else if (use_unicode(inode))
+
+		size = 2 * size + HEADER_SIZE;
+	} else if (unicode)
 		size *= 4;
+
 	return size;
 }
 
 static loff_t vcs_lseek(struct file *file, loff_t offset, int orig)
 {
+	struct inode *inode = file_inode(file);
+	struct vc_data *vc;
 	int size;
 
 	console_lock();
-	size = vcs_size(file_inode(file));
+	vc = vcs_vc(inode, NULL);
+	if (!vc) {
+		console_unlock();
+		return -ENXIO;
+	}
+
+	size = vcs_size(vc, use_attributes(inode), use_unicode(inode));
 	console_unlock();
 	if (size < 0)
 		return size;
@@ -294,7 +302,7 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		 * as copy_to_user at the end of this loop
 		 * could sleep.
 		 */
-		size = vcs_size(inode);
+		size = vcs_size(vc, attr, uni_mode);
 		if (size < 0) {
 			ret = size;
 			break;
@@ -476,7 +484,11 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	if (!vc)
 		goto unlock_out;
 
-	size = vcs_size(inode);
+	size = vcs_size(vc, attr, false);
+	if (size < 0) {
+		ret = size;
+		goto unlock_out;
+	}
 	ret = -EINVAL;
 	if (pos < 0 || pos > size)
 		goto unlock_out;
@@ -515,7 +527,7 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 		 * the user buffer, so recheck.
 		 * Return data written up to now on failure.
 		 */
-		size = vcs_size(inode);
+		size = vcs_size(vc, attr, false);
 		if (size < 0) {
 			if (written)
 				break;
-- 
2.39.2



