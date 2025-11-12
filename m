Return-Path: <stable+bounces-194578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21808C51531
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 10:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02663ADBEB
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 09:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A9A2741C6;
	Wed, 12 Nov 2025 09:17:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FC79476;
	Wed, 12 Nov 2025 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939064; cv=none; b=QyQub8Hdw2v2akO1lA5pbSekfrg6t1DUrTz9ffacvzV5SyFbg7HdlVM6SrADwVN+H7f7hVDMRrvVsgcD1kJrQZN0FdwYpuMjldelGrxn3JNCKHOeXabBcljmMzeSa7EuJ9l2hLzLE+Juh4HDKgMLNW4eRnPS30uC4jx38HsBhYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939064; c=relaxed/simple;
	bh=CIVTOGTXKLMcPeOaQW0Hfq3hpD/bebGN7BNWF8TMSuo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NBS2u9D1D1CZ9Tp89RGmmcVOB3uSVh2VGpWkuHk839o2ICwiajEwgu7wwCS8xqKGdjDrfIXdYbc0/7gB5tOJsBGsA/4ePRDXtyAWdwKy8uy4lLIbXwFDwNsUZlRx1In3csLSfVm45tbWbmylbZMb/ndyIQhf4kEF6gXpTs4bVSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowAC3R9qlUBRpJUx3AA--.4432S2;
	Wed, 12 Nov 2025 17:17:34 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: alexander.shishkin@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] intel_th: Fix error handling in intel_th_output_open
Date: Wed, 12 Nov 2025 17:17:23 +0800
Message-Id: <20251112091723.35963-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:rQCowAC3R9qlUBRpJUx3AA--.4432S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4fWw47tFy3ZrWkCw4xCrg_yoW8ZFWrpF
	Wjqa90kFyUGwsFgws8XF4jvFyrKw1Iy3yFgFy8G3sYgFn5X3yYqrWrtFy5ZF15XrWrta4a
	qF1akrW8GFWUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1v38DUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

intel_th_output_open() calls bus_find_device_by_devt() which
internally increments the device reference count via get_device(), but
this reference is not properly released in several error paths. When
device driver is unavailable, file operations cannot be obtained, or
the driver's open method fails, the function returns without calling
put_device(), leading to a permanent device reference count leak. This
prevents the device from being properly released and could cause
resource exhaustion over time.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 39f4034693b7 ("intel_th: Add driver infrastructure for Intel(R) Trace Hub devices")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- modified the patch to fix uninitialized variable 'err' warnings.
---
 drivers/hwtracing/intel_th/core.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 47d9e6c3bac0..fdb9d022d875 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -810,13 +810,17 @@ static int intel_th_output_open(struct inode *inode, struct file *file)
 	int err;
 
 	dev = bus_find_device_by_devt(&intel_th_bus, inode->i_rdev);
-	if (!dev || !dev->driver)
-		return -ENODEV;
+	if (!dev || !dev->driver) {
+		err = -ENODEV;
+		goto out_no_device;
+	}
 
 	thdrv = to_intel_th_driver(dev->driver);
 	fops = fops_get(thdrv->fops);
-	if (!fops)
-		return -ENODEV;
+	if (!fops) {
+		err = -ENODEV;
+		goto out_put_device;
+	}
 
 	replace_fops(file, fops);
 
@@ -824,10 +828,16 @@ static int intel_th_output_open(struct inode *inode, struct file *file)
 
 	if (file->f_op->open) {
 		err = file->f_op->open(inode, file);
-		return err;
+		if (err)
+			goto out_put_device;
 	}
 
 	return 0;
+
+out_put_device:
+	put_device(dev);
+out_no_device:
+	return err;
 }
 
 static const struct file_operations intel_th_output_fops = {
-- 
2.17.1


