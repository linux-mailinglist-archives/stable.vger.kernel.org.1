Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590BF75D2D5
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjGUTEK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjGUTEJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:04:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CF02D4A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:04:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1501C61D90
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B19C433C7;
        Fri, 21 Jul 2023 19:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966247;
        bh=QI5qMOurc9gYaqovOLPCtbjWe1yRZiSoHClNmCcwJvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L40eZkZHSxJ4/kynRLjv3TptXi+z6IQl51Y8V5hbPqWB1Y1MYZnRKkoVwqperve51
         /0lstE2qxgoUFJZ2jee6R7HlzcM1aSsiKnhkagzfXLIIFFKiVJKgoSTWd7A92QXsJM
         5H5JjNF1Ym1VC9l3hWad6GIDhCXCTK5dFiqTAi38=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 276/532] clk: qcom: reset: Allow specifying custom reset delay
Date:   Fri, 21 Jul 2023 18:03:00 +0200
Message-ID: <20230721160629.353657698@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Stephan Gerhold <stephan.gerhold@kernkonzept.com>

[ Upstream commit 2cb8a39b6781ea23accd1fa93b3ad000d0948aec ]

The amount of time required between asserting and deasserting the reset
signal can vary depending on the involved hardware component. Sometimes
1 us might not be enough and a larger delay is necessary to conform to
the specifications.

Usually this is worked around in the consuming drivers, by replacing
reset_control_reset() with a sequence of reset_control_assert(), waiting
for a custom delay, followed by reset_control_deassert().

However, in some cases the driver making use of the reset is generic and
can be used with different reset controllers. In this case the reset
time requirement is better handled directly by the reset controller
driver.

Make this possible by adding an "udelay" field to the qcom_reset_map
that allows setting a different reset delay (in microseconds).

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20220706134132.3623415-4-stephan.gerhold@kernkonzept.com
Stable-dep-of: 349b5bed539b ("clk: qcom: ipq6018: fix networking resets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/reset.c | 4 +++-
 drivers/clk/qcom/reset.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/reset.c b/drivers/clk/qcom/reset.c
index 819d194be8f7b..2a16adb572d2b 100644
--- a/drivers/clk/qcom/reset.c
+++ b/drivers/clk/qcom/reset.c
@@ -13,8 +13,10 @@
 
 static int qcom_reset(struct reset_controller_dev *rcdev, unsigned long id)
 {
+	struct qcom_reset_controller *rst = to_qcom_reset_controller(rcdev);
+
 	rcdev->ops->assert(rcdev, id);
-	udelay(1);
+	udelay(rst->reset_map[id].udelay ?: 1); /* use 1 us as default */
 	rcdev->ops->deassert(rcdev, id);
 	return 0;
 }
diff --git a/drivers/clk/qcom/reset.h b/drivers/clk/qcom/reset.h
index 2a08b5e282c77..b8c113582072b 100644
--- a/drivers/clk/qcom/reset.h
+++ b/drivers/clk/qcom/reset.h
@@ -11,6 +11,7 @@
 struct qcom_reset_map {
 	unsigned int reg;
 	u8 bit;
+	u8 udelay;
 };
 
 struct regmap;
-- 
2.39.2



