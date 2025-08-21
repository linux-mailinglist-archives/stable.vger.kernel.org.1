Return-Path: <stable+bounces-172129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B1DB2FCDE
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46136189E9FC
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9042857EC;
	Thu, 21 Aug 2025 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hWG3rGef"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFCF2857E9
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786169; cv=none; b=Ot+7NrpdtJZe8TZMWcGvrcnUhJquS4DhzzgRYXNAo9+xaDuliKg+xu3B5GDYCHCMql25PbUFnH+IylB7xkw4riiOqt5ielO1oAIChpE6L84q8GY93hXcMyww5WRqNC/86BvfYAQ4YTI56fGl4969CKXjAbWCF9UE1L6wqbpOT34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786169; c=relaxed/simple;
	bh=Vp7ecHBrGHPvxP8K5SpUv0xR1EAJATczhTUvkg52edQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Lia1tgwDaJL/WrDRs9OTImzVexT7tW+WIbMUVpZ/DTTEHes8A0ykSYWhpyJBzP2vXGBX8K7yGX11fC+7g2/czjapt+6RnebhoK7Thte6q9YeQvT1uCXzsJ0J0fXbpRTr6DBvXXWURZ7D3t8eqMr9f4Dq9G9f8ySkXDA17nknsFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hWG3rGef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71140C4CEEB;
	Thu, 21 Aug 2025 14:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755786168;
	bh=Vp7ecHBrGHPvxP8K5SpUv0xR1EAJATczhTUvkg52edQ=;
	h=Subject:To:Cc:From:Date:From;
	b=hWG3rGeflz6kJVqOCcY9e6mZVpo2B/XFj8NKdy5BsZ+5arZNboNshyK+uzyBZKxR1
	 DB+CJFuA4a3qJ9jEl/XJT+dugeSq0yEEkRQ/TLDN9gDkl72Gur8oU0W06F0QA1FUrf
	 BF3q9aFxplXjwwPtddsAtM4yS4KbDrAEVkhO1Zsg=
Subject: FAILED: patch "[PATCH] PCI: imx6: Add IMX8MQ_EP third 64-bit BAR in epc_features" failed to apply to 6.12-stable tree
To: hongxing.zhu@nxp.com,Frank.Li@nxp.com,bhelgaas@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 16:22:45 +0200
Message-ID: <2025082145-scrap-ride-31b5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c523fa63ac1d452abeeb4e699560ec3365037f32
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082145-scrap-ride-31b5@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c523fa63ac1d452abeeb4e699560ec3365037f32 Mon Sep 17 00:00:00 2001
From: Richard Zhu <hongxing.zhu@nxp.com>
Date: Tue, 8 Jul 2025 17:10:02 +0800
Subject: [PATCH] PCI: imx6: Add IMX8MQ_EP third 64-bit BAR in epc_features

IMX8MQ_EP has three 64-bit BAR0/2/4 capable and programmable BARs. For
IMX8MQ_EP, use imx8q_pcie_epc_features (64-bit BARs 0, 2, 4) instead
of imx8m_pcie_epc_features (64-bit BARs 0, 2).

Fixes: 75c2f26da03f ("PCI: imx6: Add i.MX PCIe EP mode support")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
[bhelgaas: add details in subject]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250708091003.2582846-2-hongxing.zhu@nxp.com

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5a38cfaf989b..7d15bcb7c107 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1912,7 +1912,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
-		.epc_features = &imx8m_pcie_epc_features,
+		.epc_features = &imx8q_pcie_epc_features,
 		.init_phy = imx8mq_pcie_init_phy,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},


