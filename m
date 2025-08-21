Return-Path: <stable+bounces-172093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96A7B2FAA0
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09818AA5AC0
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA5A334392;
	Thu, 21 Aug 2025 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YLS0+Hss"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD252DD5F6
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782938; cv=none; b=IYIZjB/MOJ/5gcYXpHuvwNz0AoWFFKlUhOH6nwzPXAg+g7wBJG1BGHh2qdgR+7BxoCFYhHnLcygM49M/nN/uV0HToo8EkpC7106M95tza50ECRNXTaVxHFmC2f9sunVYEWc+IdBl610W4Lmm+T1bUKqHQs+jpkDC2HwveAU+zHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782938; c=relaxed/simple;
	bh=RcpIvOyiYSumkMiIRFYQX4YnXDwgDP7i04n06GFh4dc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Rw3MKeQOkH+ydFP54a6378eMaYZghu+AARmBg4BmX5PoB0EZphZcM3oj88YDRs+RMxvgZMSl08GvDVA0m29PYMEatAR+nZpX6rsuphX1gzuu8ZWzwym6eY8UJDYBcHNxE1+XNhIwWWeymWfyrn3u456UDuqDlVur5Vys2OGZFok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YLS0+Hss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5156BC113CF;
	Thu, 21 Aug 2025 13:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755782937;
	bh=RcpIvOyiYSumkMiIRFYQX4YnXDwgDP7i04n06GFh4dc=;
	h=Subject:To:Cc:From:Date:From;
	b=YLS0+HssA5g4jFYUo84OOvj/HAd8Mfc/yPiGshtvmZcYQsf7mQxLFs43s+xEoyFqF
	 63NinR9hBxF+SntLpj4nzgmljKUmqDZm2hJwK3L31zfq9XjPX2D8CjaxkgqcQjburT
	 9df1FIJSuTv6G8tt3PFYYR4fPf52j+vufhlGFhwM=
Subject: FAILED: patch "[PATCH] PCI: imx6: Add IMX8MQ_EP third 64-bit BAR in epc_features" failed to apply to 6.6-stable tree
To: hongxing.zhu@nxp.com,Frank.Li@nxp.com,bhelgaas@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:28:41 +0200
Message-ID: <2025082141-nape-sinless-0ceb@gregkh>
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
git cherry-pick -x c523fa63ac1d452abeeb4e699560ec3365037f32
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082141-nape-sinless-0ceb@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


