Return-Path: <stable+bounces-141135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B43AAB0B5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624281BA0DD6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CCB3278D5;
	Tue,  6 May 2025 00:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zfet+8yc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F37A2BE7CC;
	Mon,  5 May 2025 22:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485279; cv=none; b=WNuicQ6EGFhq7oy0KojTR9uaJt5HFxnGrnSFVtxmV7iNbdeu1kE5DhUNLZpiHOqHFXsjNZnFG4EsSya4fYhZJwH7UALjmD3DK+3Uok1HoO16TOliCjA7F8H+RmnZbVvle9rqgyJNUn/p5eLGOqRFLZfoNFq+gm8vrmtlJafEB2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485279; c=relaxed/simple;
	bh=W/fmnVm28UABsUxm8BpRqAlkePFFxH/1wCASUfw3Z+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Be/vcQ9H5MiKqKjbZiCoEXUf0uScK6twXC9HhF30+Jt8w0gy8eh/7soHd1FTCqReUuqdTLgzQmQp/J4+8Jf8RS9RVQC+wCnv4oBBNDJbwOnYKCdi8LE33qIBcxWQjWXmiQ1tW9J8XlMdWZ3K1mQTWoorM4ybqodu1LvQho9T7Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zfet+8yc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2031DC4CEE4;
	Mon,  5 May 2025 22:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485279;
	bh=W/fmnVm28UABsUxm8BpRqAlkePFFxH/1wCASUfw3Z+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zfet+8yc7R62CN8UfwbqMUAterl85qBQpagXJaeO6l+pc3G4cqlCWVb+meMAlTO5p
	 3G44aWjmfXCRGpVjvjrLPPOmSKFbW2ObQcsu84rVVMrDRSkanRZzXpivPBXgn0ukGX
	 pI4y9K0a2DSPtTjPk5ZCCT3RbSdCxITcNaZcu/ZAeJUOzbohYahYK/ihhXChg/LsuT
	 46g3vzAAAJ7Z3c8oB11YNuafKr6hVPXhdVozTvEvE5XAz03g49wMhWgyiZg+R+SCbX
	 xfPcy8dWqInvEUm/qJP/pASjG0VlI/LDW+oTPC9VU77wJ1olsCAyqAFRRowO8Pt/ms
	 6MKb0gq1ju5KQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hariprasad Kelam <hkelam@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sgoutham@marvell.com,
	lcherian@marvell.com,
	gakula@marvell.com,
	jerinj@marvell.com,
	sbhatta@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 250/486] Octeontx2-af: RPM: Register driver with PCI subsys IDs
Date: Mon,  5 May 2025 18:35:26 -0400
Message-Id: <20250505223922.2682012-250-sashal@kernel.org>
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

From: Hariprasad Kelam <hkelam@marvell.com>

[ Upstream commit fc9167192f29485be5621e2e9c8208b717b65753 ]

Although the PCI device ID and Vendor ID for the RPM (MAC) block
have remained the same across Octeon CN10K and the next-generation
CN20K silicon, Hardware architecture has changed (NIX mapped RPMs
and RFOE Mapped RPMs).

Add PCI Subsystem IDs to the device table to ensure that this driver
can be probed from NIX mapped RPM devices only.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Link: https://patch.msgid.link/20250224035603.1220913-1-hkelam@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 14 ++++++++++++--
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h |  2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 8216f843a7cd5..0b27a695008bd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -66,8 +66,18 @@ static int cgx_fwi_link_change(struct cgx *cgx, int lmac_id, bool en);
 /* Supported devices */
 static const struct pci_device_id cgx_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_OCTEONTX2_CGX) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CN10K_RPM) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CN10KB_RPM) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CN10K_RPM,
+	  PCI_ANY_ID, PCI_SUBSYS_DEVID_CN10K_A) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CN10K_RPM,
+	  PCI_ANY_ID, PCI_SUBSYS_DEVID_CNF10K_A) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CN10K_RPM,
+	  PCI_ANY_ID, PCI_SUBSYS_DEVID_CNF10K_B) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CN10KB_RPM,
+	  PCI_ANY_ID, PCI_SUBSYS_DEVID_CN10K_B) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CN10KB_RPM,
+	  PCI_ANY_ID, PCI_SUBSYS_DEVID_CN20KA) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CN10KB_RPM,
+	  PCI_ANY_ID, PCI_SUBSYS_DEVID_CNF20KA) },
 	{ 0, }  /* end of table */
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 8555edbb1c8f9..f94bf04788e98 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -30,6 +30,8 @@
 #define PCI_SUBSYS_DEVID_CNF10K_A	       0xBA00
 #define PCI_SUBSYS_DEVID_CNF10K_B              0xBC00
 #define PCI_SUBSYS_DEVID_CN10K_B               0xBD00
+#define PCI_SUBSYS_DEVID_CN20KA                0xC220
+#define PCI_SUBSYS_DEVID_CNF20KA               0xC320
 
 /* PCI BAR nos */
 #define	PCI_AF_REG_BAR_NUM			0
-- 
2.39.5


