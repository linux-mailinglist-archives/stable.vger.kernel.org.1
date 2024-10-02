Return-Path: <stable+bounces-79176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027B498D6F5
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34EAA1C20E80
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790661D0DC4;
	Wed,  2 Oct 2024 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WeeymPAh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DD71D0493;
	Wed,  2 Oct 2024 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876662; cv=none; b=fytmgXP21gUcHeOW91R8p/OBQGrGGmCULG0ebsKi63d7H/kYfpP4wKdRQRIfckAK53ChOL7x6itega5HWiUCtKKRi7A/LiFj9DsGYzGDB7H9B1AXELLxrXzQelfDeUhyd1uwa6AgUV4CRtbWAsiaKUB2GEMsVL2DlcOfW9X2lz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876662; c=relaxed/simple;
	bh=/NWruCxtWydxdC5wUgWgZSpcG1SFOiLqdEX4XxEOF2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLPUvns5Ae5PTRA8ESlOPYnr1nlJ3zgeLvO0RZVvNfhZX6kH/HqnKyM4c/H87RJGtWNu8Cg5BWNYlvyNEmoztaXXiTCuoPb1rnl3xxoSjlref/5xdyMCOGNgOLd4lgi2blmk1fq6c89RsR4riu47e2vDrBOMnK6mkWRmRWiSXso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WeeymPAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DF3C4CECE;
	Wed,  2 Oct 2024 13:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727876662;
	bh=/NWruCxtWydxdC5wUgWgZSpcG1SFOiLqdEX4XxEOF2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WeeymPAhcCOusXSvBjNN6i8cWru2aurRhQlO69YEry7vIieuKVyocQCTP5kPQf9Oz
	 7Tjz0mzbLtmG3g5NchSXMGmi0IClH3RhEgtbPd9L7JnNSV/ZIWIAi6J/ZPwi+TAFka
	 pgUXNYGUDVgQZaEB0dFmeVkIA3v0BtgUw8fmFVJw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH 6.11 519/695] PCI: Use an error code with PCIe failed link retraining
Date: Wed,  2 Oct 2024 14:58:37 +0200
Message-ID: <20241002125843.203100774@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@orcam.me.uk>

commit 59100eb248c0b15585affa546c7f6834b30eb5a4 upstream.

Given how the call place in pcie_wait_for_link_delay() got structured now,
and that pcie_retrain_link() returns a potentially useful error code,
convert pcie_failed_link_retrain() to return an error code rather than a
boolean status, fixing handling at the call site mentioned.  Update the
other call site accordingly.

Fixes: 1abb47390350 ("Merge branch 'pci/enumeration'")
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2408091156530.61955@angie.orcam.me.uk
Reported-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com/
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.5+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pci.c    |    2 +-
 drivers/pci/pci.h    |    6 +++---
 drivers/pci/quirks.c |   20 ++++++++++----------
 3 files changed, 14 insertions(+), 14 deletions(-)

--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1324,7 +1324,7 @@ static int pci_dev_wait(struct pci_dev *
 		if (delay > PCI_RESET_WAIT) {
 			if (retrain) {
 				retrain = false;
-				if (pcie_failed_link_retrain(bridge)) {
+				if (pcie_failed_link_retrain(bridge) == 0) {
 					delay = 1;
 					continue;
 				}
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -606,7 +606,7 @@ void pci_acs_init(struct pci_dev *dev);
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
 int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
-bool pcie_failed_link_retrain(struct pci_dev *dev);
+int pcie_failed_link_retrain(struct pci_dev *dev);
 #else
 static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
 					       u16 acs_flags)
@@ -621,9 +621,9 @@ static inline int pci_dev_specific_disab
 {
 	return -ENOTTY;
 }
-static inline bool pcie_failed_link_retrain(struct pci_dev *dev)
+static inline int pcie_failed_link_retrain(struct pci_dev *dev)
 {
-	return false;
+	return -ENOTTY;
 }
 #endif
 
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -78,21 +78,21 @@
  * again to remove any residual state, ignoring the result as it's supposed
  * to fail anyway.
  *
- * Return TRUE if the link has been successfully retrained.  Return FALSE
+ * Return 0 if the link has been successfully retrained.  Return an error
  * if retraining was not needed or we attempted a retrain and it failed.
  */
-bool pcie_failed_link_retrain(struct pci_dev *dev)
+int pcie_failed_link_retrain(struct pci_dev *dev)
 {
 	static const struct pci_device_id ids[] = {
 		{ PCI_VDEVICE(ASMEDIA, 0x2824) }, /* ASMedia ASM2824 */
 		{}
 	};
 	u16 lnksta, lnkctl2;
-	bool ret = false;
+	int ret = -ENOTTY;
 
 	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
 	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
-		return false;
+		return ret;
 
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
@@ -106,13 +106,13 @@ bool pcie_failed_link_retrain(struct pci
 		lnkctl2 |= PCI_EXP_LNKCTL2_TLS_2_5GT;
 		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
 
-		ret = pcie_retrain_link(dev, false) == 0;
-		if (!ret) {
+		ret = pcie_retrain_link(dev, false);
+		if (ret) {
 			pci_info(dev, "retraining failed\n");
 			pcie_capability_write_word(dev, PCI_EXP_LNKCTL2,
 						   oldlnkctl2);
 			pcie_retrain_link(dev, true);
-			return false;
+			return ret;
 		}
 
 		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
@@ -129,10 +129,10 @@ bool pcie_failed_link_retrain(struct pci
 		lnkctl2 |= lnkcap & PCI_EXP_LNKCAP_SLS;
 		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
 
-		ret = pcie_retrain_link(dev, false) == 0;
-		if (!ret) {
+		ret = pcie_retrain_link(dev, false);
+		if (ret) {
 			pci_info(dev, "retraining failed\n");
-			return false;
+			return ret;
 		}
 	}
 



