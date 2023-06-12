Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EB872C12F
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbjFLK5P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236529AbjFLK4t (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:56:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EF7D5FF
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:44:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3502612B4
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF676C433D2;
        Mon, 12 Jun 2023 10:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566674;
        bh=ZG5XaFw0OdrhywYJYu1KG5HIMTP9aOTXR3y5qEcgeXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ur6l5/bLi/4taOjY0YBHlWDoU9iSFVI32ZXB7bica2MxdH5nA47BG1TxSuIUm4J0u
         vMCRQ/tvaQ1lIZ5H/E3SxbVxmOuOdZJhELlUCcT+xHaX4ey5DiQpd7FZ1QphwHwyqn
         bSrr5lKHAxDHBpXgKOT3LJGGLr+nWQLbVxb/a6xY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 114/132] i2c: mv64xxx: Fix reading invalid status value in atomic mode
Date:   Mon, 12 Jun 2023 12:27:28 +0200
Message-ID: <20230612101715.484382293@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

From: Marek Behún <kabel@kernel.org>

[ Upstream commit 5578d0a79b6430fa1543640dd6f2d397d0886ce7 ]

There seems to be a bug within the mv64xxx I2C controller, wherein the
status register may not necessarily contain valid value immediately
after the IFLG flag is set in the control register.

My theory is that the controller:
- first sets the IFLG in control register
- then updates the status register
- then raises an interrupt

This may sometime cause weird bugs when in atomic mode, since in this
mode we do not wait for an interrupt, but instead we poll the control
register for IFLG and read status register immediately after.

I encountered -ENXIO from mv64xxx_i2c_fsm() due to this issue when using
this driver in atomic mode.

Note that I've only seen this issue on Armada 385, I don't know whether
other SOCs with this controller are also affected. Also note that this
fix has been in U-Boot for over 4 years [1] without anybody complaining,
so it should not cause regressions.

[1] https://source.denx.de/u-boot/u-boot/-/commit/d50e29662f78

Fixes: 544a8d75f3d6 ("i2c: mv64xxx: Add atomic_xfer method to driver")
Signed-off-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 047dfef7a6577..878c076ebdc6b 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -520,6 +520,17 @@ mv64xxx_i2c_intr(int irq, void *dev_id)
 
 	while (readl(drv_data->reg_base + drv_data->reg_offsets.control) &
 						MV64XXX_I2C_REG_CONTROL_IFLG) {
+		/*
+		 * It seems that sometime the controller updates the status
+		 * register only after it asserts IFLG in control register.
+		 * This may result in weird bugs when in atomic mode. A delay
+		 * of 100 ns before reading the status register solves this
+		 * issue. This bug does not seem to appear when using
+		 * interrupts.
+		 */
+		if (drv_data->atomic)
+			ndelay(100);
+
 		status = readl(drv_data->reg_base + drv_data->reg_offsets.status);
 		mv64xxx_i2c_fsm(drv_data, status);
 		mv64xxx_i2c_do_action(drv_data);
-- 
2.39.2



