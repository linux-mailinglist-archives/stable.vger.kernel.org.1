Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC3D72BFD3
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjFLKrQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbjFLKqw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:46:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91173768D
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:31:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5225361500
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649A1C433EF;
        Mon, 12 Jun 2023 10:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565888;
        bh=dCW03YcQ7Sp8gb5yhGj9XFZ6AhfxdonTI6+xK0RH5Xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jz+V/wIOX0EEOb8TfJWJkYFvzOK5T/1YYxXI0tsyRS1HUoofGE9SdXr8DzE7fiyPi
         w3VtgKQ7X1AwF1fJUXjXXrPF+9Y3KsrW+hvigafNqdmarfFubtS2TTO2sA3v3Updjg
         Q+2APg43Q+OmSaS+DHupjgvSoN/WExgOxmska0xI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [PATCH 5.4 30/45] rbd: move RBD_OBJ_FLAG_COPYUP_ENABLED flag setting
Date:   Mon, 12 Jun 2023 12:26:24 +0200
Message-ID: <20230612101655.882266373@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101654.644983109@linuxfoundation.org>
References: <20230612101654.644983109@linuxfoundation.org>
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

commit 09fe05c57b5aaf23e2c35036c98ea9f282b19a77 upstream.

Move RBD_OBJ_FLAG_COPYUP_ENABLED flag setting into the object request
state machine to allow for the snapshot context to be captured in the
image request state machine rather than in rbd_queue_workfn().

Cc: stable@vger.kernel.org
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/rbd.c |   32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1493,14 +1493,28 @@ static bool rbd_obj_is_tail(struct rbd_o
 /*
  * Must be called after rbd_obj_calc_img_extents().
  */
-static bool rbd_obj_copyup_enabled(struct rbd_obj_request *obj_req)
+static void rbd_obj_set_copyup_enabled(struct rbd_obj_request *obj_req)
 {
-	if (!obj_req->num_img_extents ||
-	    (rbd_obj_is_entire(obj_req) &&
-	     !obj_req->img_request->snapc->num_snaps))
-		return false;
+	if (obj_req->img_request->op_type == OBJ_OP_DISCARD) {
+		dout("%s %p objno %llu discard\n", __func__, obj_req,
+		     obj_req->ex.oe_objno);
+		return;
+	}
 
-	return true;
+	if (!obj_req->num_img_extents) {
+		dout("%s %p objno %llu not overlapping\n", __func__, obj_req,
+		     obj_req->ex.oe_objno);
+		return;
+	}
+
+	if (rbd_obj_is_entire(obj_req) &&
+	    !obj_req->img_request->snapc->num_snaps) {
+		dout("%s %p objno %llu entire\n", __func__, obj_req,
+		     obj_req->ex.oe_objno);
+		return;
+	}
+
+	obj_req->flags |= RBD_OBJ_FLAG_COPYUP_ENABLED;
 }
 
 static u64 rbd_obj_img_extents_bytes(struct rbd_obj_request *obj_req)
@@ -2389,9 +2403,6 @@ static int rbd_obj_init_write(struct rbd
 	if (ret)
 		return ret;
 
-	if (rbd_obj_copyup_enabled(obj_req))
-		obj_req->flags |= RBD_OBJ_FLAG_COPYUP_ENABLED;
-
 	obj_req->write_state = RBD_OBJ_WRITE_START;
 	return 0;
 }
@@ -2497,8 +2508,6 @@ static int rbd_obj_init_zeroout(struct r
 	if (ret)
 		return ret;
 
-	if (rbd_obj_copyup_enabled(obj_req))
-		obj_req->flags |= RBD_OBJ_FLAG_COPYUP_ENABLED;
 	if (!obj_req->num_img_extents) {
 		obj_req->flags |= RBD_OBJ_FLAG_NOOP_FOR_NONEXISTENT;
 		if (rbd_obj_is_entire(obj_req))
@@ -3439,6 +3448,7 @@ again:
 	case RBD_OBJ_WRITE_START:
 		rbd_assert(!*result);
 
+		rbd_obj_set_copyup_enabled(obj_req);
 		if (rbd_obj_write_is_noop(obj_req))
 			return true;
 


