Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C3F79B62F
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244571AbjIKVSt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242073AbjIKPVl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:21:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058E2D3
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:21:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A4CC433C8;
        Mon, 11 Sep 2023 15:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445696;
        bh=OWETa99FvWRO8Sqmt+/JQRDqKI4SoMeTPTcC8RaqZkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yEIkxn200pwpWOhDt5DH6rYL97uHphQPzXB+AANOuPQ6V1sit5CbOhjvCYmW3TE8w
         M5FAbTZdQrmK82E9EXmEBdjqBLqQc15l+n0/npU6TaIScbSpB1ld5DmrGpVY5zpnMd
         XVzhshw5eWHDxEZ5nDR4CE/kyyM9ALuzCz6kW3mk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 440/600] extcon: cht_wc: add POWER_SUPPLY dependency
Date:   Mon, 11 Sep 2023 15:47:53 +0200
Message-ID: <20230911134646.637890366@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit d20a3a8a32e3fa564ff25da860c5fc1a97642dfe ]

The driver fails to link when CONFIG_POWER_SUPPLY is disabled:

x86_64-linux-ld: vmlinux.o: in function `cht_wc_extcon_psy_get_prop':
extcon-intel-cht-wc.c:(.text+0x15ccda7): undefined reference to `power_supply_get_drvdata'
x86_64-linux-ld: vmlinux.o: in function `cht_wc_extcon_pwrsrc_event':
extcon-intel-cht-wc.c:(.text+0x15cd3e9): undefined reference to `power_supply_changed'
x86_64-linux-ld: vmlinux.o: in function `cht_wc_extcon_probe':
extcon-intel-cht-wc.c:(.text+0x15cd596): undefined reference to `devm_power_supply_register'

It should be possible to change the driver to not require this at
compile time and still provide other functions, but adding a hard
Kconfig dependency does not seem to have any practical downsides
and is simpler since the option is normally enabled anyway.

Fixes: 66e31186cd2aa ("extcon: intel-cht-wc: Add support for registering a power_supply class-device")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/extcon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index 290186e44e6bd..4dd52a6a5b48d 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -62,6 +62,7 @@ config EXTCON_INTEL_CHT_WC
 	tristate "Intel Cherrytrail Whiskey Cove PMIC extcon driver"
 	depends on INTEL_SOC_PMIC_CHTWC
 	depends on USB_SUPPORT
+	depends on POWER_SUPPLY
 	select USB_ROLE_SWITCH
 	help
 	  Say Y here to enable extcon support for charger detection / control
-- 
2.40.1



