Return-Path: <stable+bounces-98653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D35F99E4988
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FDA281456
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CA4218AD9;
	Wed,  4 Dec 2024 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVfQCkT4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EF0218AD3;
	Wed,  4 Dec 2024 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355030; cv=none; b=s5CIToQZjj15EiJuMX8m4Gn2GxyBHFqLSfp8vOh2TeJato7EPiOKeR06GL8hto24NC+jJQ0XnFKEAXNPc5nWWPEpJ4BwJTB0MuB4JTcHOM4slrk3ex+N/C8w6QnS0v2Noh9nEQPkjYJpanmQMw9P2DfQcrdLlM/BdsVSbishpC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355030; c=relaxed/simple;
	bh=bnhsjoYqb0f4QR43eg+NqinUwaS8vciC0FvnW6dKSWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9tIS+/XIf+1p2rn7Se+l0pSYnyJ0EVjUzix/t4C606F3DEvn+PAcRv4JwES/j2mce5V6039eo7y2FedTshlcs8FnRnFuKeRUW7M+yu64nVr8Md0GhalB8hLB1YsKVZy7N+8UnR4uHaIfHhy4INj9YZ4uHHdiDomoQpDaymJepw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVfQCkT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F556C4CECD;
	Wed,  4 Dec 2024 23:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355029;
	bh=bnhsjoYqb0f4QR43eg+NqinUwaS8vciC0FvnW6dKSWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SVfQCkT4PMuESA81l/WiZsUzxXRg5z8VppiWC+mZFjIwc82q6jcJ6oSE+c9XfYign
	 LbHf/gj+88bGewpZF8vu3q+URsk2QJA3n+YlUsXd7axnKK7jD0bIbOP+FSerL0c3C1
	 x6NvXj0AhBzolXZGL/YVGKaZMTw+psiOBn9Y6MsqLHA+HZC60jwHafbKYl8zvLBX2f
	 5NrU5TG83jz0fJharOMKn+xFAncAiCIhAF3fMSH3O5MyEsuqW7dPqjZy1m6gfQFVnm
	 aPuFtGKsI4N9V3d4Un/Bm6gVryt/ygdRyCPMaSbX01eyPZCi2VQ2Luz/GXF4bjk7H9
	 RPGN/mnkdTUKg==
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
Subject: [PATCH AUTOSEL 6.1 5/8] phy: tegra: xusb: Set fwnode for xusb port devices
Date: Wed,  4 Dec 2024 17:18:47 -0500
Message-ID: <20241204221859.2248634-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221859.2248634-1-sashal@kernel.org>
References: <20241204221859.2248634-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index dc22b1dd2c8ba..aa050aea2df58 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -537,7 +537,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
 
 	device_initialize(&port->dev);
 	port->dev.type = &tegra_xusb_port_type;
-	port->dev.of_node = of_node_get(np);
+	device_set_node(&port->dev, of_fwnode_handle(of_node_get(np)));
 	port->dev.parent = padctl->dev;
 
 	err = dev_set_name(&port->dev, "%s-%u", name, index);
-- 
2.43.0


