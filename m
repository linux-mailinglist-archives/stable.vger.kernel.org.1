Return-Path: <stable+bounces-17354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A13841601
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 23:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746C81C239B6
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 22:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C3F50A9D;
	Mon, 29 Jan 2024 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="40T+yWrj"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6A14F5ED;
	Mon, 29 Jan 2024 22:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706568623; cv=none; b=oeFdK0gyHJLOpkCYj5fxu6cAu+T1wLy5OIhqqGGyyPt4t1rVTXOWUOxG9tkcDyVuCyCmR36KxNydSg06mswcRR01P7hwD9NTYDgqvImCn5cYrlOEdAbuPs6InmD5jAdnydoL6vI5DSbZxSEh4iTZ2+H4HlBBpPEOQptD/oMjE9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706568623; c=relaxed/simple;
	bh=QwxS36Fs8KqCf1UAhmxBRh7I0VEHIgeYiJUVvMVZB/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gL+zb41wW47rMnd2Dbf0OZuh4rCiH77ObeuBsqU8vi5d8FpjujZV9K/AwXk5GAp34luBkeT5rnxa04/PDoB/PDFA/V/xZlRjZV1+CIoivII9QF5BYfGL6vn0MPTichf4L0LJUngfhIuaMa+CZZouYiIDlOWU9kYjOLxXB33LuKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=40T+yWrj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Content-Disposition:In-Reply-To:References;
	bh=VYGzllOGvsjuYhCTcQrDKGQ3L1G9SFVv1wvxvFjxSl8=; b=40T+yWrjWmC5mKVLzfuiXcDjFd
	BwwTepL9JzLGZ5rGVLj1U+zOqwCKWRpAnNFFHdazCEkWtCtS1Cy88PScoLLsA1GNmg5ECoUkhQT3F
	te+TJ5Vffdl2bVZa8lfL4qq81ODmAt4tK5HDIJ+xmD8sqeQ3JzEFmTOCGTt+V5ZcKxh0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUaS9-006QPA-Jr; Mon, 29 Jan 2024 23:50:09 +0100
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
Subject: [PATCH net v2] net: dsa: mv88e6xxx: Fix failed probe due to unsupported C45 reads
Date: Mon, 29 Jan 2024 23:49:48 +0100
Message-Id: <20240129224948.1531452-1-andrew@lunn.ch>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not all mv88e6xxx device support C45 read/write operations. Those
which do not return -EOPNOTSUPP. However, when phylib scans the bus,
it considers this fatal, and the probe of the MDIO bus fails, which in
term causes the mv88e6xxx probe as a whole to fail.

When there is no device on the bus for a given address, the pull up
resistor on the data line results in the read returning 0xffff. The
phylib core code understands this when scanning for devices on the
bus. C45 allows multiple devices to be supported at one address, so
phylib will perform a few reads at each address, so although thought
not the most efficient solution, it is a way to avoid fatal
errors. Make use of this as a minimal fix for stable to fix the
probing problems.

Follow up patches will rework how C45 operates to make it similar to
C22 which considers -ENODEV as a none-fatal, and swap mv88e6xxx to
using this.

Cc: stable@vger.kernel.org
Fixes: 743a19e38d02 ("net: dsa: mv88e6xxx: Separate C22 and C45 transactions")
Reported-by: Tim Menninger <tmenninger@purestorage.com>
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


