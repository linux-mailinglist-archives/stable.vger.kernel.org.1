Return-Path: <stable+bounces-78370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F4B98B8B3
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C616F1C216CA
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 09:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E750D19F426;
	Tue,  1 Oct 2024 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JYeZ1hQ8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E5519D8B3
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727776520; cv=none; b=sdFrYjUwh4LLXC2KW0fbgkRMs7Dsk3IfROn7Mf/7Aav/mDn/+C79+lVnOuasmvk6U7mIY/CCuNmyibgJQ0jullyibuHCzjo+vLZYCfmfFHrFnpokLxMGGZGrfaCEKXmb012P4zJNORdqdrIAuLLqGv8HQKvObxUBoBpEGJq+A2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727776520; c=relaxed/simple;
	bh=wPmDHh4y8bScXxcQxWxtlECZJEEuQnkd0lMtn1WatGw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FZ3w7BnznGtlfoY+P2wiPz185lD44hthr03eEPeWXro3Bj+ufWXpX3sgU0bHZSOJWR8Q6LEoRqOlNYR1+f+qSMTEZCFp1u5z7fHWc12jyftcWFfBWrk/lOHXzeDlMQdjNCkwrCckwP+OoZycuIjOvt8rQfzuIFs+k8WhNTV3cgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JYeZ1hQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30812C4CEC6;
	Tue,  1 Oct 2024 09:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727776520;
	bh=wPmDHh4y8bScXxcQxWxtlECZJEEuQnkd0lMtn1WatGw=;
	h=Subject:To:Cc:From:Date:From;
	b=JYeZ1hQ8cnlacjJi/O6cfQRr9WbgLNlOls0I7u8mowrzt7s3X+O8nBsJkXgLRVg+P
	 KRqH8QucTSA3oEs41+k6l6jmhIEAucOG5qAVsIHnTF6Lfq33lHlgUta7J9XDz9xSJm
	 3kJ2fEbz2g26EWOjKJpSwMrNE/Jjnlu5a6Oc3/Uc=
Subject: FAILED: patch "[PATCH] PCI: dra7xx: Fix error handling when IRQ request fails in" failed to apply to 4.19-stable tree
To: s-vadapalli@ti.com,khilman@baylibre.com,kwilczynski@kernel.org,manivannan.sadhasivam@linaro.org,u-kumar1@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 11:54:29 +0200
Message-ID: <2024100128-conceded-stowaway-a8a3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 4d60f6d4b8fa4d7bad4aeb2b3ee5c10425bc60a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100128-conceded-stowaway-a8a3@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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


