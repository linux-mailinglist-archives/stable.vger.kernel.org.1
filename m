Return-Path: <stable+bounces-212829-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +M90MacZfGlgKgIAu9opvQ
	(envelope-from <stable+bounces-212829-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 03:38:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E54B6821
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 03:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75F47300E72C
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 02:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694C032863A;
	Fri, 30 Jan 2026 02:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AGs4ee/A"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9041EB9E1;
	Fri, 30 Jan 2026 02:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769740685; cv=none; b=UjVHErQZ0c4wuOYLFzJ3+ne9zhR0adxwrVU5I+z1LiqQLnZb7Hapv0nq8QqlyekcRybhwzjsixJ2Dzp72ly6B6cTrXNJDgXpv/WSngVOry+o5WipcWweuBAJfqgdA+oEHcE/TeyM05MRT9eNr/ohi+5jdIx669zIe7rhhzJfSBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769740685; c=relaxed/simple;
	bh=XoCGmtKIL2kudFYfX8yG6xddZrcl2tEnErJHjcjGy2k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=C9EmcXUX4Ri6Bvizh+dl0V/FSVYe8/orq5lglEPv5I5WAJSIpFW3JzWhbzlQRouPPCVDjW2a1bo64iQ3sYrWBR+lDKoigpAaPFYRxeb+ZhXealswKnv8/KdF39fUeTyAzFy/fF/uFRYysMnS+s/C+0CNdm7Ayg2m4ubj2eNlb68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AGs4ee/A; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=ak+stKbQO+SG0zj6nGU7d67tPLLkh6z5jY0vfqhLTWc=;
	b=AGs4ee/AUzcOv1DEOrrAY4rxyPiCJU7nTpqZzg4rcs1/OEiGV0cts+6ECKQkHV
	LndphiGdeBAwDN22qvR1lzeXCr4TVqDIurG+186mps/3jwGYrHs95RIrvuYiRI9N
	JLCjG51kSmvsmuljNEW4wQA5UZcYYAEqDQmwxUpkyEx/M=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3sf9gGXxp4GANIw--.640S2;
	Fri, 30 Jan 2026 10:37:22 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 6.1.y] net: stmmac: make sure that ptp_rate is not 0 before configuring EST
Date: Fri, 30 Jan 2026 10:37:18 +0800
Message-Id: <20260130023718.3757414-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3sf9gGXxp4GANIw--.640S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr47ArW7Aw4xJr4UKw4xXrb_yoW5Gr1DpF
	W7AFyFvr97tF1fJ3WkJF4kXF98WayDtrWDWryfKw4fuFWav3yqqF9avFyrtF1Utrs8XFW3
	tr4jkr1xCFn8urUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_ManUUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC3gPXcWl8GWOa9QAA37
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,bootlin.com,kernel.org,163.com];
	TAGGED_FROM(0.00)[bounces-212829-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[black.hawk@163.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28E54B6821
X-Rspamd-Action: no action

From: Alexis Lothoré <alexis.lothore@bootlin.com>

[ Upstream commit f11cf946c0a92c560a890d68e4775723353599e1 ]

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
and the proper adoption is done. ]
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
index d0e2748a0ed2..b73c8dcfacee 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1497,6 +1497,11 @@ static int dwxgmac3_est_configure(void __iomem *ioaddr, struct stmmac_est *cfg,
 	int i, ret = 0x0;
 	u32 ctrl;
 
+	if (!ptp_rate) {
+		pr_warn("Dwxgmac2: Invalid PTP rate");
+		return -EINVAL;
+	}
+
 	ret |= dwxgmac3_est_write(ioaddr, XGMAC_BTR_LOW, cfg->btr[0], false);
 	ret |= dwxgmac3_est_write(ioaddr, XGMAC_BTR_HIGH, cfg->btr[1], false);
 	ret |= dwxgmac3_est_write(ioaddr, XGMAC_TER, cfg->ter, false);
-- 
2.34.1


