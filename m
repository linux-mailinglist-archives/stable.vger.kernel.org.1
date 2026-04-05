Return-Path: <stable+bounces-233319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG5QIMn40Wm9RwcAu9opvQ
	(envelope-from <stable+bounces-233319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 07:53:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE0339D740
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 07:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A29173012CE9
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 05:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7E9369967;
	Sun,  5 Apr 2026 05:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF/dX01n"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103436B047
	for <stable@vger.kernel.org>; Sun,  5 Apr 2026 05:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775368375; cv=none; b=OJOb7SJgLVWzqn44gxJIbwCfkL4czTyBnjvHpM4V3WGS0SrcDPbSbjqTeajqwTJN9CCmLJi6N5WxQ/Y1mNKFWLxNhnv8nW/8owGoqawKelkByVN2u75abwfdXo+6b0c2M7dloDgls2aPRB1W9OvXxW2kaBkEwiJ0vjYHU17Dgm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775368375; c=relaxed/simple;
	bh=AcbCMRscvnlSYNTKITNZryCi2V7a4cYUyJMEAvQd/Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAkb2BX8mNsrldqPdi42QXTd9pQKhQBVVokZZa6f2ejgJWGDaNhzjmdAS5dWL42yZmUBaWRdiZPd43atADGoG65tbQOsHwxUVqPyf6phz5V2+FbJ76uGT//tS3nRib0bywK/Swf8jpTZTGVQEngY1z5vBsGKRsqA1hPhQYy3zCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aF/dX01n; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so41077125e9.3
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 22:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775368369; x=1775973169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Io37eMQXjFrNe5EGOk1T1EQBTG5MupuGxN8OBbeP41k=;
        b=aF/dX01nRH2bxQnsibtNB/5jDNxU2j4y0QCSWw3N6qFUxvVTuLnJPrG6FjgoQ8jpE0
         02iB6NyJn7asVR+O0QlKp1Vb+UYXS4oHfc38k56M69vp1X1oKkeqlQovRKiMZTdUlXv2
         sQg7IWpZDeQs+xA2n6iJP0FK7iezt+s8Fl9Q4Y1U2KIqSOUWNPBR4LO6uAJ2TWcU7N/5
         hLWs3nViOpXbyqu+Dmm741PSbmZQr45qo/qkHSFbYHc2xG9jfj8gu35Fd8w0iogWVaD7
         uFMxGntx1WfG5S6P/or+/cJDgtVFH3wsgKR2zby8K0i9AMHtrElepzxb0XuZs9lHtBPL
         OxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775368369; x=1775973169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Io37eMQXjFrNe5EGOk1T1EQBTG5MupuGxN8OBbeP41k=;
        b=rE4fOKXEPeAjkhqMVqKuQyJwHF9+1PoLe5bD5Xh6sX8C1lI1YQjPlrzOnkOm+XFMDx
         Ph5H5Ubn5Nq+eDKmQbYOqNPfXD7jDfB2JWuykrrgG+qLhH2KAP1nuz0Dv6Q/gBQU3f5X
         SLiPhdVWVwOwfBgIJWQVoF2+kDWbaTSG8GfIPmdFG1GrRnBRqvh6LZ7kfUEs27cQp+/C
         4hPiYIqYoMA4VLWy+kASesRVthS32NCg1E8G3V8r4RlT6pcDir/WqmWqs6b01/z/9BDH
         ihYbS1N7f7suNgL8sARi31tgJQGvs2xA3IiGX2CK+y+hx2Jm/8sDAhPX8srIoCCIapJM
         /rLw==
X-Gm-Message-State: AOJu0YzT9NUqrvbEels99b5vZfZvxDiq51o0cASA1gP4Fq7MjIz22LBL
	PIh9kbBujl8lK1GZaX2Xll6xYFSDeczh8dRa7SkSqfCWatSzN79THG90
X-Gm-Gg: AeBDieshWJ2wEFvvJwMrmufqgwzd3GY/MedQVYvI5QclWtir5jM/vueZbn3/Dfnpnva
	CXwR0hvCTwZGsWMBz2PKYwUjv3E6e5IcFnkjSm733fEiIZp28n7dJiJaEdvL/vGMc1P3koD2W8A
	yShXcZMAVjuMHO7lJCx7wGUorzBfUiITljBy1wRAYfG+zDXNj1BxwUznpbeHTs9FZMcddPpdVev
	luTZvDhhXoReYu3KPxj1Jd6p+VnKcoLEptXpsPbalLU+V+yXTJYS7Yq3npFlyApAoAK6oWphHzb
	bZIIRHVKKZAZNDSdT5GEnVTn7aEpJlt/yOWofojuTsbSd5Ee70FKFbABSsbS1qYLwOaMKyEFOg+
	uK5HqjPDbPosZnt5EMa8RXpsc69SL5DH2729YNuwABDboH9f7WF6QYyD9Gz5NVZ4QhjK1ifMGgW
	tztJq1CIxh/iEvVNTUYzk73bnmvOo1VZozbMA/99Oy/TpijoUHfxG5Kf7/dqSWARZYNhtmkqX9j
	gxod6O1+H8R
X-Received: by 2002:a05:600c:46d5:b0:486:fdba:f5db with SMTP id 5b1f17b1804b1-488995d5fa9mr125286085e9.0.1775368368776;
        Sat, 04 Apr 2026 22:52:48 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899e960a7sm55847465e9.27.2026.04.04.22.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 22:52:47 -0700 (PDT)
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
Subject: [PATCH net v3 v3 2/3] net: lan966x: fix page pool leak in error paths
Date: Sun,  5 Apr 2026 06:52:40 +0100
Message-ID: <20260405055241.35767-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260405055241.35767-1-devnexen@gmail.com>
References: <20260405055241.35767-1-devnexen@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-233319-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: EAE0339D740
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

lan966x_fdma_rx_alloc() creates a page pool but does not destroy it if
the subsequent fdma_alloc_coherent() call fails, leaking the pool.

Similarly, lan966x_fdma_init() frees the coherent DMA memory when
lan966x_fdma_tx_alloc() fails but does not destroy the page pool that
was successfully created by lan966x_fdma_rx_alloc(), leaking it.

Add the missing page_pool_destroy() calls in both error paths.

Fixes: 11871aba1974 ("net: lan96x: Use page_pool API")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 74851c63e46a..10773fe93d4d 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -119,8 +119,10 @@ static int lan966x_fdma_rx_alloc(struct lan966x_rx *rx)
 		return PTR_ERR(rx->page_pool);
 
 	err = fdma_alloc_coherent(lan966x->dev, fdma);
-	if (err)
+	if (err) {
+		page_pool_destroy(rx->page_pool);
 		return err;
+	}
 
 	fdma_dcbs_init(fdma, FDMA_DCB_INFO_DATAL(fdma->db_size),
 		       FDMA_DCB_STATUS_INTR);
@@ -957,6 +959,7 @@ int lan966x_fdma_init(struct lan966x *lan966x)
 	err = lan966x_fdma_tx_alloc(&lan966x->tx);
 	if (err) {
 		fdma_free_coherent(lan966x->dev, &lan966x->rx.fdma);
+		page_pool_destroy(lan966x->rx.page_pool);
 		return err;
 	}
 
-- 
2.53.0


