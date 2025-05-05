Return-Path: <stable+bounces-140066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54192AAA4B8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15DFF3AB319
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BEF302A7E;
	Mon,  5 May 2025 22:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ou1TAKVg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196AF302A73;
	Mon,  5 May 2025 22:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484017; cv=none; b=jm6oJKbVQf2UmV+00EKTk+y49iKGtusIKd8gZ1nE/ucO98YcZN9Af5O4k5A0ACh/IkyraL9fLK7QUPoePE4g+oEEz89aOBvIw+I+80OKgd6O53OY4VHROLTXXEZUdYgR8sYM8nBFj9SwbHWJA462j1Kse6Xy0iGomUB3ga4TFAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484017; c=relaxed/simple;
	bh=suDV7faIvbXvY3stwO9+XUDT+p7WeoMrqgsIgnkIvKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RqpCehoxha4ICD7Pppq8Aw4Po1JHG5P4BZZc7PiBvu+Op8TsFX7PloIymb4oNt6R8+zDfc3oLrRrNVGiDBJIBirGZwIBGlx+2Fi+fKiPjvF1DCxTDu1iVWBrAw01X4qzeCvv4bVDEDiU/pm77E5sq6nhECsBKZvHeD5Y/YuwFy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ou1TAKVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4BAC4CEE4;
	Mon,  5 May 2025 22:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484016;
	bh=suDV7faIvbXvY3stwO9+XUDT+p7WeoMrqgsIgnkIvKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ou1TAKVggO9CmPPo9EW9hMXVNcNU9WXSquCk0JYxrsDgvv35NJkPi3704l0vQ+A6C
	 b+ytpWlEwfZi6WzSPjDCBgcrp5v4rGNBl64C2EF5jU8A1ovlTOIwm9Igc8Ogan3R+E
	 QC8MRqpeOIxdzerlB8F4iquLmiQVVDqwXOhg7vBonybO9xUdpLjSrSRzjS2p1yVL3G
	 ACh9FsLVGdEo24XoxEogFMrN2YbKD1GkceI04O6ECGmYaB1wZuUWxFQKOStml5pgVP
	 qkYF1hAYxDSuoj7yxWMPcRKG1vW4tecNmak/tU6BA4rhtst6QyatrU74RmWiAhsNfa
	 dPcD+hOHJSZIQ==
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
Subject: [PATCH AUTOSEL 6.14 319/642] Octeontx2-af: RPM: Register driver with PCI subsys IDs
Date: Mon,  5 May 2025 18:08:55 -0400
Message-Id: <20250505221419.2672473-319-sashal@kernel.org>
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
index a383b5ef5b2d8..60f085b00a8cc 100644
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


