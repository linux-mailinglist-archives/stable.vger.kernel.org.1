Return-Path: <stable+bounces-188946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC0ABFB1F9
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 11:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8CC55061C7
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 09:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC993101BA;
	Wed, 22 Oct 2025 09:18:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E162571A0;
	Wed, 22 Oct 2025 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124718; cv=none; b=sSFytcDJkVIVvmJxkrOLt2AnqqjbqaL0PR8yJNhLRh9CcEcIVLuHjRDbdWchrIe9wa+YuciLN3BKMh666iDm9T+eInLTyGpse3IDnTPG++aX0FQ5IkXOxtBtS25c2TPVWarELMMgT0BBA3gO8bcDNmLGa0I4zOEgOjhf9z/xYVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124718; c=relaxed/simple;
	bh=iFDCalLskXW9rVP0zzspDtQbMZaXfTw4fPS+22BIkQ0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=uUTAVzPd6NUXbpch/p2JQF4gPAlm/zdbssnntjmpvT37fP/pyUtQKua78P4DBiuXPpwpPeOOjOlXi+sH5F0GiSzAq7o8HcQnU2EN3DMXexRzBhyiROZq7ST86GLGQ5brqsh1c0kd3iR+6ZP25fgisIuMeDZtpcmoxXuaBFufl/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-01 (Coremail) with SMTP id qwCowADXK55Qofhopw_aEw--.35253S2;
	Wed, 22 Oct 2025 17:18:21 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: eajames@linux.ibm.com,
	ninad@linux.ibm.com,
	joel@jms.id.au,
	jk@ozlabs.org
Cc: linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] fsi/core: fix error handling in fsi_slave_init()
Date: Wed, 22 Oct 2025 17:18:07 +0800
Message-Id: <20251022091807.3300-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:qwCowADXK55Qofhopw_aEw--.35253S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WryrKw4rWw17XFW8GFyDJrb_yoW8Wr4kpa
	1DGa4FyrWUGr1kKrsrZas7ZF98C3yIv34furWrGwn2krZxXr90vryjg340ya48JFWkCF48
	X3srXrykW3WDXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjWxR3UUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

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
index c6c115993ebc..444878ab9fb1 100644
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
2.17.1


