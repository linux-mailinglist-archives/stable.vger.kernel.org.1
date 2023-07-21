Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A10D75D3F1
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjGUTQJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjGUTQI (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:16:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921491BF4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:16:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15ECF61D76
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DB8C433C7;
        Fri, 21 Jul 2023 19:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966966;
        bh=iG8v+Hhcwd6x516GQymi6SmvXrwlUJ0bCxNgK79PWE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hhvCc8L3DMcBtBkhnn/8jnkgyXOCRvUdddx19+IA2xcNsUhivQQkBizq24i+Iv2U1
         oTtSLup22y7GeIq94kBKnLoD3X88rPpFL+a6vCCtJwQyJn069yWAYp5k3jSBR+fV6J
         0ediYdlB/DuNSc/WVXJuqCqzlH5qkZuDcbrnYd3U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Subject: [PATCH 5.15 503/532] xhci: Show ZHAOXIN xHCI root hub speed correctly
Date:   Fri, 21 Jul 2023 18:06:47 +0200
Message-ID: <20230721160641.889669958@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Weitao Wang <WeitaoWang-oc@zhaoxin.com>

commit d9b0328d0b8b8298dfdc97cd8e0e2371d4bcc97b upstream.

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
Message-ID: <20230602144009.1225632-11-mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-mem.c |   31 ++++++++++++++++++++++++-------
 drivers/usb/host/xhci-pci.c |    2 ++
 drivers/usb/host/xhci.h     |    1 +
 3 files changed, 27 insertions(+), 7 deletions(-)

--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2128,7 +2128,7 @@ static void xhci_add_in_port(struct xhci
 {
 	u32 temp, port_offset, port_count;
 	int i;
-	u8 major_revision, minor_revision;
+	u8 major_revision, minor_revision, tmp_minor_revision;
 	struct xhci_hub *rhub;
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	struct xhci_port_cap *port_cap;
@@ -2148,6 +2148,15 @@ static void xhci_add_in_port(struct xhci
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
@@ -2157,10 +2166,6 @@ static void xhci_add_in_port(struct xhci
 		/* Ignoring port protocol we can't understand. FIXME */
 		return;
 	}
-	rhub->maj_rev = XHCI_EXT_PORT_MAJOR(temp);
-
-	if (rhub->min_rev < minor_revision)
-		rhub->min_rev = minor_revision;
 
 	/* Port offset and count in the third dword, see section 7.2 */
 	temp = readl(addr + 2);
@@ -2179,8 +2184,6 @@ static void xhci_add_in_port(struct xhci
 	if (xhci->num_port_caps > max_caps)
 		return;
 
-	port_cap->maj_rev = major_revision;
-	port_cap->min_rev = minor_revision;
 	port_cap->psi_count = XHCI_EXT_PORT_PSIC(temp);
 
 	if (port_cap->psi_count) {
@@ -2201,6 +2204,11 @@ static void xhci_add_in_port(struct xhci
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
@@ -2210,6 +2218,15 @@ static void xhci_add_in_port(struct xhci
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
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -337,6 +337,8 @@ static void xhci_pci_quirks(struct devic
 		xhci->quirks |= XHCI_NO_SOFT_RETRY;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ZHAOXIN) {
+		xhci->quirks |= XHCI_ZHAOXIN_HOST;
+
 		if (pdev->device == 0x9202) {
 			xhci->quirks |= XHCI_RESET_ON_RESUME;
 			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1907,6 +1907,7 @@ struct xhci_hcd {
 #define XHCI_SUSPEND_RESUME_CLKS	BIT_ULL(43)
 #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
 #define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
+#define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;


