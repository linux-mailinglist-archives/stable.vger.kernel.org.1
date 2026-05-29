Return-Path: <stable+bounces-256679-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1npyNijQGWoFzQgAu9opvQ
	(envelope-from <stable+bounces-256679-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:43:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9485606BCF
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6FBAC30E3169
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 17:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485A7386C2C;
	Fri, 29 May 2026 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PSQjfXFO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16728382395;
	Fri, 29 May 2026 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075911; cv=none; b=nIE1mA+doqi8dzVsGUkM/ZGu1GMt8O1IAuZFffu2a8BbivSwuaLUwOamOYrATJbbh63efpDcGGwoDfFMYy0r3whZ5vL1UlU8i3HIqMfPAVNRXgDPyhLEEsBftTjMFpR2J0d9JtoHPjEQ8CMQfnMcO+ZhrEMnQRPtmrYx+MRZK1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075911; c=relaxed/simple;
	bh=Q06bJju4vjK+LwTO4qrehBuUisgs7933dWko+XFsx2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMs3Hee/7DM+emklXFJVTCksb84PY6eVRwdDcMOnk8wd1eRVvgD8GkCSi0CpDUbo1ThvbQ8iFQ2hNbQKY6wVIA77ONuKPgJqfu0yxFgGbOlh3dYekRGG7Ha3XW9robrV14e8Yj7PK2DAnYx1Nhk6kCEUf5tMtl2HdosRXzo4uM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=PSQjfXFO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7F91F0089A;
	Fri, 29 May 2026 17:31:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=PSQjfXFO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1780075908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0CwUYbkKVZl/Pq7eis7n2tPVJbZkAfR4XyxZ6WhX0Kg=;
	b=PSQjfXFOp+ui4MhIaHqQjXykHkx40KS5nnm2ulTH5SwtqSCJ8YPYipsWasdxwI2YTh532/
	OB5vc3XSVwar1F8+OjGhc0l4Tbqmxg+FhnEDuQmonI9VwHTgfMC8t5oeFCyrsOBMWjmRY7
	vYJM4POnLejwjJdRVJ/cInwgQPtp9C4=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id d8c4ebe6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 29 May 2026 17:31:48 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/1] wireguard: send: append trailer after expanding head
Date: Fri, 29 May 2026 19:31:34 +0200
Message-ID: <20260529173134.3080773-2-Jason@zx2c4.com>
In-Reply-To: <20260529173134.3080773-1-Jason@zx2c4.com>
References: <20260529173134.3080773-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zx2c4.com,quarantine];
	R_DKIM_ALLOW(-0.20)[zx2c4.com:s=20210105];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[zx2c4.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256679-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jason@zx2c4.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zx2c4.com:email,zx2c4.com:mid,zx2c4.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E9485606BCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With how this is currently written, we add the trailer, zero it out, and
then add the header space on. If that header space requires a
reallocation + copy, the zeros in the trailer aren't copied, because the
skb len hasn't actually been yet expanded to cover that. Instead add the
padding at the end of the process rather than at the beginning.

Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Cc: stable@vger.kernel.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/send.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireguard/send.c b/drivers/net/wireguard/send.c
index 26e09c30d596..67d01478eb76 100644
--- a/drivers/net/wireguard/send.c
+++ b/drivers/net/wireguard/send.c
@@ -177,16 +177,6 @@ static bool encrypt_packet(struct sk_buff *skb, struct noise_keypair *keypair)
 	trailer_len = padding_len + noise_encrypted_len(0);
 	plaintext_len = skb->len + padding_len;
 
-	/* Expand data section to have room for padding and auth tag. */
-	num_frags = skb_cow_data(skb, trailer_len, &trailer);
-	if (unlikely(num_frags < 0 || num_frags > ARRAY_SIZE(sg)))
-		return false;
-
-	/* Set the padding to zeros, and make sure it and the auth tag are part
-	 * of the skb.
-	 */
-	memset(skb_tail_pointer(trailer), 0, padding_len);
-
 	/* Expand head section to have room for our header and the network
 	 * stack's headers.
 	 */
@@ -198,6 +188,16 @@ static bool encrypt_packet(struct sk_buff *skb, struct noise_keypair *keypair)
 		     skb_checksum_help(skb)))
 		return false;
 
+	/* Expand data section to have room for padding and auth tag. */
+	num_frags = skb_cow_data(skb, trailer_len, &trailer);
+	if (unlikely(num_frags < 0 || num_frags > ARRAY_SIZE(sg)))
+		return false;
+
+	/* Set the padding to zeros, and make sure it and the auth tag are part
+	 * of the skb.
+	 */
+	memset(skb_tail_pointer(trailer), 0, padding_len);
+
 	/* Only after checksumming can we safely add on the padding at the end
 	 * and the header.
 	 */
-- 
2.54.0


