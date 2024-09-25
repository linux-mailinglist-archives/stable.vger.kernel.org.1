Return-Path: <stable+bounces-77572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 590FE985EB0
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9B41F21DE3
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C5B2141D6;
	Wed, 25 Sep 2024 12:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+M4KGSc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F01518E74A;
	Wed, 25 Sep 2024 12:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266357; cv=none; b=AK2nvDYInKsLQvgz7JyMn08SobV8ppHyeNa7Aiso435v8ah/uLHr6w7CTYN0qPQl1ZyTPo9uv+HRUbM2cdZp8iBSELmslzfbxCwYrAnIX0pnhHAUzFhPDrneo5n6AALjs0A0mn9Cpv26ZRDnEYL9mksAkzGRszbMsO16zy3fLW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266357; c=relaxed/simple;
	bh=IOt0KpXM+BgIW8s8YSZwbjD13vxR1ee/uXfc0ko2cAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQjozZ0myg76CwoZim92e5wI/lB66PXgf9wOwsfSutVGbTHEPtJNbvzFgBn+VVsyVIF0DaAJK6wtWvnjdN4yuE1mmlEIncTQtIPpk+D1KuZCaDqCm/x7fWDU8YsDp+wiqPoOMlUEo9Xqor9nARVdodOekZGH384aRpIvaltoB7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+M4KGSc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1136C4CEC7;
	Wed, 25 Sep 2024 12:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266356;
	bh=IOt0KpXM+BgIW8s8YSZwbjD13vxR1ee/uXfc0ko2cAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+M4KGScVjRpqeSCnqKxLtYksWL3qMYwYr2+NITi7XgCFqS4Xt1IKbEYhvzymtZDD
	 /WnQzJZ4ruCsiDRB+KtIcnZZqspki1NfvK3Fg9qCZoQj788cY7BFNpffAbX20R2HPl
	 KPqMwKSIfwAc5wHJCypE3SUbIzxUHbKpPo3xkTnkheCD0IQimgLKoify6neNtEpupw
	 5liBOKGNj1UE3PYxgUlFopN+0ZSbUcRZACr3OK08a4mJXbohpUhuwN1hwVJHbFpp4m
	 9U34UvIdjFZa+22p/qUe/rt/JU3xntaH4f3XB2LOBfJ4S+BCjEntAEiMSPelAAPaJF
	 xP5COqBT32g9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Robert Beckett <bob.beckett@collabora.com>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 026/139] nvme-pci: qdepth 1 quirk
Date: Wed, 25 Sep 2024 08:07:26 -0400
Message-ID: <20240925121137.1307574-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 83bdfcbdbe5d901c5fa432decf12e1725a840a56 ]

Another device has been reported to be unreliable if we have more than
one outstanding command. In this new case, data corruption may occur.
Since we have two devices now needing this quirky behavior, make a
generic quirk flag.

The same Apple quirk is clearly not "temporary", so update the comment
while moving it.

Link: https://lore.kernel.org/linux-nvme/191d810a4e3.fcc6066c765804.973611676137075390@collabora.com/
Reported-by: Robert Beckett <bob.beckett@collabora.com>
Reviewed-by: Christoph Hellwig hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  | 18 +++++++++---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d2b6975e71fbc..799f8a2bb0b4f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -88,6 +88,11 @@ enum nvme_quirks {
 	 */
 	NVME_QUIRK_NO_DEEPEST_PS		= (1 << 5),
 
+	/*
+	 *  Problems seen with concurrent commands
+	 */
+	NVME_QUIRK_QDEPTH_ONE			= (1 << 6),
+
 	/*
 	 * Set MEDIUM priority on SQ creation
 	 */
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7fc1ab4d9e7d8..32b5cc76a0223 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2526,15 +2526,8 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	else
 		dev->io_sqes = NVME_NVM_IOSQES;
 
-	/*
-	 * Temporary fix for the Apple controller found in the MacBook8,1 and
-	 * some MacBook7,1 to avoid controller resets and data loss.
-	 */
-	if (pdev->vendor == PCI_VENDOR_ID_APPLE && pdev->device == 0x2001) {
+	if (dev->ctrl.quirks & NVME_QUIRK_QDEPTH_ONE) {
 		dev->q_depth = 2;
-		dev_warn(dev->ctrl.device, "detected Apple NVMe controller, "
-			"set queue depth=%u to work around controller resets\n",
-			dev->q_depth);
 	} else if (pdev->vendor == PCI_VENDOR_ID_SAMSUNG &&
 		   (pdev->device == 0xa821 || pdev->device == 0xa822) &&
 		   NVME_CAP_MQES(dev->ctrl.cap) == 0) {
@@ -3399,6 +3392,8 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1217, 0x8760), /* O2 Micro 64GB Steam Deck */
+		.driver_data = NVME_QUIRK_QDEPTH_ONE },
 	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_BOGUS_NID, },
@@ -3531,7 +3526,12 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0xcd02),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
-		.driver_data = NVME_QUIRK_SINGLE_VECTOR },
+		/*
+		 * Fix for the Apple controller found in the MacBook8,1 and
+		 * some MacBook7,1 to avoid controller resets and data loss.
+		 */
+		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
+				NVME_QUIRK_QDEPTH_ONE },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
-- 
2.43.0


