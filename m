Return-Path: <stable+bounces-233244-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEG/GzhI0Glu5gYAu9opvQ
	(envelope-from <stable+bounces-233244-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 01:07:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE686398ED6
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 01:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D157301C6C0
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 23:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FAE38A710;
	Fri,  3 Apr 2026 23:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfGPaQVy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3B3285C8B
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 23:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257644; cv=none; b=CZcoGa4F2aw3IQRcIuu9z7ibO0FbThcv6mVMM8dHcvIWbWlRU8RkGS/mnBlUncKDpaHyWFpZQafejBatow/0MBebXLnmccTjqFfuB1a1WhwQS9G4yCG3vr46owzrUqEf0PN97CMLwcsnTduaDUYW3SE/Nzx8R8vzsciWuNaX7Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257644; c=relaxed/simple;
	bh=w9Up1fKB2GEY6om9s47lJMNvXz+5zEdTXVEOI5jkmIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JlLlYc4BmiCqY8XafaMEVYKKQ/p7tDTEk4oTcPenghhV8aLbrSi85xBedXppsR6GoeXkD5i+1USK+Cu4S+H92CAn8X/FeFyeQklX7OI2jGrbcf1zJEPthMEuFj8Dh2aSJz9xtv9Fqd2t7NIKHge09C8EyeIhz2+KXaZ5mMcGUYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfGPaQVy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4888244e9f9so20623405e9.0
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 16:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775257640; x=1775862440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LFVf762eS5hmMghaQTstY0t0CTwtXlUiAW2YdJ/qH4Y=;
        b=ZfGPaQVybBqvtxFRuGhx0wL3V+XXpMaDYShiLea2wwphqYqyvtYv3vqNQm3fEfdkZb
         KOl8kRP9eygkTVf/S569F46JSShw2Fa5hJgDuhx6u+75ysad3Mc/dyWqFXx57vxfJ2CS
         DT+/Gu5fqrnz6DgMg9657yf7Fh1QmLbAR8fIXWfd4lHn/xaWFeIbP0AkGK9M3YPyUA+J
         CLrv28QJYV0d4V1mYg2renK3Luy9Yn2GHZbQ9sC+MLr63VN07AB2eot3mH0vjflBT26B
         vMLCHitl7t5shed6jmX7dELGBqgVXi6XxoOCDOplqyw2xSSinl9eJG2+hyNmajrGe8BT
         xgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775257640; x=1775862440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFVf762eS5hmMghaQTstY0t0CTwtXlUiAW2YdJ/qH4Y=;
        b=kWVW1KGHGTyXLwr24EeTFcC5jHLdYtcf/pz0FOQqcgoRvMXoxOVbZmESbz3yhHPZkG
         TYZL2D0oxdA63DwnY6I5AUFHyJLLeSYmtV/TduJKNIv3vYW4TTnQqBt8SXEAienuHW9E
         lUVLaaX88UeRwEY325qrN7HATRnUjllfTC9tQFBXaHM8jFr8Ek9oMmp4K7oIp1A4+uOC
         nKK2epDEQt4eF2rcQiIC6gnVV1eSk2Vu1ZfEqoYwugyRycBXJgn6t5yBapLT0QQUz7UU
         UepH9LtmIf7aBDvMqljmlAPjCbbAJtuxDcLa15ZvwGPbJFHfF+S7Oiqy2DDyM+JTEnaU
         1UyQ==
X-Gm-Message-State: AOJu0YzSMh8Csl09wkPSfRWoCsh/1Zb2nMwZ8AYedorg9hSFIVCFINAy
	a/S+TeC0f0ZTQwzbgyfDereDyZt4hFub1dd9gWk1Kwr/iO4cxzuIAI/E
X-Gm-Gg: AeBDievGCWZQWTC3KI9E1DQy++B2ZjqKG641bNwSxfSPf1rSs59L5uC9shp8y3s9k3r
	+rDps5VlW769o03rRPjpu7DRZPHjv8eSyqKrkh1Bm4O8BCgpLeLhRZdbPkjZRIngp3eODG+3S9n
	MOVyfs1NFKS+hWDUMa85Ah6SHod/hFEWbmFIX2Z3pDDK9lviGJwCLigOdBUiTciyq/YzDfEOHp1
	UskOcbv8RneI0hBREn5PJJ/QgF1bSOFfOYrG9WGWqKVjDn6Wfau46kJG7O4PkJk7zBQ0nA70mcU
	acDlt4QzR6YHm0aKhAMDMwxX5K3UIvd8aLNiDmemMr8SiBnYOfR45uTZ/ahGerP0PqPHXb+/L66
	2p++aGL/LJv8uUkzBRDzGirsLmB8kn2+CVbck8+nHP3lXnbkqq+UTB7YYB8Gx/P/QMjVwbsnJRd
	kuhrFpQGCIny8pX31E3Fd+cvF7cAFZBLQDo5dx+oeRa0MhnhXhpGxW0fuvR0dMyVudWz0Q5VZPD
	pYJBK6+cdOu
X-Received: by 2002:a05:6000:2c0a:b0:43d:14cb:8470 with SMTP id ffacd0b85a97d-43d2930630dmr7189067f8f.46.1775257640395;
        Fri, 03 Apr 2026 16:07:20 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c60a2sm18830924f8f.10.2026.04.03.16.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 16:07:19 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2 1/3] net: lan966x: fix page_pool error handling in lan966x_fdma_rx_alloc_page_pool()
Date: Sat,  4 Apr 2026 00:07:12 +0100
Message-ID: <20260403230714.10667-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233244-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE686398ED6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

page_pool_create() can return an ERR_PTR on failure. The return value
is used unconditionally in the loop that follows, passing the error
pointer through xdp_rxq_info_reg_mem_model() into page_pool_use_xdp_mem(),
which dereferences it, causing a kernel oops.

Add an IS_ERR check after page_pool_create() to return early on failure.

Fixes: 11871aba1974 ("net: lan96x: Use page_pool API")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 7b6369e43451..34bbcae2f068 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -92,6 +92,9 @@ static int lan966x_fdma_rx_alloc_page_pool(struct lan966x_rx *rx)
 
 	rx->page_pool = page_pool_create(&pp_params);
 
+	if (unlikely(IS_ERR(rx->page_pool)))
+		return PTR_ERR(rx->page_pool);
+
 	for (int i = 0; i < lan966x->num_phys_ports; ++i) {
 		struct lan966x_port *port;
 
-- 
2.53.0


