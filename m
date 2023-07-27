Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E126676542C
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 14:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjG0MkQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 08:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjG0MkP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 08:40:15 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9432E1AA
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 05:40:13 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id C27441C0003;
        Thu, 27 Jul 2023 12:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690461612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ACbp1OZFDUJy9r8hr8wH8esFbApT2wuUBXR8Kt5oAjo=;
        b=nfIjQ5ur/HTOk139RPEDmVWMVw39rXkNr0aPKqNQdFTNmBjZXf60CH+HtmrOpU2awM5yOE
        Uyjoz5OkTlJvW6f12j42dVMKcSM7GjZTc1hOU3Ht2B4tZQ75tp+ViahpVwY2+TsN5cKLN1
        UT3r6IYOamkdHUv4/88vYp2sK4lyw82fscTdjOYm8Sovymgv/D06ACdhdAXGJvPx33ZqK6
        JMUSMwKw49Ni6JPJ8ThOxLGizZ6A+TCaMT9LZxJnyytnCEDSJMWbMbJd+TjxENZRKZgz+3
        T/KQu4VbIjV79/egnJSXNcSudA7eKrp9dqT35YLtU3Fq0ZVsPxm0QwEoxn2rdA==
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     stable@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 4.19.y] ASoC: cs42l51: fix driver to properly autoload with automatic module loading
Date:   Thu, 27 Jul 2023 14:40:02 +0200
Message-ID: <20230727124002.701881-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023072306-polyester-reproach-45e3@gregkh>
References: <2023072306-polyester-reproach-45e3@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.petazzoni@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

In commit 2cb1e0259f50 ("ASoC: cs42l51: re-hook of_match_table
pointer"), 9 years ago, some random guy fixed the cs42l51 after it was
split into a core part and an I2C part to properly match based on a
Device Tree compatible string.

However, the fix in this commit is wrong: the MODULE_DEVICE_TABLE(of,
....) is in the core part of the driver, not the I2C part. Therefore,
automatic module loading based on module.alias, based on matching with
the DT compatible string, loads the core part of the driver, but not
the I2C part. And threfore, the i2c_driver is not registered, and the
codec is not known to the system, nor matched with a DT node with the
corresponding compatible string.

In order to fix that, we move the MODULE_DEVICE_TABLE(of, ...) into
the I2C part of the driver. The cs42l51_of_match[] array is also moved
as well, as it is not possible to have this definition in one file,
and the MODULE_DEVICE_TABLE(of, ...) invocation in another file, due
to how MODULE_DEVICE_TABLE works.

Thanks to this commit, the I2C part of the driver now properly
autoloads, and thanks to its dependency on the core part, the core
part gets autoloaded as well, resulting in a functional sound card
without having to manually load kernel modules.

Fixes: 2cb1e0259f50 ("ASoC: cs42l51: re-hook of_match_table pointer")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 sound/soc/codecs/cs42l51-i2c.c | 6 ++++++
 sound/soc/codecs/cs42l51.c     | 7 -------
 sound/soc/codecs/cs42l51.h     | 1 -
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs42l51-i2c.c b/sound/soc/codecs/cs42l51-i2c.c
index 4b5731a41876..cd93e93a5983 100644
--- a/sound/soc/codecs/cs42l51-i2c.c
+++ b/sound/soc/codecs/cs42l51-i2c.c
@@ -23,6 +23,12 @@ static struct i2c_device_id cs42l51_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cs42l51_i2c_id);
 
+const struct of_device_id cs42l51_of_match[] = {
+	{ .compatible = "cirrus,cs42l51", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cs42l51_of_match);
+
 static int cs42l51_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 5080d7a3c279..662f1f85ba36 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -563,13 +563,6 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 }
 EXPORT_SYMBOL_GPL(cs42l51_probe);
 
-const struct of_device_id cs42l51_of_match[] = {
-	{ .compatible = "cirrus,cs42l51", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, cs42l51_of_match);
-EXPORT_SYMBOL_GPL(cs42l51_of_match);
-
 MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>");
 MODULE_DESCRIPTION("Cirrus Logic CS42L51 ALSA SoC Codec Driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs42l51.h b/sound/soc/codecs/cs42l51.h
index 0ca805492ac4..8c55bf384bc6 100644
--- a/sound/soc/codecs/cs42l51.h
+++ b/sound/soc/codecs/cs42l51.h
@@ -22,7 +22,6 @@ struct device;
 
 extern const struct regmap_config cs42l51_regmap;
 int cs42l51_probe(struct device *dev, struct regmap *regmap);
-extern const struct of_device_id cs42l51_of_match[];
 
 #define CS42L51_CHIP_ID			0x1B
 #define CS42L51_CHIP_REV_A		0x00
-- 
2.41.0

