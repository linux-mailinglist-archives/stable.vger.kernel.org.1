Return-Path: <stable+bounces-269201-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ns8UKtmnPmoJJwkAu9opvQ
	(envelope-from <stable+bounces-269201-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:24:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2528C6CEFF3
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:24:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=narfation.org header.s=20121 header.b=m9k3vWTw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269201-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269201-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=narfation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7271E32368F2
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5829E403AF2;
	Fri, 26 Jun 2026 16:12:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90C3401A00
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490368; cv=none; b=QVR0HEsKq3uasnhlEKye5y1hFfe48y6J6yUmKFEJE/a3zoxTcLf6wkW58V0qvMLw64obEIPgXRLEggBT1Ch6vdma1333Hb6LEmUSpT1B5Ym25VffstpqG6xLWjW4jSMNojIm/5iNS+j4FAiL3/pTPGSHV1rG0ifzaTabT0O11OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490368; c=relaxed/simple;
	bh=QZktRvAi679Js8LcsPuSgfbx0QIe+PSG1y0OBYyksIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOxbHu34GB7SZfAdUiGzm8R4GuQdXkI0DEJRF8+vDI1qh3bMQ5+ZZJU0Ye1pF8HQTSYmCuF9xqA7pW3fBSo2kNxtwTMRd6CndHU8gEhgIkup4lBR4rdgb1TYmt40d31hkE0UihC+GljN33IZTXxOOyY7PQuKboSaloXujVf2V0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=m9k3vWTw; arc=none smtp.client-ip=213.160.73.56
Received: by dvalin.narfation.org (Postfix) id 2BBF4203E0;
	Fri, 26 Jun 2026 16:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MUo/n68WRcfdrH+GxigRX3fJka5Paoze8a3ktElMHtk=;
	b=m9k3vWTw9fggRamp+WocKAlOSX3sugViZtGA++WQ+FsyyetWqOpwzFpiebqOwXEm21PtA+
	YGWjj9U9G3am/1My8UFgobyzvESlqec269qNN0lMxwWZKwRd8a55ws33yIJRvc9PxHXCWz
	HlsFCY966e7bYU8EPUhinNe3qR3ipAE=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7.1 02/26] batman-adv: tp_meter: initialize dup_acks explicitly
Date: Fri, 26 Jun 2026 18:12:17 +0200
Message-ID: <20260626161241.124988-3-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161241.124988-1-sven@narfation.org>
References: <20260626161241.124988-1-sven@narfation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269201-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,narfation.org:dkim,narfation.org:email,narfation.org:mid,narfation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2528C6CEFF3

commit b2b68b32a715e0328662801576974aa37b942b00 upstream.

When an ack with a sequence number equal to the last_acked is received, the
dup_acks counter is increased to decide whether fast retransmit should be
performed. Only when the sequence numbers are not equal, the dup_acks is
set to the initial value (0).

But if the initial packet would have the sequence number
BATADV_TP_FIRST_SEQ, dup_acks would not be initialized and atomic_inc would
operate on an undefined starting value. It is therefore required to have it
explicitly initialized during the start of the sender session.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index e8941f753a969..0325b951ff8a8 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1045,6 +1045,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	tp_vars->icmp_uid = icmp_uid;
 
 	tp_vars->last_sent = BATADV_TP_FIRST_SEQ;
+	atomic_set(&tp_vars->dup_acks, 0);
 	atomic_set(&tp_vars->last_acked, BATADV_TP_FIRST_SEQ);
 	tp_vars->fast_recovery = false;
 	tp_vars->recover = BATADV_TP_FIRST_SEQ;
-- 
2.47.3


