Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E24A703A0A
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244635AbjEORrq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244726AbjEORrb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:47:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666751690C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:46:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E46E762EC4
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92C1C433EF;
        Mon, 15 May 2023 17:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172768;
        bh=FqWwb3Kuhe4Ed5F0WxPtuKv0KMypabM4wdP+vzAlwPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2fQzfIPdICArV4MIt2zPgvWj2+ToHmIKozqZZ3TYiaUN9pnkMhzM3K2L5pqBKxLTt
         6IBqcWaxLOQzLbg0iC0mk/p53uE1oD7hahidxI1SqgNCS4mB1c4eKAhxVSsfavqcbL
         9DXomN3CWX+dyt1HZsJHTJTXEAldge1dpJpLpZyc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 253/381] firmware: raspberrypi: Introduce devm_rpi_firmware_get()
Date:   Mon, 15 May 2023 18:28:24 +0200
Message-Id: <20230515161748.142710842@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

[ Upstream commit f663204c9a1f8d6fcc590667d9d7a9f44e064644 ]

It'll simplify the firmware handling for most consumers.

Suggested-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Stable-dep-of: 5bca3688bdbc ("Input: raspberrypi-ts - fix refcount leak in rpi_ts_probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/raspberrypi.c             | 29 ++++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h |  8 ++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index 9eef49da47e04..45ff03da234a6 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -243,6 +243,13 @@ void rpi_firmware_put(struct rpi_firmware *fw)
 }
 EXPORT_SYMBOL_GPL(rpi_firmware_put);
 
+static void devm_rpi_firmware_put(void *data)
+{
+	struct rpi_firmware *fw = data;
+
+	rpi_firmware_put(fw);
+}
+
 static int rpi_firmware_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -338,6 +345,28 @@ struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node)
 }
 EXPORT_SYMBOL_GPL(rpi_firmware_get);
 
+/**
+ * devm_rpi_firmware_get - Get pointer to rpi_firmware structure.
+ * @firmware_node:    Pointer to the firmware Device Tree node.
+ *
+ * Returns NULL is the firmware device is not ready.
+ */
+struct rpi_firmware *devm_rpi_firmware_get(struct device *dev,
+					   struct device_node *firmware_node)
+{
+	struct rpi_firmware *fw;
+
+	fw = rpi_firmware_get(firmware_node);
+	if (!fw)
+		return NULL;
+
+	if (devm_add_action_or_reset(dev, devm_rpi_firmware_put, fw))
+		return NULL;
+
+	return fw;
+}
+EXPORT_SYMBOL_GPL(devm_rpi_firmware_get);
+
 static const struct of_device_id rpi_firmware_of_match[] = {
 	{ .compatible = "raspberrypi,bcm2835-firmware", },
 	{},
diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index fdfef7fe40df9..73ad784fca966 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -142,6 +142,8 @@ int rpi_firmware_property_list(struct rpi_firmware *fw,
 			       void *data, size_t tag_size);
 void rpi_firmware_put(struct rpi_firmware *fw);
 struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node);
+struct rpi_firmware *devm_rpi_firmware_get(struct device *dev,
+					   struct device_node *firmware_node);
 #else
 static inline int rpi_firmware_property(struct rpi_firmware *fw, u32 tag,
 					void *data, size_t len)
@@ -160,6 +162,12 @@ static inline struct rpi_firmware *rpi_firmware_get(struct device_node *firmware
 {
 	return NULL;
 }
+
+static inline struct rpi_firmware *devm_rpi_firmware_get(struct device *dev,
+					struct device_node *firmware_node)
+{
+	return NULL;
+}
 #endif
 
 #endif /* __SOC_RASPBERRY_FIRMWARE_H__ */
-- 
2.39.2



