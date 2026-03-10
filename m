Return-Path: <stable+bounces-224592-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEICN6GUsGkukgIAu9opvQ
	(envelope-from <stable+bounces-224592-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 23:01:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F20258A08
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 23:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAA7B3119467
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 22:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25FA3F20EA;
	Tue, 10 Mar 2026 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johannes-moeller.dev header.i=@johannes-moeller.dev header.b="ot9Q50H+"
X-Original-To: stable@vger.kernel.org
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C9E3F20F0
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 22:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180044; cv=none; b=gVaOzYEw4SiHgs/KXK1zWoThzrMT4RWCvJjsHGZ9Bx9pRwVg7EeJxnOU0wPSuczCywbp/Kwq3ieDBSrqyHQz9TOMxHSKP4hhNL0tvOid7gX904Xm1TBNMNdn85iZ6e3OraraH6h1qZ9MRqlTHYxfAmwBSTtuXvk/SJWRsZ6Z83A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180044; c=relaxed/simple;
	bh=Vu8s7jUwMOvlyEwIzaoSMQ+wQNXgnXVAF0jZnj55++4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uBJtR+J1AIAcN5ErAyaZPmd/ZSdVvbwPzMldQU8cD5JuwA3S2HcJ4fxFQQFQh9uqp8qhOcwJai8DNdCn4+NLolTTezwMQqg76alEXPcc67u+KTJQV7BrPjY5OUNuF1Ie5m3wcDwjbKamzWnXogezLLKRBpkawuhOA1h//w7FxBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=johannes-moeller.dev; spf=pass smtp.mailfrom=johannes-moeller.dev; dkim=pass (2048-bit key) header.d=johannes-moeller.dev header.i=@johannes-moeller.dev header.b=ot9Q50H+; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=johannes-moeller.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johannes-moeller.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=johannes-moeller.dev; s=protonmail; t=1773180034; x=1773439234;
	bh=Ejdg6l7b/i4f0KmxGuMk1g7CgiSer0a95DBCWcHIAss=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ot9Q50H+wXeyoT+d80eVg0z87DsxbnTf9aO1/V6DOyY6Lgb9D6qmb9vmo/P+09zVU
	 EJmK06/RBlaHddkG12kwS8TuggUXdgl8zmf6+oY/5ugkyfougNQNQThzCpad0EjceR
	 sNuSOskQqQhoXzIGxFqW4tfXzhNh5YNv3goR0EkQQxcL+GuUYKPpFMWYp9WDcd06AG
	 Dit4HSVcUG4WCWU4TvfBVYLqFN9gkrjUJ3US2uVSAPNaSm/FSPEEKIu9fEGOBOuy9W
	 ID1YPvoMWcvKSxTeZSjnr3KZ+86lS2UsWW9CxZ+SiIWaa7J1ESak2nTrPQJuscTY+V
	 S3X3uaViwQXUQ==
X-Pm-Submission-Id: 4fVnqx3Xvtz1DDL4
From: =?UTF-8?q?Lukas=20Johannes=20M=C3=B6ller?= <research@johannes-moeller.dev>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	=?UTF-8?q?Lukas=20Johannes=20M=C3=B6ller?= <research@johannes-moeller.dev>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: L2CAP: Fix type confusion in l2cap_ecred_reconf_rsp()
Date: Tue, 10 Mar 2026 21:59:46 +0000
Message-ID: <20260310215947.35756-1-research@johannes-moeller.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 41F20258A08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[johannes-moeller.dev:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224592-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DMARC_NA(0.00)[johannes-moeller.dev];
	FREEMAIL_CC(0.00)[gmail.com,johannes-moeller.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[research@johannes-moeller.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[johannes-moeller.dev:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[johannes-moeller.dev:dkim,johannes-moeller.dev:email,johannes-moeller.dev:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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


