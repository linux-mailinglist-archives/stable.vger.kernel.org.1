Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9D878AA8D
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjH1KXV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjH1KWs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:22:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D97E83
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:22:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1501F6389D
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F47C433C8;
        Mon, 28 Aug 2023 10:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218162;
        bh=ihfVriidgKm9Vt6gZuO542E6LjdgS1Gfl5CRgcjRiO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JyK5m8DakD8ampp8s22BhWF0IZl6hvSGWLFGKTA5+iywUoqu0p2FC4+BwqVYK9wM/
         4GnzB4nUfB6XRUPfm8mxJZxSG6FMIijFOQCK9pxA9XaGgldG3vURuvIIJAdTWZsflC
         Q5d5vLWpHsLj0dsKF6CcmB4dBOyi8BQ85a9+4GFU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 118/129] ASoC: cs35l56: Read firmware uuid from a device property instead of _SUB
Date:   Mon, 28 Aug 2023 12:13:17 +0200
Message-ID: <20230828101201.298812873@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

[ Upstream commit 897a6b5a030e62c21566551c870d81740f82ca13 ]

Use a device property "cirrus,firmware-uid" to get the unique firmware
identifier instead of using ACPI _SUB. There aren't any products that use
_SUB.

There will not usually be a _SUB in Soundwire nodes. The ACPI can use a
_DSD section for custom properties.

There is also a need to support instantiating this driver using software
nodes. This is for systems where the CS35L56 is a back-end device and the
ACPI refers only to the front-end audio device - there will not be any ACPI
references to CS35L56.

Fixes: e49611252900 ("ASoC: cs35l56: Add driver for Cirrus Logic CS35L56")
Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20230817112712.16637-2-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l56.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index f3fee448d759e..6a2b0797f3c7d 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -5,7 +5,6 @@
 // Copyright (C) 2023 Cirrus Logic, Inc. and
 //                    Cirrus Logic International Semiconductor Ltd.
 
-#include <linux/acpi.h>
 #include <linux/completion.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -1327,26 +1326,22 @@ static int cs35l56_dsp_init(struct cs35l56_private *cs35l56)
 	return 0;
 }
 
-static int cs35l56_acpi_get_name(struct cs35l56_private *cs35l56)
+static int cs35l56_get_firmware_uid(struct cs35l56_private *cs35l56)
 {
-	acpi_handle handle = ACPI_HANDLE(cs35l56->dev);
-	const char *sub;
+	struct device *dev = cs35l56->dev;
+	const char *prop;
+	int ret;
 
-	/* If there is no ACPI_HANDLE, there is no ACPI for this system, return 0 */
-	if (!handle)
+	ret = device_property_read_string(dev, "cirrus,firmware-uid", &prop);
+	/* If bad sw node property, return 0 and fallback to legacy firmware path */
+	if (ret < 0)
 		return 0;
 
-	sub = acpi_get_subsystem_id(handle);
-	if (IS_ERR(sub)) {
-		/* If bad ACPI, return 0 and fallback to legacy firmware path, otherwise fail */
-		if (PTR_ERR(sub) == -ENODATA)
-			return 0;
-		else
-			return PTR_ERR(sub);
-	}
+	cs35l56->dsp.system_name = devm_kstrdup(dev, prop, GFP_KERNEL);
+	if (cs35l56->dsp.system_name == NULL)
+		return -ENOMEM;
 
-	cs35l56->dsp.system_name = sub;
-	dev_dbg(cs35l56->dev, "Subsystem ID: %s\n", cs35l56->dsp.system_name);
+	dev_dbg(dev, "Firmware UID: %s\n", cs35l56->dsp.system_name);
 
 	return 0;
 }
@@ -1390,7 +1385,7 @@ int cs35l56_common_probe(struct cs35l56_private *cs35l56)
 		gpiod_set_value_cansleep(cs35l56->reset_gpio, 1);
 	}
 
-	ret = cs35l56_acpi_get_name(cs35l56);
+	ret = cs35l56_get_firmware_uid(cs35l56);
 	if (ret != 0)
 		goto err;
 
@@ -1577,8 +1572,6 @@ void cs35l56_remove(struct cs35l56_private *cs35l56)
 
 	regcache_cache_only(cs35l56->regmap, true);
 
-	kfree(cs35l56->dsp.system_name);
-
 	gpiod_set_value_cansleep(cs35l56->reset_gpio, 0);
 	regulator_bulk_disable(ARRAY_SIZE(cs35l56->supplies), cs35l56->supplies);
 }
-- 
2.40.1



