Return-Path: <stable+bounces-12074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B26831797
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 11:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA7F288682
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 10:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470C023761;
	Thu, 18 Jan 2024 10:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="flL0fgAZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043BC22F0B;
	Thu, 18 Jan 2024 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575533; cv=none; b=IK7LkHFz8EzjOurtkdfRgUWXf6D5zHb+SO77yYwaXmS+x+VTWAb5DHJYejEaf7qyeomEZNBwLIBRJ+pKMz5hLKTHaXAx9BLF8fXUfgz6J7q7f05Hg2DAE7U3sI73MvraTeh2WVKIZ3f+BKfZYPUOqwejwhpUxDRawa5AkBu96JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575533; c=relaxed/simple;
	bh=A0A6C+JyJjnWjO8uoamZcLA+w5fRO3NLHOW73kMay7k=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:User-Agent:X-stable:
	 X-Patchwork-Hint:MIME-Version:Content-Transfer-Encoding; b=BouNpe+lcP0f8+yjfrAn1AkLV2gJtOBAxi9Wz0vQuW7c137o82w7OoZeivfUSSJWcq2uS9z5PJ16bEX8zWOCLuKzi6MZwhKxPhWKH4jdnHQ7sBt/qOTP5ko7tC5OpTwo2G0a8uogxz1fhvcXIY+A4nGLyGZID4SQayhBTofHkaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=flL0fgAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407E8C433F1;
	Thu, 18 Jan 2024 10:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705575532;
	bh=A0A6C+JyJjnWjO8uoamZcLA+w5fRO3NLHOW73kMay7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=flL0fgAZgG34kZOlgOT9dFuOF36nlsVF9l8Kc22s4iyGeVAa/+gpWTAq33bnCnkCR
	 ORqPhE8aU1dpQlkIqTXjO+Kvdjf0ftdLfffBiTDMz1VGb5kS38Rpwd6zG4SDFL4wZS
	 Du1vjChcbVqtS0bfQIB/G9T9rtgnIoo0dmGSQZps=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 016/100] hwtracing: hisi_ptt: Handle the interrupt in hardirq context
Date: Thu, 18 Jan 2024 11:48:24 +0100
Message-ID: <20240118104311.614533121@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118104310.892180084@linuxfoundation.org>
References: <20240118104310.892180084@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 016220ba0add..11f26ef709c9 100644
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
2.43.0




