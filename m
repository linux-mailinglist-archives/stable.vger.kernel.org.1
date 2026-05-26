Return-Path: <stable+bounces-254422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLeCNTjpFWqXegcAu9opvQ
	(envelope-from <stable+bounces-254422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:40:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A135DB778
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8F8C300EA8A
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55364219EB;
	Tue, 26 May 2026 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="s+Edj5+Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85174219FE
	for <stable@vger.kernel.org>; Tue, 26 May 2026 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820652; cv=none; b=m5kqF23Jm1DZCUx8uwNrTeHwwy99dD+as8TMJqAKPtpb9kB+/WFw5KlAICSEdQtad7kh9qAnxsVyvRnOOI73H6KAyKR4fFHFUbSVmKCDLxDqWe3AlKl8ldzTFpL+ftdjberxeQhBk6L2FzhNogBazkjpoYFVwlLEiwqrPQlMsNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820652; c=relaxed/simple;
	bh=qMZKEzKm2QuHaMTiZQhoB7eayvCxCYtSQW0Pa32K1mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knJYSxiJ6LuU+7PThtB/i649VeN0ebaL0nB7OXrUUiJUG9RURrTxG7XdFUXSlL88FFqa+YvsYeiuUGEYzNQGaAJkTSDH4fZBU8Zf2LbeLcvRyiUJSKszlP2e+MoN/7j0G3ZrcWf3RAfaF6uHNHTRbu9ZP6cLcw//ZcCcyG9Qxdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=s+Edj5+Y; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45e9f4a3510so3144589f8f.1
        for <stable@vger.kernel.org>; Tue, 26 May 2026 11:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1779820649; x=1780425449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyPLg68IB+9zQ8MOCEl3EcTRfH24d5QSaojSphJzQ2Q=;
        b=s+Edj5+Yyc0SFmNsSKO8eM5sr7tpUgLB2/2q2jAFn23stPaHk7KxED/1r4OBlFOtri
         JrX3wPd5jeqLIYPBxANJctLuCEIX/mmbV3kVW9O1vvA0McOJUw7goqJhr4AzvMv2m9KM
         ZGb+eZ+Fb2pHkxoRNEq0b5RNRNFS2yHQG+oVW6eRKqDa/Z84yDayuLvtto/QnWlUPUpf
         9skgph6eptV5X4p8bGRU38PEpRAT4zC716ZlCRwG1MQQ8vzav+ytx9FQCZIydxTOK7Fr
         tOFV9OxpLcdk47nPeK0KZddLEfQhIGhLFlzSyyJKpPAKlFsm/QIu9zaSKqLKTBVMW+cY
         cRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779820649; x=1780425449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zyPLg68IB+9zQ8MOCEl3EcTRfH24d5QSaojSphJzQ2Q=;
        b=Zol5qNKsMKvKoIDxvQEzVQ+BJ7EIT1da9/GnmkJzo5AlVtwTmKnoFyKs5Xn4E4uAMd
         EWsZEE2H5vpkQt03ap5c5Tdu6eJf9rBAgUyyyQKbq/V69fwadEiPqzGjYuwPmCKBhkXm
         h3Z/AuRD+QhU9+ex6KpqN89fsao4dc+UKyf1Qk8jKOosq5vY25paI4fBLbX6FGpEFcO+
         GY1CTDHVTfy0rxeSXUNI+B4o/rBBZPYhYJFdCoa/dZMmCBizqd9cu5wt9JXMsQc9EbTZ
         AlN2VqjA2Y6Bd5kx7mrj6NINU5U4CiEQuNzgMoviHQgH2X95mazlLR09ZDhXcVKo0Of4
         3Gsw==
X-Forwarded-Encrypted: i=1; AFNElJ/8RKuD/Zg+E0IymUC2+HAGO4QZxxFiq5IIBOROL5XIreBz7/7vCl2AK4OIKvdpu+GnyCkp/2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRYHVmh8VX27XgjFBiGNivkWNYGKhqNz7Md2H1nlkFYzbhS2j3
	+eOJIwXC6TLgUxydCYGnfaIoeVEGZV5brbXd9xnDuxYgAasLZB9tVbP8fIxRZzlzXJ2R
X-Gm-Gg: Acq92OEB5zRRVrReSVC7cRRiMr27LS7AHRlfECkgOQwmJXHn9zTIGyJoGEc3hjzGpFF
	2RPPO0UTjcWuL03+z6Q8IBzFTy4DgFBkA3VU2nRAxJCiAJUc58IzWSLvzduZQcBNOmOFBpUuCWi
	R7ZGrHlsvSxh8/Ic4md7iAsuGb1Q9RMZSLtVpkH4XzwoF/gHuNgkW3mcUuFxHU1G64htuaoVeSH
	/tY7+1Xj+wRmOMozGn8gntCm/nP23rBN6gcPGL2TcgkVmOGKLe854KN7Bl1mxCFIkL7MqrUz3P9
	hHPWjemU6dB9X65sWLcynBplvhLIwOBgR4T3ev5SnISfNUDX5sRuCQpgMCev3mi5pWt370ZtcRg
	YdnJRYUWbONbLRK7vBLgoGiMtdAcKR1oJEOffEVgma4SnYIFhe52OKqCUzGTxM6POlWmD0NORYZ
	2LWNDMwLLjxaaZ0UAsuJXyb2fW1kMjFWFgTbJ/IlndjrUyKtF+oxtYBNpe8TRP94EeuVYubdWbX
	AiQhwdHWRWHLQLaJg5PcXLoCjOTeeMOupymE65DUmrs
X-Received: by 2002:a05:6000:2883:b0:45d:3cb0:5ab1 with SMTP id ffacd0b85a97d-45eb38ca1cemr35106577f8f.38.1779820648940;
        Tue, 26 May 2026 11:37:28 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5c2323sm68164f8f.34.2026.05.26.11.37.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 11:37:28 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com
Cc: aleksander.lobakin@intel.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH net v2] mac802154: llsec: add skb_cow_data() before in-place crypto
Date: Tue, 26 May 2026 20:37:26 +0200
Message-ID: <20260526183726.56100-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525161806.96158-1-doruk@0sec.ai>
References: <20260525161806.96158-1-doruk@0sec.ai>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,datenfreihafen.org,bootlin.com];
	TAGGED_FROM(0.00)[bounces-254422-lists,stable=lfdr.de];
	DMARC_NA(0.00)[0sec.ai];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:-];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_SPAM(0.00)[0.224];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,0sec.ai:url,0sec.ai:email,0sec.ai:mid]
X-Rspamd-Queue-Id: 35A135DB778
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

Found by 0sec (https://0sec.ai) using automated source analysis.

Fixes: 4c14a2fb5d14 ("mac802154: add llsec decryption method")
Fixes: 03556e4d0dbb ("mac802154: add llsec encryption method")
Cc: stable@vger.kernel.org
Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>
Closes: https://lore.kernel.org/linux-wpan/20260525161806.96158-1-doruk@0sec.ai/
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2:
  - mark as net fix per Olek's review
  - add Closes tag
  - add Reviewed-by

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

