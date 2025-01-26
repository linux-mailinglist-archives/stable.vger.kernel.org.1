Return-Path: <stable+bounces-110629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55584A1CAD8
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C9F3AA5B5
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF69B205AD9;
	Sun, 26 Jan 2025 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L75ISMAw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870F3205ACF;
	Sun, 26 Jan 2025 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903715; cv=none; b=O089S7thRmXLXcak5avGLBZYWcslNoH7jV0GlNWWO9nKGn6mEEiSnfx6EMUIWx0tUyA7ZsJmynOrJlg++11gWY8sPgkUDf/Gk+0Oz8+QzkZZLHCau4guMV8J6/QrQD3VXVQCYup3shlpxct6MhpPjYkph5tRqRB42QGxd6bT28k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903715; c=relaxed/simple;
	bh=6WDegq0g+rvUu4CoGCs63VWBKLiD07QZv1qR80IXc9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mpC2pU0LKjsXAmOdrcmrey9FJf4MsNhELbsietq3/0Kd9qOO1nV/rxlwJ0S6UlmHGYUdcV88qTdGOFD3nMgdjLkxM9AaxQinQatWUco5ftqDUW/b+DsY0s/uU2h2iAMo3xGTVnYi6XE4Y8MVl1YUXtKr8stSajx+E75qoGg6NmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L75ISMAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A302C4CED3;
	Sun, 26 Jan 2025 15:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903715;
	bh=6WDegq0g+rvUu4CoGCs63VWBKLiD07QZv1qR80IXc9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L75ISMAw+xsBAAzZo6DX72s8qXqUn6LUkOZp35zNDStcV55z7dz5pKPFpaEvT+h+m
	 5nocfBQdNFCfcblNI15MvHR7gdjuu4q45cMeEoEKx1QXScNKZSTbJrcvMoZTxCO1B3
	 pkBnaBj0o4hcY0DWUKnU28nbInR12OCHiCTOONTsmRlpGxD1G2shqDCkSdHtvx2RoV
	 iPsGONokd0VwDcEiKyLGmuET95cV6C5wU4srYYLr+aijlrKpnBLl7uJL1caiDOp1hH
	 SYLDemiUcjGapShg4cRi1OBj4kPHSYet9WWQah61gC/H15I4gOtGs5I6jn6nyaYV7D
	 nqbsHcDEx9L0g==
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
Subject: [PATCH AUTOSEL 6.13 28/35] net: wwan: iosm: Fix hibernation by re-binding the driver around it
Date: Sun, 26 Jan 2025 10:00:22 -0500
Message-Id: <20250126150029.953021-28-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150029.953021-1-sashal@kernel.org>
References: <20250126150029.953021-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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
index 04517bd3325a2..a066977af0be5 100644
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
@@ -448,7 +450,6 @@ static struct pci_driver iosm_ipc_driver = {
 	},
 	.id_table = iosm_ipc_ids,
 };
-module_pci_driver(iosm_ipc_driver);
 
 int ipc_pcie_addr_map(struct iosm_pcie *ipc_pcie, unsigned char *data,
 		      size_t size, dma_addr_t *mapping, int direction)
@@ -530,3 +531,56 @@ void ipc_pcie_kfree_skb(struct iosm_pcie *ipc_pcie, struct sk_buff *skb)
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


