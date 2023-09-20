Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F857A7DE9
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbjITMN1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbjITMN0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:13:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779E3CA
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:13:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FB4C433CA;
        Wed, 20 Sep 2023 12:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211998;
        bh=ZtSUoNHEXV7Q0vL4v1GnBfXN5R9Cso9jyuMUrd7+gLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O0j5WGV7bOdgO9kAskyxTj/2Vzr8UPCLyKGXw0Hd/Bt1vfzUZKrIXos+41v3Y5HeG
         /h/vanT4aE2/vr+XQ0SMFWOSc5/zLyQCZNkAmSXd0k9Q9I0u2yJX5nC7Vs/aOhmFj3
         06cdAu+6v+dDk7ON3+l3Wma5PeHRPi3UnUo0le1U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 113/273] PCI: Decode PCIe 32 GT/s link speed
Date:   Wed, 20 Sep 2023 13:29:13 +0200
Message-ID: <20230920112849.979984405@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>

[ Upstream commit de76cda215d56256ffcda7ffa538b70f9fb301a7 ]

PCIe r5.0, sec 7.5.3.18, defines a new 32.0 GT/s bit in the Supported Link
Speeds Vector of Link Capabilities 2.  Decode this new speed.  This does
not affect the speed of the link, which should be negotiated automatically
by the hardware; it only adds decoding when showing the speed to the user.

Previously, reading the speed of a link operating at this speed showed
"Unknown speed" instead of "32.0 GT/s".

Link: https://lore.kernel.org/lkml/92365e3caf0fc559f9ab14bcd053bfc92d4f661c.1559664969.git.gustavo.pimentel@synopsys.com
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
[bhelgaas: changelog]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Stable-dep-of: ce7d88110b9e ("drm/amdgpu: Use RMW accessors for changing LNKCTL")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci-sysfs.c       | 3 +++
 drivers/pci/pci.c             | 4 +++-
 drivers/pci/probe.c           | 2 +-
 drivers/pci/slot.c            | 1 +
 include/linux/pci.h           | 1 +
 include/uapi/linux/pci_regs.h | 4 ++++
 6 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 34a7b3c137bb0..7d3fb70568e3d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -182,6 +182,9 @@ static ssize_t current_link_speed_show(struct device *dev,
 		return -EINVAL;
 
 	switch (linkstat & PCI_EXP_LNKSTA_CLS) {
+	case PCI_EXP_LNKSTA_CLS_32_0GB:
+		speed = "32 GT/s";
+		break;
 	case PCI_EXP_LNKSTA_CLS_16_0GB:
 		speed = "16 GT/s";
 		break;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c8326c7b468fa..2ac400adaee11 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5575,7 +5575,9 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
 	 */
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
 	if (lnkcap2) { /* PCIe r3.0-compliant */
-		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_16_0GB)
+		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_32_0GB)
+			return PCIE_SPEED_32_0GT;
+		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_16_0GB)
 			return PCIE_SPEED_16_0GT;
 		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
 			return PCIE_SPEED_8_0GT;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 113b7bdf86dd9..5a609848452f2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -667,7 +667,7 @@ const unsigned char pcie_link_speed[] = {
 	PCIE_SPEED_5_0GT,		/* 2 */
 	PCIE_SPEED_8_0GT,		/* 3 */
 	PCIE_SPEED_16_0GT,		/* 4 */
-	PCI_SPEED_UNKNOWN,		/* 5 */
+	PCIE_SPEED_32_0GT,		/* 5 */
 	PCI_SPEED_UNKNOWN,		/* 6 */
 	PCI_SPEED_UNKNOWN,		/* 7 */
 	PCI_SPEED_UNKNOWN,		/* 8 */
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index dfbe9cbf292c0..d575583e49c2c 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -75,6 +75,7 @@ static const char *pci_bus_speed_strings[] = {
 	"5.0 GT/s PCIe",	/* 0x15 */
 	"8.0 GT/s PCIe",	/* 0x16 */
 	"16.0 GT/s PCIe",	/* 0x17 */
+	"32.0 GT/s PCIe",	/* 0x18 */
 };
 
 static ssize_t bus_speed_read(enum pci_bus_speed speed, char *buf)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1d1b0bfd51968..2636990e0cccf 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -260,6 +260,7 @@ enum pci_bus_speed {
 	PCIE_SPEED_5_0GT		= 0x15,
 	PCIE_SPEED_8_0GT		= 0x16,
 	PCIE_SPEED_16_0GT		= 0x17,
+	PCIE_SPEED_32_0GT		= 0x18,
 	PCI_SPEED_UNKNOWN		= 0xff,
 };
 
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 9fd0cb2f9d12d..c47dbeeb02318 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -527,6 +527,7 @@
 #define  PCI_EXP_LNKCAP_SLS_5_0GB 0x00000002 /* LNKCAP2 SLS Vector bit 1 */
 #define  PCI_EXP_LNKCAP_SLS_8_0GB 0x00000003 /* LNKCAP2 SLS Vector bit 2 */
 #define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vector bit 3 */
+#define  PCI_EXP_LNKCAP_SLS_32_0GB 0x00000005 /* LNKCAP2 SLS Vector bit 4 */
 #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
 #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
 #define  PCI_EXP_LNKCAP_L0SEL	0x00007000 /* L0s Exit Latency */
@@ -555,6 +556,7 @@
 #define  PCI_EXP_LNKSTA_CLS_5_0GB 0x0002 /* Current Link Speed 5.0GT/s */
 #define  PCI_EXP_LNKSTA_CLS_8_0GB 0x0003 /* Current Link Speed 8.0GT/s */
 #define  PCI_EXP_LNKSTA_CLS_16_0GB 0x0004 /* Current Link Speed 16.0GT/s */
+#define  PCI_EXP_LNKSTA_CLS_32_0GB 0x0005 /* Current Link Speed 32.0GT/s */
 #define  PCI_EXP_LNKSTA_NLW	0x03f0	/* Negotiated Link Width */
 #define  PCI_EXP_LNKSTA_NLW_X1	0x0010	/* Current Link Width x1 */
 #define  PCI_EXP_LNKSTA_NLW_X2	0x0020	/* Current Link Width x2 */
@@ -660,6 +662,7 @@
 #define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000004 /* Supported Speed 5GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000008 /* Supported Speed 8GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_16_0GB	0x00000010 /* Supported Speed 16GT/s */
+#define  PCI_EXP_LNKCAP2_SLS_32_0GB	0x00000020 /* Supported Speed 32GT/s */
 #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
 #define PCI_EXP_LNKCTL2		48	/* Link Control 2 */
 #define  PCI_EXP_LNKCTL2_TLS		0x000f
@@ -667,6 +670,7 @@
 #define  PCI_EXP_LNKCTL2_TLS_5_0GT	0x0002 /* Supported Speed 5GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
+#define  PCI_EXP_LNKCTL2_TLS_32_0GT	0x0005 /* Supported Speed 32GT/s */
 #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
 #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
-- 
2.40.1



