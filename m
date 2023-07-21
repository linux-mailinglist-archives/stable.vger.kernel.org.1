Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9B375D309
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjGUTGY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjGUTGV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:06:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64868359B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:06:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42D2961D80
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5710BC433CC;
        Fri, 21 Jul 2023 19:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966377;
        bh=pPqpxxxsNpwJRfOJB1PFI12LmyEANEKEm/1TgvXf3qE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VF+dgDOMPXSt9pW3fXXo/mCTsLWMxcy/YLhfzFJvUEhPlUJSqJ8W6/ZZK/b+7Ccy0
         ZRI7btdeV3Q8TZhTVcXh0FQ6YJ2YOeLhvHdErW9AWIGl6yEPytq1dPl0ki5j108U3g
         tls0jWRFUfkInZwNT1UTlJoSa3L5s/Z0BPYKJNsk=
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
Subject: [PATCH 5.15 315/532] media: cec: i2c: ch7322: also select REGMAP
Date:   Fri, 21 Jul 2023 18:03:39 +0200
Message-ID: <20230721160631.481958192@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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



