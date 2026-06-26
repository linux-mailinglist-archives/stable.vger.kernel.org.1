Return-Path: <stable+bounces-269014-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vR5iG0SlPmoqJgkAu9opvQ
	(envelope-from <stable+bounces-269014-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:13:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C13E86CED55
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:13:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=narfation.org header.s=20121 header.b=nwxK949c;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269014-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269014-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=narfation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42F7E306A178
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60773E2745;
	Fri, 26 Jun 2026 16:10:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC323FAE10
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:10:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490213; cv=none; b=R2ZZTYSCiwGkM+uCoNBqOa5uFLApsIeRh1TNy2wUA/mZFdr5j3AdpJYaKRlV4a1/24dAbGETsyszImMURRfEeVNqri8GdV4JeuBptXC6zi0oDlppCUgM8iTX0eg1YD65rD+nRD4CxlQ6Ojn8p47ieN5EVZseQ6j14Bhl8R5k71U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490213; c=relaxed/simple;
	bh=pGw6X/D8XFkiPbN5COnZK8rdijVDlHkDvtUs9aIiiOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0f1HrAjfW3Cu67tLUsIJFCVqkOMEvc8xBYefpvr1O7q1W9ukv2zKUNdgGKVa7FnSDvAuHB8Oo/4ByM8dhze+DM3QSIZumfES5FUBpA/d6v1HwQthh8m37PeVZnhvAtSj8lLT/lzuTok3XH6vWwhJAyap/Cd2FxVVdLZYF8p+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=nwxK949c; arc=none smtp.client-ip=213.160.73.56
Received: by dvalin.narfation.org (Postfix) id 73F6820470;
	Fri, 26 Jun 2026 16:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eMX6rWcmLHogjuKC+qfM32Qf+5DM3mEKOIkrnF4rOMM=;
	b=nwxK949cO1635isCYuXkc2lOwcTBIh5YdEOnFsv+O6/LCd2P6S4+BEumFAUOAp2o+vvJLw
	m9UHc4GYq/3UuANvK0CBHn38rSOP08Rnm0KERNg3Xrd0Nhl2gvODRnEsTWz4WvfXCKjP0e
	YkLcUKxbJqVPqqttPgU9X+tYG+LXQzw=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.10 05/23] batman-adv: tp_meter: avoid divide-by-zero for dec_cwnd
Date: Fri, 26 Jun 2026 18:09:34 +0200
Message-ID: <20260626160952.123713-6-sven@narfation.org>
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
	TAGGED_FROM(0.00)[bounces-269014-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: C13E86CED55

commit 33ccd52f3cc9ed46ce395199f89aa3234dc83314 upstream.

The cwnd is always MSS <= cwnd <= 0x20000000. But the calculation in
batadv_tp_update_cwnd() assumes unsigned 32 bit arithmetics.

    ((mss * 8) ** 2) / (cwnd * 8)

In case cwnd is actually 0x20000000, it will be shifted by 3 bit to the
left end up at 0x100000000 or U32_MAX + 1. It will therefore wrap around
and be 0 - resulting in:

    ((mss * 8) ** 2) / 0

This is of course invalid and cannot be calculated. The calculation should
must be simplified to avoid this overflow:

   (mss ** 2) * 8 / cwnd

It will keep the precision enhancement from the scaling (by 8) but avoid
the overflow in the divisor.

In theory, there could still be an overflow in the dividend. It is at the
moment fixed to BATADV_TP_PLEN in batadv_tp_recv_ack() - so it is not an
imminent problem. But allowing it to use the whole u32 bit range, would
mean that it can still use up to 67 bits. To keep this calculation safe for
32 bit arithmetic, mss must never use more than floor((32 - 3) / 2) bits -
or in other words: must never be larger than 16383.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 10953096996ab..118cb5dd285c2 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -153,9 +153,12 @@ static void batadv_tp_update_cwnd(struct batadv_tp_vars *tp_vars, u32 mss)
 		return;
 	}
 
+	/* prevent overflow in (mss * mss) << 3 */
+	mss = min_t(u32, mss, (1U << 14) - 1);
+
 	/* increment CWND at least of 1 (section 3.1 of RFC5681) */
 	tp_vars->dec_cwnd += max_t(u32, 1U << 3,
-				   ((mss * mss) << 6) / (tp_vars->cwnd << 3));
+				   ((mss * mss) << 3) / tp_vars->cwnd);
 	if (tp_vars->dec_cwnd < (mss << 3)) {
 		spin_unlock_bh(&tp_vars->cwnd_lock);
 		return;
-- 
2.47.3


