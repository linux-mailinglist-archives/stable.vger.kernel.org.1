Return-Path: <stable+bounces-95001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D5A9D722A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05182283F91
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC451F4707;
	Sun, 24 Nov 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUrV3iR7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029B91F429B;
	Sun, 24 Nov 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455537; cv=none; b=K/Hs6NPC+J2vpHf6HnmdeFhs3gDtBdtOL8h1yT1BObe8/dwyoBAkHHKaTOkafK34e0/M/v8FeYLxutRAPInUO8pIhiiS8+7//HUwYvDJTPPB3X0mw4Z8JugTYm66dv9J43m6uvkptXdyyiSplJoDfxxHAFmXdA9GuSh/e9kF4Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455537; c=relaxed/simple;
	bh=hrCde4a35Dm/RsknlHhqqoZ54pz6d+84OwbqpEvUKsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e82nWVAhfS68qWDCegh2GjwtW2vIVC2KI/8qqWId1IIvKBwJijWTcDNh8m0u3fGGI9vRYlVkoWbsdDuxQ+f4gPCjT+9fPe3iIFZ7SALqfvzJ8S16dDiGzfGPQHld5gAH8I4+G5+8cyarWFI3GGKp8gpvUt2K4J6v7l5o8rt57wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUrV3iR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993EFC4CED3;
	Sun, 24 Nov 2024 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455536;
	bh=hrCde4a35Dm/RsknlHhqqoZ54pz6d+84OwbqpEvUKsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MUrV3iR7PUmQonK6CXDeTNOhSwlHgXhehfwtP47ynj8km3B35HV3WtU5pR4EENlSb
	 EK1FrW0oNg2V70cKakiq+PBWjnZLd7y00jkVv1WMeqvpKqMsbMslx08nhtWS402Sho
	 ahLS5QfUYLh9luWPXoEC2IBM6Dfcs4+ZYFNo1IwCdd/fz31yMF5UjIqwgtzExpXpaj
	 6b3SGck3Sh4VbcDGvMh3kMvm5fyt7eh7FdGsB9RRuFt0mswBu06500cE/hJ8e0UBUD
	 9Z82RV0QQh2Q+Wk54cdlOdCB4rY6yD6brm1tY+yG8cTO+QkydOTk94NL258HUEOWGV
	 H831THlksG05A==
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
Subject: [PATCH AUTOSEL 6.12 105/107] rocker: fix link status detection in rocker_carrier_init()
Date: Sun, 24 Nov 2024 08:30:05 -0500
Message-ID: <20241124133301.3341829-105-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 84fa911c78db5..fe0bf1d3217af 100644
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


