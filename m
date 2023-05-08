Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAD16FA4D2
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjEHKDd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbjEHKDc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:03:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804E22E6BD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:03:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EACF362026
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C77C433D2;
        Mon,  8 May 2023 10:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540210;
        bh=Zl3yB4I7jmLbr4Wjo08xzHw+k2BrZbWVxUBQSp+G6Ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2rbzk4anuhPccBEFWh25LSequfYG6fx4gN/zH7rw/HHYWIIWXw5tCSWiLl2MYtPnY
         /FmYCYy0M20mlAfqUr1f+uXj3eDlztg/sX70feQGhN92y24rmRdOej49XaJELx8vQI
         8UumsXjNtts7lQN07Spuu9bQKxeHzhLWTdsqc5Ds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 246/611] media: v4l: async: Return async sub-devices to subnotifier list
Date:   Mon,  8 May 2023 11:41:28 +0200
Message-Id: <20230508094430.409653494@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 5276c9df9c2ab9a43b534bfb56bdb10899cd3a22 ]

When an async notifier is unregistered, the async sub-devices in the
notifier's done list will disappear with the notifier. However this is
currently also done to the sub-notifiers that remain registered. Their
sub-devices only need to be unbound while the async sub-devices themselves
need to be returned to the sub-notifier's waiting list. Do this now.

Fixes: 2cab00bb076b ("media: v4l: async: Allow binding notifiers to sub-devices")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-async.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 2f1b718a91893..008a2a3e312e0 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -414,7 +414,8 @@ static void v4l2_async_cleanup(struct v4l2_subdev *sd)
 
 /* Unbind all sub-devices in the notifier tree. */
 static void
-v4l2_async_nf_unbind_all_subdevs(struct v4l2_async_notifier *notifier)
+v4l2_async_nf_unbind_all_subdevs(struct v4l2_async_notifier *notifier,
+				 bool readd)
 {
 	struct v4l2_subdev *sd, *tmp;
 
@@ -423,9 +424,11 @@ v4l2_async_nf_unbind_all_subdevs(struct v4l2_async_notifier *notifier)
 			v4l2_async_find_subdev_notifier(sd);
 
 		if (subdev_notifier)
-			v4l2_async_nf_unbind_all_subdevs(subdev_notifier);
+			v4l2_async_nf_unbind_all_subdevs(subdev_notifier, true);
 
 		v4l2_async_nf_call_unbind(notifier, sd, sd->asd);
+		if (readd)
+			list_add_tail(&sd->asd->list, &notifier->waiting);
 		v4l2_async_cleanup(sd);
 
 		list_move(&sd->async_list, &subdev_list);
@@ -557,7 +560,7 @@ static int __v4l2_async_nf_register(struct v4l2_async_notifier *notifier)
 	/*
 	 * On failure, unbind all sub-devices registered through this notifier.
 	 */
-	v4l2_async_nf_unbind_all_subdevs(notifier);
+	v4l2_async_nf_unbind_all_subdevs(notifier, false);
 
 err_unlock:
 	mutex_unlock(&list_lock);
@@ -607,7 +610,7 @@ __v4l2_async_nf_unregister(struct v4l2_async_notifier *notifier)
 	if (!notifier || (!notifier->v4l2_dev && !notifier->sd))
 		return;
 
-	v4l2_async_nf_unbind_all_subdevs(notifier);
+	v4l2_async_nf_unbind_all_subdevs(notifier, false);
 
 	notifier->sd = NULL;
 	notifier->v4l2_dev = NULL;
@@ -805,7 +808,7 @@ int v4l2_async_register_subdev(struct v4l2_subdev *sd)
 	 */
 	subdev_notifier = v4l2_async_find_subdev_notifier(sd);
 	if (subdev_notifier)
-		v4l2_async_nf_unbind_all_subdevs(subdev_notifier);
+		v4l2_async_nf_unbind_all_subdevs(subdev_notifier, false);
 
 	if (sd->asd)
 		v4l2_async_nf_call_unbind(notifier, sd, sd->asd);
-- 
2.39.2



