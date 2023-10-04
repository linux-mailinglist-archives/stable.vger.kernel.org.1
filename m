Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06C27B84FB
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 18:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243337AbjJDQZI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 12:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243287AbjJDQZI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 12:25:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD4DA7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 09:25:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDBBC433C8;
        Wed,  4 Oct 2023 16:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696436704;
        bh=pYGts5f3WfGNDwYHynbPyFX24BPx2eyJtXlHF7M9SXs=;
        h=Subject:To:Cc:From:Date:From;
        b=a9Rv++8BFHF5GO9oWt214O2rOitX7WWoYf9UTyCJw3BTCwZWah7OnTXLS7+/iN0OF
         6/t5JOFPT7cTWCykEejat2SDPapvAT6+SfQT3w7u35iVuG0BEaB7ON+30uRWutD1Uq
         Ss4goaqtkC7HmFByQL/rXn07sSt8IDvVlcNFmmvk=
Subject: FAILED: patch "[PATCH] rbd: move rbd_dev_refresh() definition" failed to apply to 6.1-stable tree
To:     idryomov@gmail.com, dongsheng.yang@easystack.cn
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 04 Oct 2023 18:25:01 +0200
Message-ID: <2023100401-brunch-clutch-5341@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0b035401c570
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100401-brunch-clutch-5341@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0b035401c57021fc6c300272cbb1c5a889d4fe45 Mon Sep 17 00:00:00 2001
From: Ilya Dryomov <idryomov@gmail.com>
Date: Sun, 17 Sep 2023 15:07:40 +0200
Subject: [PATCH] rbd: move rbd_dev_refresh() definition

Move rbd_dev_refresh() definition further down to avoid having to
move struct parent_image_info definition in the next commit.  This
spares some forward declarations too.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Dongsheng Yang <dongsheng.yang@easystack.cn>

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 3de11f077144..5da001f1fe94 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -633,8 +633,6 @@ static void rbd_dev_remove_parent(struct rbd_device *rbd_dev);
 
 static int rbd_dev_refresh(struct rbd_device *rbd_dev);
 static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev);
-static int rbd_dev_header_info(struct rbd_device *rbd_dev);
-static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev);
 static const char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev,
 					u64 snap_id);
 static int _rbd_dev_v2_snap_size(struct rbd_device *rbd_dev, u64 snap_id,
@@ -4931,39 +4929,6 @@ static void rbd_dev_update_size(struct rbd_device *rbd_dev)
 	}
 }
 
-static int rbd_dev_refresh(struct rbd_device *rbd_dev)
-{
-	u64 mapping_size;
-	int ret;
-
-	down_write(&rbd_dev->header_rwsem);
-	mapping_size = rbd_dev->mapping.size;
-
-	ret = rbd_dev_header_info(rbd_dev);
-	if (ret)
-		goto out;
-
-	/*
-	 * If there is a parent, see if it has disappeared due to the
-	 * mapped image getting flattened.
-	 */
-	if (rbd_dev->parent) {
-		ret = rbd_dev_v2_parent_info(rbd_dev);
-		if (ret)
-			goto out;
-	}
-
-	rbd_assert(!rbd_is_snap(rbd_dev));
-	rbd_dev->mapping.size = rbd_dev->header.image_size;
-
-out:
-	up_write(&rbd_dev->header_rwsem);
-	if (!ret && mapping_size != rbd_dev->mapping.size)
-		rbd_dev_update_size(rbd_dev);
-
-	return ret;
-}
-
 static const struct blk_mq_ops rbd_mq_ops = {
 	.queue_rq	= rbd_queue_rq,
 };
@@ -7043,6 +7008,39 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
 	return ret;
 }
 
+static int rbd_dev_refresh(struct rbd_device *rbd_dev)
+{
+	u64 mapping_size;
+	int ret;
+
+	down_write(&rbd_dev->header_rwsem);
+	mapping_size = rbd_dev->mapping.size;
+
+	ret = rbd_dev_header_info(rbd_dev);
+	if (ret)
+		goto out;
+
+	/*
+	 * If there is a parent, see if it has disappeared due to the
+	 * mapped image getting flattened.
+	 */
+	if (rbd_dev->parent) {
+		ret = rbd_dev_v2_parent_info(rbd_dev);
+		if (ret)
+			goto out;
+	}
+
+	rbd_assert(!rbd_is_snap(rbd_dev));
+	rbd_dev->mapping.size = rbd_dev->header.image_size;
+
+out:
+	up_write(&rbd_dev->header_rwsem);
+	if (!ret && mapping_size != rbd_dev->mapping.size)
+		rbd_dev_update_size(rbd_dev);
+
+	return ret;
+}
+
 static ssize_t do_rbd_add(const char *buf, size_t count)
 {
 	struct rbd_device *rbd_dev = NULL;

