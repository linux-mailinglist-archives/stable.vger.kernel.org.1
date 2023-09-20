Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460BB7A7FB6
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbjITMaJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235883AbjITM3l (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:29:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CC48F
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:29:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286A1C433C8;
        Wed, 20 Sep 2023 12:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212975;
        bh=zuwApQyc8Q6rvgKzkp3911pshkSJaW3XqPoJzBwWVlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LH7mGvn+GBiNfwYnJ1X3/Dm/v4eHdxKccd0SP9Hjdxluv1dGI0KzNfD9T4NBi4B2e
         561ryfML1ar4aFlxkGd8UbaOVh5k3d9hqUfnCWJeuXyhLOJa5erydxh/AuUGi0QEC1
         E2m967omhYEoaliUm9Cq46tuTa+WX7E0ZvpyNWoc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yangtao Li <frank.li@vivo.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 114/367] drm/tegra: dpaux: Fix incorrect return value of platform_get_irq
Date:   Wed, 20 Sep 2023 13:28:11 +0200
Message-ID: <20230920112901.566544880@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yangtao Li <frank.li@vivo.com>

[ Upstream commit 2a1ca44b654346cadfc538c4fb32eecd8daf3140 ]

When platform_get_irq fails, we should return dpaux->irq
instead of -ENXIO.

Fixes: 6b6b604215c6 ("drm/tegra: Add eDP support")
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230710032355.72914-13-frank.li@vivo.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/dpaux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
index 304434bf10814..a84d19087d094 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -448,7 +448,7 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 
 	dpaux->irq = platform_get_irq(pdev, 0);
 	if (dpaux->irq < 0)
-		return -ENXIO;
+		return dpaux->irq;
 
 	if (!pdev->dev.pm_domain) {
 		dpaux->rst = devm_reset_control_get(&pdev->dev, "dpaux");
-- 
2.40.1



