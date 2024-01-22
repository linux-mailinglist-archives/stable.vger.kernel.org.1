Return-Path: <stable+bounces-12790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9A3837397
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 21:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414171C273D3
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB952405EC;
	Mon, 22 Jan 2024 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yfNG5bAP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CABC3DB86
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705954542; cv=none; b=jQlOT7LY2K/3A7WfuN2sZNiHbvKxl+SGEAIihIBS8u7DnoTEsUq06yal9SRWGHhoWBE4vqmoe/cwzj3cIPo7hERjja3kY7zSodYuBybtaKVyZgHdiWY9KE01UEd9MjTng/pX9hLE068r5FOqU8hBAmTemJrQDjqpTiCNiwXU44c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705954542; c=relaxed/simple;
	bh=Jz30tTp1oa/1r07va0eSNZu31xZ9q54ZHwDtkzyYbgE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AqMv7WTafxghiRf4CBUfZsXQTnllPRx//Z19fl8aw+7EfcQa1d0rwcy/ATNLdU04s1SKTEJPslhv06PvKDTh1WCc4JQsINauXKaMCmO3gjBtDVVL1Ch12XXdFTlcpLAuE/LxqWygynXswQbQ6GrNNj+IR1iC72sM5Z0NPC6OMrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yfNG5bAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC63EC43390;
	Mon, 22 Jan 2024 20:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705954542;
	bh=Jz30tTp1oa/1r07va0eSNZu31xZ9q54ZHwDtkzyYbgE=;
	h=Subject:To:Cc:From:Date:From;
	b=yfNG5bAPez6xAU1J7FkQFVITBClCo+gOPFHoXQ0N/sk8/7EoffDWB1CkCLWisZ03b
	 fhdfiMk/4MgK2YaJY349HW5jfrJpZVQ/lamQvAjQk+QPuyI65yCIPo2D36+PS4pHxU
	 pvW/sZ+yWPk2izlfdAXYkWgmWFs+FqXLH7OIg5W0=
Subject: FAILED: patch "[PATCH] ARM: dts: qcom: sdx55: Fix the base address of PCIe PHY" failed to apply to 6.6-stable tree
To: manivannan.sadhasivam@linaro.org,andersson@kernel.org,dmitry.baryshkov@linaro.org,konrad.dybcio@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 12:15:39 -0800
Message-ID: <2024012239-monstrous-fridge-7c31@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x cc6fc55c7ae04ab19b3972f78d3a8b1be32bf533
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012239-monstrous-fridge-7c31@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

cc6fc55c7ae0 ("ARM: dts: qcom: sdx55: Fix the base address of PCIe PHY")
bb56cff4ac03 ("ARM: dts: qcom-sdx55: switch PCIe QMP PHY to new style of bindings")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cc6fc55c7ae04ab19b3972f78d3a8b1be32bf533 Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 11 Dec 2023 22:54:11 +0530
Subject: [PATCH] ARM: dts: qcom: sdx55: Fix the base address of PCIe PHY

While convering the binding to new format, serdes address specified in the
old binding was used as the base address. This causes a boot hang as the
driver tries to access memory region outside of the specified address. Fix
it!

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: stable@vger.kernel.org # 6.6
Fixes: bb56cff4ac03 ("ARM: dts: qcom-sdx55: switch PCIe QMP PHY to new style of bindings")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20231211172411.141289-1-manivannan.sadhasivam@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index e233233c74ce..2045fc779f88 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -431,9 +431,9 @@ pcie_ep: pcie-ep@1c00000 {
 			status = "disabled";
 		};
 
-		pcie_phy: phy@1c07000 {
+		pcie_phy: phy@1c06000 {
 			compatible = "qcom,sdx55-qmp-pcie-phy";
-			reg = <0x01c07000 0x2000>;
+			reg = <0x01c06000 0x2000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;


