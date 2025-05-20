Return-Path: <stable+bounces-145439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF69ABDC26
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63354E2FE0
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7713224887A;
	Tue, 20 May 2025 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vKNjMKiK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E3E246773;
	Tue, 20 May 2025 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750182; cv=none; b=O6BlYOktw1eHmcjzYTcQ13J4/2Bq1eE0j22x+mrwPRI8lyW+Gu79EshGZP5S8K+JWh0YTdiwA4r434Bf3LM1N9jNs/B+nExMYJbGSbGrTRyndc7+1amlwvUx9tTyYYlzmNhb4fmGz4EDlWaNdRkvfYLffd3d+FWUSZ3uKKEYNnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750182; c=relaxed/simple;
	bh=DCGMaGKDc9+gU9DmS7a69EdSpxlLDB5fAUy1Te83x8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ey6hZc163ICleP3TvSpMC7zEUOzBzcKQYUp/XTOfh3aj1fSYqKjlmoZTaKPXVd19OYn7nXqyRE4hybF8AHcCq00U1l+4jMI2AfH/u4QCR7G7MmgbZr/1oLuCTkRS+akaWHNR5aVtQTbuyHPcpAfCgWFKaQ0/AiDDJZso91OwAXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vKNjMKiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3C3C4CEE9;
	Tue, 20 May 2025 14:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747750180;
	bh=DCGMaGKDc9+gU9DmS7a69EdSpxlLDB5fAUy1Te83x8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vKNjMKiK2dh5Xv9w7HY5fRoh3bEGprKxBlhbj7Ipotp+fOY0qVykF/V7J0Tj8ciHq
	 8HWHfHDNYxggvvee7GA44HgX8d7+wbUZhegBITzOh7JCqAXbXSkVjmNbd9JEPqcEnF
	 EwRJl84mr2nF34t6vTZxC/etH7SBlOxmzzJZoDVc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 067/143] tsnep: fix timestamping with a stacked DSA driver
Date: Tue, 20 May 2025 15:50:22 +0200
Message-ID: <20250520125812.695245116@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125810.036375422@linuxfoundation.org>
References: <20250520125810.036375422@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gerhard Engleder <gerhard@engleder-embedded.com>

[ Upstream commit b3ca9eef6646576ad506a96d941d87a69f66732a ]

This driver is susceptible to a form of the bug explained in commit
c26a2c2ddc01 ("gianfar: Fix TX timestamping with a stacked DSA driver")
and in Documentation/networking/timestamping.rst section "Other caveats
for MAC drivers", specifically it timestamps any skb which has
SKBTX_HW_TSTAMP, and does not consider if timestamping has been enabled
in adapter->hwtstamp_config.tx_type.

Evaluate the proper TX timestamping condition only once on the TX
path (in tsnep_xmit_frame_ring()) and store the result in an additional
TX entry flag. Evaluate the new TX entry flag in the TX confirmation path
(in tsnep_tx_poll()).

This way SKBTX_IN_PROGRESS is set by the driver as required, but never
evaluated. SKBTX_IN_PROGRESS shall not be evaluated as it can be set
by a stacked DSA driver and evaluating it would lead to unwanted
timestamps.

Fixes: 403f69bbdbad ("tsnep: Add TSN endpoint Ethernet MAC driver")
Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/20250514195657.25874-1-gerhard@engleder-embedded.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/engleder/tsnep_main.c | 30 ++++++++++++++--------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 44da335d66bda..6a6efe2b2bc51 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -67,6 +67,8 @@
 #define TSNEP_TX_TYPE_XDP_NDO_MAP_PAGE	(TSNEP_TX_TYPE_XDP_NDO | TSNEP_TX_TYPE_MAP_PAGE)
 #define TSNEP_TX_TYPE_XDP		(TSNEP_TX_TYPE_XDP_TX | TSNEP_TX_TYPE_XDP_NDO)
 #define TSNEP_TX_TYPE_XSK		BIT(12)
+#define TSNEP_TX_TYPE_TSTAMP		BIT(13)
+#define TSNEP_TX_TYPE_SKB_TSTAMP	(TSNEP_TX_TYPE_SKB | TSNEP_TX_TYPE_TSTAMP)
 
 #define TSNEP_XDP_TX		BIT(0)
 #define TSNEP_XDP_REDIRECT	BIT(1)
