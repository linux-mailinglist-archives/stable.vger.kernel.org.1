Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3B76FA604
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjEHKPT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbjEHKPR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:15:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44493AA0A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:15:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F6BD6246C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76675C433D2;
        Mon,  8 May 2023 10:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540915;
        bh=J5/+2UX8HyoUYOSVQRQbMUBhzE5hFQvdkMsz6RtOOKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tLaJnhqUEklX8ueb8QorjK9dL2N1YHxYnLCiSMZZlaiNnwRrOJaFwFUjbxZaUL3DD
         4v3wgyBwseNAEx5QkkxOatwn+fz+fMhn+4tSJEiHDarHS9Lp1Jn71h7GqzprWJ+cLD
         wXqj0OrdY7QgUIulT0fe+QfHmkfqjIaLtLJlaHkU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Andrew Lunn <andrew@lunn.ch>, Lee Jones <lee@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 546/611] mfd: tqmx86: Do not access I2C_DETECT register through io_base
Date:   Mon,  8 May 2023 11:46:28 +0200
Message-Id: <20230508094439.755100696@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

[ Upstream commit 1be1b23696b3d4b0231c694f5e0767b4471d33a9 ]

The I2C_DETECT register is at IO port 0x1a7, which is outside the range
passed to devm_ioport_map() for io_base, and was only working because
there aren't actually any bounds checks for IO port accesses.

Extending the range does not seem like a good solution here, as it would
then conflict with the IO resource assigned to the I2C controller. As
this is just a one-off access during probe, use a simple inb() instead.

While we're at it, drop the unused define TQMX86_REG_I2C_INT_EN.

Fixes: 2f17dd34ffed ("mfd: tqmx86: IO controller with I2C, Wachdog and GPIO")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/e8300a30f0791afb67d79db8089fb6004855f378.1676892223.git.matthias.schiffer@ew.tq-group.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/tqmx86.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 7ae906ff8e353..31d0efb5aacf8 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -49,9 +49,8 @@
 #define TQMX86_REG_IO_EXT_INT_MASK		0x3
 #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
 
-#define TQMX86_REG_I2C_DETECT	0x47
+#define TQMX86_REG_I2C_DETECT	0x1a7
 #define TQMX86_REG_I2C_DETECT_SOFT		0xa5
-#define TQMX86_REG_I2C_INT_EN	0x49
 
 static uint gpio_irq;
 module_param(gpio_irq, uint, 0);
@@ -213,7 +212,12 @@ static int tqmx86_probe(struct platform_device *pdev)
 		 "Found %s - Board ID %d, PCB Revision %d, PLD Revision %d\n",
 		 board_name, board_id, rev >> 4, rev & 0xf);
 
-	i2c_det = ioread8(io_base + TQMX86_REG_I2C_DETECT);
+	/*
+	 * The I2C_DETECT register is in the range assigned to the I2C driver
+	 * later, so we don't extend TQMX86_IOSIZE. Use inb() for this one-off
+	 * access instead of ioport_map + unmap.
+	 */
+	i2c_det = inb(TQMX86_REG_I2C_DETECT);
 
 	if (gpio_irq_cfg) {
 		io_ext_int_val =
-- 
2.39.2



