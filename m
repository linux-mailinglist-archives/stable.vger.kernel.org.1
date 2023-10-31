Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18B77DC937
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 10:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343799AbjJaJPf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 05:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343785AbjJaJPd (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 05:15:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C07B3
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 02:15:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A0BC433CA;
        Tue, 31 Oct 2023 09:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698743731;
        bh=ICeeB78CY+DZI1wIfCMxlL9odFYQ53yyILBrx9Jq5/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=liXoxotj34R0glxhradmqsjFDIr2QimX8PLUtbuCvWPyaBjIH3PX773QasZ2cqWCS
         IID3e39zMRMy/BsB7TtHLccpmRSoDG27fUf/u5piWE1++w0E2ZvEZAPER3emsFMKzq
         LUkbniso6kqoA+43iadT1zYjfphuoNY39WGGiKDYhlgUnBbO5lTmYeHVaLF2AzhD4T
         mJf9lEs9cIhgrZsUe8n0Z1uI4ACqkhdd0GzAjrXE0y08THrUXLe5wa4GPrp4vITm7A
         w/haCHbdYgEElfUoi8+A2vs6yg+WryJusbpkFANImPN/lBxZEdx+4mU4qVXE61uUtP
         IZUkgevpxm16Q==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/6] rpmsg: Fix kfree() of static memory on setting driver_override
Date:   Tue, 31 Oct 2023 09:15:14 +0000
Message-ID: <20231031091521.2223075-3-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231031091521.2223075-1-lee@kernel.org>
References: <20231031091521.2223075-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Change-Id: Ib74ccad7c81138e320254a237185d09d26111db1
---
 drivers/rpmsg/rpmsg_internal.h | 13 +++++++++++--
 include/linux/rpmsg.h          |  6 ++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index a76c344253bf5..5f4f3691bbf1e 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -90,10 +90,19 @@ int rpmsg_release_channel(struct rpmsg_device *rpdev,
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
index a8dcf8a9ae885..1b7294cefb807 100644
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
@@ -51,7 +53,7 @@ struct rpmsg_channel_info {
 struct rpmsg_device {
 	struct device dev;
 	struct rpmsg_device_id id;
-	char *driver_override;
+	const char *driver_override;
 	u32 src;
 	u32 dst;
 	struct rpmsg_endpoint *ept;
-- 
2.42.0.820.g83a721a137-goog

