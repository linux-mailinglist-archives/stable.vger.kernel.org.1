Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACF27B8A9B
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244480AbjJDShL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244455AbjJDShL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:37:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD349BF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:37:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0125AC433D9;
        Wed,  4 Oct 2023 18:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444627;
        bh=IFWljd12NImMrjTDz0g7RYwJPdFWkROyRKkWNvP+qAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFrDO6BiUgtaFCFXf1JhEwl+bAQ0F6XCLMJTgPpXnOquRCntmZWfoBDhDxfvEqCPa
         k9XAyaEWSnqmzok60BuEdOeabq7OektZ/IWK3qGAA7sYh4XqnSBVgLP/yYldPAKdnf
         OMWBX1730ecOG5fJU0aOdgAu6h3bC1wgOmAPh9/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [PATCH 6.5 318/321] rbd: take header_rwsem in rbd_dev_refresh() only when updating
Date:   Wed,  4 Oct 2023 19:57:43 +0200
Message-ID: <20231004175244.015144337@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

From: Ilya Dryomov <idryomov@gmail.com>

commit 0b207d02bd9ab8dcc31b262ca9f60dbc1822500d upstream.

rbd_dev_refresh() has been holding header_rwsem across header and
parent info read-in unnecessarily for ages.  With commit 870611e4877e
("rbd: get snapshot context after exclusive lock is ensured to be
held"), the potential for deadlocks became much more real owning to
a) header_rwsem now nesting inside lock_rwsem and b) rw_semaphores
not allowing new readers after a writer is registered.

For example, assuming that I/O request 1, I/O request 2 and header
read-in request all target the same OSD:

1. I/O request 1 comes in and gets submitted
2. watch error occurs
3. rbd_watch_errcb() takes lock_rwsem for write, clears owner_cid and
   releases lock_rwsem
4. after reestablishing the watch, rbd_reregister_watch() calls
   rbd_dev_refresh() which takes header_rwsem for write and submits
   a header read-in request
5. I/O request 2 comes in: after taking lock_rwsem for read in
   __rbd_img_handle_request(), it blocks trying to take header_rwsem
   for read in rbd_img_object_requests()
6. another watch error occurs
7. rbd_watch_errcb() blocks trying to take lock_rwsem for write
8. I/O request 1 completion is received by the messenger but can't be
   processed because lock_rwsem won't be granted anymore
9. header read-in request completion can't be received, let alone
   processed, because the messenger is stranded

Change rbd_dev_refresh() to take header_rwsem only for actually
updating rbd_dev->header.  Header and parent info read-in don't need
any locking.

Cc: stable@vger.kernel.org # 0b035401c570: rbd: move rbd_dev_refresh() definition
Cc: stable@vger.kernel.org # 510a7330c82a: rbd: decouple header read-in from updating rbd_dev->header
Cc: stable@vger.kernel.org # c10311776f0a: rbd: decouple parent info read-in from updating rbd_dev
Cc: stable@vger.kernel.org
Fixes: 870611e4877e ("rbd: get snapshot context after exclusive lock is ensured to be held")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/rbd.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6986,7 +6986,14 @@ static void rbd_dev_update_header(struct
 	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
 	rbd_assert(rbd_dev->header.object_prefix); /* !first_time */
 
-	rbd_dev->header.image_size = header->image_size;
+	if (rbd_dev->header.image_size != header->image_size) {
+		rbd_dev->header.image_size = header->image_size;
+
+		if (!rbd_is_snap(rbd_dev)) {
+			rbd_dev->mapping.size = header->image_size;
+			rbd_dev_update_size(rbd_dev);
+		}
+	}
 
 	ceph_put_snap_context(rbd_dev->header.snapc);
 	rbd_dev->header.snapc = header->snapc;
@@ -7044,11 +7051,9 @@ static int rbd_dev_refresh(struct rbd_de
 {
 	struct rbd_image_header	header = { 0 };
 	struct parent_image_info pii = { 0 };
-	u64 mapping_size;
 	int ret;
 
-	down_write(&rbd_dev->header_rwsem);
-	mapping_size = rbd_dev->mapping.size;
+	dout("%s rbd_dev %p\n", __func__, rbd_dev);
 
 	ret = rbd_dev_header_info(rbd_dev, &header, false);
 	if (ret)
@@ -7064,18 +7069,13 @@ static int rbd_dev_refresh(struct rbd_de
 			goto out;
 	}
 
+	down_write(&rbd_dev->header_rwsem);
 	rbd_dev_update_header(rbd_dev, &header);
 	if (rbd_dev->parent)
 		rbd_dev_update_parent(rbd_dev, &pii);
-
-	rbd_assert(!rbd_is_snap(rbd_dev));
-	rbd_dev->mapping.size = rbd_dev->header.image_size;
-
-out:
 	up_write(&rbd_dev->header_rwsem);
-	if (!ret && mapping_size != rbd_dev->mapping.size)
-		rbd_dev_update_size(rbd_dev);
 
+out:
 	rbd_parent_info_cleanup(&pii);
 	rbd_image_header_cleanup(&header);
 	return ret;


