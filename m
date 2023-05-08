Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74306FA3D8
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjEHJwU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbjEHJwR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:52:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283932383F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:52:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADF35621DF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFCAC433D2;
        Mon,  8 May 2023 09:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539535;
        bh=8CzwNqCKKKnedw56dv1I0GxLmR3opeDahK5Tq1C8qiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LC+1xfrTt/RmgggVLa4So9xK9iilHtn0WrdNu/BW7yBxavbWFTVBoFWnwOHF7Lplw
         OzW7TurDYb2tD3Ac0lfYzjGxrVjQMCIKC+Dw2+hpFRdWUeDnOELXlHoqJSaUJEGWf7
         eHNdxgDPaEngPRLgd84RZNPipnzt7c0Qdro/qZOc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Subject: [PATCH 6.1 053/611] serial: max310x: fix IO data corruption in batched operations
Date:   Mon,  8 May 2023 11:38:15 +0200
Message-Id: <20230508094423.634344138@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Jan Kundrát <jan.kundrat@cesnet.cz>

commit 3f42b142ea1171967e40e10e4b0241c0d6d28d41 upstream.

After upgrading from 5.16 to 6.1, our board with a MAX14830 started
producing lots of garbage data over UART. Bisection pointed out commit
285e76fc049c as the culprit. That patch tried to replace hand-written
code which I added in 2b4bac48c1084 ("serial: max310x: Use batched reads
when reasonably safe") with the generic regmap infrastructure for
batched operations.

Unfortunately, the `regmap_raw_read` and `regmap_raw_write` which were
used are actually functions which perform IO over *multiple* registers.
That's not what is needed for accessing these Tx/Rx FIFOs; the
appropriate functions are the `_noinc_` versions, not the `_raw_` ones.

Fix this regression by using `regmap_noinc_read()` and
`regmap_noinc_write()` along with the necessary `regmap_config` setup;
with this patch in place, our board communicates happily again. Since
our board uses SPI for talking to this chip, the I2C part is completely
untested.

Fixes: 285e76fc049c ("serial: max310x: use regmap methods for SPI batch operations")
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Jan Kundrát <jan.kundrat@cesnet.cz>
Link: https://lore.kernel.org/r/79db8e82aadb0e174bc82b9996423c3503c8fb37.1680732084.git.jan.kundrat@cesnet.cz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/max310x.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -525,6 +525,11 @@ static bool max310x_reg_precious(struct
 	return false;
 }
 
+static bool max310x_reg_noinc(struct device *dev, unsigned int reg)
+{
+	return reg == MAX310X_RHR_REG;
+}
+
 static int max310x_set_baud(struct uart_port *port, int baud)
 {
 	unsigned int mode = 0, div = 0, frac = 0, c = 0, F = 0;
@@ -651,14 +656,14 @@ static void max310x_batch_write(struct u
 {
 	struct max310x_one *one = to_max310x_port(port);
 
-	regmap_raw_write(one->regmap, MAX310X_THR_REG, txbuf, len);
+	regmap_noinc_write(one->regmap, MAX310X_THR_REG, txbuf, len);
 }
 
 static void max310x_batch_read(struct uart_port *port, u8 *rxbuf, unsigned int len)
 {
 	struct max310x_one *one = to_max310x_port(port);
 
-	regmap_raw_read(one->regmap, MAX310X_RHR_REG, rxbuf, len);
+	regmap_noinc_read(one->regmap, MAX310X_RHR_REG, rxbuf, len);
 }
 
 static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
@@ -1472,6 +1477,10 @@ static struct regmap_config regcfg = {
 	.writeable_reg = max310x_reg_writeable,
 	.volatile_reg = max310x_reg_volatile,
 	.precious_reg = max310x_reg_precious,
+	.writeable_noinc_reg = max310x_reg_noinc,
+	.readable_noinc_reg = max310x_reg_noinc,
+	.max_raw_read = MAX310X_FIFO_SIZE,
+	.max_raw_write = MAX310X_FIFO_SIZE,
 };
 
 #ifdef CONFIG_SPI_MASTER
@@ -1557,6 +1566,10 @@ static struct regmap_config regcfg_i2c =
 	.volatile_reg = max310x_reg_volatile,
 	.precious_reg = max310x_reg_precious,
 	.max_register = MAX310X_I2C_REVID_EXTREG,
+	.writeable_noinc_reg = max310x_reg_noinc,
+	.readable_noinc_reg = max310x_reg_noinc,
+	.max_raw_read = MAX310X_FIFO_SIZE,
+	.max_raw_write = MAX310X_FIFO_SIZE,
 };
 
 static const struct max310x_if_cfg max310x_i2c_if_cfg = {


