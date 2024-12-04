Return-Path: <stable+bounces-98664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9869E49B9
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1734516254B
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9073121CA0A;
	Wed,  4 Dec 2024 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sv5TXyH9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B82221CA04;
	Wed,  4 Dec 2024 23:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355067; cv=none; b=AcJnIZZ2xBZTDPdnJGG1gw0wl6smXkBBGlYrxYDVmEXxZwfIqiT09qxrzjtY2hNgMAxtQElY4VEioL+uSQe+Y8pn6YzGa1bhyIOF/pe3UsT8UxyC8ob8KXIiZiLYMAoRahUR1zlnEuQ1xiK35XLxbtyJRlCUHPjwF70IKV9N9fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355067; c=relaxed/simple;
	bh=7ui9ot9eoh+IkUpPzOlVCenipdDiAvxsCmjSBdH7YbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtOkbsTq1BZBH0ipbIxWjjiS6AtR+WG9I8FCLVrq2o/Kbg6qWWfqed8bi76q4Celqi5UPn0/N5hHP7onQKiprTRYvC16enHFmemLnq9oQbrFFxX3bFhZjtmDLIE4QNTEAAjxC+o5l3zcmnaWa8LFifmyTyFnQdG13sNAnjHjLic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sv5TXyH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539AAC4CEDD;
	Wed,  4 Dec 2024 23:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355065;
	bh=7ui9ot9eoh+IkUpPzOlVCenipdDiAvxsCmjSBdH7YbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sv5TXyH9KCjl8AnDZ9wOvwPYh+tiLsmIOdFbphEmQw+VjOTVtQWOqJ5LxoFbpudtp
	 baST1f+GNxHi8cq/rrsBa65DHlauVKWnBetPUtjy9pemNTk3GL9Q63dtT2ZEdcAODb
	 LvRbX+E+WbMNJa5B33dvIl3gSxifLLDznz1iAalQNyRNFbYZtPheYjcorEYRpR5npd
	 r4zCVBqbl6dts/CTLGhlskv6oFyk0l1wNb5kowwHuH639k470EdjK97hJk27JBKFy8
	 abC6tK9c5iCrwG6ZN/YBxJXQgJzm87lVlkenGslwf0F4dxCWpKI+x+xYAYRDNY85kL
	 bFA27G5KpsIbQ==
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
Subject: [PATCH AUTOSEL 5.10 3/5] phy: tegra: xusb: Set fwnode for xusb port devices
Date: Wed,  4 Dec 2024 17:19:36 -0500
Message-ID: <20241204221942.2248973-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221942.2248973-1-sashal@kernel.org>
References: <20241204221942.2248973-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
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
index 856397def89ac..133f504dfe9a7 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -531,7 +531,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
 
 	device_initialize(&port->dev);
 	port->dev.type = &tegra_xusb_port_type;
-	port->dev.of_node = of_node_get(np);
+	device_set_node(&port->dev, of_fwnode_handle(of_node_get(np)));
 	port->dev.parent = padctl->dev;
 
 	err = dev_set_name(&port->dev, "%s-%u", name, index);
-- 
2.43.0


