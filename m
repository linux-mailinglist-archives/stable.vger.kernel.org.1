Return-Path: <stable+bounces-245877-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGA6CqtmA2oq5gEAu9opvQ
	(envelope-from <stable+bounces-245877-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:43:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9696525FA1
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7A7F3033CBF
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29ED3DB980;
	Tue, 12 May 2026 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jl/AKiNz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61323B1EE2;
	Tue, 12 May 2026 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607784; cv=none; b=V2im5aoQ89w2HSbiYyX3nu72LFpaL8Owe4BYsafHSU2gceIrZgqT6Q85HZ917EwKtv5DOA1bBgU/YqeLaalcpkQzRCPyD02Gy47UiVV/6dVcxS8Antz8eBkk1hxJdEQu4mUrZS2ZCxPcNM7/mXfR3H58b1x/S1d4I66pR4Xw36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607784; c=relaxed/simple;
	bh=k/IeHvqQeXnEZjY12q6Z1BQfxNY5iOngFxT4H24gtU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfJjX0swqlsH6L/FoRKJL5jbNFRMFrZk1CKJIJEc67Uo1fG42+DkbfTBoEN1KQwzYQwam6HfQXw5YyLdYzol/J34RrBrww6zw9qhWPFjkjqfhQcgQz5iicvGYtXkjrmmA8zvwCoUAhvXvfM6+C6qQN/jWoJww7GCKLX0aerM/KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jl/AKiNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4F3C2BCB0;
	Tue, 12 May 2026 17:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778607784;
	bh=k/IeHvqQeXnEZjY12q6Z1BQfxNY5iOngFxT4H24gtU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jl/AKiNzX4NNkJdBuKm6zrgioMLvsSbKQ+z8V6HZFCyeagO8jqwc7yvCyPNtJFDxH
	 ufKFONNZH+i+MLDSi5fRZiue3VFcKrvfR9lmnZhKpqr+1AANH8icFIEcGxc+NwRNEw
	 scjq8htiY4sop1xU9mrnJLDmN7Yy2p7i+Vye9XTY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Catherine <enderaoelyther@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.12 034/206] wifi: mac80211: drop stray static from fast-RX rx_result
Date: Tue, 12 May 2026 19:38:06 +0200
Message-ID: <20260512173933.552752140@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A9696525FA1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245877-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Catherine <enderaoelyther@gmail.com>

commit 7a5b81e0c87a075afd572f659d8eb68c9c4cd2ba upstream.

ieee80211_invoke_fast_rx() is documented as safe for parallel RX, but
its per-invocation rx_result is declared static. Concurrent callers then
share one instance and can overwrite each other's result between
ieee80211_rx_mesh_data() and the switch on res.

That can make a packet that was queued or consumed by
ieee80211_rx_mesh_data() fall through into ieee80211_rx_8023(), or make
a packet that should continue return as queued.

Make res an automatic variable so each invocation keeps its own result.

Fixes: 3468e1e0c639 ("wifi: mac80211: add mesh fast-rx support")
Cc: stable@vger.kernel.org
Signed-off-by: Catherine <enderaoelyther@gmail.com>
Link: https://patch.msgid.link/20260424131435.83212-2-enderaoelyther@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/rx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4882,7 +4882,7 @@ static bool ieee80211_invoke_fast_rx(str
 	struct sk_buff *skb = rx->skb;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
-	static ieee80211_rx_result res;
+	ieee80211_rx_result res;
 	int orig_len = skb->len;
 	int hdrlen = ieee80211_hdrlen(hdr->frame_control);
 	int snap_offs = hdrlen;



