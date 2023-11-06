Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFA17E2352
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjKFNLH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjKFNLE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:11:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73C4A9
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:11:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F16C433C9;
        Mon,  6 Nov 2023 13:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276261;
        bh=ePgqRN11B+ILxbec/R8Iv5/ZZN0pZrulWuVixrFuSEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WSQ0jht3Uex4orG8VE+QZIOj//OgXNih116gApMiKDhtirLnxYKZUh9kTLQKMDC5f
         pBOQqq15iQ0nshVeTt7di2HQJUAeuHcO+5s9kYrx4yW04vhjc18Bs3fv4ODYsJ/emk
         VfwVkZzQzSOWgEJ9JrLw2Yxnlbr4338lB16DkafM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Shurong <zhang_shurong@foxmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 45/61] dmaengine: ste_dma40: Fix PM disable depth imbalance in d40_probe
Date:   Mon,  6 Nov 2023 14:03:41 +0100
Message-ID: <20231106130301.158685822@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130259.573843228@linuxfoundation.org>
References: <20231106130259.573843228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Shurong <zhang_shurong@foxmail.com>

[ Upstream commit 0618c077a8c20e8c81e367988f70f7e32bb5a717 ]

The pm_runtime_enable will increase power disable depth. Thus
a pairing decrement is needed on the error handling path to
keep it balanced according to context.
We fix it by calling pm_runtime_disable when error returns.

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/tencent_DD2D371DB5925B4B602B1E1D0A5FA88F1208@qq.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/ste_dma40.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index e9d76113c9e95..d7d3bf7920ead 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3685,6 +3685,7 @@ static int __init d40_probe(struct platform_device *pdev)
 		regulator_disable(base->lcpa_regulator);
 		regulator_put(base->lcpa_regulator);
 	}
+	pm_runtime_disable(base->dev);
 
 	kfree(base->lcla_pool.alloc_map);
 	kfree(base->lookup_log_chans);
-- 
2.42.0



