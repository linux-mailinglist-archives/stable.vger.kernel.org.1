Return-Path: <stable+bounces-253824-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AKgLAyaEGoMaQYAu9opvQ
	(envelope-from <stable+bounces-253824-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 20:01:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB795B8B5A
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 20:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89C2D3006941
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 17:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DCA367297;
	Fri, 22 May 2026 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgWOsch9"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2969135A385
	for <stable@vger.kernel.org>; Fri, 22 May 2026 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472654; cv=none; b=hiEINJO+GFBn8INZi97bMYramHUtR3zXWSOpAXWYxNO93Uo68+pD2klofA2zIdMtYd3UVjF9WoJvTGIYgdzjKYlME7c2eE4kvOhrgtDtHB1z0tgzKchb1ZDEdkuvmd4+k+51ZUal33TrQfGxjzPZJq0cAyw3VnTZOY6Z0pkkg4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472654; c=relaxed/simple;
	bh=wikLoVl4AbM3L5+Zq1/t7qxKsF/SJ1XW7843dCnZgQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYcRT6+BDYh+f33O1d7k1EkXgxVyYp22gE3+7hLhwgkKxP24cEZh5qtZOWcBCqiBnCaMKbbIohQNCHpgJy2R9pZBxDx7mmHB0gjaOznHi32xp1BfNkMaFFBTKTVYuZFg2nk6fX5TNRWsdQNOeys1mmo+0wEi1ZQVHhIYInWg3CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgWOsch9; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so12531070a12.1
        for <stable@vger.kernel.org>; Fri, 22 May 2026 10:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779472649; x=1780077449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bR5EQ3Z+bYBcnVE3TKPfJID/2BeP76rf75SuWiw1z5M=;
        b=XgWOsch9kunGhAvBfHanxyYknycyOxKNWMYJkAssc64jIdeKZwmNMY7GVhJqbVzBry
         b+cW9QUNnUGpI/hYOSdb1p2YLzrzFoqYk3kLGn6zqDrY3w9Kol4E6aAasUx48EaOQgB9
         DpQBP76Oqdb09yzd+Nb1gP5OTXps5KRrzDGCAO/ys/y97y/iO+56s7vd/YyB0YPkiPFX
         jv4zHOCm4Pcnh232x3RGrLvFNUxQelMDT4h6kGomNzpSvSV6qcyNbSLqjP5KaJpoFvxK
         XGSImC/K99JlykAKBbgWlqJNT3NNZaZfBNfUDGSotMojTAowqj2owFre49XPKgr5iJ8m
         khRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779472649; x=1780077449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bR5EQ3Z+bYBcnVE3TKPfJID/2BeP76rf75SuWiw1z5M=;
        b=Ogna5LF5WJLW3IY4s6lIo3OkEs3lkpATS/zIY2l4dKU311wDwDYb3XaTGgkNLAUh/O
         vTjdjvm3oQNLPxWrV55IKz9ImnyhIFuuONiJ4SZaPLt0ufeluO1qZIzdN65vYfg/grGU
         NTXyeakI2Emz3QKTKmX7ZqZNrkkNUtGLSggwuuC++BG/i6LFTqvV7TiuB4ltCFdA7wb+
         vyXCgsac1avJoY5WUNHMOqFhTugc0AXQOENJAE0Pm7LL1xrELAd7XubtGfAgtY+08v0g
         5CjRoULpUP8Dnr7IbDDAwN6nyj/quc7YcHIyo3md+DjF3sTPbQDC2qBuqnemsRwiAPAL
         D3rA==
X-Forwarded-Encrypted: i=1; AFNElJ+GlQplDKtJIOiJqaGkIi0dvjzj8uFtVW668uRv6osTewNOkR3taIG95b+yCfrQhDHyumQteuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeaOcYQMQ3aN7rG5CdcekXo1GD6J2bJ3P+UdJCO+Uj8PFcbstm
	aejNSj0rC5N7tdXw4x9qykIRTre+VBacAjQH6/7IaP4xIcKhP2PmyuGWn82kB2R6
X-Gm-Gg: Acq92OE+e0LDPoipNzIM8ummm9BfcCfp5uP6BWEgd3uIBK13NgYhvsg+SpVhWNtM5D3
	Y/dvtHhgyZQeziBsnHP4KkI4sbx0funZoIm0htixQae/DtkeOqdBgF6s5HGBzlY8pLWMh7vlYpw
	oquAlBeIIUdY3KiJFXZLoYf78I2/p3luKsEVsedjLLVKD1IcxdeIE+XD4XPIYvRut3XnEksWY9H
	C9FZ1/iSDRyblCUvoF+RruYGXaOt7VNs+xJDKoiG10l1MS/yEGFq0kr02k7Y6QWNwT3/nFtywcs
	0HFUESymT95XnVeHJ2fc6pIpZha2GB/82ZO0HbOIFwdV3hSkCBP7TqZ1DBR0bVlBDRupJ0QDdkg
	hOc39/1jw4zoi3lQvRZiW9RREu67C+6zwXrsfPOVlRhz/YMw+JdwEhXxz6tDURqjoHs+lkZR3zH
	Gf7v1V9700Hs7t4oEj4XTTxBL8MEk9H/Cds3xSdiK8uxLrrIOmppYZWtf+/LlMzbxugcBaiGSMP
	2nJVIyrLr1LpVTkE635a+myb1g=
X-Received: by 2002:a05:6402:5110:b0:66e:cf8d:6970 with SMTP id 4fb4d7f45d1cf-6889c46833dmr2397386a12.20.1779472648784;
        Fri, 22 May 2026 10:57:28 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688b9f60898sm1002376a12.13.2026.05.22.10.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 10:57:28 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org,
	SeungJu Cheon <suunj1331@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] Bluetooth: RFCOMM: add length check in rfcomm_recv_mcc
