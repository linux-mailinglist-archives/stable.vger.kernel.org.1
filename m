Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8656D7BE080
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377199AbjJINkw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377339AbjJINkv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:40:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B7194
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:40:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBB3C433C7;
        Mon,  9 Oct 2023 13:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858848;
        bh=2a6Ay11T+H99YJoz7sMrhZR4DD7df4y1lCwOxBQzOaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jVN9Flf2P6oNdrhIm+ZlhxsZVq8twiym4KYCOO6itD/QZhOtrapdBuMADvBmn5aTU
         dxoh1o7xXuRHLlMMpTU5qIX6NrJyb3SNrZ20FdcIB/a/k0x6KBr93FGya5v8YHe3wO
         jpUpSrmwX8iSDd6l7qy0Xbx17TuyVIMCcj1+4pkk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Timo Alho <talho@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 091/226] clk: tegra: fix error return case for recalc_rate
Date:   Mon,  9 Oct 2023 15:00:52 +0200
Message-ID: <20231009130129.147760693@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index a66263b6490d3..00845044c98ef 100644
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



