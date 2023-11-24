Return-Path: <stable+bounces-1469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BBA7F7FD5
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1019B1C2151F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334E939FC2;
	Fri, 24 Nov 2023 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tabg6/IH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7180381A2;
	Fri, 24 Nov 2023 18:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760E9C433C7;
	Fri, 24 Nov 2023 18:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851476;
	bh=na/ovnYjpo7dLGhavaHWxbo86Is6MsP/ed0yHvmrKDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tabg6/IHNvqxFxTtiNnpYSqnLUhmKkzrQBUNGh0aWeerrAM/W8N1RVNEKb24YE79l
	 J5gPtuwwVhUtfkCJGMAJJ2UhyRrRURYCatGm/hKt4jPtQARg0Oc1XlpJ4SPzrTOb8Y
	 tj1jGl5RV+TYBLWXeNMSt7xFNlY3UTtwL82j36KE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.5 439/491] mmc: sdhci-pci-gli: A workaround to allow GL9750 to enter ASPM L1.2
Date: Fri, 24 Nov 2023 17:51:15 +0000
Message-ID: <20231124172037.800210909@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Victor Shih <victor.shih@genesyslogic.com.tw>

commit d7133797e9e1b72fd89237f68cb36d745599ed86 upstream.

When GL9750 enters ASPM L1 sub-states, it will stay at L1.1 and will not
enter L1.2. The workaround is to toggle PM state to allow GL9750 to enter
ASPM L1.2.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Link: https://lore.kernel.org/r/20230912091710.7797-1-victorshihgli@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-pci-gli.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -25,6 +25,9 @@
 #define   GLI_9750_WT_EN_ON	    0x1
 #define   GLI_9750_WT_EN_OFF	    0x0
 
+#define PCI_GLI_9750_PM_CTRL	0xFC
+#define   PCI_GLI_9750_PM_STATE	  GENMASK(1, 0)
+
 #define SDHCI_GLI_9750_CFG2          0x848
 #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
 #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
@@ -539,8 +542,12 @@ static void sdhci_gl9750_set_clock(struc
 
 static void gl9750_hw_setting(struct sdhci_host *host)
 {
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev;
 	u32 value;
 
+	pdev = slot->chip->pdev;
+
 	gl9750_wt_on(host);
 
 	value = sdhci_readl(host, SDHCI_GLI_9750_CFG2);
@@ -550,6 +557,13 @@ static void gl9750_hw_setting(struct sdh
 			    GLI_9750_CFG2_L1DLY_VALUE);
 	sdhci_writel(host, value, SDHCI_GLI_9750_CFG2);
 
+	/* toggle PM state to allow GL9750 to enter ASPM L1.2 */
+	pci_read_config_dword(pdev, PCI_GLI_9750_PM_CTRL, &value);
+	value |= PCI_GLI_9750_PM_STATE;
+	pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
+	value &= ~PCI_GLI_9750_PM_STATE;
+	pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
+
 	gl9750_wt_off(host);
 }
 



