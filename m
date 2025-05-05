Return-Path: <stable+bounces-141401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2146AAB6E0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E801C0720A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED14A21FF3A;
	Tue,  6 May 2025 00:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuAA1ipA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03742DDCED;
	Mon,  5 May 2025 23:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486096; cv=none; b=nZHbkXOj88sggx2Lq7cP/ziIjaPBA8By0syvMP2F4rPB6WMm2ZNczfI09Oa0oYBQ46e5/LfIr73hW0qUww8eDUdeOC2sVibRYA7J3BsghZqDe0Vdt1nvnQVqb+HZnB9cQ3tdnLsKNM9kYie840QezUac6loVQVDXXjC8nusbyMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486096; c=relaxed/simple;
	bh=pnzhBEWhGCP4jsOoNQaGpQGLgNWSZkZ9jh4PrhHMuSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fq+JHUCVzpxUxmB8LTVP9jE0BaLBExur7GSHFkvmZFcywH6yQE3ck/KmR+6DmgZd8HzIVXPpvzDefCrRyTPzdfl2Tqllodd+MRla7ErwGzdZau0Nnu7JBqFhZ1bcWDhCO9IwFUtNo/5BxVGA/fRNGaAK0YTTYuD3SKSWf+TK35g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuAA1ipA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929A9C4CEE4;
	Mon,  5 May 2025 23:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486095;
	bh=pnzhBEWhGCP4jsOoNQaGpQGLgNWSZkZ9jh4PrhHMuSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DuAA1ipAiY5o+fuLgaJjSk0dzb6BKzj1KvIijM+Xz0svptCnb2DrejbmWA2TlyZ+N
	 fb+6M8RS8Et1CX5vEbLfRKK7e6WStK9zveqxg7ZyYbNhMnVbgFCWHF4uT/pWVo0f4t
	 RMlD3YlAWX/4kV1nmsww6zI7blqZzLRImKKOT5bLhukhnIiKrcmE8QrrscGx+It/zY
	 azmnkgK40npVHnayJi0wdIrgtFmMrJTZb5rZMNkmsX0XEvNm/RZPlYSBdM6zJPlCCv
	 Ve9kiYkFQHUyThlo+jxc9KcIlDBFr/u2UG0haN+mAgIZ72B2t3JIPAjoRWl2s4BnSm
	 XxnCOpwk7Do6Q==
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
Subject: [PATCH AUTOSEL 6.6 153/294] Octeontx2-af: RPM: Register driver with PCI subsys IDs
Date: Mon,  5 May 2025 18:54:13 -0400
Message-Id: <20250505225634.2688578-153-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 52792546fe00d..fc771e495836e 100644
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
index a607c7294b0c5..9fbc071ef29b0 100644
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


