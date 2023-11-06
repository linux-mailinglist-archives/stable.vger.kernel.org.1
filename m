Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CB37E24D0
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjKFNZd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjKFNZb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:25:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3372BA9
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:25:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0877C433C7;
        Mon,  6 Nov 2023 13:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277127;
        bh=JNQKAJ2DFrwGsJOFdLx7Rl197fVLGTGW3uE+y5JFGZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c2eHexOVhadWt0uiuX1awxGzHP5hiWMM6ALr1FjfSOx8ZACVEw4keSUeV88B/BeXx
         1zXpQZ6og9zsY7BSqIZRiQRoESCgAoiN7qQLqhOfi4S42C8qRAeg2H/o3DVGiUMmGQ
         Dhhpq2EBY9tr5oLf6qlHvoB4YGrsdCX9noGG92Hg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jian Zhang <zhangjian.3032@bytedance.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 5.15 047/128] i2c: aspeed: Fix i2c bus hang in slave read
Date:   Mon,  6 Nov 2023 14:03:27 +0100
Message-ID: <20231106130311.261343655@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -744,6 +744,8 @@ static void __aspeed_i2c_reg_slave(struc
 	func_ctrl_reg_val = readl(bus->base + ASPEED_I2C_FUN_CTRL_REG);
 	func_ctrl_reg_val |= ASPEED_I2CD_SLAVE_EN;
 	writel(func_ctrl_reg_val, bus->base + ASPEED_I2C_FUN_CTRL_REG);
+
+	bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
 }
 
 static int aspeed_i2c_reg_slave(struct i2c_client *client)
@@ -760,7 +762,6 @@ static int aspeed_i2c_reg_slave(struct i
 	__aspeed_i2c_reg_slave(bus, client->addr);
 
 	bus->slave = client;
-	bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
 	spin_unlock_irqrestore(&bus->lock, flags);
 
 	return 0;


