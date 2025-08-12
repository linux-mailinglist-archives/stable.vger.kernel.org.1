Return-Path: <stable+bounces-167264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFAAB22F46
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C0C1A26DE6
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1612FDC22;
	Tue, 12 Aug 2025 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Nn6AS90"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6769E2FD1CE;
	Tue, 12 Aug 2025 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020233; cv=none; b=h/jbvqmR4LaJOWdbJ9HKQZIc+d3ubzaJl/vW0FV03+VSggaxbrSujeFtlRxZ/tkqqEE1Ly2J/afQ9fYyZFhziJBx2E3mToHKXpGdb9fzXWUtsi+oIIrUzvu45m6rTxNMpMvCstcH4XhRlJGDDiDjLcp3gfu5T9sCCPxpuY6WJWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020233; c=relaxed/simple;
	bh=xGrQSHPsBdykj8Ms2p+RrGpnDLz4kyyFJ0CDmtVYPjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rd7ba2Cc78d1XVJ/B5+264zxK8udbfXq2HG8DrJQsKJsXR3cruBl90MMq0tdUCqJJ+tKd7/NZPMGAfnNkqgYK+5ZFDS3FLAljGdPTQSdDS2Wn+fj5UhkugNIYA31N7Jx8XGH4dtFajBerCUFyo9cZeDK/w/f57qCXyVBqiqlrig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Nn6AS90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA91C4CEF0;
	Tue, 12 Aug 2025 17:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755020233;
	bh=xGrQSHPsBdykj8Ms2p+RrGpnDLz4kyyFJ0CDmtVYPjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2Nn6AS90IC+0IxExfByUynDDtkSy7MbPX2nKWotryteU3ufnt+RQ0tXkr1Fr8a2em
	 gzMowfR1nIIELOBgLg6Tc+IfOrIxZbSlHmu+FZNCwFwe4O0Vb/SlG3IMmpZtWM0h9H
	 ZSNHCKKteE7yVz/bCvmPN9W/jKZ6sgeDEfswiXDg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 019/253] can: dev: can_restart(): reverse logic to remove need for goto
Date: Tue, 12 Aug 2025 19:26:47 +0200
Message-ID: <20250812172949.528414468@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit 8f3ec204d340af183fb2bb21b8e797ac2ed012b2 ]

Reverse the logic in the if statement and eliminate the need for a
goto to simplify code readability.

Link: https://lore.kernel.org/all/20231005-can-dev-fix-can-restart-v2-3-91b5c1fd922c@pengutronix.de
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Stable-dep-of: c1f3f9797c1f ("can: netlink: can_changelink(): fix NULL pointer deref of struct can_priv::do_set_mode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/dev/dev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 43125ce96f1aa..42c486d1fd10b 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -142,14 +142,11 @@ static void can_restart(struct net_device *dev)
 
 	/* send restart message upstream */
 	skb = alloc_can_err_skb(dev, &cf);
-	if (!skb)
-		goto restart;
-
-	cf->can_id |= CAN_ERR_RESTARTED;
-
-	netif_rx(skb);
+	if (skb) {
+		cf->can_id |= CAN_ERR_RESTARTED;
+		netif_rx(skb);
+	}
 
-restart:
 	netdev_dbg(dev, "restarted\n");
 	priv->can_stats.restarts++;
 
-- 
2.39.5




