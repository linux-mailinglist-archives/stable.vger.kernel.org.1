Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13C77DCBDE
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 12:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbjJaLeL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 07:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbjJaLeL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 07:34:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C9D91
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 04:34:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D24C433CA;
        Tue, 31 Oct 2023 11:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698752048;
        bh=YG8z8MF86gfJsLTYvef4/8BgE3f9GkB+5h1Wqg78KCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rNErEFaeSzPJFGvhlyVmTFXZZC/cFduD9qIcSvgxVsvXHSGlrn75OfNZ/KR6RX8Dy
         IDNC+pYNXdMli6Xb6CylOtIvDC1AVvRDSwwRQyeN8f72IPapStf9SVv5/jSk8OqNrh
         CXvAGRbEbsABHJV6jMQYMZ+CfC7vq9RKUANLpc8XQcLyjqA92ARF+sa247/ue9fnE+
         PYSo4PrafS5zn6ZL+csR75/EqKcguC4bytF8TNqj2odyGAqO7rvteYuREKhKh9DLh3
         t9ZkyHc1cBGE9uKUnPDhXn47BI0JOMKpzUnUGHZMWrTSb8G1YKsdjwxEn2aTpYOP3l
         czlCiHbBAxFuA==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5.10.y 3/6] rpmsg: Fix kfree() of static memory on setting driver_override
Date:   Tue, 31 Oct 2023 11:33:51 +0000
Message-ID: <20231031113357.2282037-3-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231031113357.2282037-1-lee@kernel.org>
References: <20231031113357.2282037-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
2.42.0.820.g83a721a137-goog

