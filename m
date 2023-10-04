Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183687B8891
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244087AbjJDSRe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244085AbjJDSRd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:17:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FCCAD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:17:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282A6C433C7;
        Wed,  4 Oct 2023 18:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443449;
        bh=/tkbAhIUsUricz7Vj9qZqF6sGQOOr5LhHcY4azyu6Yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TRbm7O67XALbNdMikhcwRoZ5RAgTt4YN4UsqJn7HoR/fFMYy8bCO2CzK7XPaXIml4
         xDSWFhqr+Qjql1cdBW4cCpYB4OY/huQWq7nNO5j6F1yiFv578IiWmUzD8JSsvxBvqO
         5mTTQTvVO192C7HqDK25dxRJX+HFjfal+qSNtsjg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@oracle.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 132/259] power: supply: rk817: Fix node refcount leak
Date:   Wed,  4 Oct 2023 19:55:05 +0200
Message-ID: <20231004175223.428180761@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
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

From: Chris Morgan <macromorgan@hotmail.com>

[ Upstream commit 488ef44c068e79752dba8eda0b75f524f111a695 ]

Dan Carpenter reports that the Smatch static checker warning has found
that there is another refcount leak in the probe function. While
of_node_put() was added in one of the return paths, it should in
fact be added for ALL return paths that return an error and at driver
removal time.

Fixes: 54c03bfd094f ("power: supply: Fix refcount leak in rk817_charger_probe")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Closes: https://lore.kernel.org/linux-pm/dc0bb0f8-212d-4be7-be69-becd2a3f9a80@kili.mountain/
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Link: https://lore.kernel.org/r/20230920145644.57964-1-macroalpha82@gmail.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/rk817_charger.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index f1b431aa0e4f2..e30ef601d91da 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -1058,6 +1058,13 @@ static void rk817_charging_monitor(struct work_struct *work)
 	queue_delayed_work(system_wq, &charger->work, msecs_to_jiffies(8000));
 }
 
+static void rk817_cleanup_node(void *data)
+{
+	struct device_node *node = data;
+
+	of_node_put(node);
+}
+
 static int rk817_charger_probe(struct platform_device *pdev)
 {
 	struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
@@ -1074,11 +1081,13 @@ static int rk817_charger_probe(struct platform_device *pdev)
 	if (!node)
 		return -ENODEV;
 
+	ret = devm_add_action_or_reset(&pdev->dev, rk817_cleanup_node, node);
+	if (ret)
+		return ret;
+
 	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
-	if (!charger) {
-		of_node_put(node);
+	if (!charger)
 		return -ENOMEM;
-	}
 
 	charger->rk808 = rk808;
 
-- 
2.40.1



