Return-Path: <stable+bounces-235966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKMoCJ6v3GnfVAkAu9opvQ
	(envelope-from <stable+bounces-235966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:55:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E393E9661
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 453803010B64
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74813AE1BD;
	Mon, 13 Apr 2026 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="SGx3k+5B";
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="orBkzjje"
X-Original-To: stable@vger.kernel.org
Received: from mailhub11-fb.kaspersky-labs.com (mailhub11-fb.kaspersky-labs.com [81.19.104.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB903AE6FA
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.104.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070488; cv=none; b=gdefLCbpImZ5U0MzRkQVzuouBoMyUm5OECzrcV9e4jsBypBn8MK66HPElJAt0o8wFVgz2vz+z8u+9cF/DeneWDx5xt4Oi1dLZQZ1BSn6tghhuAqqTCKvH7VuVT/59TDaDpi7Dv7bZ5JpnsZ3s6RxMPdtDJy7gXd48AUWu2bDcFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070488; c=relaxed/simple;
	bh=WzzuVQiM3vQq7Pu3MA9rG3D8KIzEfGSPLkZjzsLkU5o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C26N+Q401T2BBuE640u9D3gPSi+6kvbp9D1GLAaZer4sfttIyZsaxoQwIdLEFC8/zhdE0hlC483hJj9sz9OY67Bw/4O8Td/KyOgeNNzigEhK5uVQDb2PKhP7fRrq/kW/i1k561o8I1QBJkPUKkYsjDZCp8l4dDfpgdYO13dLiUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=SGx3k+5B; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=orBkzjje; arc=none smtp.client-ip=81.19.104.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1776070165;
	bh=K+knYpaQC63S6yxb+K9P2BEcXIw8nVZezjjBAu4p/T8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=SGx3k+5BYPDxEvIQJqGUPD1zA4afE/yt+RpVviPrVqOl801Px/4GX3LCEl8wCH8kI
	 Q/A7Esr9IoQHts2HqLQTnsm4uX4b50YZyzXCPrGh15LCn5yp3N7L6G9R+RG9RUHJjN
	 bifEd+keo+PSfHNLwMbNbp9DANS52nDWzsApKWvSWukdsKfQ9dBtQXjHgNptbs+Ogi
	 nnXMuTehDNMXGH/SUIBhApMubAXpMoCT9ZHGvNcvRDX/B0uE6hMR5PjDQDGpRKsdM3
	 ZwDz/O0vsrlcU1AAN8aYt4MbAFwveme9EGS7pDUI49TofDEuTgx7YY0jh6FyzOxPWQ
	 OZcAMnvBw4T8g==
Received: from mailhub11-fb.kaspersky-labs.com (localhost [127.0.0.1])
	by mailhub11-fb.kaspersky-labs.com (Postfix) with ESMTP id 4322BE8198C
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 11:49:25 +0300 (MSK)
Received: from mx9.kaspersky-labs.com (mx9.kaspersky-labs.com [195.122.169.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "mx9.kaspersky-labs.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub11-fb.kaspersky-labs.com (Postfix) with ESMTPS id 1B770E81359
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 11:49:25 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1776070157;
	bh=K+knYpaQC63S6yxb+K9P2BEcXIw8nVZezjjBAu4p/T8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=orBkzjjeb3Wk4MjxQPUt6sYM6uO4FMulv31qvC0bze8Q+8NTEDFnuidPVc3jpLkKg
	 7CGFEFdPRvLZDZp7JWdjpEcjc7zaxry5eonfn9g7SJ4rgv+DoEjMtzlIUMivJQjNi/
	 x/D4VIm0Q11SzZLhRy8I04gyV/Ajdeux0i0CV2K5onf1F2R2Qp44F9+bZHbauTsokn
	 f+VCs3A07comtN4zu9RHUJ/VHaRkkmEVf1I9yrqpTg2UxyaMJPCtGyZTvS5/dHWPii
	 csn0O9KVGedaCjPwf9SDgUZDpXAoNZnDzQWWQJGWImRUCf6jmAiFpmDkGMNSSt8Aw8
	 XfRQyAvUTtB2A==
Received: from relay9.kaspersky-labs.com (localhost [127.0.0.1])
	by relay9.kaspersky-labs.com (Postfix) with ESMTP id 027BE8A063E
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 11:49:17 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub9.kaspersky-labs.com (Postfix) with ESMTPS id C926C8A0581
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 11:49:16 +0300 (MSK)
Received: from chesnokov.avp.ru (10.16.105.7) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 13 Apr
 2026 11:49:15 +0300
From: <Alexander.Chesnokov@kaspersky.com>
To: <Alexander.Chesnokov@kaspersky.com>
CC: <stable@vger.kernel.org>
Subject: [PATCH] net: dsa: sja1105: fix division by zero in sja1105_tas_set_runtime_params()
Date: Mon, 13 Apr 2026 11:49:08 +0300
Message-ID: <20260413084908.32745-1-Alexander.Chesnokov@kaspersky.com>
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 04/13/2026 08:35:29
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
X-KSE-AntiSpam-Info: kaspersky.com:7.1.1,5.0.1;chesnokov.avp.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/13/2026 08:38:00
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kaspersky.com,reject];
	R_DKIM_ALLOW(-0.20)[kaspersky.com:s=mail202505];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kaspersky.com:+];
	TAGGED_FROM(0.00)[bounces-235966-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Alexander.Chesnokov@kaspersky.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxtesting.org:url,kaspersky.com:dkim,kaspersky.com:email,kaspersky.com:mid];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: D5E393E9661
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


