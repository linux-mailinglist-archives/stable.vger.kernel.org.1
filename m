Return-Path: <stable+bounces-3526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FC67FF612
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D1B1C211DD
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCED10EF;
	Thu, 30 Nov 2023 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FNDFzmAd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23ED3D382;
	Thu, 30 Nov 2023 16:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF8FC433C8;
	Thu, 30 Nov 2023 16:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701362054;
	bh=nbKkw+r3tU4cOq13jqZEkEfDgsgBeoWOaq9Jh2VZ7lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FNDFzmAdPFD37XAVSss/VBBiTGVmfdrOB9tavs1dDKXZhwakVGaIs/nZe7g18GFMG
	 AE8U5vyjSjn60GbejscZ776zDgNmmV2T/Q9XRT8rdba849tOOqCSTv+pK6qMCSEOcg
	 bmCECAeKXge9ZOW3OiQHZfvivoHj2SnaDpfsje/o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan+linaro@kernel.org>,
	Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH 5.15 68/69] USB: dwc3: qcom: fix wakeup after probe deferral
Date: Thu, 30 Nov 2023 16:23:05 +0000
Message-ID: <20231130162135.306795243@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162133.035359406@linuxfoundation.org>
References: <20231130162133.035359406@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan+linaro@kernel.org>

commit 41f5a0973259db9e4e3c9963d36505f80107d1a0 upstream.

The Qualcomm glue driver is overriding the interrupt trigger types
defined by firmware when requesting the wakeup interrupts during probe.

This can lead to a failure to map the DP/DM wakeup interrupts after a
probe deferral as the firmware defined trigger types do not match the
type used for the initial mapping:

	irq: type mismatch, failed to map hwirq-14 for interrupt-controller@b220000!
	irq: type mismatch, failed to map hwirq-15 for interrupt-controller@b220000!

Fix this by not overriding the firmware provided trigger types when
requesting the wakeup interrupts.

Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
Cc: stable@vger.kernel.org      # 4.18
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Link: https://lore.kernel.org/r/20231120161607.7405-3-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/dwc3-qcom.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -492,7 +492,7 @@ static int dwc3_qcom_setup_irq(struct pl
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					IRQF_ONESHOT,
 					"qcom_dwc3 HS", qcom);
 		if (ret) {
 			dev_err(qcom->dev, "hs_phy_irq failed: %d\n", ret);
@@ -507,7 +507,7 @@ static int dwc3_qcom_setup_irq(struct pl
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					IRQF_ONESHOT,
 					"qcom_dwc3 DP_HS", qcom);
 		if (ret) {
 			dev_err(qcom->dev, "dp_hs_phy_irq failed: %d\n", ret);
@@ -522,7 +522,7 @@ static int dwc3_qcom_setup_irq(struct pl
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					IRQF_ONESHOT,
 					"qcom_dwc3 DM_HS", qcom);
 		if (ret) {
 			dev_err(qcom->dev, "dm_hs_phy_irq failed: %d\n", ret);
@@ -537,7 +537,7 @@ static int dwc3_qcom_setup_irq(struct pl
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					IRQF_ONESHOT,
 					"qcom_dwc3 SS", qcom);
 		if (ret) {
 			dev_err(qcom->dev, "ss_phy_irq failed: %d\n", ret);



