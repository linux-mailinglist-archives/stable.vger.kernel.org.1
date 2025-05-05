Return-Path: <stable+bounces-140437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F393AAA8B1
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863D1460DDD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9C2352B4E;
	Mon,  5 May 2025 22:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lO5IEr/i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DF9352B42;
	Mon,  5 May 2025 22:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484849; cv=none; b=cR55tvRh80wrXCySrw6g0NUgWgJut2fmfwAgs22j7HenMvJjg6TSgjH+gWoVA/nuc2mpFEu+1NqvmByse6j1ocRmpoVqWkmnmNIZvDs01yVR5DZIAECwyFoOWCjdiO1eIY4NQ4a8U1ouu+Z5m9RB7Imtf3czSeDudQWkuJxmhG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484849; c=relaxed/simple;
	bh=aJdXPv18U8OTg0wYWxuaSKfkCuM+TeU+Mu1IdEujK9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lxDHPtbgEQ/88rttnLDASae4giSRuILn7fT8Tf11jaPhzs/aHCE9/80em6r6ygcdSRXWtmwcALIeOOf59NkZjXwDz/r9EpZwajdDXXQd5fBYHmn/2luULOjHfK2AVl6bgCRI/WuP9UQcNzrmNg3MHEvq5L0fr9Ct/rKAdZc68fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lO5IEr/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFEFC4CEE4;
	Mon,  5 May 2025 22:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484849;
	bh=aJdXPv18U8OTg0wYWxuaSKfkCuM+TeU+Mu1IdEujK9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lO5IEr/ixcL8WORS/p4E5X/hQN/IFqtsB7wo1JQh5ok8JnjQwrV0AnObb349Ehd2a
	 T6YFbxb6IAw0Q30zuA4ROh0dcU2QR+hOI7AwMKJUj3T4EQhYsQ5M2nUJPOFlarBTVK
	 UppyMGwdQntMr6Ic6Com3aOnx7GBOiMrNRYkfw5Fqr4LXEN4JhqvRbA7ekxyfOJ1k1
	 Qv6I+mCyvDKOZDHdPQER5fzHx84TXR8CNsJlIacz8Eqg5mwM+3MAhcJo7hlTmx9Inp
	 Jd1E/wvFXvpGTswWKFcmEVwr9t1pSMHohUeVXvpk2tHlsMF5WKikT4v5RyJEPEEPPU
	 PLgLzrjE2uSnA==
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
Subject: [PATCH AUTOSEL 6.12 046/486] r8169: disable RTL8126 ZRX-DC timeout
Date: Mon,  5 May 2025 18:32:02 -0400
Message-Id: <20250505223922.2682012-46-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 5ed2818bac257..3420b6cf8189f 100644
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
@@ -3816,6 +3842,7 @@ static void rtl_hw_start_8125b(struct rtl8169_private *tp)
 
 static void rtl_hw_start_8126a(struct rtl8169_private *tp)
 {
+	rtl_disable_zrxdc_timeout(tp);
 	rtl_set_def_aspm_entry_latency(tp);
 	rtl_hw_start_8125_common(tp);
 }
-- 
2.39.5


