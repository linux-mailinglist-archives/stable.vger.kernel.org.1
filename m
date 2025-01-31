Return-Path: <stable+bounces-111787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8214A23BE1
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 11:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBEA3A98E5
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 10:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EA41922F4;
	Fri, 31 Jan 2025 10:06:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53854136A;
	Fri, 31 Jan 2025 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738318017; cv=none; b=TN7eQnVXsSUh4haNrjzO4f2ZYDzADrTmSqMVX6H382iu8kEMiLzdcb24N0cKVv20ecdkvuh9WfhDS0+qhZqeP9UsEQ/wSCAJtRmMPmeJyMnmjj2DWrKrbivPGUH+9d5a248ipbAmpauX6eOT3rvo1NN0s1z+Ho0p7bTTjkwB6Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738318017; c=relaxed/simple;
	bh=hR1PJk5Vtg0pStm2OBnAppLW5Z9iaWW+/qQ2rU7s24o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V7BPZHHu6ed5JYOTlvLNvmVnoAuQbpB/lb/dsYu5u48OWiRL228LmwHb2WM5aKaaq0m0dSu3PJpZbojtaDaEPuht3nGHEo7awvMBv9YVsvfQFMd2NX2mE8JZ3rLJvzE4qg5QYD2VeCpaUSTZVclxqbcU0qsIHrk+HDGaBoMjFDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.38])
	by gateway (Coremail) with SMTP id _____8DxGeGzoJxnUcdqAA--.11878S3;
	Fri, 31 Jan 2025 18:06:43 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.38])
	by front1 (Coremail) with SMTP id qMiowMDxK8WvoJxnc9MyAA--.15387S2;
	Fri, 31 Jan 2025 18:06:42 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH] USB: core: Enable root_hub's remote wakeup for wakeup sources
Date: Fri, 31 Jan 2025 18:06:30 +0800
Message-ID: <20250131100630.342995-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxK8WvoJxnc9MyAA--.15387S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw4DWF4xGr4xXFW5uFy8WFX_yoW8GFyrp3
	4xC34Fkr4kWryxCa1qg3W8X3WUJa1xtFWUGFZa939rXw13Z34vkFy8A34FqayDtrnYqFW5
	tF43X34YgFyUCFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU

Now we only enable the remote wakeup function for the USB wakeup source
itself at usb_port_suspend(). But on pre-XHCI controllers this is not
enough to enable the S3 wakeup function for USB keyboards, so we also
enable the root_hub's remote wakeup (and disable it on error). Frankly
this is unnecessary for XHCI, but enable it unconditionally make code
simple and seems harmless.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/usb/core/hub.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index c3f839637cb5..efd6374ccd1d 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3480,6 +3480,7 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
 			if (PMSG_IS_AUTO(msg))
 				goto err_wakeup;
 		}
+		usb_enable_remote_wakeup(udev->bus->root_hub);
 	}
 
 	/* disable USB2 hardware LPM */
@@ -3543,8 +3544,10 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
 		/* Try to enable USB2 hardware LPM again */
 		usb_enable_usb2_hardware_lpm(udev);
 
-		if (udev->do_remote_wakeup)
+		if (udev->do_remote_wakeup) {
 			(void) usb_disable_remote_wakeup(udev);
+			(void) usb_disable_remote_wakeup(udev->bus->root_hub);
+		}
  err_wakeup:
 
 		/* System sleep transitions should never fail */
-- 
2.47.1


