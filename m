Return-Path: <stable+bounces-185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C1C7F7506
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185D2281B5C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA98286AF;
	Fri, 24 Nov 2023 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AYDzgSXq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133F528DC8
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9294AC43391;
	Fri, 24 Nov 2023 13:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700832529;
	bh=myxorxAQdolB9IM2uCNIguxAT9XaXngbW1/a444hDnU=;
	h=Subject:To:Cc:From:Date:From;
	b=AYDzgSXqsmRozAUi9CzLOv1fvDUDo8MVtKH+15i1o02uXf1972SCfut9/3M598XF9
	 X7UqkW0yeRToBuYwCfG/yEHqBY/wXiJmzcvDAhE9lf7yj6qbI33BMDwYd1Ee+oIWNi
	 tIgos4DGwxwkRme6vXCx72fvV0rCaTpAI38LLwFE=
Subject: FAILED: patch "[PATCH] r8169: add handling DASH when DASH is disabled" failed to apply to 5.10-stable tree
To: hau@realtek.com,hkallweit1@gmail.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 13:28:45 +0000
Message-ID: <2023112445-stung-palpable-15d2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0ab0c45d8aaea5192328bfa6989673aceafc767c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112445-stung-palpable-15d2@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

0ab0c45d8aae ("r8169: add handling DASH when DASH is disabled")
cf2ffdea0839 ("r8169: revert 2ab19de62d67 ("r8169: remove ASPM restrictions now that ASPM is disabled during NAPI poll")")
162d626f3013 ("r8169: fix ASPM-related problem for chip version 42 and 43")
2ab19de62d67 ("r8169: remove ASPM restrictions now that ASPM is disabled during NAPI poll")
49ef7d846d4b ("r8169: prepare rtl_hw_aspm_clkreq_enable for usage in atomic context")
6bc6c4e6893e ("r8169: use spinlock to protect access to registers Config2 and Config5")
91c8643578a2 ("r8169: use spinlock to protect mac ocp register access")
ad425666a1f0 ("r8169: move rtl_wol_enable_rx() and rtl_prepare_power_down()")
c9ae520ac3fa ("r8169: remove rtl_wol_shutdown_quirk()")
7e04a111cde2 ("r8169: merge handling of chip versions 12 and 17 (RTL8168B)")
efc37109c780 ("r8169: remove support for chip version 60")
133706a960de ("r8169: remove support for chip version 50")
8a1ab0c4028d ("r8169: remove support for chip version 49")
ebe598985711 ("r8169: remove support for chip versions 45 and 47")
44307b27de2e ("r8169: remove support for chip version 41")
54744510fa9c ("r8169: improve driver unload and system shutdown behavior on DASH-enabled systems")
68650b4e6c13 ("r8169: support L1.2 control on RTL8168h")
c217ab7a3961 ("r8169: enable ASPM L1.2 if system vendor flags it as safe")
8fe6e670640e ("r8169: use new PM macros")
4b5f82f6aaef ("r8169: enable ASPM L1/L1.1 from RTL8168h")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0ab0c45d8aaea5192328bfa6989673aceafc767c Mon Sep 17 00:00:00 2001
From: ChunHao Lin <hau@realtek.com>
Date: Fri, 10 Nov 2023 01:33:59 +0800
Subject: [PATCH] r8169: add handling DASH when DASH is disabled

For devices that support DASH, even DASH is disabled, there may still
exist a default firmware that will influence device behavior.
So driver needs to handle DASH for devices that support DASH, no
matter the DASH status is.

This patch also prepares for "fix network lost after resume on DASH
systems".

Fixes: ee7a1beb9759 ("r8169:call "rtl8168_driver_start" "rtl8168_driver_stop" only when hardware dash function is enabled")
Cc: stable@vger.kernel.org
Signed-off-by: ChunHao Lin <hau@realtek.com>
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://lore.kernel.org/r/20231109173400.4573-2-hau@realtek.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 0c76c162b8a9..cfcb40d90920 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -624,6 +624,7 @@ struct rtl8169_private {
 
 	unsigned supports_gmii:1;
 	unsigned aspm_manageable:1;
