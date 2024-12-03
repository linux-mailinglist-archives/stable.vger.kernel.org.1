Return-Path: <stable+bounces-97001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB339E221B
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BBD284679
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7B31F4707;
	Tue,  3 Dec 2024 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FGl+6cww"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB08A1F472A;
	Tue,  3 Dec 2024 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239236; cv=none; b=i1sxOM5iFIFajoaSVEIsnx5ed2bIswFVJBiz9ZgTfVQ7Spa5Jk9GFkVhwdRDjbNNX63GLhqlIeXKB/xIwXVoPZyGB4HhzNp51HEG9p9kPbhN2raLaTEvGBhE+nCtVUjcj1+5TuKxFVAwkJtc0EYlDJJFi0GXOz9AsSCWbgMmmIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239236; c=relaxed/simple;
	bh=pLwoT2w4JfMAelBs7IBymBWhe05CRbeUkjLpoh+GkjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7DDr3jlykUL163Uf5YGYDRU421IBoPMh8ns+FZ/XbwWiHlaKKGmiKU/rteZhq9oTY6rPr3JPv4Ygx+CwG0fYmCSC/5uyBRovj5xuXGwdyxN3LrzLfPmnvOcznk7O0gWq3g2wxjfIqFNhWVQ1N9Hz0AaCwRMSAETs7SAYkWtYqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FGl+6cww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532DAC4CECF;
	Tue,  3 Dec 2024 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239236;
	bh=pLwoT2w4JfMAelBs7IBymBWhe05CRbeUkjLpoh+GkjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FGl+6cwwoZ5rKMljUZSVQkq7wXru2PPGqYK91O/xRTvfavnlTApGHS78lnUE7Iquv
	 EQ33jpzSrucEVfLw4TuWxE0HlYgarG3IRS1TA8jcF9dgCRpKXyJ8a32244ZBjXx4Wu
	 y5d1H0B2RrjP7xeqE+r8VEo9vQtVoEGVhQNa3GiQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 513/817] PCI: qcom-ep: Move controller cleanups to qcom_pcie_perst_deassert()
Date: Tue,  3 Dec 2024 15:41:25 +0100
Message-ID: <20241203144015.905688063@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit 7d7cf89b119af433354f865fc01017b9f8aa411a ]

Currently, the endpoint cleanup function dw_pcie_ep_cleanup() and EPF
deinit notify function pci_epc_deinit_notify() are called during the
execution of qcom_pcie_perst_assert() i.e., when the host has asserted
PERST#. But quickly after this step, refclk will also be disabled by the
host.

All of the Qcom endpoint SoCs supported as of now depend on the refclk from
the host for keeping the controller operational. Due to this limitation,
any access to the hardware registers in the absence of refclk will result
in a whole endpoint crash. Unfortunately, most of the controller cleanups
require accessing the hardware registers (like eDMA cleanup performed in
dw_pcie_ep_cleanup(), powering down MHI EPF etc...). So these cleanup
functions are currently causing the crash in the endpoint SoC once host
asserts PERST#.

One way to address this issue is by generating the refclk in the endpoint
itself and not depending on the host. But that is not always possible as
some of the endpoint designs do require the endpoint to consume refclk from
the host (as I was told by the Qcom engineers).

Thus, fix this crash by moving the controller cleanups to the start of
the qcom_pcie_perst_deassert() function. qcom_pcie_perst_deassert() is
called whenever the host has deasserted PERST# and it is guaranteed that
the refclk would be active at this point. So at the start of this function
(after enabling resources), the controller cleanup can be performed. Once
finished, rest of the code execution for PERST# deassert can continue as
usual.

Fixes: 473b2cf9c4d1 ("PCI: endpoint: Introduce 'epc_deinit' event and notify the EPF drivers")
Fixes: 570d7715eed8 ("PCI: dwc: ep: Introduce dw_pcie_ep_cleanup() API for drivers supporting PERST#")
Link: https://lore.kernel.org/r/20240817-pci-qcom-ep-cleanup-v1-1-d6b958226559@linaro.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index c8bb7cd89678f..a7f65d50d4ebb 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -395,6 +395,10 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 		return ret;
 	}
 
+	/* Perform cleanup that requires refclk */
+	pci_epc_deinit_notify(pci->ep.epc);
+	dw_pcie_ep_cleanup(&pci->ep);
+
 	/* Assert WAKE# to RC to indicate device is ready */
 	gpiod_set_value_cansleep(pcie_ep->wake, 1);
 	usleep_range(WAKE_DELAY_US, WAKE_DELAY_US + 500);
@@ -534,8 +538,6 @@ static void qcom_pcie_perst_assert(struct dw_pcie *pci)
 {
 	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
 
-	pci_epc_deinit_notify(pci->ep.epc);
-	dw_pcie_ep_cleanup(&pci->ep);
 	qcom_pcie_disable_resources(pcie_ep);
 	pcie_ep->link_status = QCOM_PCIE_EP_LINK_DISABLED;
 }
-- 
2.43.0




