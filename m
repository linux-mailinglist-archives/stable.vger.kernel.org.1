Return-Path: <stable+bounces-180723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0324B8C41E
	for <lists+stable@lfdr.de>; Sat, 20 Sep 2025 10:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA0E47B851E
	for <lists+stable@lfdr.de>; Sat, 20 Sep 2025 08:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385C12798EC;
	Sat, 20 Sep 2025 08:52:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771EA34BA47;
	Sat, 20 Sep 2025 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758358324; cv=none; b=LQ4JyWRM6UxfRCToCockVEjKoUHFNIb9Er5DW8pGrTeCTk1n73lLxZm0UGAA3PzqvB36zQz1oJsRru+eQceFTu1vs34qiIDSb6Ovqi38uNz1wVmwbo2oXExSIH41j8tEbDsmEYZR8rdh9U6onpzdR1TQ/7Vku7zTMd8KBCU+D5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758358324; c=relaxed/simple;
	bh=98/A/gvh5ZZHq0EdCKQVJZBXC8RCJoc/pSNT9Nc/RpM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Vdu8WzEQhxBHeFCy2EBsr+q+QVV6vL7YWW8ga+3RbQ2WmfceCvwKVn3WEEId+eFpB2MP0ocRLgqqypOZ1dMD8Om6Dwaiv6FFTDqrfF/A3YF1vzuHpG6/Z4n+XdUKemZJ+XwoQQWuBd6S/k1yZKJ0lhJk4iI2OfBdc7q1Vq76oUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-05 (Coremail) with SMTP id zQCowABnCRMZa85onmPrAw--.50258S2;
	Sat, 20 Sep 2025 16:51:52 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: robh@kernel.org,
	saravanak@google.com,
	lizhi.hou@amd.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] of: unittest: Fix device reference count leak in of_unittest_pci_node_verify
Date: Sat, 20 Sep 2025 16:51:35 +0800
Message-Id: <20250920085135.21835-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:zQCowABnCRMZa85onmPrAw--.50258S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1kKFWxAryxKFW3Zr17GFg_yoW8Gw1kp3
	yUGas09rW8GF47Kw48Zr4UZFy3A342934rGFy8A3WS9wsYq34xtFyUXayjyrs8urWkXF1Y
	yr17tay8CF4UtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	WUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU0tCzDUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

In of_unittest_pci_node_verify(), when the add parameter is false,
device_find_any_child() obtains a reference to a child device. This
function implicitly calls get_device() to increment the device's
reference count before returning the pointer. However, the caller
fails to properly release this reference by calling put_device(),
leading to a device reference count leak.

As the comment of device_find_any_child states: "NOTE: you will need
to drop the reference with put_device() after use".

Cc: stable@vger.kernel.org
Fixes: 26409dd04589 ("of: unittest: Add pci_dt_testdrv pci driver")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/of/unittest.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index e3503ec20f6c..d225e73781fe 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -4271,7 +4271,7 @@ static struct platform_driver unittest_pci_driver = {
 static int of_unittest_pci_node_verify(struct pci_dev *pdev, bool add)
 {
 	struct device_node *pnp, *np = NULL;
-	struct device *child_dev;
+	struct device *child_dev = NULL;
 	char *path = NULL;
 	const __be32 *reg;
 	int rc = 0;
@@ -4306,6 +4306,8 @@ static int of_unittest_pci_node_verify(struct pci_dev *pdev, bool add)
 	kfree(path);
 	if (np)
 		of_node_put(np);
+	if (child_dev)
+		put_device(child_dev);
 
 	return rc;
 }
-- 
2.17.1


