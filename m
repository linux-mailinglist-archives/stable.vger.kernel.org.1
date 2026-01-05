Return-Path: <stable+bounces-204912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06517CF57F9
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 21:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93F31305DD9D
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 20:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C5C2874FA;
	Mon,  5 Jan 2026 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ypz8tEcU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FAC1D7E42
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767644309; cv=none; b=CSt5bDL+pgDKY2T7AxrSibwLF/skOOEP78BXD2cpQgND+AV4MIWmqvl2pExcIYJAvGH78Fd8exWs7qC37icjU0FHTXnNQsAjovFvDT3utzahCbICabTfCPkd3EJfZqrzwl2NR4VvsQRopEJz3X8n53M/rTUvRPktFGYyODzLUgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767644309; c=relaxed/simple;
	bh=yr2qNx8fTWh/B2E6F+znIoSLvRn/dayJ8VER94IaGNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBQZ2Wt3g4rbTB3lqvtKr0Oe8YmWVuguzx2RZANRy1bnVzdojqyP2GfCbOgG5p6FnjeuFioLCc/UnhlBcP7DgCtnTwU6ywTXQa58I7bGANYCw29vj8K9/MgypSQe3JSG+hcQw+i7860fnP56LYAZKvMNKA6OkcVWeKg6lCxY8Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ypz8tEcU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3127CC116D0;
	Mon,  5 Jan 2026 20:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767644308;
	bh=yr2qNx8fTWh/B2E6F+znIoSLvRn/dayJ8VER94IaGNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ypz8tEcUFcdCrc/87jgrksH+vZxslQmJ+gw5bfHzjSEp+y6dlKjSggb0D63NhFXqA
	 J458wSnPoyolkk7B7InOwhrgX8Tei8eUP8srGfhEpuf9Ri/EShfFrAE6NP3HwLabSn
	 Hn6sQIMrvDx97jX5tVViy+1iCaflGeH/G2SmgEqCHeyDDDyW6W4FxA5eMOLrF8dzQU
	 hPDyPG0FAt/xdJZq1zUOngkkEwJg6EaAul0/+/clOUJ+k+xRC683d2Kze8GF6vVVF6
	 iWl7wWVyZQeWhwK/1L76i7fORpaTR5qx4ulVXx0DXYtKMfFC9R8mjxf5v4y5Od4fM/
	 A/tVabbaSC5SQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miaoqian Lin <linmq006@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] media: renesas: rcar_drif: fix device node reference leak in rcar_drif_bond_enabled
Date: Mon,  5 Jan 2026 15:18:26 -0500
Message-ID: <20260105201826.2771666-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010524-trespass-although-c962@gregkh>
References: <2026010524-trespass-although-c962@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit 445e1658894fd74eab7e53071fa16233887574ed ]

The function calls of_parse_phandle() which returns
a device node with an incremented reference count. When the bonded device
is not available, the function
returns NULL without releasing the reference, causing a reference leak.

Add of_node_put(np) to release the device node reference.
The of_node_put function handles NULL pointers.

Found through static analysis by reviewing the doc of of_parse_phandle()
and cross-checking its usage patterns across the codebase.

Fixes: 7625ee981af1 ("[media] media: platform: rcar_drif: Add DRIF support")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rcar_drif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/rcar_drif.c b/drivers/media/platform/rcar_drif.c
index 083dba95beaa..c5161c39c045 100644
--- a/drivers/media/platform/rcar_drif.c
+++ b/drivers/media/platform/rcar_drif.c
@@ -1253,6 +1253,7 @@ static struct device_node *rcar_drif_bond_enabled(struct platform_device *p)
 	if (np && of_device_is_available(np))
 		return np;
 
+	of_node_put(np);
 	return NULL;
 }
 
-- 
2.51.0


