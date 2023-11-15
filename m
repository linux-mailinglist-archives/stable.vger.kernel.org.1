Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F7B7E2403
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjKFNRL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbjKFNRK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:17:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A999F3
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:17:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF237C433C8;
        Mon,  6 Nov 2023 13:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276627;
        bh=kwnoC+uNfRjt289lGFuKfSbvenq4alxN0/3u2ck4dx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vu+gfPaQ8iXt6kypUxkl47hr29IiZHhEOxRx9Eax5RhhJxtTvHdqGc1ihGCFdg+0W
         6ebjnw75Oaywg07/TINXz+9KTAcM598ZG8NljbiS+c1wxrWsSXGBEJuYX7xo8hudxs
         N+pEjZM6b7ajp+tItQHpOrcffKkmbTCzJ0GY+juo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ondrej Jirman <megi@xff.cz>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 16/88] media: i2c: ov8858: Dont set fwnode in the driver
Date:   Mon,  6 Nov 2023 14:03:10 +0100
Message-ID: <20231106130306.394206308@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ondrej Jirman <megi@xff.cz>

[ Upstream commit c46f16f156ac58afcf4addc850bb5dfbca77b9fc ]

This makes the driver work with the new check in
v4l2_async_register_subdev() that was introduced recently in 6.6-rc1.
Without this change, probe fails with:

ov8858 1-0036: Detected OV8858 sensor, revision 0xb2
ov8858 1-0036: sub-device fwnode is an endpoint!
ov8858 1-0036: v4l2 async register subdev failed
ov8858: probe of 1-0036 failed with error -22

This also simplifies the driver a bit.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov8858.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/ov8858.c b/drivers/media/i2c/ov8858.c
index 3af6125a2eee8..4d9fd76e2f60f 100644
--- a/drivers/media/i2c/ov8858.c
+++ b/drivers/media/i2c/ov8858.c
@@ -1850,9 +1850,9 @@ static int ov8858_parse_of(struct ov8858 *ov8858)
 	}
 
 	ret = v4l2_fwnode_endpoint_parse(endpoint, &vep);
+	fwnode_handle_put(endpoint);
 	if (ret) {
 		dev_err(dev, "Failed to parse endpoint: %d\n", ret);
-		fwnode_handle_put(endpoint);
 		return ret;
 	}
 
@@ -1864,12 +1864,9 @@ static int ov8858_parse_of(struct ov8858 *ov8858)
 	default:
 		dev_err(dev, "Unsupported number of data lanes %u\n",
 			ov8858->num_lanes);
-		fwnode_handle_put(endpoint);
 		return -EINVAL;
 	}
 
-	ov8858->subdev.fwnode = endpoint;
-
 	return 0;
 }
 
@@ -1913,7 +1910,7 @@ static int ov8858_probe(struct i2c_client *client)
 
 	ret = ov8858_init_ctrls(ov8858);
 	if (ret)
-		goto err_put_fwnode;
+		return ret;
 
 	sd = &ov8858->subdev;
 	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
@@ -1964,8 +1961,6 @@ static int ov8858_probe(struct i2c_client *client)
 	media_entity_cleanup(&sd->entity);
 err_free_handler:
 	v4l2_ctrl_handler_free(&ov8858->ctrl_handler);
-err_put_fwnode:
-	fwnode_handle_put(ov8858->subdev.fwnode);
 
 	return ret;
 }
@@ -1978,7 +1973,6 @@ static void ov8858_remove(struct i2c_client *client)
 	v4l2_async_unregister_subdev(sd);
 	media_entity_cleanup(&sd->entity);
 	v4l2_ctrl_handler_free(&ov8858->ctrl_handler);
-	fwnode_handle_put(ov8858->subdev.fwnode);
 
 	pm_runtime_disable(&client->dev);
 	if (!pm_runtime_status_suspended(&client->dev))
-- 
2.42.0



