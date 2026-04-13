Return-Path: <stable+bounces-235965-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMqGK2Wv3GnfVAkAu9opvQ
	(envelope-from <stable+bounces-235965-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:55:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 159B43E9641
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3478B3029E61
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF773ACF0B;
	Mon, 13 Apr 2026 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="MMhIZ8WL"
X-Original-To: stable@vger.kernel.org
Received: from mx9.kaspersky-labs.com (mx9.kaspersky-labs.com [195.122.169.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C243F37EFFE;
	Mon, 13 Apr 2026 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.122.169.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070312; cv=none; b=raTxihV84vcR13fBK//rkvXYv6wETWzhHegxsqiHMkOBpZrM2iJgyDCyAyZVgTMtyQhVkgFeTz7maJRYDVA3lj+XseJNaqXet+8lAoO17pRmWVWXCKZvbrdn5UnAg6b9c/wxT3qYJbSX/Trt5rOGiczSvyuRESkNmCTkBvAGsiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070312; c=relaxed/simple;
	bh=WzzuVQiM3vQq7Pu3MA9rG3D8KIzEfGSPLkZjzsLkU5o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uhEva6xmPCjowX+G7xzV6WFXr3A8U1UqDy5js9emcnugVZwivGXkDYFXM2Vpa8nlABoJFSD0eurEwYnBtZaflt8AJ6ctAhLVi7LOOAgcwDZmMVhymp/8DXdQF+LZh1YNw5uw2u6hsa7PisvT+hXtG7xWzo3WKww67Orr1C9sG0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=MMhIZ8WL; arc=none smtp.client-ip=195.122.169.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1776070304;
	bh=K+knYpaQC63S6yxb+K9P2BEcXIw8nVZezjjBAu4p/T8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=MMhIZ8WLlN8+jzXPL+j4hKcYUHbgJwG6ltHkOw2HP8hiMWNPacPd2PRkuv6rPO5PB
	 mzxBWm1ba5iVWoi8IOh1sUBXv1w8EFZvJoWdc3b1lxZQEGXgQ3kgJazFpZCY+V1KLO
	 uMUvXnVZp5ooYOZWd/ImRdvcQLqcM7v/Zsp6v1FPnPKHhyBLRoM9KyZqq33rKMnujI
	 VToUS5hkCRjEekRRMx6Ydg6E+EEEaRhw9K9dlxiTviOsRe7ZVbuBi2ZSEmHa094Yjc
	 Qih4CsEE1x5cVuJNbzIvOueR0RRX3AsX7rILf0qBISjcC6S1TS0edk0i+1UaEhH/Ji
	 sseAfRI10ttew==
Received: from relay9.kaspersky-labs.com (localhost [127.0.0.1])
	by relay9.kaspersky-labs.com (Postfix) with ESMTP id 4C9398A0705;
	Mon, 13 Apr 2026 11:51:44 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub9.kaspersky-labs.com (Postfix) with ESMTPS id 906158A0620;
	Mon, 13 Apr 2026 11:51:43 +0300 (MSK)
Received: from chesnokov.avp.ru (10.16.105.7) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 13 Apr
 2026 11:51:42 +0300
From: <Alexander.Chesnokov@kaspersky.com>
To: <olteanv@gmail.com>
CC: <lvc-project@linuxtesting.org>, <Oleg.Kazakov@kaspersky.com>,
	<Pavel.Zhigulin@kaspersky.com>, Alexander Chesnokov
	<Alexander.Chesnokov@kaspersky.com>, <stable@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH] net: dsa: sja1105: fix division by zero in sja1105_tas_set_runtime_params()
Date: Mon, 13 Apr 2026 11:51:32 +0300
Message-ID: <20260413085140.33138-1-Alexander.Chesnokov@kaspersky.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV4.avp.ru (10.64.57.54) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 04/13/2026 08:39:29
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 202220 [Apr 13 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.22
X-KSE-AntiSpam-Info: Envelope from: Alexander.Chesnokov@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 98 0.3.98
 ca9d2f3beca9ca2a85e178af9d8e97d5fa2c38a3
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: chesnokov.avp.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;kaspersky.com:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/13/2026 08:42:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/13/2026 6:00:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/04/13 06:49:00 #28394185
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kaspersky.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kaspersky.com:s=mail202505];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxtesting.org,kaspersky.com,vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-235965-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Alexander.Chesnokov@kaspersky.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kaspersky.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kaspersky.com:dkim,kaspersky.com:email,kaspersky.com:mid,linuxtesting.org:url]
X-Rspamd-Queue-Id: 159B43E9641
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>

If taprio offload is configured such that none of the ports' base_time
is less than S64_MAX (the initial value of earliest_base_time), then
its_cycle_time remains zero and is passed to future_base_time() as
cycle_time, causing division by zero in div_s64().

Add a check for its_cycle_time being zero before calling
future_base_time() and return -EINVAL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 86db36a347b4 ("net: dsa: sja1105: Implement state machine for TAS with PTP clock source")
Cc: stable@vger.kernel.org

Signed-off-by: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
---
 drivers/net/dsa/sja1105/sja1105_tas.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/sja1105/sja1105_tas.c b/drivers/net/dsa/sja1105/sja1105_tas.c
index e6153848a950..ce4b544a2b9c 100644
--- a/drivers/net/dsa/sja1105/sja1105_tas.c
+++ b/drivers/net/dsa/sja1105/sja1105_tas.c
@@ -62,6 +62,9 @@ static int sja1105_tas_set_runtime_params(struct sja1105_private *priv)
 	if (!tas_data->enabled)
 		return 0;
 
+	if (!its_cycle_time)
+		return -EINVAL;
+
 	/* Roll the earliest base time over until it is in a comparable
 	 * time base with the latest, then compare their deltas.
 	 * We want to enforce that all ports' base times are within
-- 
2.43.0


