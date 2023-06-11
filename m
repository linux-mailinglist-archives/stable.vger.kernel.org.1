Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D078372B36A
	for <lists+stable@lfdr.de>; Sun, 11 Jun 2023 20:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjFKSmj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 11 Jun 2023 14:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFKSmi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Jun 2023 14:42:38 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74AA13E
        for <stable@vger.kernel.org>; Sun, 11 Jun 2023 11:42:36 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so5182507a12.0
        for <stable@vger.kernel.org>; Sun, 11 Jun 2023 11:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686508955; x=1689100955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tQ0U4VgrFzYNQw32J4p9U+WNh1xNQSz3+s8meXCehgU=;
        b=cQ+9tTCjfxtl2e3CXEz36SBJ1a8TwnKnWpDcJk3j+Wfp/7+mBpEgMgbebY27uEt0wW
         Nui7UztQcjmhuPzs2XMmw6BfUSbP7dvpP3UT4nJhf/pf6ovkVcfaBDHeKNIKB1qAAuPP
         NBLMsRRsMP5drJLufEjmBw0hM4aqFLf4Zzo2ou8h69vsos3BR3Ai0n+LhZlb7BvM4QJJ
         xiZeqL7Al3ortlSGGdmq03n/fzf+y8bTlPvWwNyxm4BEKC83XQ+7/iXeur+HFrawGu33
         Lg9xbrQ2M3N/9it8E6CrPY44bqSvIAwlMNkUdHHEiw9mACte9eMLXe/t4HCubixV88Fl
         HgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686508955; x=1689100955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQ0U4VgrFzYNQw32J4p9U+WNh1xNQSz3+s8meXCehgU=;
        b=UFCxaqq8EfD6c+IQf3/rK6usX7JI26Ok1ryg2ASy44oa0sltP1gd5qaADu1y9edYjJ
         kgDG987C4wrdTQ7FbuXlMldvax43e01kbgxnOEL5AV7Jia2FumalTeDiwCiDCv35yTWu
         difWhFE2DYUcrUEWKPskhzfasAIrpxcvSg329Ec6AovKMYOSn8zn0Qls9fzLZhRChFvK
         tIxJg6NjONzR59xBzmy5AwPWYf+hQ5FhezvrJ5/NrzCvmkGnTb/t1qxMQ79bEWm4OuGD
         86thb7+xXD54CrTCRyHGy7XEAc8oJvFKyiwo259Szq19IVlhQuMiWjdq3CA9UiSuMNHu
         81+g==
X-Gm-Message-State: AC+VfDz8YriK8xk77ouQ2+5f3ChIY26Npi3PQlnapDkQW0GZcrbj7fOy
        4lX9CfyOxQuzY6ogKY+fVAR41rKefNY=
X-Google-Smtp-Source: ACHHUZ4i5OWhcs2swQtOHTuDGLYSohFgkasSX4NjxzHoxGst3W8UL6g/xkn5SrnjW3/zggxd9wL2Tw==
X-Received: by 2002:a17:907:7e97:b0:981:82c0:15bb with SMTP id qb23-20020a1709077e9700b0098182c015bbmr1344323ejc.0.1686508954882;
        Sun, 11 Jun 2023 11:42:34 -0700 (PDT)
Received: from zambezi.local (ip-94-112-104-28.bb.vodafone.cz. [94.112.104.28])
        by smtp.gmail.com with ESMTPSA id e4-20020a056402088400b00516323ef3a9sm4172101edy.49.2023.06.11.11.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 11:42:33 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [PATCH for 5.4] rbd: get snapshot context after exclusive lock is ensured to be held
Date:   Sun, 11 Jun 2023 20:41:27 +0200
Message-Id: <20230611184127.29830-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
[idryomov@gmail.com: backport to 5.4: no rbd_img_capture_header(),
 img_request not embedded in blk-mq pdu]
