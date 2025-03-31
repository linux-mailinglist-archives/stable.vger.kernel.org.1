Return-Path: <stable+bounces-127038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2661A762FF
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 11:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845ED169006
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 09:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EDA1D90AD;
	Mon, 31 Mar 2025 09:13:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F65A155A30;
	Mon, 31 Mar 2025 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743412424; cv=none; b=fPq/RQ/XbkHeJQROKp9X9JbYJSBLKnfwKf+bQUt8NckUCFptrqJKhpDIlGPZ1xsmOcSAKjR3TL+LKWet1M4kBsEyhPV8w3uYetroaqeaEEd7JZ0ceZm3BHsFeXjW13d9Z1/V2fnokgPvEamD53n2RgxoSzBLiyI+Im47cJp9+oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743412424; c=relaxed/simple;
	bh=Lg/kjQ8+BXnYP2pnKclvS2rFLRLs9Np0/eWDe1t6oRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MXGoG87BX+sHvRUHibCE6tCAN2Vz+/U7Dwx5Jps4S8GC/mX0SOMf8/m15e3vI1908urvTF2R/yNXn3foxMRA1gLdRFGYVpCjVtQ6KpLL1J6XCzCgdK3mzta4LG7MNYKHC0EXcUcjEDZ0al23fIF/W5wmMmdqxklAu/2w5ocLYwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowABHhw+oXOpn3vw8BA--.61420S2;
	Mon, 31 Mar 2025 17:13:21 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: eajames@linux.ibm.com,
	ninad@linux.ibm.com,
	jk@ozlabs.org,
	joel@jms.id.au
Cc: linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] fsi/core: fix error handling in fsi_slave_init()
Date: Mon, 31 Mar 2025 17:13:11 +0800
Message-Id: <20250331091311.2233000-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHhw+oXOpn3vw8BA--.61420S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WryrKw4rWw17XFW8GFyDJrb_yoW8Wr4kpa
	1DGa4FyrWUGr1kKrsrZas7Z3s8CrWIv34furW8Gw1IkrZxX34Yyryjg340ya48JaykJF48
	Xr9rXrykWF1DXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUQvtAUUUUU=
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
index e2e1e9df6115..1373e05e3659 100644
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


