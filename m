Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A787553AF
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjGPUVt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjGPUVs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:21:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A910B90
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:21:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4717C60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B41C433C7;
        Sun, 16 Jul 2023 20:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538906;
        bh=EtXBL588rAZue7eXHuBVVNlYaLjtCL31FUVUTsGisoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AQRuEHTTQSnApD32kxB++rZrRDEIFB+UTMxb64zJV3JNlY0GiZQV2JN0LiFL+gr9M
         EqlpdvTTZuaaEERVdnEGRCDDPinhHGcGLnpdmj1o/R2yDwu5o+Ch3b4NvqyPGu0ll3
         McJs+bODRyJl+BkULmtk6i50ElJye0TunqWlQHw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andrew Halaney <ahalaney@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 618/800] usb: dwc3: qcom: Release the correct resources in dwc3_qcom_remove()
Date:   Sun, 16 Jul 2023 21:47:51 +0200
Message-ID: <20230716195003.468642917@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 8fd95da2cfb5046c4bb5a3cdc9eb7963ba8b10dd ]

In the probe, some resources are allocated with
dwc3_qcom_of_register_core() or dwc3_qcom_acpi_register_core(). The
corresponding resources are already coorectly freed in the error handling
path of the probe, but not in the remove function.

Fix it.

Fixes: 2bc02355f8ba ("usb: dwc3: qcom: Add support for booting with ACPI")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Message-ID: <c0215a84cdf18fb3514c81842783ec53cf149deb.1685891059.git.christophe.jaillet@wanadoo.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 482260182d656..9c01e963ae467 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -950,11 +950,15 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 static int dwc3_qcom_remove(struct platform_device *pdev)
 {
 	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	int i;
 
 	device_remove_software_node(&qcom->dwc3->dev);
-	of_platform_depopulate(dev);
+	if (np)
+		of_platform_depopulate(&pdev->dev);
+	else
+		platform_device_put(pdev);
 
 	for (i = qcom->num_clocks - 1; i >= 0; i--) {
 		clk_disable_unprepare(qcom->clks[i]);
-- 
2.39.2



