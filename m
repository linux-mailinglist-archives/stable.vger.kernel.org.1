Return-Path: <stable+bounces-98643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A559E4987
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF83C18828D1
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65526217F33;
	Wed,  4 Dec 2024 23:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZ+tUr+d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5F217F2A;
	Wed,  4 Dec 2024 23:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354991; cv=none; b=Efpx5oaAhlfx/2dB/gg6liwOArQ28lV7ZQzkpspJOCkogrJqHmPaBEQFtVYJYhRE2LWVNs9oS9w4OOt6XLCggk3gOOm5PfhVM32u0cAQyQDb6hz69KCBMihWvbFgi4SOwyn0VkwwVyYVLiQOWrO/YtElhk8SOGtdPEPE+OCAqgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354991; c=relaxed/simple;
	bh=hxtNF2rBxU1e7TSL3gd0s5IgM6jW2PE2/nfSOLEvQQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqA4AzSloR2y7EtuJrgpxJsiDayevNONzi7uw02fYoA3LtKgI52oA3hJqUigYHFYSqcbNFZqS4UH9dtx6poaPqtVrH7jePWAJsM+O819GAWIAfVaF69DM6lpBnpbC9BC6pgsQ+s01dpESUvUGpnz34oe5uScji99uxFCyb9Z2PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZ+tUr+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F5BC4CED2;
	Wed,  4 Dec 2024 23:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354991;
	bh=hxtNF2rBxU1e7TSL3gd0s5IgM6jW2PE2/nfSOLEvQQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jZ+tUr+dsxdhkdwffNuKKbkfbIRx//QuRsfHKsAjV9DTo54Tp16JzBniq+gTxgls9
	 OaohWsVpDa/CVeuWxWDBnRkd0tMTfNXe6XgmAcXFm07f4KIl0hRs132x3O8OM7wLuB
	 VTS9oCY0yvYKZkBAIQ9S7pp22BkP03OgSp4oq6N7JjFLeQgum+swq+SisJMpdrqdUy
	 BY4tsYe0i0d5BNYCCdo+QOWo09d+gE+ndPtPB2x+joulCJKjhgyeLi4Z8NexR3DYh6
	 xmM5hlw941eIMQXleSN7x6S66Cl48Xszz0WGWumKJ/4wwk8D6lchAOL3QSsYQbRxCn
	 9fsTkgmcNmflg==
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
Subject: [PATCH AUTOSEL 6.6 05/10] phy: tegra: xusb: Set fwnode for xusb port devices
Date: Wed,  4 Dec 2024 17:18:03 -0500
Message-ID: <20241204221820.2248367-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221820.2248367-1-sashal@kernel.org>
References: <20241204221820.2248367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index 983a6e6173bd2..765ae53c85664 100644
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


