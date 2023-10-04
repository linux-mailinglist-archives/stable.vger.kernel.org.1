Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3C17B89C3
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244271AbjJDS3B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244272AbjJDS3B (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:29:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7740BF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:28:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E69CC433C7;
        Wed,  4 Oct 2023 18:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444137;
        bh=GkfID3NuDmMQd6zrhZyl+6eUSMPfzGV8Zwipui1W4HI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b2R2qwZ01IFjfqpQddRVntp38ZnZats1ASdlZzBfpqsnU4xdlT4HL1gvZVOqtMB62
         g8N6OVAgtArm7Fal57IBUXXKmfmfMen1BQCUf4ysyWBEgV4c+LwvLx5o6IQPt1Gtk9
         MkEiGyx14WHCzY9XH/n64JF3XMP53NptNrsaDWsQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@oracle.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 143/321] power: supply: rk817: Fix node refcount leak
Date:   Wed,  4 Oct 2023 19:54:48 +0200
Message-ID: <20231004175235.870477367@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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
index 8328bcea1a299..242e158824222 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -1045,6 +1045,13 @@ static void rk817_charging_monitor(struct work_struct *work)
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
@@ -1061,11 +1068,13 @@ static int rk817_charger_probe(struct platform_device *pdev)
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



