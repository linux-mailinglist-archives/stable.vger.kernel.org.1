Return-Path: <stable+bounces-269064-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n5HUJHKlPmo+JgkAu9opvQ
	(envelope-from <stable+bounces-269064-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:14:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2B56CED9C
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:14:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=narfation.org header.s=20121 header.b=UZ0NceFh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269064-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269064-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=narfation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05E5530CC161
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFC23E2AD1;
	Fri, 26 Jun 2026 16:11:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AFB33993
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490288; cv=none; b=t8N9nnXCS/QgfGGEIMniXvYlZxhTQ2NiAr8iwxw0jbaqruZvR91YMnAnUnBBZ2OZ/k2Axi1jOg/OVQe2TYinlABAK/aN2ab69UZpK1C9V13O88jNexbZXUfUq92JTumsGmkedf0Y1j3O/FO/depSvdgsIqZJfzNtAbDxWAXnTCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490288; c=relaxed/simple;
	bh=zwAThkbUo7uLI085bpnJZYNkhWQl2aIAz6Cbp/faPm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpoyXOLeyQqk0hjubsTuVUeathsXepODFxC03Yz3IGRiy46VMFWwbAt8NVv7NNOsNvlWU68PEPpoNj7r8favyKp9idwb9UWn9rxGxutGSp0REbfMb+d0RAMK33I7uK7ACQ6F3JE+Mbn0ePCymluT0tAcYj+RF5eCL0u0epuBktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=UZ0NceFh; arc=none smtp.client-ip=213.160.73.56
Received: by dvalin.narfation.org (Postfix) id 177E8203F3;
	Fri, 26 Jun 2026 16:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YsN9N4Ncr1XBwBc+jSexSwkY0AGyzatpp6r9NLB28q8=;
	b=UZ0NceFhOxyu74LJvwp7o3DlJis4iWbZXsBgz1TFe78eVp2mjpKCatCwN/uJqd1ukfBtOj
	AVNw3mjVvozHeEtKLw+QGGhlZWnUcd/lyqfTGfBl0+TUhUcX+O4COLZ4WT4dvHiJzSDpAB
	IgcAtuIoh7Xz0X6eKjdu3DM7sxC4zeo=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.1 04/25] batman-adv: tp_meter: avoid window underflow
Date: Fri, 26 Jun 2026 18:11:02 +0200
Message-ID: <20260626161123.124273-5-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161123.124273-1-sven@narfation.org>
References: <20260626161123.124273-1-sven@narfation.org>
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
	TAGGED_FROM(0.00)[bounces-269064-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,narfation.org:dkim,narfation.org:email,narfation.org:mid,narfation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D2B56CED9C

commit 765947b81fb54b6ebb0bc1cfe55c0fa399e002b8 upstream.

In batadv_tp_avail(), win_left is calculated with 32-bit unsigned
arithmetic: win_left = win_limit - tp_vars->last_sent;

During Fast Recovery, cwnd is inflated and last_sent advances rapidly. When
Fast Recovery ends, cwnd drops abruptly back to ss_threshold. If the newly
shrunk win_limit is less than last_sent, the unsigned subtraction will
underflow, wrapping to a massive positive value. Instead of returning that
the window is full (unavailable), it returns that the sender can continue
sending.

To handle this situation, it must be checked whether the windows end
sequence number (win_limit) has to be compared with the last sent sequence
number. If it would be before the last sent sequence number, then more acks
are needed before the transmission can be started again.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index f6ccb639744a2..0fdcafca3aa02 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -817,10 +817,15 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 static bool batadv_tp_avail(struct batadv_tp_vars *tp_vars,
 			    size_t payload_len)
 {
+	u32 last_sent = READ_ONCE(tp_vars->last_sent);
 	u32 win_left, win_limit;
 
 	win_limit = atomic_read(&tp_vars->last_acked) + tp_vars->cwnd;
-	win_left = win_limit - tp_vars->last_sent;
+
+	if (batadv_seq_before(last_sent, win_limit))
+		win_left = win_limit - last_sent;
+	else
+		win_left = 0;
 
 	return win_left >= payload_len;
 }
-- 
2.47.3


