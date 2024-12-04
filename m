Return-Path: <stable+bounces-98617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF749E4921
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F2862834EE
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5052116FD;
	Wed,  4 Dec 2024 23:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9Xl0Waz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B500B2116F4;
	Wed,  4 Dec 2024 23:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354886; cv=none; b=Ll/BvliHyilJbYnpT/6SaVpZfO/2lCvJFVRCdOJTOqUufCwNtFbi2RlDWN4g2Xu8EOv0Y30i/UOA4M09ratN4vdoZGiwNcKZ3LTR4IVTqoov4GqSJAH+g8c1nZhpXnvmE0fxVLQBLiNyKazmznq6KnEqzqZgYr4yPVJI/eYn4CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354886; c=relaxed/simple;
	bh=Eui2HQ4Hgc+MEWR+/Z9ZyS66EVROKvhofo2EgPXu/LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDQRoyBtJTyooZZ3ZRIlyCGTx3HeIEtnDmEOX8ZCHohllGNri6SPXaln+ows08ymcVa2/KvJc366oFgpGp+EE7j0yuEMQvCPkKopY+znrD4BwM75mj9CcE4oTo3OH3v6e277uXUS+XtrnOYBfabUagEcTUE4Y+0hhF4AGgWr/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9Xl0Waz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B796FC4CED2;
	Wed,  4 Dec 2024 23:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354886;
	bh=Eui2HQ4Hgc+MEWR+/Z9ZyS66EVROKvhofo2EgPXu/LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S9Xl0WaznqnOjxeJxrLeQB9k2VBdNI6TjczRCgRv3/vnzSfwblJhGKTtC+D/ljGqN
	 BSy+g/WFtPUytPeIi9QVuXwFZo56U8n2mGgoGc0b8KCqOLdzuSMosnkYPM7EjJM4gX
	 r5b71bLVQFFAm4EqP9mykAwJldk/5HEoU91wDAhB6rHvqVbhwiiztLl/Ec6Tnn0yRq
	 4WTkaMCT76v4CUmfCQCaWOMMwsEvGYLv6AD5Mj0R9HS3Mt6CXqr4pULVBPpzQgJb5a
	 KqEHWjXEA19xkMWMfhJHEFjwch7OAJ+OwiBP4/5k7F1uMeqdP5Ya5JfP4gYg1A9iUO
	 Neuh6TT0m7+Ig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Saravana Kannan <saravanak@google.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Thierry Reding <treding@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	jckuo@nvidia.com,
	vkoul@kernel.org,
	kishon@kernel.org,
	thierry.reding@gmail.com,
	linux-phy@lists.infradead.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 09/15] phy: tegra: xusb: Set fwnode for xusb port devices
Date: Wed,  4 Dec 2024 17:16:03 -0500
Message-ID: <20241204221627.2247598-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221627.2247598-1-sashal@kernel.org>
References: <20241204221627.2247598-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Saravana Kannan <saravanak@google.com>

[ Upstream commit 74ffe43bad3af3e2a786ca017c205555ba87ebad ]

fwnode needs to be set for a device for fw_devlink to be able to
track/enforce its dependencies correctly. Without this, you'll see error
messages like this when the supplier has probed and tries to make sure
all its fwnode consumers are linked to it using device links:

tegra-xusb-padctl 3520000.padctl: Failed to create device link (0x180) with 1-0008

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Closes: https://lore.kernel.org/all/20240910130019.35081-1-jonathanh@nvidia.com/
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Suggested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/20241024061347.1771063-3-saravanak@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/tegra/xusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 342f5ccf611d8..d536998288acb 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -543,7 +543,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
 
 	device_initialize(&port->dev);
 	port->dev.type = &tegra_xusb_port_type;
-	port->dev.of_node = of_node_get(np);
+	device_set_node(&port->dev, of_fwnode_handle(of_node_get(np)));
 	port->dev.parent = padctl->dev;
 
 	err = dev_set_name(&port->dev, "%s-%u", name, index);
-- 
2.43.0


