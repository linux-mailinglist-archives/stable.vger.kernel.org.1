Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCF6775C25
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjHILYV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjHILYV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:24:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F63319A1
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:24:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F34863243
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6ADC433C8;
        Wed,  9 Aug 2023 11:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580259;
        bh=fJkDtPkTGMDdvBeinE9EhWLb0IOtRQvHqUZH8RwLvXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t0671SxFL9KtU7+vorkzTNzuXPpBhCj7aPFf5H+LInEFNTNyfPK28OhsXqYpuTV+0
         nXa7qA7FlbLqznw2pz1k/+K5OBK/oXe7v8tlylPNCSyBHawFPSVCv3HRpt12PpwZDb
         +FgXDpEIYVCuhkrbJzwcqXuySH0FXaLT59abwCCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 285/323] ASoC: cs42l51: fix driver to properly autoload with automatic module loading
Date:   Wed,  9 Aug 2023 12:42:03 +0200
Message-ID: <20230809103711.086327261@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

commit e51df4f81b02bcdd828a04de7c1eb6a92988b61e upstream.

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
Link: https://lore.kernel.org/r/20230713112112.778576-1-thomas.petazzoni@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/cs42l51-i2c.c |    6 ++++++
 sound/soc/codecs/cs42l51.c     |    7 -------
 sound/soc/codecs/cs42l51.h     |    1 -
 3 files changed, 6 insertions(+), 8 deletions(-)

--- a/sound/soc/codecs/cs42l51-i2c.c
+++ b/sound/soc/codecs/cs42l51-i2c.c
@@ -23,6 +23,12 @@ static struct i2c_device_id cs42l51_i2c_
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
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -563,13 +563,6 @@ error:
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
--- a/sound/soc/codecs/cs42l51.h
+++ b/sound/soc/codecs/cs42l51.h
@@ -22,7 +22,6 @@ struct device;
 
 extern const struct regmap_config cs42l51_regmap;
 int cs42l51_probe(struct device *dev, struct regmap *regmap);
-extern const struct of_device_id cs42l51_of_match[];
 
 #define CS42L51_CHIP_ID			0x1B
 #define CS42L51_CHIP_REV_A		0x00


