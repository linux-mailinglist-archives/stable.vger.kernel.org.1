Return-Path: <stable+bounces-78371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D46498B8B4
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18DD91F22841
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 09:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE38D19F41D;
	Tue,  1 Oct 2024 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iBAux8jr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBE819D8B3
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727776523; cv=none; b=hRFLSXJAZExZZhcBfnUwN4RqI5umpo7A6VLEwa0CtWjjl4uTtKl+eO+5FCeQBjBCQEUsvA0sug9phkCpTd9Ai6OuuvDJqA/nTpTy7wc1VwrOXU9FVP5PjPkdKPaXo7qERPXnqhbw+E4Bx/1BsVhGlsH7BIY8bjisrTo7CLT/tww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727776523; c=relaxed/simple;
	bh=Do9f+YryGkZR0SrcuqVvu7MVm6FPIQWYRSNmNKrMqbo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=D1c/p6HtmSeDyNn1s7WtYAituHLArYrRlzMxm/Ag9j0D9OoDKA98bY9CVg6CR/AbCLvxmES/CSQuKUQEZKL+BRQPe6ILW2iAN5PBBSGWVEl4OpVeHlwqgaFruW7YhCJ/uq5rcz8ftmaKN0QSzeSFMUGAyLRDGK6H0nmHqzxq9lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iBAux8jr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAD2C4CECE;
	Tue,  1 Oct 2024 09:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727776523;
	bh=Do9f+YryGkZR0SrcuqVvu7MVm6FPIQWYRSNmNKrMqbo=;
	h=Subject:To:Cc:From:Date:From;
	b=iBAux8jrUyKeFYwqjbuAUplzMQPmdFp4x21JbdgQ/Z13LAQAIQLCcINm5fUq/Yev1
	 CTgxDFFYZYLTGR4ct57puxm9Yf4Hu57avkPjm8VMQ95I8KlskY8Uz2snZe+Is689u+
	 cZXESDmSCkWlxKPV1bxIeuMc9B29K4a0zMO9GsDg=
Subject: FAILED: patch "[PATCH] PCI: dra7xx: Fix error handling when IRQ request fails in" failed to apply to 5.4-stable tree
To: s-vadapalli@ti.com,khilman@baylibre.com,kwilczynski@kernel.org,manivannan.sadhasivam@linaro.org,u-kumar1@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 11:54:30 +0200
Message-ID: <2024100129-hankie-animator-1715@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 4d60f6d4b8fa4d7bad4aeb2b3ee5c10425bc60a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100129-hankie-animator-1715@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


