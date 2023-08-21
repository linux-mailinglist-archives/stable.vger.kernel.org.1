Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C487831C9
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjHUT4N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjHUT4N (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:56:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FBB129
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:56:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9CE7645E7
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F46C433C8;
        Mon, 21 Aug 2023 19:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647768;
        bh=ZqXMqSGFTK4y2HZnHJYay9/4BD3AFpaWThPFUV+6aUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zHdmJv1fTWNRpGSxTeWgrn3lwY6n6Wduj3jCYqy1OzaJxOCO7HAma75ITF2mVU7fE
         aYogstSfkydGNGUFRSAd3MtcKBCVSp6pNJuJ+tuxnYXimiMMDa8a38N4PItAwHNBnR
         bwdm16B73pcGLFsLMrbfYoaCBstWkiiskbJiqR2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Tam Nguyen <tamnguyenchi@os.amperecomputing.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 6.1 102/194] i2c: designware: Correct length byte validation logic
Date:   Mon, 21 Aug 2023 21:41:21 +0200
Message-ID: <20230821194127.175853783@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
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

From: Quan Nguyen <quan@os.amperecomputing.com>

commit 49d4db3953cb9004ff94efc0c176e026c820af5a upstream.

Commit 0daede80f870 ("i2c: designware: Convert driver to using regmap API")
changes the logic to validate the whole 32-bit return value of
DW_IC_DATA_CMD register instead of 8-bit LSB without reason.

Later, commit f53f15ba5a85 ("i2c: designware: Get right data length"),
introduced partial fix but not enough because the "tmp > 0" still test
tmp as 32-bit value and is wrong in case the IC_DATA_CMD[11] is set.

Revert the logic to just before commit 0daede80f870
("i2c: designware: Convert driver to using regmap API").

Fixes: f53f15ba5a85 ("i2c: designware: Get right data length")
Fixes: 0daede80f870 ("i2c: designware: Convert driver to using regmap API")
Cc: stable@vger.kernel.org
Signed-off-by: Tam Nguyen <tamnguyenchi@os.amperecomputing.com>
Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20230726080001.337353-2-tamnguyenchi@os.amperecomputing.com
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-designware-master.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -525,9 +525,10 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 			u32 flags = msgs[dev->msg_read_idx].flags;
 
 			regmap_read(dev->map, DW_IC_DATA_CMD, &tmp);
+			tmp &= DW_IC_DATA_CMD_DAT;
 			/* Ensure length byte is a valid value */
 			if (flags & I2C_M_RECV_LEN &&
-			    (tmp & DW_IC_DATA_CMD_DAT) <= I2C_SMBUS_BLOCK_MAX && tmp > 0) {
+			    tmp <= I2C_SMBUS_BLOCK_MAX && tmp > 0) {
 				len = i2c_dw_recv_len(dev, tmp);
 			}
 			*buf++ = tmp;


