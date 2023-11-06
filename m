Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBD27E24EB
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjKFN0h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjKFN0g (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:26:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D258A9
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:26:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA91C433C8;
        Mon,  6 Nov 2023 13:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277193;
        bh=GC6B9NVNE987GfQcLHLRE/uK8fbtlV1JCDahHp9bnF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vzo43DmE+1320/CWBGFbOWQBdQFBbxPkUSp40wXQ2Qkz1BLbKM7h1xQGoHn1I7Zo2
         0zh4N/MV7jzAf7ZbZqalx9xgunFF1V9GVMjcruo0hg8JlUYrIDPNUCQ1i9ICB+MkSz
         EB2ePkpCHc4kV9x4QrIS63jzg5Mew2aYN52N12ko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org, lee@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5.15 070/128] rpmsg: Fix kfree() of static memory on setting driver_override
Date:   Mon,  6 Nov 2023 14:03:50 +0100
Message-ID: <20231106130312.302773682@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rpmsg/rpmsg_internal.h |   13 +++++++++++--
 include/linux/rpmsg.h          |    6 ++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -90,10 +90,19 @@ int rpmsg_release_channel(struct rpmsg_d
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


