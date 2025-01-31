Return-Path: <stable+bounces-111788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2F7A23BE8
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 11:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EC377A4272
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 10:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F205199384;
	Fri, 31 Jan 2025 10:07:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A70E136A;
	Fri, 31 Jan 2025 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738318025; cv=none; b=kMcGtdSfHaODhmuPS0j3vPsmVPBBUqLIriesuP6AnHA954KQukEdJ5tmpkv0CF3aLzIq6GT5EROiUp+mShjK+DhaMr6WRQCVntboeLmTO31P50sjf+RX31UaT3dE4vrdq1BrgH2ctWaGCr+2QOo0hSfnxVCe7F03esk7dm3ltu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738318025; c=relaxed/simple;
	bh=Hl1526HVV8YIoo9EGdA+ETaUvPASA+86SqkC0Sp0pAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HS/buJgXcmzredYdx6mnC3Vz/g1DVuZb3mHcpCOHT8EuWOLBcS9eA3H7ASXelCbZARuktlcCzOQpF4cBfA2RDeUG8W/dvF9yNUB1j20wjzal5Kmkpo2yrpao6vXkPXblvolWu1hdus5l3ePKmvCLdMs/qCud5mSRjLvlkGLSTzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.38])
	by gateway (Coremail) with SMTP id _____8BxeeHEoJxnVcdqAA--.17462S3;
	Fri, 31 Jan 2025 18:07:00 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.38])
	by front1 (Coremail) with SMTP id qMiowMCxG8XBoJxngtMyAA--.15397S2;
	Fri, 31 Jan 2025 18:07:00 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	Baoqi Zhang <zhangbaoqi@loongson.cn>
Subject: [PATCH] USB: pci-quirks: Fix HCCPARAMS register error for LS7A EHCI
Date: Fri, 31 Jan 2025 18:06:51 +0800
Message-ID: <20250131100651.343015-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxG8XBoJxngtMyAA--.15397S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7urWrJF1DZrW7Wr47GrWrCrX_yoW8uFWDp3
	WDA3srGFWfJr4Ivw4DK3W5uFy5AF1DCa47Aa47K345XFsxWa18JryDZr43Cry3tFs3uF4j
	vr42k3yxKFnrJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU90b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWU
	XVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x07j5xhLUUUUU=

LS7A EHCI controller doesn't have extended capabilities, so the EECP
(EHCI Extended Capabilities Pointer) field of HCCPARAMS register should
be 0x0, but it reads as 0xa0 now. This is a hardware flaw and will be
fixed in future, now just clear the EECP field to avoid error messages
on boot:

......
[    0.581675] pci 0000:00:04.1: EHCI: unrecognized capability ff
[    0.581699] pci 0000:00:04.1: EHCI: unrecognized capability ff
[    0.581716] pci 0000:00:04.1: EHCI: unrecognized capability ff
[    0.581851] pci 0000:00:04.1: EHCI: unrecognized capability ff
......
[    0.581916] pci 0000:00:05.1: EHCI: unrecognized capability ff
[    0.581951] pci 0000:00:05.1: EHCI: unrecognized capability ff
[    0.582704] pci 0000:00:05.1: EHCI: unrecognized capability ff
[    0.582799] pci 0000:00:05.1: EHCI: unrecognized capability ff
......

Cc: stable@vger.kernel.org
Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/usb/host/pci-quirks.c | 4 ++++
 include/linux/pci_ids.h       | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 1f9c1b1435d8..7e3151400a5e 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -958,6 +958,10 @@ static void quirk_usb_disable_ehci(struct pci_dev *pdev)
 	 * booting from USB disk or using a usb keyboard
 	 */
 	hcc_params = readl(base + EHCI_HCC_PARAMS);
+	if (pdev->vendor == PCI_VENDOR_ID_LOONGSON &&
+	    pdev->device == PCI_DEVICE_ID_LOONGSON_EHCI)
+		hcc_params &= ~(0xffL << 8);
+
 	offset = (hcc_params >> 8) & 0xff;
 	while (offset && --count) {
 		pci_read_config_dword(pdev, offset, &cap);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index de5deb1a0118..74a84834d9eb 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -162,6 +162,7 @@
 
 #define PCI_VENDOR_ID_LOONGSON		0x0014
 
+#define PCI_DEVICE_ID_LOONGSON_EHCI     0x7a14
 #define PCI_DEVICE_ID_LOONGSON_HDA      0x7a07
 #define PCI_DEVICE_ID_LOONGSON_HDMI     0x7a37
 
-- 
2.47.1


