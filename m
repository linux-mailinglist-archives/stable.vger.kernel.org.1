Return-Path: <stable+bounces-227561-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJuqHNlmvWnL9gIAu9opvQ
	(envelope-from <stable+bounces-227561-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:25:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E57212DCA30
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04E513055FA3
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 15:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D073C197D;
	Fri, 20 Mar 2026 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OviWkPUc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BCF279DC8
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019336; cv=none; b=iEYBn8nRMeJeT/ObCK9oeQNN0oLzCvQdjaUraeLiwA6cH5llAwAkzfI+P2Serinur4Eono+UtIu5quAsGBF+ruhpI/PlNsArJ0s6vFYcH8jmj5lnQCXDWMSUjLTaYlVJiFokMsQqXP361gQ5tYvbEMVmfP/suFYkUMn/sSJ0eSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019336; c=relaxed/simple;
	bh=0sYby9ZtHXh+hi4xOzy32GQYL42EvP7PbLzB0UZ5w9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUYa9ewU3jqRkFF1E52qqmWpldgnIwmPuUZFFy/FG+1GqNtSChVXbSJhz/DdIJBa/KLZUNRY3HoiNnR2L/ZDp3C4Joypd0NcaX0gT6YKXvZ3GzQn7sykTw4ryFRHX2fOfsiXalt69MXSVTlKqLi+o7na3I46XnAkHjwgQ0QCUcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OviWkPUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B4BC19425;
	Fri, 20 Mar 2026 15:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774019335;
	bh=0sYby9ZtHXh+hi4xOzy32GQYL42EvP7PbLzB0UZ5w9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OviWkPUcEhaBtqeOjt0HxR43NbUtCx2krcepZQ49tvN2YmWs4Kw0UXzRzURl5ynUy
	 HJy+kHvu8QMXHVHwRsXNREDehZKFuowgr6NGfVaUQ63TFZ+H7INSRDQTnGuIB0YBss
	 +6ljCoZu+Bc9MR4grnjJekx5f0pcYZ52764f/Jhlo4U1x28EnTn988p1MfKvAgFuHy
	 H6mrbElJhoYRRQvv0ikR9iglWM/jK4b7ZWeX/oSdV3R45gJo/BIN7md0KshDvdW660
	 iqa1PlpRlwqKQK1+5ok3xZ3O4aJ0FtTCtTRZnQQs8TUrNeLWEhPsI+Gfb39sxW25CA
	 VEjieY2inIZog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] net: macb: Introduce gem_init_rx_ring()
Date: Fri, 20 Mar 2026 11:08:51 -0400
Message-ID: <20260320150852.4191566-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260320150852.4191566-1-sashal@kernel.org>
References: <2026032002-habitual-dolly-4a11@gregkh>
 <20260320150852.4191566-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227561-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.979];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: E57212DCA30
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
index 043491cadcb7f..7374e9da71f1d 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2546,6 +2546,14 @@ static void macb_init_tieoff(struct macb *bp)
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
@@ -2563,10 +2571,7 @@ static void gem_init_rings(struct macb *bp)
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


