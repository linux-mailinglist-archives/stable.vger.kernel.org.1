Return-Path: <stable+bounces-80406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3AB98DD43
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781261F2304D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B7A1D1E85;
	Wed,  2 Oct 2024 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uGYpd+nM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F6819752C;
	Wed,  2 Oct 2024 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880281; cv=none; b=iXvAq9ZrNLwMTdJCQ1Vu7XkCCGaTpXf0l14DG0S/Sfln+pjW34NBvUh7IslgZn4e9VGdr8TRxWsYQOwtuAzFB1o65NqcOMOa7xROMFBByY3x8YA8x5OkTCvL1/jc4OBB/YHyeKxZ51xiMkchffRuR6p4ptxGnPcNgAcKhWTeQjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880281; c=relaxed/simple;
	bh=YipQxIsvPs5Ie6sRIuON1WjnApoiRgSasgWMLh9Mj60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cygiIgDxO1kxO8IGznUbm3tbR68zOJIRRM0L0apYSW8cFmHIjVOkmngglyybhJ8wpctMc9HEcVNvgIevDhDIhJ6vODopV5JaU6uyhR/I4Vy6Ja2cPjleLL5I/gOcgzxZEYa+0TURja/l8tB2hBwrcUg0OECzEO4mRH200iP2GMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uGYpd+nM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01430C4CEC2;
	Wed,  2 Oct 2024 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727880281;
	bh=YipQxIsvPs5Ie6sRIuON1WjnApoiRgSasgWMLh9Mj60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGYpd+nMK+v2Wb+HtDs7YPg1R9inypSYkQ1X0brt4WFQfCx7kU8yKU9DKzfHOtPn7
	 cLhKNm9j+XodQrdoOM9D3Yi/ZHvwPU2Sb+dzQvDihm0Hi6yT8kLD7W4ldHSg37ix47
	 x26QMShsRk8ZB1fBT5L40NH5mcRYnS+mpbtGWhcc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH 6.6 398/538] PCI: Use an error code with PCIe failed link retraining
Date: Wed,  2 Oct 2024 15:00:37 +0200
Message-ID: <20241002125808.147340219@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1208,7 +1208,7 @@ static int pci_dev_wait(struct pci_dev *
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
@@ -530,7 +530,7 @@ void pci_acs_init(struct pci_dev *dev);
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
 int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
-bool pcie_failed_link_retrain(struct pci_dev *dev);
+int pcie_failed_link_retrain(struct pci_dev *dev);
 #else
 static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
 					       u16 acs_flags)
@@ -545,9 +545,9 @@ static inline int pci_dev_specific_disab
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
 