+	unsigned dash_enabled:1;
 	dma_addr_t counters_phys_addr;
 	struct rtl8169_counters *counters;
 	struct rtl8169_tc_offsets tc_offset;
@@ -1253,14 +1254,26 @@ static bool r8168ep_check_dash(struct rtl8169_private *tp)
 	return r8168ep_ocp_read(tp, 0x128) & BIT(0);
 }
 
-static enum rtl_dash_type rtl_check_dash(struct rtl8169_private *tp)
+static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
+{
+	switch (tp->dash_type) {
+	case RTL_DASH_DP:
+		return r8168dp_check_dash(tp);
+	case RTL_DASH_EP:
+		return r8168ep_check_dash(tp);
+	default:
+		return false;
+	}
+}
+
+static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
 {
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_28:
 	case RTL_GIGA_MAC_VER_31:
-		return r8168dp_check_dash(tp) ? RTL_DASH_DP : RTL_DASH_NONE;
+		return RTL_DASH_DP;
 	case RTL_GIGA_MAC_VER_51 ... RTL_GIGA_MAC_VER_53:
-		return r8168ep_check_dash(tp) ? RTL_DASH_EP : RTL_DASH_NONE;
+		return RTL_DASH_EP;
 	default:
 		return RTL_DASH_NONE;
 	}
@@ -1453,7 +1466,7 @@ static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
 
 	device_set_wakeup_enable(tp_to_dev(tp), wolopts);
 
-	if (tp->dash_type == RTL_DASH_NONE) {
+	if (!tp->dash_enabled) {
 		rtl_set_d3_pll_down(tp, !wolopts);
 		tp->dev->wol_enabled = wolopts ? 1 : 0;
 	}
@@ -2512,7 +2525,7 @@ static void rtl_wol_enable_rx(struct rtl8169_private *tp)
 
 static void rtl_prepare_power_down(struct rtl8169_private *tp)
 {
-	if (tp->dash_type != RTL_DASH_NONE)
+	if (tp->dash_enabled)
 		return;
 
 	if (tp->mac_version == RTL_GIGA_MAC_VER_32 ||
@@ -4869,7 +4882,7 @@ static int rtl8169_runtime_idle(struct device *device)
 {
 	struct rtl8169_private *tp = dev_get_drvdata(device);
 
-	if (tp->dash_type != RTL_DASH_NONE)
+	if (tp->dash_enabled)
 		return -EBUSY;
 
 	if (!netif_running(tp->dev) || !netif_carrier_ok(tp->dev))
@@ -4895,8 +4908,7 @@ static void rtl_shutdown(struct pci_dev *pdev)
 	/* Restore original MAC address */
 	rtl_rar_set(tp, tp->dev->perm_addr);
 
-	if (system_state == SYSTEM_POWER_OFF &&
-	    tp->dash_type == RTL_DASH_NONE) {
+	if (system_state == SYSTEM_POWER_OFF && !tp->dash_enabled) {
 		pci_wake_from_d3(pdev, tp->saved_wolopts);
 		pci_set_power_state(pdev, PCI_D3hot);
 	}
@@ -5254,7 +5266,8 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1);
 	tp->aspm_manageable = !rc;
 
-	tp->dash_type = rtl_check_dash(tp);
+	tp->dash_type = rtl_get_dash_type(tp);
+	tp->dash_enabled = rtl_dash_is_enabled(tp);
 
 	tp->cp_cmd = RTL_R16(tp, CPlusCmd) & CPCMD_MASK;
 
@@ -5325,7 +5338,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* configure chip for default features */
 	rtl8169_set_features(dev, dev->features);
 
-	if (tp->dash_type == RTL_DASH_NONE) {
+	if (!tp->dash_enabled) {
 		rtl_set_d3_pll_down(tp, true);
 	} else {
 		rtl_set_d3_pll_down(tp, false);
@@ -5365,7 +5378,8 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			    "ok" : "ko");
 
 	if (tp->dash_type != RTL_DASH_NONE) {
-		netdev_info(dev, "DASH enabled\n");
+		netdev_info(dev, "DASH %s\n",
+			    tp->dash_enabled ? "enabled" : "disabled");
 		rtl8168_driver_start(tp);
 	}
 


