Return-Path: <stable+bounces-192673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1CBC3E56D
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 04:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0AA188870A
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 03:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3A02E8B9E;
	Fri,  7 Nov 2025 03:22:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F1E21578F;
	Fri,  7 Nov 2025 03:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762485736; cv=none; b=nwsAyFgUpzZynU2zS3Hv9/VM2ziMyscBVoVcFJrQdDUI5BqRnpuG+QwPJlYfGs4hTgFKsmM6MGxKUGikytL4KdRPxSAPl/keBqVr4U1+AbbONWWFSDSWHuRHKowgLGFSHELqSYqoQXgMQ0pRhupm2+MXs+P59kl+UpsWlhfIh1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762485736; c=relaxed/simple;
	bh=n/CvNyeydy7A7ai8PO9KeruPT4Vy2/gZRmm23G/tF6s=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XXAZ3Iw0+DnoSBbEWNzzG8QgBR1L5XpnTyucMXJ5GulYz3GoJMclIHZaXjIWji/Alcv6LfCjSybK7D9lbOIAvj5mARsX8yDRXO3TkUy4BVsPEUIjYQl1krcYC5J/Tw2AIwIGMil4sUh3IFIyngGzaq4360SkY69MVqxEtUdnZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-05 (Coremail) with SMTP id zQCowAD3ZvXSZQ1pMZXYAQ--.42215S2;
	Fri, 07 Nov 2025 11:22:02 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: eajames@linux.ibm.com,
	ninad@linux.ibm.com,
	joel@jms.id.au
Cc: linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fsi: Fix device refcount leak in i2cr_scom_probe
Date: Fri,  7 Nov 2025 11:21:52 +0800
Message-Id: <20251107032152.16835-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:zQCowAD3ZvXSZQ1pMZXYAQ--.42215S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GryfGF43Zr1xCw4UJry3XFb_yoWkCFc_Cw
	1Dur9rWrn8WFZ3uFy3Xr43ZryF9F4qqF18CF4jqrWfKasxXFnrXwn5ur4UCr4xWw47AFsY
	v3W8WrWfZr1IgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4q2NUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This patch fixes a device reference count leak in the i2cr_scom driver
by adding proper put_device() calls in both error paths and the remove
function.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: c0b34bed0bbf ("fsi: Add I2C Responder SCOM driver")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/fsi/i2cr-scom.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/i2cr-scom.c b/drivers/fsi/i2cr-scom.c
index cb7e02213032..11506d321d7e 100644
--- a/drivers/fsi/i2cr-scom.c
+++ b/drivers/fsi/i2cr-scom.c
@@ -104,14 +104,20 @@ static int i2cr_scom_probe(struct device *dev)
 
 	ret = fsi_get_new_minor(fsi_dev, fsi_dev_scom, &scom->dev.devt, &didx);
 	if (ret)
-		return ret;
+		goto err_put_device;
 
 	dev_set_name(&scom->dev, "scom%d", didx);
 	cdev_init(&scom->cdev, &i2cr_scom_fops);
 	ret = cdev_device_add(&scom->cdev, &scom->dev);
 	if (ret)
-		fsi_free_minor(scom->dev.devt);
+		goto err_free_minor;
+
+	return ret;
 
+err_free_minor:
+	fsi_free_minor(scom->dev.devt);
+err_put_device:
+	put_device(&scom->dev);
 	return ret;
 }
 
-- 
2.17.1


