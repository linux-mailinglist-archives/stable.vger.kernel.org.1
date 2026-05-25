Return-Path: <stable+bounces-254178-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IIxNG92FGokNgcAu9opvQ
	(envelope-from <stable+bounces-254178-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 18:18:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 423195CCB80
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 18:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97F673013B70
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 16:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3C73ECBEE;
	Mon, 25 May 2026 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="trEsvmkb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3623F54C7
	for <stable@vger.kernel.org>; Mon, 25 May 2026 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779725893; cv=none; b=WjDhK+gGQQevU8oN6LXob8CeU2BYwhx4stYe8UtQaVoeNq+0usZFxOEoopEOrcqSgfPFlO/Khfh6gQvE9bO53+mGFPZEnv7kZLKgWx4sppum3Y20rfNTLkXTIKGv2z8phwwOw1n2aQLR3HoZqk2tmu6UWhTfqYS7nRxgLIVGktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779725893; c=relaxed/simple;
	bh=Z9A6BlK5sqy/y1bSlbWapeXBeb92OXQH7UFq90QBLic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbzXIdHPJmUO03tA31v1lgaSPAyE54+1JX2yvamMATms9V9PVjihea9murzmGHF8Ytk3ga1ps3cepC5aGJMlVeW5fpQoq/Gw05/u9HfCz+n8UdXJod4wszbDOfdAYYjhkpxmM7JFQMOWtMN8wL25ESAgrGFJsjtZI9tCooYMu2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=trEsvmkb; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44e1ebb3122so5928610f8f.2
        for <stable@vger.kernel.org>; Mon, 25 May 2026 09:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1779725888; x=1780330688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aBTZFEXLf4Ae4/qSPFb1sAKHfgjqYB9a6NWd+4a/d5E=;
        b=trEsvmkbMpAeKGcqEmnLSnr2rlgA3Q5G6yosAfx74Uy80m5Rr5QtYP9Ui+A5KldRlr
         JtUV49p8rFtLWnznZmn3/Uo2npvQ87wQs3PnJSKbAfhzRr9MikvBxA4KZS691JXPlciA
         XNiNGaoMUdfza/dQzVjUqQ6iVLsp0I3PHw4ZYbYE/E5BLNnwzsko8JDWrfCZxZThEIBw
         1S6h2g9Ri/nv+Xbk4+PC7iixXD5VUi0sPYkHmzwAx4/D38jlnSdH9ZwxW5PHCNfdlxhN
         Sr1ZTRGAMdAJ+S/HNNAP6frxt66v/LyTrBLhMpNhnaurSauO4hlBxz886SKMBx3VXghw
         8brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779725888; x=1780330688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBTZFEXLf4Ae4/qSPFb1sAKHfgjqYB9a6NWd+4a/d5E=;
        b=gCZlEAjMHXv3HWy63YAkbEF7EiNQUmEFQSGQP3s3+aQO+FZ7R3zMNpGabLVTkeroPG
         r/TnENAozoPSjaNpVvrN6/vFnqV397IDBwbhxK6yby352qRs8FJF2QvT6XZpCo5TFBpC
         a8tdagd7nWxwRuBFnfFIw1atOa3gAHlra+ODRcof2pZDY5bLfaFMa4boaFLlG+ViyBEV
         tNyO0628dgBLlRp47KImEDUdXIAhyHL3pG0WPB+B81gaozyrpSYLaUVFvFxzA4z+ZlMw
         nKCTf6ZoqikJMKc/JiL1fMtuzZej+ZOywzOUR0KBwN/qFhkIR6GU3khEefaeiLaov8dq
         3DPA==
X-Forwarded-Encrypted: i=1; AFNElJ8p6v/nVPL0KuQ1nzjmEKq+DNNbmiZN2zJEX5DW1oOqTwS+eL1GOwHU/Jt7ze+wU9EijQVIb8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpZIyPw3BxxeQ9vva8tdMUzBPLYpBRGf00Z1GznNWJ1+ugC3W7
	Uqe2UtaiEsaa/izHxxwPxLmEGzJNF2HGCvjLstn4fTzHWmyvurVLKQJOb/aBWyXuGLkB
X-Gm-Gg: Acq92OE8xRug8vRTQpNBi3iy8jYoSD/7okAQhD1svKgVI4FqzPwV5vDPSOv3NBnGTnl
	Ebg8JEaGZ7aPGNs59tY+BjZPUNjwBRzRN6ep+Lt1yflhgbscDryA9zYnfT9le5RdmEgoB785am0
	L8T0iz6BmNpn7wMlP8G5ZosgZeprUVTRzs46LvcWHWzclYz+1Wf2P3H56YfEYkml+TM8ByGgqaq
	Un5cNJALe8cPNwzhmIPC6twZ2f1SRUQH9L70Y3vFfgj3Sbr+4XA9DiMRGc/8B4SVO5dddNB/rVi
	LM6rhtyLr4Qn3Ns4YaRw2OsivZnBcDEbhVKuNvm+tY1yTyJKmbrsLmHVvsQXojlYEYcuLhQhhau
	gDiRlifOLDF8urH+3+u5oDZrVU0q14oKRNrr1t2LeyHVEYOtXbDC8Q9cBVDtbnXJazmYfPV6Ko4
	2+tCpA3kDDQQtGvjlqG+92XvYwpPO5R4D2ADsCy8aJWyt6zdbNwHIL6e2660XhPEM9dBRl5Yyiq
	2NC8xcE5DoiSrqzrTgY0L9Kdc8g9fdzAoUNT+hCK8iy
X-Received: by 2002:a05:6000:25c2:b0:43c:f52b:8003 with SMTP id ffacd0b85a97d-45eb39fa851mr25720549f8f.36.1779725888100;
        Mon, 25 May 2026 09:18:08 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ec7fcd7f9sm14841234f8f.37.2026.05.25.09.18.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 May 2026 09:18:07 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com
Cc: linux-wpan@vger.kernel.org,
	security@kernel.org,
	netdev@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH] mac802154: llsec: add skb_cow_data() before in-place crypto
