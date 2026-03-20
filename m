Return-Path: <stable+bounces-227558-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MhiDgBlvWlF9gIAu9opvQ
	(envelope-from <stable+bounces-227558-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:17:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3128E2DC7E8
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C836A3046475
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 14:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8993C2771;
	Fri, 20 Mar 2026 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1TBIv7j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC7E3BED13
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018670; cv=none; b=lOGw1i2upjwIxwzZ5XJw3yoFGVjC28GDNmiPlxFuHa/Kzw7rg+/at8gxgic1B05+I5NrECnU3lqShQrfidkHSKjqvMO5IfxPlFMO274jQnm0aNWx6v4a3vtFrmLzWpM0qaqdMkQht5HSHuNvPraeDyoP89E0ZU+Rrxb4TJ2LCYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018670; c=relaxed/simple;
	bh=3+3yf/vhZ3eApzKXMWwnqPIXW2Hsx2RQuMZAhDB+wNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLCBvYsZ/t7qeo+8OYS7Ey4z3Rp93j2y90kS5sj5iyB1z6A5bYTZrCpHj3fNh8Cut3x0LPZzR9ML40dvGEIEUEb26vAxl6vq1SO8hjfAIFR7gCTLps+zq7kigNDm1hPVoNiz2L2+TJ50CS07PjDUrxHRXfkwAldRsN4ia1328nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1TBIv7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3D4C2BCB1;
	Fri, 20 Mar 2026 14:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774018670;
	bh=3+3yf/vhZ3eApzKXMWwnqPIXW2Hsx2RQuMZAhDB+wNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f1TBIv7jgYGMua1XQFGQ/aBpC4sCVS5q+HhvRYQf5XYRqVuyVbiWso0QAweAYvyg7
	 rfRE+IEnQDgx81rrtvlP021dqVE4xc/QvoPBSN3D0vBF1I5wLJf6MD4D7o6P+hfvxc
	 b+OZULw4EhGHJbaJ0GM7wi5GAbxZmq0LZSNnSE8oP2QGsDrfJPjcHdDRDLQLiqy559
	 e8GxRC5/no7N3rZoSEPIJpIpSFlchr7ohA21LSDWj2kSSBcrwLA+ZwtrhLml9TOIK9
	 9n3VJLIyWKxJY+fZJGyP0EHDHfFtIxl1ecPlRK4+sr/gqiSn1hfjwtyT1wH9dzakx1
	 vthe6YhGqdA/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] net: macb: Introduce gem_init_rx_ring()
Date: Fri, 20 Mar 2026 10:57:45 -0400
Message-ID: <20260320145746.4187361-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260320145746.4187361-1-sashal@kernel.org>
References: <2026032001-degrease-handcuff-81e4@gregkh>
 <20260320145746.4187361-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227558-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3128E2DC7E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kevin Hao <haokexin@gmail.com>

[ Upstream commit 1a7124ecd655bcaf1845197fe416aa25cff4c3ea ]

Extract the initialization code for the GEM RX ring into a new function.
This change will be utilized in a subsequent patch. No functional changes
are introduced.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260312-macb-versal-v1-1-467647173fa4@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 718d0766ce4c ("net: macb: Reinitialize tx/rx queue pointer registers and rx ring during resume")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 29daa4b484dbf..ffd39103dd860 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2608,6 +2608,14 @@ static void macb_init_tieoff(struct macb *bp)
 	desc->ctrl = 0;
 }
 
+static void gem_init_rx_ring(struct macb_queue *queue)
+{
+	queue->rx_tail = 0;
+	queue->rx_prepared_head = 0;
+
+	gem_rx_refill(queue);
+}
+
 static void gem_init_rings(struct macb *bp)
 {
 	struct macb_queue *queue;
@@ -2625,10 +2633,7 @@ static void gem_init_rings(struct macb *bp)
 		queue->tx_head = 0;
 		queue->tx_tail = 0;
 
-		queue->rx_tail = 0;
-		queue->rx_prepared_head = 0;
-
-		gem_rx_refill(queue);
+		gem_init_rx_ring(queue);
 	}
 
 	macb_init_tieoff(bp);
-- 
2.51.0


