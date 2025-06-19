Return-Path: <stable+bounces-154792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8083FAE0379
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 13:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CAA5A0B49
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F007822756A;
	Thu, 19 Jun 2025 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dEo3q58B"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3406422539D
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332448; cv=none; b=bs/C0JzefYArIKUL7qW9RmXJwbQTtewTiHLxenlnqhp9sPzJs3WZLRexjczdhkpwCIKIQ3CR5j2GmykD2llbHfT9TO+04Q98mChBOgy8NJUU1mpTEdgjovAAP/JLWeHZmu8pa277RbUkSaBVm0KCupU+Y5h/TWwPh0hxgHiEG20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332448; c=relaxed/simple;
	bh=GTEgAFblZ1I1Rx/PA6kcyVtspNNY8STQFOb+NjVi1nA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AKzGxbFtu9GSC+q/XP8qL7LNm5cOdvx9paRRDT8yuroGF6+zxL/sDuUuzQ+fdhIWdAbKv4lumABUVQb/6Douu89t65f6su21IJz6LclYn3rMf16lhQyGaq8KG5EoBQzIAjYNMcYXcWUgigsm3p+9pgm8U1RbcwtS38v+oPtAVdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dEo3q58B; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=WD
	hgu/zjInVYs5iXtRtiJKoU32H8cbXGc1Rl7gw9t4Y=; b=dEo3q58BPn+hygs1HS
	TptEy/ny5TtfNI/txQ5JXh1qelrJIJWQjU+craK6ASZeIKbNe5hspHUl3601tfVy
	JzIkA5iIzqj435n0Q16QacMNi6df67tsscGDdtrH5/ylCv2pfCX3Su/XqDkFTZnk
	NnAMoLKaNFCZ4NBWQPD//taFs=
Received: from pek-blan-cn-l1.corp.ad.wrs.com (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAXH3XN81NoslEPAQ--.20433S4;
	Thu, 19 Jun 2025 19:26:26 +0800 (CST)
From: jetlan9@163.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.12.y] wifi: ath12k: Clear affinity hint before calling ath12k_pci_free_irq() in error path
Date: Thu, 19 Jun 2025 19:25:41 +0800
Message-Id: <20250619112541.1641-1-jetlan9@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAXH3XN81NoslEPAQ--.20433S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryxZF45JFyrKFy5GFWrAFb_yoW8Zry3pr
	W0gw17CFyfGa18Ww4rGa1xXryfWanrXry7Gr47Kwn3uFW5ZF97tFn0qF17Jr1UGFWrAFya
	9FsrGr18Xas0qaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pujgn5UUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/1tbiWx1xyGhT6-bwVwAAs+

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit b43b1e2c52db77c872bd60d30cdcc72c47df70c7 ]

If a shared IRQ is used by the driver due to platform limitation, then the
IRQ affinity hint is set right after the allocation of IRQ vectors in
ath12k_pci_msi_alloc(). This does no harm unless one of the functions
requesting the IRQ fails and attempt to free the IRQ.

This may end up with a warning from the IRQ core that is expecting the
affinity hint to be cleared before freeing the IRQ:

kernel/irq/manage.c:

	/* make sure affinity_hint is cleaned up */
	if (WARN_ON_ONCE(desc->affinity_hint))
		desc->affinity_hint = NULL;

So to fix this issue, clear the IRQ affinity hint before calling
ath12k_pci_free_irq() in the error path. The affinity will be cleared once
again further down the error path due to code organization, but that does
no harm.

Fixes: a3012f206d07 ("wifi: ath12k: set IRQ affinity to CPU0 in case of one MSI vector")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>
Link: https://patch.msgid.link/20250225053447.16824-3-manivannan.sadhasivam@linaro.org
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/net/wireless/ath/ath12k/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 45d537066345..9c35fbe52872 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1503,6 +1503,8 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 err_free_irq:
+	/* __free_irq() expects the caller to have cleared the affinity hint */
+	ath12k_pci_set_irq_affinity_hint(ab_pci, NULL);
 	ath12k_pci_free_irq(ab);
 
 err_ce_free:
-- 
2.34.1


