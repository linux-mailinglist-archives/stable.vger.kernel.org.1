Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBDB761343
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbjGYLJN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbjGYLIy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:08:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822BE1BE1
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0465561648
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165D8C433C8;
        Tue, 25 Jul 2023 11:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283261;
        bh=Y1thFwVoES51AB1wPzTd0ivxRPqBzGtpvZ+MM/mJa3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q46xPWuUCztQD3Qnj52B4DYeMFoj7CJSjW5uGBpx42BGLWGy1fGNgbR2KwZ7S2Cu8
         7EkfVgFqOk9czeJsYWepei+Rkn2tfHuPzNKXGMQ56goFR1jWmqYSR6QnEhtOJzoLu4
         zvEjbQhaOcDAWi7S2XAO+uRtxLIkW6zFvFCpoZ1o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Mark Brown <broonie@kernel.org>, Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 5.15 13/78] regmap: Account for register length in SMBus I/O limits
Date:   Tue, 25 Jul 2023 12:46:04 +0200
Message-ID: <20230725104451.847706611@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104451.275227789@linuxfoundation.org>
References: <20230725104451.275227789@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

commit 0c9d2eb5e94792fe64019008a04d4df5e57625af upstream.

The SMBus I2C buses have limits on the size of transfers they can do but
do not factor in the register length meaning we may try to do a transfer
longer than our length limit, the core will not take care of this.
Future changes will factor this out into the core but there are a number
of users that assume current behaviour so let's just do something
conservative here.

This does not take account padding bits but practically speaking these
are very rarely if ever used on I2C buses given that they generally run
slowly enough to mean there's no issue.

Cc: stable@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Link: https://lore.kernel.org/r/20230712-regmap-max-transfer-v1-2-80e2aed22e83@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/regmap/regmap-i2c.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -242,8 +242,8 @@ static int regmap_i2c_smbus_i2c_read(voi
 static const struct regmap_bus regmap_i2c_smbus_i2c_block = {
 	.write = regmap_i2c_smbus_i2c_write,
 	.read = regmap_i2c_smbus_i2c_read,
-	.max_raw_read = I2C_SMBUS_BLOCK_MAX,
-	.max_raw_write = I2C_SMBUS_BLOCK_MAX,
+	.max_raw_read = I2C_SMBUS_BLOCK_MAX - 1,
+	.max_raw_write = I2C_SMBUS_BLOCK_MAX - 1,
 };
 
 static int regmap_i2c_smbus_i2c_write_reg16(void *context, const void *data,
@@ -299,8 +299,8 @@ static int regmap_i2c_smbus_i2c_read_reg
 static const struct regmap_bus regmap_i2c_smbus_i2c_block_reg16 = {
 	.write = regmap_i2c_smbus_i2c_write_reg16,
 	.read = regmap_i2c_smbus_i2c_read_reg16,
-	.max_raw_read = I2C_SMBUS_BLOCK_MAX,
-	.max_raw_write = I2C_SMBUS_BLOCK_MAX,
+	.max_raw_read = I2C_SMBUS_BLOCK_MAX - 2,
+	.max_raw_write = I2C_SMBUS_BLOCK_MAX - 2,
 };
 
 static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,


