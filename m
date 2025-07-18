Return-Path: <stable+bounces-163348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFA6B09F79
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 11:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D82C7B9FAC
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 09:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936D8298258;
	Fri, 18 Jul 2025 09:25:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D006207DF7;
	Fri, 18 Jul 2025 09:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830728; cv=none; b=oESBms2n24zTftTSn9eqYEp/mKhoXmjPmSZWZ+UzsILHtVCjUy5l3VNxQtcRdbgBN3sHKn9mAqgl9NUryuY0VJ242x+XzwJec4PNtaFWj2g6stEFN0kH14gatDzV2iUXZdxz1R9rniE2Nz1epye+OALyzc1ZbiPCESBX3yFlTHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830728; c=relaxed/simple;
	bh=p8L/crSaIvP89HYdkhQRcIOEzvOeFkDY8nSCAWshkQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hx/dlU8hdOw9nEaRXoOEGPJ5aU86KyBIeH1zB9ga3ZscKIqGAj3Tb3EWXwZ/UGiNyt89yC9Ctx7sdHHBCkrgidNRIPzcLC/UqcFpxRPdHib+W1/zb/cA1jGJKgeoUrk/7vGXNx4kQ3U7JBtR+p087Sv3cbKFVSq0SKObfMy5+g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [211.71.28.34])
	by APP-03 (Coremail) with SMTP id rQCowADHIYPoEnpoxyYuBQ--.12146S2;
	Fri, 18 Jul 2025 17:25:05 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: eajames@linux.ibm.com,
	ninad@linux.ibm.com,
	jk@ozlabs.org,
	joel@jms.id.au
Cc: akpm@linux-foundation.org,
	linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] fsi/core: fix error handling in fsi_slave_init()
Date: Fri, 18 Jul 2025 17:24:55 +0800
Message-Id: <20250718092455.3402609-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADHIYPoEnpoxyYuBQ--.12146S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WryrKw4rWw17XFW8GFyDJrb_yoW8Wr4kpa
	1DGa4FyryUGr1kKrsrZas7Zr98CrWIy34furWrGwn2krZxJ34Yyryjg340ya48JFWkGF48
	X3srXrykWF1kXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUeF4EDUUUU
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


