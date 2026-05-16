Return-Path: <stable+bounces-249003-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ5VCcGECGo9tgMAu9opvQ
	(envelope-from <stable+bounces-249003-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 16:52:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B8555C2FE
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 16:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4611E300EABC
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2023E2ABF;
	Sat, 16 May 2026 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itW1GJ/M"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836272C326F
	for <stable@vger.kernel.org>; Sat, 16 May 2026 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778943161; cv=none; b=tBlmA7vnX4UxvEfo6pR8tJZwkY0pZXlzzCVQxmXbC0ZVhtGdfjfMWu4h3Frs+Pmy2j4cX0RUaI4qhme4UM6BY07tWVSX1LAOFsPzVWoivMYk19Dfp5it6Fi1rRJpVkcKO5mpuKhrcnWWrTAcLGUJubP+hS0oDt25dxAQk1ES6Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778943161; c=relaxed/simple;
	bh=QmkJpHUldte/egmuA7DGybI2tVG7cghkcZq8VmZIces=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5q3vFm6EOxsE6sbHBEJHEVoLFD5+7nE3giqMUzbgln/tKW+12RAkovZXxFpalJxXoThigN6lDhswigSXOpnxqygAF2GWteDbs4+UwIGRqnffCOAxvUiZVqcJOUhwbvtfIWMK75k+l/QCpWbvNvifcwkO+R3pd5dx+YPOu161Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itW1GJ/M; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bd394f4a931so199999866b.2
        for <stable@vger.kernel.org>; Sat, 16 May 2026 07:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778943159; x=1779547959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxxDjL5gnnI2uwzrc+KACxtlyJsnDYW3Yb57xozjSks=;
        b=itW1GJ/MmP/rraX61+guXfi0qf/rTu7VGrKEiMpgMuWhYH+6iwOnBvLQVo4gBZu7PD
         5NJ54DUJD5UIBHNWL2uG2xLM/VuZlRo/uj6EyqGs2v5kSJG3t/kBvDJjMKhvKUvwTBNR
         3/GwZVsPizfKfTCSqm5mn4aBYDdCWtfihdrzwaZvzV8+omlkAUPeGXpjZ8ZAnSFwYIAg
         QZfityw9VUwVyqzQExSA2CgEmthKrf9HP7abcO+Zy9jQQtd5LGuq8qjOPiVmfWcKcnXd
         VigeG+mr8/bQyiUNjUa/ag+w6guAlaKNz9xiTKOUubB/Mtn6qP/n45Z4KRq/51ktiqYg
         3nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778943159; x=1779547959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxxDjL5gnnI2uwzrc+KACxtlyJsnDYW3Yb57xozjSks=;
        b=X1XkvKuyQ2qYpmmvoHuWhaIWcY/b593SuyVnnd3umHgycaarGOLa2DBFU+lplENgSA
         IZvis496rBjiIMhKJeX7JhPTwwFyk4LJBaRKOwsPT8aOGhNOHLriKbNEXsepGP6qxyvb
         UfkWcRicdZKr+tLV8tOIJej2ORnwp3Zk56lBTGAoJnFccuYC9g371v6OXHPnTYbsmDBV
         NYnOq9RpZCFpeRWrpqr0dcep2lDkvAmcE6ExqcIydu8aKdUVzpEeJxcMEElz8biANSI+
         VGkOR7G0Ikl7g3e7mDagRuJ1fI7Wof7NVpNnGRH+N09mcF9OJN4a0+r0A9L3CnLsyafj
         kMNg==
X-Forwarded-Encrypted: i=1; AFNElJ/QcRW+pActs90MFRDTry47SGWLRqL0+ClqBtTip7JJnrapQaDsHM9d/eqOVm0rRG6GqXUStwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdyIVrGpTKIjHaigGUbH5RH4CD1zi8HB0MNzR4u4hTCu2nbSvK
	3TOekK3tfZWMOwDUaM5lLxAj+A4NX05eon/Srk0f+3Zb/r00NtdqKAs=
X-Gm-Gg: Acq92OGFim4CPXNfnbmgxlgrVA6USjfk7ZISegHNRdIDKAG6SOnjsJO7vdah0sw398G
	EoqQMUDzT3v6ZUrKfJbLQvd/uB2ySODqFhmWyM8n63arB9AdLgKg1C/dWj9yXMMilv+JY3xzxPB
	CDnxTL00D+TpqTgqaaAj4g/oix5dDpaUMtR6hGKJyulB1eOjqlwhEqmxSFqwEJvpYkee7S+jDwn
	F5se5wHjbwI/bZFuwhym9DEFfMToVsEycea+pmICzr/mMK4de+zBdx0xb0HmVvEeh13r0rRGQwW
	tWOcJTwBiIWR0bZF+RJ54IsdB91FESAK6xVSdseGGa+MpnqhJuj4xq8vjvS0sSaM7GzRlKdyMWB
	6T+bhBx0cbFVvbvkNtS/i7MzWycpbvmIbcPYsjjhLqzmx0AhsJ/NfJab1IiLZsFGtl+b9xJS31e
	lJ/XD2PUwDOdf2/j7tyA01DDp9tJZQOgFiC8HVAFr2mPLHA0ecYqXeMeQNTHUM7J48fO2ptrhTl
	P9dcNzmFNkoxevDAc0ckfBMtSXoXVrbaQym3j8VcXgHmBbpVd+3OA==
X-Received: by 2002:a17:906:8e0e:b0:bd1:d244:ca24 with SMTP id a640c23a62f3a-bd517861053mr429002166b.14.1778943158629;
        Sat, 16 May 2026 07:52:38 -0700 (PDT)
Received: from nn ([2001:1ab8:1003:0:5454:f357:ba89:4e22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4bd0a40sm352858966b.12.2026.05.16.07.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 07:52:38 -0700 (PDT)
Sender: N B <gen.benner@gmail.com>
From: =?UTF-8?q?Nerijus=20Bend=C5=BEi=C5=ABnas?= <nerijus.bendziunas@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: phy: skip EEE advertisement write when autoneg is disabled
Date: Sat, 16 May 2026 17:52:20 +0300
Message-ID: <20260516145220.875871-1-nerijus.bendziunas@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260516114334.812828-1-nerijus.bendziunas@gmail.com>
References: <20260516114334.812828-1-nerijus.bendziunas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B6B8555C2FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249003-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nerijusbendziunas@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
---
Changes since v1:
 - Reworded the inline comment and commit message: the MMD AN
   write is read by the chip with side-effects, not silently
   ignored. Suggested by Andrew Lunn.
 - Tightened the reproducer paragraph (was repeating paragraph 1).

v1: https://lore.kernel.org/netdev/20260516114334.812828-1-nerijus.bendziunas@gmail.com/
 drivers/net/phy/phy-c45.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index d48aa7231b37..126951741428 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -940,6 +940,14 @@ EXPORT_SYMBOL_GPL(genphy_c45_read_eee_abilities);
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
 
-- 
2.54.0


