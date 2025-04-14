Return-Path: <stable+bounces-132419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C65AA87BD6
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 11:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1DA173212
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 09:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B751CDFD5;
	Mon, 14 Apr 2025 09:27:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EE325D207;
	Mon, 14 Apr 2025 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744622852; cv=none; b=Onc9DnqWUHD7VFY3bIivA2lvFsSBdOncqULRNZjPSQE3+WG0bC/cuKRcr+s1u4pLeBWiCAuwDTA3DZy0RVYsGUyOLNq3KwxTe98eLV5hEgaE9OUR6vmOQgXf3Ll8D7SvwLvWDjbsgyox9C4zgKW4s3eoceqyMv+pWQ+QzwK8CQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744622852; c=relaxed/simple;
	bh=p8L/crSaIvP89HYdkhQRcIOEzvOeFkDY8nSCAWshkQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jOWHxSswWNXruIfGAvcXeWzrMpTrsSL9KIkn4Zh3+x1adlLCAHkvsdxKBVcpiZZZk0VcqQ1TsrdOZOjmE5MHMitk85LBIa8vMPZeBYrDH78yUxGQmOJ1QgTPNMJgzyhg9+dnKfxHhNEFEGgBlJvrtmFQvuG9+Fw4J6HWR3Aoxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowAD3mzjo1PxninzQCA--.38456S2;
	Mon, 14 Apr 2025 17:27:12 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: eajames@linux.ibm.com,
	ninad@linux.ibm.com,
	joel@jms.id.au
Cc: linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] fsi/core: fix error handling in fsi_slave_init()
Date: Mon, 14 Apr 2025 17:27:03 +0800
Message-Id: <20250414092703.3074906-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD3mzjo1PxninzQCA--.38456S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WryrKw4rWw17XFW8GFyDJrb_yoW8Wr4kpa
	1DGa4FyryUGr1kKrsrZas7Zr98CrWIy34furWrGwn2krZxJ34Yyryjg340ya48JFWkGF48
	X3srXrykWF1kXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbsYFJUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Once cdev_device_add() failed, we should use put_device() to decrement
reference count for cleanup. Or it could cause memory leak. Although
operations in err_free_ida are similar to the operations in callback
function fsi_slave_release(), put_device() is a correct handling
operation as comments require when cdev_device_add() fails.

As comment of device_add() says, 'if device_add() succeeds, you should
call device_del() when you want to get rid of it. If device_add() has
not succeeded, use only put_device() to drop the reference count'.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 371975b0b075 ("fsi/core: Fix error paths on CFAM init")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/fsi/fsi-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 50e8736039fe..c494fc0bd747 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1084,7 +1084,8 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	rc = cdev_device_add(&slave->cdev, &slave->dev);
 	if (rc) {
 		dev_err(&slave->dev, "Error %d creating slave device\n", rc);
-		goto err_free_ida;
+		put_device(&slave->dev);
+		return rc;
 	}
 
 	/* Now that we have the cdev registered with the core, any fatal
@@ -1110,8 +1111,6 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 
 	return 0;
 
-err_free_ida:
-	fsi_free_minor(slave->dev.devt);
 err_free:
 	of_node_put(slave->dev.of_node);
 	kfree(slave);
-- 
2.25.1