---
 drivers/block/rbd.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 22b282409a16..9d21f90f93f0 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1495,6 +1495,8 @@ static bool rbd_obj_is_tail(struct rbd_obj_request *obj_req)
  */
 static void rbd_obj_set_copyup_enabled(struct rbd_obj_request *obj_req)
 {
+	rbd_assert(obj_req->img_request->snapc);
+
 	if (obj_req->img_request->op_type == OBJ_OP_DISCARD) {
 		dout("%s %p objno %llu discard\n", __func__, obj_req,
 		     obj_req->ex.oe_objno);
@@ -1613,6 +1615,7 @@ __rbd_obj_add_osd_request(struct rbd_obj_request *obj_req,
 static struct ceph_osd_request *
 rbd_obj_add_osd_request(struct rbd_obj_request *obj_req, int num_ops)
 {
+	rbd_assert(obj_req->img_request->snapc);
 	return __rbd_obj_add_osd_request(obj_req, obj_req->img_request->snapc,
 					 num_ops);
 }
@@ -1741,11 +1744,14 @@ static bool rbd_dev_parent_get(struct rbd_device *rbd_dev)
  * Caller is responsible for filling in the list of object requests
  * that comprises the image request, and the Linux request pointer
  * (if there is one).
+ *
+ * Only snap_id is captured here, for reads.  For writes, snapshot
+ * context is captured in rbd_img_object_requests() after exclusive
+ * lock is ensured to be held.
  */
 static struct rbd_img_request *rbd_img_request_create(
 					struct rbd_device *rbd_dev,
-					enum obj_operation_type op_type,
-					struct ceph_snap_context *snapc)
+					enum obj_operation_type op_type)
 {
 	struct rbd_img_request *img_request;
 
@@ -1757,8 +1763,6 @@ static struct rbd_img_request *rbd_img_request_create(
 	img_request->op_type = op_type;
 	if (!rbd_img_is_write(img_request))
 		img_request->snap_id = rbd_dev->spec->snap_id;
-	else
-		img_request->snapc = snapc;
 
 	if (rbd_dev_parent_get(rbd_dev))
 		img_request_layered_set(img_request);
@@ -2944,7 +2948,7 @@ static int rbd_obj_read_from_parent(struct rbd_obj_request *obj_req)
 	int ret;
 
 	child_img_req = rbd_img_request_create(img_req->rbd_dev->parent,
-					       OBJ_OP_READ, NULL);
+					       OBJ_OP_READ);
 	if (!child_img_req)
 		return -ENOMEM;
 
@@ -3635,9 +3639,19 @@ static int rbd_img_exclusive_lock(struct rbd_img_request *img_req)
 
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
@@ -3655,7 +3669,6 @@ static void rbd_img_object_requests(struct rbd_img_request *img_req)
 
 static bool rbd_img_advance(struct rbd_img_request *img_req, int *result)
 {
-	struct rbd_device *rbd_dev = img_req->rbd_dev;
 	int ret;
 
 again:
@@ -3676,9 +3689,6 @@ static bool rbd_img_advance(struct rbd_img_request *img_req, int *result)
 		if (*result)
 			return true;
 
-		rbd_assert(!need_exclusive_lock(img_req) ||
-			   __rbd_is_lock_owner(rbd_dev));
-
 		rbd_img_object_requests(img_req);
 		if (!img_req->pending.num_pending) {
 			*result = img_req->pending.result;
@@ -4140,6 +4150,10 @@ static int rbd_post_acquire_action(struct rbd_device *rbd_dev)
 {
 	int ret;
 
+	ret = rbd_dev_refresh(rbd_dev);
+	if (ret)
+		return ret;
+
 	if (rbd_dev->header.features & RBD_FEATURE_OBJECT_MAP) {
 		ret = rbd_object_map_open(rbd_dev);
 		if (ret)
@@ -4798,7 +4812,6 @@ static void rbd_queue_workfn(struct work_struct *work)
 	struct request *rq = blk_mq_rq_from_pdu(work);
 	struct rbd_device *rbd_dev = rq->q->queuedata;
 	struct rbd_img_request *img_request;
-	struct ceph_snap_context *snapc = NULL;
 	u64 offset = (u64)blk_rq_pos(rq) << SECTOR_SHIFT;
 	u64 length = blk_rq_bytes(rq);
 	enum obj_operation_type op_type;
@@ -4863,10 +4876,6 @@ static void rbd_queue_workfn(struct work_struct *work)
 
 	down_read(&rbd_dev->header_rwsem);
 	mapping_size = rbd_dev->mapping.size;
-	if (op_type != OBJ_OP_READ) {
-		snapc = rbd_dev->header.snapc;
-		ceph_get_snap_context(snapc);
-	}
 	up_read(&rbd_dev->header_rwsem);
 
 	if (offset + length > mapping_size) {
@@ -4876,13 +4885,12 @@ static void rbd_queue_workfn(struct work_struct *work)
 		goto err_rq;
 	}
 
-	img_request = rbd_img_request_create(rbd_dev, op_type, snapc);
+	img_request = rbd_img_request_create(rbd_dev, op_type);
 	if (!img_request) {
 		result = -ENOMEM;
 		goto err_rq;
 	}
 	img_request->rq = rq;
-	snapc = NULL; /* img_request consumes a ref */
 
 	dout("%s rbd_dev %p img_req %p %s %llu~%llu\n", __func__, rbd_dev,
 	     img_request, obj_op_name(op_type), offset, length);
@@ -4904,7 +4912,6 @@ static void rbd_queue_workfn(struct work_struct *work)
 	if (result)
 		rbd_warn(rbd_dev, "%s %llx at %llx result %d",
 			 obj_op_name(op_type), length, offset, result);
-	ceph_put_snap_context(snapc);
 err:
 	blk_mq_end_request(rq, errno_to_blk_status(result));
 }
-- 
2.40.1

