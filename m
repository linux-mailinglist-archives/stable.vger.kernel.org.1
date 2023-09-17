Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB057A394D
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240011AbjIQTro (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240005AbjIQTrO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:47:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B78103
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:47:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28F0C433C7;
        Sun, 17 Sep 2023 19:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980029;
        bh=dBuHvkTi3Ju4QL/yftbIRKVi6SjxFHdxegfRYGEpUes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tJrZ8X4M5hS/pO0jJuopk4ohhtm47bnB/sj7xeW6xetKX4NJFyBgzUInZjr9iVtrw
         XtuX86CyNZEJ3MMYUmItllUJc5g4DwSWZvd8v1EUNkh3xdL9iMg9qlPcB/X7GeC5Ja
         lCi1F9hu196ToOsHRyAXHOt3KS00Wl1h6U+BytlA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 077/285] Input: tca6416-keypad - fix interrupt enable disbalance
Date:   Sun, 17 Sep 2023 21:11:17 +0200
Message-ID: <20230917191054.382620433@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit cc141c35af873c6796e043adcb820833bd8ef8c5 ]

The driver has been switched to use IRQF_NO_AUTOEN, but in the error
unwinding and remove paths calls to enable_irq() were left in place, which
will lead to an incorrect enable counter value.

Fixes: bcd9730a04a1 ("Input: move to use request_irq by IRQF_NO_AUTOEN flag")
Link: https://lore.kernel.org/r/20230724053024.352054-3-dmitry.torokhov@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/tca6416-keypad.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
index 01bc0b8811882..d20cbddfae68c 100644
--- a/drivers/input/keyboard/tca6416-keypad.c
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -292,10 +292,8 @@ static int tca6416_keypad_probe(struct i2c_client *client)
 	return 0;
 
 fail2:
-	if (!chip->use_polling) {
+	if (!chip->use_polling)
 		free_irq(client->irq, chip);
-		enable_irq(client->irq);
-	}
 fail1:
 	input_free_device(input);
 	kfree(chip);
@@ -306,10 +304,8 @@ static void tca6416_keypad_remove(struct i2c_client *client)
 {
 	struct tca6416_keypad_chip *chip = i2c_get_clientdata(client);
 
-	if (!chip->use_polling) {
+	if (!chip->use_polling)
 		free_irq(client->irq, chip);
-		enable_irq(client->irq);
-	}
 
 	input_unregister_device(chip->input);
 	kfree(chip);
-- 
2.40.1



