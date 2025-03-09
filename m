Return-Path: <stable+bounces-121563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CBAA58300
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 11:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95ADD3AE474
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 10:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8DB19F104;
	Sun,  9 Mar 2025 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s7bIapUt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF2F2114
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741515972; cv=none; b=gNnIEUPJadl+QAuRiiDYQHJhVNnywx2K/OATNqPFN5u/myJYJHf/bljzBpThA2saGSVqfcuLipng6/Nn4fSOn/hOGmdXZDf6wHPPQLvyWJHdd+5qXR8zPA79wQrHvXvtRUL3WWiERnekhq6zOTsZfMUp03mNUw7PDzM3+18c1rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741515972; c=relaxed/simple;
	bh=KYGTStMmZi8kj98FBEWbKGHw/VMEFVF5b4LO2KqBMI0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EL3wfRhUZFzk2lytrz2EmSVyZ/Pn9Y07Lzf0qxZwqA1QSk4SVkKU1vs1c69J0ewWgwahSw47yxIG30MuHA7Bym6HaUaRACh9vSZlf+cuS37cDFFYoL/bltKLCyBk3kZtL4GIastf9X0Ia/GdKNn7ocEfB62TZqK2LfDUZKQfvMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s7bIapUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A2BC4CEE5;
	Sun,  9 Mar 2025 10:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741515971;
	bh=KYGTStMmZi8kj98FBEWbKGHw/VMEFVF5b4LO2KqBMI0=;
	h=Subject:To:Cc:From:Date:From;
	b=s7bIapUtpwbiQZ3ryh8Ql607kAVAxVbU84qkFVsk4PAKiqIzQ3KFY9GQtyWMMj4Nz
	 OtzKOI89uCm4sxPLNrIxwxpe2Ns6kQ1/oqh8PEjp6OXTO8eenim7BqvsHUazg7ObLL
	 NoJKKEpPzgV1T8mQ9ov0ktdywmnR6v4jdxsTgUnw=
Subject: FAILED: patch "[PATCH] stmmac: loongson: Pass correct arg to PCI function" failed to apply to 6.6-stable tree
To: phasta@kernel.org,andrew@lunn.ch,chenx97@aosc.io,kuba@kernel.org,si.yanteng@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Mar 2025 11:24:55 +0100
Message-ID: <2025030955-spruce-hence-17e4@gregkh>
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
git cherry-pick -x 00371a3f48775967950c2fe3ec97b7c786ca956d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030955-spruce-hence-17e4@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 00371a3f48775967950c2fe3ec97b7c786ca956d Mon Sep 17 00:00:00 2001
From: Philipp Stanner <phasta@kernel.org>
Date: Wed, 26 Feb 2025 09:52:05 +0100
Subject: [PATCH] stmmac: loongson: Pass correct arg to PCI function

pcim_iomap_regions() should receive the driver's name as its third
parameter, not the PCI device's name.

Define the driver name with a macro and use it at the appropriate
places, including pcim_iomap_regions().

Cc: stable@vger.kernel.org # v5.14+
Fixes: 30bba69d7db4 ("stmmac: pci: Add dwmac support for Loongson")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
Tested-by: Henry Chen <chenx97@aosc.io>
Link: https://patch.msgid.link/20250226085208.97891-2-phasta@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index f5acfb7d4ff6..ab7c2750c104 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -11,6 +11,8 @@
 #include "dwmac_dma.h"
 #include "dwmac1000.h"
 
+#define DRIVER_NAME "dwmac-loongson-pci"
+
 /* Normal Loongson Tx Summary */
 #define DMA_INTR_ENA_NIE_TX_LOONGSON	0x00040000
 /* Normal Loongson Rx Summary */
@@ -568,7 +570,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (pci_resource_len(pdev, i) == 0)
 			continue;
-		ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
+		ret = pcim_iomap_regions(pdev, BIT(0), DRIVER_NAME);
 		if (ret)
 			goto err_disable_device;
 		break;
@@ -687,7 +689,7 @@ static const struct pci_device_id loongson_dwmac_id_table[] = {
 MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
 
 static struct pci_driver loongson_dwmac_driver = {
-	.name = "dwmac-loongson-pci",
+	.name = DRIVER_NAME,
 	.id_table = loongson_dwmac_id_table,
 	.probe = loongson_dwmac_probe,
 	.remove = loongson_dwmac_remove,


