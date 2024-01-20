Return-Path: <stable+bounces-12320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AABB8335F2
	for <lists+stable@lfdr.de>; Sat, 20 Jan 2024 20:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13FB3282832
	for <lists+stable@lfdr.de>; Sat, 20 Jan 2024 19:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79AE10942;
	Sat, 20 Jan 2024 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RmXvNkCo"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB5810940;
	Sat, 20 Jan 2024 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705778528; cv=none; b=Usl//JqgjwLzYfWX7nvrJS2GlNwfwbF9ZkfaGrk1UL9pm7eOo7JMAhwqNowv6pezYknAGAKy5C1zhjPidN3WUUD4IFUSuo1C4imLN/aPFbqXxX2Cd7BLXThDe0XYepYaQ7pEtwQG2sT4xkkI1YsT6iU5Hu3NBMlyauXDpiJt6V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705778528; c=relaxed/simple;
	bh=KOJQynuPNUuxMCnDQ2so7cOMmmM3iPmcFkmKx3QHt8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ji7v1s6p1Sj6xbUtnmrtSTxJzf4AqDfQ04FWZWSmeySze5bo7r2HHYtDPoIaH0c8ovx7Nj+Q+XV3kLiYAY7gG0e+qaiv1M/IQCv+PhRQueSAZkuTcJGFBDkKCyZKVEtdA6Ru04pjILbDkRy9bU9A9rLuAuvf3CO8qlsmPzt0e+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RmXvNkCo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Content-Disposition:In-Reply-To:References;
	bh=HD3Mb/M0xcfrIduVFRJvKQ8XdYWI1bJWyh2PimvxhbQ=; b=RmXvNkCoJWNYRQoJM1xOt0ugar
	QpbwxG9SaVHJQsjOmpM9V74r9HbIu8QoEqeaFejXNmc9kjdUfs9duJewbp7jVduZwV1BaSnlgpd3D
	p448ZgeVy3e1Qe2Ozgfdxya4iwLRIKV8HzcFLGYvfn45nIEI3gIBidywQt2y9Wt3xIfQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rRGuZ-005cou-KC; Sat, 20 Jan 2024 20:21:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: netdev-maintainers <edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<davem@davemloft.net>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev <netdev@vger.kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	stable@vger.kernel.org,
	Tim Menninger <tmenninger@purestorage.com>
Subject: [PATCH net v1] net: dsa: mv88e6xxx: Make unsupported C45 reads return 0xffff
Date: Sat, 20 Jan 2024 20:21:25 +0100
Message-Id: <20240120192125.1340857-1-andrew@lunn.ch>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When there is no device on the bus for a given address, the pull up
resistor on the data line results in the read returning 0xffff. The
phylib core code understands this when scanning for devices on the
bus, and a number of MDIO bus masters make use of this as a way to
indicate they cannot perform the read.

Make us of this as a minimal fix for stable where the mv88e6xxx
returns EOPNOTSUPP when the hardware does not support C45, but phylib
interprets this as a fatal error, which it should not be.

Cc: stable@vger.kernel.org
Reported-by: Tim Menninger <tmenninger@purestorage.com>
Fixes: 1a136ca2e089 ("net: mdio: scan bus based on bus capabilities for C22 and C45")
Fixes: da099a7fb13d ("net: phy: Remove probe_capabilities")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 383b3c4d6f59..614cabb5c1b0 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3659,7 +3659,7 @@ static int mv88e6xxx_mdio_read_c45(struct mii_bus *bus, int phy, int devad,
 	int err;
 
 	if (!chip->info->ops->phy_read_c45)
-		return -EOPNOTSUPP;
+		return 0xffff;
 
 	mv88e6xxx_reg_lock(chip);
 	err = chip->info->ops->phy_read_c45(chip, bus, phy, devad, reg, &val);
-- 
2.43.0


