Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B3F7B878A
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjJDSGe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243810AbjJDSGd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:06:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B8C9E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:06:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F6EC433C7;
        Wed,  4 Oct 2023 18:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442789;
        bh=JLKDp/fgfQ7p6GsKA6KtC09J1vNXlac6id2dEvO475s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oszz9pAv6NSfOvme8VT5DShURQPb5HvxfkUZJ58mUDyggHlNcqy0cYSwLIveVCmta
         W9PHBTSlTVHZhJlxQIuoIphKkXLvN6kOEuBMMgjGs+YZ8IzeQUQJIOzCkfWpYUzIRE
         vurupbXqMBrK2H5S7wmT/vdAWy8ZJtwGf96cA8Qs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "William A. Kennington III" <william@wkennington.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 109/183] i2c: npcm7xx: Fix callback completion ordering
Date:   Wed,  4 Oct 2023 19:55:40 +0200
Message-ID: <20231004175208.465129652@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: William A. Kennington III <william@wkennington.com>

[ Upstream commit 92e73d807b68b2214fcafca4e130b5300a9d4b3c ]

Sometimes, our completions race with new master transfers and override
the bus->operation and bus->master_or_slave variables. This causes
transactions to timeout and kernel crashes less frequently.

To remedy this, we re-order all completions to the very end of the
function.

Fixes: 56a1485b102e ("i2c: npcm7xx: Add Nuvoton NPCM I2C controller driver")
Signed-off-by: William A. Kennington III <william@wkennington.com>
Reviewed-by: Tali Perry <tali.perry1@gmail.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-npcm7xx.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-npcm7xx.c b/drivers/i2c/busses/i2c-npcm7xx.c
index c1b6797372409..73c808ef1bfe5 100644
--- a/drivers/i2c/busses/i2c-npcm7xx.c
+++ b/drivers/i2c/busses/i2c-npcm7xx.c
@@ -675,6 +675,7 @@ static void npcm_i2c_callback(struct npcm_i2c *bus,
 {
 	struct i2c_msg *msgs;
 	int msgs_num;
+	bool do_complete = false;
 
 	msgs = bus->msgs;
 	msgs_num = bus->msgs_num;
@@ -701,23 +702,17 @@ static void npcm_i2c_callback(struct npcm_i2c *bus,
 				 msgs[1].flags & I2C_M_RD)
 				msgs[1].len = info;
 		}
-		if (completion_done(&bus->cmd_complete) == false)
-			complete(&bus->cmd_complete);
-	break;
-
+		do_complete = true;
+		break;
 	case I2C_NACK_IND:
 		/* MASTER transmit got a NACK before tx all bytes */
 		bus->cmd_err = -ENXIO;
-		if (bus->master_or_slave == I2C_MASTER)
-			complete(&bus->cmd_complete);
-
+		do_complete = true;
 		break;
 	case I2C_BUS_ERR_IND:
 		/* Bus error */
 		bus->cmd_err = -EAGAIN;
-		if (bus->master_or_slave == I2C_MASTER)
-			complete(&bus->cmd_complete);
-
+		do_complete = true;
 		break;
 	case I2C_WAKE_UP_IND:
 		/* I2C wake up */
@@ -731,6 +726,8 @@ static void npcm_i2c_callback(struct npcm_i2c *bus,
 	if (bus->slave)
 		bus->master_or_slave = I2C_SLAVE;
 #endif
+	if (do_complete)
+		complete(&bus->cmd_complete);
 }
 
 static u8 npcm_i2c_fifo_usage(struct npcm_i2c *bus)
-- 
2.40.1



