Return-Path: <stable+bounces-225464-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMsRBDZqtmnUBQEAu9opvQ
	(envelope-from <stable+bounces-225464-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 09:13:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA95290364
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 09:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13D913023531
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 08:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F65C24A06D;
	Sun, 15 Mar 2026 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cq/nbTP4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DD3235BE2
	for <stable@vger.kernel.org>; Sun, 15 Mar 2026 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773562417; cv=none; b=atr/tSlOqps1MHdS1cT0J+7g7Po226WPNtbwoE+YEb8DdEN9THZy9IGvbT2/rw2lKHMY9Y0tqhqjFFO1ZfGwH95TjjEFqqUJvp3ci8xvj/4fBlEBQ8h0yKZleJjLZosmghBpYuGfqwW81AYus2dTZFIi0IwNNFJGo1roKKCyYLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773562417; c=relaxed/simple;
	bh=uKmJoLtmmsQeWmKY+Hq9ioE42HsbXjE6fak8QMHJMFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9CWN0RKqfGYx8WJbwx/em2ACRghkmXnMMROeBa5SBDHF9bTVPFokhGDKHfn4u6aCIR6RmKvVNhTJ1225ocojljLvIj/Iot4ZkCYBJWg0pLp260Uer+1vXNCQ75J08z0nYCR2DzOyhzEOvgxqF18fN7oXAWMbKogH/woO8HqDNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cq/nbTP4; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b97b333673eso16570066b.2
        for <stable@vger.kernel.org>; Sun, 15 Mar 2026 01:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773562414; x=1774167214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBdYfpQsARbdjGI37WFIgWl/KvYpW6/tXUSbnC+M6Nw=;
        b=cq/nbTP4vyzFjIfyecfSsafxnW+QtN3XW/HUFPjUXjm3Y6Gdnhsds5Q5YZZGSkuwVv
         j23JOzh0YzjscmX5gnub/LE4a3BxKM43opR0UrfZiODSDGY75ePywS9KyDGmND50R8v2
         UP58/A/3vHWgAvmgxUIAhmzyaUkoDpwTEcuTRiEA2dVMs0bZBtRbz4Cd33t+vDL4maVN
         hjrzJ7kWhhxV0rZrCVuLGM8hToLs8taNMM/LY7lWQIAqNEYKBBh0X5qEPHDVu3axfO33
         wqfUIo/CyqCt3ox1+f7vrdj91a7FEo0DCVgerj1ti53vj7s0foJj3gCqVRkckgRHcjyD
         TzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773562414; x=1774167214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CBdYfpQsARbdjGI37WFIgWl/KvYpW6/tXUSbnC+M6Nw=;
        b=atHrzY840A2Jr4fe+JKVH3TBvOYuLYjA5SPojvio8WipGLaYi8IYijarDdptWNhwBX
         JJY5ymferbGr9Xd1WJLjyMlZh8+3JM0lN+waiQCO6EUdpFg7DAbNMTkcl1uDSgGftzpt
         0RMDP4zP0ompySAWDehmwIBX5/5qvaDQJWqDJQw5XdjhXnO8eOz0FXfO/mCKcjPLjrHn
         YlxeAd6/sjOsCtT4F9+NzBiAcLMglakYK6AxLqJnt0OeIjwcQtYOaR/2tFYVcMo7+WZf
         yX69egD+8rqvzMZW5t7BRYf8486B8Z946EsPaIsD72lkR1CqtvGUp7YWISl7kwyr2rTP
         hZdQ==
X-Gm-Message-State: AOJu0YzLGs48IHIU/6gMv7QQCWd50U7u/mVdGBxctFR5pCRQm+tbBlZ9
	o68Bo6OBb2th3aG/qX8D7FEiTZWZJzG6Xk2gZN+cjZPCJUjuwFLj/kXJ
X-Gm-Gg: ATEYQzz3Vqe189W1JELY3iwVGdRR6w+P+PNSIMzncdsd64mKdryQ4ZNGUt6x8Xn8+Kp
	srdv8KH9j6ng4TwuIiCm3Ih66Ss73X6rpUf0cCbDc26567BhEHOi89DxfJ0rr+FfIHw9YvC1FgD
	R2nAajT9ms7b/QPqdPjNxQUvaFGm67YnDh/gUVLAH3gkbMhaINZkbbyUsoOkdcPxzGVF9UygnGS
	ICStZv2AKjYOua6YwcLZnqxBwcsuYUy+wHYJxbGDZB1ErD6ugbG0i591BJ+EbP+k5MR+HedB1JP
	hJmwkNP4yF9//eUL7tfQ2VeFErQrwfCSgQpApbSZlxZNJz3qzgRuCCbVzaP5J9Tec/jN9Wkb6yi
	llGUEw46bvUuHf9ehDnyGOMYmwlkcSpmZsgnUWwIh81ejfOgHVf/FTVmPmC//zzcFK5ozjsBScv
	H5lF8B3OvAvZD9RdZcHXImTA==
X-Received: by 2002:a17:906:9f96:b0:b97:b6ef:fc8c with SMTP id a640c23a62f3a-b97b6f016ccmr12604666b.23.1773562413742;
        Sun, 15 Mar 2026 01:13:33 -0700 (PDT)
Received: from zenbook ([176.98.224.6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66350d80a90sm3590633a12.32.2026.03.15.01.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 01:13:32 -0700 (PDT)
From: Sheroz Juraev <goodmartiandev@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: stable@vger.kernel.org,
	Sheroz Juraev <goodmartiandev@gmail.com>
Subject: [PATCH wireless v2] wifi: iwlwifi: mld: stop TX during firmware restart
Date: Sun, 15 Mar 2026 13:12:21 +0500
Message-ID: <20260315081221.2678478-1-goodmartiandev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303104217.180715-1-goodmartiandev@gmail.com>
References: <20260303104217.180715-1-goodmartiandev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-225464-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goodmartiandev@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6AA95290364
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When iwlwifi firmware crashes (e.g., NMI_INTERRUPT_UNKNOWN on Intel
BE201/Wi-Fi 7), iwl_mld_nic_error() sets mld->fw_status.in_hw_restart
to true. However, iwl_mld_tx_from_txq() does not check this flag before
dequeuing frames from mac80211 and pushing them to the transport layer.

Since the firmware is dead, iwl_trans_tx() returns -EIO for each frame,
which then gets freed immediately. Under high-throughput conditions
(e.g., Tailscale UDP traffic or active SSH sessions), this creates a
tight dequeue-send-fail-free loop that wastes CPU cycles and generates
rapid skb allocation churn, leading to memory pressure from slab
fragmentation.

The RX path already has this guard (iwl_mld_rx_mpdu checks
in_hw_restart at rx.c:1906), and so does the TXQ allocation worker
(iwl_mld_add_txqs_wk at tx.c:156). Add the same guard to
iwl_mld_tx_from_txq() to stop all TX during firmware restart.

Frames left in mac80211's TXQs are naturally drained after restart
completes, when queue reallocation triggers iwl_mld_tx_from_txq()
via iwl_mld_add_txq_list(), or when new upper-layer traffic invokes
wake_tx_queue.

Tested on ASUS Zenbook 14 UX3405CA with Intel BE201 (Wi-Fi 7) on
kernel 6.19.5 where the firmware crashes approximately every 10-15
minutes under Tailscale traffic.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sheroz Juraev <goodmartiandev@gmail.com>
---
v2: add target tree name to subject, drop cover letter (single patch)
---
 drivers/net/wireless/intel/iwlwifi/mld/tx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index 3b4b575aa..c5eb36652 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -959,6 +959,16 @@ void iwl_mld_tx_from_txq(struct iwl_mld *mld, struct ieee80211_txq *txq)
 	struct sk_buff *skb = NULL;
 	u8 zero_addr[ETH_ALEN] = {};

+	/*
+	 * Don't transmit during firmware restart. The firmware is dead,
+	 * so iwl_trans_tx() would return -EIO for each frame. Avoid the
+	 * overhead of dequeuing from mac80211 only to immediately free
+	 * the skbs, and the potential memory pressure from rapid skb
+	 * allocation churn during high-throughput restart scenarios.
+	 */
+	if (unlikely(mld->fw_status.in_hw_restart))
+		return;
+
 	/*
 	 * No need for threads to be pending here, they can leave the first
 	 * taker all the work.
--
2.47.2


