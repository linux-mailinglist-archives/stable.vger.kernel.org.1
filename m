Return-Path: <stable+bounces-192690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31892C3EB4D
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 08:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34173ACE7B
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 07:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676D0306D3D;
	Fri,  7 Nov 2025 07:09:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E172C325F;
	Fri,  7 Nov 2025 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762499396; cv=none; b=tBZiVQp7MxBoGGL6X1Kit/51o/AzCxlSJGr/lMJf6qLLFLBkdBh/I6V+zCP2dACuNaPqKWch0olnkjoMaWGIuI2zbWkI4e0t9DCPtVoHnepXMPCpUWUkvVyDX+F/gFYPkN5AV3bEG+F0PNhEjqDHtey3PMVLfC3PcK4/GUGIlnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762499396; c=relaxed/simple;
	bh=9zzRv5jbx/f1HHwRrSJhRSD0gg5HgNQWvxoG7TJhu+U=;
	h=From:To:Cc:Subject:Date:Message-Id; b=eblvVFUztXq/MwE5qjD+yLYGuVdTPiLKIE4Asf71UAP5s4hBKUZusjX7BFT47OrCDSr4PwNXN6bgOp1ZqxrdnHMXnuz5c9n28xy37eAup+K1j6HwsyCE6KNaVxL75zqdmLbuRKVYx+CmDcZHXU4AKoRvqhJfh9Mp69NvzO4ZoV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-05 (Coremail) with SMTP id zQCowAC3IfAsmw1pwFveAQ--.53882S2;
	Fri, 07 Nov 2025 15:09:39 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: eajames@linux.ibm.com,
	ninad@linux.ibm.com,
	benh@kernel.crashing.org
Cc: linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fsi: Fix error handling in fsi_slave_init
Date: Fri,  7 Nov 2025 15:09:31 +0800
Message-Id: <20251107070931.30549-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:zQCowAC3IfAsmw1pwFveAQ--.53882S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4xAr1fKF4Dtr4xXr47Jwb_yoW8GFWDpa
	9rWasYkr48CrZ5Kr47uw18ZFZ8Cw4I934fCr1fGw1SkrZxWryqvFy8tryIkw18J3y8CFn5
	JF95G3ykWFn8Jr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbbTm3UUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

fsi_slave_init() calls device_initialize() for slave->dev
unconditionally. However, in the error paths, put_device() is not
called, leading to an imbalance in the device reference count.

Although kfree(slave) eventually frees the memory, it does not
properly release the device initialized by device_initialize(). For
proper pairing of device_initialize()/put_device(), add put_device()
calls in both error paths.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: d1dcd6782576 ("fsi: Add cfam char devices")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/fsi/fsi-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index c6c115993ebc..0d45e4442ca9 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1075,7 +1075,7 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	rc = __fsi_get_new_minor(slave, fsi_dev_cfam, &slave->dev.devt,
 				 &slave->cdev_idx);
 	if (rc)
-		goto err_free;
+		goto err_put_device;
 
 	trace_fsi_slave_init(slave);
 
@@ -1112,6 +1112,9 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 
 err_free_ida:
 	fsi_free_minor(slave->dev.devt);
+err_put_device:
+	put_device(&slave->dev);
+	return rc;
 err_free:
 	of_node_put(slave->dev.of_node);
 	kfree(slave);
-- 
2.17.1


