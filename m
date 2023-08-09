Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA549775C59
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbjHIL0Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbjHIL0X (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:26:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC1819A1
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:26:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB2FF63275
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E09C433C9;
        Wed,  9 Aug 2023 11:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580382;
        bh=JsGghG11bIcezQvDbMqfL8Pjf7cg8zu4qiQpHOGVTA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OtdxIRwVAZVmTUH4EpCMf08Isxsakx0l4sb/OTbwE5nae5/Ti9fCKGhjqNZREVHc4
         vzS8i2zuJlXD74uww7Y13xAhw2IeUO0EHRZ14QROh0obuCmyuhR7CSNE9QVRhbfk/1
         W4K/lFrya8rI4Lh09CK72ib/wwB0MGHKT88BAmTM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Xiubo Li <xiubli@redhat.com>
Subject: [PATCH 4.19 306/323] libceph: fix potential hang in ceph_osdc_notify()
Date:   Wed,  9 Aug 2023 12:42:24 +0200
Message-ID: <20230809103712.048258857@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ilya Dryomov <idryomov@gmail.com>

commit e6e2843230799230fc5deb8279728a7218b0d63c upstream.

If the cluster becomes unavailable, ceph_osdc_notify() may hang even
with osd_request_timeout option set because linger_notify_finish_wait()
waits for MWatchNotify NOTIFY_COMPLETE message with no associated OSD
request in flight -- it's completely asynchronous.

Introduce an additional timeout, derived from the specified notify
timeout.  While at it, switch both waits to killable which is more
correct.

Cc: stable@vger.kernel.org
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
Reviewed-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ceph/osd_client.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -3137,17 +3137,24 @@ static int linger_reg_commit_wait(struct
 	int ret;
 
 	dout("%s lreq %p linger_id %llu\n", __func__, lreq, lreq->linger_id);
-	ret = wait_for_completion_interruptible(&lreq->reg_commit_wait);
+	ret = wait_for_completion_killable(&lreq->reg_commit_wait);
 	return ret ?: lreq->reg_commit_error;
 }
 
-static int linger_notify_finish_wait(struct ceph_osd_linger_request *lreq)
+static int linger_notify_finish_wait(struct ceph_osd_linger_request *lreq,
+				     unsigned long timeout)
 {
-	int ret;
+	long left;
 
 	dout("%s lreq %p linger_id %llu\n", __func__, lreq, lreq->linger_id);
-	ret = wait_for_completion_interruptible(&lreq->notify_finish_wait);
-	return ret ?: lreq->notify_finish_error;
+	left = wait_for_completion_killable_timeout(&lreq->notify_finish_wait,
+						ceph_timeout_jiffies(timeout));
+	if (left <= 0)
+		left = left ?: -ETIMEDOUT;
+	else
+		left = lreq->notify_finish_error; /* completed */
+
+	return left;
 }
 
 /*
@@ -4760,7 +4767,8 @@ int ceph_osdc_notify(struct ceph_osd_cli
 
 	ret = linger_reg_commit_wait(lreq);
 	if (!ret)
-		ret = linger_notify_finish_wait(lreq);
+		ret = linger_notify_finish_wait(lreq,
+				 msecs_to_jiffies(2 * timeout * MSEC_PER_SEC));
 	else
 		dout("lreq %p failed to initiate notify %d\n", lreq, ret);
 


