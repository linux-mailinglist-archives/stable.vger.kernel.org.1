Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3673579AD24
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242272AbjIKVHX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239748AbjIKO1w (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:27:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11249F0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:27:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A42CC433C8;
        Mon, 11 Sep 2023 14:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442467;
        bh=Lp/VKQAj3gLyBKmDgGgoljehNbQ7uqcUX1oqFeG1r7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pU+n3AGpzup5fWeuOx+p7oUg8w7LJ2RgM6t65VHjcPS1J9uCABSouDkQ4jD2oERQH
         PZtqrpTckT+SQJnR6HjpPfZHfG1DL1knqkRTdr136HBDJJtp4akUyjZwniP+RLghIr
         6L35a9twX6D6c3mmIXxUOJyBg7pguuL5FaOaU2Po=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kristian Angelov <kristiana2000@abv.bg>,
        "Luke D. Jones" <luke@ljones.dev>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 036/737] platform/x86: asus-wmi: Fix setting RGB mode on some TUF laptops
Date:   Mon, 11 Sep 2023 15:38:15 +0200
Message-ID: <20230911134651.425179508@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kristian Angelov <kristiana2000@abv.bg>

[ Upstream commit 6a758a3e831ce1a84c9c209ac6dc755f4c8ce77a ]

This patch fixes setting the cmd values to 0xb3 and 0xb4.
This is necessary on some TUF laptops in order to set the RGB mode.

Closes: https://lore.kernel.org/platform-driver-x86/443078148.491022.1677576298133@nm83.abv.bg
Signed-off-by: Kristian Angelov <kristiana2000@abv.bg>
Reviewed-by: Luke D. Jones <luke@ljones.dev>
Link: https://lore.kernel.org/r/ZLlS7o6UdTUBkyqa@wyvern.localdomain
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-wmi.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 1038dfdcdd325..8bef66a2f0ce7 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -738,13 +738,23 @@ static ssize_t kbd_rgb_mode_store(struct device *dev,
 				 struct device_attribute *attr,
 				 const char *buf, size_t count)
 {
-	u32 cmd, mode, r, g,  b,  speed;
+	u32 cmd, mode, r, g, b, speed;
 	int err;
 
 	if (sscanf(buf, "%d %d %d %d %d %d", &cmd, &mode, &r, &g, &b, &speed) != 6)
 		return -EINVAL;
 
-	cmd = !!cmd;
+	/* B3 is set and B4 is save to BIOS */
+	switch (cmd) {
+	case 0:
+		cmd = 0xb3;
+		break;
+	case 1:
+		cmd = 0xb4;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	/* These are the known usable modes across all TUF/ROG */
 	if (mode >= 12 || mode == 9)
-- 
2.40.1



