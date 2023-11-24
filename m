Return-Path: <stable+bounces-1452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD9D7F7FBC
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B304B218E1
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEDD37170;
	Fri, 24 Nov 2023 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZF2yaB4R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A3033CCA;
	Fri, 24 Nov 2023 18:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA101C433C8;
	Fri, 24 Nov 2023 18:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851434;
	bh=SF5KATcoICYW4IUv2VwF3JgvnEGvqUqQBTqhPtlRdYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZF2yaB4R+UX5m8pd3F/shoXXf+u9GwN+73wCFPd9c2VTsGfEv3IMz205Zp+MFeM/Y
	 sfUYOoJy71QoGoAiPzgSG09C2V+4zzUOcfoJtwMRruT5xaYaBH8GbX3AcyE/Oqe+xy
	 9d4Jpy4cZv2USK65y99shWxn32JJgllJfj/FOvOw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ChunHao Lin <hau@realtek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.5 447/491] r8169: add handling DASH when DASH is disabled
Date: Fri, 24 Nov 2023 17:51:23 +0000
Message-ID: <20231124172038.040199897@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ChunHao Lin <hau@realtek.com>

commit 0ab0c45d8aaea5192328bfa6989673aceafc767c upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169_main.c |   36 ++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 11 deletions(-)

--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -624,6 +624,7 @@ struct rtl8169_private {
 
 	unsigned supports_gmii:1;
 	unsigned aspm_manageable:1;
+	unsigned dash_enabled:1;
 	dma_addr_t counters_phys_addr;
 	struct rtl8169_counters *counters;
 	struct rtl8169_tc_offsets tc_offset;
@@ -1253,14 +1254,26 @@ static bool r8168ep_check_dash(struct rt
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
@@ -1453,7 +1466,7 @@ static void __rtl8169_set_wol(struct rtl
 
 	device_set_wakeup_enable(tp_to_dev(tp), wolopts);
 
-	if (tp->dash_type == RTL_DASH_NONE) {
+	if (!tp->dash_enabled) {
 		rtl_set_d3_pll_down(tp, !wolopts);
 		tp->dev->wol_enabled = wolopts ? 1 : 0;
 	}
@@ -2512,7 +2525,7 @@ static void rtl_wol_enable_rx(struct rtl
 
 static void rtl_prepare_power_down(struct rtl8169_private *tp)
 {
-	if (tp->dash_type != RTL_DASH_NONE)
+	if (tp->dash_enabled)
 		return;
 
 	if (tp->mac_version == RTL_GIGA_MAC_VER_32 ||
@@ -4875,7 +4888,7 @@ static int rtl8169_runtime_idle(struct d
 {
 	struct rtl8169_private *tp = dev_get_drvdata(device);
 
-	if (tp->dash_type != RTL_DASH_NONE)
+	if (tp->dash_enabled)
 		return -EBUSY;
 
 	if (!netif_running(tp->dev) || !netif_carrier_ok(tp->dev))
@@ -4901,8 +4914,7 @@ static void rtl_shutdown(struct pci_dev
 	/* Restore original MAC address */
 	rtl_rar_set(tp, tp->dev->perm_addr);
 
-	if (system_state == SYSTEM_POWER_OFF &&
-	    tp->dash_type == RTL_DASH_NONE) {
+	if (system_state == SYSTEM_POWER_OFF && !tp->dash_enabled) {
 		pci_wake_from_d3(pdev, tp->saved_wolopts);
 		pci_set_power_state(pdev, PCI_D3hot);
 	}
@@ -5260,7 +5272,8 @@ static int rtl_init_one(struct pci_dev *
 		rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1);
 	tp->aspm_manageable = !rc;
 
-	tp->dash_type = rtl_check_dash(tp);
+	tp->dash_type = rtl_get_dash_type(tp);
+	tp->dash_enabled = rtl_dash_is_enabled(tp);
 
 	tp->cp_cmd = RTL_R16(tp, CPlusCmd) & CPCMD_MASK;
 
@@ -5331,7 +5344,7 @@ static int rtl_init_one(struct pci_dev *
 	/* configure chip for default features */
 	rtl8169_set_features(dev, dev->features);
 
-	if (tp->dash_type == RTL_DASH_NONE) {
+	if (!tp->dash_enabled) {
 		rtl_set_d3_pll_down(tp, true);
 	} else {
 		rtl_set_d3_pll_down(tp, false);
@@ -5371,7 +5384,8 @@ static int rtl_init_one(struct pci_dev *
 			    "ok" : "ko");
 
 	if (tp->dash_type != RTL_DASH_NONE) {
-		netdev_info(dev, "DASH enabled\n");
+		netdev_info(dev, "DASH %s\n",
+			    tp->dash_enabled ? "enabled" : "disabled");
 		rtl8168_driver_start(tp);
 	}
 



