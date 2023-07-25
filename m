Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E617611F9
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjGYK6f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbjGYK56 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:57:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA2A4696
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:55:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFEE461656
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDAFC433C8;
        Tue, 25 Jul 2023 10:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282502;
        bh=PpPdT6IQRWL70+jo9Q++ntwn0Yf8jgAz3kvQxu+dBMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PL8JsteYytq3ZtQt9Vv1Oe/fqEKpuFFr50K66KytYm/jPSbKkrIR9MPcXLo9+GjdU
         va7fECo1qS4Sj+Pn/VjepjFK3CQVBlytoURSr29n0XhiM/Ys4s6BmIgU/kaHcJrHLw
         sd/1nJty9WRPqrP0vuvvbeDnGjw4WB7hyGIMIcT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrew Lunn <andrew@lunn.ch>,
        Tobias Waldekranz <tobias@waldekranz.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 152/227] dsa: mv88e6xxx: Do a final check before timing out
Date:   Tue, 25 Jul 2023 12:45:19 +0200
Message-ID: <20230725104521.211115806@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 95ce158b6c93b28842b54b42ad1cb221b9844062 ]

I get sporadic timeouts from the driver when using the
MV88E6352. Reading the status again after the loop fixes the
problem: the operation is successful but goes undetected.

Some added prints show things like this:

[   58.356209] mv88e6085 mdio_mux-0.1:00: Timeout while waiting
    for switch, addr 1b reg 0b, mask 8000, val 0000, data c000
[   58.367487] mv88e6085 mdio_mux-0.1:00: Timeout waiting for
    ATU op 4000, fid 0001
(...)
[   61.826293] mv88e6085 mdio_mux-0.1:00: Timeout while waiting
    for switch, addr 1c reg 18, mask 8000, val 0000, data 9860
[   61.837560] mv88e6085 mdio_mux-0.1:00: Timeout waiting
    for PHY command 1860 to complete

The reason is probably not the commands: I think those are
mostly fine with the 50+50ms timeout, but the problem
appears when OpenWrt brings up several interfaces in
parallel on a system with 7 populated ports: if one of
them take more than 50 ms and waits one or more of the
others can get stuck on the mutex for the switch and then
this can easily multiply.

As we sleep and wait, the function loop needs a final
check after exiting the loop if we were successful.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Cc: Tobias Waldekranz <tobias@waldekranz.com>
Fixes: 35da1dfd9484 ("net: dsa: mv88e6xxx: Improve performance of busy bit polling")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20230712223405.861899-1-linus.walleij@linaro.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 08a46ffd53af9..642e93e8623eb 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -109,6 +109,13 @@ int mv88e6xxx_wait_mask(struct mv88e6xxx_chip *chip, int addr, int reg,
 			usleep_range(1000, 2000);
 	}
 
+	err = mv88e6xxx_read(chip, addr, reg, &data);
+	if (err)
+		return err;
+
+	if ((data & mask) == val)
+		return 0;
+
 	dev_err(chip->dev, "Timeout while waiting for switch\n");
 	return -ETIMEDOUT;
 }
-- 
2.39.2



