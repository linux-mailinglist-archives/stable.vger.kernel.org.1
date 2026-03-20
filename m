Return-Path: <stable+bounces-227536-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HEyHFFBvWn28AIAu9opvQ
	(envelope-from <stable+bounces-227536-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 13:45:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDD52DA75B
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 13:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 670D1301703D
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 12:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E38376477;
	Fri, 20 Mar 2026 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiB0OFAo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B73837E312
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774010526; cv=none; b=rvurgzmjdfFoBcmw+/fjOLmn0Ry6x0byPRfNeqC/7iaLAtzxyezztGfYZ23kBZhW8xNSIOTWz9S6QV+DssXansW6ndPnA5joQdZkraBp7hj9OOUdeOPpvzg9ixnodAoIaOsnde03UN24eskcVY6Cj3jMcc/zaSx+hJ/CWofE1IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774010526; c=relaxed/simple;
	bh=P2YINNi1o3rVNh6mMpCU/PhtHBfjk/tcXMEgZ6BgClo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJIH59BSvmet5DQUmxfw+RqSgqhHOEaQs/wj9jCFCro2Aeyj+pTeftUDXvPiSF7UQc7uUR+hkrI/gEiSTTD6f4KMPLPZqtdDo67Tn5TQRJvHIU8hLQxo6odE7oG9Taq+V6yYZ29d2i5AabN+WX5K9HnHbWhTANEijKum5CvsaW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiB0OFAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177C7C4CEF7;
	Fri, 20 Mar 2026 12:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774010525;
	bh=P2YINNi1o3rVNh6mMpCU/PhtHBfjk/tcXMEgZ6BgClo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UiB0OFAokKyTAt6TkTC0IhYWdYV5wRH9Ii6KiXlC8EGomC39BR7GS3TBkrFW6y88n
	 GRij6oOq40xXIi7p9YWBlQcmqJll0J0FIJ54hgel6nDi9hGf67CWc73JpQJ9OYNZey
	 RVuucSoG7PPDokDc+22DDJZDYJlSj0mlOxG8BWBKPBlDDFILfmlgOIv8y/EfZ+2nQE
	 NFHsXX5pg+km0OtPjEe8c7lwLYJRKF4/arsZ+QGKzAgrkiKg+TEwz4qQ8pGJD4ORCS
	 xnXweab39S9R50nUd81rljaW7U+YpinEkf61rbvWHQnvDYpclcOebT7jH7vCBGH2Bs
	 HiSYZPogD08vw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19.y 1/2] net: macb: Introduce gem_init_rx_ring()
Date: Fri, 20 Mar 2026 08:42:02 -0400
Message-ID: <20260320124203.4124440-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026032059-helpline-reason-16c7@gregkh>
References: <2026032059-helpline-reason-16c7@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227536-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: DBDD52DA75B
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
index 256cb5bcfac74..d81fe135dcba4 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2669,6 +2669,14 @@ static void macb_init_tieoff(struct macb *bp)
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
@@ -2686,10 +2694,7 @@ static void gem_init_rings(struct macb *bp)
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


