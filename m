Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395E7755695
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjGPUwE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjGPUwA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:52:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A2BE6A
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:51:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1F3160DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C391BC433C7;
        Sun, 16 Jul 2023 20:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540714;
        bh=idIg/BBJfsxnWNgLXXxjhl0qTe+yXQAeXnMDUsDeXJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APepyZKPrwQeE3eIsDOaT1a1T+jfR/dleVuDAXrAZDT3sukdiAt5cTVJ5sE2UB8Nq
         74FRoLrZL/HvAvhuWJMy0mmipMVFflhqYZ4yc4qelM9w8lNATNfZCWoDlsVC+iGYlf
         zn4P+gnJxFuRIzPTdGB3QA8WQqKdVca+1OUeGUFE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 435/591] usb: dwc3-meson-g12a: Fix an error handling path in dwc3_meson_g12a_probe()
Date:   Sun, 16 Jul 2023 21:49:34 +0200
Message-ID: <20230716194935.167163595@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 01052b91c9808e3c3b068ae2721cb728ec9aa4c0 ]

If dwc3_meson_g12a_otg_init() fails, resources allocated by the previous
of_platform_populate() call should be released, as already done in the
error handling path.

Fixes: 1e355f21d3fb ("usb: dwc3: Add Amlogic A1 DWC3 glue")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Message-ID: <9d28466de1808ccc756b4cc25fc72c482d133d13.1686403934.git.christophe.jaillet@wanadoo.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index b282ad0e69c6d..eaea944ebd2ce 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -805,7 +805,7 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 
 	ret = dwc3_meson_g12a_otg_init(pdev, priv);
 	if (ret)
-		goto err_phys_power;
+		goto err_plat_depopulate;
 
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
@@ -813,6 +813,9 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_plat_depopulate:
+	of_platform_depopulate(dev);
+
 err_phys_power:
 	for (i = 0 ; i < PHY_COUNT ; ++i)
 		phy_power_off(priv->phys[i]);
-- 
2.39.2



