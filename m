Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CA879B9E8
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376702AbjIKWUS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239425AbjIKOUM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:20:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E326BDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:20:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB34C433C8;
        Mon, 11 Sep 2023 14:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442008;
        bh=k0Jng5tNiI0AyuvKN5JOS3N9CJHn8+aoJrLMYxcHMBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z0TIz7uRQhlmE9qBEOHhrgIZqqkNhHEHDchqRjuYTIWyw7XLa4K7nR0jeIrFGZQEb
         FOSR8uls8kATU6EXzAJ6psHDsdcng+gf7tg31S5YWEZU2JrKnzBzXuOCCIw7tHEIMw
         rrVOOiaxx1f/dnhzLppP69FLgYcO55ftS7VGNFFU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maxime Ripard <mripard@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 587/739] HID: nvidia-shield: Reference hid_device devm allocation of input_dev name
Date:   Mon, 11 Sep 2023 15:46:26 +0200
Message-ID: <20230911134707.500583506@linuxfoundation.org>
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

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

[ Upstream commit 197d3143520fec9fde89aebabc9f0d7464f08e50 ]

Use hid_device for devm allocation of the input_dev name to avoid a
use-after-free. input_unregister_device would trigger devres cleanup of all
resources associated with the input_dev, free-ing the name. The name would
subsequently be used in a uevent fired at the end of unregistering the
input_dev.

Reported-by: Maxime Ripard <mripard@kernel.org>
Closes: https://lore.kernel.org/linux-input/ZOZIZCND+L0P1wJc@penguin/T/#m443f3dce92520f74b6cf6ffa8653f9c92643d4ae
Fixes: 09308562d4af ("HID: nvidia-shield: Initial driver implementation with Thunderstrike support")
Suggested-by: Maxime Ripard <mripard@kernel.org>
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://lore.kernel.org/r/20230824061308.222021-4-sergeantsagara@protonmail.com
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-nvidia-shield.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shield.c
index 4e183650c4478..9c44974135079 100644
--- a/drivers/hid/hid-nvidia-shield.c
+++ b/drivers/hid/hid-nvidia-shield.c
@@ -164,7 +164,7 @@ static struct input_dev *shield_allocate_input_dev(struct hid_device *hdev,
 	idev->id.product = hdev->product;
 	idev->id.version = hdev->version;
 	idev->uniq = hdev->uniq;
-	idev->name = devm_kasprintf(&idev->dev, GFP_KERNEL, "%s %s", hdev->name,
+	idev->name = devm_kasprintf(&hdev->dev, GFP_KERNEL, "%s %s", hdev->name,
 				    name_suffix);
 	if (!idev->name)
 		goto err_name;
-- 
2.40.1



