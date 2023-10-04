Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF777B89B2
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244256AbjJDS2S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244255AbjJDS2S (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:28:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10160C1
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:28:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F53FC433C7;
        Wed,  4 Oct 2023 18:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444094;
        bh=vcVklMgi+tO6hc/6P/wmuPaEMWslcGYqNGUEUXqlUUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kxwwnq7zsvxmeQCjtinqui7ItGbAOr47mkCvea2v0Z87QSn/w3ACuO66aEwvbITOn
         Uo2ijht8aYjVGO7edX296+1g6bPkA8axmoDEZa9M85rn0aso+J2rto6Otv7sVSIK0J
         0KkoDjjX8kf5fSbcirsp+OSTCs2wlhzS1GnJz9xU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Timo Alho <talho@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 129/321] clk: tegra: fix error return case for recalc_rate
Date:   Wed,  4 Oct 2023 19:54:34 +0200
Message-ID: <20231004175235.226667148@linuxfoundation.org>
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

From: Timo Alho <talho@nvidia.com>

[ Upstream commit a47b44fbb13f5e7a981b4515dcddc93a321ae89c ]

tegra-bpmp clocks driver makes implicit conversion of signed error
code to unsigned value in recalc_rate operation. The behavior for
recalc_rate, according to it's specification, should be that "If the
driver cannot figure out a rate for this clock, it must return 0."

Fixes: ca6f2796eef7 ("clk: tegra: Add BPMP clock driver")
Signed-off-by: Timo Alho <talho@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Link: https://lore.kernel.org/r/20230912112951.2330497-1-cyndis@kapsi.fi
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/tegra/clk-bpmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
index a9f3fb448de62..7bfba0afd7783 100644
--- a/drivers/clk/tegra/clk-bpmp.c
+++ b/drivers/clk/tegra/clk-bpmp.c
@@ -159,7 +159,7 @@ static unsigned long tegra_bpmp_clk_recalc_rate(struct clk_hw *hw,
 
 	err = tegra_bpmp_clk_transfer(clk->bpmp, &msg);
 	if (err < 0)
-		return err;
+		return 0;
 
 	return response.rate;
 }
-- 
2.40.1



