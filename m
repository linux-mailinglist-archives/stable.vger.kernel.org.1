Return-Path: <stable+bounces-176915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1288B3F151
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 01:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF4C203664
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 23:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEF1286891;
	Mon,  1 Sep 2025 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tcicKCDY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Rjmmo2pJ"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CB832F76C
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 23:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756768887; cv=none; b=M9Kz8nEwO9asHFkpyESKDIhp6M3854908ReC8MfMeBXM2tViYgPnASjYKK4suH2hqcpLdzBXSfL70SmbLVzx7kRLQLye09EE9263zwFYt9iPPc02V2JpfAhlafFZW7ai3l5OLeIo+uNWEiJz3ACc9WMrBvw7WNW/t1xcaBTWSLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756768887; c=relaxed/simple;
	bh=FFlJXfdXcFQix/AqMvGLRkodpK1dXIjrF+G6eURK3g4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h3csZqohkZm47OizBFz5zsKbutWotUeK3RASUojAMJelHlXDjvyTRMIpwKaW/xeIXtm43YYweDpjcZEvMEKBla+SiqDQ8/H7uv/4UMyBaEcPvFMsur12LsTk1hwZEjzlwMIcWAfqhCLbIY5fz2G+EnmVNUVOP3ekYQy/V0gMiA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tcicKCDY; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Rjmmo2pJ; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cG4cz5rQRz9sm6;
	Tue,  2 Sep 2025 01:21:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756768883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WE+0x2BzLTMyHvVG++xQOQXzu1LsGH1QM5RqsMPA1uw=;
	b=tcicKCDY9372L17oh6YQ2Q0KhiPSxr8UZtOB+Wwqg3/TciOUHYm2UFu7Oak2+tz0OiAZ8R
	z0Ky3xABrQCPUfuF0twlwrZdUMu0NqSc585QnmYsOzOXvb7zR1BRaSocoqAISTydjUVrv0
	ta7Icbl/DK7k4SDBBK7svNmnmm1Vi1JEj0EeeA4dWZw2FSJ/Y+EaG9FcVE5Eha31vc4nAU
	aj1PL+19Fr0QWuT7UWR9MTU419jEri/6E7orfooTttLkTVBCnEftYi2e8Kdl+UMfJ9pULj
	H1gk5r/dCJYES17aewJUt2zL1CbdiFxx/+2z9HAxh99S9p+lJm+mMskAKYSfgw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Rjmmo2pJ;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756768881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WE+0x2BzLTMyHvVG++xQOQXzu1LsGH1QM5RqsMPA1uw=;
	b=Rjmmo2pJWwo8a0HOkquSwuTJB0cZ1r7Q2oubUfLddUu7JaG9GpmzyBZEKhUgIq9apjuAii
	V+y2Gl3AQmvWvEggpfnCgLY1/94qVs+tYOEAzrhgYPG4DwUMGGWAScl3MmHvzrPUZwZCSe
	pnYEiOL5Lpi0sKgkVkQigJNCzE34HePUGhaaoJMYfVfRlYg1TOYDlxasm2b222HqSL4lwm
	nNJVRpm7cPWH+XdzWB5eyMDQ7fqyxxeMzRlb4Pr4o7v1Z+596pU58lWN6WWUY1VnlDumYN
	SZgk4pgne195WXJchHtoA3qWwo1/+zcYDfDgUgrd4euZowJ9TKzmgpthRyHbZA==
To: stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 1/2] PCI: Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to PCIE_RESET_CONFIG_WAIT_MS
Date: Tue,  2 Sep 2025 01:20:09 +0200
Message-ID: <20250901232051.232813-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7e99d0fd6a4e2781343
X-MBO-RS-META: p6f3q59a3rs6p6ed16x49831o7m5ijhn
X-Rspamd-Queue-Id: 4cG4cz5rQRz9sm6

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit 817f989700fddefa56e5e443e7d138018ca6709d ]

Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to PCIE_RESET_CONFIG_WAIT_MS.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: <stable@vger.kernel.org> # 6.12.x
---
V2: Add own SoB line
---
 drivers/pci/controller/plda/pcie-starfive.c | 2 +-
 drivers/pci/pci.h                           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index 0564fdce47c2a..0a0b5a7d84d7e 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -368,7 +368,7 @@ static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
 	 * of 100ms following exit from a conventional reset before
 	 * sending a configuration request to the device.
 	 */
-	msleep(PCIE_RESET_CONFIG_DEVICE_WAIT_MS);
+	msleep(PCIE_RESET_CONFIG_WAIT_MS);
 
 	if (starfive_pcie_host_wait_for_link(pcie))
 		dev_info(dev, "port link down\n");
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b65868e709517..c951f861a69b2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -57,7 +57,7 @@
  *    completes before sending a Configuration Request to the device
  *    immediately below that Port."
  */
-#define PCIE_RESET_CONFIG_DEVICE_WAIT_MS	100
+#define PCIE_RESET_CONFIG_WAIT_MS	100
 
 /* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
 #define PCIE_MSG_TYPE_R_RC	0
-- 
2.50.1


