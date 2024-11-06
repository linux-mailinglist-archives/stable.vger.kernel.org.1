Return-Path: <stable+bounces-91493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 757DA9BEE3C
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057521F246A1
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364D71E04B2;
	Wed,  6 Nov 2024 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Et2jIJKo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E763D1DFE38;
	Wed,  6 Nov 2024 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898894; cv=none; b=t2h/m72TAbwthGZfhD0/gwkcvrY1Ms0ub/dgVdBnnvnBqQzlI1Y6CopJXMuEUQid2ypp1P6Go88re3mC+3LnrSEFwN4iS3eDyUhKUWi2y6TOBz8TpYD7Z9rU8A8evcWm7ZsDpA51Dk71TJ1wnucO8/CmPHwy6C0iorefULUujJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898894; c=relaxed/simple;
	bh=QRMOJmNTDSvo54EG3NJwHiYMN3owKhMrpHqYwHBWXu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfjEFHl30ZAZyj77eVdMY6GFgzWDivxgM/R+hCpJf9DWpZeRqDblcnvR9cdRkOTX7/sEHJTBrLNMSjGIZRIqj09PGN0s+I/2NOXQI/aGrp5A51Mg1td7RrsPZ408HXKeW+5G38QPDbCavSoGjvJlt2wP1Rz7SuM8RhuO+N1XTRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Et2jIJKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D83CC4CECD;
	Wed,  6 Nov 2024 13:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898893;
	bh=QRMOJmNTDSvo54EG3NJwHiYMN3owKhMrpHqYwHBWXu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Et2jIJKokT7PTcqx59E/HW0H4Iv4zJTq9t36wR3Qh1upeq9DmLNpP6rsjbIsAV7AD
	 edvpgU1M2CtRT78SXQxjTD24L6ClT2tTKG12CXHYvHFYWZCJzFfpJU2lCtF0ghj2n7
	 hL288YJi6Wo7bpWjjDXzbnvDiIw/HxFQnN608Eso=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ben Greear <greearb@candelatech.com>,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>,
	Sven Eckelmann <sven@narfation.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.4 384/462] mac80211: Fix NULL ptr deref for injected rate info
Date: Wed,  6 Nov 2024 13:04:37 +0100
Message-ID: <20241106120341.006121527@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>

commit bddc0c411a45d3718ac535a070f349be8eca8d48 upstream.

