Return-Path: <stable+bounces-4379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D8980473D
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E03B0B20BF0
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E4C8BF8;
	Tue,  5 Dec 2023 03:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="innbZnoU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F62F6FB1;
	Tue,  5 Dec 2023 03:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC6DC433C7;
	Tue,  5 Dec 2023 03:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747386;
	bh=oNTOOcszilmRKOvHejysuifF1MTcbdx7+L2uvUGLi5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=innbZnoUzIOyVgh4ym60IA0QpSpNTOU2lL4g42GHk0bJTOCEwGaSHRiOgs49W5Ta8
	 oTmgkSm4MllscDfxh8jaX3g9ebDQHUoOiPzrgBuGgQ/r276DAvlBCiL2x6TeFdeRk6
	 X009ApXchFKU51lXMNuufF1BDED3TfXLIIeqcBFw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Lee Jones <lee@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 033/135] USB: dwc3: qcom: fix resource leaks on probe deferral
Date: Tue,  5 Dec 2023 12:15:54 +0900
Message-ID: <20231205031532.758830120@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031530.557782248@linuxfoundation.org>
References: <20231205031530.557782248@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit 51392a1879ff06dc21b68aef4825f6ef68a7be42 ]

The driver needs to deregister and free the newly allocated dwc3 core
platform device on ACPI probe errors (e.g. probe deferral) and on driver
unbind but instead it leaked those resources while erroneously dropping
a reference to the parent platform device which is still in use.

For OF probing the driver takes a reference to the dwc3 core platform
device which has also always been leaked.

Fix the broken ACPI tear down and make sure to drop the dwc3 core
reference for both OF and ACPI.

Fixes: 8fd95da2cfb5 ("usb: dwc3: qcom: Release the correct resources in dwc3_qcom_remove()")
Fixes: 2bc02355f8ba ("usb: dwc3: qcom: Add support for booting with ACPI")
Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
Cc: stable@vger.kernel.org      # 4.18
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Lee Jones <lee@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Acked-by: Andrew Halaney <ahalaney@redhat.com>
Link: https://lore.kernel.org/r/20231117173650.21161-2-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 9cf87666fc6e ("USB: dwc3: qcom: fix ACPI platform device leak")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 3973f6c18857e..0d11d282c0a2e 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -690,6 +690,7 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
 	if (!qcom->dwc3) {
 		ret = -ENODEV;
 		dev_err(dev, "failed to get dwc3 platform device\n");
+		of_platform_depopulate(dev);
 	}
 
 node_put:
@@ -832,7 +833,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 
 	if (ret) {
 		dev_err(dev, "failed to register DWC3 Core, err=%d\n", ret);
-		goto depopulate;
+		goto clk_disable;
 	}
 
 	ret = dwc3_qcom_interconnect_init(qcom);
@@ -864,7 +865,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	if (np)
 		of_platform_depopulate(&pdev->dev);
 	else
-		platform_device_put(pdev);
+		platform_device_del(qcom->dwc3);
+	platform_device_put(qcom->dwc3);
 clk_disable:
 	for (i = qcom->num_clocks - 1; i >= 0; i--) {
 		clk_disable_unprepare(qcom->clks[i]);
@@ -886,7 +888,8 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
 	if (np)
 		of_platform_depopulate(&pdev->dev);
 	else
-		platform_device_put(pdev);
+		platform_device_del(qcom->dwc3);
+	platform_device_put(qcom->dwc3);
 
 	for (i = qcom->num_clocks - 1; i >= 0; i--) {
 		clk_disable_unprepare(qcom->clks[i]);
-- 
2.42.0




