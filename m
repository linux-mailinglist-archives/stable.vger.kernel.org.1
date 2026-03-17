Return-Path: <stable+bounces-226116-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKzgLdt6uWnQGQIAu9opvQ
	(envelope-from <stable+bounces-226116-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:01:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3E42AD770
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12BAB30DAA37
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83D72F25E4;
	Tue, 17 Mar 2026 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="gcYa9d+H"
X-Original-To: stable@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6528C2EDD78;
	Tue, 17 Mar 2026 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763216; cv=none; b=UPCEJvRu4Ts3M6Ex9iWI768KFZiWKTWSak0GA84JfaapD3g45omf09jIlmDir3xhMeKttZeD2v6fG0qlCmKoxREn3LtsvxqUsRsWFNCh80mbNMkfOgOq/nyYM+WOpXVjQS4xnPfLkuJ6PPSPSc+Afu/S6/Mmv/ggGZsWVzxYHyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763216; c=relaxed/simple;
	bh=DpcV5NN4oIQAYTrETu51T9FOwpaAuK7Z8d64V62Uo8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkXiIHCE0qXBjJFIYUHLDQNRLKOLPu+x3W1BrBNlZ2CVGhZlg7KyAV/ioOOXoeEgVa0K5311fm1WbHAj1tjNrHIpsf5ux994R+6pvtwdkltkzVpAlBweEGfAosKZOj4QH9Sg2dg6YShSH5/iAIbn8xFV0ylI9jFIl02YMIKhJnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=gcYa9d+H; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1773763204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xx7mjI2MofOxW6iU5Fob/w9bvKDeUmPtcm6wJ652Ow=;
	b=gcYa9d+HZBCXiDYZTLSwbEcTys8KHFnDaShmRPpIlHNKm+lWIyTeCxvvGE2O2Oxl5o60QB
	9BwxhlW2xJwZiAcLsdUl4tMCuxMZ3Q4LS1LOGp3W32GCi2lA1dgBe6llcRhKUs9csM8Fib
	7hVRmtNLKEruKiG2tcv2rdXH1c0KQ+1NNIZQ0ZYqMkiLHAvgr1+GBLrmBGmosy6kmmmvRe
	Fk+jr5nD8X+i1yvkq/HmmxalTD7/FWpNoBn0K1H2GkRjCYoU1TGWcwFVoNoLvS9cDJ6GHx
	wcDijEtQKYYnGbGIms9+f1ZNtnwhbzq10gahJsQmp2Humcb7sShsIaDPuf8DsA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Yang Yang <n05ec@lzu.edu.cn>,
	stable@vger.kernel.org,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <tanyuan98@outlook.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 1/1] batman-adv: avoid OGM aggregation when skb tailroom is insufficient
Date: Tue, 17 Mar 2026 17:00:02 +0100
Message-ID: <20260317160002.1869478-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317160002.1869478-1-sw@simonwunderlich.de>
References: <20260317160002.1869478-1-sw@simonwunderlich.de>
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
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.open-mesh.org,lzu.edu.cn,gmail.com,outlook.com,narfation.org,simonwunderlich.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226116-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,simonwunderlich.de:dkim,simonwunderlich.de:email,simonwunderlich.de:mid]
X-Rspamd-Queue-Id: 5F3E42AD770
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yang Yang <n05ec@lzu.edu.cn>

When OGM aggregation state is toggled at runtime, an existing forwarded
packet may have been allocated with only packet_len bytes, while a later
packet can still be selected for aggregation. Appending in this case can
hit skb_put overflow conditions.

Reject aggregation when the target skb tailroom cannot accommodate the new
packet. The caller then falls back to creating a new forward packet
instead of appending.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Cc: stable@vger.kernel.org
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
Signed-off-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
Signed-off-by: Yang Yang <n05ec@lzu.edu.cn>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index b75c2228e69a6..f28e9cbf8ad5f 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -473,6 +473,9 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 	if (aggregated_bytes > max_bytes)
 		return false;
 
+	if (skb_tailroom(forw_packet->skb) < packet_len)
+		return false;
+
 	if (packet_num >= BATADV_MAX_AGGREGATION_PACKETS)
 		return false;
 
-- 
2.47.3


