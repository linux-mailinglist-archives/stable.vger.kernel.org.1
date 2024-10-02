Return-Path: <stable+bounces-79255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B1798D755
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817361F24A84
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DB31D0156;
	Wed,  2 Oct 2024 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iILKiMQe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546752BAF9;
	Wed,  2 Oct 2024 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876904; cv=none; b=cVvedu6TfWhQSxJmc+rftrqTL9obg7tILcy8Radm3kGUISv/QC92E94FB0G+Wd6sSkoNX4uvzv25ufbGeSiEDvzccwA9AuWBly4C9wTa0UBuO9KAmQpGk22TamMh78OpuNMzlQLZDUrQDI1G3K7Q5f2obfBWBnfM2SgSSVrDlmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876904; c=relaxed/simple;
	bh=DTVQOW/ZlMjMyYwK9bzOOypPtfRgIaLzbE3baiLMdKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sh7QUyn8JOM/hIOi8BNZxzkItGhYs0QCLUh9jMtgU6swNAPUCBqGdq08QKstwN1e6vVa7b/AM+8hc7UOoBEZlzZXgUOLK/lgSI0jfKEx5D518FkvaMfX0iZj60Sn/nJSeuKCz5RZBnl0YOHwFhbohLZuaa1axF634d0eiVaoO78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iILKiMQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1360C4CEC2;
	Wed,  2 Oct 2024 13:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727876904;
	bh=DTVQOW/ZlMjMyYwK9bzOOypPtfRgIaLzbE3baiLMdKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iILKiMQe5A2sW9Rg0GC3H7LvZRvels8q6ojOvXr887HqvzhGfd2fS3f2zWPKdLC3+
	 kCPMjRG4wQ9b2o2FmrNHlMc21OzwBno4F8gkfL6XxLeu1faz1Uk8kYRYShgelQxCTY
	 PIKcGxY/IbSab/U+h5xfPg2Qici5R84dAGLf1XPQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fabio Porcedda <fabio.porcedda@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6.11 592/695] bus: mhi: host: pci_generic: Fix the name for the Telit FE990A
Date: Wed,  2 Oct 2024 14:59:50 +0200
Message-ID: <20241002125846.141155059@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Porcedda <fabio.porcedda@gmail.com>

commit bfc5ca0fd1ea7aceae0b682fa4bd8079c52f96c8 upstream.

Add a mhi_pci_dev_info struct specific for the Telit FE990A modem in
order to use the correct product name.

Cc: stable@vger.kernel.org # 6.1+
Fixes: 0724869ede9c ("bus: mhi: host: pci_generic: add support for Telit FE990 modem")
Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20240820080439.837666-1-fabio.porcedda@gmail.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bus/mhi/host/pci_generic.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -677,6 +677,15 @@ static const struct mhi_pci_dev_info mhi
 	.mru_default = 32768,
 };
 
+static const struct mhi_pci_dev_info mhi_telit_fe990a_info = {
+	.name = "telit-fe990a",
+	.config = &modem_telit_fn990_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.sideband_wake = false,
+	.mru_default = 32768,
+};
+
 /* Keep the list sorted based on the PID. New VID should be added as the last entry */
 static const struct pci_device_id mhi_pci_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0304),
@@ -694,9 +703,9 @@ static const struct pci_device_id mhi_pc
 	/* Telit FN990 */
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0308, 0x1c5d, 0x2010),
 		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
-	/* Telit FE990 */
+	/* Telit FE990A */
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0308, 0x1c5d, 0x2015),
-		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
+		.driver_data = (kernel_ulong_t) &mhi_telit_fe990a_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
 		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0309),



