Return-Path: <stable+bounces-121565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E966FA58302
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 11:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50B63AE67A
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 10:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8035A1A9B2A;
	Sun,  9 Mar 2025 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gRw+K22v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412D72114
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741515983; cv=none; b=Gk9gshR3Z1vDZ+yno4Y8XVmYY71sJM1DaVCppnpXqKGn9Tu9tW6LgEgMrEc+gEnW2SDcyuyHtGS0nUWLkZ6Rp+hY8wZTjPTGFOztswyY23MF/6c4BPgH4PBUtDoCmNaPzpDok6Ho7XoySmwaZk+zxjwtSdpWmioSdfQFeOjXGYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741515983; c=relaxed/simple;
	bh=qDxOz4ec6hIOUM6aPTVWfKoA0roiKQWW7Sa+jEGfHIs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZwOKfqSjSoqt/cVZZ+c55HgMM/ay/ms1cUODONaV4tvwW0Vnr78GCjU9w09KpSA0qm8MYmH+T+w6RxcQviDFZ8i+nu9GpYVLmWmw6kKss85FAJ81EScNCwzH2JVyQ3X8qoQI/oqfMwk3ecEGsLSKBaqZkGfF35AaNGj6U2wMZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gRw+K22v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A4EC4CEE5;
	Sun,  9 Mar 2025 10:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741515982;
	bh=qDxOz4ec6hIOUM6aPTVWfKoA0roiKQWW7Sa+jEGfHIs=;
	h=Subject:To:Cc:From:Date:From;
	b=gRw+K22vsux6IKebKlx/gcbcuCke9USiSzocRz/QjTtB9NOoD4/Qae2kSiZyAuWwJ
	 nIDEE2eq8Ib5c4XBf1RyEXDe6t97vtGYrAkNX7gPgDMJRQlrjYaysq7W0yGjJc+YC6
	 we2vw35wgkDJBDdl7ILTO9QJ2cBVzyKliVyRtodM=
Subject: FAILED: patch "[PATCH] stmmac: loongson: Pass correct arg to PCI function" failed to apply to 5.15-stable tree
To: phasta@kernel.org,andrew@lunn.ch,chenx97@aosc.io,kuba@kernel.org,si.yanteng@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Mar 2025 11:24:56 +0100
Message-ID: <2025030956-demeanor-abrasion-7a8d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 00371a3f48775967950c2fe3ec97b7c786ca956d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030956-demeanor-abrasion-7a8d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


