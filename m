Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F2C79B0FE
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244558AbjIKWZs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239421AbjIKOUH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:20:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A88DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:20:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9042FC433C7;
        Mon, 11 Sep 2023 14:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442002;
        bh=Xtfz33bwtvBTXuNOxNDbg8xsGZeG0xAbBp4DIgEC3eY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2TK9Hw5t/m/KjCVTwZXqmbEhgLzFJ8eWThUks/I41vtBlYSmegiAW3Pctn5gAV1V
         gO6gpN6otWAYuOw464Gvlw5rb5w2DSGQ9Uu2l+oN2yrD7C6URrzSAgCHY5llHs9sp9
         WZP8uRX71wYx3jv8Rd83xLczZ7yVvxomn3Ytkzd4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+3a0ebe8a52b89c63739d@syzkaller.appspotmail.com,
        Maxime Ripard <mripard@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rahul Rameshbabu <sergeantsagara@protonmail.com>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 585/739] HID: uclogic: Correct devm device reference for hidinput input_dev name
Date:   Mon, 11 Sep 2023 15:46:24 +0200
Message-ID: <20230911134707.445214831@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rahul Rameshbabu <sergeantsagara@protonmail.com>

[ Upstream commit dd613a4e45f8d35f49a63a2064e5308fa5619e29 ]

Reference the HID device rather than the input device for the devm
allocation of the input_dev name. Referencing the input_dev would lead to a
use-after-free when the input_dev was unregistered and subsequently fires a
uevent that depends on the name. At the point of firing the uevent, the
name would be freed by devres management.

Use devm_kasprintf to simplify the logic for allocating memory and
formatting the input_dev name string.

Reported-by: syzbot+3a0ebe8a52b89c63739d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-input/ZOZIZCND+L0P1wJc@penguin/T/
Reported-by: Maxime Ripard <mripard@kernel.org>
Closes: https://lore.kernel.org/linux-input/ZOZIZCND+L0P1wJc@penguin/T/#m443f3dce92520f74b6cf6ffa8653f9c92643d4ae
Fixes: cce2dbdf258e ("HID: uclogic: name the input nodes based on their tool")
Suggested-by: Maxime Ripard <mripard@kernel.org>
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://lore.kernel.org/r/20230824061308.222021-2-sergeantsagara@protonmail.com
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-uclogic-core.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index f67835f9ed4cc..ad74cbc9a0aa5 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -85,10 +85,8 @@ static int uclogic_input_configured(struct hid_device *hdev,
 {
 	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
 	struct uclogic_params *params = &drvdata->params;
-	char *name;
 	const char *suffix = NULL;
 	struct hid_field *field;
-	size_t len;
 	size_t i;
 	const struct uclogic_params_frame *frame;
 
@@ -146,14 +144,9 @@ static int uclogic_input_configured(struct hid_device *hdev,
 		}
 	}
 
-	if (suffix) {
-		len = strlen(hdev->name) + 2 + strlen(suffix);
-		name = devm_kzalloc(&hi->input->dev, len, GFP_KERNEL);
-		if (name) {
-			snprintf(name, len, "%s %s", hdev->name, suffix);
-			hi->input->name = name;
-		}
-	}
+	if (suffix)
+		hi->input->name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
+						 "%s %s", hdev->name, suffix);
 
 	return 0;
 }
-- 
2.40.1



