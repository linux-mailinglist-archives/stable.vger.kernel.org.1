Return-Path: <stable+bounces-47975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4428FC527
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 09:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA3D282808
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 07:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A94318FDDE;
	Wed,  5 Jun 2024 07:52:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F049418FDBF
	for <stable@vger.kernel.org>; Wed,  5 Jun 2024 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573975; cv=none; b=A0waTvroD0VXXtuGKFgW8wFQDHafBaS1yCZ8xS/KnBaQgWMrTNKGrBnJHDO6WA+0Co1duqGQN1qODvB9fCLPZxIlJSpV+ii9uuKfC3UPxlE7X1MPPeg7zaSUt3on6fmkQdOWfZrzmCtUHAooVYJeNvLkfE5xzPebzEn6kmKegR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573975; c=relaxed/simple;
	bh=0WgU7SJsiJXMETAWSbenmXb88IxbtmToM9ed9ByiSVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S9AyT2mneIcMRIOcogxQXI0XWbHQF6CliuGLvobOyHOnuGNBsgLgKzJKa4W0V/Vx51VxG6P+dmh7OFAkdZ8d15L9srUJ+jFR3+l5HMSHbonGNR7c+Ju9zqj2A1mVbskR8UNUWJO7Cn2XnvWcsXhSL1ZJsrF7Y85sy8r0ZJuXs4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.180.133.93])
	by gateway (Coremail) with SMTP id _____8AxW+pPGWBm2a8DAA--.15793S3;
	Wed, 05 Jun 2024 15:52:48 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.133.93])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxlsVPGWBmqlgVAA--.42816S2;
	Wed, 05 Jun 2024 15:52:47 +0800 (CST)
From: Hongchen Zhang <zhanghongchen@loongson.cn>
To: "H. Peter Anvin" <zhanghongchen@loongson.cn>
Cc: stable@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v2] PCI: use local_pci_probe when best selected cpu is offline
Date: Wed,  5 Jun 2024 15:52:46 +0800
Message-Id: <20240605075246.3973234-1-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxlsVPGWBmqlgVAA--.42816S2
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQATB2ZfxJMBrABDsV
X-Coremail-Antispam: 1Uk129KBj9xXoW7GrW7CFW8Jw4fuw4kZr1kWFX_yoWkJFb_uF
	y0grs7Wr4UCry0y3s0vr4fZrZYk3WjvFn2kF4xta43Za47AF15tayDury5JF18Ww43JF9I
	yw1UXr18ur17JosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==

When the best selected CPU is offline, work_on_cpu() will stuck forever.
This can be happen if a node is online while all its CPUs are offline
(we can use "maxcpus=1" without "nr_cpus=1" to reproduce it), Therefore,
in this case, we should call local_pci_probe() instead of work_on_cpu().

Cc: <stable@vger.kernel.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
v1 -> v2 Added the method to reproduce this issue
---
 drivers/pci/pci-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index af2996d0d17f..32a99828e6a3 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -386,7 +386,7 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 		free_cpumask_var(wq_domain_mask);
 	}
 
-	if (cpu < nr_cpu_ids)
+	if ((cpu < nr_cpu_ids) && cpu_online(cpu))
 		error = work_on_cpu(cpu, local_pci_probe, &ddi);
 	else
 		error = local_pci_probe(&ddi);
-- 
2.33.0


