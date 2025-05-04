Return-Path: <stable+bounces-139557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3278CAA84D0
	for <lists+stable@lfdr.de>; Sun,  4 May 2025 10:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD803BC17B
	for <lists+stable@lfdr.de>; Sun,  4 May 2025 08:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0323D18FDD8;
	Sun,  4 May 2025 08:14:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A9919C546
	for <stable@vger.kernel.org>; Sun,  4 May 2025 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746346496; cv=none; b=c9J1DxSvihjNKCwWXyzci6SoDn/sRRJNMMJr36sUAcZ1vBkY2LyiJt5KujXbNRDIu/YtU8Xe/QMiiJrP9hjBJHkQkCZ9u0W0df4UhrvncDwBK8vt81hKiYOr+RGjh9pNBbmsuuZzfIA2nHsspKpdGgfN7yPQpEpO0hrLA+vsJCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746346496; c=relaxed/simple;
	bh=anzPSjuVn++Aj09QLcJVVuFubNsZ4dYazOZp3wVinHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CNlrRV/mEwg/wI26lOgfGG6ZcWqWIbpqwp7gS5MwW6InPqd1JlTyEvdRuGSAtkeMEmWLFHPZIun73cKrbmJ9TMrKkrlomX08J25KseNm94KWkh9N63gz3/IBwtkilFcfyqKFgi50cqv2rvrvHoAFqA5w2+bWSj9IKfCIm9yeUUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uBUUf-00062Z-64; Sun, 04 May 2025 10:14:37 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uBUUd-0012RM-0T;
	Sun, 04 May 2025 10:14:35 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uBUUd-001mQy-0B;
	Sun, 04 May 2025 10:14:35 +0200
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
Date: Sun,  4 May 2025 10:14:32 +0200
Message-Id: <20250504081434.424489-1-o.rempel@pengutronix.de>
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

 drivers/net/dsa/microchip/ksz_common.c | 135 ++++++++++++++++++++-----
 drivers/net/phy/micrel.c               |   7 --
 include/linux/micrel_phy.h             |   1 -
 3 files changed, 107 insertions(+), 36 deletions(-)

--
2.39.5


