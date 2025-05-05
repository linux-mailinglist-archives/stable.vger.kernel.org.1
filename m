Return-Path: <stable+bounces-139800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE4FAA9FD1
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0ED3A7040
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D5728A1F8;
	Mon,  5 May 2025 22:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEYWQ2bH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF5228A1F2;
	Mon,  5 May 2025 22:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483360; cv=none; b=WL1knAUlLkiOqBI3SYNHaGbEP2rgSVpWeKncj2fhuDEOWDUpceZ8K7W414PlIMfhqhlx9aBGmJeCLgo6WFd4j5JaCX6jeoS+GNAvhbo4BUS7JSKCusqK/jX7VQow87wGnZ8Zm98FhZM/iNQuSZ0rWSZKaiNr7ZMS3/ruVpGoprM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483360; c=relaxed/simple;
	bh=fl21SqllGa3GmW7YFUTP0an3YYMZ++AKiz3F0pLgxhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZwGviw/lPD+ygmwIYx3AWydp+rTO8pE6/2CkzXhbiIuXaySuD3XOeT4qUkCEku3irvuPvgZLx+3bofnRDjlO0IrADgf22gaeyXRHa1ty/x1mGXTCQn8u3dMMakoCZgBOhFw5MURhSnHS77YizXs/JiD1Zs761YCuTUhZMxTBDPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEYWQ2bH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C58C4CEF1;
	Mon,  5 May 2025 22:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483359;
	bh=fl21SqllGa3GmW7YFUTP0an3YYMZ++AKiz3F0pLgxhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UEYWQ2bHILFwsS6s/2mam7abcjB4rxiF50uz9r91GJN+mXN1Yu6RO4KU2jGheIluM
	 k8a5bI3qx9XNz4DDiJMFzUCrREYkt0VfcBGm75UyYGPdya3xp1Bui1T4s7HN0HxJ66
	 E8D7Gyn4CyJJEepc3dSWepkJ2WLEpJNrAGfzhJR/nymV2Meukh3tRfK//S8gQNlx0U
	 RPDcCK16GC6ToBDX2e8S62ho0RFLbtSNNBXLgRRhfbRA+d1mxuZYCZQ6DSmyfFBngo
	 XdGTkDMeYP04X0vCFKlmYJFoU0d/Bt+5+IbikSYFfPQfeNKIoIKO3TtL15GPKGUGp/
	 ucar+5Qbip80w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: ChunHao Lin <hau@realtek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 053/642] r8169: disable RTL8126 ZRX-DC timeout
Date: Mon,  5 May 2025 18:04:29 -0400
Message-Id: <20250505221419.2672473-53-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: ChunHao Lin <hau@realtek.com>

[ Upstream commit b48688ea3c9ac8d5d910c6e91fb7f80d846581f0 ]

Disable it due to it dose not meet ZRX-DC specification. If it is enabled,
device will exit L1 substate every 100ms. Disable it for saving more power
in L1 substate.

Signed-off-by: ChunHao Lin <hau@realtek.com>
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://patch.msgid.link/20250318083721.4127-3-hau@realtek.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169_main.c | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5a5eba49c6515..4ead966727734 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2850,6 +2850,32 @@ static u32 rtl_csi_read(struct rtl8169_private *tp, int addr)
 		RTL_R32(tp, CSIDR) : ~0;
 }
 
+static void rtl_disable_zrxdc_timeout(struct rtl8169_private *tp)
+{
+	struct pci_dev *pdev = tp->pci_dev;
+	u32 csi;
+	int rc;
+	u8 val;
+
+#define RTL_GEN3_RELATED_OFF	0x0890
+#define RTL_GEN3_ZRXDC_NONCOMPL	0x1
+	if (pdev->cfg_size > RTL_GEN3_RELATED_OFF) {
+		rc = pci_read_config_byte(pdev, RTL_GEN3_RELATED_OFF, &val);
+		if (rc == PCIBIOS_SUCCESSFUL) {
+			val &= ~RTL_GEN3_ZRXDC_NONCOMPL;
+			rc = pci_write_config_byte(pdev, RTL_GEN3_RELATED_OFF,
+						   val);
+			if (rc == PCIBIOS_SUCCESSFUL)
+				return;
+		}
+	}
+
+	netdev_notice_once(tp->dev,
+		"No native access to PCI extended config space, falling back to CSI\n");
+	csi = rtl_csi_read(tp, RTL_GEN3_RELATED_OFF);
+	rtl_csi_write(tp, RTL_GEN3_RELATED_OFF, csi & ~RTL_GEN3_ZRXDC_NONCOMPL);
+}
+
 static void rtl_set_aspm_entry_latency(struct rtl8169_private *tp, u8 val)
 {
 	struct pci_dev *pdev = tp->pci_dev;
@@ -3822,6 +3848,7 @@ static void rtl_hw_start_8125d(struct rtl8169_private *tp)
 
 static void rtl_hw_start_8126a(struct rtl8169_private *tp)
 {
+	rtl_disable_zrxdc_timeout(tp);
 	rtl_set_def_aspm_entry_latency(tp);
 	rtl_hw_start_8125_common(tp);
 }
-- 
2.39.5


