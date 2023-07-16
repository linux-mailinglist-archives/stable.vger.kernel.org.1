Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F268075569D
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjGPUwQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjGPUwQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:52:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DADDF
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:52:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAA4860EB8
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6335C433C7;
        Sun, 16 Jul 2023 20:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540734;
        bh=pPqpxxxsNpwJRfOJB1PFI12LmyEANEKEm/1TgvXf3qE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YuzLOumBDaIvOHCyuwndgUt7ceZiv3ubdXv3Kcug/sQoSIv4riBwKPb+SZVRc163X
         7NPi0a3H6qtzm7+jFGCrZq8RkOiJSRKQvw0VYb0cfAuW8yQ/qi2AMLxAIbj8C8I1NJ
         9HWHxWpv3jmn6Y+IdZe7F5cRhFxlfNpfXGWGCLcw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Jeff Chase <jnchase@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Joe Tessler <jrt@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 469/591] media: cec: i2c: ch7322: also select REGMAP
Date:   Sun, 16 Jul 2023 21:50:08 +0200
Message-ID: <20230716194936.039175759@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 29f96ac23648b2259f42d40703c47dd18fd172ca ]

Selecting only REGMAP_I2C can leave REGMAP unset, causing build errors,
so also select REGMAP to prevent the build errors.

../drivers/media/cec/i2c/ch7322.c:158:21: error: variable 'ch7322_regmap' has initializer but incomplete type
  158 | static const struct regmap_config ch7322_regmap = {
../drivers/media/cec/i2c/ch7322.c:159:10: error: 'const struct regmap_config' has no member named 'reg_bits'
  159 |         .reg_bits = 8,
../drivers/media/cec/i2c/ch7322.c:159:21: warning: excess elements in struct initializer
  159 |         .reg_bits = 8,
../drivers/media/cec/i2c/ch7322.c:160:10: error: 'const struct regmap_config' has no member named 'val_bits'
  160 |         .val_bits = 8,
../drivers/media/cec/i2c/ch7322.c:160:21: warning: excess elements in struct initializer
  160 |         .val_bits = 8,
../drivers/media/cec/i2c/ch7322.c:161:10: error: 'const struct regmap_config' has no member named 'max_register'
  161 |         .max_register = 0x7f,
../drivers/media/cec/i2c/ch7322.c:161:25: warning: excess elements in struct initializer
  161 |         .max_register = 0x7f,
../drivers/media/cec/i2c/ch7322.c:162:10: error: 'const struct regmap_config' has no member named 'disable_locking'
  162 |         .disable_locking = true,
../drivers/media/cec/i2c/ch7322.c:162:28: warning: excess elements in struct initializer
  162 |         .disable_locking = true,
../drivers/media/cec/i2c/ch7322.c: In function 'ch7322_probe':
../drivers/media/cec/i2c/ch7322.c:468:26: error: implicit declaration of function 'devm_regmap_init_i2c' [-Werror=implicit-function-declaration]
  468 |         ch7322->regmap = devm_regmap_init_i2c(client, &ch7322_regmap);
../drivers/media/cec/i2c/ch7322.c:468:24: warning: assignment to 'struct regmap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
  468 |         ch7322->regmap = devm_regmap_init_i2c(client, &ch7322_regmap);
../drivers/media/cec/i2c/ch7322.c: At top level:
../drivers/media/cec/i2c/ch7322.c:158:35: error: storage size of 'ch7322_regmap' isn't known
  158 | static const struct regmap_config ch7322_regmap = {

Link: https://lore.kernel.org/linux-media/20230608025435.29249-1-rdunlap@infradead.org
Fixes: 21b9a47e0ec7 ("media: cec: i2c: ch7322: Add ch7322 CEC controller driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jeff Chase <jnchase@google.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Joe Tessler <jrt@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/cec/i2c/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/cec/i2c/Kconfig b/drivers/media/cec/i2c/Kconfig
index 70432a1d69186..d912d143fb312 100644
--- a/drivers/media/cec/i2c/Kconfig
+++ b/drivers/media/cec/i2c/Kconfig
@@ -5,6 +5,7 @@
 config CEC_CH7322
 	tristate "Chrontel CH7322 CEC controller"
 	depends on I2C
+	select REGMAP
 	select REGMAP_I2C
 	select CEC_CORE
 	help
-- 
2.39.2



