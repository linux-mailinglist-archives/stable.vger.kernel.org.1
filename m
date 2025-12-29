Return-Path: <stable+bounces-203463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3782CE59DC
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 01:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4E5F3009B0C
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 00:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9EF1339A4;
	Mon, 29 Dec 2025 00:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pj1gT3es"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE9C2AD0C;
	Mon, 29 Dec 2025 00:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766968344; cv=none; b=nrmZIb5HT/Wv18zyBOnbEqLpvjCtMvqNEwjx0X/aWMbGTlVjzoo3zIDKE+NRZngBATaETEJXRa2bKtnJFFrp5i3WBL8SbYKpfaZSIlNvrrdQg/zJBCY6oGU0vdylOIRvTOfFB/5CsKdYA0KeqKd8NEcXWBzQyeK6ipEfNaVGsuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766968344; c=relaxed/simple;
	bh=ibHHCWpmDjJgu18LdIycxtB5UdvGBhQFVkss/84A4Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IsPMfCJ93Q+T0cg7F91Te/mpbxUdasstUXZB5xqja2RfPfsiHM1zuGsCnNn9xXG6hoJPo3PV0eskSGLcGjHzUvfPTdaqi34vHN2MF4Vikm1hv7IRReyBJzqEzI2urOcCkreHAm+PEPJoMPLPeUPj46NEkwGmNoTpXqrlG7q+EFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pj1gT3es; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=SIyJ2V32M7OdhzhP0EuIp0BnYKflR7Qg6zrL/G07kGM=;
	b=pj1gT3esuGJV2LGuiMYqhP246IZIDfnDkb5l7fndGhWtNKtPEpfweURnpgUaYo
	I4RVTcbMvk7g549yeJsZkQmf7GTl/fKdlTWGt9BSts4TJPVcvgGygLhYmNk8tyZT
	EGd7oCvyj5MWuAIWQjzH912yoOGFVcOQYfpKFMmBsGEp0=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDHMpTny1Fpk10YDA--.58172S2;
	Mon, 29 Dec 2025 08:31:36 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH v6.6] net: stmmac: make sure that ptp_rate is not 0 before configuring EST
Date: Mon, 29 Dec 2025 08:31:17 +0800
Message-Id: <20251229003117.1918863-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHMpTny1Fpk10YDA--.58172S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW8Aw1DWF18XryxZF48Xrb_yoW5JFy7pF
	W7AFySvr92qr1xJ3WkJr4DXF98WayUtrWDWryfKw4fuFWav3yqqr9avFyjyF1Utrs8ZF43
	tr4jkr1xC3Z8CrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEQzVOUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC3QnbdWlRy+kxugAA3r

From: Alexis Lothoré <alexis.lothore@bootlin.com>

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
[ The context change is due to the commit c3f3b97238f6
("net: stmmac: Refactor EST implementation")
which is irrelevant to the logic of this patch. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c        | 5 +++++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index 8fd167501fa0..0afd4644a985 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -597,6 +597,11 @@ int dwmac5_est_configure(void __iomem *ioaddr, struct stmmac_est *cfg,
 	int i, ret = 0x0;
 	u32 ctrl;
 
+	if (!ptp_rate) {
+		pr_warn("Dwmac5: Invalid PTP rate");
+		return -EINVAL;
+	}
+
 	ret |= dwmac5_est_write(ioaddr, BTR_LOW, cfg->btr[0], false);
 	ret |= dwmac5_est_write(ioaddr, BTR_HIGH, cfg->btr[1], false);
 	ret |= dwmac5_est_write(ioaddr, TER, cfg->ter, false);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 0bcb378fa0bc..aab02328a613 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1537,6 +1537,11 @@ static int dwxgmac3_est_configure(void __iomem *ioaddr, struct stmmac_est *cfg,
 	int i, ret = 0x0;
 	u32 ctrl;
 
+        if (!ptp_rate) {
+                pr_warn("Dwxgmac2: Invalid PTP rate");
+                return -EINVAL;
+        }
+
 	ret |= dwxgmac3_est_write(ioaddr, XGMAC_BTR_LOW, cfg->btr[0], false);
 	ret |= dwxgmac3_est_write(ioaddr, XGMAC_BTR_HIGH, cfg->btr[1], false);
 	ret |= dwxgmac3_est_write(ioaddr, XGMAC_TER, cfg->ter, false);
-- 
2.34.1


