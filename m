Return-Path: <stable+bounces-78373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CD398B8B5
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1BE1F2288B
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 09:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06BD19F42A;
	Tue,  1 Oct 2024 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BxWDcxCA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F05D19D8B3
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727776529; cv=none; b=QQPq3DKinzuZe31VtU6RdylxmDV/SiZQAqCvBj8DeEaE1NDonZpiEuqXqUQqkldHoVysGDTn3oy9f85sYnCGzYCMUEahKABIfcPx/6YE7sRwghSP3/kRW8VvyY/KUO+/8fB5h35cqGDk9mNZpowGQ/0/s9agsYsGlY1OwRT+hYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727776529; c=relaxed/simple;
	bh=9X6sddDghrRPZsfr2G/QZPrZlEC3idnpYauWOhP13Mw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iJynmTO0MLuBsx9fm1MyjBfN658nPPUnf4z2gLRAoS5AKt/T9Is4eS8pYs3d5dBZi0f3yGbTGneDToCmXmmv+w0wX8v/9CNgiiiR26jbTTqZ+Xwo6GL0VZTd8exXXX7UKFfs86eVXFA1azBhGJodVLR1UJ6W8jNKvonqtv0KpG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BxWDcxCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6203C4CEC6;
	Tue,  1 Oct 2024 09:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727776529;
	bh=9X6sddDghrRPZsfr2G/QZPrZlEC3idnpYauWOhP13Mw=;
	h=Subject:To:Cc:From:Date:From;
	b=BxWDcxCAimHSEumqE3PT5XR0GMhv4o4CJov+w+LshGcPoPwy4rzw9P3xDLMIQVRp4
	 oVyIQXGAgeVILhCeBEPHqU34AyulO1VoCDAldG5sJg46jaEJ1+dKarHTEaJBcvwSMr
	 NGHfZSLinjk3fNtmzxjApSM6PUtm0GXn5wzQnt0Q=
Subject: FAILED: patch "[PATCH] PCI: dra7xx: Fix error handling when IRQ request fails in" failed to apply to 5.10-stable tree
To: s-vadapalli@ti.com,khilman@baylibre.com,kwilczynski@kernel.org,manivannan.sadhasivam@linaro.org,u-kumar1@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 11:54:31 +0200
Message-ID: <2024100130-headlamp-copper-3088@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4d60f6d4b8fa4d7bad4aeb2b3ee5c10425bc60a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100130-headlamp-copper-3088@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

4d60f6d4b8fa ("PCI: dra7xx: Fix error handling when IRQ request fails in probe")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4d60f6d4b8fa4d7bad4aeb2b3ee5c10425bc60a4 Mon Sep 17 00:00:00 2001
From: Siddharth Vadapalli <s-vadapalli@ti.com>
Date: Tue, 27 Aug 2024 17:54:22 +0530
Subject: [PATCH] PCI: dra7xx: Fix error handling when IRQ request fails in
 probe
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit d4c7d1a089d6 ("PCI: dwc: dra7xx: Push request_irq()
call to the bottom of probe") moved the IRQ request for
"dra7xx-pcie-main" towards the end of dra7xx_pcie_probe().

However, the error handling does not take into account the
initialization performed by either dra7xx_add_pcie_port() or
dra7xx_add_pcie_ep(), depending on the mode of operation.

Fix the error handling to address this.

Fixes: d4c7d1a089d6 ("PCI: dwc: dra7xx: Push request_irq() call to the bottom of probe")
Link: https://lore.kernel.org/linux-pci/20240827122422.985547-3-s-vadapalli@ti.com
Tested-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: stable@vger.kernel.org

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 20fb50741f3d..5c62e1a3ba52 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -854,11 +854,17 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 					"dra7xx-pcie-main", dra7xx);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
-		goto err_gpio;
+		goto err_deinit;
 	}
 
 	return 0;
 
+err_deinit:
+	if (dra7xx->mode == DW_PCIE_RC_TYPE)
+		dw_pcie_host_deinit(&dra7xx->pci->pp);
+	else
+		dw_pcie_ep_deinit(&dra7xx->pci->ep);
+
 err_gpio:
 err_get_sync:
 	pm_runtime_put(dev);


