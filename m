Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595D27A3A80
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240451AbjIQUFV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbjIQUEu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:04:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8D6100
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:04:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57002C433C7;
        Sun, 17 Sep 2023 20:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981084;
        bh=yOTuOGxP/qgjPFheRWci00HqN1WbLV6evByZpJ2L8XQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kKddTn/qu9HEvgpJZKyRvnu5atx2zHqe3lC7l4CcWLZOeTKwILyYCZ9JmZQqqYFqd
         i1iP5dPK6MbqvBJYyDLdRfqmYgfk3BkP5GFiqr2MdFuVhSUxnmLIL0kYtASF88bzX9
         HJZReaciJmp/dHFjTExHYeheMPsV1MGMyorrkqno=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 071/219] Input: tca6416-keypad - fix interrupt enable disbalance
Date:   Sun, 17 Sep 2023 21:13:18 +0200
Message-ID: <20230917191043.562414214@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index b48adec8fe2e7..9c1489c0dae13 100644
--- a/drivers/input/keyboard/tca6416-keypad.c
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -292,10 +292,8 @@ static int tca6416_keypad_probe(struct i2c_client *client,
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



