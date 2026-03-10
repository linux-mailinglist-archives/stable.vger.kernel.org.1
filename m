Return-Path: <stable+bounces-224581-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOvjIZKOsGkukgIAu9opvQ
	(envelope-from <stable+bounces-224581-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 22:35:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC1D2585A8
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 22:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FE34325A243
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 21:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419503EFD04;
	Tue, 10 Mar 2026 21:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johannes-moeller.dev header.i=@johannes-moeller.dev header.b="MRus8NSx"
X-Original-To: stable@vger.kernel.org
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3616309EF9
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178260; cv=none; b=fXNajDBFSrvFYr2qIs2EDOcTLjTFZw4+RcvmLOk1UzWYOBhy2vTSkiL8FE9oSGbOj62doTppOSaU0EEPPlfTptkpd64Pe5Hd/Ky73CGfF09qQIXHWZHKe9QjUcY0DHnKcFP0qXBPNVo0OEB0JvURasklmHW5eIQumODOlqYj4dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178260; c=relaxed/simple;
	bh=Vu8s7jUwMOvlyEwIzaoSMQ+wQNXgnXVAF0jZnj55++4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bC8pTx3yUG4zibIfQxqHPWwQWgOsY0lNe5Azrec5MBNcqpxkzO80xtUfPWUw+5clBIJXFjXPp/hpkRr+OmR4XcPF+LLOH2SP5/Y3KHR7m7PA12LANt5bHdYmZuOHP3dIrottCW1eUonUWWJ8MLt9QezbL8+4/+aSd0G+lA5s9pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=johannes-moeller.dev; spf=pass smtp.mailfrom=johannes-moeller.dev; dkim=pass (2048-bit key) header.d=johannes-moeller.dev header.i=@johannes-moeller.dev header.b=MRus8NSx; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=johannes-moeller.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johannes-moeller.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=johannes-moeller.dev; s=protonmail; t=1773178249; x=1773437449;
	bh=Ejdg6l7b/i4f0KmxGuMk1g7CgiSer0a95DBCWcHIAss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=MRus8NSxFzAAA2xJeghfXEa0DeqsSfvp4VFrinP2OsXTTZi7xvI+zleO8/vWuJPGt
	 aeDvuRvorr2WKFDRixUwKeyA2NxQEyKkTMDxNU/h0snfWJnEIDFWAiQ1a40T5mavES
	 k3XQKRjHxbOh5UnGuXBaeD1WeJ+1PMYqWZ5Krii5WCvq/pWjzLylOYuXHDNJvrKUmR
	 z3VmRfgchq7XQ4YI4DIaPWPYWfW6fQ+oxLgnw/1UF6dprVYEIXeD76v8mfBfQDbV8N
	 hec9G+8cnqQzg4coniFEutcMGlgBCObvwruogb4Ir4A7mSi4K43iS9RKL7ZFaRM+0Q
	 SZcPQDV68wYnQ==
X-Pm-Submission-Id: 4fVn9g73n2z1DDKr
From: =?UTF-8?q?Lukas=20Johannes=20M=C3=B6ller?= <research@johannes-moeller.dev>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: security@kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Lukas=20Johannes=20M=C3=B6ller?= <research@johannes-moeller.dev>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: L2CAP: Fix type confusion in l2cap_ecred_reconf_rsp()
Date: Tue, 10 Mar 2026 21:29:48 +0000
Message-ID: <20260310212949.74577-1-research@johannes-moeller.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <abBJh7sJ11RKVGhd@1wt.eu>
References: <abBJh7sJ11RKVGhd@1wt.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ADC1D2585A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[johannes-moeller.dev:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224581-lists,stable=lfdr.de];
	DMARC_NA(0.00)[johannes-moeller.dev];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[johannes-moeller.dev:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[research@johannes-moeller.dev,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,holtmann.org,gmail.com,1wt.eu,johannes-moeller.dev,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,johannes-moeller.dev:dkim,johannes-moeller.dev:email,johannes-moeller.dev:mid]
X-Rspamd-Action: no action

l2cap_ecred_reconf_rsp() casts the incoming data to struct
l2cap_ecred_conn_rsp (the ECRED *connection* response, 8 bytes with
result at offset 6) instead of struct l2cap_ecred_reconf_rsp (2 bytes
with result at offset 0).

This causes two problems:

 - The sizeof(*rsp) length check requires 8 bytes instead of the
   correct 2, so valid L2CAP_ECRED_RECONF_RSP packets are rejected
   with -EPROTO.

 - rsp->result reads from offset 6 instead of offset 0, returning
   wrong data when the packet is large enough to pass the check.

Fix by using the correct type.  Also pass the already byte-swapped
result variable to BT_DBG instead of the raw __le16 field.

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Cc: stable@vger.kernel.org
Signed-off-by: Lukas Johannes Möller <research@johannes-moeller.dev>
---
 net/bluetooth/l2cap_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ad98db9632fd..f8ed03095592 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5424,7 +5424,7 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 					 u8 *data)
 {
 	struct l2cap_chan *chan, *tmp;
-	struct l2cap_ecred_conn_rsp *rsp = (void *) data;
+	struct l2cap_ecred_reconf_rsp *rsp = (void *) data;
 	u16 result;
 
 	if (cmd_len < sizeof(*rsp))
@@ -5432,7 +5432,7 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 
 	result = __le16_to_cpu(rsp->result);
 
-	BT_DBG("result 0x%4.4x", rsp->result);
+	BT_DBG("result 0x%4.4x", result);
 
 	if (!result)
 		return 0;
-- 
2.43.0


