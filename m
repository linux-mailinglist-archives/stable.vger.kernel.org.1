Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6F97A8127
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbjITMnC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbjITMnC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:43:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFE88F
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:42:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34F1C433C8;
        Wed, 20 Sep 2023 12:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213776;
        bh=2YbsDd+qphnJgvqKWnV2aN18d5wWIHl3ITBXWdXgi00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hoiOU6dHqJizSgO1zawibWXk9fMK0sjV1e/30+EkbaxvHhVl6Mc8Jg9NnOTc/cx9j
         RwuuD2y1PFCwVhUQUP/hmNdHSffZ3vhlup2DtknuQfZVFxSksRB+Ab+ssxF36MHBxU
         oYRXkuhkDjnBBvcUDKqjgM5I6PAM2kZCeXb5QABg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tommy Huang <tommy_huang@aspeedtech.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 5.4 362/367] i2c: aspeed: Reset the i2c controller when timeout occurs
Date:   Wed, 20 Sep 2023 13:32:19 +0200
Message-ID: <20230920112907.856127571@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tommy Huang <tommy_huang@aspeedtech.com>

commit fee465150b458351b6d9b9f66084f3cc3022b88b upstream.

Reset the i2c controller when an i2c transfer timeout occurs.
The remaining interrupts and device should be reset to avoid
unpredictable controller behavior.

Fixes: 2e57b7cebb98 ("i2c: aspeed: Add multi-master use case support")
Cc: <stable@vger.kernel.org> # v5.1+
Signed-off-by: Tommy Huang <tommy_huang@aspeedtech.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-aspeed.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -693,13 +693,16 @@ static int aspeed_i2c_master_xfer(struct
 
 	if (time_left == 0) {
 		/*
-		 * If timed out and bus is still busy in a multi master
-		 * environment, attempt recovery at here.
+		 * In a multi-master setup, if a timeout occurs, attempt
+		 * recovery. But if the bus is idle, we still need to reset the
+		 * i2c controller to clear the remaining interrupts.
 		 */
 		if (bus->multi_master &&
 		    (readl(bus->base + ASPEED_I2C_CMD_REG) &
 		     ASPEED_I2CD_BUS_BUSY_STS))
 			aspeed_i2c_recover_bus(bus);
+		else
+			aspeed_i2c_reset(bus);
 
 		/*
 		 * If timed out and the state is still pending, drop the pending


