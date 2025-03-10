Return-Path: <stable+bounces-121660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAB7A58A79
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 03:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308A13AA5E2
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 02:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D9519B5B8;
	Mon, 10 Mar 2025 02:28:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F62288D6;
	Mon, 10 Mar 2025 02:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741573718; cv=none; b=cPNTNCijETb9IZpmpfW70EKTJnqDf238qDtyijrZzQW2/k77C9zNAfHBhgN2GHUPPNTkSj4+EbKnvRvYyy95DoFFk9E53vtHv07EDslL3JwP7WVFcErF5kTaiY3KOatJiTBeoyV5U7d17n4VYpgjN+JRxyOYfh9TXskUolEKNs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741573718; c=relaxed/simple;
	bh=HNEg0+3WipjXdcvdRHeHQ72N6wixwMcaX5VZ+mtcxas=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fKFePJKTZdwPnFj+02EvI4Bd+qBuFue5V3gSh+6AO2KlGaKaKimnr10hd/2ky+0jKJigCJylpLlJ25SOX9Pb6i5hGY/AeYV+nC+MngnBH+B1oQ9azkwki0XddcMaY9jFNcG/MG8apublz2Y+8Gpskr05Wd3IB8v2ga5/5Xo7SNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowAA3Plo8Ts5naU_XEw--.39940S2;
	Mon, 10 Mar 2025 10:28:21 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: eli.billauer@gmail.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] char: xillybus: Fix error handling in xillybus_init_chrdev()
Date: Mon, 10 Mar 2025 10:28:11 +0800
Message-Id: <20250310022811.182553-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAA3Plo8Ts5naU_XEw--.39940S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr4ktr47JrWfJF4kKry8Krg_yoWkuFb_CF
	1FkrWkWry0krnrJw15Kw18uF1j9w13Z3WfGF1vq3WaqryFvr4Uur4xWr1DZw15KrWv9ry7
	Ca42y3yUXFWa9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb38FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWI
	evJa73UjIFyTuYvjfUY3kuUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

After cdev_alloc() succeed and cdev_add() failed, call cdev_del() to
remove unit->cdev from the system properly.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 8cb5d216ab33 ("char: xillybus: Move class-related functions to new xillybus_class.c")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/char/xillybus/xillybus_class.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/xillybus/xillybus_class.c b/drivers/char/xillybus/xillybus_class.c
index c92a628e389e..045e125ec423 100644
--- a/drivers/char/xillybus/xillybus_class.c
+++ b/drivers/char/xillybus/xillybus_class.c
@@ -105,7 +105,7 @@ int xillybus_init_chrdev(struct device *dev,
 		dev_err(dev, "Failed to add cdev.\n");
 		/* kobject_put() is normally done by cdev_del() */
 		kobject_put(&unit->cdev->kobj);
-		goto unregister_chrdev;
+		goto err_cdev;
 	}
 
 	for (i = 0; i < num_nodes; i++) {
@@ -157,6 +157,7 @@ int xillybus_init_chrdev(struct device *dev,
 		device_destroy(&xillybus_class, MKDEV(unit->major,
 						     i + unit->lowest_minor));
 
+err_cdev:
 	cdev_del(unit->cdev);
 
 unregister_chrdev:
-- 
2.25.1


