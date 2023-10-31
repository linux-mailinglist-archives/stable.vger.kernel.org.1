Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1737DD559
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376560AbjJaRtm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376534AbjJaRtk (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:49:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB476102
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:49:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B10C433C7;
        Tue, 31 Oct 2023 17:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774577;
        bh=s+HVRB9wuVOaqa2s/NN6Ff7M1lBBxK7ZFOy+7mdB+Gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y66jIh90UkMEyb3vklh5sWGqLTP38MBPqG5/SIv9ZLtHbG8HwEitbI3fT5u2g2mHj
         XZzqr6EnTp9eeV353V3MC3leK9/cLkU0bJeX3OWzyI/2/dwbE/5Brn6fwQoBl+Seyw
         a+Tf5ielTHtqj/5Nk2le8gWqEKn8xkAUqiRyP8uo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jian Zhang <zhangjian.3032@bytedance.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 6.5 092/112] i2c: aspeed: Fix i2c bus hang in slave read
Date:   Tue, 31 Oct 2023 18:01:33 +0100
Message-ID: <20231031165904.207694901@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jian Zhang <zhangjian.3032@bytedance.com>

commit 54f1840ddee9bbdc8dd89fbbfdfa632401244146 upstream.

When the `CONFIG_I2C_SLAVE` option is enabled and the device operates
as a slave, a situation arises where the master sends a START signal
without the accompanying STOP signal. This action results in a
persistent I2C bus timeout. The core issue stems from the fact that
the i2c controller remains in a slave read state without a timeout
mechanism. As a consequence, the bus perpetually experiences timeouts.

In this case, the i2c bus will be reset, but the slave_state reset is
missing.

Fixes: fee465150b45 ("i2c: aspeed: Reset the i2c controller when timeout occurs")
Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
Acked-by: Andi Shyti <andi.shyti@kernel.org>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-aspeed.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -749,6 +749,8 @@ static void __aspeed_i2c_reg_slave(struc
 	func_ctrl_reg_val = readl(bus->base + ASPEED_I2C_FUN_CTRL_REG);
 	func_ctrl_reg_val |= ASPEED_I2CD_SLAVE_EN;
 	writel(func_ctrl_reg_val, bus->base + ASPEED_I2C_FUN_CTRL_REG);
+
+	bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
 }
 
 static int aspeed_i2c_reg_slave(struct i2c_client *client)
@@ -765,7 +767,6 @@ static int aspeed_i2c_reg_slave(struct i
 	__aspeed_i2c_reg_slave(bus, client->addr);
 
 	bus->slave = client;
-	bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
 	spin_unlock_irqrestore(&bus->lock, flags);
 
 	return 0;


