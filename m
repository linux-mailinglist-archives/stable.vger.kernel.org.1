Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7E07CDB33
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 14:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjJRME4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 08:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjJRMEz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 08:04:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A0F98
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 05:04:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B6DC433C7;
        Wed, 18 Oct 2023 12:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697630693;
        bh=lx8ixl5af9cF2kzKiet+iDNr4nK6jZ4AVBDXxpO5MhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jRl2T/Wk3Vjm6sy4Mh48blR1oXmn0p5paWmeYT8D52t+b0fVAmLEF2l0CCcSqkxWE
         OZG1/SH6ekcZrPbnP5wmoL+eqDKJscyOLo9hiD1bopsTrSv+JKs9Iyk6nqmrSdHvQW
         +/3Y5Nzc5i1jiEmGhI2eCNLRSU5cdifu0zQCVfqA86Ep4txs5GCBMlzwFpsTY1/pA9
         aSahZ10J7yLMFUmq9EsG/gD+4auwfXAdybEEAg0y9dHtkFYvyFHpMg8BcQ5fgQXKCN
         H3Ohx3kLO6wnGfK5Et9peIl7/wwf2Jlh7hr84TkUgG4D7LuzKw4uTgO97OJgVDakH3
         eSH7Sq6WftPRg==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5.15.y 3/3] rpmsg: Fix kfree() of static memory on setting driver_override
Date:   Wed, 18 Oct 2023 13:04:34 +0100
Message-ID: <20231018120441.2110004-3-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231018120441.2110004-1-lee@kernel.org>
References: <20231018120441.2110004-1-lee@kernel.org>
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
2.42.0.655.g421f12c284-goog

