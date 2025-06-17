Return-Path: <stable+bounces-154120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97DCADD7E9
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5844A1A15
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E1C2E8E10;
	Tue, 17 Jun 2025 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gTxnDNLY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0F12EA165;
	Tue, 17 Jun 2025 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178164; cv=none; b=nvViUx9/nUdXV4LQST9hrKethY58L9ImcXinDSHY6FYQCwxhK2SR1PBgy87OmFiduMQ/IJNvCPyHTpUMD/O2O7kFoTj2xfnTEo6RCxfAjhzZS9rVhyQnScWJjx9xOigRHnxtosIADZKVLmPkt04FnrioH1KzF7mBP+FID3PAaz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178164; c=relaxed/simple;
	bh=L4B9f9J4/mSWmDhGY7PhnJLYWMTJSCmljU8zGObQqms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ql5OoiUMU7bhK4c7RcJPy6xQcvrvGgH4Xl31cOuLfgYEKWXa1zeKOzDY6IbUajuuWdYeXHhg3bI9xK4j5z7zU/zJrs+n8fRmsKAV1Ajl7dwcBkf+f36IMuOvmaRTTiiQsmu3t208BUxdadFh4p7Dm+nWYZBseZfJ3qIQgqvEYsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gTxnDNLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17FFC4CEE3;
	Tue, 17 Jun 2025 16:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750178164;
	bh=L4B9f9J4/mSWmDhGY7PhnJLYWMTJSCmljU8zGObQqms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gTxnDNLYs/+Mro4NCuYhtzkZYo3yBr8lSZbs194RgDYChj6HWTqIsNHWlisgi9VvB
	 jLQKxjK+y+Dq+JD0PQHDGj6t8FSxprXbQVEIgrOWJrknYeapS1sqocaseaHxBqytli
	 VomRLOrky3S0wdFofVf0slVrHcgcfCe5LlLXbaSk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Raczynski <j.raczynski@samsung.com>,
	Wenjing Shan <wenjing.shan@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 455/512] net/mdiobus: Fix potential out-of-bounds clause 45 read/write access
Date: Tue, 17 Jun 2025 17:27:01 +0200
Message-ID: <20250617152438.004490128@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Raczynski <j.raczynski@samsung.com>

[ Upstream commit 260388f79e94fb3026c419a208ece8358bb7b555 ]

When using publicly available tools like 'mdio-tools' to read/write data
from/to network interface and its PHY via C45 (clause 45) mdiobus,
there is no verification of parameters passed to the ioctl and
it accepts any mdio address.
Currently there is support for 32 addresses in kernel via PHY_MAX_ADDR define,
but it is possible to pass higher value than that via ioctl.
While read/write operation should generally fail in this case,
mdiobus provides stats array, where wrong address may allow out-of-bounds
read/write.

Fix that by adding address verification before C45 read/write operation.
While this excludes this access from any statistics, it improves security of
read/write operation.

Fixes: 4e4aafcddbbf ("net: mdio: Add dedicated C45 API to MDIO bus drivers")
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
Reported-by: Wenjing Shan <wenjing.shan@samsung.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/mdio_bus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 7d2616435ce9e..591e8fd33d8ea 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -985,6 +985,9 @@ int __mdiobus_c45_read(struct mii_bus *bus, int addr, int devad, u32 regnum)
 
 	lockdep_assert_held_once(&bus->mdio_lock);
 
+	if (addr >= PHY_MAX_ADDR)
+		return -ENXIO;
+
 	if (bus->read_c45)
 		retval = bus->read_c45(bus, addr, devad, regnum);
 	else
@@ -1016,6 +1019,9 @@ int __mdiobus_c45_write(struct mii_bus *bus, int addr, int devad, u32 regnum,
 
 	lockdep_assert_held_once(&bus->mdio_lock);
 
+	if (addr >= PHY_MAX_ADDR)
+		return -ENXIO;
+
 	if (bus->write_c45)
 		err = bus->write_c45(bus, addr, devad, regnum, val);
 	else
-- 
2.39.5




