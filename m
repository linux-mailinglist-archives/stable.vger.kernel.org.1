Return-Path: <stable+bounces-137012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D426AA04AF
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 09:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3C94831C8
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 07:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437B7292904;
	Tue, 29 Apr 2025 07:37:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06245289367
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745912221; cv=none; b=qR/OoAVt5e0sTgwoAnHAOnqwc10mb8lOjTWzQlPRykNCS+3WjQp10o4YRJSn6gRC+P/qBN1LaSbUx4LZX0q8GYgp/BQotZXkf0h/mxyztmd0C6wNOizasbw7bkghzRc91QVidFUozTdyUQMT6RBwDmd3UKmuPiG497v4Ts1T0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745912221; c=relaxed/simple;
	bh=0DjVB5bsxhzbNAMeRyZa4FifU108HCJLKTchWTnfluc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=orIBgpFIY8RBSWQJROGE/TX1xia4bYmw8D8g0rgaUa92TktgDRtT0TXxucFuHwd4QWcsW5AqoVSdO9/CV6M5bE4UsuboCnhPBxtLSKEJ9Gm0jgEtqV36DeNl4l5dgF1oimHWUIvCU6oJPvdJsc3WDSCa6TbFDJB8DAlxro2ZTPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u9fWI-0004BB-1Z; Tue, 29 Apr 2025 09:36:46 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9fWH-000E2W-1x;
	Tue, 29 Apr 2025 09:36:45 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9fWH-00CX8L-1g;
	Tue, 29 Apr 2025 09:36:45 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	stable@vger.kernel.org
Subject: [PATCH net v3 0/2] address EEE regressions on KSZ switches since v6.9 (v6.14+)
Date: Tue, 29 Apr 2025 09:36:42 +0200
Message-Id: <20250429073644.2987282-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

This patch series addresses a regression in Energy Efficient Ethernet
(EEE) handling for KSZ switches with integrated PHYs, introduced in
kernel v6.9 by commit fe0d4fd9285e ("net: phy: Keep track of EEE
configuration").

The first patch updates the DSA driver to allow phylink to properly
manage PHY EEE configuration. Since integrated PHYs handle LPI
internally and ports without integrated PHYs do not document MAC-level
LPI support, dummy MAC LPI callbacks are provided.

The second patch removes outdated EEE workarounds from the micrel PHY
driver, as they are no longer needed with correct phylink handling.

This series addresses the regression for mainline and kernels starting
from v6.14. It is not easily possible to fully fix older kernels due
to missing infrastructure changes.

Tested on KSZ9893 hardware.

Oleksij Rempel (2):
  net: dsa: microchip: let phylink manage PHY EEE configuration on KSZ
    switches
  net: phy: micrel: remove KSZ9477 EEE quirks now handled by phylink

 drivers/net/dsa/microchip/ksz_common.c | 134 +++++++++++++++++++------
 drivers/net/phy/micrel.c               |   7 --
 include/linux/micrel_phy.h             |   1 -
 3 files changed, 106 insertions(+), 36 deletions(-)

--
2.39.5


