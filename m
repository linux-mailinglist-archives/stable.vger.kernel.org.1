Return-Path: <stable+bounces-273897-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pu47HWweVWq3kAAAu9opvQ
	(envelope-from <stable+bounces-273897-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:20:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C69A174DF5F
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:20:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=breiti.cc header.s=google header.b="H4Ub/jeg";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273897-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273897-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87993303AF23
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 17:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A56288C81;
	Mon, 13 Jul 2026 17:16:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5005D270552
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 17:16:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963006; cv=none; b=Y181yMzLyczvgqk9xTSjJ0dscC7i+EATWzbcs9Yi7a9FtWKDcu3eQlpNXa6jLS53TcmX7sueVdKKkhBfQAwcXkiSjzjIbZAU9p8OSNSYvhI+bW/XOQUDdcILPjnk24UVdA7leYvwsHh9OQQeTH/N/o915/4aAKsxQX6GAjeXZxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963006; c=relaxed/simple;
	bh=p1jLAlgaFAZC8YZE8WGwBXhLOIAf22MGlzvlCbicn1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tn0Ia6BH0iV2vzRnf2i9kf4U/R2NEncL70JmTuB7vwSioPGaG+ZFNs3QDSLccRAsoiyXvj0RWQWvM7yZRNY3S5HtGCvWcRRPSkl6JZLOX50g7cjaYy7nv9oaKQK4sDOj2/xZbdu9qpQr7nGxR3856goZcQ6vuawR+otMXew4I2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breiti.cc; spf=pass smtp.mailfrom=breiti.cc; dkim=temperror (0-bit key) header.d=breiti.cc header.i=@breiti.cc header.b=H4Ub/jeg; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47defd0c1c5so51897f8f.3
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 10:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=breiti.cc; s=google; t=1783963004; x=1784567804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D6+zJCN4uHBUySGZxMxtpjUmXPdT/OOFNXEwXFVOhXs=;
        b=H4Ub/jegVV6xKMr4b4ZDBmeZ0ff+XupXiS9lQnnIZYqM4pT9VVV3bSGeBrmCRXsc5z
         g1zq7Q/Jp09al8/RSz30PQaRl7O3KE7e18lo7uC+l16JFTDYLn+WEBqCc2h3XxplWNyT
         Eyfd3QPCqAPv0bKUvjN0+/shaMoAQ6AdgF3jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783963004; x=1784567804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D6+zJCN4uHBUySGZxMxtpjUmXPdT/OOFNXEwXFVOhXs=;
        b=YaglnTXOYVkDHBVuj6Cc+/WCdRHfPm2sMAnnB7/8D1MOlcEzB90bdwq7YGruo/D3l7
         Ywuoe1mpRpU7kCJ2ofec4VLMmXTfS1SP2XZFwOjioWPhgyZ3wT7BeFnOZXdHnJxFijtG
         as3pHF/bHl9m6q2z4duf3n1oo+/60rOuu5tYFRnX7D3OovHKji9sbrHKnlN0FMLJ2IXd
         RYq5t5QqeDN6rf15/ChBqwxa32hS4tT+n9CWTMc6yYz5PbimQ54ONC1+BcJAjDTSoLh8
         W5HIy6b3/CT+Kd8Ow+VeE/xVgDQ72CEUS+nWTqQc68rD8sP2sAhBfSnGnOysuy/OjOFG
         j5ag==
X-Forwarded-Encrypted: i=1; AHgh+RoehHSGB4OTgoMQD5giY7n7zCd7Fm/F8vceranmvoVi8MkVCh1sgmAD2gnDCl5Y7gpnViTJ1mw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm+XuiQUzo1Hi0q1beZy8sExA0DADc+4DC996H+htypYdjcNyy
	aEbj0co1SJwabAyoIMw9m3syV7Ami0MUrq9xiYqtM690viR5C6+scRjCitW5Tkd/Qg==
X-Gm-Gg: AfdE7cnUZbapyfWZWdBKtYBl+APtOUfXRPbnjYqxYA+37GiVRBnukFEGnKRMOTHw/V/
	qXpy1Amksgsef4osIKBwZ2ZNd1/EAgexy1UhDpG6OZ/tEQyqsBABF/+58c8BIuuIUmh0tdB2LVz
	US5DIWeji3SyRQ5pILJQO9GU94PP+nb7Tc2dYn9+CA6GaCEN1wdVhjPvc/jnBY4S9/cm10SH/wF
	MyiTo1YjeI6mag24MhHuKvHAzGp/hzMNpXmJyCZYPJ+wqLAsHwLK4PDGZ2bwdWsP6u1sTS88P4q
	syuQXMwFyKnEefzYj9uHkmUuhKD6czkupKClOqdw5hIWpIGy5kvlDkHlqEKBxQeQJJJ/e4fzV5i
	q+nLTA0xRpmH9UOpr6R3Z3iJMxhQSScTnNlN0dbb0B9QOt2IkUryqEA0C1AYCNFXu10myZpOh34
	PD03CProTDZYPytzP2Ur2DPCaux419LO4lhbLj1YLlKOx8EIvOMQ==
X-Received: by 2002:a05:6000:1848:b0:476:a715:1a with SMTP id ffacd0b85a97d-47f2dce2b61mr11893647f8f.41.1783963003297;
        Mon, 13 Jul 2026 10:16:43 -0700 (PDT)
Received: from framework.casa.breiti.cc ([2.57.48.190])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a9728sm1007047f8f.21.2026.07.13.10.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:16:42 -0700 (PDT)
From: Markus Breitenberger <bre@breiti.cc>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	yong.liang.choong@linux.intel.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org,
	Markus Breitenberger <bre@keba.com>
Subject: [PATCH net v3] net: stmmac: intel: skip SerDes reconfig when rate is unchanged
Date: Mon, 13 Jul 2026 19:16:19 +0200
Message-ID: <20260713171619.192452-1-bre@breiti.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[breiti.cc:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273897-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[bre@breiti.cc,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:yong.liang.choong@linux.intel.com,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,m:bre@keba.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[breiti.cc];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,gmail.com,foss.st.com,armlinux.org.uk,linux.intel.com,st-md-mailman.stormreply.com,lists.infradead.org,vger.kernel.org,keba.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bre@breiti.cc,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[breiti.cc:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,keba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C69A174DF5F

From: Markus Breitenberger <bre@keba.com>

intel_mac_finish() is registered as the phylink mac_finish()
callback for the Elkhart Lake SGMII ports. phylink calls it at
the end of every major link reconfiguration, including the
initial one during probe.

The callback selects the PMC ModPHY LCPLL programming for the
requested MAC-side interface and then power-cycles the SerDes.
On Elkhart Lake that ModPHY is also used by the on-die AHCI
SATA PHY. Reapplying the programming during the initial
boot-time link-up disturbs the shared analog block while it is
still driving SATA, so the SATA link fails to train:

  ata1: SATA link down (SStatus 1 SControl 300)

The disk carrying the root filesystem is never detected and the
system hangs at rootwait. Ethernet itself comes up normally,
which makes the failure look unrelated to the network driver.

Before mac_finish() runs, the legacy SerDes power-up path has
already programmed SERDES_GCR0 for the current interface. The
1G and 2.5G ModPHY tables selected by mac_finish() correspond
to the SerDes lane rate, so read that rate back from SERDES_GCR0
and skip the PMC reprogramming and SerDes power-cycle when it
already matches the selected interface.

This keeps the disruptive reprogramming out of the boot path
when the SerDes is configured correctly, while preserving the
previous behavior when a real SGMII/1000BASE-X to 2500BASE-X
rate change is needed. If the register read fails, reconfigure
as before.

Fixes: a42f6b3f1cc1 ("net: stmmac: configure SerDes according to the interface mode")
Cc: stable@vger.kernel.org
Assisted-by: GitHub-Copilot:claude-opus-4.8
Signed-off-by: Markus Breitenberger <bre@keba.com>
---
v3:
  - Update priv->plat->phy_interface before skipping SerDes reconfiguration,
    so SGMII <-> 1000BASE-X changes still update the cached interface.
  - Rename subject to "net: stmmac: intel: skip SerDes reconfig when rate is unchanged".

v2: https://lore.kernel.org/netdev/20260709190329.124432-1-bre@breiti.cc/
  - Read current SerDes lane rate from SERDES_GCR0 instead of comparing
    against cached phy_interface state.
  - Rework commit message.
  - Keep previous behavior if SERDES_GCR0 read fails.

v1: https://lore.kernel.org/netdev/20260706061954.94842-1-bre@breiti.cc/

 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index b8d467ba6d72..4d207f41a43b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -525,6 +525,32 @@ static int intel_set_reg_access(const struct pmc_serdes_regs *regs, int max_regs
 	return ret;
 }
 
+/*
+ * Return true if the SerDes lane rate must change to serve @interface.
+ * If the current rate cannot be determined, reconfigure as before.
+ */
+static bool intel_serdes_needs_reconfig(struct stmmac_priv *priv,
+					struct intel_priv_data *intel_priv,
+					phy_interface_t interface)
+{
+	u32 cur_rate, want_rate;
+	int data;
+
+	if (!intel_priv->mdio_adhoc_addr)
+		return true;
+
+	data = mdiobus_read(priv->mii, intel_priv->mdio_adhoc_addr,
+			    SERDES_GCR0);
+	if (data < 0)
+		return true;
+
+	cur_rate = (data & SERDES_RATE_MASK) >> SERDES_RATE_PCIE_SHIFT;
+	want_rate = interface == PHY_INTERFACE_MODE_2500BASEX ?
+			SERDES_RATE_PCIE_GEN2 : SERDES_RATE_PCIE_GEN1;
+
+	return cur_rate != want_rate;
+}
+
 static int intel_mac_finish(struct net_device *ndev,
 			    void *intel_data,
 			    unsigned int mode,
@@ -536,6 +562,11 @@ static int intel_mac_finish(struct net_device *ndev,
 	int max_regs = 0;
 	int ret = 0;
 
+	if (!intel_serdes_needs_reconfig(priv, intel_priv, interface)) {
+		priv->plat->phy_interface = interface;
+		return 0;
+	}
+
 	ret = intel_tsn_lane_is_available(ndev, intel_priv);
 	if (ret < 0) {
 		netdev_info(priv->dev, "No TSN lane available to set the registers.\n");
-- 
2.55.0


