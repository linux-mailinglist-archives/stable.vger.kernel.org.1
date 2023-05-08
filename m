Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B556FAB07
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjEHLIq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjEHLIT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:08:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEA831EEF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:08:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D834062AFD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE767C433EF;
        Mon,  8 May 2023 11:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544096;
        bh=4632fbugsGT7no4S4NBzvQVSfnylYB1F/CeIHt4BM7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Z1Gse140stJ83y+teh/c8v/yj3saQGJfpLD2dlfpRWmviuJ3gVPNK1HgfmlxSCSo
         1mPau/rpi2MQDYKRyopndLrX7kwDz0LFYL3MdzW1zcPj4IpKgWNPqvHGPI06VssTNU
         ar7ZfRsZ67uBUVDXH6uurljBD5VqH6wvBZYqZJzU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 300/694] media: v4l: async: Return async sub-devices to subnotifier list
Date:   Mon,  8 May 2023 11:42:15 +0200
Message-Id: <20230508094442.009367151@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index d7e9ffc7aa237..b16b5f4cb91e2 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -416,7 +416,8 @@ static void v4l2_async_cleanup(struct v4l2_subdev *sd)
 
 /* Unbind all sub-devices in the notifier tree. */
 static void
-v4l2_async_nf_unbind_all_subdevs(struct v4l2_async_notifier *notifier)
+v4l2_async_nf_unbind_all_subdevs(struct v4l2_async_notifier *notifier,
+				 bool readd)
 {
 	struct v4l2_subdev *sd, *tmp;
 
@@ -425,9 +426,11 @@ v4l2_async_nf_unbind_all_subdevs(struct v4l2_async_notifier *notifier)
 			v4l2_async_find_subdev_notifier(sd);
 
 		if (subdev_notifier)
-			v4l2_async_nf_unbind_all_subdevs(subdev_notifier);
+			v4l2_async_nf_unbind_all_subdevs(subdev_notifier, true);
 
 		v4l2_async_nf_call_unbind(notifier, sd, sd->asd);
+		if (readd)
+			list_add_tail(&sd->asd->list, &notifier->waiting);
 		v4l2_async_cleanup(sd);
 
 		list_move(&sd->async_list, &subdev_list);
@@ -559,7 +562,7 @@ static int __v4l2_async_nf_register(struct v4l2_async_notifier *notifier)
 	/*
 	 * On failure, unbind all sub-devices registered through this notifier.
 	 */
-	v4l2_async_nf_unbind_all_subdevs(notifier);
+	v4l2_async_nf_unbind_all_subdevs(notifier, false);
 
 err_unlock:
 	mutex_unlock(&list_lock);
@@ -609,7 +612,7 @@ __v4l2_async_nf_unregister(struct v4l2_async_notifier *notifier)
 	if (!notifier || (!notifier->v4l2_dev && !notifier->sd))
 		return;
 
-	v4l2_async_nf_unbind_all_subdevs(notifier);
+	v4l2_async_nf_unbind_all_subdevs(notifier, false);
 
 	notifier->sd = NULL;
 	notifier->v4l2_dev = NULL;
@@ -807,7 +810,7 @@ int v4l2_async_register_subdev(struct v4l2_subdev *sd)
 	 */
 	subdev_notifier = v4l2_async_find_subdev_notifier(sd);
 	if (subdev_notifier)
-		v4l2_async_nf_unbind_all_subdevs(subdev_notifier);
+		v4l2_async_nf_unbind_all_subdevs(subdev_notifier, false);
 
 	if (sd->asd)
 		v4l2_async_nf_call_unbind(notifier, sd, sd->asd);
-- 
2.39.2



