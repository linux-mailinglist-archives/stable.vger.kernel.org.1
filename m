Return-Path: <stable+bounces-139786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FC5AA9F8F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D1CF3AF995
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CD8284B21;
	Mon,  5 May 2025 22:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0v++0l4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEDD284694;
	Mon,  5 May 2025 22:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483334; cv=none; b=VHgbNzk1MIDPFUHOQISUk/6zyUWslyiy27r3GwKrzOM7IWcBvS2ukjmLVnYKyVHwLkyTT5955CzArRFUCO1clPE+sXor1V0H1pMWXe8Fyr1Ry6r7Vr/YCq5ie1J/IwAVmtfNs2Stqv8RspfxlQUqq/QBAu0ZTDI8KuqCatxIsck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483334; c=relaxed/simple;
	bh=/UCsCVFjAKQ5ixedxcZzXmKFJNG1lbkF0KEuXoj11jk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ikpbJwTvyCbK4PL2/ZkXdPzzbTxv/XUcYv4f3J9yqvyWjJ9qsgntg2laZq+adQF14ZiJNt0a1C/m1GirUyOjManXpq2FPn+JJuOQzTWfCCsnSk5eLT2gBIwNdfFNwtrIjEnVFDkx/tlarkYRy/yR+v9DmxhOoQ5CywfFlsbH54g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0v++0l4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B600C4CEEE;
	Mon,  5 May 2025 22:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483333;
	bh=/UCsCVFjAKQ5ixedxcZzXmKFJNG1lbkF0KEuXoj11jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F0v++0l43aDVcGbp1W1qFf/7C84V/vd1MpEqtmVNI/MAn6JxJcDn7MYkYO5ysVulx
	 k/XGVhDECDiVMqW1gNMFsiSLG/o9dOfmbGpALWHY/gQ/EW7I9njIxfTvW2SZx1yjte
	 wZAvRBhc2fEuDFjfH8thBfdjiOUeS4bAZaukXNTSNbvIEr5+I8t40FOxDgrd035YVc
	 UHmvVS0puKf3X+7mlLggzeyoENsCEKQGz4nAiot5Gd/uygWqiKfcTwUSbJxv5u+G2M
	 GKUmi0F98rmnvQgPPxdvRAICgotyGPdIjHU+w4gBVpEPdkf3aaw9+fqx8Of7PLoH4g
	 2A/wkz0VyGAVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans-Frieder Vogt <hfdevel@gmx.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	fujita.tomonori@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 039/642] net: tn40xx: add pci-id of the aqr105-based Tehuti TN4010 cards
Date: Mon,  5 May 2025 18:04:15 -0400
Message-Id: <20250505221419.2672473-39-sashal@kernel.org>
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

From: Hans-Frieder Vogt <hfdevel@gmx.net>

[ Upstream commit 53377b5c2952097527b01ce2f1d9a9332f042f70 ]

Add the PCI-ID of the AQR105-based Tehuti TN4010 cards to allow loading
of the tn40xx driver on these cards. Here, I chose the detailed definition
with the subvendor ID similar to the QT2025 cards with the PCI-ID
TEHUTI:0x4022, because there is a card with an AQ2104 hiding amongst the
AQR105 cards, and they all come with the same PCI-ID (TEHUTI:0x4025). But
the AQ2104 is currently not supported.

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250322-tn9510-v3a-v7-7-672a9a3d8628@gmx.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/tehuti/tn40.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
index 259bdac24cf21..a6965258441c4 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1832,6 +1832,10 @@ static const struct pci_device_id tn40_id_table[] = {
 			 PCI_VENDOR_ID_ASUSTEK, 0x8709) },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
 			 PCI_VENDOR_ID_EDIMAX, 0x8103) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, PCI_DEVICE_ID_TEHUTI_TN9510,
+			 PCI_VENDOR_ID_TEHUTI, 0x3015) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, PCI_DEVICE_ID_TEHUTI_TN9510,
+			 PCI_VENDOR_ID_EDIMAX, 0x8102) },
 	{ }
 };
 
-- 
2.39.5


