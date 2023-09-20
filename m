Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0A17A7DF9
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbjITMOJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbjITMOI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:14:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4316412D
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:13:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E9DC433CA;
        Wed, 20 Sep 2023 12:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212036;
        bh=anxcBiLWjIZmSTq11QkjBl0wM39cUk70UkvpJ5m75kU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GO9WPFkMZ1OE6FznVokikt7Z8PdyKRmtxjfBsJpf5IebAY8x7z5nXYegPujzzCr3L
         qzjyyzog73TVE30ik33JffHndyC/63/hxoeySe+Z71+4vZUox2Yr5MUggOdD+6gtr6
         SN36DIJSPpFRgFhzyLh745GUF5UH+/hXnOqy31HI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tan Zhongjun <tanzhongjun@yulong.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 097/273] drm/tegra: Remove superfluous error messages around platform_get_irq()
Date:   Wed, 20 Sep 2023 13:28:57 +0200
Message-ID: <20230920112849.439892305@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tan Zhongjun <tanzhongjun@yulong.com>

[ Upstream commit d12919bb5da571ec50588ef97683d37e36dc2de5 ]

The platform_get_irq() prints error message telling that interrupt is
missing,hence there is no need to duplicated that message in the
drivers.

Signed-off-by: Tan Zhongjun <tanzhongjun@yulong.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Stable-dep-of: 2a1ca44b6543 ("drm/tegra: dpaux: Fix incorrect return value of platform_get_irq")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/dpaux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
index d84e81ff36ad0..bed9efe36a1eb 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -449,10 +449,8 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 		return PTR_ERR(dpaux->regs);
 
 	dpaux->irq = platform_get_irq(pdev, 0);
-	if (dpaux->irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ\n");
+	if (dpaux->irq < 0)
 		return -ENXIO;
-	}
 
 	if (!pdev->dev.pm_domain) {
 		dpaux->rst = devm_reset_control_get(&pdev->dev, "dpaux");
-- 
2.40.1



