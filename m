Return-Path: <stable+bounces-259963-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nxNuLcvKH2rkpwAAu9opvQ
	(envelope-from <stable+bounces-259963-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 08:33:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF19634AF2
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 08:33:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=vt2Jw+Nm;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259963-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-259963-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4DC7303740B
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 06:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242F53F9A1E;
	Wed,  3 Jun 2026 06:28:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36FA3F99F6;
	Wed,  3 Jun 2026 06:28:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468125; cv=none; b=QXVKQ+TU5ws8QNl/H3nd2gooKlbikg8j3nPt2ATnW6zFdpGZm22N3mdNRcKzLiyzghU0vhZnFebATFz2dT7QlRwLEb3yc4En8xtbf/GjWqMPygQDvw7shPleWbPSJ3Y+EdFfG4+b/OScW+b7Dxs7DVhe0EmYOlHgbpsPP2Y+Hco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468125; c=relaxed/simple;
	bh=WAi8U+3sfBWwUpadzsvWjdyiQFBV9pSSkxACkoPzTxs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B/1SNagc2WT41tCxnjnZWc+ovJTIXlmF2pviOdmpUPv99KzlEldjjDHmJAHbCzFjq4AMsdqOECGE0QPuZge3LNgdiz4o4aYUQdMSKVpHbI9D/l+GNIG7Bs9S9+Zo0OAQ7hiOWIFh1kPupSvfQBZX69VSF8BIM/OhLPh9X1CUP1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=vt2Jw+Nm; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6536IIJ103626622, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780467498; bh=TWwBiF+NAdoTfoslkDu2INd/Tmlxm1z80iFJEROktwk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=vt2Jw+NmqA5BLN8q1OfkiPv9cZZhXr3uvwEpnlxnBWiUTNJXwb9wZ8rbOrTkjNhek
	 6OQXcAACnP23ZhQsiWq6zurYr7DpMZ8/PQmAmwpCg/z8QHc17brZBmWxuu3mpq8Zrq
	 7822d9G9U6hwmPHuqc1IS6g1MlWsvbDRsECZwIJa5UluLU5/hMuX3hIF1sPwxtlUR4
	 +n+cP1rFnyLlOS+vBOrcvxQkDWkGKPiQQQ8y6Ogsgd8Eli5l4JRK/0pZZdlwk+BZJ3
	 +qCL65jFZ6oJnQYLs0C3Hj/8eUqp9NLjFR4x+7yVDX2dxk9mv+c1hxf61N2kmSC7Z7
	 Hq1mJGFrWOw3Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6536IIJ103626622
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Jun 2026 14:18:18 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Jun 2026 14:18:18 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Jun 2026 14:18:18 +0800
Received: from RTDOMAIN (172.21.42.225) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 3 Jun 2026 14:18:18 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <stable@vger.kernel.org>, <horms@kernel.org>,
	<aleksander.lobakin@intel.com>, <pkshih@realtek.com>,
	<larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net v2] rtase: Avoid sleeping in get_stats64()
Date: Wed, 3 Jun 2026 14:18:16 +0800
Message-ID: <20260603061816.31356-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259963-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[justinlai0215@realtek.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:stable@vger.kernel.org,m:horms@kernel.org,m:aleksander.lobakin@intel.com,m:pkshih@realtek.com,m:larry.chiu@realtek.com,m:justinlai0215@realtek.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justinlai0215@realtek.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:mid,realtek.com:dkim,realtek.com:from_mime,realtek.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AF19634AF2

The .ndo_get_stats64 callback must not sleep because it can be
called when reading /proc/net/dev.

rtase_get_stats64() calls rtase_dump_tally_counter(), which polls
the tally counter dump bit with read_poll_timeout(). This may
sleep while waiting for the hardware counter dump to complete.

Use read_poll_timeout_atomic() instead to avoid sleeping in the
get_stats64() path.

Fixes: 079600489960 ("rtase: Implement net_device_ops")
Cc: stable@vger.kernel.org
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
v1 -> v2:
- Target net tree.
- Add Fixes tag.
- Add Cc: stable@vger.kernel.org.
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 6ccbefb5acf2..55105d34bc79 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1565,8 +1565,9 @@ static void rtase_dump_tally_counter(const struct rtase_private *tp)
 	rtase_w32(tp, RTASE_DTCCR0, cmd);
 	rtase_w32(tp, RTASE_DTCCR0, cmd | RTASE_COUNTER_DUMP);
 
-	err = read_poll_timeout(rtase_r32, val, !(val & RTASE_COUNTER_DUMP),
-				10, 250, false, tp, RTASE_DTCCR0);
+	err = read_poll_timeout_atomic(rtase_r32, val,
+				       !(val & RTASE_COUNTER_DUMP),
+				       10, 250, false, tp, RTASE_DTCCR0);
 
 	if (err == -ETIMEDOUT)
 		netdev_err(tp->dev, "error occurred in dump tally counter\n");
-- 
2.40.1


