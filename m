Return-Path: <stable+bounces-269101-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AgdZMlemPmqXJgkAu9opvQ
	(envelope-from <stable+bounces-269101-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:18:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A2D6CEE98
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:18:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=narfation.org header.s=20121 header.b="kJ33xrz/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269101-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269101-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=narfation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ED193106EA3
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72C63FD12D;
	Fri, 26 Jun 2026 16:11:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6693DFC8D
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490307; cv=none; b=RdV+yvZqylp7m8xoO0r3mSoLLYKt0Gpr3Dr/iJnVvVcRXf3kWoKwVPxrDsysEqF/oqllvmo8MvERUbWstsmUm0p+FB2UacCkjhxaBRl17NgOq3Yrbzz+rsMqD6MNFIoJnRfiLQC5oMHmIfdetlfmyJnaXDcsCAjflQ9F1/Z7AB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490307; c=relaxed/simple;
	bh=nMr/70IovSuNxPpA563ZA4Ek6iwE7fWh9hB1Lzh2TdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WG/0Ciy75NaaeBp6WQtWvBdGr/ABNkilsHlFNIQNtNbk+tp3BjMRJyzI6bJhQixn7bzIASwqITF3aKyZholvwx60UkAh5QYWzyY3k99kqeWCWGIKCIf/PGlkj8j/uzKkDEe9FsHgiob82gtuBEyKixns3pmaP6rsKrZ2O9/k8kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=kJ33xrz/; arc=none smtp.client-ip=213.160.73.56
Received: by dvalin.narfation.org (Postfix) id E114520470;
	Fri, 26 Jun 2026 16:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fv6VtklCnnRc8+Jfzx+eMpuHJW3dvqhILNZkvygE91c=;
	b=kJ33xrz/V0JDUj91yP7D1UV3RjGwJHCpT27j5nTQEz4eVoA4wZvNk0bgbrAffziWrt2UrU
	B/K8zoFE8IDY6ynUOu7NNxzdpbEiWhHQ8EdHoBeQpDbK9/91fR+UfqH2Xl6haxF9aKC3Wd
	5fPkNNrcaYLFe1jDIMciBoBubsrpcRQ=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.6 12/25] batman-adv: ensure bcast is writable before modifying TTL
Date: Fri, 26 Jun 2026 18:11:26 +0200
Message-ID: <20260626161139.124425-13-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161139.124425-1-sven@narfation.org>
References: <20260626161139.124425-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269101-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sven@narfation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[narfation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,narfation.org:dkim,narfation.org:email,narfation.org:mid,narfation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37A2D6CEE98

commit 4cd6d3a4b96a8576f1fed8f9f9f17c2dc2978e0c upstream.

Before batman-adv is allowed to write to an skb, it either has to have its
own copy of the skb or used skb_cow() to ensure that the data part is not
shared.

The old implementation used a shared queue and created copies before
attempting to write to it. But with the new implementation, the broadcast
packet is already modified when it gets received. Potentially writing to
shared buffers in this process.

Adding a skb_cow() right before this operation avoids this and can at the
same time prepare it for the modifications required to rebroadcast the
packet.

Cc: stable@kernel.org
Fixes: 3f69339068f9 ("batman-adv: bcast: queue per interface, if needed")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 163cd43c4821b..747c3ff1c253b 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1198,6 +1198,12 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	if (batadv_is_my_mac(bat_priv, bcast_packet->orig))
 		goto free_skb;
 
+	/* create a copy of the skb, if needed, to modify it. */
+	if (skb_cow(skb, ETH_HLEN) < 0)
+		goto free_skb;
+
+	bcast_packet = (struct batadv_bcast_packet *)skb->data;
+
 	if (bcast_packet->ttl-- < 2)
 		goto free_skb;
 
-- 
2.47.3


