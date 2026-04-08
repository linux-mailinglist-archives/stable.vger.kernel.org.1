Return-Path: <stable+bounces-233950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOQxFNCP1mmEGQgAu9opvQ
	(envelope-from <stable+bounces-233950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:26:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DAC3BF835
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B3393059FEA
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 17:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B733D75AF;
	Wed,  8 Apr 2026 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qP3gKH4t";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="c5G4GbAU"
X-Original-To: stable@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34C329BDB4;
	Wed,  8 Apr 2026 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669087; cv=none; b=l1ujYJG5C+OiUIXgYbZ396s5hQ2144WPzEAGH4oK3QvMypnAdZ9s9CbnRFPaUGC5UM3gdhkWNV7MGcC4QbGybIuef/PzWXrSWaPtIhbtL98y+7t5SBYeUorV9rXB9YqrBdPG1NJqE6xw5ATC1e3urNbjbK+YH9xi9D2fwDZw01g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669087; c=relaxed/simple;
	bh=+bDCbb8aBa+aED379bW+tQAawG2MwnKuPhBmpuxtEzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plTGMznBbM/XaBbtdhAuDeSegn9Uk8NN9IlbIbaDBCaOD9pms0xNH5q17pZfSpA9pFjG6PSTvJ3WlzReHeIgs6/ZSG+fm5/U/a/eeoiMcZSFjvh68oc9DkUwSw/tTVsUac4AchZZOxq7znoTyb1Efb2TCviFZecn0hEXbMxORhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qP3gKH4t; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=c5G4GbAU; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4frVLM13Y6zB15Y;
	Wed,  8 Apr 2026 19:24:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775669083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qaeMhsOtJt+rHdsiAnmX/WY9szbjdk96l7AUuPEpvec=;
	b=qP3gKH4tWZcehFYW3s5ayevIXnVJXZqNtekFcznXElntOkszYYZMYhFmuOgkr0BkoguRlr
	Mq0E5KIrvlirz0a0gBKlQCcluZUesQi1NZUK5BbTibqZHkMhvnlOR3AgM+ozZuIb9Um2ma
	3QPRgp5I7CmpMkBQDAFLcpoekGj1wD90IpTMw3p1u9qbZBuTk8slhDeKs38Nlnh2X7E80G
	NdpRUtateEpJH6vXx7xWmFszPT52DLiH31yIUpqj+s7Dy8znJ5dFYcHHw/SoKx/uJ69m6K
	BhavS/FUAVJO/fW+ZCznzjKtKS625s9AuqQsM4KOxR+lEyb4Xdo1K7OhpCeMGg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=c5G4GbAU;
	spf=pass (outgoing_mbo_mout: domain of mashiro.chen@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=mashiro.chen@mailbox.org
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775669081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qaeMhsOtJt+rHdsiAnmX/WY9szbjdk96l7AUuPEpvec=;
	b=c5G4GbAUkFimoGgWO8W8CWjD6RPhv+OewqvdDrBSW/XuJ3Wuhr8VA7DRWJ7TIFLCJ9qbBk
	lkOWTpT1DDyph0xGiTYn+URhfHoqeRn1juFJggqEjklZS9WvDW23cxo4NkdTcgahuwxAH4
	YFdr21cBgN510DvAsNePfKLTXq5FWRSN+oTh0qmT3hOeUXlmOFk9MF9fsxTzpTUMSKVjH0
	vZXX6fZwK9HkNH5vR8UOn+RQzlQCC+mqW8RyFS+mUPYmtFEPKjNI+9JC5t/ELxzkNcB8Zm
	wH3AEt779a0/s/ypi38RkPGCnwl3wpvgsvtzSpzq5eU4744V7TXB8zBPcopZYw==
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jreuter@yaina.de,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net: hamradio: bpqether: validate frame length in bpq_rcv()
Date: Thu,  9 Apr 2026 01:23:57 +0800
Message-ID: <20260408172358.281186-2-mashiro.chen@mailbox.org>
In-Reply-To: <20260408172358.281186-1-mashiro.chen@mailbox.org>
References: <20260408172358.281186-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: nwn1bintp8o4r8pc7y7mwbhhg45xny8m
X-MBO-RS-ID: 5d1e2c214e5180d5c86
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233950-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5DAC3BF835
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The BPQ length field is decoded as:

  len = skb->data[0] + skb->data[1] * 256 - 5;

If the sender sets bytes [0..1] to values whose combined value is
less than 5, len becomes negative.  Passing a negative int to
skb_trim() silently converts to a huge unsigned value, causing the
function to be a no-op.  The frame is then passed up to AX.25 with
its original (untrimmed) payload, delivering garbage beyond the
declared frame boundary.

Additionally, a negative len corrupts the 64-bit rx_bytes counter
through implicit sign-extension.

Add a bounds check before pulling the length bytes: reject frames
where len is negative or exceeds the remaining skb data.

Cc: stable@vger.kernel.org
Cc: linux-hams@vger.kernel.org
Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 drivers/net/hamradio/bpqether.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/hamradio/bpqether.c b/drivers/net/hamradio/bpqether.c
index 045c5177262eaf..214fd1f819a1bb 100644
--- a/drivers/net/hamradio/bpqether.c
+++ b/drivers/net/hamradio/bpqether.c
@@ -187,6 +187,9 @@ static int bpq_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_ty
 
 	len = skb->data[0] + skb->data[1] * 256 - 5;
 
+	if (len < 0 || len > skb->len - 2)
+		goto drop_unlock;
+
 	skb_pull(skb, 2);	/* Remove the length bytes */
 	skb_trim(skb, len);	/* Set the length of the data */
 
-- 
2.53.0


