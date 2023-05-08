Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8496FAE43
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbjEHLnJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236121AbjEHLmj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:42:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5B14453E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:42:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7781363585
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851A0C433D2;
        Mon,  8 May 2023 11:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546126;
        bh=UF+Wp5yUBHn6hBwVU/b/4Eqcu3M7Lz+3CEkvB5rwYd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GD2QyL+kAi2lefmHHcH2PgEElsnQ8Umc37RCQhCtewWaqsMHFqbI4CRYJmU9tmCt1
         LHIsOugP4/xa5lxl5y95zQvA8Avdeujf1O4Yhvfa3Khxom7Z8pnwJMOlXJIbQ5ziFF
         RFjWJjAdlXrWxqU2IMuZR7QhKsRRTuDg9s96vq8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@amd.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 266/371] i2c: cadence: cdns_i2c_master_xfer(): Fix runtime PM leak on error path
Date:   Mon,  8 May 2023 11:47:47 +0200
Message-Id: <20230508094822.614773332@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Lars-Peter Clausen <lars@metafoo.de>

[ Upstream commit ae1664f04f504a998737f5bb563f16b44357bcca ]

The cdns_i2c_master_xfer() function gets a runtime PM reference when the
function is entered. This reference is released when the function is
exited. There is currently one error path where the function exits
directly, which leads to a leak of the runtime PM reference.

Make sure that this error path also releases the runtime PM reference.

Fixes: 1a351b10b967 ("i2c: cadence: Added slave support")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-cadence.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 33f5588a50c07..5ea92dc97f0c5 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -828,8 +828,10 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 	/* Check i2c operating mode and switch if possible */
 	if (id->dev_mode == CDNS_I2C_MODE_SLAVE) {
-		if (id->slave_state != CDNS_I2C_SLAVE_STATE_IDLE)
-			return -EAGAIN;
+		if (id->slave_state != CDNS_I2C_SLAVE_STATE_IDLE) {
+			ret = -EAGAIN;
+			goto out;
+		}
 
 		/* Set mode to master */
 		cdns_i2c_set_mode(CDNS_I2C_MODE_MASTER, id);
-- 
2.39.2



