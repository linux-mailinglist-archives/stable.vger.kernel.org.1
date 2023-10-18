Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80267CDB3B
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 14:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjJRMFm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 08:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjJRMFl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 08:05:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C846BA
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 05:05:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F72C433CC;
        Wed, 18 Oct 2023 12:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697630738;
        bh=tPz0Fx6ZbqxlkVWTc6XO9eIjCI2CJRm3u1qhEuZ00OQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HLE9wSZW9xVB9pqdwDhDa+Zudd1/pGMAmP/1XC5tYtonxuIWixE6uYeieUn29J/aJ
         ffUW7DoA4yyVZuZABx/wWSYsLYpIuUTjq+84KAGNA45ywpaDnyrpy2Y4WOuYYGV1qx
         cou87VxGK6Dd8ur+9p5wZTr/KDCvnb8Lxkh4t1mSEYavjGFOc1x9JOICZKZ2jSGTFk
         LnYTqzutSuZ1jcKALubOak2zwTTnwWv/XamuNHVhkMuqzxWvG4qK2QnHYCWhjpCEPV
         5ENEiF9PRRgbLfSKGSKGU2SLxVqcaJWeB2OTfSxIAxSUecuVllbTtG5/4EP063IBNh
         6OsXGToFdvoCg==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5.4.y 3/3] rpmsg: Fix kfree() of static memory on setting driver_override
Date:   Wed, 18 Oct 2023 13:05:20 +0100
Message-ID: <20231018120527.2110438-5-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231018120527.2110438-1-lee@kernel.org>
References: <20231018120527.2110438-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 42cd402b8fd4672b692400fe5f9eecd55d2794ac upstream.

The driver_override field from platform driver should not be initialized
from static memory (string literal) because the core later kfree() it,
for example when driver_override is set via sysfs.

Use dedicated helper to set driver_override properly.

Fixes: 950a7388f02b ("rpmsg: Turn name service into a stand alone driver")
Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220419113435.246203-13-krzysztof.kozlowski@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/rpmsg/rpmsg_internal.h | 13 +++++++++++--
 include/linux/rpmsg.h          |  6 ++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index 3fc83cd50e98f..9165e3c811be4 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -84,10 +84,19 @@ struct device *rpmsg_find_device(struct device *parent,
  */
 static inline int rpmsg_chrdev_register_device(struct rpmsg_device *rpdev)
 {
+	int ret;
+
 	strcpy(rpdev->id.name, "rpmsg_chrdev");
-	rpdev->driver_override = "rpmsg_chrdev";
+	ret = driver_set_override(&rpdev->dev, &rpdev->driver_override,
+				  rpdev->id.name, strlen(rpdev->id.name));
+	if (ret)
+		return ret;
+
+	ret = rpmsg_register_device(rpdev);
+	if (ret)
+		kfree(rpdev->driver_override);
 
-	return rpmsg_register_device(rpdev);
+	return ret;
 }
 
 #endif
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index a68972b097b72..6e7690e20dc51 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -41,7 +41,9 @@ struct rpmsg_channel_info {
  * rpmsg_device - device that belong to the rpmsg bus
  * @dev: the device struct
  * @id: device id (used to match between rpmsg drivers and devices)
- * @driver_override: driver name to force a match
+ * @driver_override: driver name to force a match; do not set directly,
+ *                   because core frees it; use driver_set_override() to
+ *                   set or clear it.
  * @src: local address
  * @dst: destination address
  * @ept: the rpmsg endpoint of this channel
@@ -50,7 +52,7 @@ struct rpmsg_channel_info {
 struct rpmsg_device {
 	struct device dev;
 	struct rpmsg_device_id id;
-	char *driver_override;
+	const char *driver_override;
 	u32 src;
 	u32 dst;
 	struct rpmsg_endpoint *ept;
-- 
2.42.0.655.g421f12c284-goog

