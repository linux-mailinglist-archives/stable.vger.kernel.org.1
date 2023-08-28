Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF8678AC72
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjH1KkA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjH1Kjm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:39:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C2BA7
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:39:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2753D63FF9
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A30BC433CA;
        Mon, 28 Aug 2023 10:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219179;
        bh=xfSQaXN/l2azzKSuvt5eTmYIXVwKUglpch4q1BWw0/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W4ESri3ZasXujN6QWoQp7g1Evzw46W1gJkaiDuoPnmt1cdvZEGeRw35qHz5g/RHNJ
         2FNLjF7qC404U62dmEE3qX2U1XX12ii18TQrI7zMCYGgwGY109NL+6usLfSA5yazbm
         BqTWoWwC+LnhxgN9ZjjuF4Pb9bsUttMXY1VwIOhk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alfred Lee <l00g33k@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 072/158] net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset
Date:   Mon, 28 Aug 2023 12:12:49 +0200
Message-ID: <20230828101159.710904896@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alfred Lee <l00g33k@gmail.com>

[ Upstream commit 23d775f12dcd23d052a4927195f15e970e27ab26 ]

If the switch is reset during active EEPROM transactions, as in
just after an SoC reset after power up, the I2C bus transaction
may be cut short leaving the EEPROM internal I2C state machine
in the wrong state.  When the switch is reset again, the bad
state machine state may result in data being read from the wrong
memory location causing the switch to enter unexpected mode
rendering it inoperational.

Fixes: a3dcb3e7e70c ("net: dsa: mv88e6xxx: Wait for EEPROM done after HW reset")
Signed-off-by: Alfred Lee <l00g33k@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20230815001323.24739-1-l00g33k@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 393ee145ae066..ca705a0e0961c 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2143,6 +2143,14 @@ static void mv88e6xxx_hardware_reset(struct mv88e6xxx_chip *chip)
 
 	/* If there is a GPIO connected to the reset pin, toggle it */
 	if (gpiod) {
+		/* If the switch has just been reset and not yet completed
+		 * loading EEPROM, the reset may interrupt the I2C transaction
+		 * mid-byte, causing the first EEPROM read after the reset
+		 * from the wrong location resulting in the switch booting
+		 * to wrong mode and inoperable.
+		 */
+		mv88e6xxx_g1_wait_eeprom_done(chip);
+
 		gpiod_set_value_cansleep(gpiod, 1);
 		usleep_range(10000, 20000);
 		gpiod_set_value_cansleep(gpiod, 0);
-- 
2.40.1



