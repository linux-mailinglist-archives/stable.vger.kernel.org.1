Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01267ECBD0
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjKOTYj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjKOTYj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:24:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7174912C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:24:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE40C433C8;
        Wed, 15 Nov 2023 19:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076276;
        bh=jn62uk5TuXuSABVw6VkfWmLOIphJrJl72rANMLwdwlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MmIx3rTze+sMjTfFtWSHTySiUPOA05XL2IYQMVXmjS0NHpzy0Pyqvun4P6HSMWRPo
         2e5tO97dP2H5PmUJTyCVaXXJHqKnPIPittB06UFlHtbsYkxbyBwRUuGKJR9uqAB9dS
         mMVzFh4IXFvdv4JylkMZxTsjD8QmMsOB77D0NFQ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 187/550] clk: mediatek: fix double free in mtk_clk_register_pllfh()
Date:   Wed, 15 Nov 2023 14:12:51 -0500
Message-ID: <20231115191613.701328826@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit bd54ccc0f147019dac38e7841876a7415459b875 ]

The mtk_clk_register_pll_ops() currently frees the "pll" parameter.
The function has two callers, mtk_clk_register_pll() and
mtk_clk_register_pllfh().  The first one, the _pll() function relies on
the free, but for the second _pllfh() function it causes a double free
bug.

Really the frees should be done in the caller because that's where
the allocation is.

Fixes: d7964de8a8ea ("clk: mediatek: Add new clock driver to handle FHCTL hardware")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/cd7fa365-28cc-4c34-ac64-6da57c98baa6@moroto.mountain
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mediatek/clk-pll.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index a4eca5fd539c8..513ab6b1b3229 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -321,10 +321,8 @@ struct clk_hw *mtk_clk_register_pll_ops(struct mtk_clk_pll *pll,
 
 	ret = clk_hw_register(NULL, &pll->hw);
 
-	if (ret) {
-		kfree(pll);
+	if (ret)
 		return ERR_PTR(ret);
-	}
 
 	return &pll->hw;
 }
@@ -340,6 +338,8 @@ struct clk_hw *mtk_clk_register_pll(const struct mtk_pll_data *data,
 		return ERR_PTR(-ENOMEM);
 
 	hw = mtk_clk_register_pll_ops(pll, data, base, &mtk_pll_ops);
+	if (IS_ERR(hw))
+		kfree(pll);
 
 	return hw;
 }
-- 
2.42.0



