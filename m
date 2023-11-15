Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377447ED4E3
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344756AbjKOU73 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344786AbjKOU6G (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:58:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5342BD5A
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF00C4E763;
        Wed, 15 Nov 2023 20:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081524;
        bh=JojXOYgurHY0k8kr6fjNMYqy790RBaIfvRRwjb2u4gU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i+BdLW/cJTRYIpV1klspaLdttYzep3mF1w+jiTlRfPXJgf7I8OVIG1IgwIZX39q71
         EkClF7J6eUMGrSowR8xufLFfXbwzcIfl4mlGAIhM8lvInojQ07RuU73vw2x1RWumyA
         3FLQB8W9A6ZKNhT5wPF9xL0t4DsFFxzEIBnyhAHw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 206/244] media: cedrus: Fix clock/reset sequence
Date:   Wed, 15 Nov 2023 15:36:38 -0500
Message-ID: <20231115203600.719030906@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jernej Skrabec <jernej.skrabec@gmail.com>

[ Upstream commit 36fe515c1a3cd5eac148e8a591a82108d92d5522 ]

According to H6 user manual, resets should always be de-asserted before
clocks are enabled. This is also consistent with vendor driver.

Fixes: d5aecd289bab ("media: cedrus: Implement runtime PM")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../staging/media/sunxi/cedrus/cedrus_hw.c    | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
index e2f2ff609c7e6..0904aea782b1e 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
@@ -147,12 +147,12 @@ int cedrus_hw_suspend(struct device *device)
 {
 	struct cedrus_dev *dev = dev_get_drvdata(device);
 
-	reset_control_assert(dev->rstc);
-
 	clk_disable_unprepare(dev->ram_clk);
 	clk_disable_unprepare(dev->mod_clk);
 	clk_disable_unprepare(dev->ahb_clk);
 
+	reset_control_assert(dev->rstc);
+
 	return 0;
 }
 
@@ -161,11 +161,18 @@ int cedrus_hw_resume(struct device *device)
 	struct cedrus_dev *dev = dev_get_drvdata(device);
 	int ret;
 
+	ret = reset_control_reset(dev->rstc);
+	if (ret) {
+		dev_err(dev->dev, "Failed to apply reset\n");
+
+		return ret;
+	}
+
 	ret = clk_prepare_enable(dev->ahb_clk);
 	if (ret) {
 		dev_err(dev->dev, "Failed to enable AHB clock\n");
 
-		return ret;
+		goto err_rst;
 	}
 
 	ret = clk_prepare_enable(dev->mod_clk);
@@ -182,21 +189,14 @@ int cedrus_hw_resume(struct device *device)
 		goto err_mod_clk;
 	}
 
-	ret = reset_control_reset(dev->rstc);
-	if (ret) {
-		dev_err(dev->dev, "Failed to apply reset\n");
-
-		goto err_ram_clk;
-	}
-
 	return 0;
 
-err_ram_clk:
-	clk_disable_unprepare(dev->ram_clk);
 err_mod_clk:
 	clk_disable_unprepare(dev->mod_clk);
 err_ahb_clk:
 	clk_disable_unprepare(dev->ahb_clk);
+err_rst:
+	reset_control_assert(dev->rstc);
 
 	return ret;
 }
-- 
2.42.0



