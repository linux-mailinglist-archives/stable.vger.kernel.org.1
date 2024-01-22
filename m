Return-Path: <stable+bounces-12788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE95837395
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 21:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977F41F2CA56
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82E840BE2;
	Mon, 22 Jan 2024 20:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F2H4xjZ4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989493DB86
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 20:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705954527; cv=none; b=j/QaCMPr8O9MUf2xm35JwgL6l5nwzsujo5UdBYtt7h875/yeFCgho+Jy35g8b4s2MJqSh8HLtt9ZcxQD422XDBcI6Pxknh94DWc+i3Ufw1dfxZE932hNZCXDYNKIptKkx2vGALvYaSklu/yJaG4zYazGu6gKSs5wiJfm1IE6DQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705954527; c=relaxed/simple;
	bh=zPuI5qMl4UYO3hMpCWxDY2yIpTuwSR50ebjpn5YmLVU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nUU1nzxdHYWPLIPBIb113V0wa2Hqo8HRwv1DZfCLglQwpK+YqRPdNgD/p0N/20YxJ80ulVpT3QzqelibT4ybcxk/CKVQHE1ehsqz/eZex4ExvuzqtaRyC8uhXRuYnnKd8mev6LqCjjaenVaWLRrEX+ptsVNheftSqpL4HZYmokg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F2H4xjZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AEFC433F1;
	Mon, 22 Jan 2024 20:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705954527;
	bh=zPuI5qMl4UYO3hMpCWxDY2yIpTuwSR50ebjpn5YmLVU=;
	h=Subject:To:Cc:From:Date:From;
	b=F2H4xjZ4KvJ+HQ2dkwWgkQ7Hs6LkMO8hKMC1wLfjTKv0bumS12jShTOy0xz6DiNzi
	 q+l+tETdLj8TK3KjtxzF1weUT6Qs52wTLUq5ixcxSAv8BrHqUNvSmMdzNWNOUEA5Et
	 vVasSsvcrCNJKAe/p6vo3aGVSykD6hr4oH3sNDyI=
Subject: FAILED: patch "[PATCH] PCI: mediatek: Clear interrupt status before dispatching" failed to apply to 5.4-stable tree
To: qizhong.cheng@mediatek.com,angelogioacchino.delregno@collabora.com,bhelgaas@google.com,jianjun.wang@mediatek.com,kwilczynski@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 12:15:25 -0800
Message-ID: <2024012225-immorally-overhand-d3ab@gregkh>
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
git cherry-pick -x 4e11c29873a8a296a20f99b3e03095e65ebf897d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012225-immorally-overhand-d3ab@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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
 


