Return-Path: <stable+bounces-118406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E67DA3D57D
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 10:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74791697CD
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 09:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F051F03F1;
	Thu, 20 Feb 2025 09:52:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE621E9912;
	Thu, 20 Feb 2025 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045176; cv=none; b=IvLB0hlrQ19ZD0a47EFzCgHDvv3+Ahx2fr1mPA/qHJzplfKaqtxn8PgfTONnnp5IsF/MboO7AA1SPgK7yGpNbYXfh6Q8o44iUY4V5ewNMlkmmrUWvhHUHIGTU8M9Ulba5JMCoA5OZ6Rwbm2n7oLhZuEE1kERM6d5Hor0OLkaIIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045176; c=relaxed/simple;
	bh=p3jUliwfLRPcDyQ9R4QDPtRJjUXusVtL9hqIDKIUrGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1HDN0Ksl4WzK5bIRsM9Q4ChzGptJPTm/5b+NtRz3yvTPWXu2buvBTDA/U8L82Dc4kGSFwHtbY5N1BFrehcnvXpLLznASLUWxZGLpwIqa9rf1judliIOgwhXqQxD41eRUQN9i/H6lMDfLWisKmozXLQRXHxzIGTfjFk62ytv4/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowAD3n_pj+7Zn_87hDg--.4050S2;
	Thu, 20 Feb 2025 17:52:40 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: stern@rowland.harvard.edu,
	christophe.jaillet@wanadoo.fr,
	mka@chromium.org,
	make_ruc2021@163.com,
	javier.carrasco@wolfvision.net,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: core: Add error handling in usb_reset_device for autoresume failure
Date: Thu, 20 Feb 2025 17:52:18 +0800
Message-ID: <20250220095218.970-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAD3n_pj+7Zn_87hDg--.4050S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zry8Wr48GrWxtFWxCrW5trb_yoW8GF1fpw
	48Aayqkry8Gr1rCa1jy34kuFy5Zw4Sy3y3JF93Ww1Igr97A345JFyrAFy3ta4rArZ5tF9x
	tFW3K3yF9Fy7AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjAsqtUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwsTA2e22-l9yQAAsb

In usb_reset_device(),  the function continues execution and
calls usb_autosuspend_device() after usb_autosuspend_device fails.

To fix this, add error handling for usb_autoresume_device()
and return the error code immediately. This ensures that
usb_autosuspend_device() is not called when usb_autoresume_device()
fails, maintaining device state consistency.

Fixes: 94fcda1f8ab5 ("usbcore: remove unused argument in autosuspend")
Cc: stable@vger.kernel.org # 2.6.20+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/core/hub.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 21ac9b464696..f2efdbdd1533 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -6292,7 +6292,9 @@ int usb_reset_device(struct usb_device *udev)
 	noio_flag = memalloc_noio_save();
 
 	/* Prevent autosuspend during the reset */
-	usb_autoresume_device(udev);
+	ret = usb_autoresume_device(udev);
+	if (ret < 0)
+		goto error_autoresume;
 
 	if (config) {
 		for (i = 0; i < config->desc.bNumInterfaces; ++i) {
@@ -6341,6 +6343,7 @@ int usb_reset_device(struct usb_device *udev)
 	}
 
 	usb_autosuspend_device(udev);
+error_autoresume:
 	memalloc_noio_restore(noio_flag);
 	udev->reset_in_progress = 0;
 	return ret;
-- 
2.42.0.windows.2


