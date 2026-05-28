Return-Path: <stable+bounces-254783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDQ6OmQVGGprcwgAu9opvQ
	(envelope-from <stable+bounces-254783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:13:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 626B05F05BF
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AC4E31FBC94
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D663B388B;
	Thu, 28 May 2026 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B56PNcSB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6556538A73B
	for <stable@vger.kernel.org>; Thu, 28 May 2026 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962329; cv=none; b=RbtritlYNxY76CL75c8MlipR6Or0wobeSozd/YrdPVjwQ30PSPXZHGRPhogZaRGqYei1jeSUKyDJjZkUNEIpEzEpXxtsKyljlTjWmtbzuYafWmSfVkFCleDIFmTgIAcG4F3+Q97fP3WReS4RhnrAFXSZ7eiNDDRTtVZful/Jagg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962329; c=relaxed/simple;
	bh=W9CtelmXDjhzxtT8U5ZBJEQ4nxu4KowCd64TROVjp1s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WoOMLQoqSPYD/QBth4wpF0WQJU/x2bCQSF+YUUnZLbw63SKsMSkOU8aOXmijQIQ7q+aMredJxkEjl51jGFDCIAcvZCCWbHKU8FtcwY/mQWEPBnI/tpuazghm6SMvE76tx5fsd0pI+a0+UjaSw9C3Ec7S1OXwZ2YG/3g8ubWUsEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B56PNcSB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADBF1F000E9;
	Thu, 28 May 2026 09:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779962328;
	bh=aj9G8ss+cGFput+yCJBqUIp2ZVTP1ohIrlwQFimX8Uk=;
	h=Subject:To:Cc:From:Date;
	b=B56PNcSBD1uUUiZrWXqoTGJdj1/9d+ABb1GOG2/WCn3kJR4rbNYZXPlPtGlqjp/wf
	 ZLEFfBaokhtSINAQuC0cegYc5yftxOKEaiL0d+siR1buHT8xtH8yvtj1b+8Gyi2NQV
	 iTntXo2PIF9uXeBZbuq3Dlb/TDjnw37l9/gbk4AA=
Subject: FAILED: patch "[PATCH] wifi: mac80211: capture fast-RX rate before mesh reuses" failed to apply to 6.18-stable tree
To: enderaoelyther@gmail.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 11:57:54 +0200
Message-ID: <2026052854-skimmer-nutlike-eb6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254783-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,intel.com:email,gregkh:email]
X-Rspamd-Queue-Id: 626B05F05BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x d71c841be5d9e586ee7f36c0dc8ed4db0d9a1349
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052854-skimmer-nutlike-eb6e@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d71c841be5d9e586ee7f36c0dc8ed4db0d9a1349 Mon Sep 17 00:00:00 2001
From: Zhao Li <enderaoelyther@gmail.com>
Date: Sat, 9 May 2026 12:34:28 +0800
Subject: [PATCH] wifi: mac80211: capture fast-RX rate before mesh reuses
 skb->cb

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
Link: https://patch.msgid.link/20260509043427.60322-2-enderaoelyther@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index d18e962126ce..3fb40449c6c5 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4984,6 +4984,7 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 		u8 sa[ETH_ALEN];
 	} addrs __aligned(2);
 	struct ieee80211_sta_rx_stats *stats;
+	u32 encoded_rate;
 
 	/* for parallel-rx, we need to have DUP_VALIDATED, otherwise we write
 	 * to a common data structure; drivers can implement that per queue
@@ -5091,11 +5092,14 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
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


