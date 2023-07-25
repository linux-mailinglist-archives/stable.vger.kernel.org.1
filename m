Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CAA7614B4
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbjGYLWG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbjGYLWF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:22:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C900010D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:22:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56E22615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6941DC433C8;
        Tue, 25 Jul 2023 11:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284123;
        bh=hkEQ1fYeYcyMeuTEAHg1vLx8rA0l+0ilrBb2qZuOpsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y7/ZGLCrT9pPyBhv8tFLzcBPq/h2vIk+5Z6rCRPdZdRZlLzEoIfjzRPAobPnR3b5S
         nffAFleiHOrvWXsI/wYzvYnwHQXfjf1vMRQy0CcyzScG0YAxuzJjh7Vaxw65sHMBmK
         2VkckQGF9AimK2NwF2GhppmGwN1D/C4REaku6tWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andrew Halaney <ahalaney@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 243/509] usb: dwc3: qcom: Release the correct resources in dwc3_qcom_remove()
Date:   Tue, 25 Jul 2023 12:43:02 +0200
Message-ID: <20230725104604.879939026@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/usb/dwc3/dwc3-qcom.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -869,10 +869,14 @@ reset_assert:
 static int dwc3_qcom_remove(struct platform_device *pdev)
 {
 	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	int i;
 
-	of_platform_depopulate(dev);
+	if (np)
+		of_platform_depopulate(&pdev->dev);
+	else
+		platform_device_put(pdev);
 
 	for (i = qcom->num_clocks - 1; i >= 0; i--) {
 		clk_disable_unprepare(qcom->clks[i]);


