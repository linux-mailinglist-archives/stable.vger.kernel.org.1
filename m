Return-Path: <stable+bounces-12787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B77BC837394
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 21:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672FD28F605
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E13405EC;
	Mon, 22 Jan 2024 20:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rxem9kdA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D571D3DB86
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 20:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705954525; cv=none; b=kGG42Gex4zgw5l0MRIyFPLsERE0Skf7UyK6T7BxEAneaWQD/LDhqKcsxRTddJK9XBrSI9ufG/FRRuiAcMNzYHNapuQZDm2ELbe9J7kE+CALmaRWspJKq4FZy29fE9KDqAv5UOcxD4ZWiJr6479o7PTsOEOz4QxyrHosicmozc3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705954525; c=relaxed/simple;
	bh=hvvxrVcWfcoId/fQjGk1CMed63GvtN38X2frMXfiWWE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NgfGnCkBOcZ3Gyp5ZoyEqcD4t7J9lOQ/rIv2WIyWbpTX5difiUy94ScHUlE1LE0Mp1inY2WuDEyaaxarns0/MtgEFbSurH0VduKS1Iv67puzMhEvp7cvTjprBDFdKtA390Rp+lqad6E5fAoVCKtG/gm+BrojY4CrI7AkGoRbSSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rxem9kdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882A0C433F1;
	Mon, 22 Jan 2024 20:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705954525;
	bh=hvvxrVcWfcoId/fQjGk1CMed63GvtN38X2frMXfiWWE=;
	h=Subject:To:Cc:From:Date:From;
	b=rxem9kdACOdpNVdwbVtwR4xn07tAPKUAjHbrHLOhYMAeBf9TsVA11/ZMd0OQSBIWN
	 BFGzUhrs94HAN0CmboTPQHXl/fvli+Fx/Or9X1Gsx3AkrpbMTa38GDIj7hArSC9rXr
	 PuRHjucthsHPBhfb0wa24VV8ElyKUi3v8pTLO8rk=
Subject: FAILED: patch "[PATCH] PCI: mediatek: Clear interrupt status before dispatching" failed to apply to 5.10-stable tree
To: qizhong.cheng@mediatek.com,angelogioacchino.delregno@collabora.com,bhelgaas@google.com,jianjun.wang@mediatek.com,kwilczynski@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 12:15:23 -0800
Message-ID: <2024012223-divisive-scrubbed-87ba@gregkh>
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
git cherry-pick -x 4e11c29873a8a296a20f99b3e03095e65ebf897d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012223-divisive-scrubbed-87ba@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

4e11c29873a8 ("PCI: mediatek: Clear interrupt status before dispatching handler")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4e11c29873a8a296a20f99b3e03095e65ebf897d Mon Sep 17 00:00:00 2001
From: qizhong cheng <qizhong.cheng@mediatek.com>
Date: Mon, 11 Dec 2023 17:49:23 +0800
Subject: [PATCH] PCI: mediatek: Clear interrupt status before dispatching
 handler
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We found a failure when using the iperf tool during WiFi performance
testing, where some MSIs were received while clearing the interrupt
status, and these MSIs cannot be serviced.

The interrupt status can be cleared even if the MSI status remains pending.
As such, given the edge-triggered interrupt type, its status should be
cleared before being dispatched to the handler of the underling device.

[kwilczynski: commit log, code comment wording]
Link: https://lore.kernel.org/linux-pci/20231211094923.31967-1-jianjun.wang@mediatek.com
Fixes: 43e6409db64d ("PCI: mediatek: Add MSI support for MT2712 and MT7622")
Signed-off-by: qizhong cheng <qizhong.cheng@mediatek.com>
Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
[bhelgaas: rewrap comment]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc:  <stable@vger.kernel.org>

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 66a8f73296fc..48372013f26d 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -617,12 +617,18 @@ static void mtk_pcie_intr_handler(struct irq_desc *desc)
 		if (status & MSI_STATUS){
 			unsigned long imsi_status;
 
+			/*
+			 * The interrupt status can be cleared even if the
+			 * MSI status remains pending. As such, given the
+			 * edge-triggered interrupt type, its status should
+			 * be cleared before being dispatched to the
+			 * handler of the underlying device.
+			 */
+			writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
 			while ((imsi_status = readl(port->base + PCIE_IMSI_STATUS))) {
 				for_each_set_bit(bit, &imsi_status, MTK_MSI_IRQS_NUM)
 					generic_handle_domain_irq(port->inner_domain, bit);
 			}
-			/* Clear MSI interrupt status */
-			writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
 		}
 	}
 


