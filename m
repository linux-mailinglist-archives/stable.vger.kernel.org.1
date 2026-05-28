Return-Path: <stable+bounces-255146-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFITJOGdGGpAlggAu9opvQ
	(envelope-from <stable+bounces-255146-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:56:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 291775F7770
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 670583025A73
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1141733F5B4;
	Thu, 28 May 2026 19:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F1pdDrvi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE21348C45;
	Thu, 28 May 2026 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998094; cv=none; b=bZrQO3Nv19SfPcABFP/L+YArJ/cwZbJYK2dcZ1qtap7BLxiP0Gh5eRqJOWQH7rdbm+4B6lj4hn/V6Twmt2Kp6fA93TDyKB7VcqhPayMqFrrY83e/ewUFbA1SSgxx5VhL+M18IuX+t4JMaJc3qDqaC/Nnw9MttC7+bxcCnCUZObU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998094; c=relaxed/simple;
	bh=mojX6PtUrk3c3IxWnPeyHDNowrVrgxb71GZZVdGecK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nG2k61YNpkDcufS5gy5JClXQ6VRclfNB1pgZlsdm3XNUlbMv9xf4QYbBZCq1OmFFh9/LCerMJqUNI2Dz0hwwWD5R4HUI3TtFIDqT5I1n2J7FuiczzQxGxclxSn+s2ORXFg3hA44r/C7PjMJz7F5ylbtQBhQ2WsemSt+9OqSR2KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F1pdDrvi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC871F000E9;
	Thu, 28 May 2026 19:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998093;
	bh=oOhhLSE2x0a/oZ5bIBA3htnYP2Znx/Q2YMB21eyVZEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F1pdDrviIQ2du9kdEzZw4G2FqHJpHuHGQIG/JDKdQ0itBES3d76Si2iwhMJAsvxJj
	 vct3vSCIgImift4u9TCpVnaw4IaJnm5qi/SWT+lnLHeUmZWq/gpiOWF+sP8hmtRXeZ
	 tWmE0a6rffrTf/7YB693aZyQWRNt682tJn5UEMEk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Nerijus=20Bend=C5=BEi=C5=ABnas?= <nerijus.bendziunas@gmail.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7.0 052/461] net: phy: skip EEE advertisement write when autoneg is disabled
Date: Thu, 28 May 2026 21:43:01 +0200
Message-ID: <20260528194648.413433678@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255146-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,tipi-net.de,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,tipi-net.de:email]
X-Rspamd-Queue-Id: 291775F7770
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nerijus Bendžiūnas <nerijus.bendziunas@gmail.com>

commit 960e77ce14a83ef7f226e8e4b4d75765633ba48b upstream.

genphy_c45_an_config_eee_aneg() writes the EEE advertisement to the
auto-negotiation device's MMD register space (MDIO_MMD_AN, register
MDIO_AN_EEE_ADV).  These registers are read by the link partner only
during auto-negotiation, so writing them while autoneg is disabled
cannot influence the link.  On some PHYs (e.g. Broadcom BCM54213PE)
the write nevertheless reaches the chip and disturbs the receive
datapath.

Concretely, running

    ethtool -s eth0 speed 100 duplex full autoneg off
    ethtool --set-eee eth0 eee off

leaves eth0 with TX working and RX completely silent on a
Raspberry Pi 4 / CM4 board (bcmgenet + BCM54213PE in rgmii-rxid).
Switching back to autoneg recovers the link.

Prior to commit f26a29a038ee ("net: phy: ensure that genphy_c45_an_config_eee_aneg() sees new value of phydev->eee_cfg.eee_enabled"),
the disable path was effectively a no-op because the helper read
the stale eee_cfg.eee_enabled, so the underlying PHY behavior never
surfaced.

Bisected on rpi-6.12.y between commits 83943264 (good) and
effcbc88 (bad) to f26a29a038ee.

Fixes: f26a29a038ee ("net: phy: ensure that genphy_c45_an_config_eee_aneg() sees new value of phydev->eee_cfg.eee_enabled")
Cc: stable@vger.kernel.org
Signed-off-by: Nerijus Bendžiūnas <nerijus.bendziunas@gmail.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Tested-by: Nicolai Buchwitz <nb@tipi-net.de>
Link: https://patch.msgid.link/20260516150251.879680-1-nerijus.bendziunas@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phy-c45.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -940,6 +940,14 @@ EXPORT_SYMBOL_GPL(genphy_c45_read_eee_ab
  */
 int genphy_c45_an_config_eee_aneg(struct phy_device *phydev)
 {
+	/* Writing MMD AN advertisements while autoneg is disabled has no
+	 * effect on link-partner negotiation, but on some PHYs (e.g. the
+	 * Broadcom BCM54213PE) the write itself disturbs the receive
+	 * datapath. Skip it.
+	 */
+	if (phydev->autoneg == AUTONEG_DISABLE)
+		return 0;
+
 	if (!phydev->eee_cfg.eee_enabled) {
 		__ETHTOOL_DECLARE_LINK_MODE_MASK(adv) = {};
 



