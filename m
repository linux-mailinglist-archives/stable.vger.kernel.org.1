Return-Path: <stable+bounces-1838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561927F819B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFC02B21A96
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1024935F1A;
	Fri, 24 Nov 2023 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cZL9ih8a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515AC34189;
	Fri, 24 Nov 2023 18:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC29C433CA;
	Fri, 24 Nov 2023 18:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852397;
	bh=tPsVFIh9aX0qH4NkjfVFXNEpVQnPvvAbHvYiXHXuonw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cZL9ih8aH77DjPlhApihMWCj8GoYOokptIjgwwOXmo2w3HjXzDL9b4ch29+HPtYfv
	 M+jM/32ODKOI9qrtjGhkuqQT8Okaa6Z+ddzIAvNZYhe3yYTAAVzmgpW5/wbk2OfQhm
	 4HKcduOVF+UiuIv7fSnRcWnT2W9v04s/cRSrFSUk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kai-Heng Feng <kai.heng.geng@canonical.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.1 340/372] mmc: sdhci-pci-gli: GL9750: Mask the replay timer timeout of AER
Date: Fri, 24 Nov 2023 17:52:07 +0000
Message-ID: <20231124172021.715607530@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Victor Shih <victor.shih@genesyslogic.com.tw>

commit 015c9cbcf0ad709079117d27c2094a46e0eadcdb upstream.

Due to a flaw in the hardware design, the GL9750 replay timer frequently
times out when ASPM is enabled. As a result, the warning messages will
often appear in the system log when the system accesses the GL9750
PCI config. Therefore, the replay timer timeout must be masked.

Fixes: d7133797e9e1 ("mmc: sdhci-pci-gli: A workaround to allow GL9750 to enter ASPM L1.2")
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Kai-Heng Feng <kai.heng.geng@canonical.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231107095741.8832-2-victorshihgli@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-pci-gli.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -27,6 +27,9 @@
 #define PCI_GLI_9750_PM_CTRL	0xFC
 #define   PCI_GLI_9750_PM_STATE	  GENMASK(1, 0)
 
+#define PCI_GLI_9750_CORRERR_MASK				0x214
+#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT	  BIT(12)
+
 #define SDHCI_GLI_9750_CFG2          0x848
 #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
 #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
@@ -494,6 +497,11 @@ static void gl9750_hw_setting(struct sdh
 	value &= ~PCI_GLI_9750_PM_STATE;
 	pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
 
+	/* mask the replay timer timeout of AER */
+	pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, &value);
+	value |= PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
+	pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, value);
+
 	gl9750_wt_off(host);
 }
 



