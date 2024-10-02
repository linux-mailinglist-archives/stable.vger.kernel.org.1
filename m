Return-Path: <stable+bounces-80394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3146798DD37
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E399A284D80
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA341D1E63;
	Wed,  2 Oct 2024 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wvlNH+ao"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD401EA80;
	Wed,  2 Oct 2024 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880246; cv=none; b=DfkWBqlpRj5/N68IuGg5vPwp0mWEvF/DqYAQOE76gF3O3XHIgI4w2MRycJQEadF12TnyRSGmnxKVvofTOo0FWgWrLnVFP9oX2Hl56dX4Z9mAYqxlaqHvXL4nEhXm8mG/Io/Iq32GzdlL7dTvko00A/WCkGAqmK1z/KhMuuJgKzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880246; c=relaxed/simple;
	bh=CmGwud/iFV3kHSX/x6LAwynnrC6YJjlQ/UZ75rYSYpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdZJzny4+hwz9WavRdP5reyHttmO9j2pEGfQCedmUYzeex0jMXymFBS/fC7oitmD0IkzS9q1+gwh2cFcytxz55OZR/71972ceFnoAe11XehqsEDrjqcj3x/KyUnVRC8TdpU1N4zSYfWef7v5Il7fNcbSMk2mMpSoB/VtjqCyTaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wvlNH+ao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C5AC4CEC2;
	Wed,  2 Oct 2024 14:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727880246;
	bh=CmGwud/iFV3kHSX/x6LAwynnrC6YJjlQ/UZ75rYSYpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wvlNH+aoJu7twMWJY09+A5tSW/chmgxshc1b52TO8Iq3YtFJlMggkidlDltLX+nmX
	 RpDhsx/LzKU0d2b+3wjZNSyTltH0A5PUt29MZODyo2EPr0j/7XH99AKw5R9V4GCWVV
	 yYNbE3N1Cq6DN7V8dfUG1RBJ+STtht6sSncTxzrc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew W Carlis <mattc@purestorage.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.6 393/538] PCI: Revert to the original speed after PCIe failed link retraining
Date: Wed,  2 Oct 2024 15:00:32 +0200
Message-ID: <20241002125807.945614774@linuxfoundation.org>
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

commit f68dea13405c94381d08f42dbf0416261622bdad upstream.

When `pcie_failed_link_retrain' has failed to retrain the link by hand
it leaves the link speed restricted to 2.5GT/s, which will then affect
any device that has been plugged in later on, which may not suffer from
the problem that caused the speed restriction to have been attempted.
Consequently such a downstream device will suffer from an unnecessary
communication throughput limitation and therefore performance loss.

Remove the speed restriction then and revert the Link Control 2 register
to its original state if link retraining with the speed restriction in
place has failed.  Retrain the link again afterwards so as to remove any
residual state, waiting on LT rather than DLLLA to avoid an excessive
delay and ignoring the result as this training is supposed to fail
anyway.

Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
Link: https://lore.kernel.org/linux-pci/alpine.DEB.2.21.2408251412590.30766@angie.orcam.me.uk
Reported-by: Matthew W Carlis <mattc@purestorage.com>
Link: https://lore.kernel.org/r/20240806000659.30859-1-mattc@purestorage.com/
Link: https://lore.kernel.org/r/20240722193407.23255-1-mattc@purestorage.com/
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.5+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/quirks.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a2ce4e08edf5..ee86793109ff 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -66,7 +66,7 @@
  * apply this erratum workaround to any downstream ports as long as they
  * support Link Active reporting and have the Link Control 2 register.
  * Restrict the speed to 2.5GT/s then with the Target Link Speed field,
- * request a retrain and wait 200ms for the data link to go up.
+ * request a retrain and check the result.
  *
  * If this turns out successful and we know by the Vendor:Device ID it is
  * safe to do so, then lift the restriction, letting the devices negotiate
@@ -74,6 +74,10 @@
  * firmware may have already arranged and lift it with ports that already
  * report their data link being up.
  *
+ * Otherwise revert the speed to the original setting and request a retrain
+ * again to remove any residual state, ignoring the result as it's supposed
+ * to fail anyway.
+ *
  * Return TRUE if the link has been successfully retrained, otherwise FALSE.
  */
 bool pcie_failed_link_retrain(struct pci_dev *dev)
@@ -92,6 +96,8 @@ bool pcie_failed_link_retrain(struct pci_dev *dev)
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 	if ((lnksta & (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_DLLLA)) ==
 	    PCI_EXP_LNKSTA_LBMS) {
+		u16 oldlnkctl2 = lnkctl2;
+
 		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
 
 		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
@@ -100,6 +106,9 @@ bool pcie_failed_link_retrain(struct pci_dev *dev)
 
 		if (pcie_retrain_link(dev, false)) {
 			pci_info(dev, "retraining failed\n");
+			pcie_capability_write_word(dev, PCI_EXP_LNKCTL2,
+						   oldlnkctl2);
+			pcie_retrain_link(dev, true);
 			return false;
 		}
 
-- 
2.46.2




