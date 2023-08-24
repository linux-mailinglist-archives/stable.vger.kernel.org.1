Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3D678733D
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 17:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242001AbjHXPBf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 11:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242013AbjHXPBN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 11:01:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F3C19AA
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 08:01:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5F8E615C7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 15:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD58C433C8;
        Thu, 24 Aug 2023 15:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889270;
        bh=ULPhKOLKZyMLwIVxd7FhOg90VZ2R6hnUVS6rlTnk6Oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejTzbx0/Ja+eNbmYFCbPba9ssUp+R5/MPAKmsR3SDzlm0ttpVO3heBi477SfMd22T
         n/FEIHEtY5xFCb8V+re+3T1o4U4bU0Vn5I+NmFX1z/q78RLfXtyJ2rERCM9nzJDrTN
         KyCecpVBl0fWQ2TxMUCkNk/yWUvI/eM2L/GZuqa0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Tam Nguyen <tamnguyenchi@os.amperecomputing.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 5.10 075/135] i2c: designware: Handle invalid SMBus block data response length value
Date:   Thu, 24 Aug 2023 16:50:18 +0200
Message-ID: <20230824145030.113804366@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145027.008282920@linuxfoundation.org>
References: <20230824145027.008282920@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tam Nguyen <tamnguyenchi@os.amperecomputing.com>

commit 69f035c480d76f12bf061148ccfd578e1099e5fc upstream.

In the I2C_FUNC_SMBUS_BLOCK_DATA case, the invalid length byte value
(outside of 1-32) of the SMBus block data response from the Slave device
is not correctly handled by the I2C Designware driver.

In case IC_EMPTYFIFO_HOLD_MASTER_EN==1, which cannot be detected
from the registers, the Master can be disabled only if the STOP bit
is set. Without STOP bit set, the Master remains active, holding the bus
until receiving a block data response length. This hangs the bus and
is unrecoverable.

Avoid this by issuing another dump read to reach the stop condition when
an invalid length byte is received.

Cc: stable@vger.kernel.org
Signed-off-by: Tam Nguyen <tamnguyenchi@os.amperecomputing.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20230726080001.337353-3-tamnguyenchi@os.amperecomputing.com
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-designware-master.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -432,8 +432,19 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 
 			regmap_read(dev->map, DW_IC_DATA_CMD, &tmp);
 			/* Ensure length byte is a valid value */
-			if (flags & I2C_M_RECV_LEN &&
-			    tmp <= I2C_SMBUS_BLOCK_MAX && tmp > 0) {
+			if (flags & I2C_M_RECV_LEN) {
+				/*
+				 * if IC_EMPTYFIFO_HOLD_MASTER_EN is set, which cannot be
+				 * detected from the registers, the controller can be
+				 * disabled if the STOP bit is set. But it is only set
+				 * after receiving block data response length in
+				 * I2C_FUNC_SMBUS_BLOCK_DATA case. That needs to read
+				 * another byte with STOP bit set when the block data
+				 * response length is invalid to complete the transaction.
+				 */
+				if (!tmp || tmp > I2C_SMBUS_BLOCK_MAX)
+					tmp = 1;
+
 				len = i2c_dw_recv_len(dev, tmp);
 			}
 			*buf++ = tmp;


