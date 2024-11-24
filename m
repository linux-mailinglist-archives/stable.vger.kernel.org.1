Return-Path: <stable+bounces-95088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 777809D737A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A03DB3AD12
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182551DB55C;
	Sun, 24 Nov 2024 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWw9mhSI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CBF217F56;
	Sun, 24 Nov 2024 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455928; cv=none; b=aQuYFVLF9Kc1FUhbfs92WL5M1l0XB4F0T6EvXWMxjIZ1ITLisU+NqG9gZiY/Y0mYr9RG7ayG56cyI9zxdC072o2BR2vnr8I1NbmyZroSBVhyTEbCTf+HuGZzga52yQJdlE960n85oxmqBlPToFWqBBsUFxfvpoRV5AIjigR8t3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455928; c=relaxed/simple;
	bh=EBXQHHhl/OS3VoyjoXIvuoikIpqqeSOh4dmng018dZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrygfTE5G5mpM8ZLDDcnm4vA/hd4kkGMv3L2XsdzqzQtHV8+NJ70sbfp6rctIA2IlOTnTR8Q90g15iAoh8r/m1dkkiJN38z+9BRHDEBtw1gsn3QF6vTqEHcR7dkAvw2bmTqWsRi76U6ANwwRUqH2lLwd8FpcwLx0Qbs0gSjb37Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWw9mhSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760E8C4CED6;
	Sun, 24 Nov 2024 13:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455928;
	bh=EBXQHHhl/OS3VoyjoXIvuoikIpqqeSOh4dmng018dZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SWw9mhSIb//JKV7D6Bn2fPZsbhhvpxz1cGPfBHPVdL5O6m7oVeTouf5l4RJ1hZ4CA
	 3qImCV4zLcnrC2HgCWH9sdJY8gvaB3aE9Is+eFuZ3XsGnaoqXbaADKSbaxbd+xmKup
	 0Rg2oe15FKe2WkSYI6iO6m2N4hfVtf5bRrCDBeQj1r0nRx0a859oMv1upmb/V9y1zo
	 gEcEe75B1Ty/Y7dW6rlVUK7rme/L6rg87XMMPFxDjCrozyHKNgVxAgsriokuffrJvz
	 w/iDM724baf4bCtj9vzNacQVQUFSYpFx1o2+fez+LqHBEdVLQfCwYKESWWRlfm5BGX
	 g8WUnv/pbJocA==
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
Subject: [PATCH AUTOSEL 6.11 85/87] rocker: fix link status detection in rocker_carrier_init()
Date: Sun, 24 Nov 2024 08:39:03 -0500
Message-ID: <20241124134102.3344326-85-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index e097ce3e69ea3..0d4d1627bd283 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2502,7 +2502,7 @@ static void rocker_carrier_init(const struct rocker_port *rocker_port)
 	u64 link_status = rocker_read64(rocker, PORT_PHYS_LINK_STATUS);
 	bool link_up;
 
-	link_up = link_status & (1 << rocker_port->pport);
+	link_up = link_status & (1ULL << rocker_port->pport);
 	if (link_up)
 		netif_carrier_on(rocker_port->dev);
 	else
-- 
2.43.0


