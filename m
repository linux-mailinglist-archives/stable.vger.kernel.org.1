Return-Path: <stable+bounces-4103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76984804604
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315D8283426
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22B579E3;
	Tue,  5 Dec 2023 03:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vWKR+Vyh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0F46FB1;
	Tue,  5 Dec 2023 03:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20B1C433C8;
	Tue,  5 Dec 2023 03:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746625;
	bh=KEusSJuiBavPGBBkYDFo53V8jOZ90L5GcYmWWLhdTKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vWKR+Vyh4JNB7JttpJ4jCJSooywt2MiYfUEDNsMOjNPhPxuYs2iJxlYPHzstG8gFo
	 TXrjiI8K9SA5yxlyWTD+SdFt2TT3oCIw1JATGYQ2b6pSxxpBlqkydE4w4+EeQqZa0q
	 M5pY9j8MesWGzv+TAKo6Ln6Xi3t1AukXta0e02Dw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Furong Xu <0x1207@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 096/134] net: stmmac: xgmac: Disable FPE MMC interrupts
Date: Tue,  5 Dec 2023 12:16:08 +0900
Message-ID: <20231205031541.552631682@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
References: <20231205031535.163661217@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Furong Xu <0x1207@gmail.com>

[ Upstream commit e54d628a2721bfbb002c19f6e8ca6746cec7640f ]

Commit aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts
by default") tries to disable MMC interrupts to avoid a storm of
unhandled interrupts, but leaves the FPE(Frame Preemption) MMC
interrupts enabled, FPE MMC interrupts can cause the same problem.
Now we mask FPE TX and RX interrupts to disable all MMC interrupts.

Fixes: aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts by default")
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Furong Xu <0x1207@gmail.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Link: https://lore.kernel.org/r/20231125060126.2328690-1-0x1207@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
index ea4910ae0921a..6a7c1d325c464 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
@@ -177,8 +177,10 @@
 #define MMC_XGMAC_RX_DISCARD_OCT_GB	0x1b4
 #define MMC_XGMAC_RX_ALIGN_ERR_PKT	0x1bc
 
+#define MMC_XGMAC_TX_FPE_INTR_MASK	0x204
 #define MMC_XGMAC_TX_FPE_FRAG		0x208
 #define MMC_XGMAC_TX_HOLD_REQ		0x20c
+#define MMC_XGMAC_RX_FPE_INTR_MASK	0x224
 #define MMC_XGMAC_RX_PKT_ASSEMBLY_ERR	0x228
 #define MMC_XGMAC_RX_PKT_SMD_ERR	0x22c
 #define MMC_XGMAC_RX_PKT_ASSEMBLY_OK	0x230
@@ -352,6 +354,8 @@ static void dwxgmac_mmc_intr_all_mask(void __iomem *mmcaddr)
 {
 	writel(0x0, mmcaddr + MMC_RX_INTR_MASK);
 	writel(0x0, mmcaddr + MMC_TX_INTR_MASK);
+	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_TX_FPE_INTR_MASK);
+	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_RX_FPE_INTR_MASK);
 	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_RX_IPC_INTR_MASK);
 }
 
-- 
2.42.0




