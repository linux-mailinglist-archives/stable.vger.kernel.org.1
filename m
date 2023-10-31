Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF73A7DD558
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376529AbjJaRtk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376526AbjJaRth (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:49:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D715CDF
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:49:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF31C433C7;
        Tue, 31 Oct 2023 17:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774574;
        bh=zEeUP4HGXCVItEvXY0XqTmHCCkY16zLfK/oZ+TY5mX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KiQnVmVSiKpD4nD06Z7igsv+yQbYzaQewsjcQzpslNfl+i+dPsR0z9G1A4SGhD/ea
         6p5wWGCvq0DFohcKVumEvAhr6SA/aCwedO5TpnWMrFn20eRrZ+JxEcpODIi6uA0pzz
         16UozceLVCzI8kDp4J1QuR0Cjlj4rPUt6z5awdf0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alain Volmat <alain.volmat@foss.st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 6.5 091/112] i2c: stm32f7: Fix PEC handling in case of SMBUS transfers
Date:   Tue, 31 Oct 2023 18:01:32 +0100
Message-ID: <20231031165904.175807878@linuxfoundation.org>
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

From: Alain Volmat <alain.volmat@foss.st.com>

commit c896ff2dd8f30a6b0a922c83a96f6d43f05f0e92 upstream.

In case of SMBUS byte read with PEC enabled, the whole transfer
is split into two commands.  A first write command, followed by
a read command.  The write command does not have any PEC byte
and a PEC byte is appended at the end of the read command.
(cf Read byte protocol with PEC in SMBUS specification)

Within the STM32 I2C controller, handling (either sending
or receiving) of the PEC byte is done via the PECBYTE bit in
register CR2.

Currently, the PECBYTE is set at the beginning of a transfer,
which lead to sending a PEC byte at the end of the write command
(hence losing the real last byte), and also does not check the
PEC byte received during the read command.

This patch corrects the function stm32f7_i2c_smbus_xfer_msg
in order to only set the PECBYTE during the read command.

Fixes: 9e48155f6bfe ("i2c: i2c-stm32f7: Add initial SMBus protocols support")
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>
Acked-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-stm32f7.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -1059,9 +1059,10 @@ static int stm32f7_i2c_smbus_xfer_msg(st
 	/* Configure PEC */
 	if ((flags & I2C_CLIENT_PEC) && f7_msg->size != I2C_SMBUS_QUICK) {
 		cr1 |= STM32F7_I2C_CR1_PECEN;
-		cr2 |= STM32F7_I2C_CR2_PECBYTE;
-		if (!f7_msg->read_write)
+		if (!f7_msg->read_write) {
+			cr2 |= STM32F7_I2C_CR2_PECBYTE;
 			f7_msg->count++;
+		}
 	} else {
 		cr1 &= ~STM32F7_I2C_CR1_PECEN;
 		cr2 &= ~STM32F7_I2C_CR2_PECBYTE;
@@ -1149,8 +1150,10 @@ static void stm32f7_i2c_smbus_rep_start(
 	f7_msg->stop = true;
 
 	/* Add one byte for PEC if needed */
-	if (cr1 & STM32F7_I2C_CR1_PECEN)
+	if (cr1 & STM32F7_I2C_CR1_PECEN) {
+		cr2 |= STM32F7_I2C_CR2_PECBYTE;
 		f7_msg->count++;
+	}
 
 	/* Set number of bytes to be transferred */
 	cr2 &= ~(STM32F7_I2C_CR2_NBYTES_MASK);


