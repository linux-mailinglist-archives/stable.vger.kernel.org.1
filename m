Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3007CDB43
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 14:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjJRMGV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 08:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjJRMGU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 08:06:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA1098
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 05:06:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D303BC433C9;
        Wed, 18 Oct 2023 12:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697630779;
        bh=tDklYhrRFqyugDGhhcXSZv6qFAgDbkOsiFMGwfGq7wA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UDMHF3KO/TR5+3L2amfLfufe1I5gWmUudDM0m3YCcPJwiVWsx2QCzzMBdxOgW6O7v
         2Y2kZnva77xZUdTuPyQbhthDnLU1ly8M773q+JXnC1SinAXXC1XCe/tb4JkM/sDKnC
         BTqkkxQaYsCzpgEs9k9umbN/Mwiy7YAqrLha7AsmGoXN1nwXQq6f1TeryBYq29GPHh
         PGY6U/NjqChgrfxzKk0bSg2q4qc3tuMZPxOOJnBFDEYpITjzUR5g0f6zKpXhz4f+Z0
         HrsC/hBzFOSGQuUsJK3aTYkm2jYpq4dNX/kE5cpzOydnt7KPAnHKMGOhlpobWarafR
         wTNfhdUEApLqA==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4.14.y 2/2] rpmsg: Fix kfree() of static memory on setting driver_override
Date:   Wed, 18 Oct 2023 13:06:07 +0100
Message-ID: <20231018120611.2110876-2-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231018120611.2110876-1-lee@kernel.org>
References: <20231018120611.2110876-1-lee@kernel.org>
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
index 0cf9c7e2ee835..e1522caadbc8a 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -91,10 +91,19 @@ struct device *rpmsg_find_device(struct device *parent,
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
index 1ab79e8dc0b8f..fdbb7814cfbe8 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -66,7 +66,9 @@ struct rpmsg_channel_info {
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
@@ -75,7 +77,7 @@ struct rpmsg_channel_info {
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

