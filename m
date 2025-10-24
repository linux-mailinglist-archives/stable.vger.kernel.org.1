Return-Path: <stable+bounces-189176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4930DC03F82
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 02:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406291890FCA
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 00:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF07778F4B;
	Fri, 24 Oct 2025 00:46:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68976158DA3
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 00:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761266782; cv=none; b=hXLMroLIVepOljCwlyl8lBLc70zWVrU1HJNzwc/JcljrIcvyx7sRYta3X0rMYqLUmul4JpcQpkKnNil+cIiDL8ezPCUQ/b5VLR+uR20lX8rk43oWHxHjdSvaZQnTIikKnvYf1t7iq4M6723cnd3VS72q0jQB8qokYFT/1PbHBEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761266782; c=relaxed/simple;
	bh=XPDK2itk3WXEAGBk37ldTl4RUy95Peqpwe8qR9QvbaE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fVaZU5GkNSCzIFpQYCDwAEYEcOLDOODBZoAGsua6s5YEUIA5Cvlpuxfn3TcnpaIWShmEz6XmAhh+wMl8vDZ4z6Rypyj8A+jRjp+tjXspxWg73Ojxhgh64nlv6zCOi7Tf60aHj//CFe1TkoizSFlik5TPHSc1lYxZDPLTZrE4hX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 859D8233B4;
	Fri, 24 Oct 2025 03:46:15 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jakub Kicinski <kuba@kernel.org>,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10/5.15/6.1/6.6] net: stmmac: make sure that ptp_rate is not 0 before configuring EST
Date: Fri, 24 Oct 2025 03:46:13 +0300
Message-Id: <20251024004613.250406-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexis Lothoré <alexis.lothore@bootlin.com>

commit cbefe2ffa7784525ec5d008ba87c7add19ec631a upstream.

If the ptp_rate recorded earlier in the driver happens to be 0, this
bogus value will propagate up to EST configuration, where it will
trigger a division by 0.

Prevent this division by 0 by adding the corresponding check and error
code.

Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Fixes: 8572aec3d0dc ("net: stmmac: Add basic EST support for XGMAC")
Link: https://patch.msgid.link/20250529-stmmac_tstamp_div-v4-2-d73340a794d5@bootlin.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ kovalev: bp to fix CVE-2025-38125;
  replaced netdev_warn with pr_warn due to missing dev pointer ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index 8fd167501fa0..4df62268f852 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -597,6 +597,11 @@ int dwmac5_est_configure(void __iomem *ioaddr, struct stmmac_est *cfg,
 	int i, ret = 0x0;
 	u32 ctrl;
 
+	if (!ptp_rate) {
+		pr_warn("%s: Invalid PTP rate\n", __func__);
+		return -EINVAL;
+	}
+
 	ret |= dwmac5_est_write(ioaddr, BTR_LOW, cfg->btr[0], false);
 	ret |= dwmac5_est_write(ioaddr, BTR_HIGH, cfg->btr[1], false);
 	ret |= dwmac5_est_write(ioaddr, TER, cfg->ter, false);
-- 
2.50.1