Date: Fri, 22 May 2026 13:56:58 -0400
Message-ID: <20260522175658.41667-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com,kernel.org,molgen.mpg.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253824-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1AB795B8B5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rfcomm_recv_mcc() casts skb->data to struct rfcomm_mcc * and
reads mcc->type and mcc->len without first checking that skb->len
is at least sizeof(*mcc) (2 bytes). A remote device can send a
crafted UIH frame with a one-byte or zero-byte MCC payload to
trigger an out-of-bounds read of the second byte.

The unconditional skb_pull(skb, 2) that follows compounds the
problem: if skb->len is less than 2, skb->data and skb->len are
corrupted for all downstream MCC sub-handlers.

Replace the open-coded cast and skb_pull() with skb_pull_data(),
which atomically validates skb->len against sizeof(*mcc) and
advances skb->data. Return -EILSEQ on failure.

SeungJu Cheon's v2 patch added a manual skb->len size check in
rfcomm_recv_mcc() before an open-coded cast, but removed the
subsequent skb_pull(skb, 2) without replacing it. This leaves
skb->data pointing at the MCC header when the sub-handlers are
called, causing them to parse from the wrong offset. Using
skb_pull_data() here avoids this problem: it validates, casts,
and advances skb->data atomically, and is consistent with how
the sub-handlers themselves were fixed in Cheon's patch.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-bluetooth/20260414010741.233892-1-suunj1331@gmail.com/
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/bluetooth/rfcomm/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index d11bd5337..4e8047012 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1644,17 +1644,20 @@ static int rfcomm_recv_msc(struct rfcomm_session *s, int cr, struct sk_buff *skb
 
 static int rfcomm_recv_mcc(struct rfcomm_session *s, struct sk_buff *skb)
 {
-	struct rfcomm_mcc *mcc = (void *) skb->data;
+	struct rfcomm_mcc *mcc;
 	u8 type, cr, len;
 
+	/* Minimum MCC frame: type(1) + len(1) */
+	mcc = skb_pull_data(skb, sizeof(*mcc));
+	if (!mcc)
+		return -EILSEQ;
+
 	cr   = __test_cr(mcc->type);
 	type = __get_mcc_type(mcc->type);
 	len  = __get_mcc_len(mcc->len);
 
 	BT_DBG("%p type 0x%x cr %d", s, type, cr);
 
-	skb_pull(skb, 2);
-
 	switch (type) {
 	case RFCOMM_PN:
 		rfcomm_recv_pn(s, cr, skb);
-- 
2.54.0


