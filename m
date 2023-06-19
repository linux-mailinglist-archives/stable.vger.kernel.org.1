Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC7773529D
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjFSKgp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjFSKgX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:36:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6EAE58
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:36:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E00AC60B86
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05838C433AB;
        Mon, 19 Jun 2023 10:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170980;
        bh=pmNeNoP+3h+S6rfjAykYcgi0HCeznCuN8SzMCzWD/rE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2nZNbFpf6GcLN0OMYb3K2/KIzd4EfBh0+lS2zIWn4gIBfoW3fxAEhhOxvM3tymAap
         jLDKkIoPGmBEKOpTMtGJAG6ZRN2H6xBD8zhYWoGAGYwQP69vxZdgCUOaUwNjw2AveZ
         7eZnjED8ci5CWaEhy4DpMBqTCcbdud1VpSuJsrb0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 6.3 105/187] USB: dwc3: qcom: fix NULL-deref on suspend
Date:   Mon, 19 Jun 2023 12:28:43 +0200
Message-ID: <20230619102202.648279219@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Johan Hovold <johan+linaro@kernel.org>

commit d2d69354226de0b333d4405981f3d9c41ba8430a upstream.

The Qualcomm dwc3 glue driver is currently accessing the driver data of
the child core device during suspend and on wakeup interrupts. This is
clearly a bad idea as the child may not have probed yet or could have
been unbound from its driver.

The first such layering violation was part of the initial version of the
driver, but this was later made worse when the hack that accesses the
driver data of the grand child xhci device to configure the wakeup
interrupts was added.

Fixing this properly is not that easily done, so add a sanity check to
make sure that the child driver data is non-NULL before dereferencing it
for now.

Note that this relies on subtleties like the fact that driver core is
making sure that the parent is not suspended while the child is probing.

Reported-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/all/20230325165217.31069-4-manivannan.sadhasivam@linaro.org/
Fixes: d9152161b4bf ("usb: dwc3: Add Qualcomm DWC3 glue layer driver")
Fixes: 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")
Cc: stable@vger.kernel.org	# 3.18: a872ab303d5d: "usb: dwc3: qcom: fix use-after-free on runtime-PM wakeup"
Cc: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc: Krishna Kurapati <quic_kriskura@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Message-ID: <20230607100540.31045-2-johan+linaro@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/dwc3-qcom.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -308,7 +308,16 @@ static void dwc3_qcom_interconnect_exit(
 /* Only usable in contexts where the role can not change. */
 static bool dwc3_qcom_is_host(struct dwc3_qcom *qcom)
 {
-	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
+	struct dwc3 *dwc;
+
+	/*
+	 * FIXME: Fix this layering violation.
+	 */
+	dwc = platform_get_drvdata(qcom->dwc3);
+
+	/* Core driver may not have probed yet. */
+	if (!dwc)
+		return false;
 
 	return dwc->xhci;
 }


