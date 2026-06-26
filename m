Return-Path: <stable+bounces-269027-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FHHtEoelPmpHJgkAu9opvQ
	(envelope-from <stable+bounces-269027-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:15:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2206CEDBA
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:15:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=narfation.org header.s=20121 header.b=OoTuTJmN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269027-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269027-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=narfation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31F8831129DF
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A627C3FB7F1;
	Fri, 26 Jun 2026 16:10:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FF93F9F22
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:10:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490220; cv=none; b=TNgxDuZ/5u/YMWeleLOtqQGRoH4W4Kwifl81ARy+dtVIVAWsMuwdPoEXnz+eKARnyKtvJHO0JfyVAOLuYoxrDbMnm94QqAq+jAJW7l2RfoNU2PNvoUDj4mtqa7585BSng6cYg3qNGgjRoahBgwwLYMT7XXqBbOQ5nkqj7Mac9Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490220; c=relaxed/simple;
	bh=8rojb5sAJVGXrQxPsYaAwBG51U1p+ku7SbFwbyU5WAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yg/MlwEI6VkhGOy7MzI8rzxycUS8jbigW2EXlz0WwcmfZ3J5GA8dCsBD6XDB8IYyvW8PsvKu8GYyfYjvznur4fWqY2tg3WOEP3MdT1yNPbUo50lvK4So1v8d4ux1WUQg6Pef8jXfJV9IbL99vNDsXqwXXanPz5supnmXnhYgvjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=OoTuTJmN; arc=none smtp.client-ip=213.160.73.56
Received: by dvalin.narfation.org (Postfix) id 941F420741;
	Fri, 26 Jun 2026 16:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/lQbNX+Dq/+3vS01mxo4SnXtTr806jZlmuJS4GX/VM=;
	b=OoTuTJmNc+FmzdVX3zRaLIM0nkzcC9Zn/XINkglnBT8OYAw50ln+xB+NLjTmGw75XQqU3+
	FhgQJomeRRnf8tr0SJBpV96T5LLffuYkFQY2pCt409oDbIpM+Vqb7Du97RcKC1ARfwmiM4
	CVtlYta2WOjAjdmYdBO+no24h3+YCHY=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.10 19/23] batman-adv: tt: don't merge change entries with different VIDs
Date: Fri, 26 Jun 2026 18:09:48 +0200
Message-ID: <20260626160952.123713-20-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626160952.123713-1-sven@narfation.org>
References: <20260626160952.123713-1-sven@narfation.org>
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
	TAGGED_FROM(0.00)[bounces-269027-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,narfation.org:dkim,narfation.org:email,narfation.org:mid,narfation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB2206CEDBA

commit f08e06c2d5c3e2434e7c773f2213f4a7dce6bc1e upstream.

batadv_tt_local_event() merges/cancels events for the same client which
would conflict or be duplicates. The matching of the queued events only
compares the MAC address - the VLAN ID stored in each event is ignored.

If a MAC would now appear on multiple VID, the two ADD change events (for
VID 1 and VID 2) would be merged to a single vid event. The remote can
therefore not calculate the correct TT table and desync. A full translation
table exchange is required to recover from this state.

A check of VID is therefore necessary to avoid such wrong merges/cancels.

Cc: stable@kernel.org
Fixes: c018ad3de61a ("batman-adv: add the VLAN ID attribute to the TT entry")
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 79da90b9cf065..c323660897d43 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -486,6 +486,9 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 		if (!batadv_compare_eth(entry->change.addr, common->addr))
 			continue;
 
+		if (entry->change.vid != tt_change_node->change.vid)
+			continue;
+
 		/* DEL+ADD in the same orig interval have no effect and can be
 		 * removed to avoid silly behaviour on the receiver side. The
 		 * other way around (ADD+DEL) can happen in case of roaming of
-- 
2.47.3


