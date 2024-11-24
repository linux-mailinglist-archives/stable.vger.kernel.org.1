Return-Path: <stable+bounces-95233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B439D746D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C025162DD4
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3980123E406;
	Sun, 24 Nov 2024 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpyOWQVl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B541E3DE4;
	Sun, 24 Nov 2024 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456419; cv=none; b=ph2//myUsXlkJTOVPjMWdxOiRV1hFla/qWkzjeCUang7Z1LVGfCx0xo21NiYD2LQQeq6vVDXr5LPAOAAClpO05j2Ap2jHwSPA5zuHKOyIJMXqv9/ONiPTA+mR17K9WePSR/lfoKSaEkKOWDADpK6wEmzGtvi+v6xOQ7N5PBYEF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456419; c=relaxed/simple;
	bh=FLvK86OcuHyvlZorc91KxeHuJUfSKZ/HcO7pgG4gAC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X27LbYTF3DXFLhgjqxv3s2stI1bX6PanztHmTt3zqRmFjY51V5hsU8it5XH0yK6evkSta2hO2Upi6+bzldsseZ7JkIQVdcnZK5oCYaQdGnshzEilRQn9/7u5CeW8hBInbgNkB24dLjxDagotZN4jD6PM1hIJ4PfR5ncYgpnxWr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpyOWQVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91672C4CED3;
	Sun, 24 Nov 2024 13:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456418;
	bh=FLvK86OcuHyvlZorc91KxeHuJUfSKZ/HcO7pgG4gAC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IpyOWQVllf0Xu0nJAHLFfMJ4qXKyUB18qm9YF+Hm5Aw8tzo/xJ0rxQVM1leYYIznB
	 qDZg5Q8yvRvRYHZd4BfoYElX86mcixLbU3vqWZFnLLVSA9w1UGMW6WddMMA31bf4DX
	 S20OWll59dxj0RX4MaTDc+nNuk2YkTaMojuY7xWITuDsqpl5Efu2QSvdabLQoEJRNn
	 C7V3ugLAbvmf/KNd6wyCvgM7lApeHD3LjesH1sGLdxMPuujpCYgLmECn21FIvzxcUv
	 EirJJ9x6XaicRlGW4F2MCCsbAUvvvWfFZ2Kg6egZdyi/vmEmahdIIkXV1lYHQv9Vl7
	 fnufjkScr/tOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jiri@resnulli.us,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 34/36] rocker: fix link status detection in rocker_carrier_init()
Date: Sun, 24 Nov 2024 08:51:48 -0500
Message-ID: <20241124135219.3349183-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135219.3349183-1-sashal@kernel.org>
References: <20241124135219.3349183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
Content-Transfer-Encoding: 8bit

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit e64285ff41bb7a934bd815bd38f31119be62ac37 ]

Since '1 << rocker_port->pport' may be undefined for port >= 32,
cast the left operand to 'unsigned long long' like it's done in
'rocker_port_set_enable()' above. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Link: https://patch.msgid.link/20241114151946.519047-1-dmantipov@yandex.ru
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/rocker/rocker_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 3364b6a56bd1e..e1509becb7536 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2516,7 +2516,7 @@ static void rocker_carrier_init(const struct rocker_port *rocker_port)
 	u64 link_status = rocker_read64(rocker, PORT_PHYS_LINK_STATUS);
 	bool link_up;
 
-	link_up = link_status & (1 << rocker_port->pport);
+	link_up = link_status & (1ULL << rocker_port->pport);
 	if (link_up)
 		netif_carrier_on(rocker_port->dev);
 	else
-- 
2.43.0


