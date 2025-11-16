Return-Path: <stable+bounces-194847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 164A3C60E30
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 02:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 708794E549B
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 01:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635D61A9B58;
	Sun, 16 Nov 2025 01:06:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0D635CBC5;
	Sun, 16 Nov 2025 01:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763255218; cv=none; b=dJ+E0BHXOJ9vim315BwyLSIiBz3NZt3QKFKefFlI32CgXIHyILVkaiDTVCfFDzIb4aVmGpPcDGoqtx5AjGN1/ACopRMgHLJYwUixwkGGRh+1Yb/UPwHDYHImvvkyYffm6gNmczVhZGQL6lO/k1bsYEqPfsm2me1XC6h+q3T1s78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763255218; c=relaxed/simple;
	bh=pMBoikwlcqXhtgGzOZuJ7pt3ACAMyLeq9gNXtcVyVyM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tbTgV1KHYgJpDPopBs/X8Vt1Mjhi8h1WFUvPcZ54fCftEyXEVo0cTQ5EGvb3Jg5nsK1zJZIcxju0hmOO4KafzLvMvmgJUxwsu7l5PyahKzSmeZzuufFopEJxVb9BLJsnuCd+0UdyPlCKhOYdAzyGyahpL2j50KJrw3lmqBnVq8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowAAXqNqMIxlpksTpAA--.20173S2;
	Sun, 16 Nov 2025 09:06:23 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: stern@rowland.harvard.edu,
	vz@mleia.com,
	piotr.wojtaszczyk@timesys.com,
	gregkh@linuxfoundation.org,
	stigge@antcom.de,
	arnd@arndb.de
Cc: linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] USB: ohci-nxp: Fix error handling in ohci-hcd-nxp driver
Date: Sun, 16 Nov 2025 09:06:13 +0800
Message-Id: <20251116010613.7966-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:rQCowAAXqNqMIxlpksTpAA--.20173S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrW7urW5KF1UKrWUGF1ftFb_yoW8GrykpF
	47XFyjkFyUGw4293y3CF13Xa40kw42v34rKw17Gw17Wan0v34qvFyvyF1FvF43XFWkGrWF
	ga1Dt34jyr4UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
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
leading to resource leakage. Add put_device() to release the reference
in the probe failure path and in the remove function.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 73108aa90cbf ("USB: ohci-nxp: Use isp1301 driver")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/usb/host/ohci-nxp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
index 24d5a1dc5056..f79558ef0b45 100644
--- a/drivers/usb/host/ohci-nxp.c
+++ b/drivers/usb/host/ohci-nxp.c
@@ -223,6 +223,8 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 fail_resource:
 	usb_put_hcd(hcd);
 fail_disable:
+	if (isp1301_i2c_client)
+		put_device(&isp1301_i2c_client->dev);
 	isp1301_i2c_client = NULL;
 	return ret;
 }
@@ -234,6 +236,8 @@ static void ohci_hcd_nxp_remove(struct platform_device *pdev)
 	usb_remove_hcd(hcd);
 	ohci_nxp_stop_hc();
 	usb_put_hcd(hcd);
+	if (isp1301_i2c_client)
+		put_device(&isp1301_i2c_client->dev);
 	isp1301_i2c_client = NULL;
 }
 
-- 
2.17.1


