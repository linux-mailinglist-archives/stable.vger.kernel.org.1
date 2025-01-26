Return-Path: <stable+bounces-110712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED3EA1CBA6
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8619B7A19EE
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECAC1F55FA;
	Sun, 26 Jan 2025 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfSJ2LEZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8C11A4F3C;
	Sun, 26 Jan 2025 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903895; cv=none; b=G/M9Yr2WGocLKV4qkWYVldBkl5rCrCyDjZBjzP0+abV2gBetf/mvSEyAn5BLHm1O2pL4Jk0AFZhE84Z0/V29IIR8g08ACQ1HVYo0TeDnk6UgzsZjxSehS5VEJJb36ExdN1fduxxEVH8L3G7athNlXm39ANqrSxhSdKZKoAJcX2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903895; c=relaxed/simple;
	bh=SQWxZ0GpT3SqsCUOP+1nWRk1TGrxcTuMZnr9kQ2VdSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZjNZXDW6RFHtaEGt4oaMpSLcX1R9xbfcXYcx6uCeMKLKXv0wODsjYkMEg4DIDgQVKhctsyidG84a5zsAR37w8eNc+WpHBoPaWT+UnBvijF8H4MNh3dKkrjh75rG6AxbLSF0BvcL2Ce5MV2NevFeTlNaNh6zeuvBZtfoeehozsfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfSJ2LEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B1AC4CEE3;
	Sun, 26 Jan 2025 15:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903894;
	bh=SQWxZ0GpT3SqsCUOP+1nWRk1TGrxcTuMZnr9kQ2VdSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfSJ2LEZAxiNjF5bPV1R0nMVN1N1/shaIU00wZizkL76K+aujLm0XAtvjCGwJRqX1
	 vUYt5vv9bnwnOPAM+DxzvqEnpzipU++UfXl6ipUVMB+CXMV0R92BcvmJNIZAzeBwkL
	 6QRaYqhZFFfG9eXe7tu3Z7zrLR3FLFFL1fs0AIgnZgB4DDwylru8zCdi2lhyTYY+R2
	 1jG4+AW6eSqm54NpIQjNpaMr0OLNKgVV18UACyVNWw8kT+bYS8lFNAmC/YiZEzpcN4
	 K1A8UHx3rf+NxZ85Z9CXG9amhH5M5G6Mi+5IuM7F3/0dcOD78QvKOLXH8KLrOTuhmn
	 v9s5rQdx0xQCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	m.chetan.kumar@intel.com,
	loic.poulain@linaro.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 11/14] net: wwan: iosm: Fix hibernation by re-binding the driver around it
Date: Sun, 26 Jan 2025 10:04:27 -0500
Message-Id: <20250126150430.958708-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150430.958708-1-sashal@kernel.org>
References: <20250126150430.958708-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.177
Content-Transfer-Encoding: 8bit

From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>

[ Upstream commit 0b6f6593aa8c3a05f155c12fd0e7ad33a5149c31 ]

Currently, the driver is seriously broken with respect to the
hibernation (S4): after image restore the device is back into
IPC_MEM_EXEC_STAGE_BOOT (which AFAIK means bootloader stage) and needs
full re-launch of the rest of its firmware, but the driver restore
handler treats the device as merely sleeping and just sends it a
wake-up command.