@@ -387,8 +389,7 @@ static void tsnep_tx_activate(struct tsnep_tx *tx, int index, int length,
 	if (entry->skb) {
 		entry->properties = length & TSNEP_DESC_LENGTH_MASK;
 		entry->properties |= TSNEP_DESC_INTERRUPT_FLAG;
-		if ((entry->type & TSNEP_TX_TYPE_SKB) &&
-		    (skb_shinfo(entry->skb)->tx_flags & SKBTX_IN_PROGRESS))
+		if ((entry->type & TSNEP_TX_TYPE_SKB_TSTAMP) == TSNEP_TX_TYPE_SKB_TSTAMP)
 			entry->properties |= TSNEP_DESC_EXTENDED_WRITEBACK_FLAG;
 
 		/* toggle user flag to prevent false acknowledge
@@ -480,7 +481,8 @@ static int tsnep_tx_map_frag(skb_frag_t *frag, struct tsnep_tx_entry *entry,
 	return mapped;
 }
 
-static int tsnep_tx_map(struct sk_buff *skb, struct tsnep_tx *tx, int count)
+static int tsnep_tx_map(struct sk_buff *skb, struct tsnep_tx *tx, int count,
+			bool do_tstamp)
 {
 	struct device *dmadev = tx->adapter->dmadev;
 	struct tsnep_tx_entry *entry;
@@ -506,6 +508,9 @@ static int tsnep_tx_map(struct sk_buff *skb, struct tsnep_tx *tx, int count)
 				entry->type = TSNEP_TX_TYPE_SKB_INLINE;
 				mapped = 0;
 			}
+
+			if (do_tstamp)
+				entry->type |= TSNEP_TX_TYPE_TSTAMP;
 		} else {
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i - 1];
 
@@ -559,11 +564,12 @@ static int tsnep_tx_unmap(struct tsnep_tx *tx, int index, int count)
 static netdev_tx_t tsnep_xmit_frame_ring(struct sk_buff *skb,
 					 struct tsnep_tx *tx)
 {
-	int count = 1;
 	struct tsnep_tx_entry *entry;
+	bool do_tstamp = false;
+	int count = 1;
 	int length;
-	int i;
 	int retval;
+	int i;
 
 	if (skb_shinfo(skb)->nr_frags > 0)
 		count += skb_shinfo(skb)->nr_frags;
@@ -580,7 +586,13 @@ static netdev_tx_t tsnep_xmit_frame_ring(struct sk_buff *skb,
 	entry = &tx->entry[tx->write];
 	entry->skb = skb;
 
-	retval = tsnep_tx_map(skb, tx, count);
+	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
+	    tx->adapter->hwtstamp_config.tx_type == HWTSTAMP_TX_ON) {
+		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+		do_tstamp = true;
+	}
+
+	retval = tsnep_tx_map(skb, tx, count, do_tstamp);
 	if (retval < 0) {
 		tsnep_tx_unmap(tx, tx->write, count);
 		dev_kfree_skb_any(entry->skb);
@@ -592,9 +604,6 @@ static netdev_tx_t tsnep_xmit_frame_ring(struct sk_buff *skb,
 	}
 	length = retval;
 
-	if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
-		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
-
 	for (i = 0; i < count; i++)
 		tsnep_tx_activate(tx, (tx->write + i) & TSNEP_RING_MASK, length,
 				  i == count - 1);
@@ -845,8 +854,7 @@ static bool tsnep_tx_poll(struct tsnep_tx *tx, int napi_budget)
 
 		length = tsnep_tx_unmap(tx, tx->read, count);
 
-		if ((entry->type & TSNEP_TX_TYPE_SKB) &&
-		    (skb_shinfo(entry->skb)->tx_flags & SKBTX_IN_PROGRESS) &&
+		if (((entry->type & TSNEP_TX_TYPE_SKB_TSTAMP) == TSNEP_TX_TYPE_SKB_TSTAMP) &&
 		    (__le32_to_cpu(entry->desc_wb->properties) &
 		     TSNEP_DESC_EXTENDED_WRITEBACK_FLAG)) {
 			struct skb_shared_hwtstamps hwtstamps;
-- 
2.39.5




