Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F34A79B89E
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359771AbjIKWSj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241769AbjIKPOA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:14:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BAFFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:13:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F2BC433C8;
        Mon, 11 Sep 2023 15:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445235;
        bh=v2zBGQUyyx7eUZ4dJMk6AuhhnAIoHC77HN5out458bw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xcBw9lxC/3dXl+scozuOndirxw8m0uFFIN7wC99XvKE3fysoK4DGqOo48NGu5P8b0
         nI+ljrglI6HbFBt22LkaKitdGh/4t/hrL/14D/MzfAi/WR61lG0LCFFNXN6uIapXsO
         q3w4siIRDo9OpYdazaB7M/lO0NaSoyjLm/TzY3f0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiao Ni <xni@redhat.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 275/600] md: Factor out is_md_suspended helper
Date:   Mon, 11 Sep 2023 15:45:08 +0200
Message-ID: <20230911134641.723842572@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

From: Xiao Ni <xni@redhat.com>

[ Upstream commit d19329133d25ad3dc32f8a62635692cb2f189014 ]

This helper function will be used in next patch. It's easy for
understanding.

Signed-off-by: Xiao Ni <xni@redhat.com>
Signed-off-by: Song Liu <song@kernel.org>
Stable-dep-of: e24ed04389f9 ("md: restore 'noio_flag' for the last mddev_resume()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 45daba0eb9310..abb6c03c85b29 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -368,6 +368,13 @@ EXPORT_SYMBOL_GPL(md_new_event);
 static LIST_HEAD(all_mddevs);
 static DEFINE_SPINLOCK(all_mddevs_lock);
 
+static bool is_md_suspended(struct mddev *mddev)
+{
+	if (mddev->suspended)
+		return true;
+	else
+		return false;
+}
 /* Rather than calling directly into the personality make_request function,
  * IO requests come here first so that we can check if the device is
  * being suspended pending a reconfiguration.
@@ -377,7 +384,7 @@ static DEFINE_SPINLOCK(all_mddevs_lock);
  */
 static bool is_suspended(struct mddev *mddev, struct bio *bio)
 {
-	if (mddev->suspended)
+	if (is_md_suspended(mddev))
 		return true;
 	if (bio_data_dir(bio) != WRITE)
 		return false;
@@ -422,7 +429,7 @@ void md_handle_request(struct mddev *mddev, struct bio *bio)
 		goto check_suspended;
 	}
 
-	if (atomic_dec_and_test(&mddev->active_io) && mddev->suspended)
+	if (atomic_dec_and_test(&mddev->active_io) && is_md_suspended(mddev))
 		wake_up(&mddev->sb_wait);
 }
 EXPORT_SYMBOL(md_handle_request);
@@ -6238,7 +6245,7 @@ EXPORT_SYMBOL_GPL(md_stop_writes);
 static void mddev_detach(struct mddev *mddev)
 {
 	md_bitmap_wait_behind_writes(mddev);
-	if (mddev->pers && mddev->pers->quiesce && !mddev->suspended) {
+	if (mddev->pers && mddev->pers->quiesce && !is_md_suspended(mddev)) {
 		mddev->pers->quiesce(mddev, 1);
 		mddev->pers->quiesce(mddev, 0);
 	}
@@ -8548,7 +8555,7 @@ bool md_write_start(struct mddev *mddev, struct bio *bi)
 		return true;
 	wait_event(mddev->sb_wait,
 		   !test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags) ||
-		   mddev->suspended);
+		   is_md_suspended(mddev));
 	if (test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags)) {
 		percpu_ref_put(&mddev->writes_pending);
 		return false;
@@ -9276,7 +9283,7 @@ void md_check_recovery(struct mddev *mddev)
 		wake_up(&mddev->sb_wait);
 	}
 
-	if (mddev->suspended)
+	if (is_md_suspended(mddev))
 		return;
 
 	if (mddev->bitmap)
-- 
2.40.1



