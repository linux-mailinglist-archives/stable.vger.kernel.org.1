Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4412673E85F
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjFZSZO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjFZSYr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:24:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BB9268C
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:24:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7F0360F30
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF352C433CA;
        Mon, 26 Jun 2023 18:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803853;
        bh=+Mljsuej5wv46TxjC+eGYKwSemJD87R+3PYWElssA4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UqAuQcDuDpRKTM0M1aFORmFmh9T2fFA5nntb1bXONnVE7O6heKbCOoVDz/MnC9P+I
         6Hkf9+12mG1MyD9qWH+2GMHVso3DUw4jWbv4KxyfgZIp0MNp9CaIWywfLNuChfIOpS
         7Aor3dgp8LUEPa/5HD3cCg8vedj+FOltmYGpaoRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Zheng <david.zheng@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 183/199] i2c: designware: fix idx_write_cnt in read loop
Date:   Mon, 26 Jun 2023 20:11:29 +0200
Message-ID: <20230626180813.787122663@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

From: David Zheng <david.zheng@intel.com>

[ Upstream commit 1acfc6e753ed978b36d722f54e57fe4d1e8a6ffa ]

With IC_INTR_RX_FULL slave interrupt handler reads data in a loop until
RX FIFO is empty. When testing with the slave-eeprom, each transaction
has 2 bytes for address/index and 1 byte for value, the address byte
can be written as data byte due to dropping STOP condition.

In the test below, the master continuously writes to the slave, first 2
bytes are index, 3rd byte is value and follow by a STOP condition.

 i2c_write: i2c-3 #0 a=04b f=0000 l=3 [00-D1-D1]
 i2c_write: i2c-3 #0 a=04b f=0000 l=3 [00-D2-D2]
 i2c_write: i2c-3 #0 a=04b f=0000 l=3 [00-D3-D3]

Upon receiving STOP condition slave eeprom would reset `idx_write_cnt` so
next 2 bytes can be treated as buffer index for upcoming transaction.
Supposedly the slave eeprom buffer would be written as

 EEPROM[0x00D1] = 0xD1
 EEPROM[0x00D2] = 0xD2
 EEPROM[0x00D3] = 0xD3

When CPU load is high the slave irq handler may not read fast enough,
the interrupt status can be seen as 0x204 with both DW_IC_INTR_STOP_DET
(0x200) and DW_IC_INTR_RX_FULL (0x4) bits. The slave device may see
the transactions below.

 0x1 STATUS SLAVE_ACTIVITY=0x1 : RAW_INTR_STAT=0x1594 : INTR_STAT=0x4
 0x1 STATUS SLAVE_ACTIVITY=0x1 : RAW_INTR_STAT=0x1594 : INTR_STAT=0x4
 0x1 STATUS SLAVE_ACTIVITY=0x1 : RAW_INTR_STAT=0x1594 : INTR_STAT=0x4
 0x1 STATUS SLAVE_ACTIVITY=0x1 : RAW_INTR_STAT=0x1794 : INTR_STAT=0x204
 0x1 STATUS SLAVE_ACTIVITY=0x0 : RAW_INTR_STAT=0x1790 : INTR_STAT=0x200
 0x1 STATUS SLAVE_ACTIVITY=0x1 : RAW_INTR_STAT=0x1594 : INTR_STAT=0x4
 0x1 STATUS SLAVE_ACTIVITY=0x1 : RAW_INTR_STAT=0x1594 : INTR_STAT=0x4
 0x1 STATUS SLAVE_ACTIVITY=0x1 : RAW_INTR_STAT=0x1594 : INTR_STAT=0x4

After `D1` is received, read loop continues to read `00` which is the
first bype of next index. Since STOP condition is ignored by the loop,
eeprom buffer index increased to `D2` and `00` is written as value.

So the slave eeprom buffer becomes

 EEPROM[0x00D1] = 0xD1
 EEPROM[0x00D2] = 0x00
 EEPROM[0x00D3] = 0xD3

The fix is to use `FIRST_DATA_BYTE` (bit 11) in `IC_DATA_CMD` to split
the transactions. The first index byte in this case would have bit 11
set. Check this indication to inject I2C_SLAVE_WRITE_REQUESTED event
which will reset `idx_write_cnt` in slave eeprom.

Signed-off-by: David Zheng <david.zheng@intel.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-designware-core.h  | 1 +
 drivers/i2c/busses/i2c-designware-slave.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 050d8c63ad3c5..0164d92163308 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -40,6 +40,7 @@
 #define DW_IC_CON_BUS_CLEAR_CTRL		BIT(11)
 
 #define DW_IC_DATA_CMD_DAT			GENMASK(7, 0)
+#define DW_IC_DATA_CMD_FIRST_DATA_BYTE		BIT(11)
 
 /*
  * Registers offset
diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index cec25054bb244..2e079cf20bb5b 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -176,6 +176,10 @@ static irqreturn_t i2c_dw_isr_slave(int this_irq, void *dev_id)
 
 		do {
 			regmap_read(dev->map, DW_IC_DATA_CMD, &tmp);
+			if (tmp & DW_IC_DATA_CMD_FIRST_DATA_BYTE)
+				i2c_slave_event(dev->slave,
+						I2C_SLAVE_WRITE_REQUESTED,
+						&val);
 			val = tmp;
 			i2c_slave_event(dev->slave, I2C_SLAVE_WRITE_RECEIVED,
 					&val);
-- 
2.39.2



