Return-Path: <stable+bounces-107094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CCBA02A22
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C6057A28CA
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591F41CDFD5;
	Mon,  6 Jan 2025 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iFulSoeZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133791DB360;
	Mon,  6 Jan 2025 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177433; cv=none; b=sJDUizwhHV03UvSjhoUZoVQ6jKBncNgCbwZz5bY/TSUNGVTZG3sOZLKZsQX2ZcRUrKS5amPcq4bNiNAC07hIsa547WTy56Ve+H4CNxoKbQ3GUQ2MXT9+0MC3pa5zAVuPKq8Gryg8cOgWHx1BtKXE3Y6GQpFYWvZ5BVfkTDzKIRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177433; c=relaxed/simple;
	bh=osjn4Zo1gWi9wmsI1VZ4jnqf/xm4nHeqAk3/MxAXfFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTXH5t020KdQrHS2oSO51M6XlSFq52ibcJxBFzLusZ6ljRBJin/mTxFKg7af15f8Mfnfriq3hSR2HafCqcUCsbrbAPwnGdJ4QH8C3m5kEsrrZ4870T8vGGaioP0bMPzgwoWSkQj1PrwFWvU3hdvr+X/bJx2aUBa7/O2fIqv2dMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iFulSoeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D859C4CED2;
	Mon,  6 Jan 2025 15:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736177432;
	bh=osjn4Zo1gWi9wmsI1VZ4jnqf/xm4nHeqAk3/MxAXfFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iFulSoeZKxvU7/jHsaw6FlIy0DRTKZw0xOELDefhh7b0HrfagGFnXVNTYBfo27/IW
	 0IAhGSjHFOwKukBZB6t/+DjkdTVEDRUHI4QrBq9FqHwvHHSOn697zVb93qbagp5sau
	 vplq0LdEBNPAgyUe2DatUSOeXN2ZflYL/FBC1Whk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Pawe=C5=82=20Anikiel?= <panikiel@google.com>,
	Robert Beckett <bob.beckett@collabora.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 132/222] nvme-pci: 512 byte aligned dma pool segment quirk
Date: Mon,  6 Jan 2025 16:15:36 +0100
Message-ID: <20250106151155.766173712@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151150.585603565@linuxfoundation.org>
References: <20250106151150.585603565@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Beckett <bob.beckett@collabora.com>

[ Upstream commit ebefac5647968679f6ef5803e5d35a71997d20fa ]

We initially introduced a quick fix limiting the queue depth to 1 as
experimentation showed that it fixed data corruption on 64GB steamdecks.

Further experimentation revealed corruption only happens when the last
PRP data element aligns to the end of the page boundary. The device
appears to treat this as a PRP chain to a new list instead of the data
element that it actually is. This implementation is in violation of the
spec. Encountering this errata with the Linux driver requires the host
request a 128k transfer and coincidently be handed the last small pool
dma buffer within a page.

The QD1 quirk effectly works around this because the last data PRP
always was at a 248 byte offset from the page start, so it never
appeared at the end of the page, but comes at the expense of throttling
IO and wasting the remainder of the PRP page beyond 256 bytes. Also to
note, the MDTS on these devices is small enough that the "large" prp
pool can hold enough PRP elements to never reach the end, so that pool
is not a problem either.

Introduce a new quirk to ensure the small pool is always aligned such
that the last PRP element can't appear a the end of the page. This comes
at the expense of wasting 256 bytes per small pool page allocated.

Link: https://lore.kernel.org/linux-nvme/20241113043151.GA20077@lst.de/T/#u
Fixes: 83bdfcbdbe5d ("nvme-pci: qdepth 1 quirk")
Cc: Paweł Anikiel <panikiel@google.com>
Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/nvme.h | 5 +++++
 drivers/nvme/host/pci.c  | 9 +++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bddc068d58c7..e867ac859a87 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -172,6 +172,11 @@ enum nvme_quirks {
 	 * MSI (but not MSI-X) interrupts are broken and never fire.
 	 */
 	NVME_QUIRK_BROKEN_MSI			= (1 << 21),
+
+	/*
+	 * Align dma pool segment size to 512 bytes
+	 */
+	NVME_QUIRK_DMAPOOL_ALIGN_512		= (1 << 22),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d525fa1229d7..52c8fd3d5c47 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2653,15 +2653,20 @@ static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
 
 static int nvme_setup_prp_pools(struct nvme_dev *dev)
 {
+	size_t small_align = 256;
+
 	dev->prp_page_pool = dma_pool_create("prp list page", dev->dev,
 						NVME_CTRL_PAGE_SIZE,
 						NVME_CTRL_PAGE_SIZE, 0);
 	if (!dev->prp_page_pool)
 		return -ENOMEM;
 
+	if (dev->ctrl.quirks & NVME_QUIRK_DMAPOOL_ALIGN_512)
+		small_align = 512;
+
 	/* Optimisation for I/Os between 4k and 128k */
 	dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,
-						256, 256, 0);
+						256, small_align, 0);
 	if (!dev->prp_small_pool) {
 		dma_pool_destroy(dev->prp_page_pool);
 		return -ENOMEM;
@@ -3403,7 +3408,7 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1217, 0x8760), /* O2 Micro 64GB Steam Deck */
-		.driver_data = NVME_QUIRK_QDEPTH_ONE },
+		.driver_data = NVME_QUIRK_DMAPOOL_ALIGN_512, },
 	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_BOGUS_NID, },
-- 
2.39.5




