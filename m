Return-Path: <stable+bounces-204190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F12CE8F3F
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 09:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2736301EC68
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 08:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89152FFF94;
	Tue, 30 Dec 2025 08:00:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED22A24290D;
	Tue, 30 Dec 2025 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767081631; cv=none; b=ZU87ugjES9ujoaXpiifCmd7n9DrsIez9oc5DkXwXLyd3aYoGoLBp0PiVN+54K1U3o2KIVIYXCKJ69QBMQFakxubUJzq+pfSHJEhkj7H0SAhI2zgu8HJY0piO+gUMGHnXO6V/7hVV2V74W9Gt4ugmm7v8M59oR0hC8SSc6/4qhaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767081631; c=relaxed/simple;
	bh=C/pJ1nbvKCwDxoBTTpWf9GnAjkzJ0eeL2Bl+dIWBlZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fhoLNYml6zCSKxTSImZ4KBZcpykdqnkhk8qrU9CDztvr3GiriLMAmyRhnMwXTsxCV4myfOmHK8KIdFoyOlAw5KuLkfxpR/qjKVpDI+DsT1RHgGJWAPtomlh9HXek/agafQdv64gSKq9efX5DkASoGrPMaXkGvDuY/CUZL46BSXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.1])
	by gateway (Coremail) with SMTP id _____8Bx28KbhlNpz1YEAA--.13358S3;
	Tue, 30 Dec 2025 16:00:27 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.1])
	by front1 (Coremail) with SMTP id qMiowJBxrsKWhlNp8aEGAA--.6361S2;
	Tue, 30 Dec 2025 16:00:26 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	Shengwen Xiao <atzlinux@sina.com>
Subject: [PATCH] USB: OHCI/UHCI: Add soft dependencies on ehci_hcd
Date: Tue, 30 Dec 2025 16:00:14 +0800
Message-ID: <20251230080014.3934590-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxrsKWhlNp8aEGAA--.6361S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF4fuF43JFWfuF1rZF4DJrc_yoW8XF1UpF
	45Xr18ur1fGrW7XrZ8AasrW3WrK3Zrtry5uayIg3y8urWjy34DXF10yFWfWwnxXw47Ww12
	qF4v9r9rW3yvkFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU8EeHDUUUUU==

Commit 9beeee6584b9aa4f ("USB: EHCI: log a warning if ehci-hcd is not
loaded first") said that ehci-hcd should be loaded before ohci-hcd and
uhci-hcd. However, commit 05c92da0c52494ca ("usb: ohci/uhci - add soft
dependencies on ehci_pci") only makes ohci-pci/uhci-pci depend on ehci-
pci, which is not enough and we may still see the warnings in boot log.
So fix it by also making ohci-hcd/uhci-hcd depend on ehci-hcd.

Cc: stable@vger.kernel.org
Reported-by: Shengwen Xiao <atzlinux@sina.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/usb/host/ohci-hcd.c | 1 +
 drivers/usb/host/uhci-hcd.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 9c7f3008646e..549c965b7fbe 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1355,4 +1355,5 @@ static void __exit ohci_hcd_mod_exit(void)
 	clear_bit(USB_OHCI_LOADED, &usb_hcds_loaded);
 }
 module_exit(ohci_hcd_mod_exit);
+MODULE_SOFTDEP("pre: ehci_hcd");
 
diff --git a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
index 14e6dfef16c6..e1a27d01bdbc 100644
--- a/drivers/usb/host/uhci-hcd.c
+++ b/drivers/usb/host/uhci-hcd.c
@@ -939,3 +939,4 @@ module_exit(uhci_hcd_cleanup);
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
+MODULE_SOFTDEP("pre: ehci_hcd");
-- 
2.47.3


