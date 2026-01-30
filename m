Return-Path: <stable+bounces-212844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id svNJAM5VfGnpLwIAu9opvQ
	(envelope-from <stable+bounces-212844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 07:55:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE82B7B54
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 07:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C31B3014C46
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 06:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332AE32F762;
	Fri, 30 Jan 2026 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U0X3OgcI"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF44D515;
	Fri, 30 Jan 2026 06:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769756102; cv=none; b=FADCmyVHhEEfpQv7PeIEwcSaIsXQ+yp9HjdGb5vfWShM8rLCHPVTQj0DzDPbnn9O1TdmeMGWScQaKcswKtXql9LinaYW2ENeqYM3NKhd4Kc3w3oP4H/PcqK0xJoXE93DHrElykTPfzHoiP322bFruvEHAe5Rkpv1XkcE/OY8Wcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769756102; c=relaxed/simple;
	bh=XLJozLWOl6TGjHJ1WrpoN3RzHY2N2fGnUUj1ZXLiliU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZSdKaHxj0JPYLvOft0Uw5/zk0PZv9jup8ZFqppIQImvfFgccPtPG/iy7jn9PUhDcHIfWNTN0O69kPlwvVHPVfCJv652QpPmiY74+WaW0JeaZOWIODSWcmkGNmm6hsKLMbRZIMF1Cr8rQV3zxagIlyQWpLWmWVV9/tgHPWYt58vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U0X3OgcI; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=+wua0zpuAHVWedBGGNR9+BMvTiyVLv2mDbaZ5iHalvk=;
	b=U0X3OgcI3wWFfnVWR0+sFx6fs6N9kaUJ4qX86NycBswkPZkQdlamZSoPC1/Qk7
	Gq/Faf8hkqtL9QR/mGoRnK2H5bzazHiOfH4yV92w7kcpgASu/9aDDK//mkB1QWPR
	GpOg9ejuQjRz+E++/nO5lCUhpCh8eeHYpRB1jGCF8pEsw=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAH8_KiVXxpqq_8MQ--.20222S2;
	Fri, 30 Jan 2026 14:54:28 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 5.15.y] net: stmmac: make sure that ptp_rate is not 0 before configuring EST
Date: Fri, 30 Jan 2026 14:54:23 +0800
Message-Id: <20260130065423.3362339-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgAH8_KiVXxpqq_8MQ--.20222S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr47ArW7Aw4xJr4UKw4xXrb_yoW5Gr1DpF
	W7AFyFvr97tF1xJ3WkJr4kXF98Way7trWDWryfKr4fuFWav3yqqr9avFyFyF1jyrs8ZFW3
	tr4jkr17G3Z8urUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEMmhDUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC3QX3kWl8VaWY0QAA3S
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,bootlin.com,kernel.org,163.com];
	TAGGED_FROM(0.00)[bounces-212844-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 5EE82B7B54
X-Rspamd-Action: no action

From: Alexis Lothoré <alexis.lothore@bootlin.com>

[ Upstream commit cbefe2ffa7784525ec5d008ba87c7add19ec631a ]

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
index 813327d04c56..ce0c470915bc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1494,6 +1494,11 @@ static int dwxgmac3_est_configure(void __iomem *ioaddr, struct stmmac_est *cfg,
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


