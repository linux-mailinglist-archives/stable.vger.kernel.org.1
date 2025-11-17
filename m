Return-Path: <stable+bounces-194909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFF7C62009
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 02:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87B8735D038
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 01:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB61823D28C;
	Mon, 17 Nov 2025 01:35:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C24E23F26A;
	Mon, 17 Nov 2025 01:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763343302; cv=none; b=UAc6v1fLyDFksfI6kAZxYe5BaH0zHgJ3VbTZyHQGHLPXhCm7GtY5p/JWG6ES454ZFUKvVphrWDGjU+I1OSKyTNVMlXQvJf3DfzzmbZrfEaalULNgbPVjiV1Jw252UmdsB06GJR+K1GuLLVwL9DsAUuta8Vi8UZD2pqN4J/OQruA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763343302; c=relaxed/simple;
	bh=YR0JE0NXqs8+tcKOsSAlU2ZlbyfFSpFgZTnKfqti5G8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=H0Q08Kwwrig4hS9KBaIRaU500NtkUm1rs0nKhZ6SwBi4V5i8Jp87tIDSaoYuLtqKlmWTodIXvZecH00yql5Zy//mxamam/gooLoY8ZMdeqdo50RlWk6w3KYSDDSsJJpNObYVYOsetzFEOf85Vku7AX9Y3WpBtsHGgETGTwqo0Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-05 (Coremail) with SMTP id zQCowADn4GGlexppPSADAQ--.76S2;
	Mon, 17 Nov 2025 09:34:38 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: stern@rowland.harvard.edu,
	vz@mleia.com,
	piotr.wojtaszczyk@timesys.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	stigge@antcom.de
Cc: linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] USB: ohci-nxp: Fix error handling in ohci-hcd-nxp driver
Date: Mon, 17 Nov 2025 09:34:28 +0800
Message-Id: <20251117013428.21840-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:zQCowADn4GGlexppPSADAQ--.76S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWxCF13XrWUJr4kAr4fZrb_yoW8uFy7pF
	nrWa4YkFyDG3yIg3y3AF17XFyIkw47t3yrt3y7Gw17Wan0y3sIvFyvkFyjvF43XrWkGr1F
	9an8t3yYyw4UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4
	vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmQ6LU
	UUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

When obtaining the ISP1301 I2C client through the device tree, the
driver does not release the device reference in the probe failure path
or in the remove function. This could cause a reference count leak,
which may prevent the device from being properly unbound or freed,
leading to resource leakage.

Fix this by storing whether the client was obtained via device tree
and only releasing the reference in that case.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 73108aa90cbf ("USB: ohci-nxp: Use isp1301 driver")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- only released the device reference when the ISP1301 client was obtained through device tree, not in the non-DT case where the global variable is used;
- removed unnecessary NULL checks as suggested by reviewer.
---
 drivers/usb/host/ohci-nxp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
index 24d5a1dc5056..081b8c7f21a0 100644
--- a/drivers/usb/host/ohci-nxp.c
+++ b/drivers/usb/host/ohci-nxp.c
@@ -50,6 +50,7 @@ static const char hcd_name[] = "ohci-nxp";
 static struct hc_driver __read_mostly ohci_nxp_hc_driver;
 
 static struct i2c_client *isp1301_i2c_client;
+static bool isp1301_using_dt;
 
 static void isp1301_configure_lpc32xx(void)
 {
@@ -161,6 +162,7 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 	} else {
 		isp1301_node = NULL;
 	}
+	isp1301_using_dt = (isp1301_node != NULL);
 
 	isp1301_i2c_client = isp1301_get_client(isp1301_node);
 	of_node_put(isp1301_node);
@@ -223,6 +225,8 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 fail_resource:
 	usb_put_hcd(hcd);
 fail_disable:
+	if (isp1301_using_dt)
+		put_device(&isp1301_i2c_client->dev);
 	isp1301_i2c_client = NULL;
 	return ret;
 }
@@ -234,6 +238,8 @@ static void ohci_hcd_nxp_remove(struct platform_device *pdev)
 	usb_remove_hcd(hcd);
 	ohci_nxp_stop_hc();
 	usb_put_hcd(hcd);
+	if (isp1301_using_dt)
+		put_device(&isp1301_i2c_client->dev);
 	isp1301_i2c_client = NULL;
 }
 
-- 
2.17.1