This wake-up command times out but device nodes (/dev/wwan*) remain
accessible.
However attempting to use them causes the bootloader to crash and
enter IPC_MEM_EXEC_STAGE_CD_READY stage (which apparently means "a crash
dump is ready").

It seems that the device cannot be re-initialized from this crashed
stage without toggling some reset pin (on my test platform that's
apparently what the device _RST ACPI method does).

While it would theoretically be possible to rewrite the driver to tear
down the whole MUX / IPC layers on hibernation (so the bootloader does
not crash from improper access) and then re-launch the device on
restore this would require significant refactoring of the driver
(believe me, I've tried), since there are quite a few assumptions
hard-coded in the driver about the device never being partially
de-initialized (like channels other than devlink cannot be closed,
for example).
Probably this would also need some programming guide for this hardware.

Considering that the driver seems orphaned [1] and other people are
hitting this issue too [2] fix it by simply unbinding the PCI driver
before hibernation and re-binding it after restore, much like
USB_QUIRK_RESET_RESUME does for USB devices that exhibit a similar
problem.

Tested on XMM7360 in HP EliteBook 855 G7 both with s2idle (which uses
the existing suspend / resume handlers) and S4 (which uses the new code).

[1]: https://lore.kernel.org/all/c248f0b4-2114-4c61-905f-466a786bdebb@leemhuis.info/
[2]:
https://github.com/xmm7360/xmm7360-pci/issues/211#issuecomment-1804139413

Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Link: https://patch.msgid.link/e60287ebdb0ab54c4075071b72568a40a75d0205.1736372610.git.mail@maciej.szmigiero.name
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wwan/iosm/iosm_ipc_pcie.c | 56 ++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_pcie.c b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
index 8b4222b137d14..968ca9ff21df1 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_pcie.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
@@ -6,6 +6,7 @@
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/module.h>
+#include <linux/suspend.h>
 #include <net/rtnetlink.h>
 
 #include "iosm_ipc_imem.h"
@@ -18,6 +19,7 @@ MODULE_LICENSE("GPL v2");
 /* WWAN GUID */
 static guid_t wwan_acpi_guid = GUID_INIT(0xbad01b75, 0x22a8, 0x4f48, 0x87, 0x92,
 				       0xbd, 0xde, 0x94, 0x67, 0x74, 0x7d);
+static bool pci_registered;
 
 static void ipc_pcie_resources_release(struct iosm_pcie *ipc_pcie)
 {
@@ -484,7 +486,6 @@ static struct pci_driver iosm_ipc_driver = {
 	},
 	.id_table = iosm_ipc_ids,
 };
-module_pci_driver(iosm_ipc_driver);
 
 int ipc_pcie_addr_map(struct iosm_pcie *ipc_pcie, unsigned char *data,
 		      size_t size, dma_addr_t *mapping, int direction)
@@ -566,3 +567,56 @@ void ipc_pcie_kfree_skb(struct iosm_pcie *ipc_pcie, struct sk_buff *skb)
 	IPC_CB(skb)->mapping = 0;
 	dev_kfree_skb(skb);
 }
+
+static int pm_notify(struct notifier_block *nb, unsigned long mode, void *_unused)
+{
+	if (mode == PM_HIBERNATION_PREPARE || mode == PM_RESTORE_PREPARE) {
+		if (pci_registered) {
+			pci_unregister_driver(&iosm_ipc_driver);
+			pci_registered = false;
+		}
+	} else if (mode == PM_POST_HIBERNATION || mode == PM_POST_RESTORE) {
+		if (!pci_registered) {
+			int ret;
+
+			ret = pci_register_driver(&iosm_ipc_driver);
+			if (ret) {
+				pr_err(KBUILD_MODNAME ": unable to re-register PCI driver: %d\n",
+				       ret);
+			} else {
+				pci_registered = true;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static struct notifier_block pm_notifier = {
+	.notifier_call = pm_notify,
+};
+
+static int __init iosm_ipc_driver_init(void)
+{
+	int ret;
+
+	ret = pci_register_driver(&iosm_ipc_driver);
+	if (ret)
+		return ret;
+
+	pci_registered = true;
+
+	register_pm_notifier(&pm_notifier);
+
+	return 0;
+}
+module_init(iosm_ipc_driver_init);
+
+static void __exit iosm_ipc_driver_exit(void)
+{
+	unregister_pm_notifier(&pm_notifier);
+
+	if (pci_registered)
+		pci_unregister_driver(&iosm_ipc_driver);
+}
+module_exit(iosm_ipc_driver_exit);
-- 
2.39.5