The commit cb17ed29a7a5 ("mac80211: parse radiotap header when selecting Tx
queue") moved the code to validate the radiotap header from
ieee80211_monitor_start_xmit to ieee80211_parse_tx_radiotap. This made is
possible to share more code with the new Tx queue selection code for
injected frames. But at the same time, it now required the call of
ieee80211_parse_tx_radiotap at the beginning of functions which wanted to
handle the radiotap header. And this broke the rate parser for radiotap
header parser.

The radiotap parser for rates is operating most of the time only on the
data in the actual radiotap header. But for the 802.11a/b/g rates, it must
also know the selected band from the chandef information. But this
information is only written to the ieee80211_tx_info at the end of the
ieee80211_monitor_start_xmit - long after ieee80211_parse_tx_radiotap was
already called. The info->band information was therefore always 0
(NL80211_BAND_2GHZ) when the parser code tried to access it.

For a 5GHz only device, injecting a frame with 802.11a rates would cause a
NULL pointer dereference because local->hw.wiphy->bands[NL80211_BAND_2GHZ]
would most likely have been NULL when the radiotap parser searched for the
correct rate index of the driver.

Cc: stable@vger.kernel.org
Reported-by: Ben Greear <greearb@candelatech.com>
Fixes: cb17ed29a7a5 ("mac80211: parse radiotap header when selecting Tx queue")
Signed-off-by: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
[sven@narfation.org: added commit message]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Link: https://lore.kernel.org/r/20210530133226.40587-1-sven@narfation.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/mac80211.h |    8 ++++++-
 net/mac80211/tx.c      |   52 +++++++++++++++++++++++++++++++++----------------
 2 files changed, 43 insertions(+), 17 deletions(-)

--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6135,7 +6135,13 @@ bool ieee80211_tx_prepare_skb(struct iee
 			      int band, struct ieee80211_sta **sta);
 
 /**
- * Sanity-check and parse the radiotap header of injected frames
+ * ieee80211_parse_tx_radiotap - Sanity-check and parse the radiotap header
+ *				 of injected frames.
+ *
+ * To accurately parse and take into account rate and retransmission fields,
+ * you must initialize the chandef field in the ieee80211_tx_info structure
+ * of the skb before calling this function.
+ *
  * @skb: packet injected by userspace
  * @dev: the &struct device of this 802.11 device
  */
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2034,6 +2034,26 @@ void ieee80211_xmit(struct ieee80211_sub
 	ieee80211_tx(sdata, sta, skb, false, txdata_flags);
 }
 
+static bool ieee80211_validate_radiotap_len(struct sk_buff *skb)
+{
+	struct ieee80211_radiotap_header *rthdr =
+		(struct ieee80211_radiotap_header *)skb->data;
+
+	/* check for not even having the fixed radiotap header part */
+	if (unlikely(skb->len < sizeof(struct ieee80211_radiotap_header)))
+		return false; /* too short to be possibly valid */
+
+	/* is it a header version we can trust to find length from? */
+	if (unlikely(rthdr->it_version))
+		return false; /* only version 0 is supported */
+
+	/* does the skb contain enough to deliver on the alleged length? */
+	if (unlikely(skb->len < ieee80211_get_radiotap_len(skb->data)))
+		return false; /* skb too short for claimed rt header extent */
+
+	return true;
+}
+
 bool ieee80211_parse_tx_radiotap(struct sk_buff *skb,
 				 struct net_device *dev)
 {
@@ -2042,8 +2062,6 @@ bool ieee80211_parse_tx_radiotap(struct
 	struct ieee80211_radiotap_header *rthdr =
 		(struct ieee80211_radiotap_header *) skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ieee80211_supported_band *sband =
-		local->hw.wiphy->bands[info->band];
 	int ret = ieee80211_radiotap_iterator_init(&iterator, rthdr, skb->len,
 						   NULL);
 	u16 txflags;
@@ -2056,17 +2074,8 @@ bool ieee80211_parse_tx_radiotap(struct
 	u8 vht_mcs = 0, vht_nss = 0;
 	int i;
 
-	/* check for not even having the fixed radiotap header part */
-	if (unlikely(skb->len < sizeof(struct ieee80211_radiotap_header)))
-		return false; /* too short to be possibly valid */
-
-	/* is it a header version we can trust to find length from? */
-	if (unlikely(rthdr->it_version))
-		return false; /* only version 0 is supported */
-
-	/* does the skb contain enough to deliver on the alleged length? */
-	if (unlikely(skb->len < ieee80211_get_radiotap_len(skb->data)))
-		return false; /* skb too short for claimed rt header extent */
+	if (!ieee80211_validate_radiotap_len(skb))
+		return false;
 
 	info->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT |
 		       IEEE80211_TX_CTL_DONTFRAG;
@@ -2192,6 +2201,9 @@ bool ieee80211_parse_tx_radiotap(struct
 		return false;
 
 	if (rate_found) {
+		struct ieee80211_supported_band *sband =
+			local->hw.wiphy->bands[info->band];
+
 		info->control.flags |= IEEE80211_TX_CTRL_RATE_INJECT;
 
 		for (i = 0; i < IEEE80211_TX_MAX_RATES; i++) {
@@ -2205,7 +2217,7 @@ bool ieee80211_parse_tx_radiotap(struct
 		} else if (rate_flags & IEEE80211_TX_RC_VHT_MCS) {
 			ieee80211_rate_set_vht(info->control.rates, vht_mcs,
 					       vht_nss);
-		} else {
+		} else if (sband) {
 			for (i = 0; i < sband->n_bitrates; i++) {
 				if (rate * 5 != sband->bitrates[i].bitrate)
 					continue;
@@ -2242,8 +2254,8 @@ netdev_tx_t ieee80211_monitor_start_xmit
 	info->flags = IEEE80211_TX_CTL_REQ_TX_STATUS |
 		      IEEE80211_TX_CTL_INJECTED;
 
-	/* Sanity-check and process the injection radiotap header */
-	if (!ieee80211_parse_tx_radiotap(skb, dev))
+	/* Sanity-check the length of the radiotap header */
+	if (!ieee80211_validate_radiotap_len(skb))
 		goto fail;
 
 	/* we now know there is a radiotap header with a length we can use */
@@ -2356,6 +2368,14 @@ netdev_tx_t ieee80211_monitor_start_xmit
 
 	info->band = chandef->chan->band;
 
+	/*
+	 * Process the radiotap header. This will now take into account the
+	 * selected chandef above to accurately set injection rates and
+	 * retransmissions.
+	 */
+	if (!ieee80211_parse_tx_radiotap(skb, dev))
+		goto fail_rcu;
+
 	/* remove the injection radiotap header */
 	skb_pull(skb, len_rthdr);
 



