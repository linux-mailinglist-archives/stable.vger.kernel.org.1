Return-Path: <stable+bounces-269157-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2KcUKWynPmrlJgkAu9opvQ
	(envelope-from <stable+bounces-269157-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:23:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D6A6CEF7D
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:23:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=narfation.org header.s=20121 header.b=A4b7ETwM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269157-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269157-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=narfation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D89803132C19
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640073FF8B4;
	Fri, 26 Jun 2026 16:12:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F327C3FCB0E
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490342; cv=none; b=swaPtGefXnrvdaWZIxn2rvZyueAZXWH4QSbGZQc1hNLCyoUoKoDzNP1LO+ZE+tCzAj0SQdWrJ4PVExzfdK+pPTRbbKpS3DXoeQLvipc4DUC6WZ8dsvM74xo0iWy1+2e8WZy0Zfvo5FHP1gv7Hr3kXd8Sz+vwkhzuDqu6JO/EmRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490342; c=relaxed/simple;
	bh=b/cMUYkK8LJY0Ye7xt0XGhRLtsmOU5Uc/VHUk9ek4ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tutTjlU9c/zFTkj8cMzrKB+WUmVzM8k5TFqojlLUCIvNZ1cQ+qK6BEExA+SW+tN9HyTMcshWc2zv/47lTKGExb7sEJTzvwr83S89xfdgPP0k+Ei9xD4zv3a18DWMIowiqir357MN6/uW/daUC0ok+UgDQz3KYUv/OHdamDdnTI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=A4b7ETwM; arc=none smtp.client-ip=213.160.73.56
Received: by dvalin.narfation.org (Postfix) id 4DA9B20539;
	Fri, 26 Jun 2026 16:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jP1OnSR0jM4Q7fzRykzfNKKvUo2cr4tdUn8aaEsSYqY=;
	b=A4b7ETwMuHvnl/wwsy01vGGUssqiAht0ud7IZ7KwuaLdQDq9RZucnH7Eri0NqJTf6FyciD
	YPFVZgYf4lg+J5KJ485DrBWCQkyZixjFSUTMjQBaCnB0SxcVuwry5ZQrSyJ2Jhb+trQzv/
	UarLhO8VfUBkdAd4GeM30+XiVq40vhI=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.18 10/26] batman-adv: prevent ELP transmission interval underflow
Date: Fri, 26 Jun 2026 18:11:54 +0200
Message-ID: <20260626161210.124712-11-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161210.124712-1-sven@narfation.org>
References: <20260626161210.124712-1-sven@narfation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269157-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,narfation.org:dkim,narfation.org:email,narfation.org:mid,narfation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56D6A6CEF7D

commit 5e50d4b8ae3ea622122d3c6a38d7f6fe68dfddca upstream.

batadv_v_elp_start_timer() enqeues a delayed work. The time when it starts
is randomly chosen between (elp_interval - BATADV_JITTER) and
(elp_interval + BATADV_JITTER). The configured elp_interval must therefore
be larger or equal to BATADV_JITTER to avoid that it causes an underflow of
the unsigned integer. If this would happen, then a "fast" ELP interval
would turn into a "day long" delay.

At the same time, it must not be larger than the maximum value the variable
can store.

Cc: stable@kernel.org
Fixes: a10800829040 ("batman-adv: Add elp_interval hardif genl configuration")
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/netlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 78c651f634cd3..8114454f42cfc 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -917,7 +917,13 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 
 	if (info->attrs[BATADV_ATTR_ELP_INTERVAL]) {
+		u32 elp_interval;
+
 		attr = info->attrs[BATADV_ATTR_ELP_INTERVAL];
+		elp_interval = nla_get_u32(attr);
+
+		elp_interval = min_t(u32, elp_interval, INT_MAX);
+		elp_interval = max_t(u32, elp_interval, BATADV_JITTER);
 
 		atomic_set(&hard_iface->bat_v.elp_interval, nla_get_u32(attr));
 	}
-- 
2.47.3


