Return-Path: <stable+bounces-267300-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l0i4NF2xNGr/ewYAu9opvQ
	(envelope-from <stable+bounces-267300-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 05:02:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1C56A3A65
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 05:02:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267300-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267300-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B989C304B57A
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 03:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764A433C52F;
	Fri, 19 Jun 2026 03:02:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F8733B6F4;
	Fri, 19 Jun 2026 03:02:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781838161; cv=none; b=ej79d1Aq4SeGmDdcLZ7orz18a4Lhk9IPzs7xpbqe0NsKXVT8qYunk6QanWQ8sVqvMIANor+4dbm4ayghgpgxiKOAp6+bogmU7v/wuvIW6+dw1O/JCX5dbVQV95xZ91yJnCBnTvtRsMqmNPOjfEI8THexcdusjDu6++Bncuo1pEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781838161; c=relaxed/simple;
	bh=r4bodF9U8oMEN04T0y18dysLerS4jks16bI6avdd++w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FkiXvyvBDqjQr27sK3o7+ah2tnfeW8KzOyoS4khzGQtgsIrGcL7vhbxthEBU1DywGUzjM8PTaE8CtJNFzzV/pZgP8dSzWKoBQYmgxglnt0tAbCQisW6CJIuH6JMmz1Ggd9IS7yr0pg5WB5Fh9nxPUTuFiwvvBcfzz+kTucoZ9Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 4a0426106b8b11f1aa26b74ffac11d73-20260619
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:54b7c1a8-4e26-4de3-9828-59c9a56bcaa4,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:4c2eda3750725ae7bc323e2f32abb649,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|850|865|898,TC:nil,Content
	:0|15|50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4a0426106b8b11f1aa26b74ffac11d73-20260619
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 677852642; Fri, 19 Jun 2026 11:02:21 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: vkoul@kernel.org,
	neil.armstrong@linaro.org,
	johan@kernel.org,
	kishon@kernel.org,
	rogerq@ti.com
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	Sashiko AI <sashiko@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v6 4/4] phy: ti-pipe3: Fix clock leak in init error path
Date: Fri, 19 Jun 2026 11:02:14 +0800
Message-Id: <20260619030214.1779043-5-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619030214.1779043-1-zenghongling@kylinos.cn>
References: <20260619030214.1779043-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267300-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,126.com,kylinos.cn,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zenghongling@kylinos.cn,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:neil.armstrong@linaro.org,m:johan@kernel.org,m:kishon@kernel.org,m:rogerq@ti.com,m:linux-phy@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:zhongling0719@126.com,m:zenghongling@kylinos.cn,m:sashiko@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenghongling@kylinos.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kylinos.cn:email,kylinos.cn:mid,kylinos.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F1C56A3A65

When regmap_update_bits() fails in ti_pipe3_init() for PCIe mode,
the function returns the error without calling ti_pipe3_disable_clocks().
This leaves the clocks permanently enabled since the PHY framework won't
invoke the .exit callback on init failure.

Fix this by adding proper clock cleanup in the PCIe error path, consistent
with how the DPLL program error path handles cleanup.

Fixes: 234738ea3390 ("phy: ti-pipe3: move clk initialization to a separate function")
Reported-by: Sashiko AI <sashiko@kernel.org>
Closes: https://lore.kernel.org/all/20260518023657.41852C2BCB0@smtp.kernel.org/
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Cc: stable@vger.kernel.org

---
Change in v5:
  -Add Fix ignored clock enable return value in init patch
---
Change in v6:
 -Fix all clock leak paths comprehensively:
 -PCIe syscon update failure path
 -SATA DPLL lock check path
 -SATA errata path in ti_pipe3_exit()
---
 drivers/phy/ti/phy-ti-pipe3.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index 9ec228c2a940..860058f31594 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -518,6 +518,8 @@ static int ti_pipe3_init(struct phy *x)
 		val = 0x96 << OMAP_CTRL_PCIE_PCS_DELAY_COUNT_SHIFT;
 		ret = regmap_update_bits(phy->pcs_syscon, phy->pcie_pcs_reg,
 					 PCIE_PCS_MASK, val);
+		if (ret)
+			ti_pipe3_disable_clocks(phy);
 		return ret;
 	}
 
@@ -531,8 +533,9 @@ static int ti_pipe3_init(struct phy *x)
 
 	/* SATA has issues if re-programmed when locked */
 	val = ti_pipe3_readl(phy->pll_ctrl_base, PLL_STATUS);
-	if ((val & PLL_LOCK) && phy->mode == PIPE3_MODE_SATA)
-		return ret;
+	if ((val & PLL_LOCK) && phy->mode == PIPE3_MODE_SATA) {
+		return 0;
+	}
 
 	/* Program the DPLL */
 	ret = ti_pipe3_dpll_program(phy);
@@ -555,8 +558,10 @@ static int ti_pipe3_exit(struct phy *x)
 	/* If dpll_reset_syscon is not present we wont power down SATA DPLL
 	 * due to Errata i783
 	 */
-	if (phy->mode == PIPE3_MODE_SATA && !phy->dpll_reset_syscon)
+	if (phy->mode == PIPE3_MODE_SATA && !phy->dpll_reset_syscon) {
+		ti_pipe3_disable_clocks(phy);
 		return 0;
+	}
 
 	/* PCIe doesn't have internal DPLL */
 	if (phy->mode != PIPE3_MODE_PCIE) {
-- 
2.25.1


