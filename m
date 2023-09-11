Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C658079B04D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244919AbjIKVIb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbjIKOQd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:16:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D42E0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:16:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FBCC433C7;
        Mon, 11 Sep 2023 14:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441788;
        bh=X4G/AWkmIJicMDvuC4Yup2HWdyOxg0+OG9Cr6rCHizY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YQIITdZOPqRP/On+4wTpyxrFPsSyMCplY3QvMVbhZVg5EZGZhi+czzjhXOet1JEjw
         w8pI0+bBPVdHCv9ayGqYZhHXE304fWcCiDqAfvjNEKW6EaRvDVGnjAbVVNv5ZkGad5
         c2b1kvzXh6NDxF9blBnF93pzaOwSxn57inx9DH+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 537/739] HID: nvidia-shield: Remove led_classdev_unregister in thunderstrike_create
Date:   Mon, 11 Sep 2023 15:45:36 +0200
Message-ID: <20230911134706.101024692@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

[ Upstream commit cb818a047f2b95f3d9e08568ff7f8f513832ff2f ]

Avoid calling thunderstrike_led_set_brightness from thunderstrike_create
when led_classdev_unregister is called. led_classdev_unregister was called
from thunderstrike_create in the error path. Calling
thunderstrike_led_set_brightness in this situation is unsafe.

Fixes: f88af60e74a5 ("HID: nvidia-shield: Support LED functionality for Thunderstrike")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-nvidia-shield.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shield.c
index a928ad2be62db..4e183650c4478 100644
--- a/drivers/hid/hid-nvidia-shield.c
+++ b/drivers/hid/hid-nvidia-shield.c
@@ -513,21 +513,22 @@ static struct shield_device *thunderstrike_create(struct hid_device *hdev)
 
 	hid_set_drvdata(hdev, shield_dev);
 
+	ts->haptics_dev = shield_haptics_create(shield_dev, thunderstrike_play_effect);
+	if (IS_ERR(ts->haptics_dev))
+		return ERR_CAST(ts->haptics_dev);
+
 	ret = thunderstrike_led_create(ts);
 	if (ret) {
 		hid_err(hdev, "Failed to create Thunderstrike LED instance\n");
-		return ERR_PTR(ret);
-	}
-
-	ts->haptics_dev = shield_haptics_create(shield_dev, thunderstrike_play_effect);
-	if (IS_ERR(ts->haptics_dev))
 		goto err;
+	}
 
 	hid_info(hdev, "Registered Thunderstrike controller\n");
 	return shield_dev;
 
 err:
-	led_classdev_unregister(&ts->led_dev);
+	if (ts->haptics_dev)
+		input_unregister_device(ts->haptics_dev);
 	return ERR_CAST(ts->haptics_dev);
 }
 
-- 
2.40.1



