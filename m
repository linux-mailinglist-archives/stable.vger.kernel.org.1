Return-Path: <stable+bounces-203101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BFCCD0DDF
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 17:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6C5D30EEB9B
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 16:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D213587B4;
	Fri, 19 Dec 2025 15:49:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4B1357A54;
	Fri, 19 Dec 2025 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159360; cv=none; b=KbV3Y2KxC0z8G7afvzl8yf1nI8nPqnkLO3t2U4pZbbXpu/lDSlXboK6oBII+wiw+Y3eZP+fDOne2iIoHOHeT2uFjzcos8wJsMzaZoNTqOY5ffNNA3h8RFNXdpNAGB7LVyc94micilJBydWfLnCVd00+v/5/3g/ohEGG5v6csxnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159360; c=relaxed/simple;
	bh=qQz9RwgBslT+g58gNrRKbTwfu8PBxFCNcaNz4G/mb2c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B46rRfpA1lpo7xYv36kQi2a+m+s7D/SrU8tHlRaFWBOSAWM4llHaJk35zqyROF1enC59d6uM92UsmKlT7GLNhHcSaYPxYv8+ERFmS5040H0Po4iSBodC7w7srzpCw+aM3JK5KrQV/18fI/5RvJWXGLWpk0GO7vmNJc/3dmnbar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.209])
	by APP-03 (Coremail) with SMTP id rQCowAAnR97tc0Vp2FY8AQ--.28876S2;
	Fri, 19 Dec 2025 23:49:02 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	sean.anderson@seco.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: ulpi: fix a double free in ulpi_register_interface()
Date: Fri, 19 Dec 2025 23:48:59 +0800
Message-Id: <20251219154859.650819-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnR97tc0Vp2FY8AQ--.28876S2
X-Coremail-Antispam: 1UD129KBjvJXoW7try8Kr47JFyfCF48uFyfJFb_yoW8uF1rpa
	13Ca4ftFyFqr4xuF45ZF48Xa4Y9F47t3yxuFW7Cw42krnrZr9YyF1UJFyYvFy5JFykCF1U
	Ars7Jw48uan8AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUU
	UUU
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBg0BE2lFNrJyvwACs+

If ulpi_register() fails, put_device() is called in ulpi_register(),
kfree() in ulpi_register_interface() will result in a double free.

Also, refactor the device registration sequence to use a unified
put_device() cleanup path, addressing multiple error returns in
ulpi_register().

Found by code review and compiled on ubuntu 20.04.

Fixes: 0a907ee9d95e ("usb: ulpi: Call of_node_put correctly")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/usb/common/ulpi.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index 4a2ee447b213..c81a0cb24067 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -278,6 +278,7 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 	int ret;
 	struct dentry *root;
 
+	device_initialize(&ulpi->dev);
 	ulpi->dev.parent = dev; /* needed early for ops */
 	ulpi->dev.bus = &ulpi_bus;
 	ulpi->dev.type = &ulpi_dev_type;
@@ -287,19 +288,15 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 
 	ret = ulpi_of_register(ulpi);
 	if (ret)
-		return ret;
+		goto err_register;
 
 	ret = ulpi_read_id(ulpi);
-	if (ret) {
-		of_node_put(ulpi->dev.of_node);
-		return ret;
-	}
+	if (ret)
+		goto err_register;
 
-	ret = device_register(&ulpi->dev);
-	if (ret) {
-		put_device(&ulpi->dev);
-		return ret;
-	}
+	ret = device_add(&ulpi->dev);
+	if (ret)
+		goto err_register;
 
 	root = debugfs_create_dir(dev_name(&ulpi->dev), ulpi_root);
 	debugfs_create_file("regs", 0444, root, ulpi, &ulpi_regs_fops);
@@ -308,6 +305,10 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 		ulpi->id.vendor, ulpi->id.product);
 
 	return 0;
+
+err_register:
+	put_device(&ulpi->dev);
+	return ret;
 }
 
 /**
@@ -331,10 +332,8 @@ struct ulpi *ulpi_register_interface(struct device *dev,
 	ulpi->ops = ops;
 
 	ret = ulpi_register(dev, ulpi);
-	if (ret) {
-		kfree(ulpi);
+	if (ret)
 		return ERR_PTR(ret);
-	}
 
 	return ulpi;
 }
-- 
2.25.1