Date: Mon, 25 May 2026 18:18:06 +0200
Message-ID: <20260525161806.96158-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[0sec.ai:s=google];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,datenfreihafen.org,bootlin.com];
	TAGGED_FROM(0.00)[bounces-254178-lists,stable=lfdr.de];
	DMARC_NA(0.00)[0sec.ai];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_SPAM(0.00)[0.092];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0sec.ai:mid,0sec.ai:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 423195CCB80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

llsec_do_encrypt_unauth(), llsec_do_encrypt_auth(),
llsec_do_decrypt_unauth(), and llsec_do_decrypt_auth() all perform
in-place cryptographic transformations on skb data.  They build a
scatterlist with sg_init_one() pointing into the skb's linear data area
and then pass the same scatterlist as both src and dst to the crypto API
(e.g. crypto_skcipher_encrypt/decrypt, crypto_aead_encrypt/decrypt).

On the RX path, __ieee802154_rx_handle_packet() clones the received skb
before handing it to each subscriber via ieee802154_subif_frame().  The
cloned skb shares the same underlying data buffer via reference
counting.  When llsec_do_decrypt() subsequently modifies this shared
buffer in place, it corrupts data that other clones -- potentially
belonging to other sockets or subsystems -- still reference.

On the TX path, similar data sharing can occur when an skb's head has
been cloned (skb_cloned() returns true).

The fix is to call skb_cow_data() before performing any in-place crypto
operation.  skb_cow_data() ensures that the skb's data area is not
shared: if the skb head is cloned or the data spans multiple fragments,
it copies the data into a private buffer that can be safely modified in
place.  This is the same pattern used by:

  - ESP (net/ipv4/esp4.c, net/ipv6/esp6.c)
  - MACsec (drivers/net/macsec.c)
  - WireGuard (drivers/net/wireguard/receive.c)
  - TIPC (net/tipc/crypto.c)

Without this guard, in-place crypto on shared skb data leads to:
  - Silent data corruption of other skb clones
  - Use-after-free when the crypto API scatterwalk writes through a
    page that has already been freed by another clone's kfree_skb()
  - Kernel crashes under concurrent 802.15.4 traffic with security
    enabled (KASAN/KMSAN reports slab-use-after-free)

This vulnerability was identified using 0sec.ai, an open-source
automated security auditing platform (https://github.com/0sec-labs).

Fixes: 4c14a2fb5d14 ("mac802154: add llsec decryption method")
Fixes: 03556e4d0dbb ("mac802154: add llsec encryption method")
Cc: stable@vger.kernel.org
Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/mac802154/llsec.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index e8512578398e..b6a4a8c93d72 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -710,6 +710,7 @@ int mac802154_llsec_encrypt(struct mac802154_llsec *sec, struct sk_buff *skb)
 {
 	struct ieee802154_hdr hdr;
 	int rc, authlen, hlen;
+	struct sk_buff *trailer;
 	struct mac802154_llsec_key *key;
 	u32 frame_ctr;

@@ -769,6 +770,12 @@ int mac802154_llsec_encrypt(struct mac802154_llsec *sec, struct sk_buff *skb)
 	skb->mac_len = ieee802154_hdr_push(skb, &hdr);
 	skb_reset_mac_header(skb);

+	rc = skb_cow_data(skb, 0, &trailer);
+	if (rc < 0) {
+		llsec_key_put(key);
+		return rc;
+	}
+
 	rc = llsec_do_encrypt(skb, sec, &hdr, key);
 	llsec_key_put(key);

@@ -908,6 +915,13 @@ llsec_do_decrypt(struct sk_buff *skb, const struct mac802154_llsec *sec,
 		 const struct ieee802154_hdr *hdr,
 		 struct mac802154_llsec_key *key, __le64 dev_addr)
 {
+	struct sk_buff *trailer;
+	int err;
+
+	err = skb_cow_data(skb, 0, &trailer);
+	if (err < 0)
+		return err;
+
 	if (hdr->sec.level == IEEE802154_SCF_SECLEVEL_ENC)
 		return llsec_do_decrypt_unauth(skb, sec, hdr, key, dev_addr);
 	else
--
2.45.0


