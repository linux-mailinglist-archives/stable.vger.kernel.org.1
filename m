Return-Path: <stable+bounces-95197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6A29D763F
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 17:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 943F2C209A8
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04ED239965;
	Sun, 24 Nov 2024 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzkt6KWH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693FB23995D;
	Sun, 24 Nov 2024 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456303; cv=none; b=DTG9jLom6hVG4qmuCQi6ftsL7dP2nWWVnrGx3jg1VP1vSPPPktb4XitN30ky+S6c3+dzlqbSxh7Alk9Hfgbqyp/Dw/JPmJm6m7nCrG2PgGdCtKZWpOVzuxLPo5mI/K2dQpYCBFODfwTH2Jzl8OFuU9a+lmY6pze9wLFUEMbFfIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456303; c=relaxed/simple;
	bh=fKFqPoYIBX7KqlaFGH/qVI1sKDFUgPkpK1kwpJXs4ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0llb4FmeVyxVk+0RWmrt7eMRmBNiLdlxuHv7zU/7BK4g0PXewceJCIsf8C6XYUpPTIbW00O4spNFzVrSAGKuSDyAEgAuTAO81UTfhwcc3Ucl0X4oUzuQxC68aTtZyUzOf/mINaRJIjOjuCCTttCuXfntt7KU7cESIjL3BIjZTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzkt6KWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6632C4CED7;
	Sun, 24 Nov 2024 13:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456303;
	bh=fKFqPoYIBX7KqlaFGH/qVI1sKDFUgPkpK1kwpJXs4ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uzkt6KWHxvN/r9E0mjmHsHRVRNMjxGVR7jkAdex2OEO6rUWNIvydQPxgt5wL8rS4U
	 SckgsFv+ozLA8w9Uvf0+ZJ5tSLEgTQkwBioLK0GEr1l32dvVUls97sigEEOx+RAyFa
	 ZNfit+L0oiqLn8nxEgSqQctkoobc15IixJSesJpl1eao4cxmsYh0ybpNqhwar/MEd+
	 Hl/UCa/BPGYIFz2V3hkBICZ7JMNCPF8YwVKB66013qDvlrD6eoNomXDe1Ia+JQQ7uJ
	 uQKEqybtX67ET4Pq7iB2vgeJcCX9ShpEWpAo5nuK91hzO6cssivuWpVidt51dBxgEa
	 HECK40uJyRilg==
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
Subject: [PATCH AUTOSEL 6.1 46/48] rocker: fix link status detection in rocker_carrier_init()
Date: Sun, 24 Nov 2024 08:49:09 -0500
Message-ID: <20241124134950.3348099-46-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index 9e59669a93dd3..2e2826c901fcc 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2504,7 +2504,7 @@ static void rocker_carrier_init(const struct rocker_port *rocker_port)
 	u64 link_status = rocker_read64(rocker, PORT_PHYS_LINK_STATUS);
 	bool link_up;
 
-	link_up = link_status & (1 << rocker_port->pport);
+	link_up = link_status & (1ULL << rocker_port->pport);
 	if (link_up)
 		netif_carrier_on(rocker_port->dev);
 	else
-- 
2.43.0


