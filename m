Return-Path: <stable+bounces-5356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A2380CB5E
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD67B213D3
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF3D47774;
	Mon, 11 Dec 2023 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AO1IE9wN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C4338DD0
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 13:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E731C433C8;
	Mon, 11 Dec 2023 13:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302711;
	bh=L1V/DOY/F+5p3c12NfvDLScxNfhhqwl8sBHrp8jPS5U=;
	h=From:To:Cc:Subject:Date:From;
	b=AO1IE9wNDfMvIbYy1jav41xBZkcSMqQJjWqje+u6LV/GABD8whXHLsoIzodeG/DmR
	 h9ryGDkaJfsMNgGsa+V+fU3w5mD1jBBPmF6b2lyTDe9UPSUfWxOjz/J2zT3c6Dbu2h
	 WnZHyQMcBq1ZlLH2kreBBL2OdKgHUzOitMtaVDVpNmz6msp8pqAawW08afZWSrY4Yx
	 btuxfk1kb1vVFZ12lwtwSya2WJ9c+Fe5wvdI05V1rqWmhGFEh+811K5Pnh0rwr/Yv6
	 mtCw00DmURFg64Gxr0GpQiu+mcuU+e0fP7Ed8x+aFZRi1ary6BFXkiQNuwIeBkB6hp
	 ycSsHKbLq3jew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	jonathan.cameron@huawei.com,
	alexander.shishkin@linux.intel.com
Subject: [PATCH AUTOSEL 6.6 01/47] hwtracing: hisi_ptt: Handle the interrupt in hardirq context
Date: Mon, 11 Dec 2023 08:50:02 -0500
Message-ID: <20231211135147.380223-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit

From: Yicong Yang <yangyicong@hisilicon.com>

[ Upstream commit e0dd27ad8af00f147ac3c9de88e0687986afc3ea ]

Handle the trace interrupt in the hardirq context, make sure the irq
core won't threaded it by declaring IRQF_NO_THREAD and userspace won't
balance it by declaring IRQF_NOBALANCING. Otherwise we may violate the
synchronization requirements of the perf core, referenced to the
change of arm-ccn PMU
  commit 0811ef7e2f54 ("bus: arm-ccn: fix PMU interrupt flags").

In the interrupt handler we mainly doing 2 things:
- Copy the data from the local DMA buffer to the AUX buffer
- Commit the data in the AUX buffer

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ Fixed commit description to suppress checkpatch warning ]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20231010084731.30450-3-yangyicong@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 49ea1b0f74890..7d2127d86c728 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -342,9 +342,9 @@ static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
 		return ret;
 
 	hisi_ptt->trace_irq = pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ);
-	ret = devm_request_threaded_irq(&pdev->dev, hisi_ptt->trace_irq,
-					NULL, hisi_ptt_isr, 0,
-					DRV_NAME, hisi_ptt);
+	ret = devm_request_irq(&pdev->dev, hisi_ptt->trace_irq, hisi_ptt_isr,
+				IRQF_NOBALANCING | IRQF_NO_THREAD, DRV_NAME,
+				hisi_ptt);
 	if (ret) {
 		pci_err(pdev, "failed to request irq %d, ret = %d\n",
 			hisi_ptt->trace_irq, ret);
-- 
2.42.0


