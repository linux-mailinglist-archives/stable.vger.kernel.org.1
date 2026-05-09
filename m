Return-Path: <stable+bounces-244912-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JkgNWG5/mkRvgAAu9opvQ
	(envelope-from <stable+bounces-244912-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 06:34:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2625D4FE11C
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 06:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5A6F300EF66
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 04:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AE233263B;
	Sat,  9 May 2026 04:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Za4zVImj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B214242050
	for <stable@vger.kernel.org>; Sat,  9 May 2026 04:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778301276; cv=none; b=JKZxbq2u1aD9jt+uH1yJnkp2WVTlRuVW85RcPLOGHVqp9JDngsFBsKCEABW3qV02OTFjIrrea1AG8mGYph6wy4dO0dn1/PxpOmBc5FttTHS7RDre+LZkOCmad7YQ57nu8er3cC54GkHWktb3VFyNXIrwm7n8czp83/bG3g5yEfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778301276; c=relaxed/simple;
	bh=gtxY+4TOi0oA41qVHGkJ/QLj89NC1FA7J5o+n/DdpMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KIvfUd49Iu1+QKvP1LgKWEhVZ6TSPvm27ocLLWXOTUX5X8nVF8zGsyRbv6ZYa6pW+qFBxIdSakh3LpL4v01ndQMuyVLCC0sPnABCBLAk8kJcvD9l/lDRhvS1FfCVWljjB4UBxwbFAJzxXEsKic8cMkgynrFFeHkeQmf8llntPZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Za4zVImj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b9705613ddso17123785ad.1
        for <stable@vger.kernel.org>; Fri, 08 May 2026 21:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778301275; x=1778906075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qHby+hWH9+W424QK2ah85IJT+/j+8nWOsWmsllDI9MU=;
        b=Za4zVImjLqNml7p+0s6UTUqQNeP/SEyVIro4wSxgQJ3NUs1cEW6A0wMYtf5GYWNxbF
         RozOOdcDWYT8rrT8qoTcmfE0eur2Ww3qEHDWFFL8PYSrs4LJkV4vk8MYH6DGLlJXDdtG
         rBNuZ5iokYX+8c/Qvh5TxFToyqcJF4XBLdYadxvAZMIk3OCbMazgcVCN+ZIk0+Rp+UTk
         0aivQHBlXrubf8pjMOqvmPFM+/AB6T+5guxoTaQl1UHAuonJIPHLvzlW60y0de2RHIx2
         XilEO1tk+qWqoo0SZUXLKps+Lh1DhphCEINTi+fCq9KzsTiljloMQtKW/rKD2mOK4F/v
         BqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778301275; x=1778906075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHby+hWH9+W424QK2ah85IJT+/j+8nWOsWmsllDI9MU=;
        b=dqjsab110mES4J1IQlvGn5FhEADpurceawET4LgRTm3MFms/IV2mXmE/c4zgeSbhOv
         +A6EeNoygjtQXCtUW/VMNVnaNfIGxhqyOFBl8MRUNzQb5t5fAJznvSaqE6IfRcWdDXRy
         SCKqk92VlmixGFTIwEJo1kd2oSw9ErHvjwfN2oT/C0R83SOXz6N5iDdU3j8Ov/xWGOEZ
         r0LlAU0IckwLOLP3rZpUUs6DGVl8eOPmJLDBVMB+4qhrbGNS4R7mBLIeXiSCHCQUj9we
         ZjfXRwiU0wF/F8n1zABlyigPmUO15l2N7WpiOPcZhYj9kb4mYsCdgDFXexgpMQrD61wd
         cE2w==
X-Forwarded-Encrypted: i=1; AFNElJ+2QZTuCbL3Ma6mJBtmTc3YhA6q/Eg5c5GWBlvdWzF7RX+qA84vQbGzOEfEzNZCLDXK44Fw8SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUGtp9uPIX6T2Nffky83OXGxjZkP3+YCGv+4+xoeqfI9UDcb4O
	PWuCW4anDBSr7hsUZx1kXrAyaaCf8dwhz3w2s79ByvbY7PEtWo3BP6yL
X-Gm-Gg: Acq92OG2LWApeoQG5TIqBxl2F1vfrpJ+bkbk3vimU86jrQPZ+Hv5lP42lJBSCTrTpgq
	dH/Kmt9nEHadfzo5+P/PxfzxnN1RUNifE88uV1wmCf42G3O/EUMBg7rhG3TtD+eNxd8GzGR0feK
	fyVyrDbJbRMMutJ3ipsGMpFouJhHBWRKQnpsUMwUHDHmHOmS0kNDz9FyJ/TRnCEzXl/bcbKSBls
	liodd4Ohqor5jNEAE/rHdmfVc5f6g6mpj49ki3DcTwglKaGWZVXDluk2wV5ZqyaAbDMyldjFOYw
	Kjs0WHycN16Wob2Vk1lVdEhhiNP6F7VMjCeS7gqhWH/4D8chB5ZzLdnyEsX6yQqAypSTWQy+Ocv
	XNnxT0s6Aus2343Xe25n0TWkPl3HlijsFOo7qKZ5Fr33uvJsqE+7+nBaBIfF1heCASPY/VQijgj
	NwasmKqciAPOGzMpKTuZeW3Gs+BoCTNjF9YCV5VhuOqjtwLSZyPJtEOYk=
X-Received: by 2002:a17:903:1d2:b0:2b0:663f:6b53 with SMTP id d9443c01a7336-2ba7908bfb1mr159909685ad.13.1778301274960;
        Fri, 08 May 2026 21:34:34 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([203.208.189.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e6199csm52018435ad.55.2026.05.08.21.34.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 08 May 2026 21:34:34 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Felix Fietkau <nbd@nbd.name>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mac80211: capture fast-RX rate before mesh reuses skb->cb
Date: Sat,  9 May 2026 12:34:28 +0800
Message-ID: <20260509043427.60322-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2625D4FE11C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244912-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

ieee80211_invoke_fast_rx() reads RX status through
IEEE80211_SKB_RXCB(skb), which aliases the same skb->cb storage
that ieee80211_rx_mesh_data() reuses as IEEE80211_TX_INFO.  In the
unicast forward path, mesh_data does:

	info = IEEE80211_SKB_CB(fwd_skb);
	memset(info, 0, sizeof(*info));

on the same skb the caller still names via rx->skb, then either
queues the skb for TX (success) or kfree_skb()'s it (no-route)
before returning RX_QUEUED.  The caller's RX_QUEUED arm then
calls sta_stats_encode_rate(status) on memory that is either
zeroed (success path) or freed (no-route path).  The latter is
KASAN slab-use-after-free in ieee80211_prepare_and_rx_handle.

Fix by encoding the rate from status before invoking
ieee80211_rx_mesh_data(), so the RX_QUEUED arm consumes a value
captured while status was still backed by valid memory.

Fixes: 3468e1e0c639 ("wifi: mac80211: add mesh fast-rx support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 net/mac80211/rx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4984,6 +4984,7 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 		u8 sa[ETH_ALEN];
 	} addrs __aligned(2);
 	struct ieee80211_sta_rx_stats *stats;
+	u32 encoded_rate;

 	/* for parallel-rx, we need to have DUP_VALIDATED, otherwise we write
 	 * to a common data structure; drivers can implement that per queue
@@ -5090,11 +5091,14 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 	/* push the addresses in front */
 	memcpy(skb_push(skb, sizeof(addrs)), &addrs, sizeof(addrs));

+	/* capture before mesh forward may memset or free skb->cb */
+	encoded_rate = sta_stats_encode_rate(status);
+
 	res = ieee80211_rx_mesh_data(rx->sdata, rx->sta, rx->skb);
 	switch (res) {
 	case RX_QUEUED:
 		stats->last_rx = jiffies;
-		stats->last_rate = sta_stats_encode_rate(status);
+		stats->last_rate = encoded_rate;
 		return true;
 	case RX_CONTINUE:
 		break;
--
2.50.1


