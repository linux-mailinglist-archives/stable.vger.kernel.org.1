Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A220775A08
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjHILEt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjHILEt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:04:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15FE1724
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:04:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71CBC63148
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C977C433C8;
        Wed,  9 Aug 2023 11:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579087;
        bh=iV95kiA3TY0v/qrBkxh0jUGBJi4iuMIb2KY7W44qQcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2hr7o7yvlsOu4KEFoNEDLNzu2+t1wBlHVOc3mqKJKeKti/RGlt9AZnnkRBx23tdF5
         Y2ilvI3Oc9XVBrt4y7TFpIjxmX+7IJ/amnkzEAVncVg+q/vntwAjLAsHo2Pgtp6sFA
         H8wFgCYSTXY6zbiDZP2WSqqzO2vd4Vn4crpnmaFU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jonas Gorski <jonas.gorski@gmail.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 070/204] spi: bcm-qspi: return error if neither hif_mspi nor mspi is available
Date:   Wed,  9 Aug 2023 12:40:08 +0200
Message-ID: <20230809103644.980474949@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jonas Gorski <jonas.gorski@gmail.com>

[ Upstream commit 7c1f23ad34fcdace50275a6aa1e1969b41c6233f ]

If neither a "hif_mspi" nor "mspi" resource is present, the driver will
just early exit in probe but still return success. Apart from not doing
anything meaningful, this would then also lead to a null pointer access
on removal, as platform_get_drvdata() would return NULL, which it would
then try to dereference when trying to unregister the spi master.

Fix this by unconditionally calling devm_ioremap_resource(), as it can
handle a NULL res and will then return a viable ERR_PTR() if we get one.

The "return 0;" was previously a "goto qspi_resource_err;" where then
ret was returned, but since ret was still initialized to 0 at this place
this was a valid conversion in 63c5395bb7a9 ("spi: bcm-qspi: Fix
use-after-free on unbind"). The issue was not introduced by this commit,
only made more obvious.

Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Reviewed-by: Kamal Dasu <kamal.dasu@broadcom.com>
Link: https://lore.kernel.org/r/20230629134306.95823-1-jonas.gorski@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-bcm-qspi.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 0321ac531df7f..cebc06759eeea 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1251,13 +1251,9 @@ int bcm_qspi_probe(struct platform_device *pdev,
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						   "mspi");
 
-	if (res) {
-		qspi->base[MSPI]  = devm_ioremap_resource(dev, res);
-		if (IS_ERR(qspi->base[MSPI]))
-			return PTR_ERR(qspi->base[MSPI]);
-	} else {
-		return 0;
-	}
+	qspi->base[MSPI]  = devm_ioremap_resource(dev, res);
+	if (IS_ERR(qspi->base[MSPI]))
+		return PTR_ERR(qspi->base[MSPI]);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "bspi");
 	if (res) {
-- 
2.39.2



