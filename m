Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE5272C119
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbjFLK4Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235846AbjFLK4I (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:56:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79533525F
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:43:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1031D612E1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EE3C433D2;
        Mon, 12 Jun 2023 10:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566618;
        bh=YGT5O8LWmbRI8kOfxccvDKASF56ZcRywHubGzlAHvOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p5lAlywPqLlRP91JkARuriNPHiztYfMWmly4uau3D0+cY6KhgQsEkbehLXy85vH9B
         0SlEXSQFDRtiy6DJWM9nZaiqB9xsaimO5wHKtdootV8JI0+mWynW68GTm2YaARtTau
         hS8NaxwuAiWvzz93NTBvZWEcLTwYldk5O2Dahs7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [PATCH 6.1 093/132] rbd: get snapshot context after exclusive lock is ensured to be held
Date:   Mon, 12 Jun 2023 12:27:07 +0200
Message-ID: <20230612101714.470934970@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

From: Ilya Dryomov <idryomov@gmail.com>

commit 870611e4877eff1e8413c3fb92a585e45d5291f6 upstream.

Move capturing the snapshot context into the image request state
machine, after exclusive lock is ensured to be held for the duration of
dealing with the image request.  This is needed to ensure correctness
of fast-diff states (OBJECT_EXISTS vs OBJECT_EXISTS_CLEAN) and object
deltas computed based off of them.  Otherwise the object map that is
forked for the snapshot isn't guaranteed to accurately reflect the
contents of the snapshot when the snapshot is taken under I/O.  This
breaks differential backup and snapshot-based mirroring use cases with
fast-diff enabled: since some object deltas may be incomplete, the
destination image may get corrupted.

Cc: stable@vger.kernel.org
Link: https://tracker.ceph.com/issues/61472
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/rbd.c |   30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1336,6 +1336,8 @@ static bool rbd_obj_is_tail(struct rbd_o
  */
 static void rbd_obj_set_copyup_enabled(struct rbd_obj_request *obj_req)
 {
+	rbd_assert(obj_req->img_request->snapc);
+
 	if (obj_req->img_request->op_type == OBJ_OP_DISCARD) {
 		dout("%s %p objno %llu discard\n", __func__, obj_req,
 		     obj_req->ex.oe_objno);
@@ -1456,6 +1458,7 @@ __rbd_obj_add_osd_request(struct rbd_obj
 static struct ceph_osd_request *
 rbd_obj_add_osd_request(struct rbd_obj_request *obj_req, int num_ops)
 {
+	rbd_assert(obj_req->img_request->snapc);
 	return __rbd_obj_add_osd_request(obj_req, obj_req->img_request->snapc,
 					 num_ops);
 }
@@ -1592,15 +1595,18 @@ static void rbd_img_request_init(struct
 	mutex_init(&img_request->state_mutex);
 }
 
+/*
+ * Only snap_id is captured here, for reads.  For writes, snapshot
+ * context is captured in rbd_img_object_requests() after exclusive
+ * lock is ensured to be held.
+ */
 static void rbd_img_capture_header(struct rbd_img_request *img_req)
 {
 	struct rbd_device *rbd_dev = img_req->rbd_dev;
 
 	lockdep_assert_held(&rbd_dev->header_rwsem);
 
-	if (rbd_img_is_write(img_req))
-		img_req->snapc = ceph_get_snap_context(rbd_dev->header.snapc);
-	else
+	if (!rbd_img_is_write(img_req))
 		img_req->snap_id = rbd_dev->spec->snap_id;
 
 	if (rbd_dev_parent_get(rbd_dev))
@@ -3483,9 +3489,19 @@ static int rbd_img_exclusive_lock(struct
 
 static void rbd_img_object_requests(struct rbd_img_request *img_req)
 {
+	struct rbd_device *rbd_dev = img_req->rbd_dev;
 	struct rbd_obj_request *obj_req;
 
 	rbd_assert(!img_req->pending.result && !img_req->pending.num_pending);
+	rbd_assert(!need_exclusive_lock(img_req) ||
+		   __rbd_is_lock_owner(rbd_dev));
+
+	if (rbd_img_is_write(img_req)) {
+		rbd_assert(!img_req->snapc);
+		down_read(&rbd_dev->header_rwsem);
+		img_req->snapc = ceph_get_snap_context(rbd_dev->header.snapc);
+		up_read(&rbd_dev->header_rwsem);
+	}
 
 	for_each_obj_request(img_req, obj_req) {
 		int result = 0;
@@ -3503,7 +3519,6 @@ static void rbd_img_object_requests(stru
 
 static bool rbd_img_advance(struct rbd_img_request *img_req, int *result)
 {
-	struct rbd_device *rbd_dev = img_req->rbd_dev;
 	int ret;
 
 again:
@@ -3524,9 +3539,6 @@ again:
 		if (*result)
 			return true;
 
-		rbd_assert(!need_exclusive_lock(img_req) ||
-			   __rbd_is_lock_owner(rbd_dev));
-
 		rbd_img_object_requests(img_req);
 		if (!img_req->pending.num_pending) {
 			*result = img_req->pending.result;
@@ -3988,6 +4000,10 @@ static int rbd_post_acquire_action(struc
 {
 	int ret;
 
+	ret = rbd_dev_refresh(rbd_dev);
+	if (ret)
+		return ret;
+
 	if (rbd_dev->header.features & RBD_FEATURE_OBJECT_MAP) {
 		ret = rbd_object_map_open(rbd_dev);
 		if (ret)


