Return-Path: <stable+bounces-12789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2756A837396
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 21:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB69E1F2CB06
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9312440BEE;
	Mon, 22 Jan 2024 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SeHlMARr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555743DB86
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705954529; cv=none; b=BNctdY6zMbHdotyATfngk4W+RENdTKaxTblhpRqYNMWS9r+sU7f6NFwGtVfawWohllNr1CnXVLXs37ilR5apRS6TpzAmdb06v7pEVndh4hjT7utWSHP8xpNiSLi2FqhSBYdq0sm4AwH1BmNHRASB+pH3Qq7lcFvLVS1DnjCb7Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705954529; c=relaxed/simple;
	bh=DH69NDVHaCERScLWskRxhsgTuKq5VLJD+ea3JjQCDoM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cwGX5PclS+10y3i/Px7Ihj0yAgL5Rz+fG3f2794BEZdbxXtOm/HrwVtqWjiG1QrPBdRf/UitMQBnz/+s1ykGRxw2v6Mq3z8+rHeDf3W8AtZ8cBpTNh9hsfz6lMcnrCgd2twb5scxWfExTaByTlkfmRSEsOpvOiPCLDctLg2tzko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SeHlMARr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B32C433C7;
	Mon, 22 Jan 2024 20:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705954529;
	bh=DH69NDVHaCERScLWskRxhsgTuKq5VLJD+ea3JjQCDoM=;
	h=Subject:To:Cc:From:Date:From;
	b=SeHlMARrY6z4iuaPw0s/mY07GvBeCJ6gnLx+GMhixeG0Wf/sfTZc3JEWGNoXzYWpQ
	 bT52UfBHmrOQ2f1oWGaRCiY24mEYmwH99BaWM1SEQ0wxSvWQMcNfJBO4xRnbn8V6fN
	 t7hVBmaxDA/+hwi0CBhOZFeSzTlw5neMJydNcOcc=
Subject: FAILED: patch "[PATCH] PCI: mediatek: Clear interrupt status before dispatching" failed to apply to 4.19-stable tree
To: qizhong.cheng@mediatek.com,angelogioacchino.delregno@collabora.com,bhelgaas@google.com,jianjun.wang@mediatek.com,kwilczynski@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 12:15:27 -0800
Message-ID: <2024012227-outdoors-swivel-68c9@gregkh>
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
git cherry-pick -x 4e11c29873a8a296a20f99b3e03095e65ebf897d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012227-outdoors-swivel-68c9@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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
 


