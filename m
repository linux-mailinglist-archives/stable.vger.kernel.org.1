Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C457034C8
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243110AbjEOQwN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243139AbjEOQv6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:51:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480ED559D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:51:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8C7C6299C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7997C433D2;
        Mon, 15 May 2023 16:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169516;
        bh=2CpyPyxBfC2wsCt3WW3S9wDelkzwsiNvUhAcLcGys0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bltw/BdZvq3yh6jVyoJAcaWRpp7RdO7pVtHNHtNgMQXebnQ5RHdiIfo/o6KaNmCMO
         w/0Lq1Q2jUeOvZrPIg5S7cWtq1CdZftQuO5JLwDe/VpyDuLp8Je2dRTWUwoQoXzdNg
         RNn5SfuPTyNXESYuOLS4KHRb6wBV4LjnAOBfRMaM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 082/246] i2c: gxp: fix build failure without CONFIG_I2C_SLAVE
Date:   Mon, 15 May 2023 18:24:54 +0200
Message-Id: <20230515161725.038027340@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 5d388143fa6c351d985ffd23ea50c91c8839141b ]

The gxp_i2c_slave_irq_handler() is hidden in an #ifdef, but the
caller uses an IS_ENABLED() check:

drivers/i2c/busses/i2c-gxp.c: In function 'gxp_i2c_irq_handler':
drivers/i2c/busses/i2c-gxp.c:467:29: error: implicit declaration of function 'gxp_i2c_slave_irq_handler'; did you mean 'gxp_i2c_irq_handler'? [-Werror=implicit-function-declaration]

It has to consistently use one method or the other to avoid warnings,
so move to IS_ENABLED() here for readability and build coverage, and
move the #ifdef in linux/i2c.h to allow building it as dead code.

Fixes: 4a55ed6f89f5 ("i2c: Add GXP SoC I2C Controller")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Nick Hawkins <nick.hawkins@hpe.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-gxp.c | 2 --
 include/linux/i2c.h          | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-gxp.c b/drivers/i2c/busses/i2c-gxp.c
index d4b55d989a268..8ea3fb5e4c7f7 100644
--- a/drivers/i2c/busses/i2c-gxp.c
+++ b/drivers/i2c/busses/i2c-gxp.c
@@ -353,7 +353,6 @@ static void gxp_i2c_chk_data_ack(struct gxp_i2c_drvdata *drvdata)
 	writew(value, drvdata->base + GXP_I2CMCMD);
 }
 
-#if IS_ENABLED(CONFIG_I2C_SLAVE)
 static bool gxp_i2c_slave_irq_handler(struct gxp_i2c_drvdata *drvdata)
 {
 	u8 value;
@@ -437,7 +436,6 @@ static bool gxp_i2c_slave_irq_handler(struct gxp_i2c_drvdata *drvdata)
 
 	return true;
 }
-#endif
 
 static irqreturn_t gxp_i2c_irq_handler(int irq, void *_drvdata)
 {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 5ba89663ea865..13a1ce38cb0c5 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -385,7 +385,6 @@ static inline void i2c_set_clientdata(struct i2c_client *client, void *data)
 
 /* I2C slave support */
 
-#if IS_ENABLED(CONFIG_I2C_SLAVE)
 enum i2c_slave_event {
 	I2C_SLAVE_READ_REQUESTED,
 	I2C_SLAVE_WRITE_REQUESTED,
@@ -396,9 +395,10 @@ enum i2c_slave_event {
 
 int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb);
 int i2c_slave_unregister(struct i2c_client *client);
-bool i2c_detect_slave_mode(struct device *dev);
 int i2c_slave_event(struct i2c_client *client,
 		    enum i2c_slave_event event, u8 *val);
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+bool i2c_detect_slave_mode(struct device *dev);
 #else
 static inline bool i2c_detect_slave_mode(struct device *dev) { return false; }
 #endif
-- 
2.39.2



