Return-Path: <stable+bounces-98671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015AB9E49D5
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2266A188295C
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8563222577;
	Wed,  4 Dec 2024 23:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvD1hFxf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D7F222571;
	Wed,  4 Dec 2024 23:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355088; cv=none; b=h3gJO28dx6wMe/PdLI++3ehx2dGNzLiGbMdXJcsqDESigFgkWH0JR+nZlvcXRaA8whOwlcjYQZ9xabwo/V0c83cubMGWom3rPSeF+HWmP4dtIZR1nFiZkX6PQPmw9Hj1eQgGQ2dwLP/lkE47wUhWCFgEOWftYYLJla/6twMBLR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355088; c=relaxed/simple;
	bh=IUR3gZrLMdlukOm1qjxRs6qsMryMMWBFmvw0RLnp3wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6C0iCKvUEVEWQPcPdimHHUavoi9ZJv+r/WJxzo2cU6mQil0I1KxBxE3ltJNk6+eglL3bN+mgfynn7EEk1OhepUUbfgbBASXn808okOQbnepapIJt40nkPnw0hUiP3il+Z0MLdhI6s7NS+bR/fXe3yjYuEFdS8egpaScYkNIB7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvD1hFxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89414C4CECD;
	Wed,  4 Dec 2024 23:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355088;
	bh=IUR3gZrLMdlukOm1qjxRs6qsMryMMWBFmvw0RLnp3wA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FvD1hFxfisotSSzGXRdnIwr+pcRHzJMtl6OCIGq8Y4WDsLfSdaWTExTd0FGN3cEbt
	 W/Zth5jvXFXuQ/tz+ThYFcu1SQuqKtx80ZsspyAoX2PvlyhG+98U67tSzVq3aOFP2P
	 kIRLzEvjMSAwEoXhJmXFxWvp0YU/2YIuRb9/woNXjyKxBuVCxPMd3kQwgcO2lSA7EO
	 JBtQwpd1C+0EsKrt8TqyjArZwO+awnrk3bxUGqdPuOvggdCcZcApRJ/FymBzg7GyZ5
	 QEJKUZ0sLOBgMfzTqwca+Bquf12vc+oVsFyu9x4HUFy4NrHgqmBJDnkZF+knnjmf3u
	 9v8BNT2mb9RWQ==
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
Subject: [PATCH AUTOSEL 4.19 2/3] phy: tegra: xusb: Set fwnode for xusb port devices
Date: Wed,  4 Dec 2024 17:20:02 -0500
Message-ID: <20241204222006.2249186-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204222006.2249186-1-sashal@kernel.org>
References: <20241204222006.2249186-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.324
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
index 17211b31e1ed4..943dfff49592d 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -519,7 +519,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
 
 	device_initialize(&port->dev);
 	port->dev.type = &tegra_xusb_port_type;
-	port->dev.of_node = of_node_get(np);
+	device_set_node(&port->dev, of_fwnode_handle(of_node_get(np)));
 	port->dev.parent = padctl->dev;
 
 	err = dev_set_name(&port->dev, "%s-%u", name, index);
-- 
2.43.0


