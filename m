Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBF07204A0
	for <lists+stable@lfdr.de>; Fri,  2 Jun 2023 16:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbjFBOjb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 2 Jun 2023 10:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbjFBOj3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Jun 2023 10:39:29 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAEC1BD;
        Fri,  2 Jun 2023 07:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685716767; x=1717252767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fg1OmSdDSXyTznxFIFbqh97jb21+zgWkwkHKMj3mhK8=;
  b=kJvlcj2dED33zPeJ0nLS94LgXNma7f+8wjD4DntWBpjHnJaGeSUGZRF8
   EBGhHDfc0yKC3ogrIxmfVwh6QAAmIXQlr6RVPVXX1xQIKVSX2VxcP91SJ
   PfYoTV4zgZ8kBUbnCm930aM8bh6qOGibZCFwTDT/gkPKBG71waxR6Ki9q
   mP7NDj2P126v6qo0QE4c3WYvPb5dIFzhLI855WtwHeeqm1d3yNYDV2U+X
   q/vbOWrX2FufiCylmMVyq2OlwwwoC6Xk2Wbl5Czplc/sLByp/hdemfwNT
   aPfwwusgHylmp9DcT92FTrvIVGEnrb+RAhpP2Yv6bbe4jhcFbWPE5qMsC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="358311317"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="358311317"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 07:39:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="707877466"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="707877466"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by orsmga002.jf.intel.com with ESMTP; 02 Jun 2023 07:39:08 -0700
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
To:     <gregkh@linuxfoundation.org>
Cc:     <linux-usb@vger.kernel.org>,
        Weitao Wang <WeitaoWang-oc@zhaoxin.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH 10/11] xhci: Show ZHAOXIN xHCI root hub speed correctly
Date:   Fri,  2 Jun 2023 17:40:08 +0300
Message-Id: <20230602144009.1225632-11-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602144009.1225632-1-mathias.nyman@linux.intel.com>
References: <20230602144009.1225632-1-mathias.nyman@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Weitao Wang <WeitaoWang-oc@zhaoxin.com>

Some ZHAOXIN xHCI controllers follow usb3.1 spec, but only support
gen1 speed 5Gbps. While in Linux kernel, if xHCI suspport usb3.1,
root hub speed will show on 10Gbps.
To fix this issue of ZHAOXIN xHCI platforms, read usb speed ID
supported by xHCI to determine root hub speed. And add a quirk
XHCI_ZHAOXIN_HOST for this issue.

[fix warning about uninitialized symbol -Mathias]

Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-mem.c | 31 ++++++++++++++++++++++++-------
 drivers/usb/host/xhci-pci.c |  2 ++
 drivers/usb/host/xhci.h     |  1 +
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index c4170421bc9c..19a402123de0 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1961,7 +1961,7 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 {
 	u32 temp, port_offset, port_count;
 	int i;
-	u8 major_revision, minor_revision;
+	u8 major_revision, minor_revision, tmp_minor_revision;
 	struct xhci_hub *rhub;
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	struct xhci_port_cap *port_cap;
@@ -1981,6 +1981,15 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 		 */
 		if (minor_revision > 0x00 && minor_revision < 0x10)
 			minor_revision <<= 4;
+		/*
+		 * Some zhaoxin's xHCI controller that follow usb3.1 spec
+		 * but only support Gen1.
+		 */
+		if (xhci->quirks & XHCI_ZHAOXIN_HOST) {
+			tmp_minor_revision = minor_revision;
+			minor_revision = 0;
+		}
+
 	} else if (major_revision <= 0x02) {
 		rhub = &xhci->usb2_rhub;
 	} else {
@@ -1989,10 +1998,6 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 		/* Ignoring port protocol we can't understand. FIXME */
 		return;
 	}
-	rhub->maj_rev = XHCI_EXT_PORT_MAJOR(temp);
-
-	if (rhub->min_rev < minor_revision)
-		rhub->min_rev = minor_revision;
 
 	/* Port offset and count in the third dword, see section 7.2 */
 	temp = readl(addr + 2);
@@ -2010,8 +2015,6 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 	if (xhci->num_port_caps > max_caps)
 		return;
 
-	port_cap->maj_rev = major_revision;
-	port_cap->min_rev = minor_revision;
 	port_cap->psi_count = XHCI_EXT_PORT_PSIC(temp);
 
 	if (port_cap->psi_count) {
@@ -2032,6 +2035,11 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 				  XHCI_EXT_PORT_PSIV(port_cap->psi[i - 1])))
 				port_cap->psi_uid_count++;
 
+			if (xhci->quirks & XHCI_ZHAOXIN_HOST &&
+			    major_revision == 0x03 &&
+			    XHCI_EXT_PORT_PSIV(port_cap->psi[i]) >= 5)
+				minor_revision = tmp_minor_revision;
+
 			xhci_dbg(xhci, "PSIV:%d PSIE:%d PLT:%d PFD:%d LP:%d PSIM:%d\n",
 				  XHCI_EXT_PORT_PSIV(port_cap->psi[i]),
 				  XHCI_EXT_PORT_PSIE(port_cap->psi[i]),
@@ -2041,6 +2049,15 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 				  XHCI_EXT_PORT_PSIM(port_cap->psi[i]));
 		}
 	}
+
+	rhub->maj_rev = major_revision;
+
+	if (rhub->min_rev < minor_revision)
+		rhub->min_rev = minor_revision;
+
+	port_cap->maj_rev = major_revision;
+	port_cap->min_rev = minor_revision;
+
 	/* cache usb2 port capabilities */
 	if (major_revision < 0x03 && xhci->num_ext_caps < max_caps)
 		xhci->ext_caps[xhci->num_ext_caps++] = temp;
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 3aad946bab68..88c16d91fb69 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -522,6 +522,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_NO_SOFT_RETRY;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ZHAOXIN) {
+		xhci->quirks |= XHCI_ZHAOXIN_HOST;
+
 		if (pdev->device == 0x9202) {
 			xhci->quirks |= XHCI_RESET_ON_RESUME;
 			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 5a495126c8ba..7e282b4522c0 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1905,6 +1905,7 @@ struct xhci_hcd {
 #define XHCI_SUSPEND_RESUME_CLKS	BIT_ULL(43)
 #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
 #define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
+#define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.25.1

