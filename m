Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261FA72C0AF
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjFLKyH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbjFLKxp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:53:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878A661BA
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:38:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6870E60F87
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECC4C433D2;
        Mon, 12 Jun 2023 10:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566327;
        bh=khTySXve3q1fPZUymo85ovTEQXkanLvf18RuLKGE8Tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u1tdzgNuK6/gJc+Hov+NjjOyYUa4oHhlOsDPNGJ7vX9pxk+lDYdMb9btRazA28fDq
         fsa3WNRWnS1EFKb7nejHObklFihPLuYV/PXhI/mW/Yyjs32FsAydFx3pMsC09zYqyn
         UxFUpn5jpjcJsOP/u1magpSUsB+ivnyRarHmjqPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 82/91] eeprom: at24: also select REGMAP
Date:   Mon, 12 Jun 2023 12:27:11 +0200
Message-ID: <20230612101705.533633228@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 7f3c782b3914e510b646a77aedc3adeac2e4a63b ]

Selecting only REGMAP_I2C can leave REGMAP unset, causing build errors,
so also select REGMAP to prevent the build errors.

../drivers/misc/eeprom/at24.c:540:42: warning: 'struct regmap_config' declared inside parameter list will not be visible outside of this definition or declaration
  540 |                                   struct regmap_config *regmap_config)
../drivers/misc/eeprom/at24.c: In function 'at24_make_dummy_client':
../drivers/misc/eeprom/at24.c:552:18: error: implicit declaration of function 'devm_regmap_init_i2c' [-Werror=implicit-function-declaration]
  552 |         regmap = devm_regmap_init_i2c(dummy_client, regmap_config);
../drivers/misc/eeprom/at24.c:552:16: warning: assignment to 'struct regmap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
  552 |         regmap = devm_regmap_init_i2c(dummy_client, regmap_config);
../drivers/misc/eeprom/at24.c: In function 'at24_probe':
../drivers/misc/eeprom/at24.c:586:16: error: variable 'regmap_config' has initializer but incomplete type
  586 |         struct regmap_config regmap_config = { };
../drivers/misc/eeprom/at24.c:586:30: error: storage size of 'regmap_config' isn't known
  586 |         struct regmap_config regmap_config = { };
../drivers/misc/eeprom/at24.c:586:30: warning: unused variable 'regmap_config' [-Wunused-variable]

Fixes: 5c015258478e ("eeprom: at24: add basic regmap_i2c support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/eeprom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index f0a7531f354c1..2d240bfa819f8 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -6,6 +6,7 @@ config EEPROM_AT24
 	depends on I2C && SYSFS
 	select NVMEM
 	select NVMEM_SYSFS
+	select REGMAP
 	select REGMAP_I2C
 	help
 	  Enable this driver to get read/write support to most I2C EEPROMs
-- 
2.39.2



