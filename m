Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDD87ECFC0
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbjKOTue (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbjKOTud (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:50:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA591A7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:50:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41ABC433C7;
        Wed, 15 Nov 2023 19:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077829;
        bh=e0bbPI4u0TFb93d3EJUd5dRJL5Y+FWGNgTZUaA7B+1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TY6l2f548zqFKnWYD0xDchbeRbwFNrs5VXxhyqFtUrC2Y0kbaRjLPoYyI8aQNcKkT
         /+/kgswwHk0skZaugTwbIxLeI5I8uygoqGcEZdY+gEaDznoJnXE1m71bitx4hHTSa+
         9kYq0ATByHrJD89jhjjVQL2I1FKJHxpKIQon+URU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiaolei Wang <xiaolei.wang@windriver.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 513/603] media: ov5640: Fix a memory leak when ov5640_probe fails
Date:   Wed, 15 Nov 2023 14:17:38 -0500
Message-ID: <20231115191647.599944033@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiaolei Wang <xiaolei.wang@windriver.com>

[ Upstream commit 20290feaaeb76cc719921aad275ccb18662a7c3a ]

sensor->ctrls.handler is initialized in ov5640_init_controls(),
so when the sensor is not connected and ov5640_sensor_resume()
fails, sensor->ctrls.handler should be released, otherwise a
memory leak will be detected:

unreferenced object 0xc674ca80 (size 64):
   comm "swapper/0", pid 1, jiffies 4294938337 (age 204.880s)
   hex dump (first 32 bytes):
     80 55 75 c6 80 54 75 c6 00 55 75 c6 80 52 75 c6 .Uu..Tu..Uu..Ru.
     00 53 75 c6 00 00 00 00 00 00 00 00 00 00 00 00 .Su..........

Fixes: 85644a9b37ec ("media: ov5640: Use runtime PM")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov5640.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 1c9cda1e7df5c..40532f7bcabea 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -3928,7 +3928,7 @@ static int ov5640_probe(struct i2c_client *client)
 	ret = ov5640_sensor_resume(dev);
 	if (ret) {
 		dev_err(dev, "failed to power on\n");
-		goto entity_cleanup;
+		goto free_ctrls;
 	}
 
 	pm_runtime_set_active(dev);
@@ -3953,8 +3953,9 @@ static int ov5640_probe(struct i2c_client *client)
 err_pm_runtime:
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
-	v4l2_ctrl_handler_free(&sensor->ctrls.handler);
 	ov5640_sensor_suspend(dev);
+free_ctrls:
+	v4l2_ctrl_handler_free(&sensor->ctrls.handler);
 entity_cleanup:
 	media_entity_cleanup(&sensor->sd.entity);
 	mutex_destroy(&sensor->lock);
-- 
2.42.0



