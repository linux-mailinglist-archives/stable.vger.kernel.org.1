Return-Path: <stable+bounces-121564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBECA58301
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 11:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8EF16A62A
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 10:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D1E19F104;
	Sun,  9 Mar 2025 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qsszf7cF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443392114
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741515980; cv=none; b=MtI5XXq2JoTY3MjpE7wRW7bGiCatSjS6VscKIr5CL9K7u4DYSHQlqpgxYNNwmbCbkb6JsgAEexaG+cZHhavIkmmIHFU3R2GuVviuZPXFT5RhATcM4fbf+dEZnF20237B2ItvWQ0xVpDPCZyGhaPDGhh+SEcRQV4eHovyiB11hz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741515980; c=relaxed/simple;
	bh=rcwGJG3bcLThmSNrVmyeS1ML9LAgh49rZXH5aOBXFCc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mukc7HbK0agh6fZEL9ja9B6/m+7ms67xXkomrCEMnThJDHvcL7PetTYPSGKsSg6XEiv1dT9WX/UabxOOWFHCl4+/KMc2G4qd8UucVcX/Vq5If4+qwMLMmJDxor+4FFMKbgZ9zMsjg7lwGJmJul+eiH9nKYpT0KxrdC87/jvn/6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qsszf7cF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C9DC4CEE5;
	Sun,  9 Mar 2025 10:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741515979;
	bh=rcwGJG3bcLThmSNrVmyeS1ML9LAgh49rZXH5aOBXFCc=;
	h=Subject:To:Cc:From:Date:From;
	b=Qsszf7cF2ZIQP7h6O5D4J/iGZKz1v2vmJSfkoBvXBue668ntLWejwAb7cA/bZn78x
	 6mXVALDoDyX/wLdastNuHA1qBxRZzWOsIoSIVfl3QDkM/ojtIk5CipwVBpT9nS9Y7b
	 hdFIKYNDVZS9fwDJPxWndMxdRxw54oTYv+tABsSE=
Subject: FAILED: patch "[PATCH] stmmac: loongson: Pass correct arg to PCI function" failed to apply to 6.1-stable tree
To: phasta@kernel.org,andrew@lunn.ch,chenx97@aosc.io,kuba@kernel.org,si.yanteng@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Mar 2025 11:24:55 +0100
Message-ID: <2025030955-curable-irk-822f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 00371a3f48775967950c2fe3ec97b7c786ca956d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030955-curable-irk-822f@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


