Return-Path: <stable+bounces-84523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C50999D096
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD791C23680
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7851AAE27;
	Mon, 14 Oct 2024 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xuhYK9rB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078BA481B7;
	Mon, 14 Oct 2024 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918302; cv=none; b=CIXhCspjqg1XhEoW0sFbCUq7g5yuhOeNn/ad/h5XFEyoezv5i6P/vKlfegIYElIoQklcL8hGKwCTkL1YSVuFc4UFuWNlCZTn8GezV8eTtU7nuRz2C7GrHOQ5wUzOs8I1OtOqEKuVCCdSGq82bNzwv0RFKMeoUYtwy7oaqsZogxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918302; c=relaxed/simple;
	bh=QB+Fh4XyrvjmlmajZu11nKrr7S2921eUNnS1rLzo3wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m5CtTlv/4gcUHHKuc8nw3uxABG36uxWHTRMAtsICHN+An7UhDcweZXod6l2Duo4z39zc9L6hxA6POJArVEiTLROVLyjpJd6zWNf9ilqve+qCVfPtXVNmdIMSxyOzfNuVXqbJQHw/4EH1ExGHpCs1a4PwRDHB6COOLZN5f8mI0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xuhYK9rB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30160C4CEC3;
	Mon, 14 Oct 2024 15:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918301;
	bh=QB+Fh4XyrvjmlmajZu11nKrr7S2921eUNnS1rLzo3wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xuhYK9rB2fOw4hwKPWy8qDLFDdclbxC/Ai0mCIvrR3c8K3IX1MEViK1PmNmljvmOI
	 MdHVw3JNSr8SXJScqMHwPxih9WJOwAecTBOMKpwmqMWPCvfrwaeJM0Qf4hbUkQOAJ2
	 0c3azLRi+fo7be06xLDCJ6gNIdAbOUAaBurmjsMg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6.1 282/798] PCI: imx6: Fix missing call to phy_power_off() in error handling
Date: Mon, 14 Oct 2024 16:13:56 +0200
Message-ID: <20241014141229.025085482@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frank Li <Frank.Li@nxp.com>

commit 5b04d44d5c74e4d8aab1678496b84700b4b343fe upstream.

Fix missing call to phy_power_off() in the error path of
imx6_pcie_host_init(). Remove unnecessary check for imx6_pcie->phy
as the PHY API already handles NULL pointers.

Fixes: cbcf8722b523 ("phy: freescale: imx8m-pcie: Fix the wrong order of phy_init() and phy_power_on()")
Link: https://lore.kernel.org/linux-pci/20240729-pci2_upstream-v8-3-b68ee5ef2b4d@nxp.com
Signed-off-by: Frank Li <Frank.Li@nxp.com>
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: <stable@vger.kernel.org> # 6.1+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/dwc/pci-imx6.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -956,7 +956,7 @@ static int imx6_pcie_host_init(struct dw
 		ret = phy_power_on(imx6_pcie->phy);
 		if (ret) {
 			dev_err(dev, "waiting for PHY ready timeout!\n");
-			goto err_phy_off;
+			goto err_phy_exit;
 		}
 	}
 
@@ -971,8 +971,9 @@ static int imx6_pcie_host_init(struct dw
 	return 0;
 
 err_phy_off:
-	if (imx6_pcie->phy)
-		phy_exit(imx6_pcie->phy);
+	phy_power_off(imx6_pcie->phy);
+err_phy_exit:
+	phy_exit(imx6_pcie->phy);
 err_clk_disable:
 	imx6_pcie_clk_disable(imx6_pcie);
 err_reg_disable:



