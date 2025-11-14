Return-Path: <stable+bounces-194768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED23C5BAC8
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 08:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10073B0D26
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 07:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07041F91E3;
	Fri, 14 Nov 2025 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QPrqaDX1"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC571A3160
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763103978; cv=none; b=S8QXcrIPID3uWfmar7BOf1W94ALm+AOe1O6hx4f75Yy/gtz8HYdgiJZCOZaLn6/XqgrtyeEl3fEXTvEsafG6M6jr8QE90j5Am5DwSe3muqlNX12/aLdJGezRFdj3qZTHyQoAa7ZWsScXwdPLImqQB4LXmbuTYCYS1I2ROi6ideQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763103978; c=relaxed/simple;
	bh=d9LjtPLP9ntFDGX3+zqvG6uFgPQVD0YLOV0GppXVWLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iIuiusDB87O4o357HR2Zn0iLrdQxnaEmP6LT0cNkSiPdkdItgS0vLZos16XeD1JC2EqSV7IuuFZMwbJoy6rLzb2qCBY0SIBKj/snJnsP57qPp6ULALWBusGE8nR2vc36RzmTQeO/zjaJLXeoI5wteFt3jrhm864whQeyVmf+7jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QPrqaDX1; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ja
	PZ23DPribnGwimqs5KgNFWQUUN5wS6hsvSHAbMjiQ=; b=QPrqaDX1rBoY9QXUF8
	m8xTgBjzp3cwZqWaaTfckQopbXaLPPrFJ/9hcXfNlW+wInx7qCGwgV61wLADCNjo
	hE78yimDFEf9tg7MgJHY30Zn9Dd4byKyxVivCW2CxIFuR0IKiN3i1spguh/e4i5H
	O2MVsasW2OBiYVBWreUcy+iCk=
Received: from pek-blan-cn-l1.corp.ad.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDHT6G41BZpwnLFAA--.10020S4;
	Fri, 14 Nov 2025 15:05:46 +0800 (CST)
From: jetlan9@163.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.12.y] wifi: ath11k: Clear affinity hint before calling ath11k_pcic_free_irq() in error path
Date: Fri, 14 Nov 2025 15:05:09 +0800
Message-Id: <20251114070509.1764-1-jetlan9@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHT6G41BZpwnLFAA--.10020S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryxAr48ZrWUGF4DuF1xZrb_yoW8tr18pr
	W0gay7CF93Jr4xGa1rGF4xZFyfXFsxArW7JrW7Kw13uF4YyFyktF1aqF17tF1UCrWrAFya
	qwsrKr1fWa4YvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pujgn5UUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/1tbiOgIGyGkW0b5P3gAAs3

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit 68410c5bd381a81bcc92b808e7dc4e6b9ed25d11 ]

If a shared IRQ is used by the driver due to platform limitation, then the
IRQ affinity hint is set right after the allocation of IRQ vectors in
ath11k_pci_alloc_msi(). This does no harm unless one of the functions
requesting the IRQ fails and attempt to free the IRQ. This results in the
below warning:

WARNING: CPU: 7 PID: 349 at kernel/irq/manage.c:1929 free_irq+0x278/0x29c
Call trace:
 free_irq+0x278/0x29c
 ath11k_pcic_free_irq+0x70/0x10c [ath11k]
 ath11k_pci_probe+0x800/0x820 [ath11k_pci]
 local_pci_probe+0x40/0xbc

The warning is due to not clearing the affinity hint before freeing the
IRQs.

So to fix this issue, clear the IRQ affinity hint before calling
ath11k_pcic_free_irq() in the error path. The affinity will be cleared once
again further down the error path due to code organization, but that does
no harm.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-05266-QCAHSTSWPLZ_V2_TO_X86-1

Cc: Baochen Qiang <quic_bqiang@quicinc.com>
Fixes: 39564b475ac5 ("wifi: ath11k: fix boot failure with one MSI vector")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>
Link: https://patch.msgid.link/20250225053447.16824-2-manivannan.sadhasivam@linaro.org
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/net/wireless/ath/ath11k/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 6ebfa5d02e2e..c1d576ff77fa 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -936,6 +936,8 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 err_free_irq:
+	/* __free_irq() expects the caller to have cleared the affinity hint */
+	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
 	ath11k_pcic_free_irq(ab);
 
 err_ce_free:
-- 
2.43.0


