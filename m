Return-Path: <stable+bounces-154427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF23ADD9E0
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C876C1BC278A
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B082CCC5;
	Tue, 17 Jun 2025 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RvK7Xvqk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2B22FA649;
	Tue, 17 Jun 2025 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179158; cv=none; b=GgRJg6z2ffRYwalJGUgDpjxfjqfi6ZDhmKSrJsQBcmnS0Es2Rhqgt7SbkFsB5Hzz6oma7AGBifaY5aWO1m5Ynm38m40G4rpsa/qrc+YmeFaC4QcXLQnbhQrXcnktNDQ/OIpk1TZBHx6pmoU13AMQEE/gQnXF9fNp5mmHzGBX/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179158; c=relaxed/simple;
	bh=ixf3Iaa9/6nmqiFS4BrM2X/iOvwss2LWrSmXih8uHw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gt1yyRGZ5nhmAsshRumX2PWaqWfQM3YOaaCoTdzZwRROCr+M5PqBGjvcIUDygFYGZBx/0ZartBTECSXZ4+kOZX8E4wX17VXidt25ze/swD76h8AEcbeIDMjH7Yie2534HQAN9m/hlER69W4ZarCx+iEu5PSQ8Ys905efVJe0Q1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RvK7Xvqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80B5C4CEE3;
	Tue, 17 Jun 2025 16:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750179156;
	bh=ixf3Iaa9/6nmqiFS4BrM2X/iOvwss2LWrSmXih8uHw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RvK7Xvqk04AFu0fmRdDe0wiCYyPvTzf6qBeqaO2HwLi5b7MGihPXjJ/cIHrF0bKwy
	 XZEaq8rEHjJMbEynv73lonDylKNgW3NIlqa+/ktwwBNVCaz4kPhNOnNWPfC9HOj+y2
	 F6MAv8Z5xDnMx2OuwpuQIA9opzrg6Otgc1cPq+oc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Kiran K <kiran.k@intel.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 665/780] Bluetooth: btintel_pcie: Increase the tx and rx descriptor count
Date: Tue, 17 Jun 2025 17:26:13 +0200
Message-ID: <20250617152518.547949930@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>

[ Upstream commit 2dd711102ce69ae41f65d09c012441227d4aa983 ]

This change addresses latency issues observed in HID use cases where
events arrive in bursts. By increasing the Rx descriptor count to 64,
the firmware can handle bursty data more effectively, reducing latency
and preventing buffer overflows.

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btintel_pcie.c | 24 ++++++++++++------------
 drivers/bluetooth/btintel_pcie.h |  7 +++++--
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index a1bfc76fa29b2..a4883523ccc9e 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1665,8 +1665,8 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 	 *  + size of index * Number of queues(2) * type of index array(4)
 	 *  + size of context information
 	 */
-	total = (sizeof(struct tfd) + sizeof(struct urbd0) + sizeof(struct frbd)
-		+ sizeof(struct urbd1)) * BTINTEL_DESCS_COUNT;
+	total = (sizeof(struct tfd) + sizeof(struct urbd0)) * BTINTEL_PCIE_TX_DESCS_COUNT;
+	total += (sizeof(struct frbd) + sizeof(struct urbd1)) * BTINTEL_PCIE_RX_DESCS_COUNT;
 
 	/* Add the sum of size of index array and size of ci struct */
 	total += (sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES * 4) + sizeof(struct ctx_info);
@@ -1691,36 +1691,36 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 	data->dma_v_addr = v_addr;
 
 	/* Setup descriptor count */
-	data->txq.count = BTINTEL_DESCS_COUNT;
-	data->rxq.count = BTINTEL_DESCS_COUNT;
+	data->txq.count = BTINTEL_PCIE_TX_DESCS_COUNT;
+	data->rxq.count = BTINTEL_PCIE_RX_DESCS_COUNT;
 
 	/* Setup tfds */
 	data->txq.tfds_p_addr = p_addr;
 	data->txq.tfds = v_addr;
 
-	p_addr += (sizeof(struct tfd) * BTINTEL_DESCS_COUNT);
-	v_addr += (sizeof(struct tfd) * BTINTEL_DESCS_COUNT);
+	p_addr += (sizeof(struct tfd) * BTINTEL_PCIE_TX_DESCS_COUNT);
+	v_addr += (sizeof(struct tfd) * BTINTEL_PCIE_TX_DESCS_COUNT);
 
 	/* Setup urbd0 */
 	data->txq.urbd0s_p_addr = p_addr;
 	data->txq.urbd0s = v_addr;
 
-	p_addr += (sizeof(struct urbd0) * BTINTEL_DESCS_COUNT);
-	v_addr += (sizeof(struct urbd0) * BTINTEL_DESCS_COUNT);
+	p_addr += (sizeof(struct urbd0) * BTINTEL_PCIE_TX_DESCS_COUNT);
+	v_addr += (sizeof(struct urbd0) * BTINTEL_PCIE_TX_DESCS_COUNT);
 
 	/* Setup FRBD*/
 	data->rxq.frbds_p_addr = p_addr;
 	data->rxq.frbds = v_addr;
 
-	p_addr += (sizeof(struct frbd) * BTINTEL_DESCS_COUNT);
-	v_addr += (sizeof(struct frbd) * BTINTEL_DESCS_COUNT);
+	p_addr += (sizeof(struct frbd) * BTINTEL_PCIE_RX_DESCS_COUNT);
+	v_addr += (sizeof(struct frbd) * BTINTEL_PCIE_RX_DESCS_COUNT);
 
 	/* Setup urbd1 */
 	data->rxq.urbd1s_p_addr = p_addr;
 	data->rxq.urbd1s = v_addr;
 
-	p_addr += (sizeof(struct urbd1) * BTINTEL_DESCS_COUNT);
-	v_addr += (sizeof(struct urbd1) * BTINTEL_DESCS_COUNT);
+	p_addr += (sizeof(struct urbd1) * BTINTEL_PCIE_RX_DESCS_COUNT);
+	v_addr += (sizeof(struct urbd1) * BTINTEL_PCIE_RX_DESCS_COUNT);
 
 	/* Setup data buffers for txq */
 	err = btintel_pcie_setup_txq_bufs(data, &data->txq);
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 3f59138dfcca4..a94910ccd5d3c 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -135,8 +135,11 @@ enum btintel_pcie_tlv_type {
 /* Default interrupt timeout in msec */
 #define BTINTEL_DEFAULT_INTR_TIMEOUT_MS	3000
 
-/* The number of descriptors in TX/RX queues */
-#define BTINTEL_DESCS_COUNT	16
+/* The number of descriptors in TX queues */
+#define BTINTEL_PCIE_TX_DESCS_COUNT	32
+
+/* The number of descriptors in RX queues */
+#define BTINTEL_PCIE_RX_DESCS_COUNT	64
 
 /* Number of Queue for TX and RX
  * It indicates the index of the IA(Index Array)
-- 
2.39.5




